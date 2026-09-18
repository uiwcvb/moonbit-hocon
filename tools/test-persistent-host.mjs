import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {fork} from 'node:child_process';
import {once} from 'node:events';
import {Config,ConfigError,load} from './config.mjs';
import {_packConfig} from './config-object.mjs';
import {config_unpack,config_status,config_query} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-persistent-'));
const checks=[];let server;
async function check(name,run){await run();checks.push(name);}
const source='a=${missing}\nknown=7\nobject={x=[1],v=bare}\nobjects=[{x=1},{x=2}]\nnumber="9223372036854775807"\nzero="-0.0"\nzeros=["-0.0",0]\nperiod=12months';
try{
 fs.writeFileSync(path.join(temp,'base.conf'),source);fs.writeFileSync(path.join(temp,'main.conf'),'include "base.conf"');
 for(const factory of ['parse','parseAsync','parseFile','parseFileAsync'])await check(factory+' preserves raw tree and resolves later',async()=>{
  const config=await Config[factory](factory.includes('File')?'main.conf':source,{cwd:temp});
  assert(config instanceof Config);assert(!config.isResolved());assert.equal(config.getInt('known'),7);
  const ready=config.withFallback(Config.load('missing=11')).resolve();assert.equal(ready.getInt('a'),11);assert(!config.isResolved());
 });
 for(const factory of ['load','loadAsync','loadFile','loadFileAsync'])await check(factory+' resolves fallback at construction',async()=>{
  const config=await Config[factory](factory.includes('File')?'main.conf':source,{cwd:temp,fallbacks:['missing=13']});assert(config.isResolved());assert.equal(config.getInt('a'),13);
 });
 const original=Config.loadFile('main.conf',{cwd:temp,fallbacks:['missing=1']});
 await check('file deletion does not invalidate retained configuration',()=>{fs.unlinkSync(path.join(temp,'base.conf'));fs.unlinkSync(path.join(temp,'main.conf'));for(let i=0;i<300;i++)assert.equal(original.getInt('known'),7);});
 await check('getter results and returned config arrays cannot mutate parent',()=>{
  original.getObject('object').x.push(9);original.getAnyRef('objects')[0].x=99;
  const children=original.getConfigList('objects');const changed=children[0].withValue('x',99);children.length=0;
  assert.deepEqual(original.getObject('object'),{x:[1],v:'bare'});assert.equal(original.getConfigList('objects')[0].getInt('x'),1);assert.equal(changed.getInt('x'),99);
 });
 await check('withValue copies caller data and branches preserve old state',()=>{
  const value={a:[1]},derived=original.withValue('new',value);value.a.push(2);assert.deepEqual(derived.getAnyRef('new'),{a:[1]});assert(!original.hasPath('new'));assert(Object.isFrozen(derived));assert.throws(()=>{derived.extra=1;},TypeError);
 });
 await check('large operation chain has no pipeline replay limit',()=>{let config=original;for(let i=0;i<1000;i++)config=config.withValue('counter',i);assert.equal(config.getInt('counter'),999);assert(!original.hasPath('counter'));});
 await check('exact numbers and negative zero survive worker and getter boundaries',async()=>{
  const config=await Config.loadAsync(source,{fallbacks:['missing=1']});assert.equal(config.getLong('number'),'9223372036854775807');assert(Object.is(config.getDouble('zero'),-0));assert(Object.is(config.getDoubleList('zeros')[0],-0));assert(!Object.is(config.getInt('zero'),-0));assert.equal(config.getNumber('zero').bits,'-9223372036854775808');
 });
 await check('raw child lookup retains delayed object and protocol reconstructs it',()=>{
  const child=Config.parse('a=${missing}\na={x=1}').getConfig('a');assert(!child.isResolved());assert.equal(child.getInt('x'),1);
  const handle=config_unpack(_packConfig(child));assert(JSON.parse(config_status(handle)).accepted);assert.equal(JSON.parse(config_query(handle,JSON.stringify({getter:'int',path:'x'}))).value,1);
 });
 await check('raw value transfer retains substitutions independently',()=>{
  const raw=Config.parse('source={x=${missing}}'),copy=Config.parse('{}').withValueFrom('copy',raw,'source');assert.equal(copy.withValue('missing',5).resolve().getInt('copy.x'),5);assert(!raw.isResolved());
 });
 await check('resolve options snapshot environment and preserve self identity',async()=>{
  const environment={MISSING:'first'},pending=Config.parseAsync('a=${MISSING}',{environment});environment.MISSING='second';const raw=await pending;
  assert.equal(raw.resolve().getString('a'),'first');assert.equal(raw.resolveWith(raw).getString('a'),'first');assert.equal(raw.resolve({environment:{MISSING:'third'}}).getString('a'),'third');assert(!raw.isResolved());
 });
 await check('prototype-looking keys remain ordinary data',()=>{
  const config=Config.fromObject(JSON.parse('{"__proto__":{"polluted":1},"constructor":2}'));
  assert.equal(config.getInt('__proto__.polluted'),1);assert.equal(config.getInt('constructor'),2);assert.equal({}.polluted,undefined);
 });
 await check('validation errors retain structured problems and leave input usable',()=>{
  const reference=Config.load('known={x=1}');assert.throws(()=>original.checkValid(reference),e=>e instanceof ConfigError&&Array.isArray(e.problems)&&e.problems.length>0);assert(original.validationProblems(reference).length);assert.equal(original.getInt('known'),7);assert.strictEqual(original.checkValid(Config.load('known=1'),'known'),original);
 });
 for(const factory of ['parse','parseAsync'])await check(factory+' preserves source location on syntax errors',async()=>{
  try{await Config[factory]('a={');assert.fail('must reject');}catch(error){assert(error instanceof ConfigError);assert(error.position);}
 });
 await check('unresolved hasPath rejects without corrupting subsequent reads',()=>{
  const raw=Config.parse(source);assert.throws(()=>raw.hasPath('a'),ConfigError);assert(raw.hasPathOrNull('a'));assert.equal(raw.getInt('known'),7);assert(raw.withoutPath('a').isResolved());
 });
 await check('legacy load and persistent class share ConfigError type',()=>{assert.throws(()=>load('a=${absent}'),ConfigError);assert.throws(()=>Config.load('a=${absent}'),ConfigError);});
 await check('private constructor and incompatible Config inputs reject',()=>{assert.throws(()=>new Config(),TypeError);assert.throws(()=>original.withFallback({}),TypeError);assert.throws(()=>original.resolveWith({}),TypeError);});
 for(const value of [undefined,()=>1,NaN,Infinity,1n,Symbol('x')])await check('non-JSON withValue rejects '+typeof value,()=>assert.throws(()=>original.withValue('bad',value),TypeError));
 for(const options of [{document:true},{getter:'int'},{environment:null},{environment:{x:1}},{includes:{x:1}}])await check('invalid factory options '+JSON.stringify(options),()=>assert.throws(()=>Config.parse('a=1',options),TypeError));
 for(const operation of [()=>original.get(1),()=>original.get('a',{type:1}),()=>original.get('a',{path:'known'}),()=>original.resolve({allowUnresolved:1}),()=>original.resolve({environment:null})])await check('invalid path/getter/resolve options',()=>assert.throws(operation,TypeError));
 for(const wire of ['{}','[]','{"version":2,"root":["object",[]]}','{"version":1,"root":["text","x"]}','{"version":1,"root":["object",[["x",["null"]],["x",["null"]]]]}','{"version":1,"root":["object",[["x",["unknown"]]]]}','x'.repeat(4000001)])await check('invalid transfer protocol length '+wire.length,()=>assert.equal(JSON.parse(config_status(config_unpack(wire))).accepted,false));
 const fixtures=path.join(temp,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/base.conf':{body:'n=17\na=${missing}'},'/slow.conf':{body:'n=1',delayMs:1000}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);const timer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed: '+errors);})]);clearTimeout(timer);
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 for(const factory of ['parseURL','parseURLAsync','loadURL','loadURLAsync'])await check(factory+' HTTPS immutable configuration',async()=>{
  const resolved=factory.startsWith('load'),config=await Config[factory](addresses.https+'/base.conf',{network:{ca},...(resolved?{fallbacks:['missing=23']}:{})});assert.equal(config.getInt('n'),17);assert.equal(config.isResolved(),resolved);assert.equal(config.withValue('missing',23).resolve().getInt('a'),23);
 });
 await check('URL factories support real file URL input',async()=>{const file=path.join(temp,'url.conf');fs.writeFileSync(file,'n=31');const {pathToFileURL}=await import('node:url');assert.equal((await Config.loadURLAsync(pathToFileURL(file).href)).getInt('n'),31);});
 await check('aborted persistent HTTP load releases worker and allows later work',async()=>{
  const controller=new AbortController(),pending=Config.loadURLAsync(addresses.http+'/slow.conf',{signal:controller.signal});setTimeout(()=>controller.abort(),25);await assert.rejects(pending,e=>e.name==='AbortError');assert.equal((await Config.loadAsync('n=41')).getInt('n'),41);
 });
 await check('already aborted factory preserves abort reason',async()=>{const controller=new AbortController(),reason=new Error('stop');controller.abort(reason);await assert.rejects(Config.parseAsync('n=1',{signal:controller.signal}),error=>error===reason);});
 const retained=await Config.parseURLAsync(addresses.http+'/base.conf');const exited=once(server,'exit');server.kill();await exited;
 await check('server shutdown does not invalidate retained configuration',()=>{assert.equal(retained.getInt('n'),17);assert.equal(retained.withValue('missing',29).resolve().getInt('a'),29);});
 fs.writeFileSync(new URL('../evidence/persistent-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' persistent file/HTTP/async/ownership checks passed');
}finally{
 if(server&&!server.killed){const exited=once(server,'exit');server.kill();await exited;}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
