import {config_create,config_error,config_read_native,config_derive,config_child,config_children,config_validate,config_pack,config_unpack} from '../web/engine.mjs';
import {prepare} from './config-host.mjs';
import {ConfigError} from './config-error.mjs';
import {executeAsync} from './config-async.mjs';

const token=Symbol('Config constructor'),states=new WeakMap();
function result(text){const value=JSON.parse(text);if(!value.accepted)throw new ConfigError(value);return value.value;}
function state(config){const stored=states.get(config);if(!stored)throw new TypeError('Expected a Config object');return stored;}
function path(value){if(typeof value!=='string')throw new TypeError('Configuration path must be a string');return value;}
function environment(value={}){
 if(value===null||typeof value!=='object'||Array.isArray(value))throw new TypeError('environment must be a string map');
 const pairs=Object.entries(value);for(const [,v] of pairs)if(typeof v!=='string')throw new TypeError('environment values must be strings');
 return Object.freeze(Object.fromEntries(pairs));
}
function factoryOptions(options){
 if(options===null||typeof options!=='object'||Array.isArray(options))throw new TypeError('Configuration options must be an object');
 for(const key of ['document','steps','probes','getter','path','operations','checkValid','referenceSource','validationPaths','enumChoices','unit'])if(options[key]!==undefined)throw new TypeError('Config factory does not accept '+key);
 return {...options,...(options.includes!==undefined?{includes:environment(options.includes)}:{}),environment:environment(options.environment)};
}
function create(source,options,kind,resolved){
 if(typeof source!=='string')throw new TypeError('Configuration source must be a string');
 const cloned=factoryOptions(options),{request,callback}=prepare(source,{...cloned,document:!resolved},kind);
 return new Config(token,config_create(JSON.stringify(request),callback),cloned.environment);
}
async function createAsync(source,options,method){
 const checked=factoryOptions(options),{signal,...rest}=checked,cloned=structuredClone(rest);
 const wire=await executeAsync(source,{...cloned,signal},'config-'+method,error=>error.name==='ConfigError'?new ConfigError({error:error.message,position:error.position,problems:error.problems}):new Error(error.message));
 return new Config(token,config_unpack(wire),cloned.environment);
}
function query(config,getter,key,options){const value=config_read_native(state(config).handle,getter??'',key??'',options?JSON.stringify(options):'');if(!value.accepted)throw new ConfigError(value);return value.value;}
function derive(config,operation,other=config,env=state(config).environment){
 return new Config(token,config_derive(state(config).handle,JSON.stringify(operation),state(other).handle),env);
}
function resolveOptions(config,options){
 if(options===null||typeof options!=='object'||Array.isArray(options))throw new TypeError('Resolve options must be an object');
 if(options.allowUnresolved!==undefined&&typeof options.allowUnresolved!=='boolean')throw new TypeError('allowUnresolved must be boolean');
 return {environment:environment(options.environment===undefined?state(config).environment:options.environment),allowUnresolved:options.allowUnresolved??false};
}
function jsonValue(value){
 const text=JSON.stringify(value,(_,v)=>{
  if(v===undefined||['function','symbol','bigint'].includes(typeof v)||(typeof v==='number'&&!Number.isFinite(v)))throw new TypeError('withValue requires JSON values; use withValueSource for exact numeric text');
  return v;
 });
 if(text===undefined)throw new TypeError('withValue requires a JSON value');
 return JSON.parse(text);
}

