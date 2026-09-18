import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const sources=[
 '{}','a=foo','a=1\nb=true\nc=null','a=${missing}','a=${?missing}','a=pre${missing}post',
 'a=[${missing},${?gone},1]','a={x=${missing},known=1}','a=${missing}\na={x=1}',
 'a=1\na=${missing}','a={x=1}\na=${missing}','a=${missing}\na=${other}',
 'a=${?missing}\na={x=1}','a={x=1}\na=${?missing}','a=${missing}\na=1',
 'a=${missing}\na={x=${other}}','a=1\na=${a}foo','a=[1]\na+=2','a+=${missing}',
 'x=1\na=${x}','x={z=1}\na=${x}','x=[1,2]\na=${x}',
 'a=${b}\nb=${c}\nc=3','a=${b}\nb=${a}','a=${a}','a=${?a}','a=${?b}\nb=${?a}',
 'a={x=${a}}','a={x=${?a}}','a={x=3}\nb=${a.x}',
 'a=${missing} ${other}','a=${missing}${other}','a=[1] ${missing}','a={x=1} ${missing}',
 'a=${x}\nx=old\na={y=1}','a={x=1}\na=${a.x}\na={y=2}',
 'a=${missing}\nb=${a}','a=${missing}\nb=${a.x}','a=${missing}\nb=${?a}',
 'a=${missing}\nb=${?a.x}','a=${?missing}tail','a=before${?missing}',
 'a=${x}\na=${a}tail\nx=base','a=${?HOCON_DOCUMENT_LIST[]}','a=${HOCON_DOCUMENT_LIST[]}',
 'a=${missing}\na={x=1}\nb=${a.x}','a=${missing}\na={x={z=1}}\nb=${a.x.z}','a=1\na=${a}${missing}','a={x=${missing}}\na={y=2}\nb=${a.y}',
 'a=${HOCON_DOCUMENT_ENV}','a=null\nb=${a}','a=${?HOCON_DOCUMENT_ENV}',
 'a={include "part"}\nx=outer','include "part"','a=${"quoted.key"}\n"quoted.key"=5',
 'a=foo bar','a=[1] [2]','a={x=1} {y=2}',
 'a=${missing}\na={x=null}\nb=${a.x}','a=${missing}\na={x=[1]}\nb=${a.x}',
 'a=${missing}\na={x=[${other}]}\nb=${a.x}','a=${missing}\na={x=${other}}\nb=${a.x}',
 'a={x=${missing}}\nb=${a}\nc=${b.x}',
];
const probes=['a','a.x','a.x.z','a.known','b','c','x','missing','outer.a','outer.x','known','"quoted.key"'];
const external=['{}','missing=7\nother=8','missing={x=2}\nother={y=3}','missing=[2,3]\nother=[4]','missing=null\nother=9','x=9\na=2','missing=${other}\nother=7','missing=${a}\na=${missing}','a={x=8}\nx={z=9}','missing=prefix\nother=suffix'];
const requests=[];
const options={document:true,probes,includes:{part:'x=inner\ny=${x}'},systemEnvironment:true,environment:{HOCON_DOCUMENT_ENV:'value',HOCON_DOCUMENT_LIST_0:'one',HOCON_DOCUMENT_LIST_1:'two'}};
for(const source of sources){
 for(const steps of [[],[{op:'resolve'}],[{op:'resolve',allowUnresolved:true}],[{op:'resolve-with-self'}],
  [{op:'resolve',allowUnresolved:true},{op:'resolve',allowUnresolved:true}],
  [{op:'resolve',allowUnresolved:true},{op:'with-fallback',source:'missing=7\nother=8'},{op:'resolve'}],
  [{op:'with-value',path:'missing',value:7},{op:'with-value',path:'other',value:8},{op:'resolve'}],
  [{op:'without-path',path:'a'},{op:'resolve'}],
  [{op:'with-only-path',path:'a.x'},{op:'resolve',allowUnresolved:true}],
  [{op:'at-key',path:'outer'},{op:'resolve'}],
  [{op:'with-value',path:'known',valueSource:'${x}'},{op:'with-value',path:'x',value:11},{op:'resolve'}],
  [{op:'with-fallback',source:'known=${missing}'},{op:'with-value',path:'missing',value:11},{op:'resolve'}],
  [{op:'with-value',path:'a.x',value:2},{op:'resolve',allowUnresolved:true}],
  [{op:'without-path',path:'a.x'},{op:'resolve',allowUnresolved:true}],
  [{op:'with-key-value',path:'quoted.key',valueSource:'${x}'},{op:'with-value',path:'x',value:13},{op:'resolve',allowUnresolved:true}]
 ])requests.push({...options,source,steps});
 for(const other of external)for(const allowUnresolved of [false,true])requests.push({...options,source,steps:[{op:'resolve-with',source:other,allowUnresolved}]});
 for(const other of external.slice(0,5))requests.push({...options,source,steps:[{op:'resolve-with',source:other,allowUnresolved:true},{op:'resolve-with',source:'missing=9\nother=10\nx=11\na=12',allowUnresolved:true}]});
}
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/document-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const env={...process.env,...options.environment};for(const key of ['a','b','c','x','missing','other','gone'])delete env[key];
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',env,windowsHide:true,timeout:90000,maxBuffer:64*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/document-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=JSON.parse(inspect_json(JSON.stringify(requests[i]))),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index:i,request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Every lifecycle state: isResolved, resolved root values and required-value probes. Raw parse/edit/fallback, allowUnresolved, external/self resolution and staged continuation. Exact values/acceptance; error class/text/origin and unresolved rendering not compared.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/document-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} document lifecycle native cases agree`);
for(const failure of failures.slice(0,6))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
