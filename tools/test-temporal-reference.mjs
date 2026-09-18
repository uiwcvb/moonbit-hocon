import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const requests=[];
const add=(value,getter,rest={})=>requests.push({source:'a='+value,getter,path:'a',...rest});
const units=['nanoseconds','microseconds','milliseconds','seconds','minutes','hours','days'];
for(const suffix of ['', 'd','day','days','w','week','weeks','m','mo','month','months','y','year','years','ms','s','h','minute','millis','D','Days','WEEK','mos','yr','P1D','é','μs']){
 for(const value of ['0','1','-1','+12','1.5','2147483647','-2147483648','2147483648','306783378','306783379']){
  for(const getter of ['period','temporal'])add(JSON.stringify(value+suffix),getter);
 }
}
const values=['0','-0','1','-1','1.5','-1.5','1e3','2147483647','9223372036854775807','-9223372036854775808','9223372036854775808','9.223372036854776e18','true','false','null','{}','[]','[1]'];
for(const value of [...values,...['','1','1.0','1e3','-0','NaN','Infinity','1ns','-1999ns','1999us','1.5s','-1.5s','1d','106752d','-106752d','9223372036854775807ms','-9223372036854775808ms','9223372036854775808ns','1w','1mo','1y','0x1.8p2 ms','  2 weeks  ','\t-12 months\n','１','𝟙','1_0'].map(JSON.stringify)]){
 for(const getter of ['period','temporal','milliseconds','nanoseconds'])add(value,getter);
 for(const unit of units){add(value,'duration-in',{unit});add('['+value+']','duration-list-in',{unit});}
 for(const getter of ['milliseconds-list','nanoseconds-list'])add('['+value+']',getter);
}
for(const unit of units){
 for(const value of ['[]','[1,1.5,-1.5,"1.5ms"]','[9223372036854775807,"9223372036854775807"]','[-9223372036854775808,"-9223372036854775808"]','["-1999ns","1999ns",-1999,1999]','{0=1,3="2s",ignored=true}','[1,null]','[1,true]','[1,{}]'])add(value,'duration-list-in',{unit});
}
const digits=JSON.parse(fs.readFileSync(new URL('../evidence/numeric-characters.json',import.meta.url),'utf8'));
for(const base of digits.starts){
 const encode=n=>String(n).replace(/[0-9]/g,d=>String.fromCodePoint(base+Number(d)));
 for(const value of ['12','-12','+2147483647','2147483648'])for(const getter of ['period','temporal'])add(JSON.stringify(encode(value)),getter);
 for(const getter of ['period','temporal'])add(JSON.stringify(encode('12')+'months'),getter);
}
for(const space of [' ','\t','\n','\r','\u000b','\u000c','\u001c','\u0085','\u00a0','\u1680','\u180e','\u2000','\u2007','\u200b','\u2028','\u202f','\u205f','\u3000','\ufeff']){
 for(const getter of ['period','temporal'])for(const value of [space+'2months'+space,'2'+space+'weeks'])add(JSON.stringify(value),getter);
}
for(const getter of ['period','temporal','duration-in','duration-list-in','milliseconds','nanoseconds','milliseconds-list','nanoseconds-list']){
 for(const source of ['{}','a=null','a=${missing}','a=${?missing}','a=${a}','a=${value}\nvalue="2mo"','a=[1]\na+=2'])requests.push({source,getter,path:'a',unit:'milliseconds'});
 for(const [source,rest] of [['include "base"\na=${value}',{includes:{base:'value="2weeks"'}}],['a=${value}',{fallbacks:['value=2s']}],['a=${value}',{environment:{value:'2years'}}]])requests.push({source,getter,path:'a',unit:'seconds',...rest});
 for(const path of ['nested.a','"quoted.key"'])requests.push({source:path+'="2months"',getter,path,unit:'hours'});
}
for(const [suffix,factor] of [['ns',1n],['us',1000n],['ms',1000000n],['s',1000000000n],['m',60000000000n],['h',3600000000000n],['d',86400000000000n]]){
 const edge=9223372036854775807n/factor;
 for(const n of [edge-1n,edge,edge+1n,-edge+1n,-edge,-edge-1n]){
  const value=JSON.stringify(n.toString()+suffix);
  add(value,'nanoseconds');add(value,'duration-in',{unit:'seconds'});add('['+value+']','duration-list-in',{unit:'milliseconds'});
 }
}
const golden=process.argv.includes('--golden');let references,reference;
if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/temporal-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;reference=saved.reference;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:90000,maxBuffer:64*1024*1024});
 assert.equal(run.status,0,run.stderr||String(run.error));references=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex'),digitClassificationJava:digits.java};
 fs.writeFileSync(new URL('../evidence/temporal-reference-vectors.json',import.meta.url),JSON.stringify({reference,requests,references},null,2)+'\n');
}
const failures=[];
for(let i=0;i<requests.length;i++){
 const actual=JSON.parse(inspect_json(JSON.stringify(requests[i]))),expected=references[i];
 if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({index:i,request:requests[i],actual,expected});
}
const report={utc:new Date().toISOString(),mode:golden?'saved independent native results':'live official library',reference,total:requests.length,passed:requests.length-failures.length,failed:failures.length,scope:'Period fields, TemporalAmount subtype/fields, seven TimeUnit scalar/list conversions and deprecated aliases; exact acceptance/value including overflow, truncation, Unicode and integration. Exact exception class, diagnostic text and origin not compared.',sourceHashes:sourceHashes(),failures};
fs.writeFileSync(new URL('../evidence/temporal-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`${report.passed}/${report.total} temporal native cases agree`);
for(const failure of failures.slice(0,12))console.log(JSON.stringify(failure));assert.equal(failures.length,0);
