import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {sourceHashes} from './evidence.mjs';
import {requests,execute} from './value-cases.mjs';
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/value-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);({references,reference}=saved);}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./ValueOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:64*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/value-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){const actual=execute(requests[i]),expected=references[i];if(!isDeepStrictEqual(actual,expected))failures.push({index:i,request:requests[i],actual,expected});}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Raw/resolved ConfigValue, object and list reads; literal keys/null; immutable edits; arbitrary-value fallback barriers across embedding and continued operations. Exact type/data/acceptance; errors/origins/rendering and high-collision iteration are outside scope.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/value-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} value/container native programs agree`);
for(const failure of failures.slice(0,4))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
