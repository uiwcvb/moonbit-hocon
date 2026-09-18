import {Config,ConfigValue,ConfigEntry,ConfigEntrySet} from './config-object.mjs';
const attempt=work=>{try{return {accepted:true,value:work()??null};}catch{return {accepted:false};}};
const valueSnapshot=value=>value===null?null:{type:attempt(()=>value.valueType()),unwrap:attempt(()=>value.unwrapped()),render:attempt(()=>value.render()),hash:attempt(()=>value.hashCode())};
const entrySnapshot=entry=>entry===null?null:{key:entry.getKey(),value:valueSnapshot(entry.getValue())};
function compareEntries(a,b){if(a===null)return b===null?0:-1;if(b===null)return 1;const ka=a.getKey(),kb=b.getKey();if(ka!==kb){if(ka===null)return -1;if(kb===null)return 1;return ka<kb?-1:1;}const av=a.getValue()?.render()??'',bv=b.getValue()?.render()??'';return av<bv?-1:av>bv?1:0;}
const setSnapshot=set=>({size:set.size(),empty:set.isEmpty(),hash:attempt(()=>set.hashCode()),entries:[...set].sort(compareEntries).map(entrySnapshot)});
const makeEntry=spec=>spec===null?null:new ConfigEntry(spec.key,spec.value===null?null:ConfigValue.parse(spec.value));
export function execute(req,provided){return attempt(()=>{
 const configs=[provided??Config[req.resolved?'load':'parse'](req.source,{includes:req.includes})],sets=[],entries=[],iterators=[],results=[];
 for(const call of req.calls)results.push(attempt(()=>{
  const config=configs[call.config??0],set=sets[call.set??0],entry=entries[call.entry??0],iterator=iterators[call.iterator??0];
  switch(call.op){
   case 'enumerate':{const id=sets.length;sets.push(config.entrySet());return id;}
   case 'new-set':{const id=sets.length;sets.push(new ConfigEntrySet(call.entries.map(makeEntry)));return id;}
   case 'copy-set':{const id=sets.length;sets.push(new ConfigEntrySet(set));return id;}
   case 'new-entry':{const id=entries.length;entries.push(makeEntry(call.spec));return id;}
   case 'find-entry':{const found=[...set].find(e=>e?.getKey()===call.key);if(found===undefined)throw Error('missing');const id=entries.length;entries.push(found);return id;}
   case 'snapshot':return setSnapshot(set);
   case 'entry-snapshot':return entrySnapshot(entry);
   case 'add':return set.add(entry);
   case 'remove':return set.remove(entry);
   case 'contains':return set.contains(entry);
   case 'clear':set.clear();return null;
   case 'add-all':return set.addAll(sets[call.other]);
   case 'remove-all':return set.removeAll(sets[call.other]);
   case 'retain-all':return set.retainAll(sets[call.other]);
   case 'contains-all':return set.containsAll(sets[call.other]);
   case 'equals':return set.equals(sets[call.other]);
   case 'entry-equals':return entry.equals(entries[call.other]);
   case 'entry-set-value':return entry.setValue(ConfigValue.parse('9'));
   case 'iterator':{const id=iterators.length;iterators.push(set.iterator());return id;}
   case 'has-next':return iterator.hasNext();
   case 'next':iterator.next();return true;
   case 'iterator-remove':iterator.remove();return null;
   case 'value-at-key':return entry.getValue().atKey('copy').resolve({allowUnresolved:true}).root().render();
   case 'value-list-get':return valueSnapshot(entry.getValue().get(call.index));
   case 'value-mutate':return entry.getValue().clear();
   case 'config-resolve':{const id=configs.length;configs.push(config.resolve({allowUnresolved:call.allowUnresolved??false}));return id;}
   case 'config-fallback':{const id=configs.length;configs.push(config.withFallback(Config.parse(call.source)));return id;}
   case 'config-at-path':{const id=configs.length;configs.push(config.atPath(call.path));return id;}
   default:throw Error('unknown entry operation '+call.op);
  }
 }));
 return {results,sets:sets.map(setSnapshot),configs:configs.map(c=>attempt(()=>c.root().render()))};
});}

