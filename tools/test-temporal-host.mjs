import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {load,loadFile,loadURL,loadAsync,loadFileAsync,loadURLAsync,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-temporal-'));
const checks=[];let server;
async function checked(name,fn){await fn();checks.push(name);}
const source='period=12months\nduration="-1999ns"\nvalues=[9223372036854775807,"9223372036854775807",-1.5,"1.5ms"]\nmonths=１２months';
const cases=[
 ['period','period',{years:0,months:12,days:0}],
 ['temporal','period',{kind:'period',years:0,months:12,days:0}],
 ['duration-in','duration','-1','microseconds'],
 ['duration-list-in','values',['9223372036854775807','9223372036854','-1','1'],'milliseconds'],
 ['milliseconds','duration','0'],['nanoseconds','duration','-1999'],
 ['milliseconds-list','values',['9223372036854775807','9223372036854','-1','1']],
 ['nanoseconds-list','values',['9223372036854775807','9223372036854775807','-1000000','1500000']],
];
function invoke(args,input){return spawnSync(process.execPath,[fileURLToPath(new URL('./cli.mjs',import.meta.url)),...args],{cwd:temp,input,encoding:'utf8',windowsHide:true,timeout:15000});}
try{
 fs.writeFileSync(path.join(temp,'base.conf'),source);fs.writeFileSync(path.join(temp,'main.conf'),'include "base.conf"');
 for(const [getter,key,expected,unit] of cases){
  const opts={getter,path:key,unit};
  for(const [mode,run] of [['sync string',()=>load(source,opts)],['async file include',()=>loadFileAsync('main.conf',{...opts,cwd:temp})]])await checked(getter+' '+mode,async()=>assert.deepEqual(await run(),expected));
  for(const mode of ['file','stdin'])await checked(getter+' CLI '+mode,()=>{const run=invoke([...(mode==='file'?['--file','main.conf']:[]),'--get',key,'--type',getter,...(unit?['--time-unit',unit]:[])],mode==='stdin'?source:undefined);assert.equal(run.status,0,run.stderr);assert.deepEqual(JSON.parse(run.stdout),expected);});
 }
 await checked('sync file period with Unicode digits',()=>assert.deepEqual(loadFile('main.conf',{cwd:temp,getter:'period',path:'months'}),{years:0,months:12,days:0}));
 await checked('async string duration-first temporal',async()=>assert.deepEqual(await loadAsync('a=2m',{getter:'temporal',path:'a'}),{kind:'duration',nanoseconds:'120000000000'}));
 for(const [unit,expected] of [['nanoseconds','86400000000000'],['microseconds','86400000000'],['milliseconds','86400000'],['seconds','86400'],['minutes','1440'],['hours','24'],['days','1']])await checked('async time unit '+unit,async()=>assert.equal(await loadAsync('a=1d',{getter:'duration-in',path:'a',unit}),expected));
 for(const unit of [undefined,null,{},1,'Seconds','invalid'])await checked('invalid host unit '+JSON.stringify(unit),()=>assert.throws(()=>load('a=1s',{getter:'duration-in',path:'a',unit}),ConfigError));
 await checked('async invalid period surfaces ConfigError',()=>assert.rejects(loadAsync('a="306783379w"',{getter:'period',path:'a'}),ConfigError));
 for(const args of [['--time-unit'],['--type','duration-in'],['--type','duration-in','--time-unit','Seconds'],['--type','period','--time-unit','days'],['--type','duration-in','--time-unit','days','--time-unit','hours']])await checked('CLI invalid unit arguments '+args.join(' '),()=>assert.equal(invoke(['--input','a=1s','--get','a',...args]).status,1));
 await checked('CLI period overflow exit 2',()=>assert.equal(invoke(['--input','a=306783379w','--get','a','--type','period']).status,2));
 const fixtures=path.join(temp,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/base.conf':{body:source}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);const timer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed: '+errors);})]);clearTimeout(timer);
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 await checked('HTTP period fields',()=>assert.deepEqual(loadURL(addresses.http+'/base.conf',{getter:'period',path:'period'}),cases[0][2]));
 await checked('HTTPS async unit options cross worker boundary',async()=>assert.deepEqual(await loadURLAsync(addresses.https+'/base.conf',{getter:'duration-list-in',path:'values',unit:'milliseconds',network:{ca}}),cases[3][2]));
 await checked('CLI HTTPS temporal',()=>{fs.writeFileSync(path.join(temp,'ca.pem'),ca);const run=invoke(['--url',addresses.https+'/base.conf','--ca','ca.pem','--get','period','--type','temporal']);assert.equal(run.status,0,run.stderr);assert.deepEqual(JSON.parse(run.stdout),cases[1][2]);});
 fs.writeFileSync(new URL('../evidence/temporal-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' temporal file/HTTP/async/CLI checks passed');
}finally{
 if(server&&!server.killed){const exited=once(server,'exit');server.kill();await exited;}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
