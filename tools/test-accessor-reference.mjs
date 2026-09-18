import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const enumChoices=['RED','GREEN','BLUE','on','yes','NaN','Infinity','蓝色','Α','_foo','$dollar'];
const getters=['number','number-list','object','object-list','any-ref','any-ref-list','enum','enum-list'];
const values=['0','-0','1','-1','2147483647','2147483648','-2147483649','9223372036854775807','-9223372036854775808','9007199254740993','1.0','1.5','-0.0','1e3','1e-3','true','false','null','{}','{x=1,n=null}','[]','[null]','[1,"2",3.5]','[{a=1},{b=null}]','[1,{}]','{0=1,2="2"}','{a=1}','RED','red','on','[RED,GREEN,蓝色]','[RED,red]','[1,null]'];
const strings=['0','1','+1','-0','01','2147483647','2147483648','9223372036854775807','9223372036854775808','-9223372036854775809','1.0','1.5','-0.0','1e3','1e-400','1e400','NaN','+NaN','-NaN','Infinity','-Infinity','0x1.8p2','0x1p-1074','1d','1F',' 1 ','\t1\n','','-','+','1_0','１２','١٢','²','𝟙','1.٢','null','yes','蓝色','Α','$dollar'];
const requests=[];
const add=(source,getter,path='a',rest={})=>requests.push({source,getter,path,...(getter.startsWith('enum')?{enumChoices}:{}),...rest});
for(const value of [...values,...strings.map(JSON.stringify)])for(const getter of getters)for(const key of ['a','nested.a','"quoted.key"'])add(key+'='+value,getter,key);
for(const value of [...values,...strings.map(JSON.stringify)])for(const getter of ['number-list','object-list','any-ref-list','enum-list'])for(const list of [`[${value}]`,`[${value},${value}]`,`{0=${value},2=${value},ignored=true}`])add('a='+list,getter);
for(const getter of getters)for(const source of ['{}','a=null','a={x=1}\nb=${a}','x=RED\na=${x}','a=${missing}','a=${?missing}','a=${a}','a=[1]\na+=2','a=${x}\nx=[1,"2"]','a=${x}\nx={y=1}','a=[RED] [GREEN]','a={x=1} {y=2}'])add(source,getter);
for(const value of ['9223372036854775808','-9223372036854775809','9223372036854775809','9.223372036854776e18','1e400','-1e400','1e-400','2.2250738585072014e-308','4.9406564584124654e-324'])for(const getter of ['number','number-list'])add('a='+(getter.endsWith('list')?'['+value+']':value),getter);
const digits=JSON.parse(fs.readFileSync(new URL('../evidence/numeric-characters.json',import.meta.url),'utf8'));
for(const value of ['9223372036854775808','-9223372036854775809','999999999999999999999999999','9223372036854775807','-9223372036854775808','1.0','-0.0','9.223372036854776e18','[9223372036854775808]','{"nested":9223372036854775808}'])for(const getter of ['number','number-list','any-ref','any-ref-list','object']){
 add('a='+value,getter);
 add('{"a":'+value+'}',getter,'a',{format:'json'});
}
for(const base of digits.starts){
 const encode=n=>String(n).replace(/[0-9]/g,d=>String.fromCodePoint(base+Number(d)));
 for(const value of ['0','1','-12','+12','2147483647','2147483648','9223372036854775807','-9223372036854775808','9223372036854775808'])add('a='+JSON.stringify(encode(value)),'number');
 for(const getter of ['number-list','any-ref-list','long-list','double-list'])add('a={"'+encode(1)+'"="'+encode(7)+'","'+encode(0)+'"="'+encode(8)+'",other=false}',getter);
 for(const source of ['a={"1"=10,"'+encode(1)+'"=20}','a={"'+encode(1)+'"=20,"1"=10}','a={"+'+encode(1)+'"=30,"01"=40,"1"=10}'])add(source,'number-list');
 for(const cp of [base-1,base+10])add('a='+JSON.stringify(String.fromCodePoint(cp)),'number');
}
for(const getter of ['number','number-list','enum','enum-list','object','object-list']){
 add('include "base"\na=${chosen}',getter,'a',{includes:{base:'chosen=[RED,GREEN]'}});
 add('a=${chosen}',getter,'a',{fallbacks:['chosen={x=1}']});
 add('a=${chosen}',getter,'a',{environment:{chosen:'RED'}});
}
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/accessor-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:64*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex'),digitClassificationJava:digits.java};
 fs.writeFileSync(new URL('../evidence/accessor-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=JSON.parse(inspect_json(JSON.stringify(requests[i]))),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index:i,request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Number subtype and exact integer/IEEE-754 bits, object/any/enum getters and lists, scalar conversion and indexed objects including every JDK BMP digit block. Exact acceptance/value; diagnostics, Java reflection identity and unresolved ConfigObject containers not compared.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/accessor-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} extended accessor native cases agree`);
for(const failure of failures.slice(0,8))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
