import {Worker} from 'node:worker_threads';

const workers=new Set(),idle=[],queue=[];
const limit=4;let nextId=0;
const abortGroups=new WeakMap();
const abortReason=signal=>signal.reason===undefined?new DOMException('Aborted','AbortError'):signal.reason;

function subscribe(job){
  if(!job.signal)return;
  let group=abortGroups.get(job.signal);
  if(!group){
    group={jobs:new Set()};group.listener=()=>{for(const task of [...group.jobs])task.abort();};
    abortGroups.set(job.signal,group);job.signal.addEventListener('abort',group.listener,{once:true});
  }
  group.jobs.add(job);
  job.unsubscribe=()=>{
    group.jobs.delete(job);
    if(!group.jobs.size){job.signal.removeEventListener('abort',group.listener);abortGroups.delete(job.signal);}
  };
}

function retire(slot){
  if(!slot.alive)return;
  slot.alive=false;workers.delete(slot);
  const index=idle.indexOf(slot);if(index>=0)idle.splice(index,1);
  slot.worker.terminate();
}

function finish(job,error,value){
  if(job.settled)return;
  job.settled=true;job.unsubscribe?.();
  if(job.slot){
    const slot=job.slot;slot.job=undefined;job.slot=undefined;
    if(slot.alive){slot.worker.unref();idle.push(slot);}
  }
  if(error!==undefined)job.reject(error);else job.resolve(value);
  drain();
}

function create(){
  const worker=new Worker(new URL('./config-async-worker.mjs',import.meta.url),{execArgv:process.execArgv.filter(arg=>!arg.startsWith('--input-type'))});
  const slot={worker,alive:true};workers.add(slot);
  worker.on('message',message=>{
    const job=slot.job;if(!slot.alive||!job)return;
    if(message.id!==job.id){retire(slot);finish(job,new Error('Configuration worker response mismatch'));return;}
    finish(job,message.ok?undefined:job.errorFactory(message),message.value);
  });
  worker.on('error',error=>{const job=slot.job;retire(slot);if(job)finish(job,error);else drain();});
  worker.on('exit',code=>{const job=slot.job;retire(slot);if(job)finish(job,new Error('Configuration worker exited before returning a result: '+code));else drain();});
  return slot;
}

function drain(){
  while(queue.length&&(idle.length||workers.size<limit)){
    const job=queue.shift();if(job.settled)continue;
    if(job.signal?.aborted){finish(job,abortReason(job.signal));continue;}
    let slot;
    try{
      slot=idle.pop()??create();slot.job=job;job.slot=slot;slot.worker.ref();
      slot.worker.postMessage({id:job.id,...job.request});
    }catch(error){if(slot)retire(slot);finish(job,error);}
  }
}

export function executeAsync(source,options,kind,errorFactory){
  const {signal,...cloned}=options;
  return new Promise((resolve,reject)=>{
    if(signal?.aborted){reject(abortReason(signal));return;}
    if(queue.length>=128){reject(new Error('Configuration asynchronous queue limit'));return;}
    // Reject uncloneable options before occupying the bounded pool or its queue.
    const request=structuredClone({source,options:cloned,kind});
    const job={id:++nextId,request,signal,resolve,reject,errorFactory,settled:false};
    job.abort=()=>{
      const index=queue.indexOf(job);if(index>=0)queue.splice(index,1);
      if(job.slot)retire(job.slot);
      finish(job,abortReason(signal));
    };
    subscribe(job);queue.push(job);drain();
  });
}
