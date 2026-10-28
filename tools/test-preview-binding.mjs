import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import http from 'node:http';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {isDeepStrictEqual} from 'node:util';
import {parseChangePolicy,reviewFiles,previewTransitionFiles} from './change-review.mjs';
import {startReviewedService} from '../examples/reviewed-service.mjs';
const root=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-preview-'));
const names=[];
const beforeValue='private-before-preview',afterValue='private-after-preview',changedValue='private-revised-preview';
function check(name,fn){fn();names.push(name);}
async function checkAsync(name,fn){await fn();names.push(name);}
function noValues(report){const text=JSON.stringify(report);for(const value of [beforeValue,afterValue,changedValue])assert(!text.includes(value),'value appeared in preview or diagnostic');}
function fixture(name){
 const dir=path.join(root,name);fs.mkdirSync(dir);
 const before=path.join(dir,'before.conf'),after=path.join(dir,'after.conf'),part=path.join(dir,'part.conf');
 fs.writeFileSync(before,`service.port=0\nservice.message=${JSON.stringify(beforeValue)}\nservice.copy=${'${service.message}'}`);
 fs.writeFileSync(after,'include "part.conf"\nservice.port=0\nservice.copy=${service.message}');fs.writeFileSync(part,'service.message='+JSON.stringify(afterValue));
 const transitions=['message','copy'].map(key=>({path:['service',key],beforeSource:JSON.stringify(beforeValue),afterSource:JSON.stringify(afterValue)}));
 return{dir,before,after,part,spec:{before:{file:before},after:{file:after},transitions}};
}
async function activate(spec,expectedPreviewHash){
 const active=await startReviewedService({...spec,...(expectedPreviewHash===undefined?{}:{expectedPreviewHash})});
 try{const response=await fetch(active.url);return{status:response.status,body:await response.text(),report:active.report}}
 finally{await new Promise((resolve,reject)=>{active.server.close(e=>e?reject(e):resolve());active.server.closeAllConnections()})}
}
async function rejectedBeforeListen(spec,hash,name){
 const original=http.Server.prototype.listen;let opened=0;http.Server.prototype.listen=function(...args){opened++;return original.apply(this,args)};
 try{await assert.rejects(startReviewedService({...spec,expectedPreviewHash:hash}),error=>{assert.equal(error.name,name);if(error.report){assert(!error.report.accepted);noValues(error.report)}return true});assert.equal(opened,0)}finally{http.Server.prototype.listen=original}
}
const cli=fileURLToPath(new URL('./change-review.mjs',import.meta.url));
function invoke(spec,policy,extra=[]){return spawnSync(process.execPath,[cli,'--before',spec.before.file,'--after',spec.after.file,'--transition-policy',policy,...extra],{encoding:'utf8',windowsHide:true,timeout:20000});}
try{
 const a=fixture('stable');let first;
 check('default review shape remains unchanged',()=>{const report=reviewFiles(a.spec);assert(report.accepted);assert.equal(report.previewHash,undefined);assert.equal(report.previewInputs,undefined)});
 check('optional preview preserves review and discloses no values',()=>{first=previewTransitionFiles(a.spec);assert(first.accepted);assert.match(first.previewHash,/^[0-9a-f]{64}$/);assert.match(first.engineSHA256,/^[0-9a-f]{64}$/);assert.equal(first.previewVersion,'hocon-transition-preview-v1');assert.deepEqual(first.changes,reviewFiles(a.spec).changes);noValues(first)});
 check('same inputs are stable across repeated previews',()=>assert.equal(previewTransitionFiles(a.spec).previewHash,first.previewHash));
 check('JSON whitespace and policy object-key order do not change the fingerprint',()=>{const reordered=a.spec.transitions.map(r=>({afterSource:r.afterSource,beforeSource:r.beforeSource,path:r.path}));const parsed=parseChangePolicy(JSON.stringify(reordered,null,4));assert.equal(previewTransitionFiles({...a.spec,transitions:parsed}).previewHash,first.previewHash)});
 check('mtime alone does not change a content-bound preview',()=>{const time=new Date(Date.now()-5000);fs.utimesSync(a.part,time,time);assert.equal(previewTransitionFiles(a.spec).previewHash,first.previewHash)});
 await checkAsync('matching uppercase hash activates the approved HTTP value',async()=>{const actual=await activate(a.spec,first.previewHash.toUpperCase());assert.equal(actual.status,200);assert.equal(actual.body,afterValue);assert.equal(actual.report.previewHash,first.previewHash);noValues(actual.report)});
 await checkAsync('wrong fingerprint blocks a listener',()=>rejectedBeforeListen(a.spec,'0'.repeat(64),'PreviewChanged'));
 await checkAsync('invalid fingerprint arguments reject before activation',async()=>{for(const hash of [null,1,'short','g'.repeat(64)])await rejectedBeforeListen(a.spec,hash,'TypeError')});
 const coherent=fixture('coherent'),coherentPreview=previewTransitionFiles(coherent.spec);
 fs.writeFileSync(coherent.part,'service.message='+JSON.stringify(changedValue));coherent.spec.transitions=coherent.spec.transitions.map(r=>({...r,afterSource:JSON.stringify(changedValue)}));
 check('coherent plan and target update still passes current-plan validation',()=>assert(reviewFiles(coherent.spec).accepted));
 check('coherent update changes preview despite unchanged diff metadata',()=>{const next=previewTransitionFiles(coherent.spec);assert.deepEqual(next.changes,coherentPreview.changes);assert.notEqual(next.previewHash,coherentPreview.previewHash);noValues(next)});
 await checkAsync('earlier hash rejects the coherently updated target before listening',()=>rejectedBeforeListen(coherent.spec,coherentPreview.previewHash,'PreviewChanged'));
 const stale=fixture('stale'),stalePreview=previewTransitionFiles(stale.spec);
 fs.writeFileSync(stale.before,`service.port=0\nservice.message="changed baseline"\nservice.copy=${'${service.message}'}`);stale.spec.transitions=stale.spec.transitions.map(r=>({...r,beforeSource:'"changed baseline"'}));
 await checkAsync('coherently updated baseline cannot reuse an earlier hash',()=>rejectedBeforeListen(stale.spec,stalePreview.previewHash,'PreviewChanged'));
 const bytes=fixture('bytes'),bytesPreview=previewTransitionFiles(bytes.spec);fs.appendFileSync(bytes.after,'\n# byte-only change\n');
 check('file bytes bind even when effective change metadata is equal',()=>{const next=previewTransitionFiles(bytes.spec);assert.deepEqual(next.changes,bytesPreview.changes);assert.notEqual(next.previewHash,bytesPreview.previewHash)});
 check('exact value-source spelling is part of the plan',()=>{const plan=a.spec.transitions.map(r=>({...r,afterSource:' '+r.afterSource+' '}));const next=previewTransitionFiles({...a.spec,transitions:plan});assert(next.accepted);assert.notEqual(next.previewHash,first.previewHash)});
 const orderDir=path.join(root,'ordered');fs.mkdirSync(orderDir);const old=path.join(orderDir,'before.conf'),next=path.join(orderDir,'after.conf');
 fs.writeFileSync(old,'service.port=0\nservice.flag=old');fs.writeFileSync(next,'service.port=0\nservice.flag=new');
 const left=path.join(orderDir,'left.conf'),right=path.join(orderDir,'right.conf');fs.writeFileSync(left,'service.message=left');fs.writeFileSync(right,'service.message=right');
 const plan=[{path:['service','flag'],beforeSource:'old',afterSource:'new'}];
 const ordered=files=>({before:{file:old,fallbackFiles:files},after:{file:next,fallbackFiles:files},transitions:plan});
 const l=ordered([left,right]),r=ordered([right,left]);let lReceipt,rReceipt;
 check('fallback precedence is bound even when old whole reports are equal',()=>{assert(isDeepStrictEqual(reviewFiles(l),reviewFiles(r)));lReceipt=previewTransitionFiles(l);rReceipt=previewTransitionFiles(r);assert.notEqual(lReceipt.previewHash,rReceipt.previewHash);assert.deepEqual(lReceipt.previewInputs.after.fallbackFiles,[left,right])});
 check('preview input order is a detached snapshot of caller arrays',()=>{l.before.fallbackFiles.reverse();assert.deepEqual(lReceipt.previewInputs.before.fallbackFiles,[left,right]);l.before.fallbackFiles.reverse()});
 await checkAsync('fallback order drift rejects before listening',()=>rejectedBeforeListen(r,lReceipt.previewHash,'PreviewChanged'));
 await checkAsync('newly previewed fallback order consumes its actual selected value',async()=>{const actual=await activate(r,rReceipt.previewHash);assert.equal(actual.body,'right')});
 const cpA=path.join(orderDir,'cp-a'),cpB=path.join(orderDir,'cp-b');fs.mkdirSync(cpA);fs.mkdirSync(cpB);fs.writeFileSync(path.join(cpA,'base.conf'),'service.message=left');fs.writeFileSync(path.join(cpB,'base.conf'),'service.message=right');
 const cpOld=path.join(orderDir,'cp-before.conf'),cpNext=path.join(orderDir,'cp-after.conf');fs.writeFileSync(cpOld,'include classpath("base.conf")\nservice.port=0\nservice.flag=old');fs.writeFileSync(cpNext,'include classpath("base.conf")\nservice.port=0\nservice.flag=new');
 const classSpec=roots=>({before:{file:cpOld,classpath:roots},after:{file:cpNext,classpath:roots},transitions:plan});
 const ca=classSpec([cpA,cpB]),cb=classSpec([cpB,cpA]);let caReceipt,cbReceipt;
 check('directory classpath order binds the same file set and visible diff',()=>{assert(isDeepStrictEqual(reviewFiles(ca),reviewFiles(cb)));caReceipt=previewTransitionFiles(ca);cbReceipt=previewTransitionFiles(cb);assert.notEqual(caReceipt.previewHash,cbReceipt.previewHash)});
 await checkAsync('classpath order drift rejects before listening',()=>rejectedBeforeListen(cb,caReceipt.previewHash,'PreviewChanged'));
 await checkAsync('matching classpath snapshot activates the selected resource value',async()=>assert.equal((await activate(cb,cbReceipt.previewHash)).body,'right'));
 const declined={...a.spec,transitions:a.spec.transitions.slice(0,1)};let declinedPreview;
 check('valid but rejected policy still has a value-free preview',()=>{declinedPreview=previewTransitionFiles(declined);assert(!declinedPreview.accepted);assert.match(declinedPreview.previewHash,/^[0-9a-f]{64}$/);noValues(declinedPreview)});
 await checkAsync('matching rejected-preview hash cannot bypass policy rejection',()=>rejectedBeforeListen(declined,declinedPreview.previewHash,'PolicyRejected'));
 check('unknown rule fields are validated before any canonical projection',()=>assert.throws(()=>previewTransitionFiles({...a.spec,transitions:[{...a.spec.transitions[0],afterSrouce:'ignored typo'}]})));
 check('receipts require the explicit transition mode',()=>{assert.throws(()=>previewTransitionFiles({before:a.spec.before,after:a.spec.after,rules:[]}),/transition policy/);assert.throws(()=>previewTransitionFiles({...a.spec,rules:[]}),/transition policy/)});
 const policy=path.join(a.dir,'transitions.json');fs.writeFileSync(policy,JSON.stringify(a.spec.transitions));
 check('separate-process CLI preview matches the library fingerprint',()=>{const result=invoke(a.spec,policy,['--preview-receipt']);assert.equal(result.status,0,result.stderr);const report=JSON.parse(result.stdout);assert.equal(report.previewHash,first.previewHash);noValues(report)});
 check('CLI without receipt keeps the legacy report shape',()=>{const result=invoke(a.spec,policy);assert.equal(result.status,0,result.stderr);const report=JSON.parse(result.stdout);assert.equal(report.previewHash,undefined);assert.equal(report.previewInputs,undefined)});
 const rejectedPolicy=path.join(a.dir,'rejected.json');fs.writeFileSync(rejectedPolicy,JSON.stringify(declined.transitions));
 check('rejected receipt CLI exits2',()=>{const result=invoke(a.spec,rejectedPolicy,['--preview-receipt']);assert.equal(result.status,2,result.stderr);const report=JSON.parse(result.stdout);assert(!report.accepted);assert.match(report.previewHash,/^[0-9a-f]{64}$/);noValues(report)});
 const legacy=path.join(a.dir,'legacy.json');fs.writeFileSync(legacy,'[]');
 check('receipt flag with legacy permissions is an input error',()=>{const result=spawnSync(process.execPath,[cli,'--before',a.before,'--after',a.after,'--policy',legacy,'--preview-receipt'],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(result.status,1);assert.match(result.stderr,/transition policy/)});
 const malformed=path.join(a.dir,'malformed.json');fs.writeFileSync(malformed,afterValue);
 check('round10 malformed JSON privacy remains in preview mode',()=>{const result=invoke(a.spec,malformed,['--preview-receipt']);assert.equal(result.status,1);assert.match(result.stderr,/valid JSON/);noValues(result.stderr)});
 const example=fileURLToPath(new URL('../examples/preview-bound-service.mjs',import.meta.url));let exampleHash;
 check('two-step example preview exits without a listener response',()=>{const result=spawnSync(process.execPath,[example,'--preview'],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(result.status,0,result.stderr);const report=JSON.parse(result.stdout);assert(report.accepted);exampleHash=report.previewHash;assert.equal(report.response,undefined);assert(!result.stdout.includes('approved-after'));assert(!result.stdout.includes('approved-before'))});
 check('a second example process activates only with the earlier supplied hash',()=>{const result=spawnSync(process.execPath,[example,'--activate',exampleHash],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(result.status,0,result.stderr);const response=JSON.parse(result.stdout);assert.equal(response.previewHash,exampleHash);assert.equal(response.status,200);assert.equal(response.response,'approved-after')});
 check('example activation does not silently refresh an incorrect hash',()=>{const result=spawnSync(process.execPath,[example,'--activate','0'.repeat(64)],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(result.status,1);assert.equal(result.stdout,'');assert.match(result.stderr,/PreviewChanged/)});
 console.log(JSON.stringify({checks:names.length,passed:names.length,failed:0,names}));
}finally{fs.rmSync(root,{recursive:true,force:true});}
