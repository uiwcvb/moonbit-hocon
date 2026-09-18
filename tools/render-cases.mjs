import {Config,ConfigValue} from './config.mjs';
export const requests=[];
function add(request){for(const json of [true,false])for(const formatted of [false,true])requests.push({...request,json,formatted});}
const scalars=['null','true','false','0','-0','-0.0','1.0','1.50','1e3','1e30','1e-9','5e-324','-1e-999','1e999','-1e999','2147483648','9223372036854775807','9007199254740993','9223372036854775808','text','a-b','a_b','http://a','""','"123"','"truex"','"falsey"','"includeA"','"nulls"','"text"','"中文"','"é"','"١x"','"x_y"','"x y"','"a.b"','"😀"','"a\\nb\\tc\\r\\b\\f\\u0000\\u001f"','${missing}','${?missing}','${"a.b".x}','${?ENV[]}','hello ${missing} world','${x}${y}','[1,2] ${missing}','{x=1} ${missing}','${missing} {x=2}','[${missing},text,null,1.0]','{}','[]'];
for(const value of scalars){add({value});add({source:'a='+value});add({source:'a='+value,resolved:true});}
for(const key of ['', 'a','a.b','true','falseX','include-me','nullThing','x_y','-x','1','01','١','中文','😀','x\ny','Aa','BB'])add({source:JSON.stringify(key)+'={child=[1,{x=${missing}},[]]}'});
for(const source of ['a={x=1,y=2}\nz=3','"10"=ten\n"2"=two\n"1"=one\na=alpha\nZ=zed','"01"=a\n"1"=b\n"001"=c\n"٠١"=d','"999999999999999999999999999"=a\n"111111111111111111111111111"=b','a=${x}\na=1','a=1\na=${x}','a=${x}\na={b=2}','a={b=${x}}\na={c=3}','a=${x}\na=${y}\na={z=3}','a=[1]\na+=2','a=[1]\na+=${missing}','a={v=1}\na=${a}{x=2}','a=${?missing}\nb=2','# top\na=1 # inline\n# next\nb=[2,3]']){
 add({source});add({source,steps:[{op:'key',key:'a'}]});add({source,steps:[{op:'at-key',key:'wrapped'}]});add({source,steps:[{op:'resolve',allowUnresolved:true}]});
}
for(const high of ['${x}','{a=${x}}','[${x}]','{a=1}','1','${?x}'])for(const low of ['{b=2}','0','${y}']){
 add({value:high,steps:[{op:'fallback',value:low}]});
 add({value:high,steps:[{op:'fallback',value:low},{op:'at-key',key:'merged'}]});
}
for(const value of ['{a=1,b=${missing}}','[null,${missing},{a=1}]','"text"','{nested={a=1}}'])for(const op of ['at-key','at-path'])add({value,steps:[{op,key:'outer.inner'}]});
for(const value of ['1.0','1e3','1e30','-0.0','0.0001','true','null','"hello"','plain'])for(const source of [value+' ${missing}','${missing} '+value,value+' suffix ${missing}'])add({value:source});
for(const source of ['x=1\na=${x}','x=1.50\na=${x}','a={nested={list=[1,2]}}','a=${missing}\na={x=1}\na={y=2}','a=${?missing}\na=${?other}\na={x=${optional}}'])for(const steps of [[],[{op:'key',key:'a'}],[{op:'with-key',key:'added',value:'{v=${x}}'}],[{op:'without-key',key:'a'}],[{op:'resolve',allowUnresolved:true}]])add({source,steps});
// Deterministic binary64 samples exercise decimal rendering independently of
// implementation-selected spellings. Expected strings still come from Java.
const bytes=new ArrayBuffer(8),view=new DataView(bytes);let bits=0x123456789abcdefn;
for(let i=0;i<600;i++){
 bits=BigInt.asUintN(64,bits*6364136223846793005n+1442695040888963407n);view.setBigUint64(0,bits);const number=view.getFloat64(0);
 if(Number.isFinite(number))requests.push({value:number.toExponential(),json:true,formatted:false});
}
for(const exponent of [-324,-323,-309,-308,-307,-100,-10,-4,-3,-2,0,6,7,8,15,16,17,20,21,22,23,100,307,308])for(const significant of ['1','1.0000000000000002','4.9','9.999999999999998'])for(const sign of ['','-'])requests.push({value:sign+significant+'e'+exponent,json:true,formatted:false});
for(const source of ['{"10":10,"2":2,"١":1,"01":0,"a":3,"aa":4,"b":5}','{empty={},list=[{a=[1,2]},[{},[]]]}','{"a.b"={"c.d"=${"x.y"}},"x.y"=2}'])for(const resolved of [false,true])add({source,resolved});
for(const source of ['include "part"','outer { include "part" }','"outer.key" { include "part" }','outer { inner { include "part" } }'])for(const steps of [[],[{op:'resolve',allowUnresolved:true}],[{op:'at-key',key:'wrapped'}]])add({source,includes:{part:'x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]'},steps});
const seen=new Set();for(let i=requests.length-1;i>=0;i--){const key=JSON.stringify(requests[i]);if(seen.has(key))requests.splice(i,1);else seen.add(key);}
export function execute(request,initial){try{
 let value=initial??(request.value!==undefined?ConfigValue.parse(request.value):Config[request.resolved?'load':'parse'](request.source,{includes:request.includes}).root());
 for(const step of request.steps??[]){switch(step.op){
  case 'key':value=value.get(step.key);break;case 'index':value=value.get(step.index);break;case 'path':value=value.toConfig().getValue(step.key);break;
  case 'fallback':value=value.withFallback(ConfigValue.parse(step.value));break;
  case 'with-key':value=value.withValue(step.key,ConfigValue.parse(step.value));break;case 'without-key':value=value.withoutKey(step.key);break;
  case 'at-key':value=value.atKey(step.key).root();break;case 'at-path':value=value.atPath(step.key).root();break;
  case 'resolve':value=value.toConfig().resolve({allowUnresolved:step.allowUnresolved??false}).root();break;
  default:throw new Error('unknown render operation');
 }}
 return {accepted:true,value:value.render({json:request.json??true,formatted:request.formatted??false})};
}catch{return {accepted:false};}}
