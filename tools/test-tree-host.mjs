import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {load,loadFile,loadAsync,loadFileAsync,ConfigError} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
const cli=fileURLToPath(new URL('./cli.mjs',import.meta.url));
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-tree-'));
const checks=[];
async function checked(name,operation){await operation();checks.push(name);}
function invoke(args,input){return spawnSync(process.execPath,[cli,...args],{cwd:temp,input,encoding:'utf8',windowsHide:true,timeout:15000});}
try {
 fs.writeFileSync(path.join(temp,'included.conf'),'a={b=1,c=null}\nz=3');
 fs.writeFileSync(path.join(temp,'main.conf'),'include "included.conf"');
 fs.writeFileSync(path.join(temp,'reference.conf'),'a={b=1,c=true}\nz=1');
 fs.writeFileSync(path.join(temp,'bad-reference.conf'),'include "reference.conf"\nmissing={nested=1}');
 fs.writeFileSync(path.join(temp,'malformed-reference.conf'),'a=[1,,2]');
 const source='a={b=1,c=null}\nz=3';
 const operations=[{op:'with-value',path:'a.b',value:9},{op:'without-path',path:'z'},{op:'at-key',path:'x.y'}];
 const expected={'x.y':{a:{b:9,c:null}}};
 for(const [name,run] of [['sync string',()=>load(source,{operations})],['sync file',()=>loadFile('main.conf',{cwd:temp,operations})],['async string',()=>loadAsync(source,{operations})],['async file',()=>loadFileAsync('main.conf',{cwd:temp,operations})]])await checked(name,async()=>assert.deepEqual(await run(),expected));
 await checked('input operation object stays unchanged',()=>{const before=JSON.stringify(operations);load(source,{operations});assert.equal(JSON.stringify(operations),before);});
 await checked('JSON text retains exact numeric spelling',()=>assert.equal(load('n=9223372036854775807',{getter:'json-text'}),'{"n":9223372036854775807}'));
 await checked('entries skip null and empty objects',()=>assert.deepEqual(load('a={n=null,empty={},list=[null]}',{getter:'entries'}),{'a.list':[null]}));
 await checked('null has path but absent does not',()=>{assert.equal(load('a=null',{getter:'has-or-null',path:'a'}),true);assert.equal(load('a=null',{getter:'has-or-null',path:'missing'}),false);});
 for(const options of [{operations:{}},{operations:null},{operations:[{op:'unknown',path:'a'}]},{operations:Array.from({length:257},()=>({op:'without-path',path:'a'}))},{checkValid:{}},{checkValid:{source:'a=1',paths:4}},{getter:'validation',referenceSource:'a=1',validationPaths:[3]}])await checked('invalid options '+JSON.stringify(options).slice(0,90),()=>assert.throws(()=>load(source,options),ConfigError));
 for(const async of [false,true])await checked('validation problems survive '+(async?'async':'sync')+' boundary',async()=>{
  let error;try{await (async?loadAsync:load)(source,{checkValid:{source:'a={b=true}\nmissing=1'}});}catch(e){error=e;}
  assert(error instanceof ConfigError);assert.equal(error.problems.length,2);assert.deepEqual(error.problems.map(p=>p.path).sort(),['a.b','missing']);
 });
 await checked('successful validation after modifications',()=>assert.deepEqual(load('a=false',{operations:[{op:'with-value',path:'a',value:1}],checkValid:{source:'a=1'}}),{a:1}));
 await checked('all validation problems exposed',()=>{const problems=load('a=false',{getter:'validation',referenceSource:'a=1\nb=true'});assert.equal(problems.length,2);assert(problems.some(p=>p.expected==='number'&&p.actual==='boolean'));});
 for(const mode of ['input','file','stdin'])await checked('CLI ordered edits via '+mode,()=>{
  const result=invoke([...(mode==='input'?['--input',source]:mode==='file'?['--file','main.conf']:[]),'--set','a.b','9','--unset','z','--at-key','x.y'],mode==='stdin'?source:undefined);
  assert.equal(result.status,0,result.stderr);assert.deepEqual(JSON.parse(result.stdout),expected);
 });
 await checked('CLI exact long after set',()=>{const result=invoke(['--input','{}','--set','long','9223372036854775807','--get','long','--type','long']);assert.equal(result.status,0,result.stderr);assert.equal(JSON.parse(result.stdout),'9223372036854775807');});
 await checked('CLI entries with quoted key',()=>{const result=invoke(['--file','main.conf','--at-key','x.y','--entries']);assert.equal(result.status,0,result.stderr);assert.deepEqual(JSON.parse(result.stdout),{'"x.y".a.b':1,'"x.y".z':3});});
 await checked('CLI validate file with real include',()=>assert.equal(invoke(['--file','main.conf','--validate','reference.conf']).status,0));
 await checked('CLI validation rejects missing reference path',()=>assert.equal(invoke(['--file','main.conf','--validate','bad-reference.conf']).status,2));
 await checked('CLI malformed reference is config error',()=>assert.equal(invoke(['--file','main.conf','--validate','malformed-reference.conf']).status,2));
 await checked('CLI validation restriction skips other module',()=>assert.equal(invoke(['--file','main.conf','--validate','bad-reference.conf','--validate-path','a']).status,0));
 await checked('CLI modification precedes validation',()=>assert.equal(invoke(['--input','a=false\nz=3','--set','a','{b=1,c=true}','--validate','reference.conf']).status,0));
 await checked('CLI only and wrapping',()=>{const result=invoke(['--file','main.conf','--only','a.b','--at-path','outer.inner']);assert.equal(result.status,0,result.stderr);assert.deepEqual(JSON.parse(result.stdout),{outer:{inner:{a:{b:1}}}});});
 for(const args of [['--set','a'],['--validate-path','a'],['--validate','reference.conf','--validate','reference.conf'],['--unset'],['--entries','--get','a'],['--get','a','--entries'],['--entries','--type','int']])await checked('CLI rejects invalid arguments '+args.join(' '),()=>assert.equal(invoke(['--input','{}',...args]).status,1));
 await checked('CLI invalid set expression is config error',()=>assert.equal(invoke(['--input','{}','--set','a','[1,,2]']).status,2));
 await checked('CLI help documents edit and validate',()=>{const result=invoke(['--help']);assert.equal(result.status,0);for(const flag of ['--set','--unset','--validate','--entries'])assert(result.stdout.includes(flag));});
 fs.writeFileSync(new URL('../evidence/tree-host.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),checks:checks.length,passed:checks.length,failed:0,names:checks,sourceHashes:sourceHashes()},null,2)+'\n');
 console.log(checks.length+' tree/validation host/async/CLI checks passed');
} finally {
 assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
}
