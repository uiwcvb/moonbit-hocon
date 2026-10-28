import fs from 'node:fs';
import assert from 'node:assert/strict';
import crypto from 'node:crypto';
import {fileURLToPath} from 'node:url';
import {load,loadAsync,Config,ConfigError} from '../../tools/config.mjs';
const here=new URL('./',import.meta.url);
const read=name=>fs.readFileSync(new URL(name,here));
const hash=b=>crypto.createHash('sha256').update(b).digest('hex');
const cases=read('requests.jsonl').toString('utf8').trim().split('\n').map(JSON.parse);
const references=read('reference.stdout.jsonl').toString('utf8').trim().split('\n').map(JSON.parse);
const records=[];
function options(c){return {sourceName:c.name,includes:c.includes,fallbacks:c.fallbacks?.map(s=>({name:s.name,content:s.source,format:'hocon'}))};}
function expectedPosition(c,r){
 const source=r.originDescription.slice(0,-(': '+r.line).length);
 const text=source===c.name?c.source:c.includes?.[source]??c.fallbacks?.find(s=>s.name===source)?.source;
 assert.equal(typeof text,'string');
 const chars=Array.from(text);const offset=chars.indexOf('$');
 const prefix=chars.slice(0,offset).join('');
 return {source,offset,line:prefix.split('\n').length,column:Array.from(prefix.split('\n').at(-1)).length+1};
}
for(let i=0;i<cases.length;i++){
 const c=cases[i],r=references[i];assert.equal(r.id,c.id);
 for(const mode of ['sync','async']){
  let actual;
  try{actual={accepted:true,value:await (mode==='sync'?load:loadAsync)(c.source,options(c))};}
  catch(e){assert(e instanceof ConfigError);actual={accepted:false,errorClass:e.name,message:e.message,position:e.position};}
  assert.equal(actual.accepted,r.accepted,`${c.id}/${mode}: completion`);
  if(r.accepted)assert.deepEqual(actual.value,r.value,`${c.id}/${mode}: value`);
  else{
   assert.equal(r.errorClass,'com.typesafe.config.ConfigException$UnresolvedSubstitution');
   assert.match(actual.message,/^unresolved /);
   assert.equal(`${actual.position.source}: ${actual.position.line}`,r.originDescription);
   assert.deepEqual(actual.position,expectedPosition(c,r));
  }
  records.push({id:c.id,mode,actual,reference:r,compared:true});
 }
}
// Independent retained Config + worker transfer: resolve after factory returns.
for(const c of [cases[0],cases[5]]){
 const r=references.find(r=>r.id===c.id);
 for(const factory of ['parse','parseAsync']){
  const config=await Config[factory](c.source,options(c));assert.equal(config.isResolved(),false);
  let error;try{config.resolve();}catch(e){error=e;}
  assert(error instanceof ConfigError);
  assert.deepEqual(error.position,expectedPosition(c,r));
  records.push({id:c.id,mode:`retained-${factory}`,actual:{message:error.message,position:error.position},compared:true});
 }
}
const receipt={total:records.length,passed:records.length,failed:0,independentReferenceCases:references.length,
 upstreamCompared:['completion/missing-substitution category mapping','origin description/source','line','successful values'],
 textContractOnly:['offset','column'],unavailableUpstreamFields:['offset','column'],
 engineSHA256:hash(fs.readFileSync(new URL('../../web/engine.mjs',here))),
 requestsSHA256:hash(read('requests.jsonl')),referenceSHA256:hash(read('reference.stdout.jsonl')),
 comparatorSHA256:hash(fs.readFileSync(fileURLToPath(import.meta.url))),records};
fs.writeFileSync(new URL('HOST-REFERENCE-RESULTS.json',here),JSON.stringify(receipt,null,2)+'\n');
console.log(JSON.stringify({total:receipt.total,passed:receipt.passed,failed:0,engineSHA256:receipt.engineSHA256}));
