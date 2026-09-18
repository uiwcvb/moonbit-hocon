import assert from 'node:assert/strict';
import fs from 'node:fs';
import {isDeepStrictEqual} from 'node:util';
import {Config} from './config.mjs';
import {requests,execute} from './entry-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/entry-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);
const failures=[];let next=0;
await Promise.all(Array.from({length:4},async()=>{for(;;){const i=next++;if(i>=requests.length)return;const req=requests[i];let actual;
 try{const config=await Config[req.resolved?'loadAsync':'parseAsync'](req.source,{includes:req.includes});actual=execute(req,config);}catch{actual={accepted:false};}
 if(!isDeepStrictEqual(actual,saved.references[i]))failures.push({index:i,request:req,actual,expected:saved.references[i]});
}}));
fs.writeFileSync(new URL('../evidence/entry-async.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Four concurrent worker factories, then entry enumeration and set/value operations on transferred trees; independent native observations. This replays the same native cases, not additional independent coverage.',sourceHashes:sourceHashes(),failures},null,2)+'\n');
console.log(`${requests.length-failures.length}/${requests.length} async entry-set programs agree`);for(const f of failures.slice(0,3))console.log(JSON.stringify(f));assert.equal(failures.length,0);
