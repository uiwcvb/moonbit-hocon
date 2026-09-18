import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {sourceHashes} from './evidence.mjs';
const root=fileURLToPath(new URL('../',import.meta.url)),sha=data=>createHash('sha256').update(data).digest('hex'),cases=[];
const shapes={empty:'{}',flat64:Array.from({length:64},(_,i)=>`k${i}=${i}`).join('\n'),flat512:Array.from({length:512},(_,i)=>`k${i}=${i}`).join('\n'),nested128:Array.from({length:128},(_,i)=>`outer.group${i%8}.k${i}=${i}`).join('\n'),lists16:Array.from({length:16},(_,i)=>`k${i}=[${Array.from({length:32},(_,j)=>i+j).join(',')}]`).join('\n'),raw64:Array.from({length:64},(_,i)=>'k'+i+'=${missing'+i+'}').join('\n')};
for(const [name,source] of Object.entries(shapes))for(const mode of ['count','hash'])cases.push({name:name+'-'+mode,source,mode,resolved:name!=='raw64',repeats:16});
if(process.argv[2]==='--worker'){
 const {Config}=await import(pathToFileURL(process.argv[3])),legacy=process.argv[4]==='legacy';
 for(const item of cases){if(legacy&&(item.mode==='hash'||!item.resolved))continue;const config=Config[item.resolved?'load':'parse'](item.source);
  const work=()=>{let result=0;for(let n=0;n<item.repeats;n++){const entries=config.entrySet();result=(result+(legacy?Object.keys(entries).length:item.mode==='hash'?entries.hashCode():entries.size()))|0;}return result;};
  let result;const samplesMs=[];for(let i=-10;i<15;i++){const start=performance.now();for(let n=0;n<3;n++)result=work();if(i>=0)samplesMs.push((performance.now()-start)/3);}console.log(JSON.stringify({name:item.name,samplesMs,result}));
 }
}else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar);const baselineCommit='40f723d31ba771ca7ae6a06f91746827e86e3cb0',folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-entry-perf-'));
 const run=(command,args,options={})=>{const r=spawnSync(command,args,{cwd:root,encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:32*1024*1024,...options});assert.equal(r.status,0,r.stderr||String(r.error));return r.stdout;};
 try{
  for(const name of run('git',['ls-tree','-r','--name-only',baselineCommit,'--','tools','web/engine.mjs']).trim().split(/\r?\n/).filter(n=>n.endsWith('.mjs'))){const target=path.join(folder,name);fs.mkdirSync(path.dirname(target),{recursive:true});fs.writeFileSync(target,run('git',['show',baselineCommit+':'+name]));}
  fs.writeFileSync(path.join(folder,'package.json'),'{"type":"module"}');
  const records={current:[],baseline:[],upstream:[]},decode=text=>text.trim().split(/\r?\n/).map(JSON.parse),self=fileURLToPath(import.meta.url);
  for(let i=0;i<5;i++){
   // Rotate process order across rounds; construction occurs before timing.
   for(const variant of [0,1,2].map(n=>['current','baseline','upstream'][(n+i)%3]))records[variant].push(decode(variant==='upstream'?run(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./EntryBenchmark.java',import.meta.url))],{input:cases.map(JSON.stringify).join('\n')+'\n'}):run(process.execPath,[self,'--worker',variant==='current'?path.join(root,'tools/config-object.mjs'):path.join(folder,'tools/config-object.mjs'),variant==='baseline'?'legacy':'typed'])));
  }
  const median=values=>[...values].sort((a,b)=>a-b)[Math.floor(values.length/2)],summaries=[];
  for(const item of cases){const row={name:item.name},expected=records.upstream[0].find(r=>r.name===item.name).result;
   for(const variant of Object.keys(records)){const runs=records[variant].map(p=>p.find(r=>r.name===item.name));if(runs.every(r=>r===undefined))continue;for(const run of runs){assert(run);assert.equal(run.result,expected);}const processMedians=runs.map(r=>median(r.samplesMs));row[variant]={medianMs:median(processMedians),processMedians,processSpread:Math.max(...processMedians)/Math.min(...processMedians)};}
   row.currentOverUpstream=row.current.medianMs/row.upstream.medianMs;if(row.baseline)row.currentOverBaseline=row.current.medianMs/row.baseline.medianMs;summaries.push(row);
  }
  const report={utc:new Date().toISOString(),baselineCommit,baselineEngineSha256:sha(fs.readFileSync(path.join(folder,'web/engine.mjs'))),engineSha256:sha(fs.readFileSync(path.join(root,'web/engine.mjs'))),jarSha256:sha(fs.readFileSync(jar)),java:records.upstream[0][0].java,node:process.version,processesPerWorkload:5,warmupCalls:30,samplesPerProcess:15,callsPerSample:3,scope:'Twelve retained-config enumeration/count and enumeration/hash workloads, sixteen enumerations per call. Construction and result validation are outside timing. Fixed 0.18 comparison covers five resolved count workloads only: it materializes plain data; current and native retain typed values. Raw enumeration and entry hash have no equivalent old API. This is a functional upgrade cost comparison, not identical internal work.',unstableMeasurements:summaries.some(s=>['current','baseline','upstream'].some(v=>s[v]?.processSpread>1.5)),performanceParityEstablished:false,sourceHashes:sourceHashes(),summaries,records};
  fs.writeFileSync(path.join(root,'evidence/entry-performance.json'),JSON.stringify(report,null,2)+'\n');for(const s of summaries)console.log(s.name+' current/native='+s.currentOverUpstream.toFixed(3)+(s.baseline?' current/0.18='+s.currentOverBaseline.toFixed(3):''));
 }finally{assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
}
