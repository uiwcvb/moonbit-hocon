import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {fork} from 'node:child_process';
import {once} from 'node:events';
import {Config,ConfigValue,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-render-'));
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/render-reference-vectors.json',import.meta.url),'utf8'));
const source='outer { include "part" }',part='x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]';
const index=saved.requests.findIndex(r=>r.source===source&&r.includes?.part===part&&r.steps.length===0&&r.json&&!r.formatted);assert(index>=0);
const expected=saved.references[index].value,checks=[];let server;
async function check(name,run){await run();checks.push(name);}
try{
 fs.writeFileSync(path.join(folder,'main.conf'),source);fs.writeFileSync(path.join(folder,'part.conf'),part);
 for(const factory of ['parse','parseAsync','parseFile','parseFileAsync','parseURL','parseURLAsync'])await check(factory+' preserves raw include render without resolving',async()=>{
  const input=factory.includes('File')?path.join(folder,'main.conf'):factory.includes('URL')?pathToFileURL(path.join(folder,'main.conf')).href:source;
  const config=await Config[factory](input,factory==='parse'||factory==='parseAsync'?{includes:{part}}:{});assert.equal(config.root().render(),expected);assert(!config.isResolved());
  const value=config.root(),hash=value.hashCode();assert.equal(config.render({json:true}),expected);assert.equal(value.hashCode(),hash);
 });
 const fixtures=path.join(folder,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/main.conf':{body:source},'/part.conf':{body:part}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);const timer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error(errors);})]);clearTimeout(timer);
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 for(const protocol of ['http','https'])for(const factory of ['parseURL','parseURLAsync'])await check(protocol+' '+factory+' loads once and renders retained raw data',async()=>{
  const config=await Config[factory](addresses[protocol]+'/main.conf',{network:{ca}});
  for(let i=0;i<5;i++)assert.equal(config.root().render(),expected);
 });
 await check('render is local after HTTP source shutdown',async()=>{
  const config=await Config.parseURLAsync(addresses.http+'/main.conf');server.send('stop');await once(server,'exit');server=null;
  assert.equal(config.root().render(),expected);assert.equal(config.withValue('missing',9).resolve().getInt('outer.b'),9);assert.equal(config.root().render(),expected);
 });
 await check('legacy Config.render remains source-number JSON while value render canonicalizes',()=>{
  const config=Config.load('w=1.0');assert.equal(config.render(),'{"w":1.0}');assert.equal(config.render({}),'{"w":1}');assert.equal(config.root().render(),'{"w":1}');
 });
 await check('supported boolean options and omitted metadata flags have explicit behavior',()=>{
  const value=ConfigValue.parse('{x=1}');assert.equal(value.render({json:false,formatted:true,comments:false,originComments:false,showEnvVariableValues:true}),'x=1\n');
  for(const options of [null,[],1,{json:1},{formatted:null},{comments:true},{originComments:true},{showEnvVariableValues:false},{unknown:true},Object.create({json:'false'})])assert.throws(()=>value.render(options),TypeError);
 });
 await check('unresolved rendering does not unwrap or resolve missing fields',()=>{
  const config=Config.parse('a=1\na=${missing}');assert.equal(config.root().render(),'{"a":1,"a":${missing}}');assert.throws(()=>config.toJSON(),ConfigError);assert(!config.isResolved());
 });
 await check('formatted resolved JSON is usable as JSON and leaves immutable branches unchanged',()=>{
  const config=Config.load('v={a=[1,2],"__proto__"={x=1},text="x\\ny"}'),value=config.getValue('v'),old=value.hashCode();
  const rendered=value.render({formatted:true});const data=JSON.parse(rendered);assert(Object.hasOwn(data,'__proto__'));data.a.push(9);assert.deepEqual(value.get('a').unwrapped(),[1,2]);assert.equal(value.hashCode(),old);assert.deepEqual(Config.load(rendered).toJSON(),value.unwrapped());
 });
 await check('partial resolution consolidates history without changing retained input',()=>{
  const raw=Config.parse('a=${missing}\na={x=1}\na={y=2}'),before=raw.root().render();
  assert.equal(raw.resolve({allowUnresolved:true}).root().render(),'{"a":${missing},"a":{"x":1,"y":2}}');assert.equal(raw.root().render(),before);
 });
 await check('synchronous and worker numeric spelling agree with saved native boundary vectors',async()=>{
  const requestIndex=saved.requests.findIndex(r=>r.value==='5e-324'&&r.json&&!r.formatted);const native=saved.references[requestIndex].value;
  assert.equal(ConfigValue.parse('5e-324').render(),native);assert.equal((await Config.parseAsync('v=5e-324')).getValue('v').render(),native);
 });
 fs.writeFileSync(new URL('../evidence/render-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');console.log(checks.length+' render file/HTTP/async/ownership checks passed');
}finally{if(server){server.send('stop');await once(server,'exit');}assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
