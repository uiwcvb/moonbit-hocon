import http from 'node:http';
import https from 'node:https';
import {parentPort} from 'node:worker_threads';
const agentOptions={keepAlive:true,maxSockets:4,maxFreeSockets:2,maxTotalSockets:8,timeout:1000};
const agents={http:new http.Agent(agentOptions),https:new https.Agent(agentOptions)};

function receive(url, options, deadline) {
  return new Promise((resolve,reject)=>{
    const remaining=deadline-Date.now();
    if(remaining<=0){reject(new Error('HTTP total request timeout'));return;}
    let request;
    const timer=setTimeout(()=>{fail(new Error('HTTP total request timeout'));request?.destroy();},remaining);
    function fail(error){clearTimeout(timer);reject(error);}
    try {
      request=(url.protocol==='https:'?https:http).get(url,{
        headers:{Accept:options.accept},ca:options.ca,rejectUnauthorized:true,agent:url.protocol==='https:'?agents.https:agents.http,maxHeaderSize:16384,
      },response=>{
        const status=response.statusCode;
        const location=response.headers.location;
        if(status===305&&location){response.destroy();fail(new Error('HTTP 305 proxy redirects are unsupported'));return;}
        if(location&&[300,301,302,303,305,307].includes(status)){
          let target;
          try{target=new URL(location,url);}catch(error){response.destroy();fail(error);return;}
          if(target.protocol===url.protocol){
            clearTimeout(timer);resolve({redirect:target.href});response.destroy();return;
          }
        }
        if(status===404||status===410){clearTimeout(timer);resolve({missing:true,status,bytes:0});response.destroy();return;}
        if(status>=400){response.destroy();fail(new Error('HTTP status '+status));return;}
        let bytes=0;const chunks=[];
        response.on('data',chunk=>{
          bytes+=chunk.length;
          if(bytes>options.maxResponseBytes){fail(new Error('HTTP response byte limit'));response.destroy();return;}
          chunks.push(chunk);
        });
        response.on('error',fail);
        response.on('aborted',()=>fail(new Error('HTTP response ended before the declared body was received')));
        response.on('end',()=>{
          clearTimeout(timer);
          try{
            const content=new TextDecoder('utf-8',{fatal:true,ignoreBOM:true}).decode(Buffer.concat(chunks));
            if(content.length>100000)throw new Error('Configuration source exceeds 100000 UTF-16 units');
            resolve({content,status,contentType:response.headers['content-type']??'',bytes});
          }catch(error){reject(error);}
        });
      });
      request.on('error',fail);
    }catch(error){fail(error);}
  });
}

parentPort.on('message',async ({name,options,shared})=>{
  const control=new Int32Array(shared,0,2),buffer=new Uint8Array(shared,8);
  let result;
  try{
    let url=new URL(name),requests=0;
    const deadline=options.deadlineMs;
    for(;;){
      requests++;
      const response=await receive(url,options,deadline);
      if(response.redirect){
        if(requests>options.maxRedirects)throw new Error('HTTP redirect limit');
        url=new URL(response.redirect);continue;
      }
      result={...response,requests,finalURL:url.href};break;
    }
  }catch(error){result={error:String(error.message).slice(0,8192)};}
  let encoded=new TextEncoder().encode(JSON.stringify(result));
  if(encoded.length>buffer.length)encoded=new TextEncoder().encode(JSON.stringify({error:'HTTP result transport limit'}));
  buffer.set(encoded);Atomics.store(control,1,encoded.length);Atomics.store(control,0,1);Atomics.notify(control,0);
});
