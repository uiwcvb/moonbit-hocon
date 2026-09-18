import assert from 'node:assert/strict';
import fs from 'node:fs';
import {isDeepStrictEqual} from 'node:util';
import {Config} from './config-object.mjs';
import {requests,execute} from './value-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/value-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);
const failures=[];
for(let i=0;i<requests.length;i++){
 const request=requests[i];let actual;
 try{const root=(await Config[request.resolved?'loadAsync':'parseAsync'](request.source)).root();actual=execute(request,root);}catch{actual={accepted:false};}
 if(!isDeepStrictEqual(actual,saved.references[i]))failures.push({index:i,request,actual,expected:saved.references[i]});
}
fs.writeFileSync(new URL('../evidence/value-async.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Each initial source parsed/loaded in a worker; value/container program continued on the reconstructed tree and compared with native results.',sourceHashes:sourceHashes(),failures},null,2)+'\n');
console.log(`${requests.length-failures.length}/${requests.length} async value/container programs agree`);for(const failure of failures.slice(0,2))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
