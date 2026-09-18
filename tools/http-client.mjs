import {Worker} from 'node:worker_threads';
let worker;

function integer(value,fallback,max,name){
  value??=fallback;
  if(!Number.isSafeInteger(value)||value<0||value>max)throw new Error('Invalid network '+name);
  return value;
}

export function networkOptions(input){
  if(input===false)return false;
  if(input!==undefined&&(input===null||typeof input!=='object'||Array.isArray(input)))throw new Error('network must be an options object or false');
  const options=input??{};
  const timeoutMs=integer(options.timeoutMs,5000,300000,'timeoutMs');
  const totalTimeoutMs=integer(options.totalTimeoutMs,30000,600000,'totalTimeoutMs');
  if(timeoutMs===0||totalTimeoutMs===0)throw new Error('Network timeouts must be positive');
  const maxResponseBytes=integer(options.maxResponseBytes,400000,400000,'maxResponseBytes');
  if(maxResponseBytes===0)throw new Error('Network response limit must be positive');
  return {timeoutMs,totalTimeoutMs,maxResponseBytes,maxRedirects:integer(options.maxRedirects,19,64,'maxRedirects'),ca:options.ca};
}

export function readHttp(name,options,accept){
  if(options===false)throw new Error('HTTP(S) configuration loading is disabled');
  const url=new URL(name);
  if(!['http:','https:'].includes(url.protocol))throw new Error('Unsupported include URL protocol: '+url.protocol);
  if(!worker){
    const created=new Worker(new URL('./http-worker.mjs',import.meta.url),{execArgv:process.execArgv.filter(arg=>!arg.startsWith('--input-type'))});worker=created;
    created.on('error',()=>{if(worker===created)worker=undefined;});
    created.on('exit',()=>{if(worker===created)worker=undefined;});
    created.unref();
  }
  const shared=new SharedArrayBuffer(1048584),control=new Int32Array(shared,0,2);
  const current=worker;
  current.postMessage({name:url.href,options:{...options,accept,deadlineMs:Date.now()+options.timeoutMs},shared});
  // The worker owns network I/O; the existing synchronous API retains its contract.
  if(Atomics.wait(control,0,0,options.timeoutMs+2000)==='timed-out'){
    if(worker===current)worker=undefined;current.terminate();
    throw new Error('HTTP worker timeout');
  }
  const result=JSON.parse(new TextDecoder().decode(new Uint8Array(shared,8,Atomics.load(control,1))));
  if(result.error)throw new Error(result.error);
  return result;
}
