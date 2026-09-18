import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
const root=fileURLToPath(new URL('../',import.meta.url)),hash=data=>createHash('sha256').update(data).digest('hex');
const flat=Array.from({length:64},(_,i)=>'k'+i+'='+i).join('\n'),paths=Array.from({length:32},(_,i)=>'k'+(i*2));
const cases=[
 {name:'legacy-parse-64',request:{source:flat}},
 {name:'legacy-fallback-32',request:{source:Array.from({length:32},(_,i)=>'k'+i+'={high=1}').join('\n'),fallbacks:[Array.from({length:32},(_,i)=>'k'+i+'={low=2}').join('\n')]}},
 {name:'retained-int-32',mode:'int',source:flat,paths,repeats:32},
 {name:'retained-number-32',mode:'number',source:flat,paths,repeats:32},
 {name:'retained-child-32',mode:'child',source:'child={port=80,values=[1,2,3],label=service}',repeats:32},
 {name:'retained-period-32',mode:'period',source:'period=12months',repeats:32},
 {name:'immutable-edits-16',mode:'edits',source:flat,repeats:16},
 {name:'retained-resolve-16',mode:'resolve',source:'x=1\na=${x}\nb=[${x}]\nc=${a}',repeats:16},
];
if(process.argv[2]==='--worker'){
 const {inspect_json}=await import(pathToFileURL(process.argv[3]));
 const Config=process.argv[4]==='baseline'?null:(await import('./config-object.mjs')).Config;
 for(const item of cases.filter(c=>Config||c.request)){
  let work;
  if(item.request){const input=JSON.stringify(item.request);work=()=>inspect_json(input);}
  else{
   const config=Config[item.mode==='resolve'?'parse':'load'](item.source);
   work=()=>{
    if(item.mode==='int')return item.paths.map(p=>config.getInt(p));
    if(item.mode==='number')return item.paths.map(p=>config.getNumber(p));
    if(item.mode==='child')return Array.from({length:item.repeats},()=>config.getConfig('child').getInt('port'));
    if(item.mode==='period')return Array.from({length:item.repeats},()=>config.getPeriod('period'));
    if(item.mode==='edits')return Array.from({length:item.repeats},(_,i)=>config.withValue('counter',i).toJSON());
    return Array.from({length:item.repeats},()=>config.resolve().toJSON());
   };
  }
  let result;const samplesMs=[];
  for(let i=-10;i<15;i++){const start=performance.now();for(let repeat=0;repeat<3;repeat++)result=work();if(i>=0)samplesMs.push((performance.now()-start)/3);}
  console.log(JSON.stringify({name:item.name,samplesMs,result:item.request?result:JSON.stringify(result)}));
 }
}else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const baselineCommit='a469b59e5103c38e7b3a601ec25d3c48dfe1e302';
 const baseline=spawnSync('git',['show',baselineCommit+':web/engine.mjs'],{cwd:root,maxBuffer:16*1024*1024});assert.equal(baseline.status,0,String(baseline.stderr));
 const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-persistent-perf-')),baselineFile=path.join(folder,'baseline.mjs');fs.writeFileSync(baselineFile,baseline.stdout);
 const current=fileURLToPath(new URL('../web/engine.mjs',import.meta.url)),oracle=fileURLToPath(new URL('./HoconOracle.java',import.meta.url));
 const records={baseline:[],current:[],upstream:[]};
 function run(command,args,input){const r=spawnSync(command,args,{input,encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:32*1024*1024});assert.equal(r.status,0,r.stderr||String(r.error));return r.stdout.trim().split(/\r?\n/).map(JSON.parse);}
 try{
  for(let campaign=0;campaign<5;campaign++){
   for(const variant of campaign%2?['current','baseline','upstream']:['upstream','baseline','current']){
    if(variant==='upstream'){
     const legacy=run(process.env.JAVA??'java',['-cp',jar,oracle,'--benchmark'],cases.slice(0,2).map(c=>JSON.stringify(c.request)).join('\n')+'\n');
     const retained=run(process.env.JAVA??'java',['-cp',jar,oracle,'--retained-benchmark'],cases.slice(2).map(JSON.stringify).join('\n')+'\n');
     records.upstream.push([...legacy,...retained].map((row,i)=>({...row,name:cases[i].name})));
    }else records[variant].push(run(process.execPath,[fileURLToPath(import.meta.url),'--worker',variant==='current'?current:baselineFile,variant]));
   }
   console.log('Completed persistent performance campaign '+(campaign+1)+'/5');
  }
  const median=xs=>[...xs].sort((a,b)=>a-b)[Math.floor(xs.length/2)];
  const summaries=cases.map(item=>{
   const expected=JSON.parse(records.upstream[0].find(c=>c.name===item.name).result),summary={name:item.name,scope:item.request?'request JSON through response JSON, including parse and resolve':'already parsed Config objects; typed reads or immutable operations; result serialization outside timing',output:expected};
   for(const variant of ['upstream','current',...(item.request?['baseline']:[])]){
    const rows=records[variant].map(run=>run.find(c=>c.name===item.name));for(const row of rows)assert.deepEqual(JSON.parse(row.result),expected,item.name+' '+variant);
    const processMedians=rows.map(row=>median(row.samplesMs));summary[variant]={processMedians,medianMs:median(processMedians),processSpread:Math.max(...processMedians)/Math.min(...processMedians)};
   }
   summary.currentOverUpstream=summary.current.medianMs/summary.upstream.medianMs;
   if(summary.baseline)summary.currentOverBaseline=summary.current.medianMs/summary.baseline.medianMs;
   return summary;
  });
  const report={utc:new Date().toISOString(),cpu:os.cpus()[0]?.model,node:process.version,java:records.upstream[0][0].java,processesPerWorkload:5,warmupPerProcess:30,samplesPerProcess:15,executionsPerSample:3,baselineCommit,baselineEngineSha256:hash(baseline.stdout),engineSha256:hash(fs.readFileSync(current)),jarSha256:hash(fs.readFileSync(jar)),performanceParityEstablished:false,unstableMeasurements:summaries.some(s=>['current','upstream','baseline'].some(k=>s[k]?.processSpread>2)),scope:'Two old JSON-request workloads compare fixed 0.10, current and native adapters. Six retained-object workloads compare real Config methods with native Config; construction excluded, immutable operations/getter transport included, final result serialization excluded. Each workload has five fresh processes; Java legacy and retained workloads use separate processes. Startup, I/O and sustained/peak-memory parity are not measured.',summaries,records};
  fs.writeFileSync(new URL('../evidence/persistent-performance.json',import.meta.url),JSON.stringify(report,null,2)+'\n');for(const s of summaries)console.log(JSON.stringify({name:s.name,baselineRatio:s.currentOverBaseline,upstreamRatio:s.currentOverUpstream}));
 }finally{assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
}
