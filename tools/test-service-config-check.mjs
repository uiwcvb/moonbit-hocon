import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import http from 'node:http';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {previewTransitionFiles} from './change-review.mjs';
import {checkReviewedServiceConfig,startReviewedService} from '../examples/reviewed-service.mjs';

const root=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-service-check-'));
const example=fileURLToPath(new URL('../examples/preview-bound-service.mjs',import.meta.url));
const beforeValue='private-before-service-check',afterValue='private-after-service-check';
const names=[];
function check(name,fn){fn();names.push(name);}
async function checkAsync(name,fn){await fn();names.push(name);}
function fixture(name,{port='0',message=JSON.stringify(afterValue),missingPort=false,emptyPolicy=false}={}){
  const dir=path.join(root,name);fs.mkdirSync(dir);
  const before=path.join(dir,'before.conf'),after=path.join(dir,'after.conf'),part=path.join(dir,'part.conf'),policy=path.join(dir,'transitions.json');
  fs.writeFileSync(before,'service.port=0\nservice.message='+JSON.stringify(beforeValue)+'\n');
  fs.writeFileSync(after,'include "part.conf"\n'+(missingPort?'':'service.port='+port+'\n'));
  fs.writeFileSync(part,'service.message='+message+'\n');
  const transitions=[{path:['service','message'],beforeSource:JSON.stringify(beforeValue),afterSource:message}];
  if(missingPort||port!=='0')transitions.push({path:['service','port'],beforeSource:'0',...(missingPort?{}:{afterSource:port})});
  const plan=emptyPolicy?[]:transitions;fs.writeFileSync(policy,JSON.stringify(plan));
  return {spec:{before:{file:before},after:{file:after},transitions:plan},args:['--before',before,'--after',after,'--transition-policy',policy],policy};
}
function run(args){const child=spawnSync(process.execPath,[example,...args],{encoding:'utf8',cwd:root,windowsHide:true,timeout:20000});assert(!child.error,child.error?.message);assert.equal(child.signal,null);return child;}
function noValues(report){const text=JSON.stringify(report);for(const value of [beforeValue,afterValue])assert(!text.includes(value),'report exposed a service value');}
function withoutListen(fn){const original=http.Server.prototype.listen;let calls=0;http.Server.prototype.listen=function(...args){calls++;return original.apply(this,args)};try{const value=fn();assert.equal(calls,0);return value}finally{http.Server.prototype.listen=original}}
function invalid(spec,name){withoutListen(()=>assert.throws(()=>checkReviewedServiceConfig(spec),error=>error.name===name));}
try{
  const valid=fixture('valid');let checked,cliReport;
  check('library check validates the demo fields without listening or exposing values',()=>{
    checked=withoutListen(()=>checkReviewedServiceConfig(valid.spec));assert(checked.accepted);assert.equal(checked.serviceConfigChecked,true);noValues(checked);
    const {serviceConfigChecked,...base}=checked;assert.deepEqual(base,previewTransitionFiles(valid.spec));
  });
  check('custom CLI check matches the library receipt',()=>{
    const child=run(['--check',...valid.args]);assert.equal(child.status,0,child.stderr);assert.equal(child.stderr,'');cliReport=JSON.parse(child.stdout);assert.deepEqual(cliReport,checked);assert.equal(cliReport.response,undefined);noValues(cliReport);
  });
  await checkAsync('checked CLI receipt activates an independently fetched actual HTTP response',async()=>{
    const active=await startReviewedService({...valid.spec,expectedPreviewHash:cliReport.previewHash});
    try{const response=await fetch(active.url);assert.equal(response.status,200);assert.equal(await response.text(),afterValue);assert.equal(active.report.previewHash,checked.previewHash);assert.equal(active.report.serviceConfigChecked,undefined);}
    finally{await new Promise((resolve,reject)=>{active.server.close(error=>error?reject(error):resolve());active.server.closeAllConnections();});}
    assert.equal(active.server.address(),null);
  });
  check('bundled check mode returns a checked receipt without HTTP output',()=>{
    const child=run(['--check']);assert.equal(child.status,0,child.stderr);assert.equal(child.stderr,'');const report=JSON.parse(child.stdout);assert(report.accepted);assert.equal(report.serviceConfigChecked,true);assert.equal(report.response,undefined);
  });
  const low=fixture('low-port',{port:'-1'}),high=fixture('high-port',{port:'65536'});
  check('negative demo port fails during check before listening',()=>invalid(low.spec,'RangeError'));
  check('demo port above65535 fails in library and CLI check',()=>{
    invalid(high.spec,'RangeError');const child=run(['--check',...high.args]);assert.equal(child.status,1);assert.equal(child.stdout,'');assert(child.stderr.includes('Invalid service port'));
  });
  check('null demo message is an application check error',()=>invalid(fixture('null-message',{message:'null'}).spec,'ConfigError'));
  check('missing demo port is an application check error',()=>invalid(fixture('missing-port',{missingPort:true}).spec,'ConfigError'));
  check('existing numeric-string getter conversion remains accepted',()=>{
    const converted=fixture('converted-port',{port:'"0"'});const report=withoutListen(()=>checkReviewedServiceConfig(converted.spec));assert(report.accepted);assert.equal(report.serviceConfigChecked,true);
  });
  check('policy rejection is reported before reading unusable application fields',()=>{
    const rejected=fixture('policy-first',{message:'null',emptyPolicy:true});const report=withoutListen(()=>checkReviewedServiceConfig(rejected.spec));assert(!report.accepted);assert.equal(report.serviceConfigChecked,false);assert.match(report.previewHash,/^[0-9a-f]{64}$/);noValues(report);
    const child=run(['--check',...rejected.args]);assert.equal(child.status,2);assert.equal(child.stderr,'');assert.deepEqual(JSON.parse(child.stdout),report);
  });
  check('malformed policy keeps the safe diagnostic in check mode',()=>{
    const bad=fixture('bad-policy'),marker='private-json-check-marker';fs.writeFileSync(bad.policy,'[{"afterSource":"'+marker+'",}]');
    const child=run(['--check',...bad.args]);assert.equal(child.status,1);assert.equal(child.stdout,'');assert(child.stderr.includes('Policy must contain valid JSON'));assert(!child.stderr.includes(marker));
  });
  check('partial custom check never mixes in bundled files',()=>{
    const child=run(['--check','--before',valid.spec.before.file,'--transition-policy',valid.policy]);assert.equal(child.status,1);assert.equal(child.stdout,'');assert(child.stderr.includes('Custom inputs require'));
  });
  check('check mode requires value-bound transitions',()=>{
    const child=run(['--check','--before',valid.spec.before.file,'--after',valid.spec.after.file,'--policy',valid.policy]);assert.equal(child.status,1);assert.equal(child.stdout,'');assert(child.stderr.includes('Custom inputs require'));
  });
  check('ordinary preview retains legal migration behavior and its old report shape',()=>{
    const child=run(['--preview',...high.args]);assert.equal(child.status,0,child.stderr);const report=JSON.parse(child.stdout);assert(report.accepted);assert.equal(report.serviceConfigChecked,undefined);noValues(report);
  });
  console.log(JSON.stringify({checks:names.length,passed:names.length,failed:0,names}));
}finally{
  const owned=path.resolve(root);assert.equal(path.dirname(owned),path.resolve(os.tmpdir()));assert(path.basename(owned).startsWith('hocon-service-check-'));
  fs.rmSync(owned,{recursive:true,force:true});
}
