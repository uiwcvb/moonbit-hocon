import {Config,ConfigValue} from './config-object.mjs';
const attempt=work=>{try{return {accepted:true,value:work()};}catch{return {accepted:false};}};
export const snapshot=value=>({type:attempt(()=>value.valueType()),unwrapped:attempt(()=>value.unwrapped())});
export function execute(req,provided){
 return attempt(()=>{
  const initial=provided??Config[req.resolved?'load':'parse'](req.source).root(),values=[initial],results=[];
  for(const call of req.calls)results.push(attempt(()=>{
   const value=values[call.target??0],other=values[call.other??call.target??0],key=call.key??'';
   switch(call.op){
    case 'type':return value.valueType();
    case 'unwrap':return value.unwrapped();
    case 'size':return value.size();
    case 'empty':return value.isEmpty();
    case 'keys':return [...value.keySet()].sort();
    case 'contains-key':return value.containsKey(key);
    case 'contains-value':return value instanceof (initial.constructor)?value.containsValue(other):value.contains(other);
    case 'equals':return value.equals(other);
    case 'hash':return value.hashCode();
    case 'index-of':return value.indexOf(other);
    case 'last-index-of':return value.lastIndexOf(other);
    case 'values':return [...value.values()].map(snapshot);
    case 'sub-list':return value.subList(call.from,call.to).map(snapshot);
    case 'mutate':return value.clear();
   }
   let next;
   switch(call.op){
    case 'new':next=ConfigValue.parse(call.source,{resolved:call.resolved??false});break;
    case 'get-key':next=value.get(key);break;
    case 'get-index':next=value.get(call.index);break;
    case 'get-value':next=value.toConfig().getValue(key);break;
    case 'get-object':next=value.toConfig().getObject(key);break;
    case 'get-list':next=value.toConfig().getList(key);break;
    case 'with-value':next=value.withValue(key,other);break;
    case 'only-key':next=value.withOnlyKey(key);break;
    case 'without-key':next=value.withoutKey(key);break;
    case 'fallback':next=value.withFallback(call.asConfig?other.toConfig():other);break;
    case 'config-fallback':next=value.toConfig().withFallback(call.asConfig?other.toConfig():other).root();break;
    case 'at-key':next=value.atKey(key).root();break;
    case 'at-path':next=value.atPath(key).root();break;
    case 'to-config':next=value.toConfig().root();break;
    case 'resolve':next=value.toConfig().resolve({allowUnresolved:call.allowUnresolved??false}).root();break;
    default:throw new Error('Unknown value operation '+call.op);
   }
   if(next===null)return null;const id=values.length;values.push(next);return id;
  }));
  return {results,final:values.map(snapshot)};
 });
}

export const requests=[];
const sources=['{}','a=1','a=null','a=bare','a="1"','a=[1,null,"two",{}]','a={x=1,y=null}','a={"x.y"=1,""=2}','a={"__proto__"=1,constructor=2}',
 'a=${missing}','a=${?missing}','a={x=${missing},known=1}','a=[${missing},1]','a=${missing}\na={x=1}',
 'a={x=1}\na=${missing}','a=${?missing}\na={x=1}','a=1\na={x=1}','a={x=1}\na=0\na={y=2}',
 'a={x=1}\na=${a} {y=2}','a=[1]\na+=2','a=1\na=${a}tail','a={x=${a}}','a={x=${?a}}',
 'a=pre${missing}post','a={0=first,1=second}','a=[{x=1},{x=${missing}}]','a={x={z=1}}'];
