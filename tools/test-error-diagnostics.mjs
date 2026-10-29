import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
const repo=fileURLToPath(new URL('../',import.meta.url)),output=path.join(repo,'output/error-diagnostics');
fs.mkdirSync(output,{recursive:true});
const work=fs.mkdtempSync(path.join(output,'consumer-'));
const deps=path.resolve(process.env.HOCON_TYPESCRIPT_DEPS||path.join(repo,'tools/typescript-consumer/node_modules'));
const hash=bytes=>createHash('sha256').update(bytes).digest('hex');
const manifest={passed:false,work,commands:[],sourceFiles:[],outputs:[]};
const writeJSON=(name,value)=>fs.writeFileSync(path.join(work,name),JSON.stringify(value,null,2)+'\n');
function run(name,args){
 const startedAtUTC=new Date().toISOString();
 const result=spawnSync(process.execPath,args,{cwd:work,timeout:60_000,windowsHide:true,maxBuffer:4*1024*1024});
 const stdout=result.stdout||Buffer.alloc(0),stderr=result.stderr||Buffer.alloc(0);
 fs.writeFileSync(path.join(work,name+'.stdout.raw'),stdout);fs.writeFileSync(path.join(work,name+'.stderr.raw'),stderr);
 const receipt={name,executable:process.execPath,argv:args,cwd:work,pid:result.pid,startedAtUTC,completedAtUTC:new Date().toISOString(),
  exitCode:result.status,signal:result.signal,error:result.error?.message||null,
  stdout:{bytes:stdout.length,sha256:hash(stdout)},stderr:{bytes:stderr.length,sha256:hash(stderr)}};
 manifest.commands.push(receipt);writeJSON(name+'.process.json',receipt);
 assert.equal(result.error,undefined,name+': launch/timeout');assert.equal(result.signal,null,name+': signal');
 assert.equal(result.status,0,name+': '+stdout+stderr);assert.equal(stderr.length,0,name+': stderr');return stdout;
}
try{
 assert.equal(JSON.parse(fs.readFileSync(path.join(deps,'typescript/package.json'))).version,'5.9.3');
 assert.equal(JSON.parse(fs.readFileSync(path.join(deps,'@types/node/package.json'))).version,'24.0.0');
 for(const name of fs.readdirSync(path.join(repo,'tools/error-diagnostics')))fs.copyFileSync(path.join(repo,'tools/error-diagnostics',name),path.join(work,name));
 for(const name of ['tools/config.mjs','tools/config.d.mts','tools/config-object.mjs','tools/config-error.mjs','tools/config-host.mjs',
  'tools/config-async.mjs','tools/config-async-worker.mjs','tools/http-client.mjs','tools/http-worker.mjs','web/engine.mjs']){
  const bytes=fs.readFileSync(path.join(repo,name)),target=path.join(work,'product',name);fs.mkdirSync(path.dirname(target),{recursive:true});fs.writeFileSync(target,bytes);
  manifest.sourceFiles.push({path:name,bytes:bytes.length,sha256:hash(bytes)});
 }
 assert.equal(run('compile-producer',[path.join(deps,'typescript/bin/tsc'),'--project','tsconfig.json','--typeRoots',path.join(deps,'@types'),'--pretty','false']).length,0);
 assert(fs.existsSync(path.join(work,'producer.mjs')));
 const input=fs.realpathSync(path.join(work,'broken.conf')),escaped=JSON.stringify(input).slice(1,-1);
 const expected=name=>fs.readFileSync(path.join(work,name),'utf8').replaceAll('<INPUT>',escaped);
 const log=run('diagnostic-producer',[path.join(work,'producer.mjs'),input]);assert.equal(log.toString('utf8'),expected('expected.ndjson'));
 const received=path.join(work,'diagnostics.ndjson');fs.writeFileSync(received,log);assert(fs.readFileSync(received).equals(log));
 const output=run('diagnostic-receiver',[path.join(work,'receiver.mjs'),received]);assert.equal(output.toString('utf8'),expected('expected-receiver.stdout'));
 manifest.actualReceivedLogSHA256=hash(fs.readFileSync(received));manifest.producerStdoutSHA256=hash(log);manifest.diagnosticCases=5;
 for(const name of fs.readdirSync(work))if(fs.statSync(path.join(work,name)).isFile()&&name!=='RESULT.json'){
  const bytes=fs.readFileSync(path.join(work,name));manifest.outputs.push({path:name,bytes:bytes.length,sha256:hash(bytes)});
 }
 manifest.passed=true;console.log('Explicit ConfigError diagnostics: 5 full frames, detached metadata and real JSON receiver passed');
}finally{
 writeJSON('RESULT.json',manifest);fs.writeFileSync(path.join(output,'latest.json'),JSON.stringify({work,passed:manifest.passed},null,2)+'\n');
}
