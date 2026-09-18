import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {Config} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const read=name=>JSON.parse(fs.readFileSync(new URL('../evidence/'+name+'-reference-vectors.json',import.meta.url),'utf8'));
const requests=['collection','accessor','temporal'].flatMap(name=>read(name).requests);
for(const number of ['-0.0','-0','0.0','1.00','1e-300','1e100','9007199254740993','9223372036854775807','-1e-999','-1e-300'])for(const prefix of ['','a=','a=['])requests.push({source:prefix===''?'a={n='+number+'}':prefix+number+(prefix.endsWith('[')?']':'')});
const golden=process.argv.includes('--golden');let reference,references;
if(golden){const saved=read('native-read');assert.deepEqual(saved.requests,requests);({reference,references}=saved);}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:96*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));const lines=run.stdout.trim().split(/\r?\n/);references=lines.map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex')};
 fs.writeFileSync(new URL('../evidence/native-read-reference-vectors.json',import.meta.url),'{\n"reference":'+JSON.stringify(reference)+',\n"requests":'+JSON.stringify(requests,null,2)+',\n"references":[\n'+lines.join(',\n')+'\n]}\n');
}
const failures=[];
for(let index=0;index<requests.length;index++){
 const {source,getter,path,enumChoices,unit,...options}=requests[index];let actual;
 try{const config=Config.load(source,options);actual={accepted:true,value:getter===undefined?config.toJSON():config.get(path,{type:getter,...(enumChoices===undefined?{}:{enumChoices}),...(unit===undefined?{}:{unit})})};}catch{actual={accepted:false};}
 const expected=references[index];if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index,request:requests[index],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'7033 existing collection/accessor/temporal requests rerun through actual Config.get with live native results, plus 30 root JSON numeric cases including negative zero and underflow. Overlaps earlier native suites; not 7063 newly unique cases. Native lines preserve negative zero.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/native-read-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} direct-result native cases agree`);for(const failure of failures.slice(0,12))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