const queries=[{op:'type'},{op:'unwrap'},{op:'size'},{op:'empty'},{op:'keys'},{op:'values'},{op:'contains-key',key:'x'},{op:'get-key',key:'missing'},{op:'get-key',key:'x'},{op:'get-key',key:'y'},{op:'get-index',index:0},{op:'get-index',index:-1},{op:'get-index',index:9},{op:'sub-list',from:0,to:1},{op:'sub-list',from:-1,to:1},{op:'mutate'}];
for(const source of sources)for(const resolved of [false,true]){
 requests.push({source,resolved,calls:[...queries,...['get-value','get-object','get-list'].map(op=>({op,key:'a'}))]});
 requests.push({source,resolved,calls:[{op:'get-key',key:'a'},...queries.map(call=>({...call,target:1})),{op:'to-config',target:1}]});
 for(const edit of ['only-key','without-key','at-key','at-path'])for(const key of ['x','x.y','"x.y"',''])requests.push({source,resolved,calls:[{op:'get-key',key:'a'},{op:edit,target:1,key},{op:'resolve',target:2,allowUnresolved:true}]});
}
// Three-stage fallback and retained branches: the middle non-object must keep
// later objects out, including after embedding, copying and resolving.
const high=['{}','{x=1}','{x=${missing}}','{x=${?missing}}','{x={z=1}}','1','null','[1]','[${missing}]','${missing}','${?missing}','pre${missing}post'];
const low=['{}','{y=2}','{x=9,z=3}','0','null','[2]','${missing}','${?missing}','{x=${other}}'];
for(const a of high)for(const b of low){
 const calls=[{op:'new',source:a},{op:'new',source:b},{op:'fallback',target:1,other:2},{op:'new',source:'{x=11,y=12,z=13}'},{op:'fallback',target:3,other:4},{op:'at-key',target:3,key:'a'},{op:'get-key',target:6,key:'a'},{op:'fallback',target:7,other:4},{op:'resolve',target:6,allowUnresolved:true}];
 requests.push({source:'{}',calls});
 for(const op of ['only-key','without-key','with-value'])requests.push({source:'{}',calls:[...calls.slice(0,4),{op,target:3,key:'x',other:4},{op:'fallback',target:5,other:4},{op:'at-path',target:6,key:'outer.a'},{op:'resolve',target:7,allowUnresolved:true}]});
}
for(const key of ['a','a.b','"a.b"','""','__proto__','constructor'])requests.push({source:'a={x=1,y=2}',calls:[{op:'get-key',key:'a'},{op:'new',source:'null'},{op:'with-value',target:1,key,other:2},{op:'get-key',target:3,key},{op:'contains-key',target:3,key},{op:'without-key',target:3,key},{op:'only-key',target:3,key}]});

const equalityValues=['0','-0.0','1','1.0','1e0','1.5','-1','2147483647','2147483648','9007199254740992','9007199254740993','9223372036854775807','9223372036854775808','-9223372036854775808','1e100','1e-100','true','false','null','bare','"bare"','"1"','"😀蓝色"','{}','{a=1,b=2}','{b=2,a=1.0}','[1,2]','[1.0,2.0]','[2,1]','${missing}','${?missing}','${missing.path}','${?MISSING_LIST[]}','pre${missing}post','pre ${missing} post','{a=${missing}}','[${missing},1]'];
for(const a of equalityValues)for(const b of equalityValues)requests.push({source:'{}',calls:[
 {op:'new',source:a},{op:'new',source:b},{op:'equals',target:1,other:2},{op:'equals',target:2,other:1},{op:'hash',target:1},{op:'hash',target:2},
 {op:'new',source:`[${a},${b},${a}]`},{op:'contains-value',target:3,other:1},{op:'index-of',target:3,other:2},{op:'last-index-of',target:3,other:1},
 {op:'new',source:`{a=${a},b=${b},c=${a}}`},{op:'contains-value',target:4,other:2},{op:'values',target:4},{op:'hash',target:4}
]});
for(const source of ['a=${missing}\na={x=1}','a=${missing}\na={x=1}\na={y=2}','a=1\na=${missing}','a=1\na=${missing}\na=${other}','a=[1]\na=[${missing}]'])requests.push({source,calls:[{op:'get-key',key:'a'},{op:'hash',target:1},{op:'new',source:'{x=1}'},{op:'equals',target:1,other:2},{op:'equals',target:2,other:1},{op:'fallback',target:2,other:1},{op:'hash',target:3}]});
for(const size of [4,8,12,16,24,32,64,128]){
 const keys=['z','a.long.key','k10','k2','😀','\ue000','𐐷',...Array.from({length:size},(_,i)=>'key'+i)];
 const source='{'+keys.map((key,i)=>JSON.stringify(key)+'='+i).join(',')+'}';
 const reversed='{'+keys.map((key,i)=>JSON.stringify(key)+'='+i).reverse().join(',')+'}';
 requests.push({source:'{}',calls:[{op:'new',source},{op:'new',source:reversed},{op:'equals',target:1,other:2},{op:'equals',target:2,other:1},{op:'hash',target:1},{op:'hash',target:2}]});
}
for(const source of ['a={x=1}','a=${missing}\na={x=1}','a={x=${missing}}'])for(const fallback of ['0','{y=2}','${?missing}'])for(const asConfig of [false,true])requests.push({source,calls:[{op:'get-key',key:'a'},{op:'new',source:fallback},{op:'config-fallback',target:1,other:2,asConfig},{op:'resolve',target:3,allowUnresolved:true}]});
