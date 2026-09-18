import {parentPort} from 'node:worker_threads';
import {load,loadFile,loadURL} from './config.mjs';
parentPort.on('message',request=>{try{
  const operation={string:load,file:loadFile,url:loadURL}[request.kind];
  if(!operation)throw new Error('Unknown configuration operation');
  parentPort.postMessage({id:request.id,ok:true,value:operation(request.source,request.options)});
}catch(error){parentPort.postMessage({id:request.id,ok:false,name:error.name,message:error.message,position:error.position});}});
