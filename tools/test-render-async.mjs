import assert from 'node:assert/strict';
import fs from 'node:fs';
import {isDeepStrictEqual} from 'node:util';
import {Config} from './config.mjs';
import {requests,execute} from './render-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/render-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);
const failures=[];let next=0;
await Promise.all(Array.from({length:4},async()=>{for(;;){const i=next++;if(i>=requests.length)return;const req=requests[i];let actual;
 try{const config=await Config[req.resolved?'loadAsync':'parseAsync'](req.value!==undefined?'v='+req.value:req.source,{includes:req.includes});actual=execute(req,req.value!==undefined?config.root().get('v'):config.root());}catch{actual={accepted:false};}
 if(!isDeepStrictEqual(actual,saved.references[i]))failures.push({index:i,request:req,actual,expected:saved.references[i]});
}}));
fs.writeFileSync(new URL('../evidence/render-async.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Four concurrent worker factories, then render/operations on transferred trees; exact independent native strings. This replays the same native cases, not additional independent coverage.',sourceHashes:sourceHashes(),failures},null,2)+'\n');
console.log(`${requests.length-failures.length}/${requests.length} async render programs agree`);for(const f of failures.slice(0,3))console.log(JSON.stringify(f));assert.equal(failures.length,0);