export const requests=[];
const add=req=>requests.push(req),enumerate={op:'enumerate'};
const leaves=['null','1','1.0','-1','true','false','"1"','bare','"😀蓝色"','${missing}','${?missing}','pre${missing}post','[1,null,{}]','[${missing},{x=1}]','{}','{x=null}','{x=1,y=${missing}}'];
const keys=['a','a.b','"a.b"','""','"x y"','"x\\ny"','"😀"','"__proto__"','constructor','"a\\\"b"'];
for(const key of keys)for(const value of leaves)for(const resolved of [false,true])add({source:`${key}=${value}`,resolved,calls:[enumerate,{op:'copy-set'},{op:'equals',other:1},{op:'clear'},{op:'snapshot',set:1},enumerate]});
const rawSources=['{}','a=${missing}\na={x=1}','a={x=1}\na=${missing}','a=${?missing}\na={x=1}','a=1\na={x=1}','a={x=1}\na=0\na={y=2}','a={x=1}\na=${a} {y=2}','a=[1]\na+=2','a=1\na=${a}tail','a={x=${a}}','a={x=${?a}}','a=${missing}\na={x=1}\na={y=2}','a=${missing}\na={x=1}\na=null','x={n=2}\na=${x}','a.b.c=1\na.d=null','a={empty={},nested={x=1}}'];
for(const source of rawSources)for(const resolved of [false,true])add({source,resolved,calls:[enumerate,{op:'config-resolve',allowUnresolved:true},{op:'enumerate',config:1},{op:'config-at-path',path:'outer.x'},{op:'enumerate',config:2}]});
for(const source of rawSources)for(const fallback of ['a={fallback=2}','a=0','a=${missing}'])add({source,calls:[{op:'config-fallback',source:fallback},{op:'enumerate',config:1},{op:'config-resolve',config:1,allowUnresolved:true},{op:'enumerate',config:2},enumerate]});
const equality=['null','1','1.0','2','-1','true','false','bare','"bare"','"1"','[1]','[1.0]','${missing}','${?missing}','[${missing}]','{x=1}'];
for(const a of equality)for(const b of equality)add({source:`same=${a}`,calls:[enumerate,{op:'new-entry',spec:{key:'same',value:b}},{op:'contains'},{op:'add'},{op:'snapshot'},{op:'remove'},{op:'snapshot'},enumerate,{op:'equals',other:1}]});
const entryVariants=[null,{key:null,value:null},{key:'a',value:null},{key:null,value:'1'},{key:'a',value:'1'},{key:'a',value:'1.0'},{key:'b',value:'2'},{key:'a',value:'${missing}'}];
for(const a of entryVariants)for(const b of entryVariants)add({source:'a=1,b=2',calls:[enumerate,{op:'new-entry',spec:a},{op:'new-entry',spec:b},{op:'entry-equals',other:1},{op:'entry-equals',entry:1,other:0},{op:'entry-set-value'},{op:'new-set',entries:[a,b,a]},{op:'contains-all',other:1},{op:'add-all',other:1},{op:'equals',other:1},{op:'remove-all',other:1},{op:'snapshot'},{op:'retain-all',set:1,other:0}]});
for(const count of [0,1,2,8,32,128])for(const operation of ['remove-all','retain-all'])for(const otherSize of [0,1,2,8]){const entries=Array.from({length:otherSize},(_,i)=>({key:'k'+i,value:String(i)}));add({source:Array.from({length:count},(_,i)=>`k${i}=${i}`).join('\n'),calls:[enumerate,{op:'new-set',entries},{op:operation,other:1},{op:'snapshot'},enumerate,{op:operation,set:1,other:1}]});}
// Iterator programs use cardinality-only observations: HashSet order is unspecified.
for(const source of ['{}','a=1','a=1,b=2','a=1,b=2,c=3'])for(const edit of ['none','add','remove','clear','add-duplicate'])add({source,calls:[enumerate,{op:'new-entry',spec:{key:edit==='add'?'new':'a',value:'1'}},{op:'iterator'},{op:'iterator-remove'},{op:'has-next'},{op:'next'},...(edit==='none'?[]:[{op:edit==='add-duplicate'?'add':edit}]),{op:'has-next'},{op:'next'},{op:'iterator-remove'},{op:'iterator-remove'},{op:'next'},{op:'has-next'}]});
for(const source of ['a=1','a=bare','a=${missing}','a=[1,null,{x=2}]','a=[${missing}]'])add({source,calls:[enumerate,{op:'find-entry',key:'a'},{op:'entry-snapshot'},{op:'entry-set-value'},{op:'value-at-key'},{op:'value-list-get',index:0},{op:'value-list-get',index:2},{op:'value-mutate'},{op:'clear'},{op:'entry-snapshot'},enumerate]});
for(const part of ['x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]','empty={}\nn=null\n"a.b"=4'])add({source:'outer { include "part" }',includes:{part},calls:[enumerate,{op:'config-resolve',allowUnresolved:true},{op:'enumerate',config:1}]});
for(const size of [8,32,128]){const keys=Array.from({length:size},(_,i)=>i.toString(2).padStart(7,'0').replaceAll('0','Aa').replaceAll('1','BB'));add({source:keys.map(key=>key+'=1').join('\n'),calls:[enumerate,{op:'new-set',entries:keys.map(key=>({key,value:'1.0'}))},{op:'equals',other:1},{op:'add-all',other:1},{op:'remove-all',other:1}]});}
for(const source of ['{}','a=1'])add({source,calls:[enumerate,{op:'iterator'},{op:'clear'},{op:'next'},{op:'iterator-remove'},enumerate,{op:'iterator',set:1},{op:'iterator',set:1},{op:'next',iterator:1},{op:'iterator-remove',iterator:1},{op:'next',iterator:2}]});

// Separate native enumeration observations are also generated into core tests.
// These use core functionality only; set/iterator wrappers remain JS host tests.
export const coreStart=requests.length;
for(const key of keys)for(const value of leaves)for(const resolved of [false,true])add({source:`${key}=${value}`,resolved,core:true,calls:[enumerate]});
for(const source of rawSources)for(const fallback of [null,'a={fallback=2}','a=0','a=${missing}'])add({source,core:true,calls:[...(fallback===null?[]:[{op:'config-fallback',source:fallback}]),{op:'config-resolve',config:fallback===null?0:1,allowUnresolved:true},{op:'enumerate',config:fallback===null?1:2}]});
for(const part of ['x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]','empty={}\nn=null\n"a.b"=4'])add({source:'outer { include "part" }',includes:{part},core:true,calls:[enumerate]});
