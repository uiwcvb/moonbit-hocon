import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import http from 'node:http';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {Config,ConfigError} from './config.mjs';
import {reviewFiles} from './change-review.mjs';
import {startReviewedService} from '../examples/reviewed-service.mjs';
const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-transition-'));
const names=[];
function checked(name,fn){fn();names.push(name);}
async function checkedAsync(name,fn){await fn();names.push(name);}
const rule=(path,beforeSource,afterSource)=>({path,...(beforeSource===undefined?{}:{beforeSource}),...(afterSource===undefined?{}:{afterSource})});
const before=Config.load('port=8080\ncopy=${port}');
const after=Config.load('port=9080\ncopy=${port}');
const policy=[rule(['port'],'8080','9080'),rule(['copy'],'8080','9080')];
const cli=fileURLToPath(new URL('./change-review.mjs',import.meta.url));
function run(args){return spawnSync(process.execPath,[cli,...args],{encoding:'utf8',windowsHide:true,timeout:20000});}
function noValues(report){const text=JSON.stringify(report);for(const secret of ['approved-before','approved-after','wrong-target','stale-baseline'])assert(!text.includes(secret),'value leaked into report');}
try{
 checked('exact plan accepts complete effective transition',()=>{const report=before.reviewTransition(after,policy);assert(report.accepted);assert.equal(report.changes.length,2);assert.deepEqual(report.unusedRules,[])});
 checked('wrong target rejected on the planned path',()=>{const report=before.reviewTransition(Config.load('port=9081\ncopy=${port}'),policy);assert(!report.accepted);assert.deepEqual(report.mismatches.map(m=>m.side),['after','after']);assert.deepEqual(report.unexpected,[])});
 checked('stale baseline rejected',()=>{const report=Config.load('port=8081\ncopy=${port}').reviewTransition(after,policy);assert(!report.accepted);assert.deepEqual(report.mismatches.map(m=>m.side),['before','before'])});
 checked('unplanned substitution side effect rejects',()=>{const report=before.reviewTransition(after,policy.slice(0,1));assert(!report.accepted);assert.deepEqual(report.unexpected.map(c=>c.path),[['copy']])});
 checked('unused transition rejects while empty equality accepts',()=>{const report=before.reviewTransition(before,policy);assert(!report.accepted);assert.equal(report.unusedRules.length,2);assert(before.reviewTransition(before,[]).accepted)});
 checked('missing is distinct from present null',()=>{assert(Config.load('removed=null\nchanged=null').reviewTransition(Config.load('added=null\nchanged=true'),[rule(['removed'],'null',undefined),rule(['added'],undefined,'null'),rule(['changed'],'null','true')]).accepted)});
 checked('literal dotted and empty keys are exact',()=>{assert(Config.load('"a.b"=1\na.b=3\n""=false').reviewTransition(Config.load('"a.b"=2\na.b=3\n""=true'),[rule(['a.b'],'1','2'),rule([''],'false','true')]).accepted)});
 checked('list semantic equality and exact target length',()=>{const old=Config.load('items=[1,2]'),next=Config.load('items=[1,3]'),rules=[rule(['items'],'[1.0,2]','[1,3.0]')];assert(old.reviewTransition(next,rules).accepted);assert(!old.reviewTransition(Config.load('items=[1,3,4]'),rules).accepted)});
 checked('whole object additions and removals use diff boundary',()=>{assert(Config.load('gone={x=1}').reviewTransition(Config.load('added={x=2}'),[rule(['gone'],'{x=1}',undefined),rule(['added'],undefined,'{x=2}')]).accepted)});
 checked('adjacent integers above 2^53 remain distinct',()=>{const old=Config.load('id=9007199254740992'),next=Config.load('id=9007199254740993');assert(old.reviewTransition(next,[rule(['id'],'9007199254740992','9007199254740993')]).accepted);assert(!old.reviewTransition(next,[rule(['id'],'9007199254740992','9007199254740994')]).accepted)});
 for(const [label,rules] of [
  ['no values',[{path:['port']}]],['no-op',[rule(['port'],'1','1.0')]],['duplicate path',[policy[0],policy[0]]],
  ['unknown field',[{...policy[0],afterSrouce:'9080'}]],['non-string source',[{...policy[0],afterSource:9080}]],
  ['null source',[{...policy[0],afterSource:null}]],['empty path',[rule([],'1','2')]],['unresolved expected value',[rule(['port'],'8080','${MISSING}')]],
  ['multiple expected values',[rule(['port'],'8080','1,2')]],['assignment injection',[rule(['port'],'8080','1]\nvalue=[2')]],['non-string path',[rule([1],'1','2')]]
 ])checked('invalid policy: '+label,()=>assert.throws(()=>before.reviewTransition(after,rules),ConfigError));
 checked('unresolved actual configuration rejects',()=>assert.throws(()=>Config.parse('port=${missing}').reviewTransition(after,policy),ConfigError));
 await checkedAsync('async factory state supports the same native tree review',async()=>{const old=await Config.loadAsync('port=8080\ncopy=${port}'),next=await Config.parseAsync('port=9080\ncopy=${port}');assert(old.reviewTransition(next.resolve(),policy).accepted)});
 const fixture=fileURLToPath(new URL('../examples/transition-review/',import.meta.url));fs.cpSync(fixture,dir,{recursive:true});
 const spec={before:{file:path.join(dir,'before.conf')},after:{file:path.join(dir,'after.conf')},transitions:JSON.parse(fs.readFileSync(path.join(dir,'transitions.json'),'utf8'))};
 checked('file review includes actual input fingerprints and no values',()=>{const report=reviewFiles(spec);assert(report.accepted);assert(report.requireAllRulesUsed);assert.equal(report.readSets.after.length,2);noValues(report)});
 checked('ambiguous file policy modes and old invalid null rules reject',()=>{assert.throws(()=>reviewFiles({...spec,rules:[]}),/Choose/);assert.throws(()=>reviewFiles({before:spec.before,after:spec.before,rules:null}),TypeError)});
 const args=['--before',spec.before.file,'--after',spec.after.file,'--transition-policy',path.join(dir,'transitions.json')];
 checked('transition CLI accepts planned values and preserves value-free report',()=>{const r=run(args);assert.equal(r.status,0,r.stderr);const report=JSON.parse(r.stdout);assert(report.accepted);noValues(report)});
 await checkedAsync('real HTTP consumer returns the approved new response',async()=>{const active=await startReviewedService(spec);try{const response=await fetch(active.url);assert.equal(response.status,200);assert.equal(await response.text(),'approved-after');noValues(active.report)}finally{await new Promise((resolve,reject)=>{active.server.close(error=>error?reject(error):resolve());active.server.closeAllConnections()})}});
 fs.writeFileSync(path.join(dir,'message.conf'),'service.message="wrong-target"');
 checked('changed include with the same path is rejected',()=>{const report=reviewFiles(spec);assert(!report.accepted);assert.deepEqual(report.mismatches.map(m=>m.side),['after','after']);noValues(report)});
 checked('CLI rejection is exit 2',()=>{const r=run(args);assert.equal(r.status,2,r.stderr);const report=JSON.parse(r.stdout);assert(!report.accepted);noValues(report)});
 await checkedAsync('wrong target blocks activation before any listener opens',async()=>{const original=http.Server.prototype.listen;let opened=0;http.Server.prototype.listen=function(...args){opened++;return original.apply(this,args)};try{await assert.rejects(startReviewedService(spec),error=>error.name==='PolicyRejected'&&!error.report.accepted);assert.equal(opened,0)}finally{http.Server.prototype.listen=original}});
 fs.writeFileSync(path.join(dir,'message.conf'),'service.message="approved-after"');
 fs.writeFileSync(spec.before.file,'service.port=0\nservice.message="stale-baseline"\nservice.copy=${service.message}');
 await checkedAsync('stale baseline blocks service activation',async()=>{await assert.rejects(startReviewedService(spec),error=>{assert.equal(error.name,'PolicyRejected');assert(error.report.mismatches.every(m=>m.side==='before'));noValues(error.report);return true})});
 fs.writeFileSync(path.join(dir,'invalid.json'),JSON.stringify([rule(['service','message'],'"stale-baseline"','"private-secret') ]));
 checked('invalid expected source is exit 1 without echoing its value',()=>{const r=run(args.slice(0,-1).concat(path.join(dir,'invalid.json')));assert.equal(r.status,1);assert(!r.stderr.includes('private-secret'));assert.equal(r.stdout,'')});
 fs.writeFileSync(path.join(dir,'legacy.json'),JSON.stringify(spec.transitions.map(t=>({path:t.path,kind:'changed'}))));
 checked('legacy path/kind permissions keep accepting arbitrary target values',()=>{const r=run(['--before',spec.before.file,'--after',spec.after.file,'--policy',path.join(dir,'legacy.json')]);assert.equal(r.status,0,r.stderr);assert(JSON.parse(r.stdout).accepted)});
 checked('conflicting CLI policy flags reject',()=>{const r=run(args.concat('--policy',path.join(dir,'legacy.json')));assert.equal(r.status,1)});
 console.log(JSON.stringify({checks:names.length,passed:names.length,failed:0,names}));
}finally{fs.rmSync(dir,{recursive:true,force:true});}
