import assert from 'node:assert/strict';
import fs from 'node:fs';
import {Config,ConfigError} from './config.mjs';
import {config_create,config_read_native,config_read,split_path_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const checks=[];
async function check(name,run){await run();checks.push(name);}
const obj=JSON.parse('{"__proto__":{"x":[1]},"constructor":2,"prototype":3,"toJSON":"data","__hocon_output_probe__":[1,2],"astral":"😀","control":"a\\nb\\u0000c","quote":"\\\""}');
for(const factory of ['load','loadAsync'])await check(factory+' native objects preserve own data keys and isolation',async()=>{
 const config=await Config[factory]('obj='+JSON.stringify(obj));
 const value=config.getObject('obj');assert.deepEqual(value,obj);assert.equal(Object.getPrototypeOf(value),Object.prototype);
 for(const key of Object.keys(obj)){const d=Object.getOwnPropertyDescriptor(value,key);assert(d&&d.enumerable&&d.writable&&d.configurable&&!d.get&&!d.set);}
 value.__proto__.x.push(9);value.__hocon_output_probe__.clear='external';assert.deepEqual(config.getObject('obj'),obj);
});
await check('native object conversion defines properties without invoking inherited setters',()=>{
 const config=Config.load('obj='+JSON.stringify(obj));let called=0;
 const old=Object.getOwnPropertyDescriptor(Object.prototype,'__hocon_output_probe__');
 try{Object.defineProperty(Object.prototype,'__hocon_output_probe__',{set(){called++;},configurable:true});assert.deepEqual(config.getObject('obj'),obj);assert.equal(called,0);}
 finally{if(old)Object.defineProperty(Object.prototype,'__hocon_output_probe__',old);else delete Object.prototype.__hocon_output_probe__;}
});
await check('native double values preserve signed zero and explicit nonfinite strings',()=>{
 const config=Config.load('v=["-0.0","NaN","Infinity","-Infinity",1.5]\nz="-0.0"');
 assert(Object.is(config.getDouble('z'),-0));const values=config.getDoubleList('v');assert(Object.is(values[0],-0));assert.deepEqual(values.slice(1),['NaN','Infinity','-Infinity',1.5]);
});
await check('complex scalar and list values are detached in every native read',()=>{
 const config=Config.load('p=12months\nps=[{a=1},{a=[2]}]\nn=9223372036854775807');
 const period=config.getPeriod('p');period.months=0;assert.equal(config.getPeriod('p').months,12);
 const numbers=config.getNumber('n');numbers.value='0';assert.equal(config.getNumber('n').value,'9223372036854775807');
 const objects=config.getObjectList('ps');objects[1].a.length=0;assert.deepEqual(config.getObjectList('ps'),[{a:1},{a:[2]}]);
});
const handle=config_create(JSON.stringify({source:'x=1\ny=true\np=2months\nz="-0.0"\nl=[1,2]'}),()=>'{"ok":true,"sources":[]}');
for(const [getter,path,extras] of [['int','x',''],['boolean','y',''],['period','p',''],['int-list','l',''],['no-such-type','x',''],['int','absent',''],['int','a..b',''],['enum','y','{"enumChoices":["true"]}'],['duration-in','x','{"unit":"milliseconds"}']])await check('native/text transport equality '+getter+' '+path,()=>{
 assert.deepEqual(config_read_native(handle,getter,path,extras),JSON.parse(config_read(handle,getter,path,extras)));
});
for(const extras of ['null','[]','true','1','"x"','{','{"bad":1}'])await check('native malformed options reject '+extras,()=>assert.equal(config_read_native(handle,'int','x',extras).accepted,false));
await check('Config wrapper converts located native errors to shared ConfigError',()=>{
 const config=Config.load('a=1');assert.throws(()=>config.getInt('a..b'),e=>e instanceof ConfigError&&e.position?.source==='<path>');assert.equal(config.getInt('a'),1);
});
await check('path bridge rejects malformed UTF-16 and preserves quoted comment characters',()=>{
 for(const path of ['\ud800','a\udc00','x'.repeat(100001),Array(33).fill('a').join('.')])assert.equal(JSON.parse(split_path_json(path)).accepted,false);
 assert.deepEqual(JSON.parse(split_path_json('"a#b"."//x"')).value,['a#b','//x']);
});
await check('native lookup follows corrected API path rules',()=>{
 const config=Config.load('a=7\n"a#b"=9');assert.equal(config.getInt('\na\n'),7);assert.equal(config.getInt('"a#b"'),9);assert.throws(()=>config.getInt('a#b'),ConfigError);
});
fs.writeFileSync(new URL('../evidence/native-read-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
console.log(checks.length+' direct-result ownership/shape/error/path checks passed');
