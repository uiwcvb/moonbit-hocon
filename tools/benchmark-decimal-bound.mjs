import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {sourceHashes} from './evidence.mjs';
const root=fileURLToPath(new URL('../',import.meta.url)),hash=data=>createHash('sha256').update(data).digest('hex');
const flat=Array.from({length:64},(_,i)=>'k'+i+'='+i).join('\n'),paths=Array.from({length:32},(_,i)=>'k'+(i*2));
const midpoint=5n**1075n*10n**1024n,midpointLiterals=[midpoint-1n,midpoint,midpoint+1n].map(n=>String(n)+'e-2099');
const cases=[
 {name:'legacy-parse-64',request:{source:flat}},
 {name:'legacy-fallback-32',request:{source:Array.from({length:32},(_,i)=>'k'+i+'={high=1}').join('\n'),fallbacks:[Array.from({length:32},(_,i)=>'k'+i+'={low=2}').join('\n')]}},
 {name:'retained-nested-int-32',mode:'int',source:'section={'+flat+'}',paths:paths.map(p=>'section.'+p),repeats:32},
 {name:'retained-quoted-int-32',mode:'int',source:'"section.with.dot"={"p.q"=17}',paths:Array(32).fill('"section.with.dot"."p.q"'),repeats:32},
 {name:'retained-int-32',mode:'int',source:flat,paths,repeats:32},
 {name:'retained-number-32',mode:'number',source:flat,paths,repeats:32},
 {name:'retained-child-32',mode:'child',source:'child={port=80,values=[1,2,3],label=service}',repeats:32},
 {name:'retained-period-32',mode:'period',source:'period=12months',repeats:32},
 {name:'immutable-edits-16',mode:'edits',source:flat,repeats:16},
 {name:'retained-resolve-16',mode:'resolve',source:'x=1\na=${x}\nb=[${x}]\nc=${a}',repeats:16},
];
const valueSource='child={'+flat+'}\nlist=[0,2,3,4,5,6,7,1]';
for(const mode of ['value-read','value-hash','value-cold-hash','value-equals','value-search','value-fallback'])cases.push({name:mode+'-32',mode,source:valueSource,repeats:32});
cases.push(
 {name:'render-json-object',mode:'render',source:flat,json:true,formatted:false,repeats:8},
 {name:'render-hocon-formatted',mode:'render',source:'service={host="example.test",port=8080,limits={requests=10,period="1 minute"},routes=[api,status,health]}',json:false,formatted:true,repeats:8},
 {name:'render-json-unresolved',mode:'render',source:'host=${HOST}\naddress="http://"${host}\nlist=[${?EXTRA},1,2]',json:true,formatted:false,repeats:8},
 {name:'render-hocon-merge',mode:'render',source:'a=${missing}\na={x=1}\na={y=2}',steps:[{op:'resolve',allowUnresolved:true}],json:false,formatted:true,repeats:8},
 {name:'render-json-floats',mode:'render',source:'values=['+Array.from({length:16},(_,i)=>(Math.PI*(i+1)*10**(-i*20)).toExponential()).join(',')+']',json:true,formatted:false,repeats:4},
 {name:'render-json-list',mode:'render',source:'values=['+Array.from({length:512},(_,i)=>i).join(',')+']',json:true,formatted:true,repeats:4},
);
cases.push(
 {name:'render-json-subnormals',mode:'render',source:'values=[5e-324,1e-323,2e-323,3e-323,4e-323,5e-323,6e-323,7e-323,-5e-324,-1e-323,-2e-323,-3e-323,-4e-323,-5e-323,-6e-323,-7e-323]',json:true,formatted:false,repeats:4},
 {name:'render-json-decimal-powers',mode:'render',source:'values=['+[-300,-200,-100,-20,-10,-4,-3,-2,-1,0,1,6,7,20,100,300].map(e=>'1e'+e).join(',')+']',json:true,formatted:false,repeats:4},
);
cases.push(
 {name:'render-json-long-tiny',mode:'render',source:'values=[2.'+'0'.repeat(800)+'1e-324,3.'+'0'.repeat(800)+'1e-324]',json:true,formatted:false,repeats:4},
 {name:'render-json-midpoint-long',mode:'render',source:'values=['+midpointLiterals.join(',')+']',json:true,formatted:false,repeats:4},
 ...[9007199254740991n,36028797018963966n].map((multiple,i)=>({name:'render-json-midpoint-'+['normal','upper-tiny'][i],mode:'render',source:'values=['+[-1n,0n,1n].map(delta=>String(multiple*midpoint+delta)+'e-2099').join(',')+']',json:true,formatted:false,repeats:4})),
 {name:'retained-double-tiny-list',mode:'double-read',source:'values=[5e-324,1e-323,2e-323,1e-308,2.2250738585072014e-308,-5e-324,\"-0.0\",0]',repeats:8},
 {name:'retained-double-ordinary-list',mode:'double-read',source:'values=[0.1,1.25,3.141592653589793,1e-22,1e23,1e100,-1.5,-1e200]',repeats:8},
);
cases.push({name:'retained-double-long-text-list',mode:'double-read',source:'values=['+midpointLiterals.map(JSON.stringify).join(',')+']',repeats:8});
if(process.argv[2]==='--worker'){
 const {inspect_json}=await import(pathToFileURL(process.argv[3]));
 const {Config,ConfigValue}=await import(pathToFileURL(process.argv[4]));
 for(const item of cases){
  if(item.mode?.startsWith('value-')&&!Config.prototype.getValue)continue;
  let work;
  if(item.mode==='double-read'){
   const config=Config.load(item.source);work=()=>Array.from({length:item.repeats},()=>config.getDoubleList('values'));
  }else if(item.mode==='render'){
   if(!ConfigValue.prototype.render)continue;
   let config=Config.parse(item.source);if(item.steps)config=config.resolve({allowUnresolved:true});const value=config.root();
   work=()=>Array.from({length:item.repeats},()=>value.render({json:item.json,formatted:item.formatted}));
  }else if(item.mode?.startsWith('value-')){
   const config=Config.load(item.source),child=config.getValue('child'),other=Config.load(item.source).getValue('child'),list=config.getList('list'),needle=Config.load('v=1').getValue('v'),fallback=Config.load('additional=2').root();
   work=()=>Array.from({length:item.repeats},()=>{
    if(item.mode==='value-read')return config.getValue('child').unwrapped();
    if(item.mode==='value-hash')return child.hashCode();
    if(item.mode==='value-cold-hash')return config.getValue('child').hashCode();
    if(item.mode==='value-equals')return child.equals(other);
    if(item.mode==='value-search')return list.indexOf(needle);
    return child.withFallback(fallback).unwrapped();
   });
  }else if(item.request){const input=JSON.stringify(item.request);work=()=>inspect_json(input);}
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
  if(item.mode==='double-read'){const buffer=new ArrayBuffer(8),view=new DataView(buffer);result=result.map(row=>row.map(n=>{view.setFloat64(0,n);return view.getBigInt64(0).toString();}));}
  console.log(JSON.stringify({name:item.name,samplesMs,result:item.request?result:JSON.stringify(result)}));
 }
}else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const baselineCommit='fbc571fe67fb0e9f41003351746ce1c73679ae1a';
 const baseline=spawnSync('git',['show',baselineCommit+':web/engine.mjs'],{cwd:root,maxBuffer:16*1024*1024});assert.equal(baseline.status,0,String(baseline.stderr));
 const folder=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-decimal-bound-')),baselineFile=path.join(folder,'web/engine.mjs');
 const list=spawnSync('git',['ls-tree','-r','--name-only',baselineCommit,'--','tools','web/engine.mjs'],{cwd:root,encoding:'utf8'});assert.equal(list.status,0,list.stderr);
 for(const relative of list.stdout.trim().split(/\r?\n/).filter(name=>name.endsWith('.mjs'))){
  const blob=spawnSync('git',['show',baselineCommit+':'+relative],{cwd:root,maxBuffer:16*1024*1024});assert.equal(blob.status,0,String(blob.stderr));
  const target=path.join(folder,relative);fs.mkdirSync(path.dirname(target),{recursive:true});fs.writeFileSync(target,blob.stdout);
 }
 fs.writeFileSync(path.join(folder,'package.json'),'{"type":"module"}\n');
 const current=fileURLToPath(new URL('../web/engine.mjs',import.meta.url)),oracle=fileURLToPath(new URL('./HoconOracle.java',import.meta.url));
 const records={baseline:[],current:[],upstream:[]};
 function run(command,args,input){const r=spawnSync(command,args,{input,encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:32*1024*1024});assert.equal(r.status,0,r.stderr||String(r.error));return r.stdout.trim().split(/\r?\n/).map(JSON.parse);}
 try{
  for(let campaign=0;campaign<5;campaign++){
   for(const variant of campaign%2?['current','baseline','upstream']:['upstream','baseline','current']){
    if(variant==='upstream'){
     const legacy=run(process.env.JAVA??'java',['-cp',jar,oracle,'--benchmark'],cases.slice(0,2).map(c=>JSON.stringify(c.request)).join('\n')+'\n');
     const retained=run(process.env.JAVA??'java',['-cp',jar,oracle,'--retained-benchmark'],cases.slice(2,10).map(JSON.stringify).join('\n')+'\n');
     const values=run(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./ValueOracle.java',import.meta.url)),'--benchmark'],cases.slice(10,16).map(JSON.stringify).join('\n')+'\n');
     const renders=run(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./RenderOracle.java',import.meta.url)),'--benchmark'],cases.slice(16).filter(c=>c.mode==='render').map(JSON.stringify).join('\n')+'\n');
     const reads=run(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./DoubleReadOracle.java',import.meta.url))],cases.filter(c=>c.mode==='double-read').map(JSON.stringify).join('\n')+'\n');
     records.upstream.push([...legacy,...retained,...values,...renders,...reads].map((row,i)=>({...row,name:cases[i].name})));
    }else records[variant].push(run(process.execPath,[fileURLToPath(import.meta.url),'--worker',variant==='current'?current:baselineFile,variant==='current'?fileURLToPath(new URL('./config-object.mjs',import.meta.url)):path.join(folder,'tools/config-object.mjs')]));
   }
   console.log('Completed rendering performance campaign '+(campaign+1)+'/5');
  }
  const median=xs=>[...xs].sort((a,b)=>a-b)[Math.floor(xs.length/2)];
  const summaries=cases.map(item=>{
   const expected=JSON.parse(records.upstream[0].find(c=>c.name===item.name).result),summary={name:item.name,scope:item.request?'request JSON through response JSON, including parse and resolve':'already parsed Config objects; typed reads or immutable operations; result serialization outside timing',output:expected};
   for(const variant of ['upstream','current','baseline']){
    const rows=records[variant].map(run=>run.find(c=>c.name===item.name));if(rows.every(row=>row===undefined))continue;for(const row of rows)assert.deepEqual(JSON.parse(row.result),expected,item.name+' '+variant);
    const processMedians=rows.map(row=>median(row.samplesMs));summary[variant]={processMedians,medianMs:median(processMedians),processSpread:Math.max(...processMedians)/Math.min(...processMedians)};
   }
   summary.currentOverUpstream=summary.current.medianMs/summary.upstream.medianMs;
   if(summary.baseline)summary.currentOverBaseline=summary.current.medianMs/summary.baseline.medianMs;
   return summary;
  });
  const report={utc:new Date().toISOString(),cpu:os.cpus()[0]?.model,node:process.version,java:records.upstream[0][0].java,processesPerWorkload:5,warmupPerProcess:30,samplesPerProcess:15,executionsPerSample:3,baselineCommit,baselineEngineSha256:hash(baseline.stdout),engineSha256:hash(fs.readFileSync(current)),jarSha256:hash(fs.readFileSync(jar)),sourceHashes:sourceHashes(),performanceParityEstablished:false,unstableMeasurements:summaries.some(s=>['current','upstream','baseline'].some(k=>s[k]?.processSpread>2)),scope:'Twelve exact-render workloads, sixteen existing workloads and three retained Double-list reads compare current, fixed 0.20 and native Config. Long coefficients exercise conclusive prefix intervals and exact midpoint boundaries at zero, the normal transition and decimal magnitude -308; current uses the proven decimal grid bound and baseline retains its runtime fallback. Double-list output is compared as exact binary64 bit strings, converted after timing; public getDoubleList calls and list construction occur inside timing. Render timers retain the prepared ConfigValue; Java retains options and JS constructs its options object inside each call and include returned text; source parsing, optional partial resolution and final result-array serialization are excluded. The full baseline JS module dependency tree is loaded from the fixed Git commit. Retained workloads compare real Config methods with native Config; construction excluded, immutable operations/getter transport included, final result serialization excluded. Each workload has five fresh processes; Java legacy and retained workloads use separate processes. Startup, I/O and sustained/peak-memory parity are not measured.',summaries,records};
  fs.writeFileSync(new URL('../evidence/decimal-bound-performance.json',import.meta.url),JSON.stringify(report,null,2)+'\n');for(const s of summaries)console.log(JSON.stringify({name:s.name,baselineRatio:s.currentOverBaseline,upstreamRatio:s.currentOverUpstream}));
 }finally{assert(path.resolve(folder).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(folder,{recursive:true,force:true});}
}
