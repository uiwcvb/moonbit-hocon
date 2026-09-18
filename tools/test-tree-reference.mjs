import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';

const requests=[];
const sources=['{}','a=1','a=null','a={b=1,c=2}\nx=3','a={b={c=1}}','a=[1,null,{b=2}]','"a.b"={""=1}\na={"x.y"=2}','a={}\nx=null','""={a=1}\n"1"=2\n"-"=3\n"é"=4\n"中"=5'];
const paths=['a','a.b','a.b.c','a.b.c.d','x','missing','"a.b"','a."x.y"','""','"".a','a.""','a..b','','"unclosed'];
for(const source of sources)for(const path of paths)for(const op of ['without-path','with-only-path','at-path','at-key','without-key','with-only-key'])requests.push({source,operations:[{op,path}]});
for(const source of sources.slice(0,7))for(const path of paths)for(const value of [null,9,{x:2},[],[1,null],'text'])for(const op of ['with-value','with-key-value'])requests.push({source,operations:[{op,path,value}]});
for(const source of sources)for(const fallback of sources)requests.push({source,operations:[{op:'with-fallback',source:fallback}]});
for(const source of sources)for(const getter of ['entries','empty','resolved'])requests.push({source,getter});
for(const source of sources)for(const path of paths)requests.push({source,path,getter:'has-or-null'});
for(const key of ['alpha','0','01','-','_','true','null','a b','a.b','a/b','a+b','a:b','a@b','é','中','😀','quote"','slash\\','\n',''])requests.push({source:JSON.stringify(key)+'=1',getter:'entries'});
const ranges=JSON.parse(fs.readFileSync(new URL('../evidence/path-characters.json',import.meta.url),'utf8')).ranges;
for(const cp of new Set(ranges.flatMap(([low,high])=>[low-1,low,high,high+1]).filter(n=>n>=0&&n<=65535&&!(n>=0xd800&&n<=0xdfff))))requests.push({source:JSON.stringify(String.fromCodePoint(cp))+'=1',getter:'entries'});
const values=['null','"null"','"NULL"','"foo"','"1"','1','1.5','true','false','{}','{x=1}','[]','[1]','[true]','[{}]','[null]','[1,true]','{0=1,2=2}','{0=true}','{a=1}'];
for(const expected of values)for(const actual of values)requests.push({source:'a='+actual,referenceSource:'a='+expected,getter:'validation'});
for(const reference of ['a={b=1,c=true}\nx=[]','a=null','a={}\nx=1','a=[{x=1}]','a=[[],{}]','a=[null,1]','a=["foo",1]'])for(const source of ['{}','a=1','a=null','a={b=false,c=1}','a=[{y=true}]','a=[[],[1]]','a=[true,{}]','a={0=1,1=true}'])for(const validationPaths of [[],['a'],['a.b'],['missing'],['a','a','x'],['a..x']])requests.push({source,referenceSource:reference,validationPaths,getter:'validation'});
for(const source of sources)for(const path of ['a','a.b','x','""','a..b'])requests.push({source,operations:[{op:'with-value',path,valueSource:'{nested=[1,null],exact=9223372036854775807}'},{op:'without-path',path:'a.b'},{op:'with-fallback',source:'a={b=3,c=4}\nx=5'},{op:'with-only-path',path:'a'}],getter:'entries'});
for(const source of ['{}','a=1','a=true','a={b=1}','a=null'])requests.push({source,checkValid:{source:'a=1\nb=true'}});
for(const source of ['[]','[1,2]'])for(const op of ['at-key','at-path','with-only-path','with-value'])requests.push({source,operations:[{op,path:'a',value:1}]});
function normalized(value){return Array.isArray(value)?value.map(p=>({path:p.path,kind:p.kind})).sort((a,b)=>JSON.stringify(a).localeCompare(JSON.stringify(b))):value;}
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/tree-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:32*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/tree-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const request=requests[i],actual=JSON.parse(inspect_json(JSON.stringify(request))),expected=references[i];
 let same=actual.accepted===expected.accepted;
 if(same&&actual.accepted)same=isDeepStrictEqual(request.getter==='validation'?normalized(actual.value):actual.value,request.getter==='validation'?normalized(expected.value):expected.value);
 if(same&&expected.problems)same=isDeepStrictEqual(normalized(actual.problems),normalized(expected.problems));
 if(!same)failures.push({request,actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Resolved tree edits, path/key distinction, entry set, emptiness and structural validation. Exact acceptance/output and sorted validation path/kind with duplicate multiplicity; diagnostic prose/origins/order not compared.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/tree-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} tree/validation native cases agree`);
for(const failure of failures.slice(0,12))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
