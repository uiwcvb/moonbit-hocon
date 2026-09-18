import {parentPort} from 'node:worker_threads';
import {load,loadFile,loadURL} from './config.mjs';
import {Config,_packConfig} from './config-object.mjs';
parentPort.on('message',request=>{try{
  if(request.kind.startsWith('config-')){
    const method=request.kind.slice(7);
    if(!['parse','load','parseFile','loadFile','parseURL','loadURL'].includes(method))throw new Error('Unknown persistent configuration operation');
    parentPort.postMessage({id:request.id,ok:true,value:_packConfig(Config[method](request.source,request.options))});return;
  }
  const operation={string:load,file:loadFile,url:loadURL}[request.kind];
  if(!operation)throw new Error('Unknown configuration operation');
  parentPort.postMessage({id:request.id,ok:true,value:operation(request.source,request.options)});
}catch(error){parentPort.postMessage({id:request.id,ok:false,name:error.name,message:error.message,position:error.position,problems:error.problems});}});
