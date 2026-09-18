import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
const hash=data=>createHash('sha256').update(data).digest('hex');
const root=fileURLToPath(new URL('../',import.meta.url));
const flat=Array.from({length:128},(_,i)=>'k'+i+'='+i).join('\n');
const nested=Array.from({length:64},(_,i)=>'k'+i+'={port='+i+',enabled=true,values=[1,2,3]}').join('\n');
const choices=['RED','GREEN','BLUE'];
const numbers='a=['+Array.from({length:128},(_,i)=>i%3===0?'"'+i+'"':i%3===1?String(i):String(i)+'.5').join(',')+']';
const objects='a=['+Array.from({length:64},(_,i)=>'{n='+i+',values=[1,2,3],flag=true}').join(',')+']';
const enums='a=['+Array.from({length:128},(_,i)=>choices[i%3]).join(',')+']';
const indexed='a={'+Array.from({length:128},(_,i)=>'"'+String(i).replace(/[0-9]/g,n=>String.fromCodePoint(0x660+Number(n)))+'"='+i).join(',')+'}';
const inputs=[
 {name:'parse-128',request:{source:flat}},
 {name:'fallback-64',request:{source:Array.from({length:64},(_,i)=>'k'+i+'={high=1}').join('\n'),fallbacks:[Array.from({length:64},(_,i)=>'k'+i+'={low=2}').join('\n')]}},
 {name:'number-list-128',newGetter:true,request:{source:numbers,getter:'number-list',path:'a'}},
 {name:'exact-number-scalar',newGetter:true,request:{source:'a="9223372036854775807"',getter:'number',path:'a'}},
 {name:'object-list-64',newGetter:true,request:{source:objects,getter:'object-list',path:'a'}},
 {name:'any-ref-nested-64',newGetter:true,request:{source:objects,getter:'any-ref',path:'a'}},
 {name:'enum-list-128',newGetter:true,request:{source:enums,getter:'enum-list',path:'a',enumChoices:choices}},
 {name:'unicode-index-list-128',newGetter:true,request:{source:indexed,getter:'number-list',path:'a'}},
];
if(process.argv[2]==='--worker'){
 const {inspect_json}=await import(pathToFileURL(process.argv[3]));
 for(const entry of inputs.filter(x=>process.argv[4]!=='baseline'||!x.newGetter)){
  const input=JSON.stringify(entry.request),samplesMs=[];let result;
  for(let i=-10;i<15;i++){const start=performance.now();for(let repeat=0;repeat<3;repeat++)result=inspect_json(input);if(i>=0)samplesMs.push((performance.now()-start)/3);}
  console.log(JSON.stringify({samplesMs,result}));
 }
}else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const baseline=spawnSync('git',['show','44f242c5446fb05db1dc2bb2e1f3ffbcc82b3246:web/engine.mjs'],{cwd:root,maxBuffer:16*1024*1024});assert.equal(baseline.status,0,String(baseline.stderr));
 const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-perf-'));
 const baselineFile=path.join(folder,'baseline.mjs');fs.writeFileSync(baselineFile,baseline.stdout);
 const current=fileURLToPath(new URL('../web/engine.mjs',import.meta.url));
 const records={baseline:[],current:[],upstream:[]};
 function run(command,args,input){const r=spawnSync(command,args,{input,encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:16*1024*1024});assert.equal(r.status,0,r.stderr||String(r.error));return r.stdout.trim().split(/\r?\n/).map(JSON.parse);}
 try{
  for(let campaign=0;campaign<5;campaign++){
   const order=campaign%2?['current','baseline','upstream']:['upstream','baseline','current'];
   for(const variant of order){
    records[variant].push(variant==='upstream'?run(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url)),'--benchmark'],inputs.map(x=>JSON.stringify(x.request)).join('\n')+'\n'):run(process.execPath,[fileURLToPath(import.meta.url),'--worker',variant==='current'?current:baselineFile,variant]));
   }
   console.log(`Completed performance campaign ${campaign+1}/5`);
  }
  const median=xs=>[...xs].sort((a,b)=>a-b)[Math.floor(xs.length/2)];
  const summaries=inputs.map((entry,i)=>{
   const expected=JSON.parse(records.upstream[0][i].result);
   const summary={name:entry.name,inputBytes:Buffer.byteLength(entry.request.source),output:expected};
   for(const variant of ['upstream','current',...(!entry.newGetter?['baseline']:[])]){
    const cases=records[variant].map(run=>run[i]);for(const c of cases)assert.deepEqual(JSON.parse(c.result),expected,entry.name+' '+variant);
    const processMedians=cases.map(c=>median(c.samplesMs));summary[variant]={processMedians,medianMs:median(processMedians),processSpread:Math.max(...processMedians)/Math.min(...processMedians)};
   }
   summary.currentOverUpstream=summary.current.medianMs/summary.upstream.medianMs;
   if(summary.baseline)summary.currentOverBaseline=summary.current.medianMs/summary.baseline.medianMs;
   return summary;
  });
  const unstableMeasurements=summaries.some(s=>['current','upstream','baseline'].some(k=>s[k]?.processSpread>2));
  const report={unstableMeasurements,performanceParityEstablished:false,utc:new Date().toISOString(),cpu:os.cpus()[0]?.model,node:process.version,java:records.upstream[0][0].java,processesPerVariant:5,warmupPerProcess:30,samplesPerProcess:15,executionsPerSample:3,baselineCommit:'44f242c5446fb05db1dc2bb2e1f3ffbcc82b3246',baselineEngineSha256:hash(baseline.stdout),engineSha256:hash(fs.readFileSync(current)),jarSha256:hash(fs.readFileSync(jar)),scope:'Warm end-to-end request JSON parse, HOCON parse/resolve/number-object-any-enum getters and Unicode index conversion, and JSON response rendering in Node/MoonBit and unmodified Lightbend Config. No startup, file I/O, peak memory or steady-load claim. Fixed alternating process order; equality checked for every process result.',summaries,records};
  fs.writeFileSync(new URL('../evidence/accessor-performance.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
  for(const s of summaries)console.log(JSON.stringify({name:s.name,baselineRatio:s.currentOverBaseline,upstreamRatio:s.currentOverUpstream}));
 }finally{assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
}
