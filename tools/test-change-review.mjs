import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {Config} from './config.mjs';
import {compare} from './migration-gate.mjs';
import {reviewFiles} from './change-review.mjs';

const root=fileURLToPath(new URL('../',import.meta.url)),source=path.join(root,'examples/openwhisk');
const jar=process.env.HOCON_REFERENCE_JAR;
assert(jar,'Set HOCON_REFERENCE_JAR to the upstream Config 1.4.9 jar');
const hash=bytes=>createHash('sha256').update(bytes).digest('hex');
const manifest=JSON.parse(fs.readFileSync(path.join(source,'SOURCE.json'),'utf8'));
for(const [name,digest] of Object.entries(manifest.files))assert.equal(hash(fs.readFileSync(path.join(source,name))),digest,name);
const describe=dir=>({file:path.join(dir,'controller/application.conf'),fallbackFiles:[path.join(dir,'controller/reference.conf')],classpath:[path.join(dir,'resources')]});
const before=describe(source),temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-change-'));
const permission={path:['pekko','http','server','default-http-port'],kind:'changed'};
const checks=[];
try{
  fs.cpSync(source,temp,{recursive:true});
  const after=describe(temp),initial=reviewFiles({before,after});
  assert(initial.accepted);assert.equal(initial.changes.length,0);checks.push('unchanged public source accepted');
  const application=fs.readFileSync(after.file,'utf8');
  fs.appendFileSync(after.file,'\npekko.http.server.default-http-port=10002\n');
  // Independent Java parser must agree on both complete resolved trees before
  // the intentionally changed configuration is used as a policy example.
  for(const spec of [before,after])assert(compare({file:spec.file,fallbacks:spec.fallbackFiles,classpath:spec.classpath,jar}).equivalent);
  const denied=reviewFiles({before,after});
  assert.equal(denied.accepted,false);assert.deepEqual(denied.unexpected.map(x=>({path:x.path,kind:x.kind})),[permission]);
  assert(reviewFiles({before,after,rules:[permission]}).accepted);checks.push('port override agrees with Java; exact permission required');
  const policy=path.join(temp,'policy.json');fs.writeFileSync(policy,JSON.stringify([permission]));
  const args=['tools/change-review.mjs','--before',before.file,'--after',after.file,'--policy',policy,'--before-fallback',before.fallbackFiles[0],'--after-fallback',after.fallbackFiles[0],'--before-classpath',before.classpath[0],'--after-classpath',after.classpath[0]];
  let run=spawnSync(process.execPath,args,{cwd:root,encoding:'utf8',windowsHide:true});assert.equal(run.status,0,run.stderr);
  const logging=path.join(temp,'resources/logging.conf');
  fs.writeFileSync(logging,fs.readFileSync(logging,'utf8').replace('loglevel = "DEBUG"','loglevel = "TRACE"'));
  assert(compare({file:after.file,fallbacks:after.fallbackFiles,classpath:after.classpath,jar}).equivalent);
  const drift=reviewFiles({before,after,rules:[permission]});
  assert.equal(drift.accepted,false);assert.deepEqual(drift.unexpected.map(x=>x.path),[['pekko','loglevel']]);
  assert(!JSON.stringify(drift).includes('controller.pass'));
  run=spawnSync(process.execPath,args,{cwd:root,encoding:'utf8',windowsHide:true});assert.equal(run.status,2,run.stderr);assert.equal(JSON.parse(run.stdout).accepted,false);
  checks.push('included file drift rejected with exit 2 despite allowed main-file edit');
  fs.writeFileSync(after.file,application); // Main file now has exactly its original hash.
  const includeOnly=reviewFiles({before,after,rules:[permission]});assert(!includeOnly.accepted);
  assert.equal(hash(fs.readFileSync(before.file)),hash(fs.readFileSync(after.file)));
  checks.push('unchanged main-file hash cannot hide changed include');
  fs.writeFileSync(policy,JSON.stringify([{path:[],kind:'changed'}]));
  run=spawnSync(process.execPath,args,{cwd:root,encoding:'utf8',windowsHide:true});assert.equal(run.status,1);assert.equal(run.stdout,'');
  checks.push('invalid policy is an error, never an accepted review');
  assert(!Config.load('n=9007199254740992').reviewChanges(Config.load('n=9007199254740993')).accepted);
  for(const rules of [[{path:['n'],kind:'changed',extra:1}],[{path:[1],kind:'changed'}],null])assert.throws(()=>Config.load('n=1').reviewChanges(Config.load('n=2'),rules));
  assert.throws(()=>Config.parse('n=${missing}').reviewChanges(Config.load('n=1')));
  checks.push('retained-tree bridge preserves exact large integers and rejects malformed or unresolved inputs');
  const receipt={utc:new Date().toISOString(),openwhiskCommit:manifest.openwhiskCommit,referenceJarSha256:hash(fs.readFileSync(jar)),checks,baselineReadCount:initial.readSets.before.length,changes:drift.changes,unexpected:drift.unexpected,engineSha256:hash(fs.readFileSync(path.join(root,'web/engine.mjs'))),limits:['no OpenWhisk runtime startup or adoption claim','permissions concern resolved changes, not correctness of values','trusted local files; no atomic filesystem snapshot; paths may disclose names']};
  const output=process.env.HOCON_CHANGE_EVIDENCE??path.join(root,'evidence/openwhisk-change-review.json');
  fs.mkdirSync(path.dirname(output),{recursive:true});fs.writeFileSync(output,JSON.stringify(receipt,null,2)+'\n');
  console.log(JSON.stringify(receipt,null,2));
}finally{assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});}
