import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {fork} from 'node:child_process';
import {once} from 'node:events';
import {Config,ConfigValue,ConfigEntry,ConfigEntrySet,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-entries-')),checks=[];let server;
const source='outer { include "part" }',part='x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]';
const entries=config=>Object.fromEntries([...config.entrySet()].map(([key,value])=>[key,value.render()]));
const expected=entries(Config.parse(source,{includes:{part}}));
async function check(name,run){await run();checks.push(name);}
try{
 fs.writeFileSync(path.join(folder,'main.conf'),source);fs.writeFileSync(path.join(folder,'part.conf'),part);
 for(const factory of ['parse','parseAsync','parseFile','parseFileAsync','parseURL','parseURLAsync'])await check(factory+' retains unresolved typed entries after loading',async()=>{
  const input=factory.includes('File')?path.join(folder,'main.conf'):factory.includes('URL')?pathToFileURL(path.join(folder,'main.conf')).href:source;
  const config=await Config[factory](input,factory==='parse'||factory==='parseAsync'?{includes:{part}}:{});assert.deepEqual(entries(config),expected);const set=config.entrySet();set.clear();assert.deepEqual(entries(config),expected);assert(!config.isResolved());
 });
 const fixtures=path.join(folder,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/main.conf':{body:source},'/part.conf':{body:part}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});let errors='';server.stderr.on('data',c=>errors+=c);const timer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw Error(errors);})]);clearTimeout(timer);const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 for(const protocol of ['http','https'])for(const factory of ['parseURL','parseURLAsync'])await check(protocol+' '+factory+' retains entries',async()=>{assert.deepEqual(entries(await Config[factory](addresses[protocol]+'/main.conf',{network:{ca}})),expected);});
 await check('retained values survive source shutdown and file deletion',async()=>{
  const remote=await Config.parseURLAsync(addresses.http+'/main.conf'),local=await Config.parseFileAsync(path.join(folder,'main.conf'));server.send('stop');await once(server,'exit');server=null;fs.unlinkSync(path.join(folder,'main.conf'));fs.unlinkSync(path.join(folder,'part.conf'));
  assert.deepEqual(entries(remote),expected);assert.deepEqual(entries(local),expected);assert.equal(remote.withValue('missing',9).resolve().getInt('outer.b'),9);
 });
 await check('raw references remain usable views while data enumeration rejects them',()=>{const c=Config.parse('a=${missing}'),e=[...c.entrySet()][0];assert(e.getValue() instanceof ConfigValue);assert.equal(e.getValue().render(),'${missing}');assert.throws(()=>e.getValue().valueType(),ConfigError);assert.throws(()=>c.entrySetData(),ConfigError);assert.throws(()=>e.setValue(ConfigValue.fromAnyRef(1)),TypeError);});
 await check('list values and arrays are detached from set and source',()=>{const c=Config.load('v=[1,{x=2}],n=null,empty={}'),set=c.entrySet(),entry=set.toArray()[0],data=entry.getValue().unwrapped();data[1].x=99;data.push(8);set.toArray().pop();assert.equal(set.size(),1);set.remove(entry);assert.equal(c.entrySet().size(),1);assert.deepEqual(entry.getValue().unwrapped(),[1,{x:2}]);assert.deepEqual(c.entrySetData(),{v:[1,{x:2}]});});
 await check('dangerous literal keys stay data in entry pairs',()=>{const c=Config.load('"__proto__"=1,constructor=2,toJSON=3,"a.b"=4');assert.deepEqual([...c.entrySet()].map(e=>e.getKey()).sort(),['"a.b"','__proto__','constructor','toJSON']);assert.equal(Object.getPrototypeOf(c.entrySet()),ConfigEntrySet.prototype);});
 await check('semantic equality, signed hash and null entries are independent of object identity',()=>{const a=new ConfigEntry('馃榾',ConfigValue.parse('-1')),b=new ConfigEntry('馃榾',ConfigValue.parse('-1.0')),set=new ConfigEntrySet([a,b,null]);assert.equal(set.size(),2);assert(set.contains(b));assert.equal(a.hashCode(),b.hashCode());assert(new ConfigEntrySet([null,b]).equals(set));set.remove(b);assert.deepEqual([...set],[null]);});
 await check('iterator failure categories and duplicate add behavior',()=>{const c=Config.load('a=1'),set=c.entrySet(),entry=[...set][0],i=set.iterator();assert.throws(()=>i.remove(),{name:'IllegalStateException'});assert(!set.add(new ConfigEntry('a',ConfigValue.parse('1.0'))));assert.equal(i.next(),entry);i.remove();assert.throws(()=>i.remove(),{name:'IllegalStateException'});assert.throws(()=>i.next(),{name:'NoSuchElementException'});const empty=set.iterator();set.clear();assert.throws(()=>empty.next(),{name:'ConcurrentModificationException'});});
 await check('collection validation fails without exposing mutable internals',()=>{const set=Config.load('a=1').entrySet();for(const method of ['add','addAll','removeAll','retainAll','containsAll'])assert.throws(()=>set[method](undefined),TypeError);assert(!set.contains({}));assert(!set.remove({}));assert.throws(()=>new ConfigEntry('a',{}),TypeError);assert.equal(set.size(),1);});
 fs.writeFileSync(new URL('../evidence/entry-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');console.log(checks.length+' entry file/HTTP/async/ownership checks passed');
}finally{if(server){server.send('stop');await once(server,'exit');}assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
