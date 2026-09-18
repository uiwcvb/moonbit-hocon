import assert from 'node:assert/strict';
import fs from 'node:fs';
import {isDeepStrictEqual} from 'node:util';
import {Config} from './config-object.mjs';
import {requests,executeUsing} from './persistent-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/persistent-reference-vectors.json',import.meta.url),'utf8'));
assert.deepEqual(saved.requests,requests);
const failures=[];let next=0;
await Promise.all(Array.from({length:4},async()=>{
 while(next<requests.length){const index=next++,req=requests[index];let actual;
  try{const initial=await Config[req.resolved?'loadAsync':'parseAsync'](req.source,{environment:req.environment,includes:req.includes});actual=executeUsing(req,initial);}catch{actual={accepted:false};}
  const expected=saved.references[index];if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index,actual,expected});
 }
}));
fs.writeFileSync(new URL('../evidence/persistent-async.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),programs:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Four concurrent worker factories retain unresolved AST/exact number spelling and produce the same persistent branch outcomes as saved independent native expectations.',sourceHashes:sourceHashes(),failures},null,2)+'\n');
console.log(`${requests.length-failures.length}/${requests.length} async persistent native programs agree`);
for(const failure of failures.slice(0,2))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