/** Immutable configuration retaining its MoonBit tree, independent of source files. */
export class Config {
 constructor(key,handle,env){
  if(key!==token)throw new TypeError('Use Config.parse/load or their file/URL factories');
  const error=config_error(handle);if(error)result(error);states.set(this,{handle,environment:Object.isFrozen(env)?env:environment(env)});Object.freeze(this);
 }
 static parse(source,options={}){return create(source,options,'string',false);}
 static load(source,options={}){return create(source,options,'string',true);}
 static parseFile(filename,options={}){return create(filename,options,'file',false);}
 static loadFile(filename,options={}){return create(filename,options,'file',true);}
 static parseURL(url,options={}){return create(url,options,'url',false);}
 static loadURL(url,options={}){return create(url,options,'url',true);}
 static parseAsync(source,options={}){return createAsync(source,options,'parse');}
 static loadAsync(source,options={}){return createAsync(source,options,'load');}
 static parseFileAsync(filename,options={}){return createAsync(filename,options,'parseFile');}
 static loadFileAsync(filename,options={}){return createAsync(filename,options,'loadFile');}
 static parseURLAsync(url,options={}){return createAsync(url,options,'parseURL');}
 static loadURLAsync(url,options={}){return createAsync(url,options,'loadURL');}
 static fromObject(value){return Config.load(JSON.stringify(jsonValue(value)),{format:'json'});}
 get(key,{type='any-ref',...options}={}){if(typeof type!=='string')throw new TypeError('Getter type must be a string');for(const name of Object.keys(options))if(!['unit','enumChoices'].includes(name))throw new TypeError('Unknown getter option: '+name);return query(this,type,path(key),options);}
 getConfig(key){const stored=state(this);return new Config(token,config_child(stored.handle,path(key)),stored.environment);}
 getConfigList(key){return config_children(state(this).handle,path(key)).map(handle=>new Config(token,handle,state(this).environment));}
 getEnum(key,choices){return query(this,'enum',path(key),{enumChoices:choices});}
 getEnumList(key,choices){return query(this,'enum-list',path(key),{enumChoices:choices});}
 getDuration(key,unit){return query(this,unit===undefined?'duration':'duration-in',path(key),{unit});}
 getDurationList(key,unit){return query(this,unit===undefined?'duration-list':'duration-list-in',path(key),{unit});}
 isEmpty(){return query(this,'empty');}
 isResolved(){return query(this,'resolved');}
 entrySet(){return query(this,'entries');}
 toJSON(){return query(this,undefined);}
 render(){return query(this,'json-text');}
 resolve(options={}){const checked=resolveOptions(this,options);return derive(this,{op:'resolve',...checked},this,checked.environment);}
 resolveWith(other,options={}){const checked=resolveOptions(this,options);return derive(this,{op:'resolve-with',...checked},other,checked.environment);}
 withFallback(other){return derive(this,{op:'with-fallback'},other);}
 withValue(key,value){return derive(this,{op:'with-value',path:path(key),value:jsonValue(value)});}
 withValueSource(key,source){if(typeof source!=='string')throw new TypeError('Value source must be a string');return derive(this,{op:'with-value-source',path:path(key),source});}
 withValueFrom(key,other,valuePath){return derive(this,{op:'with-value-from',path:path(key),valuePath:path(valuePath)},other);}
 withoutPath(key){return derive(this,{op:'without-path',path:path(key)});}
 withOnlyPath(key){return derive(this,{op:'with-only-path',path:path(key)});}
 atPath(key){return derive(this,{op:'at-path',path:path(key)});}
 atKey(key){return derive(this,{op:'at-key',path:path(key)});}
 withoutKey(key){return derive(this,{op:'without-key',path:path(key)});}
 withOnlyKey(key){return derive(this,{op:'with-only-key',path:path(key)});}
 checkValid(reference,...paths){for(const p of paths)path(p);result(config_validate(state(this).handle,state(reference).handle,JSON.stringify({paths})));return this;}
 validationProblems(reference,...paths){for(const p of paths)path(p);return result(config_validate(state(this).handle,state(reference).handle,JSON.stringify({paths,problems:true})));}
}
const getters={
 getString:'string',getBoolean:'boolean',getInt:'int',getLong:'long',getDouble:'double',getNumber:'number',
 getObject:'object',getAnyRef:'any-ref',getList:'list',getPeriod:'period',getTemporal:'temporal',getBytes:'bytes',getMemorySize:'memory',getMilliseconds:'milliseconds',getNanoseconds:'nanoseconds',
 getStringList:'string-list',getBooleanList:'boolean-list',getIntList:'int-list',getLongList:'long-list',getDoubleList:'double-list',getNumberList:'number-list',getObjectList:'object-list',getAnyRefList:'any-ref-list',getBytesList:'bytes-list',getMemorySizeList:'memory-list',getMillisecondsList:'milliseconds-list',getNanosecondsList:'nanoseconds-list',
 hasPath:'has',hasPathOrNull:'has-or-null',getIsNull:'null',
};
for(const [method,getter] of Object.entries(getters))Object.defineProperty(Config.prototype,method,{value:function(key){return query(this,getter,path(key));}});

// Internal worker transfer: reconstruct MoonBit values, not generated JS prototypes.
export function _packConfig(config){return JSON.stringify(result(config_pack(state(config).handle)));}
