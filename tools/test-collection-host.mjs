import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {load} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const cli=fileURLToPath(new URL('./cli.mjs',import.meta.url));
const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-collections-'));
const cases=[
 ['string-list','[1,true,"x"]',['1','true','x']],
 ['boolean-list','["on",false,"off"]',[true,false,false]],
 ['int-list','["1.9",-2.5]',[1,-2]],
 ['long-list','["9223372036854775807","-3.9"]',['9223372036854775807','-3']],
 ['double-list','["NaN","0x1p3"]',['NaN',8]],
 ['duration-list','[1.9,"1.9ms"]',['1000000','1900000']],
 ['bytes-list','["1.5 KiB",1024]',['1536','1024']],
 ['memory-list','["1e30"]',['1000000000000000000000000000000']],
 ['config','{"x.y"=1,nested={ok=true}}',{'x.y':1,nested:{ok:true}}],
 ['config-list','[{x=1},{x=null}]',[{x:1},{x:null}]],
];
let checks=0;
function invoke(args,input){return spawnSync(process.execPath,[cli,...args],{cwd:folder,input,encoding:'utf8',windowsHide:true,timeout:15000});}
try {
 for(const [kind,literal,expected] of cases){
  const source='nested {"a.b"='+literal+'}',key='nested."a.b"';
  assert.deepEqual(load(source,{getter:kind,path:key}),expected);checks++;
  for(const mode of ['input','stdin','file']){
   fs.writeFileSync(path.join(folder,'main.conf'),'include "values.conf"');fs.writeFileSync(path.join(folder,'values.conf'),source);
   const args=mode==='input'?['--input',source]:mode==='file'?['--file','main.conf']:[];
   const result=invoke([...args,'--get',key,'--type',kind],mode==='stdin'?source:undefined);
   assert.equal(result.status,0,result.stderr);assert.deepEqual(JSON.parse(result.stdout),expected);checks++;
  }
  for(const source of ['a=null','a=[null]','{}']){
   const result=invoke(['--input',source,'--get','a','--type',kind]);assert.equal(result.status,2,result.stdout+result.stderr);checks++;
  }
 }
 for(const kind of ['bytes-list','memory-list']){
  assert.equal(invoke(['--input','a=["0x1p3"]','--get','a','--type',kind]).status,2);checks++;
 }
 const report={utc:new Date().toISOString(),checks,passed:checks,failed:0,scope:'Actual Node load and CLI input/stdin/relative-include files; ten getters, quoted paths, values and error exit codes.',sourceHashes:sourceHashes()};
 fs.writeFileSync(new URL('../evidence/collection-host.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
 console.log(`${checks} collection host/CLI checks passed`);
} finally {fs.rmSync(folder,{recursive:true,force:true});}
