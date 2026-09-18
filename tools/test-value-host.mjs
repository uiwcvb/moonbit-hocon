import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {pathToFileURL} from 'node:url';
import {Config,ConfigValue,ConfigObject,ConfigList,ConfigError} from './config.mjs';
import {_packConfig} from './config-object.mjs';
import {config_unpack,config_read_native,config_derive} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const checks=[];
async function check(name,run){await run();checks.push(name);}
const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-value-'));
try{
 const text='a={discarded=1}\na=0\na={x=[1,2],nil=null}\nlist=[{x=1},null,1.0,1]\nnumber=9223372036854775807\nraw={x=${missing}}';
 fs.writeFileSync(path.join(folder,'values.conf'),text);
 for(const factory of ['parse','parseAsync','parseFile','parseFileAsync','parseURL','parseURLAsync'])await check(factory+' retains value/container types and fallback barriers',async()=>{
  const source=factory.includes('File')?path.join(folder,'values.conf'):factory.includes('URL')?pathToFileURL(path.join(folder,'values.conf')).href:text;
  const config=await Config[factory](source),root=config.root();assert(root instanceof ConfigObject);assert.strictEqual(root,config.root());assert.strictEqual(root.toConfig(),config);
  assert(config.getList('list') instanceof ConfigList);assert(config.getValue('number') instanceof ConfigValue);assert.equal(config.getLong('number'),'9223372036854775807');
  assert.deepEqual(config.getObject('a').withFallback(ConfigValue.fromAnyRef({later:3})).unwrapped(),{x:[1,2],nil:null});
  assert.equal(config.getObject('raw').withValue('x',ConfigValue.fromAnyRef(5)).toConfig().getInt('x'),5);assert.throws(()=>config.getObject('raw').unwrapped(),ConfigError);
 });
 await check('getValue accepts a known delayed object but map access stays unresolved',()=>{
  const config=Config.parse('a=${missing}\na={x=1}'),value=config.getValue('a');assert(value instanceof ConfigObject);assert.equal(value.valueType(),'OBJECT');assert.equal(value.toConfig().getInt('x'),1);assert.throws(()=>value.get('x'),ConfigError);assert.throws(()=>value.size(),ConfigError);assert.throws(()=>value.unwrapped(),ConfigError);
 });
 await check('null and missing are distinct; required getValue rejects null',()=>{const config=Config.load('a=null'),root=config.root();assert.strictEqual(root.get('missing'),null);assert(root.containsKey('a'));assert.equal(root.get('a').valueType(),'NULL');assert.strictEqual(root.get('a').unwrapped(),null);assert.throws(()=>config.getValue('a'),ConfigError);});
 await check('literal key edits, detached data and retained parent branches',()=>{
  const base=ConfigValue.fromAnyRef({'x.y':{list:[1]},nil:null}),changed=base.withValue('x.y',ConfigValue.fromAnyRef({list:[2]}));
  base.get('x.y').unwrapped().list.push(9);assert.deepEqual(base.unwrapped(),{'x.y':{list:[1]},nil:null});assert.deepEqual(changed.get('x.y').unwrapped(),{list:[2]});assert.deepEqual(base.withOnlyKey('x.y').keySet(),['x.y']);assert(base.withoutKey('x.y').containsKey('nil'));
 });
 await check('list ranges, iteration, equality-based search and immutable results',()=>{
  const value=ConfigValue.parse('[1.0,null,1,{a=[2]}]');assert.equal(value.indexOf(ConfigValue.fromAnyRef(1)),0);assert.equal(value.lastIndexOf(ConfigValue.fromAnyRef(1)),2);assert.equal(value.indexOf(1),-1);assert.deepEqual([...value].map(v=>v.unwrapped()),[1,null,1,{a:[2]}]);
  const slice=value.subList(1,3);assert(Object.isFrozen(slice));assert.throws(()=>slice.push(null),TypeError);assert.throws(()=>value.get(-1),RangeError);assert.throws(()=>value.get(4),ConfigError);value.get(3).unwrapped().a.push(9);assert.deepEqual(value.get(3).unwrapped(),{a:[2]});
 });
 await check('values collection follows native equality-based deduplication',()=>{const value=ConfigValue.parse('{a=1,b=1.0,c=2,d="1"}');assert.equal(value.size(),4);assert.equal(value.values().length,3);assert.equal(value.entrySet().length,4);assert(value.containsValue(ConfigValue.parse('1.0')));assert(!value.containsValue(1));});
 await check('numeric hashes retain exact long values and equality excludes spelling',()=>{const a=ConfigValue.parse('9007199254740992'),b=ConfigValue.parse('9007199254740993');assert(!a.equals(b));assert.notEqual(a.hashCode(),b.hashCode());assert(ConfigValue.parse('1.0').equals(ConfigValue.parse('1')));assert(ConfigValue.parse('-0.0').equals(ConfigValue.parse('0')));});
 await check('unresolved equality retains native directional rejection',()=>{const raw=ConfigValue.parse('${missing}'),text=ConfigValue.parse('text');assert(!raw.equals(text));assert.throws(()=>text.equals(raw),ConfigError);assert(raw.equals(ConfigValue.parse('${missing}')));});
 await check('container-derived values retain context and raw references for later resolution',()=>{
  const raw=ConfigValue.parse('{x=${MISSING}}',{environment:{MISSING:'7'}}),config=raw.atKey('outer');assert.equal(config.resolve().getString('outer.x'),'7');
  const derived=Config.parse('missing=11').withValue('copy',ConfigValue.parse('{x=${missing}}'));assert.equal(derived.resolve().getInt('copy.x'),11);
 });
 await check('fallback barrier survives path filtering, editing, root/child conversion and transfer',()=>{
  const bounded=ConfigValue.parse('{x=1}').withFallback(ConfigValue.parse('0'));
  const config=bounded.atPath('outer.a').withOnlyPath('outer.a.x').withValue('outer.a.z',3).resolve();
  const child=config.getObject('outer').get('a');assert.deepEqual(child.withFallback(ConfigValue.parse('{y=2}')).unwrapped(),{x:1,z:3});
  const handle=config_unpack(_packConfig(child.toConfig())),lower=config_unpack(_packConfig(Config.load('y=2')));
  const merged=config_derive(handle,JSON.stringify({op:'with-fallback'}),lower);assert.deepEqual(config_read_native(merged,'','','').value,{x:1,z:3});assert.deepEqual(bounded.unwrapped(),{x:1});
 });
 await check('data getter aliases retain the 0.12 ordinary-data contract',()=>{const config=Config.load('a={x=1}\nb=[{x=2}]');assert.deepEqual(config.getObjectData('a'),{x:1});assert.deepEqual(config.getListData('b'),[{x:2}]);assert.deepEqual(config.getObjectListData('b'),[{x:2}]);assert.deepEqual(config.getObjectList('b').map(v=>v.unwrapped()),[{x:2}]);});
 await check('prototype-looking data keys cannot change wrapper or object prototypes',()=>{
  const value=ConfigValue.fromAnyRef(JSON.parse('{"__proto__":{"x":1},"constructor":2}'));assert.equal(value.get('__proto__').get('x').unwrapped(),1);assert.equal(Object.getPrototypeOf(value),ConfigObject.prototype);assert.equal({}.x,undefined);assert.equal(Object.getPrototypeOf(value.unwrapped()),Object.prototype);
 });
 for(const Type of [ConfigValue,ConfigObject,ConfigList])await check('private '+Type.name+' constructor',()=>assert.throws(()=>new Type(),TypeError));
 for(const value of [ConfigValue.fromAnyRef({}),ConfigValue.fromAnyRef([])])await check('frozen container and prohibited mutation '+value.valueType(),()=>{assert(Object.isFrozen(value));for(const method of ['clear','put','remove','set','add','sort'])assert.throws(()=>value[method]('x',1),TypeError);assert.throws(()=>{value.extra=1;},TypeError);});
 fs.writeFileSync(new URL('../evidence/value-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' value/container host checks passed');
}finally{assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
