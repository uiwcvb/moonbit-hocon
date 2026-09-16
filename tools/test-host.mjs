import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {load,loadFile,ConfigError} from './config.mjs';
const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-host-'));
const cli=fileURLToPath(new URL('cli.mjs',import.meta.url));
function run(args){return spawnSync(process.execPath,[cli,...args],{cwd:dir,encoding:'utf8',windowsHide:true,timeout:15000,env:{...process.env,HOCON_TEST_HOST:'localhost'}});}
try {
 fs.mkdirSync(path.join(dir,'defaults'));
 fs.writeFileSync(path.join(dir,'main.conf'),'include "local.conf"\nport=9090\nhost=${HOCON_TEST_HOST}\ntimeout=1.25ms');
 fs.writeFileSync(path.join(dir,'local.conf'),'endpoint=${host}":"${port}');
 fs.writeFileSync(path.join(dir,'defaults','base.conf'),'include "part.conf"');
 fs.writeFileSync(path.join(dir,'defaults','part.conf'),'port=8080\nretry=3');
 const args=['--file','main.conf','--fallback','defaults/base.conf','--env'];
 const result=run([...args,'--resolved-json']);assert.equal(result.status,0,result.stderr);assert.deepEqual(JSON.parse(result.stdout),{endpoint:'localhost:9090',host:'localhost',port:9090,retry:3,timeout:'1.25ms'});
 const duration=run([...args,'--get','timeout','--type','duration']);assert.equal(duration.status,0);assert.equal(JSON.parse(duration.stdout),'1250000');
 assert.equal(run(['--file','main.conf']).status,2);
 assert.equal(run([...args,'--get','missing']).status,2);
 assert.equal(run(['--type','int']).status,1);
 fs.writeFileSync(path.join(dir,'bad.conf'),'x=1\ny="unterminated');
 try{loadFile(path.join(dir,'bad.conf'));assert.fail('accepted malformed input');}catch(e){assert(e instanceof ConfigError);assert.equal(e.position.source,path.join(dir,'bad.conf'));assert.equal(e.position.line,2);assert.equal(e.position.column,3);}
 fs.writeFileSync(path.join(dir,'bad-utf8.conf'),Buffer.from([0xff,0xfe]));assert.throws(()=>loadFile(path.join(dir,'bad-utf8.conf')),/encoded data/);
 assert.throws(()=>load('include url("https://example.invalid/config")'),/Unsupported include URL protocol/);
 assert.throws(()=>load('include required("missing")',{cwd:dir}),/missing required/);
 fs.writeFileSync(path.join(dir,'huge.conf'),'x='+ 'a'.repeat(100001));assert.throws(()=>loadFile(path.join(dir,'huge.conf')),/100000/);
 assert.deepEqual(load('__proto__=safe\nconstructor=also-safe'),JSON.parse('{"__proto__":"safe","constructor":"also-safe"}'));
 assert.equal(load('n="NaN"',{getter:'double',path:'n'}),'NaN');
 assert.throws(()=>load('['.repeat(40)+']'.repeat(40),{format:'json'}),/nesting limit/);
 assert.throws(()=>load('x'.repeat(100001)),/excessive/);
 console.log('host: real includes, fallback origins, environment, CLI getters, errors and limits passed');
} finally {fs.rmSync(dir,{recursive:true,force:true});}
