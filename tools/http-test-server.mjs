// Independent transport fixture. Never imported by production code.
import http from 'node:http';
import https from 'node:https';
import fs from 'node:fs';
const fixtures=JSON.parse(fs.readFileSync(process.argv[2],'utf8'));
const cert=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url));
const key=fs.readFileSync(new URL('./fixtures/http-key.pem',import.meta.url));
let addresses;const requests=[],sockets=new Set(),sequences=new Map();
const expand=text=>String(text).replaceAll('@HTTP@',addresses.http).replaceAll('@HTTPS@',addresses.https);
function handle(req,res){
  requests.push({method:req.method,url:req.url,accept:req.headers.accept,secure:!!req.socket.encrypted});
  const fixture=fixtures[req.url]??{status:404,body:''};
  if(fixture.hang)return;
  if(fixture.drop){req.socket.destroy();return;}
  const send=()=>{
    const headers=Object.fromEntries(Object.entries(fixture.headers??{}).map(([k,v])=>[k,expand(v)]));
    res.writeHead(fixture.status??200,headers);
    let body=fixture.echoAccept?JSON.stringify({accept:req.headers.accept}):expand(fixture.body??'');
    if(fixture.sequenceGroup){const next=((sequences.get(fixture.sequenceGroup)??0)%3)+1;sequences.set(fixture.sequenceGroup,next);body=body.replaceAll('@SEQUENCE@',String(next));}
    if(fixture.bytes)body=Buffer.alloc(fixture.bytes,fixture.byte??120);
    if(fixture.base64)body=Buffer.from(fixture.base64,'base64');
    if(fixture.partial){res.write(body);setTimeout(()=>res.destroy(),15);return;}
    if(fixture.chunked){res.write(body.slice(0,2));setTimeout(()=>res.end(body.slice(2)),fixture.chunkDelayMs??20);return;}
    res.end(body);
  };
  if(fixture.delayMs)setTimeout(send,fixture.delayMs);else send();
}
const plain=http.createServer(handle),secure=https.createServer({cert,key},handle);
for(const server of [plain,secure])server.on('connection',socket=>{sockets.add(socket);socket.on('close',()=>sockets.delete(socket));});
await Promise.all([new Promise(resolve=>plain.listen(0,'127.0.0.1',resolve)),new Promise(resolve=>secure.listen(0,'127.0.0.1',resolve))]);
addresses={http:'http://127.0.0.1:'+plain.address().port,https:'https://127.0.0.1:'+secure.address().port};
process.send(addresses);
process.on('message',message=>{
  if(message==='logs')process.send({requests,sockets:sockets.size});
  if(message==='stop'){for(const socket of sockets)socket.destroy();plain.close();secure.close();process.disconnect();}
});
process.on('disconnect',()=>{for(const socket of sockets)socket.destroy();plain.close();secure.close();});
