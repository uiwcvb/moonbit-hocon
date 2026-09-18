import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const getters=['string-list','boolean-list','int-list','long-list','double-list','duration-list','bytes-list','memory-list','config-list','config'];
const literals=['[]','[null]','[1,true,false]','["1","2.5"]','[2147483648,-2147483649]','["2147483648"]','[9223372036854775807]','["9223372036854775807"]','["NaN","Infinity","-Infinity"]','["yes","off"]','[1.5,-1.5]','["1.5ms","2s"]','["1 KiB","2 GB"]','[{x=1},{x=null}]','{0=a,2=b,foo=c}','{0={x=1},2={x=2}}','{}','null','1','"x"',
 '["on","false"]','["TRUE"]','[" 1 ","0x1p3"]','["1e309"]','["9223372036854775808","-9223372036854775809"]','[-0.5,0,1e3]','[[],{}]','[[1,2]]','[true,false,null]','{2=c,0=a,1=b}','{"01"=a,"1"=b,"0001"=c}','{"+1"=a,"1"=b,"-1"=c}','{9999999999=a,0=b}','{"0"=null,2=a}','["0.001ns","-0.001ns"]','["1e30 bytes"]','["-1 byte"]','["1.5 KiB"]','[{"a.b"=1},{a={b=2}}]','[${?MISSING}]'];
const requests=[];
for(const getter of getters)for(const value of literals)requests.push({source:'a='+value,getter,path:'a'});
for(const getter of getters)for(const source of ['{}','a={"x.y"=[1,2]}','a={"x.y"=[{b=1}]}','a={"x.y"=null}'])requests.push({source,getter,path:'a."x.y"'});
for(const getter of getters)for(const values of [['1','"2"'],['true','"off"'],['null','1'],['{x=1}','{x=2}'],['"1s"','"2ms"'],['"1KiB"','"2MB"']])for(const reverse of [false,true])requests.push({source:'a=['+(reverse?[...values].reverse():values).join(',')+']',getter,path:'a'});
// Independently authored boundary matrix, always expected from the upstream JAR.
for(const getter of getters)for(const value of ['[1.999,-1.999]','[9223372036854775807]','[-9223372036854775808]','[1e30]','["1e30"]','["1e30 ms"]','["1e30 bytes"]','["-0.9"]','["-0.9 bytes"]','["0x1p3"]','["NaN"]','["Infinity"]','["1d"]','[".5"]','["1."]','["1e-3"]','["+1"]','[" 1 "]','["1 KiB",1024]','[0,"-0"]'])requests.push({source:'a='+value,getter,path:'a'});
for(const index of [0,1,2,15,16,99])for(const padding of [0,8,9,12,13,24,25,48,49])for(const reverse of [false,true]){
 const aliases=[String(index),'0'+index,'00'+index,'+'+index];if(reverse)aliases.reverse();
 const fields=aliases.map((key,i)=>JSON.stringify(key)+'='+JSON.stringify('v'+i));
 for(let i=0;i<padding;i++)fields.splice(i%(fields.length+1),0,JSON.stringify('padding'+i)+'=ignored');
 const object='{'+fields.join(',')+'}';
 for(const request of [{source:'a='+object},{source:'base='+object+'\na=${base}'},{source:'a='+object+'\na.x=added'},{source:'a={"'+index+'"=primary}',fallbacks:['a='+object]},{source:'a='+object+'\na.x=${?MISSING}'}])requests.push({...request,getter:'string-list',path:'a'});
}
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/collection-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR to the pinned unmodified Config 1.4.9 jar');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',timeout:60000,windowsHide:true,maxBuffer:16*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex'),unmodified:true};
 fs.writeFileSync(new URL('../evidence/collection-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=JSON.parse(inspect_json(JSON.stringify(requests[i]))),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent results':'live pinned official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,sourceHashes:sourceHashes(),engineSha256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Ten typed-list/config getters; exact JSON values and acceptance, not error wording. Config/long/unit values follow the documented JSON bridge representation.',failures};
fs.writeFileSync(new URL('../evidence/collection-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} typed collection/config cases agree`);
for(const failure of failures.slice(0,30))console.log(JSON.stringify(failure));
assert.equal(failures.length,0);
