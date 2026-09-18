import assert from 'node:assert/strict';
import fs from 'node:fs';
import {Config,ConfigValue,ConfigError} from './config.mjs';
import {value_lookup,config_create,config_error} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const checks=[];async function check(name,run){await run();checks.push(name);}
for(const factory of ['load','loadAsync'])await check(factory+' repeated hashes and detached output cannot stale retained immutable values',async()=>{
 const config=await Config[factory]('v={a=[1,2],b={x=3}}'),value=config.getValue('v'),hash=value.hashCode();
 for(let i=0;i<20;i++){const out=value.unwrapped();out.a.push(99);out.b.x=99;assert.equal(value.hashCode(),hash);assert(value.equals(ConfigValue.parse('{b={x=3},a=[1,2]}')));}
 const changed=value.withValue('a',ConfigValue.fromAnyRef([9]));assert.notEqual(changed.hashCode(),hash);assert.equal(value.hashCode(),hash);assert.deepEqual(config.toJSON(),{v:{a:[1,2],b:{x:3}}});
});
await check('raw value lookup shares only opaque data and preserves delayed paths',()=>{
 const raw=Config.parse('a=${missing}\na={x=1}\nlist=[${missing}]');
 assert.equal(raw.getValue('a').valueType(),'OBJECT');assert.equal(raw.getValue('a.x').unwrapped(),1);assert.throws(()=>raw.getValue('a').unwrapped(),ConfigError);assert.throws(()=>raw.getList('list').unwrapped(),ConfigError);
 const ready=raw.withValue('missing',2).resolve();assert.deepEqual(ready.getList('list').unwrapped(),[2]);assert.throws(()=>raw.getList('list').unwrapped(),ConfigError);
});
await check('native lookup keeps path errors and literal key semantics',()=>{
 const config=Config.load('"a.b"={x=1}\na=null');assert.equal(config.root().get('a.b').get('x').unwrapped(),1);
 for(const key of ['a','missing','a..b','a#comment'])assert.throws(()=>config.getValue(key),ConfigError);
 assert.equal(config.getValue('"a.b".x').unwrapped(),1);assert.throws(()=>config.getValue('a..b'),e=>e.position?.source==='<path>');
});
await check('direct searches retain directional equality and early/late rejection',()=>{
 const list=ConfigValue.parse('[${missing},text,text]'),needle=ConfigValue.parse('text');assert.throws(()=>list.indexOf(needle),ConfigError);assert.equal(list.lastIndexOf(needle),2);assert.equal(list.indexOf(ConfigValue.parse('${missing}')),0);
 const object=ConfigValue.parse('{a=${missing},b=text}');assert.throws(()=>object.containsValue(needle),ConfigError);assert.throws(()=>Config.parse('a=${missing}\na={x=1}').getObject('a').containsValue({}),ConfigError);
});
await check('large list searches preserve absent/first/last results without materializing wrappers',()=>{
 const values=Array.from({length:2048},(_,i)=>i),list=ConfigValue.fromAnyRef(values),needle=ConfigValue.fromAnyRef(2047);
 assert.equal(list.indexOf(needle),2047);assert.equal(list.lastIndexOf(needle),2047);assert.equal(list.indexOf(ConfigValue.fromAnyRef(-1)),-1);assert.equal(list.indexOf({}),-1);assert.equal(list.size(),2048);
});
await check('unwrapped direct serialization preserves own data keys and compact zero',()=>{
 const config=Config.load('v={"__proto__"={x=1},toJSON=data,zero=-0.0,tiny=-1e-999}'),value=config.getValue('v');
 let count=0;const old=Object.getOwnPropertyDescriptor(Object.prototype,'__hocon_read_probe__');
 try{Object.defineProperty(Object.prototype,'__hocon_read_probe__',{set(){count++;},configurable:true});const read=value.withValue('__hocon_read_probe__',ConfigValue.fromAnyRef([1])).unwrapped();assert.equal(count,0);assert.equal(Object.getPrototypeOf(read),Object.prototype);assert(Object.hasOwn(read,'__proto__'));assert(!Object.is(read.zero,-0));assert(!Object.is(read.tiny,-0));assert.deepEqual(read.__hocon_read_probe__,[1]);}
 finally{if(old)Object.defineProperty(Object.prototype,'__hocon_read_probe__',old);else delete Object.prototype.__hocon_read_probe__;}
});
await check('opaque lookup rejects invalid selectors and indexes without corrupting handles',()=>{
 const handle=config_create(JSON.stringify({source:'v=[1,2]'}),()=>'{"ok":true,"sources":[]}');
 assert(config_error(value_lookup(handle,'unknown','v',0)));assert(config_error(value_lookup(handle,'get-index','',0)));assert.equal(config_error(value_lookup(handle,'get-value','v',0)),'');
});
fs.writeFileSync(new URL('../evidence/value-walk-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');console.log(checks.length+' value traversal host checks passed');
