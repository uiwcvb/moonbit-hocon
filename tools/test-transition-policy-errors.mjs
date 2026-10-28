import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import http from 'node:http';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {parseChangePolicy} from './change-review.mjs';
import {startReviewedService} from '../examples/reviewed-service.mjs';
const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-policy-errors-'));
const marker='S3CR3T',oldMarker='B3F0RE',wrongMarker='WR0NGX'; // Public test data.
const cli=fileURLToPath(new URL('./change-review.mjs',import.meta.url));
const example=new URL('../examples/review-transition-service.mjs',import.meta.url).href;
const examplePolicy=fileURLToPath(new URL('../examples/transition-review/transitions.json',import.meta.url));
const before=path.join(dir,'before.conf'),after=path.join(dir,'after.conf'),part=path.join(dir,'message.conf');
const transitions=[{path:['service','message'],beforeSource:JSON.stringify(oldMarker),afterSource:JSON.stringify(marker)},{path:['service','copy'],beforeSource:JSON.stringify(oldMarker),afterSource:JSON.stringify(marker)}];
const malformed=[marker,'[{"path":["value"],"afterSource":'+marker+'}]',`[{"path":["value"],"afterSource":'${marker}'}]`,'[{"path":["value"],"afterSource":"'+marker+'"'];
const names=[];
function check(name,fn){fn();names.push(name);}
async function checkAsync(name,fn){await fn();names.push(name);}
function noValues(text){for(const value of [marker,oldMarker,wrongMarker])assert(!text.includes(value),'policy/configuration value appeared in diagnostic or preview');}
function run(file,mode='--transition-policy'){return spawnSync(process.execPath,[cli,'--before',before,'--after',after,mode,file],{encoding:'utf8',windowsHide:true,timeout:15000});}
try{
 fs.writeFileSync(before,`service.port=0\nservice.message="${oldMarker}"\nservice.copy=${'${service.message}'}`);
 fs.writeFileSync(after,'include "message.conf"\nservice.port=0\nservice.copy=${service.message}');
 fs.writeFileSync(part,`service.message="${marker}"`);
 const valid=path.join(dir,'valid.json');fs.writeFileSync(valid,JSON.stringify(transitions));
 check('valid JSON retains exact expected value texts',()=>assert.deepEqual(parseChangePolicy(fs.readFileSync(valid,'utf8')),transitions));
 // Execute the actual example module unchanged, replacing only its policy read
 // inside an owned child. No project fixture is modified and the bad input is
 // never embedded into child source, argv, or an assertion message.
 const child=path.join(dir,'example-input.mjs');
 fs.writeFileSync(child,`
 import fs from 'node:fs';import {fileURLToPath} from 'node:url';
 const replacement=fs.readFileSync(process.argv[2],'utf8');const original=fs.readFileSync;
 const target=${JSON.stringify(examplePolicy.replaceAll('\\','/').toLowerCase())};
 fs.readFileSync=function(file,...args){const name=(file instanceof URL?fileURLToPath(file):String(file)).replaceAll('\\\\','/').toLowerCase();return name===target?replacement:original.call(this,file,...args)};
 await import(${JSON.stringify(example)});
 `);
 for(const [i,text] of malformed.entries()){
  const bad=path.join(dir,`invalid-${i}.json`);fs.writeFileSync(bad,text);
  for(const mode of ['--transition-policy','--policy'])check(`malformed JSON ${i} ${mode} exits1 without an excerpt`,()=>{const result=run(bad,mode);assert.equal(result.status,1);assert.equal(result.stdout,'');assert.match(result.stderr,/valid JSON/i);noValues(result.stderr)});
  check(`uncaught example JSON failure ${i} contains no policy value`,()=>{const result=spawnSync(process.execPath,[child,bad],{encoding:'utf8',windowsHide:true,timeout:15000});assert.equal(result.status,1);assert.equal(result.stdout,'');assert.match(result.stderr,/valid JSON/i);noValues(result.stderr)});
 }
 check('valid transition preview remains exit0 and value-free',()=>{const result=run(valid);assert.equal(result.status,0,result.stderr);assert(JSON.parse(result.stdout).accepted);noValues(result.stdout+result.stderr)});
 const spec={before:{file:before},after:{file:after},transitions:parseChangePolicy(fs.readFileSync(valid,'utf8'))};
 await checkAsync('previewed plan activates the approved actual HTTP response',async()=>{const active=await startReviewedService(spec);try{const response=await fetch(active.url);assert.equal(response.status,200);assert.equal(await response.text(),marker);noValues(JSON.stringify(active.report))}finally{await new Promise((resolve,reject)=>{active.server.close(error=>error?reject(error):resolve());active.server.closeAllConnections()})}});
 fs.writeFileSync(part,`service.message="${wrongMarker}"`);
 check('wrong target remains exit2 with a value-free preview',()=>{const result=run(valid);assert.equal(result.status,2,result.stderr);const report=JSON.parse(result.stdout);assert(!report.accepted);assert(report.mismatches.every(m=>m.side==='after'));noValues(result.stdout+result.stderr)});
 await checkAsync('rejected plan still opens no listener',async()=>{const original=http.Server.prototype.listen;let opened=0;http.Server.prototype.listen=function(...args){opened++;return original.apply(this,args)};try{await assert.rejects(startReviewedService(spec),error=>{assert.equal(error.name,'PolicyRejected');noValues(JSON.stringify(error.report));return true});assert.equal(opened,0)}finally{http.Server.prototype.listen=original}});
 const legacy=path.join(dir,'legacy.json');fs.writeFileSync(legacy,JSON.stringify(transitions.map(t=>({path:t.path,kind:'changed'}))));
 check('legacy path permission behavior remains unchanged',()=>{const result=run(legacy,'--policy');assert.equal(result.status,0,result.stderr);assert(JSON.parse(result.stdout).accepted);noValues(result.stdout+result.stderr)});
 const invalidSource=path.join(dir,'invalid-source.json');fs.writeFileSync(invalidSource,JSON.stringify([{...transitions[0],afterSource:'"'+marker}]));
 check('valid JSON with invalid HOCON remains an input error without value',()=>{const result=run(invalidSource);assert.equal(result.status,1);assert.equal(result.stdout,'');noValues(result.stderr)});
 check('I/O failure keeps its existing diagnostic',()=>{const result=run(path.join(dir,'missing.json'));assert.equal(result.status,1);assert.match(result.stderr,/ENOENT/);noValues(result.stderr)});
 const huge=path.join(dir,'huge.json');fs.writeFileSync(huge,' '.repeat(524289)+'[]');
 check('existing policy byte guard remains effective',()=>{const result=run(huge);assert.equal(result.status,1);assert.match(result.stderr,/524288/);noValues(result.stderr)});
 console.log(JSON.stringify({checks:names.length,passed:names.length,failed:0,names}));
}finally{fs.rmSync(dir,{recursive:true,force:true});}
