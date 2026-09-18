import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {load,loadFile,loadURL,loadAsync,loadFileAsync,loadURLAsync,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-accessors-'));
const checks=[];let server;
async function checked(name,fn){await fn();checks.push(name);}
const source='number="9223372036854775807"\nnumbers=[1,"2",1.5,"-0.0"]\nobject={x=[1],n=null}\nobjects=[{x=1},{}]\nany=[1,null,{x=true}]\ncolor=GREEN\ncolors=[RED,GREEN]';
const cases=[
 ['number','number',{kind:'long',value:'9223372036854775807'}],
 ['number-list','numbers',[{kind:'int',value:'1'},{kind:'long',value:'2'},{kind:'double',value:1.5,bits:'4609434218613702656'},{kind:'double',value:'-0.0',bits:'-9223372036854775808'}]],
 ['object','object',{x:[1],n:null}],['object-list','objects',[{x:1},{}]],
 ['any-ref','any',[1,null,{x:true}]],['any-ref-list','any',[1,null,{x:true}]],
 ['enum','color','GREEN'],['enum-list','colors',['RED','GREEN']],
];
function options(getter,path){return {getter,path,...(getter.startsWith('enum')?{enumChoices:['RED','GREEN']}: {})};}
function invoke(args,input){return spawnSync(process.execPath,[fileURLToPath(new URL('./cli.mjs',import.meta.url)),...args],{cwd:temp,input,encoding:'utf8',windowsHide:true,timeout:15000});}
try{
 fs.writeFileSync(path.join(temp,'base.conf'),source);fs.writeFileSync(path.join(temp,'main.conf'),'include "base.conf"');
 for(const [getter,key,expected] of cases){
  const opts=options(getter,key);
  for(const [mode,run] of [['sync string',()=>load(source,opts)],['async file include',()=>loadFileAsync('main.conf',{...opts,cwd:temp})]])await checked(getter+' '+mode,async()=>assert.deepEqual(await run(),expected));
  for(const mode of ['file','stdin'])await checked(getter+' CLI '+mode,()=>{const run=invoke([...(mode==='file'?['--file','main.conf']:[]),'--get',key,'--type',getter,...(opts.enumChoices?opts.enumChoices.flatMap(c=>['--enum-choice',c]):[])],mode==='stdin'?source:undefined);assert.equal(run.status,0,run.stderr);assert.deepEqual(JSON.parse(run.stdout),expected);});
 }
 await checked('sync file number lookup',()=>assert.deepEqual(loadFile('main.conf',{cwd:temp,getter:'number',path:'number'}),cases[0][2]));
 await checked('async string enum lookup',async()=>assert.equal(await loadAsync(source,options('enum','color')),'GREEN'));
 await checked('unknown enum choice rejects through async ConfigError',()=>assert.rejects(loadAsync('a=BLUE',{getter:'enum',path:'a',enumChoices:['RED']}),ConfigError));
 for(const enumChoices of [undefined,null,{},[1],['RED','RED'],Array.from({length:1025},(_,i)=>String(i)),['x'.repeat(100001)]])await checked('enum choices bound/type '+JSON.stringify(enumChoices)?.slice(0,60),()=>assert.throws(()=>load('a=RED',{getter:'enum',path:'a',enumChoices}),ConfigError));
 await checked('empty enum choices reject value',()=>assert.throws(()=>load('a=RED',{getter:'enum',path:'a',enumChoices:[]}),ConfigError));
 await checked('empty enum list with empty choices succeeds',()=>assert.deepEqual(load('a=[]',{getter:'enum-list',path:'a',enumChoices:[]}),[]));
 await checked('JSON preserves exponent number and original string getter',()=>{const input='{"a":9.223372036854776e18,"b":1.00}';assert.deepEqual(load(input,{format:'json',getter:'number',path:'a'}),{kind:'long',value:'9223372036854775807'});assert.equal(load(input,{format:'json',getter:'string',path:'b'}),'1.00');});
 await checked('HOCON oversized integer retains text',()=>assert.equal(load('a=9223372036854775808',{getter:'any-ref',path:'a'}),'9223372036854775808'));
 fs.writeFileSync(path.join(temp,'overflow.json'),'{"a":9223372036854775808}');await checked('file JSON oversized integer rejects',()=>assert.throws(()=>loadFile('overflow.json',{cwd:temp}),ConfigError));
 await checked('Unicode decimal string and indexed object',()=>{assert.deepEqual(load('a="１２"',{getter:'number',path:'a'}),{kind:'long',value:'12'});assert.deepEqual(load('a={"١"=2,"٠"=1}',{getter:'any-ref-list',path:'a'}),[1,2]);});
 for(const args of [['--enum-choice'],['--type','enum'],['--type','int','--enum-choice','RED']])await checked('CLI invalid enum arguments '+args.join(' '),()=>assert.equal(invoke(['--input','a=RED','--get','a',...args]).status,1));
 await checked('CLI unknown enum is config error exit 2',()=>assert.equal(invoke(['--input','a=BLUE','--get','a','--type','enum','--enum-choice','RED']).status,2));
 const fixtures=path.join(temp,'fixtures.json');fs.writeFileSync(fixtures,JSON.stringify({'/base.conf':{body:source}}));
 server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtures],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
 let errors='';server.stderr.on('data',chunk=>errors+=chunk);const timer=setTimeout(()=>server.kill(),10000);
 const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('HTTP fixture failed: '+errors);})]);clearTimeout(timer);
 const ca=fs.readFileSync(new URL('./fixtures/http-cert.pem',import.meta.url),'utf8');
 await checked('HTTP number-list exact tagged transport',()=>assert.deepEqual(loadURL(addresses.http+'/base.conf',options('number-list','numbers')),cases[1][2]));
 await checked('HTTPS async enum choices cross worker boundary',async()=>assert.deepEqual(await loadURLAsync(addresses.https+'/base.conf',{...options('enum-list','colors'),network:{ca}}),['RED','GREEN']));
 await checked('CLI HTTPS object getter',()=>{fs.writeFileSync(path.join(temp,'ca.pem'),ca);const run=invoke(['--url',addresses.https+'/base.conf','--ca','ca.pem','--get','object','--type','object']);assert.equal(run.status,0,run.stderr);assert.deepEqual(JSON.parse(run.stdout),cases[2][2]);});
 fs.writeFileSync(new URL('../evidence/accessor-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' extended accessor file/HTTP/async/CLI checks passed');
}finally{
 if(server&&!server.killed){const exited=once(server,'exit');server.kill();await exited;}
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
