import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {isDeepStrictEqual} from 'node:util';
import {createHash} from 'node:crypto';
import {loadFile} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const cases=[];
function add(source,files={},extra={}){cases.push({files:{'app/main.conf':source,...files},entry:'app/main.conf',...extra});}
add('include "base.conf"\nx=2',{'app/base.conf':'x=1\ny=${x}'});
add('include "sub/a.conf"\nx=3',{'app/sub/a.conf':'include "b.conf"','app/sub/b.conf':'y=${x}'});
add('nested {include "base.conf"}\nnested.x=4\nx=8',{'app/base.conf':'x=1\ny=${x}'});
add('include "base"',{'app/base.conf':'x=conf\nc=1','app/base.json':'{"x":"json","j":2}','app/base.properties':'x=properties\np=3'});
for(const kind of ['','required','file','required-file','classpath','required-classpath']){
 const expression=kind===''?'"base"':kind==='required'?'required("base")':kind==='required-file'?'required(file("base"))':kind==='required-classpath'?'required(classpath("base"))':`${kind}("base")`;
 add('include '+expression,{'app/base.conf':'x=relative','base.conf':'x=cwd','cp/base.conf':'x=classpath'}, {classpath:['cp']});
 add('include '+expression);
}
for(const ext of ['json','conf','properties','weird'])add(`include "base.${ext}"`,{['app/base.'+ext]:ext==='json'?' {"x":1,"a.b":"literal","r":"${missing}"} ':ext==='properties'?'x=1\nr=${missing}':'x=1'});
add('include "base"',{'app/base':'x=bare'});
add('include "base.weird"',{'app/base.weird.conf':'x=conf'});
add('include "base.json"',{'app/base.json':'x=1'});
add('include "base.json"',{'app/base.json':'[]'});
add('include "base.conf"',{'app/base.conf':'include "main.conf"'});
add('include "base.conf"',{'app/base.conf':'a=[1,,2]'});
add('include "base.conf"',{'cp/base.conf':'x=classpath'}, {classpath:['cp']});
add('include classpath("base")',{'cp/base.conf':'x=first\na=1','cp2/base.conf':'x=second\nb=2'}, {classpath:['cp','cp2']});
add('include classpath("sub/base.conf")',{'cp/sub/base.conf':'include "other.conf"','cp/sub/other.conf':'x=relative','cp/other.conf':'x=root'}, {classpath:['cp']});
add('include classpath("sub/base.conf")',{'cp/sub/base.conf':'include "/other.conf"','cp/other.conf':'x=root'}, {classpath:['cp']});
for(const content of [
 'a=1\na.b=2','a.b=2\na=1','a=one\na=two','a\\ b : hello  \nb=world',
 '!comment\n #comment\na value#literal!','a=one\\\n   two\nb=3','a=one\\\r\n\t two',
 'a=\\u4e2d\\u6587\nb=é😀','a=\\n\\t\\r\\f\\z\\\\','a=\\uBAD','a=\\uXXXX',
 '.a.=value\n=x','a\\.b=1\n"q"=quoted','__proto__.x=1\nconstructor.y=2','a=',
 'a=\nnext','a=one\\','a\\:b=escaped\na\\=b=equals','a=1\ra=2','a=hello\\\n#notcomment',
 ])add('include "base"',{'app/base.properties':content});
for(const [ext,content] of [['json','{"x":1,"a.b":2}'],['properties','x=1\na.b=2']])cases.push({files:{['root.'+ext]:content},entry:'root.'+ext});
add('x=${base}\ny=${ENV}',{'fallback/default.conf':'include "part.conf"','fallback/part.conf':'base=4'}, {fallbackFiles:['fallback/default.conf'],environment:{ENV:'yes'}});
add('a={hi=1}',{}, {fallbacks:['a=0','a={low=2}']});
add('a=${a}z',{}, {fallbacks:['a=${a}y','a=x']});
add('a={hi=1}',{}, {fallbacks:['a=${x}\nx=0','a={low=2}']});
add('include "@FILEURL@"',{'app/base.conf':'x=1'},{fileUrl:'app/base.conf'});
add('include url("@FILEURL@")',{'app/base.conf':'x=2'},{fileUrl:'app/base.conf'});
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-files-')), golden=process.argv.includes('--golden');
try {
 const requests=cases.map((test,i)=>{
  const folder=path.join(temp,String(i));fs.mkdirSync(folder);
  for(const [name,content] of Object.entries(test.files)){const full=path.join(folder,name);fs.mkdirSync(path.dirname(full),{recursive:true});fs.writeFileSync(full,content.replaceAll('@FILEURL@',test.fileUrl?pathToFileURL(path.join(folder,test.fileUrl)).href:'').replaceAll('file("base")',`file("${i}/base")`));}
  return {file:path.join(folder,test.entry),environment:test.environment,fallbacks:test.fallbacks,fallbackFiles:test.fallbackFiles?.map(f=>path.join(folder,f)),classpath:test.classpath?.map(f=>path.join(folder,f)),cwd:temp};
 });
 let references;
 if(golden){const saved=JSON.parse(fs.readFileSync(new URL('../evidence/file-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.cases,cases);references=saved.references;}
 else {
  const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
  const r=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('HoconOracle.java',import.meta.url))],{cwd:temp,input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:45000,maxBuffer:8*1024*1024});assert.equal(r.status,0,r.stderr||String(r.error));references=r.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
  fs.writeFileSync(new URL('../evidence/file-reference-vectors.json',import.meta.url),JSON.stringify({reference:path.basename(jar),cases,references},null,2)+'\n');
 }
 const failures=[];
 requests.forEach((request,i)=>{
  let actual;try{actual={accepted:true,value:loadFile(request.file,{...request,fallbackFiles:request.fallbackFiles})};}catch(e){actual={accepted:false,error:e.message};}
  const reference=references[i];if(actual.accepted!==reference.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,reference.value)))failures.push({case:cases[i],actual,reference});
 });
 const report={utc:new Date().toISOString(),mode:golden?'saved vectors':'live Lightbend Config',reference:process.env.HOCON_REFERENCE_JAR?path.basename(process.env.HOCON_REFERENCE_JAR):undefined,jarSha256:process.env.HOCON_REFERENCE_JAR?createHash('sha256').update(fs.readFileSync(process.env.HOCON_REFERENCE_JAR)).digest('hex'):undefined,total:cases.length,passed:cases.length-failures.length,failed:failures.length,failures};
 report.sourceHashes=sourceHashes();
 fs.writeFileSync(new URL(`../evidence/file-reference-${golden?'replay':'validation'}.json`,import.meta.url),JSON.stringify(report,null,2)+'\n');
 console.log(`${report.passed}/${report.total} file reference cases agree`);for(const fail of failures)console.log(JSON.stringify(fail));if(failures.length)process.exitCode=1;
} finally { fs.rmSync(temp,{recursive:true,force:true}); }
