import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {split_path_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
import {requests} from './path-cases.mjs';
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/path-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);({references,reference}=saved);}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./PathOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:16*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9 ConfigUtil.splitPath',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/path-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=JSON.parse(split_path_json(requests[i].path)),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index:i,request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Public path decomposition: plain ASCII, quoted/concatenated/empty components, every ASCII character, Unicode whitespace and letters, comments, invalid separators and depths 1 through 32. Exact exception types/positions and inputs beyond local budgets are excluded.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/path-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} path native cases agree`);
for(const failure of failures.slice(0,15))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
