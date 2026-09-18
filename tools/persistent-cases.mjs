import {Config} from './config-object.mjs';
export const getterMethods={string:'getString',boolean:'getBoolean',int:'getInt',long:'getLong',double:'getDouble',number:'getNumber',object:'getObject','any-ref':'getAnyRef',list:'getList',period:'getPeriod',temporal:'getTemporal',bytes:'getBytes',memory:'getMemorySize',milliseconds:'getMilliseconds',nanoseconds:'getNanoseconds','string-list':'getStringList','boolean-list':'getBooleanList','int-list':'getIntList','long-list':'getLongList','double-list':'getDoubleList','number-list':'getNumberList','object-list':'getObjectList','any-ref-list':'getAnyRefList','bytes-list':'getBytesList','memory-list':'getMemorySizeList','milliseconds-list':'getMillisecondsList','nanoseconds-list':'getNanosecondsList',has:'hasPath','has-or-null':'hasPathOrNull',null:'getIsNull',empty:'isEmpty',resolved:'isResolved',entries:'entrySet'};
const choices=['RED','GREEN','BLUE','on','yes','NaN','Infinity','蓝色','Α','_foo','$dollar'];
export function read(config,call){
 const {getter,path,unit}=call;
 if(getter==='object-list')return config.getObjectList(path).map(value=>value.unwrapped());
 if(getter==='object'||getter==='list')return config[getterMethods[getter]](path).unwrapped();
 if(getterMethods[getter])return config[getterMethods[getter]](path);
 if(getter==='enum')return config.getEnum(path,choices);
 if(getter==='enum-list')return config.getEnumList(path,choices);
 if(getter==='duration'||getter==='duration-in')return config.getDuration(path,unit);
 if(getter==='duration-list'||getter==='duration-list-in')return config.getDurationList(path,unit);
 if(getter==='config')return config.getConfig(path).toJSON();
 if(getter==='config-list')return config.getConfigList(path).map(c=>c.toJSON());
 throw new Error('Unknown test getter '+getter);
}
export function snapshot(config,probes){
 const resolved=config.isResolved(),result={resolved,probes:{}};
 if(resolved)result.value=config.toJSON();
 for(const path of probes){try{result.probes[path]={accepted:true,value:config.getAnyRef(path)};}catch{result.probes[path]={accepted:false};}}
 return result;
}
export function execute(req){
 try{return executeUsing(req,Config[req.resolved?'load':'parse'](req.source,{environment:req.environment,includes:req.includes,format:req.format??'hocon'}));}catch{return {accepted:false};}
}
export function executeUsing(req,initial){
 try{
  const options={environment:req.environment,includes:req.includes,format:req.format??'hocon'};
  const configs=[initial],results=[],first=snapshot(initial,req.probes??[]);
  for(const call of req.calls){try{
   const config=configs[call.target??0];let value;
   if(call.action==='read')value=read(config,call);
   else if(call.action==='validate'){
    value=call.problems?config.validationProblems(configs[call.other],...(call.paths??[])).map(({path,kind})=>({path,kind})):(config.checkValid(configs[call.other],...(call.paths??[])),null);
   }else if(call.action==='children')value=config.getConfigList(call.path).map(child=>{const id=configs.length;configs.push(child);return id;});
   else{
    let next;
    if(call.action==='create')next=Config[call.resolved?'load':'parse'](call.source,options);
    else switch(call.op){
     case 'resolve':next=config.resolve({allowUnresolved:call.allowUnresolved??false});break;
     case 'resolve-with':next=config.resolveWith(configs[call.other],{allowUnresolved:call.allowUnresolved??false});break;
     case 'with-fallback':next=config.withFallback(configs[call.other]);break;
     case 'get-config':next=config.getConfig(call.path);break;
     case 'with-value-source':next=config.withValueSource(call.path,call.source);break;
     case 'with-value-from':next=config.withValueFrom(call.path,configs[call.other],call.valuePath);break;
     case 'with-value':next=config.withValue(call.path,call.value);break;
     case 'without-path':next=config.withoutPath(call.path);break;
     case 'with-only-path':next=config.withOnlyPath(call.path);break;
     case 'at-key':next=config.atKey(call.path);break;
     case 'at-path':next=config.atPath(call.path);break;
     case 'without-key':next=config.withoutKey(call.path);break;
     case 'with-only-key':next=config.withOnlyKey(call.path);break;
     default:throw new Error('Unknown test operation');
    }
    value=configs.length;configs.push(next);
   }
   results.push({accepted:true,value});
  }catch{results.push({accepted:false});}}
  return {accepted:true,value:{initial:first,results,final:configs.map(c=>snapshot(c,req.probes??[]))}};
 }catch{return {accepted:false};}
}
export const requests=[];
const probes=['a','a.x','a.known','b','missing','known','outer.a','"quoted.key"'];
const sources=['{}','a=1\nb=null','a=bare','a=${missing}','a=${?missing}','a={x=${missing},known=1}','a=[${missing},1]','a=${missing}\na={x=1}','a={x=1}\na=${missing}','a=${missing}\na={x={z=1}}','a=1\na=${a}tail','a=[1]\na+=2','a=${b}\nb=2','a=${b}\nb=${a}','a={x=1}\nb=${a}','a={x=${missing}}\nb=${a}', 'a={x=1}\nb=[{x=2},{x=3}]','"quoted.key"={x=1}\na={"x.y"=2}','include "part"\na=${x}'];
const base={persistent:true,probes,includes:{part:'x=3'},environment:{MISSING_FROM_ENV:'7'}};
for(const source of sources){
 const operations=[{op:'resolve'},{op:'resolve',allowUnresolved:true},{op:'resolve-with',other:0},{op:'get-config',path:'a'},{op:'get-config',path:'"quoted.key"'},{op:'with-value',path:'a',value:{x:9}},{op:'with-value',path:'missing',value:7},{op:'with-value',path:'a.x',value:null},{op:'with-value-source',path:'known',source:'${missing}'},...['without-path','with-only-path','at-path','at-key','without-key','with-only-key'].map(op=>({op,path:'a.x'}))];
 for(const operation of operations)requests.push({...base,source,calls:[{action:'derive',...operation},{action:'read',target:0,getter:'has',path:'a'},{action:'read',target:0,getter:'has-or-null',path:'a'},{action:'read',target:0,getter:'null',path:'a'},{action:'read',target:1,getter:'int',path:'x'},{action:'derive',target:1,op:'resolve',allowUnresolved:true}]});
 for(const external of ['missing=7','missing={x=9}\na={x=11}','missing=${other}\nother=8','{}'])for(const op of ['with-fallback','resolve-with','with-value-from'])requests.push({...base,source,calls:[{action:'create',source:external},{action:'derive',target:0,op,other:1,path:'copy',valuePath:'missing',allowUnresolved:true},{action:'derive',target:2,op:'resolve',allowUnresolved:true},{action:'read',target:0,getter:'resolved'}]});
 requests.push({...base,source,calls:[{action:'children',path:'b'},{action:'read',target:1,getter:'int',path:'x'},{action:'derive',target:1,op:'with-value',path:'x',value:99},{action:'read',target:1,getter:'int',path:'x'}]});
}
for(const value of ['1','"2"','true','null','{x=1}','[1,"2"]','[{x=1},{}]','2months','1.5s','RED','[RED,GREEN]','[null]','"9223372036854775807"','"-0.0"','["-0.0",1]']){
 const calls=[...Object.keys(getterMethods),'enum','enum-list','duration','duration-list','duration-in','duration-list-in','config','config-list'].map(getter=>({action:'read',getter,path:'a',...(getter.endsWith('-in')?{unit:'milliseconds'}:{})}));
 requests.push({...base,source:'a='+value,resolved:true,calls});
}
for(const source of ['a=1','a="1"','a=null','a={x=2}','a=${missing}','{}'])for(const reference of ['a=1','a="text"','a={x=1}','a=null','a=${missing}'])for(const paths of [[],['a'],['missing']])requests.push({...base,source,calls:[{action:'create',source:reference},{action:'validate',other:1,paths},{action:'validate',other:1,paths,problems:true},{action:'read',getter:'resolved'}]});
requests.push({...base,source:'a=0',calls:Array.from({length:160},(_,i)=>({action:'derive',target:i,op:'with-value',path:'a',value:i+1}))});

// Lookback and enclosing references must survive wrapping without permitting a
// cycle when there is no lower binding. Every program checks its old parents.
for(const source of ['a=1\na=${a}tail','a=[1]\na+=2','a={x=1}\na=${a} {y=2}','a={x=${a}}','a={x=${?a}}','a={x=1}\na.x=${a}','a={x=1}\na.x=${?a}','a=1\na=${a}','a=${a}','a=${?a}','a=${b}\nb=${a}','a=1\na=${a}${missing}','a=1\na=${a}${?missing}','a=1\na=${a}tail\na=${a}more','a=[1]\na+=2\na+=3','a={x=1}\na={x=${a.x}tail}','a=${missing}\na={x=1}']){
 for(const prefix of ['a','a.x','a.a','outer','outer.a','outer.x'])for(const allowUnresolved of [false,true])requests.push({...base,source,calls:[{action:'derive',op:'at-path',path:prefix},{action:'derive',target:1,op:'resolve',allowUnresolved},{action:'derive',target:0,op:'resolve',allowUnresolved}]});
}
