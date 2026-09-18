import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {sourceHashes} from './evidence.mjs';
import {requests,execute} from './persistent-cases.mjs';
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/persistent-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:96*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/persistent-reference-vectors.json',import.meta.url),'{\n"reference":'+JSON.stringify(reference)+',\n"requests":'+JSON.stringify(requests,null,2)+',\n"references":[\n'+run.stdout.trim().split(/\r?\n/).join(',\n')+'\n]}\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=execute(requests[i]),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index:i,request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Persistent immutable Config branches: all final parent/child states, typed getters, resolve/self/external, fallback/value transfer, child configs, validation and a chain beyond the old 64-step pipeline. Acceptance/values; exception class/text, origins and Java identity are not compared.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/persistent-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} persistent Config native programs agree`);
for(const failure of failures.slice(0,5))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
