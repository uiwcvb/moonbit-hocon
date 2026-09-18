import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {isDeepStrictEqual} from 'node:util';
import {createHash} from 'node:crypto';
import {load,loadURL} from './config.mjs';
import {sourceHashes} from './evidence.mjs';

const fixtures={
 '/base.conf':{body:'x=1\ny=${x}'},
 '/typed.json':{body:'{"a.b":1,"literal":"${missing}"}'},
 '/props.properties':{body:'a.b=text\nx=one'},
 '/ct-json.conf':{headers:{'Content-Type':'application/json'},body:'{"a.b":1,"literal":"${missing}"}'},
 '/ct-props.conf':{headers:{'Content-Type':'text/x-java-properties; charset=UTF-8'},body:'a.b=text\nx=1'},
 '/ct-hocon.json':{headers:{'Content-Type':'application/hocon'},body:'x=1\ny=${x}'},
 '/ct-unknown.json':{headers:{'Content-Type':'text/plain'},body:'x=1'},
 '/ct-case.conf':{headers:{'Content-Type':'Application/JSON'},body:'{"literal":"${missing}"}'},
 '/charset.conf':{headers:{'Content-Type':'application/json;charset=UTF-16'},body:'{"text":"中文😀"}'},
 '/ct-space.json':{headers:{'Content-Type':'application/hocon ; charset=UTF-8'},body:'x=1'},
 '/ct-prototype.conf':{headers:{'Content-Type':'constructor'},body:'x=1'},
 '/ct-prototype2.conf':{headers:{'Content-Type':'__proto__'},body:'x=1'},
 '/ct-prototype3.conf':{headers:{'Content-Type':'toString'},body:'x=1'},
 '/empty.json':{body:''},
 '/bom.json':{body:'\ufeff{"x":1}'},
 '/duplicate.json':{body:'{"x":1,"x":2}'},
 '/nested-duplicate.json':{body:'{"n":{"x":1,"\\u0078":2}}'},
 '/dir/main.conf':{body:'include "child.conf"\nx=2'},
 '/dir/child.conf':{body:'x=1\ny=${x}'},
 '/dir/basename.conf':{body:'include "part"'},
 '/dir/part.conf':{body:'x=conf\nc=1'},
 '/dir/part.json':{body:'{"x":"json","j":2}'},
 '/dir/part.properties':{body:'x=props\np=3'},
 '/dir/json.conf':{body:'include "part.json"'},
 '/dir/root.conf':{body:'include "/root.conf"'},
 '/root.conf':{body:'root=1'},
 '/dir/query.conf':{body:'include "part.conf?q=1"'},
 '/dir/part.conf?q=1.conf':{body:'query=conf'},
 '/dir/part.conf?q=1.json':{body:'{"query":"json"}'},
 '/dir/part.conf?q=1.properties':{body:'query=props'},
 '/red/origin.conf':{status:302,headers:{Location:'/new/target.conf'}},
 '/new/target.conf':{body:'include "child.conf"'},
 '/red/child.conf':{body:'origin=requested'},
 '/new/child.conf':{body:'origin=redirected'},
 '/redirect-loop.conf':{status:302,headers:{Location:'/redirect-loop.conf'}},
 '/cross.conf':{status:302,headers:{Location:'@HTTPS@/base.conf'},body:'redirectBody=1'},
 '/bad.conf':{body:'x=[1,,2]'},
 '/array.json':{body:'[1,2]'},
 '/cycle-a.conf':{body:'include "cycle-b.conf"'},
 '/cycle-b.conf':{body:'include "cycle-a.conf"'},
 '/drop.conf':{drop:true},
 '/hang.conf':{hang:true},
 '/chunked.conf':{body:'x=1\ny=2',chunked:true},
 '/accept.conf':{echoAccept:true,headers:{'Content-Type':'application/json'}},
 '/accept.json':{echoAccept:true,headers:{'Content-Type':'application/json'}},
 '/accept.properties':{echoAccept:true,headers:{'Content-Type':'application/json'}},
 '/ordering/main.conf':{body:'include "part"'},
 '/ordering/part.conf':{body:'order=@SEQUENCE@',sequenceGroup:'order'},
 '/ordering/part.json':{body:'{"order":@SEQUENCE@}',sequenceGroup:'order'},
 '/ordering/part.properties':{body:'order=@SEQUENCE@',sequenceGroup:'order'},
};
for(const status of [200,201,204,300,301,302,303,304,305,306,307,308,400,401,403,404,410,429,500,503])fixtures['/status/'+status+'.conf']={status,body:status===204||status===304?'':'x=1'};
for(const status of [300,301,302,303,304,305,306,307,308])fixtures['/redirect/'+status+'.conf']={status,headers:{Location:'/base.conf'},body:status===304?'':'redirectBody=1'};
for(const length of [1,19,20,21])for(let i=0;i<length;i++)fixtures[`/chain/${length}/${i}.conf`]={status:302,headers:{Location:i===length-1?'/base.conf':`/chain/${length}/${i+1}.conf`}};
const cases=[];
for(const scheme of ['@HTTP@','@HTTPS@'])for(const name of ['/base.conf','/typed.json','/props.properties','/ct-json.conf','/ct-props.conf','/ct-hocon.json','/ct-unknown.json','/ct-case.conf','/charset.conf','/ct-space.json','/dir/main.conf','/dir/basename.conf','/dir/json.conf','/dir/query.conf','/red/origin.conf','/bad.conf','/array.json','/chunked.conf','/accept.conf','/accept.json','/accept.properties'])cases.push({url:scheme+name});
for(const path of ['/base.conf','/typed.json','/props.properties','/ct-json.conf','/dir/main.conf','/dir/basename.conf','/bad.conf','/array.json','/cycle-a.conf','/missing.conf','/drop.conf','/hang.conf'])for(const required of [false,true])cases.push({source:'nested {include '+(required?'required(':'')+'url("@HTTP@'+path+'")'+(required?')':'')+'}\nx=9'});
for(const code of [200,201,204,300,301,302,303,304,305,306,307,308,400,401,403,404,410,429,500,503])for(const required of [false,true])cases.push({source:'include '+(required?'required(':'')+'url("@HTTP@/status/'+code+'.conf")'+(required?')':'')});
for(const code of [300,301,302,303,304,305,306,307,308])cases.push({url:'@HTTP@/redirect/'+code+'.conf'});
cases.push({url:'@HTTP@/redirect-loop.conf'},{url:'@HTTP@/cross.conf'},{source:'include "@HTTP@/base.conf"\nx=7'},{url:'@HTTP@/base.conf',fallbacks:['x=3\nz=4']},{source:'x=7',fallbackURLs:['@HTTP@/base.conf']});
for(const length of [1,19,20,21])cases.push({url:`@HTTP@/chain/${length}/0.conf`});
cases.push({source:'[]'},{source:'{}',fallbacks:['[]']},{source:'{}',fallbackURLs:['@HTTP@/array.json']},{url:'@HTTP@/array.json',getter:'has',path:'x'});
for(const name of ['/ct-prototype.conf','/ct-prototype2.conf','/ct-prototype3.conf','/dir/root.conf'])cases.push({url:'@HTTP@'+name});
for(const name of ['/empty.json','/bom.json','/duplicate.json','/nested-duplicate.json'])cases.push({url:'@HTTP@'+name});
cases.push({url:'@HTTP@/ordering/main.conf'},{url:'@HTTPS@/ordering/main.conf'});
for(const [i,space] of ['\ufeff','\u00a0','\u2000','\u3000','\v','\f'].entries())for(const [j,body] of [space+'{"x":1}','{"x"'+space+':1}', '{"x":"'+space+'"}'].entries()){
 const name=`/json-space-${i}-${j}.json`;fixtures[name]={body};cases.push({url:'@HTTP@'+name});
}
const golden=process.argv.includes('--golden'),temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-http-reference-'));
let server;
try{
 const fixtureFile=path.join(temp,'fixtures.json');fs.writeFileSync(fixtureFile,JSON.stringify(fixtures));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtureFile],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);
 const readyTimer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed to start: '+errors);})]);clearTimeout(readyTimer);assert(addresses.http&&addresses.https,errors);
 const expand=value=>JSON.parse(JSON.stringify(value).replaceAll('@HTTP@',addresses.http).replaceAll('@HTTPS@',addresses.https));
 const requests=cases.map(expand);
 let references,reference;
 if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/http-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.cases,cases);assert.deepEqual(saved.fixtures,fixtures);references=saved.references;reference=saved.reference;}
 else{
  const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
  const trust=path.join(temp,'trust.p12');
  const keytool=spawnSync(process.env.KEYTOOL??'keytool',['-importcert','-noprompt','-alias','local-test','-file',fileURLToPath(new URL('./fixtures/http-cert.pem',import.meta.url)),'-keystore',trust,'-storetype','PKCS12','-storepass','local-test-only'],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(keytool.status,0,keytool.stderr||String(keytool.error));
  const java=spawnSync(process.env.JAVA??'java',['-Djavax.net.ssl.trustStore='+trust,'-Djavax.net.ssl.trustStorePassword=local-test-only','-Dsun.net.client.defaultConnectTimeout=1000','-Dsun.net.client.defaultReadTimeout=1000','-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:60000,maxBuffer:16*1024*1024});assert.equal(java.status,0,java.stderr||String(java.error));
  references=java.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
  reference={library:'unmodified Lightbend Config 1.4.9',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex'),javaTimeoutMs:1000,platform:process.platform,customTrust:'test-only self-signed fixture certificate'};
  fs.writeFileSync(new URL('../evidence/http-reference-vectors.json',import.meta.url),JSON.stringify({reference,cases,fixtures,references},null,2)+'\n');
 }
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8'),failures=[],skipped=[];
 for(let i=0;i<requests.length;i++){
  const request=requests[i];let actual;
  if(golden&&reference.platform!==process.platform&&cases[i].url==='@HTTP@/dir/root.conf'){skipped.push({case:cases[i],reason:'Java absolute path handling is platform-dependent; this saved native result is from '+reference.platform});continue;}
  try{const options={...request,network:{ca,timeoutMs:1000}};actual={accepted:true,value:request.url?loadURL(request.url,options):load(request.source,options)};}catch(error){actual={accepted:false,error:error.message};}
  const expected=references[i];
  if(actual.accepted!==expected.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,expected.value)))failures.push({case:cases[i],actual,expected});
 }
 const report={utc:new Date().toISOString(),mode:golden?'saved official vectors with live HTTP/HTTPS fixtures':'live official library and live HTTP/HTTPS fixtures',reference,total:cases.length,passed:cases.length-failures.length-skipped.length,failed:failures.length,skipped,scope:'Exact resolved JSON and acceptance; custom trusted HTTPS, status/missing/error handling, content type/extension/Accept, relative includes, basename search, redirects, cycles, timeouts and chunked bodies. Error wording not compared.',sourceHashes:sourceHashes(),failures};
 fs.writeFileSync(new URL('../evidence/http-reference-'+(golden?'replay':'validation')+'.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
 console.log(`${report.passed}/${report.total} live-transport HTTP reference cases agree`);
 for(const failure of failures)console.log(JSON.stringify(failure));assert.equal(failures.length,0);
}finally{
 if(server&&server.exitCode===null){const exited=once(server,'exit');if(server.connected)server.send('stop');const timer=setTimeout(()=>server.kill(),2000);await exited;clearTimeout(timer);}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
