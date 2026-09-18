import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {load,loadFile,loadURL,loadAsync,loadFileAsync,loadURLAsync,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-document-'));
const checks=[];let server;
async function checked(name,fn){await fn();checks.push(name);}
const source='a=${missing}\noptional=${?gone}\nx=known';
const steps=[{op:'resolve',allowUnresolved:true},{op:'with-value',path:'missing',value:7},{op:'resolve'}];
const options={document:true,steps,probes:['a','x','optional']};
const expectedFinal={a:7,missing:7,x:'known'};
function verify(states){assert.equal(states.length,4);assert.equal(states[0].resolved,false);assert.deepEqual(states[0].probes.x,{accepted:true,value:'known'});assert.deepEqual(states[1].probes.a,{accepted:false});assert.equal(states[2].resolved,false);assert.equal(states[3].resolved,true);assert.deepEqual(states[3].value,expectedFinal);assert.deepEqual(states[3].probes.a,{accepted:true,value:7});}
function invoke(args,input){return spawnSync(process.execPath,[fileURLToPath(new URL('./cli.mjs',import.meta.url)),...args],{cwd:temp,input,encoding:'utf8',windowsHide:true,timeout:15000});}
try{
 fs.writeFileSync(path.join(temp,'base.conf'),source);fs.writeFileSync(path.join(temp,'main.conf'),'include "base.conf"');
 fs.writeFileSync(path.join(temp,'params.conf'),'missing=9');fs.writeFileSync(path.join(temp,'steps.json'),JSON.stringify(steps));
 for(const [name,run] of [['sync string',()=>load(source,options)],['sync file includes',()=>loadFile('main.conf',{...options,cwd:temp})],['async string',()=>loadAsync(source,options)],['async file includes',()=>loadFileAsync('main.conf',{...options,cwd:temp})]])await checked(name,async()=>verify(await run()));
 await checked('caller step data remains unchanged',()=>{const before=JSON.stringify(options);load(source,options);assert.equal(JSON.stringify(options),before);});
 await checked('raw resolved scalar state',()=>assert.deepEqual(load('a=bare',{document:true})[0],{resolved:true,value:{a:'bare'},probes:{}}));
 await checked('raw parse retains missing mandatory substitution',()=>assert.equal(load('a=${missing}',{document:true})[0].resolved,false));
 await checked('strict stage rejects missing substitution',()=>assert.throws(()=>load(source,{document:true,steps:[{op:'resolve'}]}),ConfigError));
 await checked('async stage rejects missing substitution as ConfigError',()=>assert.rejects(loadAsync(source,{document:true,steps:[{op:'resolve'}]}),ConfigError));
 await checked('self cycle rejects even with allow unresolved',()=>assert.throws(()=>load('a=${a}',{document:true,steps:[{op:'resolve',allowUnresolved:true}]}),ConfigError));
 await checked('raw fallback file participates before resolution',()=>{const states=loadFile('main.conf',{cwd:temp,document:true,fallbackFiles:['params.conf'],steps:[{op:'resolve'}]});assert.equal(states[1].value.a,9);});
 for(const op of ['resolve-with','with-fallback'])await checked('stage source supports real relative include: '+op,()=>{
  const states=loadFile('main.conf',{cwd:temp,document:true,steps:[{op,source:'include "params.conf"'},...(op==='with-fallback'?[{op:'resolve'}]:[])]});assert.equal(states.at(-1).value.a,9);
 });
 await checked('raw inserted expression can include a file',()=>{const states=load('{}',{cwd:temp,document:true,steps:[{op:'with-value',path:'a',valueSource:'{include "params.conf"}'},{op:'resolve'}]});assert.deepEqual(states.at(-1).value,{a:{missing:9}});});
 await checked('external source fields are not merged',()=>assert.deepEqual(load('a=${x}',{document:true,steps:[{op:'resolve-with',source:'x=2\ny=3'}]}).at(-1).value,{a:2}));
 for(const bad of [{steps:{}},{steps:null},{steps:Array(65).fill({op:'resolve'})},{steps:[{op:'resolve',allowUnresolved:1}]},{steps:[{op:'unknown'}]},{probes:[1]},{probes:Array(65).fill('a')}])await checked('bounded invalid pipeline '+JSON.stringify(bad).slice(0,80),()=>assert.throws(()=>load('a=1',{document:true,...bad}),ConfigError));
 for(const bad of [{document:1},{steps:[]},{probes:[]},{document:true,getter:'resolved'},{document:true,operations:[]},{document:true,checkValid:{source:'a=1'}}])await checked('conflicting host options '+JSON.stringify(bad),()=>assert.throws(()=>load('a=1',bad),TypeError));
 await checked('initial snapshot aggregate size is bounded',()=>{const large='x'.repeat(70000);assert.throws(()=>load('a="'+large+'"',{document:true,probes:['a'],steps:Array(8).fill({op:'resolve'})}),ConfigError);});
 for(const mode of ['input','file','stdin'])await checked('CLI document stages via '+mode,()=>{
  const args=[...(mode==='input'?['--input',source]:mode==='file'?['--file','main.conf']:[]),'--document-steps','steps.json','--probe','a','--probe','x','--probe','optional'];
  const result=invoke(args,mode==='stdin'?source:undefined);assert.equal(result.status,0,result.stderr);verify(JSON.parse(result.stdout));
 });
 for(const args of [['--probe','a'],['--document-steps'],['--document-steps','steps.json','--get','a'],['--document-steps','steps.json','--set','a','1'],['--document-steps','steps.json','--resolved-json'],['--document-steps','steps.json','--document-steps','steps.json']])await checked('CLI rejects invalid lifecycle arguments '+args.join(' '),()=>assert.equal(invoke(['--input','{}',...args]).status,1));
 fs.writeFileSync(path.join(temp,'bad.json'),'{}');await checked('CLI steps must be array',()=>assert.equal(invoke(['--input','{}','--document-steps','bad.json']).status,1));
 fs.writeFileSync(path.join(temp,'oversize.json'),' '.repeat(400001));await checked('CLI bounded steps read',()=>assert.equal(invoke(['--input','{}','--document-steps','oversize.json']).status,1));
 fs.writeFileSync(path.join(temp,'strict.json'),'[{"op":"resolve"}]');await checked('CLI resolve failure exit 2',()=>assert.equal(invoke(['--input',source,'--document-steps','strict.json']).status,2));
 const fixtures=path.join(temp,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/base.conf':{body:source},'/main.conf':{body:'include "base.conf"'},'/params.conf':{body:'missing=9'}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 const timer=setTimeout(()=>server.kill(),10000);let errors='';server.stderr.on('data',chunk=>errors+=chunk);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed: '+errors);})]);clearTimeout(timer);
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 await checked('sync HTTP raw document and stages',()=>verify(loadURL(addresses.http+'/main.conf',options)));
 await checked('async HTTPS raw document and stages',async()=>verify(await loadURLAsync(addresses.https+'/main.conf',{...options,network:{ca}})));
 await checked('stage external source follows URL include origin',()=>{const states=loadURL(addresses.http+'/main.conf',{document:true,steps:[{op:'resolve-with',source:'include "params.conf"'}]});assert.equal(states.at(-1).value.a,9);});
 await checked('pipeline reads root and include once per load',async()=>{const pending=once(server,'message');server.send('logs');const [snapshot]=await pending;for(const url of ['/main.conf','/base.conf'])assert.equal(snapshot.requests.filter(x=>x.url===url).length,3);assert.equal(snapshot.requests.filter(x=>x.url==='/params.conf').length,1);});
 fs.writeFileSync(new URL('../evidence/document-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' document file/HTTP/async/CLI checks passed');
}finally{
 if(server&&!server.killed){const exited=once(server,'exit');server.kill();await exited;}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
