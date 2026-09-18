import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import http from 'node:http';
import {fileURLToPath} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {load,loadFile,loadURL,loadAsync,loadFileAsync,loadURLAsync,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-http-host-'));
const caFile=fileURLToPath(new URL('./fixtures/http-cert.pem',import.meta.url)),ca=fs.readFileSync(caFile,'utf8');
const cli=fileURLToPath(new URL('./cli.mjs',import.meta.url));
const checks=[];let server;
const fixtures={
 '/base.conf':{body:'x=1\ntimeout=1.25ms\nitems=[1,2]'},
 '/main.conf':{body:'include "base.conf"\nx=2'},
 '/bad.conf':{body:'a=[1,,2]'},
 '/unresolved.conf':{body:'value=${missing}'},
 '/redirect.conf':{status:302,headers:{Location:'/base.conf'}},
 '/hang.conf':{hang:true},
 '/slow.conf':{delayMs:200,body:'x=1'},
 '/nested-slow.conf':{delayMs:200,body:'include "slow.conf"'},
 '/drip.conf':{body:'x=1',chunked:true,chunkDelayMs:200},
 '/large.conf':{bytes:400001},
 '/text-limit.conf':{bytes:100001},
 '/bad-utf8.conf':{base64:'/w=='},
 '/partial.conf':{headers:{'Content-Length':'100'},body:'x=1',partial:true},
 '/array.json':{body:'[1,2]'},
 '/counted.conf':{body:'x=1'},
 '/comments.properties':{body:'#'+'中'.repeat(99998)},
};
function checked(name,fn){fn();checks.push(name);}
async function checkedAsync(name,fn){await fn();checks.push(name);}
try{
 const fixtureFile=path.join(temp,'fixtures.json');fs.writeFileSync(fixtureFile,JSON.stringify(fixtures));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtureFile],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);
 const readyTimer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed to start: '+errors);})]);clearTimeout(readyTimer);assert(addresses.http&&addresses.https,errors);
 const plain=addresses.http,secure=addresses.https;
 checked('sync URL include/override',()=>assert.equal(loadURL(plain+'/main.conf').x,2));
 checked('sync trusted HTTPS',()=>assert.equal(loadURL(secure+'/base.conf',{network:{ca}}).x,1));
 checked('untrusted HTTPS rejected',()=>assert.throws(()=>loadURL(secure+'/base.conf'),/certificate|self.signed|verify/i));
 checked('untrusted optional HTTPS rejected',()=>assert.throws(()=>load('include url("'+secure+'/base.conf")'),ConfigError));
 checked('HTTP include in local file',()=>{fs.writeFileSync(path.join(temp,'main.conf'),'include url("'+plain+'/base.conf")\nx=3');assert.equal(loadFile(path.join(temp,'main.conf')).x,3);});
 checked('typed URL getter',()=>assert.deepEqual(loadURL(plain+'/base.conf',{getter:'int-list',path:'items'}),[1,2]));
 checked('URL fallback',()=>assert.deepEqual(load('x=9',{fallbackURLs:[plain+'/base.conf'],getter:'duration',path:'timeout'}),'1250000'));
 for(const endpoint of ['large','text-limit','bad-utf8','partial'])checked(endpoint+' rejection',()=>assert.throws(()=>loadURL(plain+'/'+endpoint+'.conf')));
 checked('custom byte cap',()=>assert.throws(()=>loadURL(plain+'/base.conf',{network:{maxResponseBytes:3}}),/byte limit/));
 checked('root array rejected',()=>assert.throws(()=>loadURL(plain+'/array.json'),ConfigError));
 checked('configuration syntax failure',()=>assert.throws(()=>loadURL(plain+'/bad.conf'),ConfigError));
 checked('missing substitutions fail',()=>assert.throws(()=>loadURL(plain+'/unresolved.conf'),ConfigError));
 checked('zero redirect budget',()=>assert.throws(()=>loadURL(plain+'/redirect.conf',{network:{maxRedirects:0}}),/redirect limit/));
 checked('one redirect budget',()=>assert.equal(loadURL(plain+'/redirect.conf',{network:{maxRedirects:1}}).x,1));
 checked('network disabled',()=>assert.throws(()=>loadURL(plain+'/base.conf',{network:false}),/disabled/));
 for(const network of [{timeoutMs:0},{timeoutMs:-1},{timeoutMs:Infinity},{timeoutMs:1.5},{maxRedirects:65},{maxResponseBytes:400001},{totalTimeoutMs:0}])checked('invalid network option '+JSON.stringify(network),()=>assert.throws(()=>loadURL(plain+'/base.conf',{network}),/network|Network/));
 for(const endpoint of ['hang','drip'])checked(endpoint+' total request deadline',()=>{const start=performance.now();assert.throws(()=>loadURL(plain+'/'+endpoint+'.conf',{network:{timeoutMs:70}}),/timeout/);assert(performance.now()-start<2500);});
 checked('whole include graph deadline',()=>{const start=performance.now();assert.throws(()=>loadURL(plain+'/nested-slow.conf',{network:{timeoutMs:1000,totalTimeoutMs:280}}),/timeout/);assert(performance.now()-start<2500);});
 checked('HTTP worker survives timeout and malformed responses',()=>assert.equal(loadURL(plain+'/base.conf').x,1));
 await checkedAsync('512 request budget bounds actual dispatch',async()=>{
  const source=Array.from({length:513},()=>`include url("${plain}/counted.conf")`).join('\n');
  assert.throws(()=>load(source),/resource limit/);
  const message=once(server,'message');server.send('logs');const [snapshot]=await message;
  assert.equal(snapshot.requests.filter(x=>x.url==='/counted.conf').length,512);
 });
 checked('aggregate HTTP byte budget',()=>assert.throws(()=>load('x=1',{fallbackURLs:Array.from({length:14},()=>plain+'/comments.properties')}),/byte limit|resource limit/));
 await checkedAsync('async string',async()=>assert.equal((await loadAsync('include url("'+plain+'/base.conf")')).x,1));
 await checkedAsync('async file',async()=>assert.equal((await loadFileAsync(path.join(temp,'main.conf'))).x,3));
 await checkedAsync('async trusted HTTPS',async()=>assert.equal((await loadURLAsync(secure+'/base.conf',{network:{ca}})).x,1));
 await checkedAsync('async preserves ConfigError',async()=>assert.rejects(loadURLAsync(plain+'/bad.conf'),ConfigError));
 await checkedAsync('abort before start',async()=>{const controller=new AbortController();controller.abort();await assert.rejects(loadURLAsync(plain+'/base.conf',{signal:controller.signal}),{name:'AbortError'});});
 await checkedAsync('abort during request',async()=>{const controller=new AbortController();const promise=loadURLAsync(plain+'/hang.conf',{signal:controller.signal});const timer=setTimeout(()=>controller.abort(),120);await assert.rejects(promise,{name:'AbortError'});clearTimeout(timer);});
 await checkedAsync('async event loop and local server stay responsive',async()=>{
  const local=http.createServer((req,res)=>res.end('x=7'));await new Promise(resolve=>local.listen(0,'127.0.0.1',resolve));let ticks=0;const timer=setInterval(()=>ticks++,5);
  try{assert.equal((await loadURLAsync('http://127.0.0.1:'+local.address().port+'/app.conf')).x,7);assert(ticks>0);}finally{clearInterval(timer);await new Promise(resolve=>local.close(resolve));}
 });
 await checkedAsync('concurrent independent URL reads',async()=>{const results=await Promise.all(Array.from({length:6},()=>loadURLAsync(plain+'/base.conf')));assert(results.every(x=>x.x===1));});
 await checkedAsync('queued cancellation and replacement after active cancellation',async()=>{
  const active=Array.from({length:4},()=>new AbortController());
  const requests=active.map(controller=>loadURLAsync(plain+'/hang.conf',{signal:controller.signal}));
  const waiting=new AbortController(),queued=loadURLAsync(plain+'/base.conf',{signal:waiting.signal});waiting.abort();
  await assert.rejects(queued,{name:'AbortError'});active.forEach(controller=>controller.abort());
  const settled=await Promise.allSettled(requests);assert(settled.every(x=>x.status==='rejected'&&x.reason.name==='AbortError'));
  assert.equal((await loadURLAsync(plain+'/base.conf')).x,1);
 });
 await checkedAsync('bounded queue and cancellation cleanup',async()=>{
  const controllers=Array.from({length:133},()=>new AbortController());
  const requests=controllers.map(controller=>loadURLAsync(plain+'/hang.conf',{signal:controller.signal}));
  const settled=Promise.allSettled(requests);controllers.forEach(controller=>controller.abort());
  const results=await settled;assert.equal(results.filter(x=>x.status==='rejected'&&/queue limit/.test(x.reason.message)).length,1);
  assert.equal((await loadURLAsync(plain+'/base.conf')).x,1);
 });
 await checkedAsync('uncloneable options do not poison pool',async()=>{await assert.rejects(loadAsync('x=1',{extra:()=>0}));assert.equal((await loadAsync('x=1')).x,1);});
 for(const reason of [false,null])await checkedAsync('shared cancellation preserves reason '+String(reason),async()=>{
  const controller=new AbortController();
  const results=Promise.allSettled(Array.from({length:16},()=>loadURLAsync(plain+'/hang.conf',{signal:controller.signal})));
  controller.abort(reason);assert((await results).every(x=>x.status==='rejected'&&x.reason===reason));
 });
 function invoke(args){return spawnSync(process.execPath,[cli,...args],{cwd:temp,encoding:'utf8',windowsHide:true,timeout:10000});}
 for(const args of [['--url',plain+'/main.conf'],['--url',secure+'/main.conf','--ca',caFile],['--file','main.conf'],['--input','x=2','--fallback-url',plain+'/base.conf']])checked('actual CLI '+args[0],()=>{const result=invoke([...args,'--get','timeout','--type','duration']);assert.equal(result.status,0,result.stderr);assert.equal(JSON.parse(result.stdout),'1250000');});
 checked('actual CLI syntax error is status 2',()=>assert.equal(invoke(['--url',plain+'/bad.conf']).status,2));
 checked('actual CLI missing URL is status 1',()=>assert.equal(invoke(['--url',plain+'/missing.conf']).status,1));
 checked('async module evaluation exits with idle pool',()=>{
  const code='const {loadURLAsync}=await import('+JSON.stringify(new URL('./config.mjs',import.meta.url).href)+'); console.log((await loadURLAsync('+JSON.stringify(plain+'/base.conf')+')).x)';
  const result=spawnSync(process.execPath,['--input-type=module','-e',code],{encoding:'utf8',windowsHide:true,timeout:10000});assert.equal(result.status,0,result.stderr||String(result.error));assert.equal(result.stdout.trim(),'1');
 });
 for(const args of [['--url',plain+'/base.conf','--input','x=1'],['--url',plain+'/base.conf','--no-network'],['--url',secure+'/base.conf'],['--url',plain+'/hang.conf','--http-timeout-ms','70'],['--input','x=1','--http-timeout-ms','-1'],['--input','x=1','--no-network','--ca',caFile],['--input','x=1','--ca',caFile,'--no-network']])checked('CLI rejects '+args.at(-2),()=>assert.equal(invoke(args).status,1));
 const report={utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,scope:'Real sync/async Node and CLI HTTP/HTTPS operations, trusted/untrusted TLS, bounded bytes/time, malformed/partial transport, cancellation, concurrent loads and event-loop responsiveness. Strict UTF-8/partial-body and resource-budget refusal are local policies, not upstream acceptance claims.',names:checks,sourceHashes:sourceHashes()};
 fs.writeFileSync(new URL('../evidence/http-host.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
 console.log(`${checks.length} HTTP host/CLI/async checks passed`);
}finally{
 if(server&&server.exitCode===null){const exited=once(server,'exit');if(server.connected)server.send('stop');const timer=setTimeout(()=>server.kill(),2000);await exited;clearTimeout(timer);}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
