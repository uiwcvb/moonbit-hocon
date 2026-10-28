import assert from 'node:assert/strict';
import fs from 'node:fs';
import http from 'node:http';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {startReviewedService} from '../examples/reviewed-service.mjs';
import {reviewFiles} from './change-review.mjs';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..');
const output=path.resolve(process.argv[2]);
fs.mkdirSync(output,{recursive:true});
const inputs=path.join(output,'inputs');fs.mkdirSync(inputs);
const old=path.join(inputs,'before.conf'),next=path.join(inputs,'after.conf');
const oldInclude=path.join(inputs,'before-include.conf'),nextInclude=path.join(inputs,'after-include.conf');
const secret='SENSITIVE_VALUE_NOT_IN_POLICY_REPORT';
fs.writeFileSync(old,'include "before-include.conf"\nservice.port=0\n');
fs.writeFileSync(next,'include "after-include.conf"\nservice.port=0\n');
fs.writeFileSync(oldInclude,'service.message="previous"\n');
fs.writeFileSync(nextInclude,`service.message="${secret}"\n`);
const before={file:old},after={file:next};
const rule={path:['service','message'],kind:'changed'};
const createServer=http.createServer;let serversCreated=0;
http.createServer=(...args)=>{serversCreated++;return createServer(...args);};
const accepted=await startReviewedService({before,after,rules:[rule]});
try{assert.equal(await (await fetch(accepted.url)).text(),secret);}finally{await new Promise((resolve,reject)=>accepted.server.close(error=>error?reject(error):resolve()));}
assert.equal(accepted.server.listening,false);
const reports={accepted:accepted.report};
for(const [name,options] of [
  ['disallowedInclude',{before,after,rules:[]}],
  ['unusedApproval',{before,after,rules:[rule,{path:['service','port'],kind:'changed'}]}],
]){
  await assert.rejects(()=>startReviewedService(options),error=>{assert.equal(error.name,'PolicyRejected');assert.equal(error.report.accepted,false);reports[name]=error.report;return true;});
  assert.equal(serversCreated,1,'rejected application must not create a server');
}
http.createServer=createServer;
assert.deepEqual(reports.disallowedInclude.unexpected.map(change=>change.path),[['service','message']]);
assert.deepEqual(reports.unusedApproval.unusedRules,[{path:['service','port'],kind:'changed'}]);
const permissive=reviewFiles({before,after,rules:[rule,{path:['service','port'],kind:'changed'}]});
assert.equal(permissive.accepted,true);assert.equal(permissive.unusedRules.length,1);
const policy=path.join(inputs,'policy.json');
fs.writeFileSync(policy,JSON.stringify([rule,{path:['service','port'],kind:'changed'}]));
const cli=spawnSync(process.execPath,['tools/change-review.mjs','--before',old,'--after',next,'--policy',policy,'--require-all-rules-used'],{cwd:root,encoding:'utf8',windowsHide:true});
assert.equal(cli.status,2);assert.equal(JSON.parse(cli.stdout).accepted,false);
assert.equal(cli.stderr,'');
const reportText=JSON.stringify(reports);
assert.equal(reportText.includes(secret),false);assert.equal(cli.stdout.includes(secret),false);
fs.writeFileSync(path.join(output,'policy-reports.json'),JSON.stringify(reports,null,2)+'\n');
const receipt={utc:new Date().toISOString(),node:process.version,checks:[
  'allowed resolved change starts real loopback HTTP application; HTTP response matches retained resolved value; listener closed',
  'disallowed included configuration rejects application activation before listener creation',
  'unused approval rejects strict application activation',
  'default review remains permissive and reports unused approvals',
  'strict CLI exits 2 for unused approval',
  'policy reports and CLI output contain no configuration values',
],strictCliExitCode:cli.status,engineSHA256:createHash('sha256').update(fs.readFileSync(path.join(root,'web/engine.mjs'))).digest('hex'),limits:['author-created local application consumer; no external adoption or OpenWhisk deployment claim','local trusted file recheck does not make an atomic filesystem snapshot','no long-running service or deployment platform verification']};
fs.writeFileSync(path.join(output,'RECEIPT.json'),JSON.stringify(receipt,null,2)+'\n');
console.log(JSON.stringify(receipt,null,2));
