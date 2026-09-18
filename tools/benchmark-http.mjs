import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {fork,spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {createHash} from 'node:crypto';
const hash=data=>createHash('sha256').update(data).digest('hex');
const root=fileURLToPath(new URL('../',import.meta.url));
const caFile=fileURLToPath(new URL('./fixtures/http-cert.pem',import.meta.url));

if(process.argv[2]==='--worker'){
 const api=await import(pathToFileURL(process.argv[3])),input=JSON.parse(fs.readFileSync(process.argv[4],'utf8')),mode=process.argv[5];
 const ca=fs.readFileSync(caFile,'utf8');
 for(const entry of input.filter(x=>mode==='baseline'?!x.request.url:mode==='async'?x.async:true)){
  const encoded=JSON.stringify(entry.request),samplesMs=[];let result;
  const warmup=mode==='async'?3:10,samples=mode==='async'?7:15,repeats=mode==='async'?1:3;
  for(let i=-warmup;i<samples;i++){
   const start=performance.now();
   for(let j=0;j<repeats;j++){
    const request=JSON.parse(encoded),options={...request,network:{ca}};
    const value=mode==='async'?await api.loadURLAsync(request.url,options):request.url?api.loadURL(request.url,options):api.load(request.source,options);
    result=JSON.stringify({accepted:true,value});
   }
   if(i>=0)samplesMs.push((performance.now()-start)/repeats);
  }
  console.log(JSON.stringify({name:entry.name,samplesMs,result}));
 }
}else{
 const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-http-perf-'));let server;
 function run(command,args,input){const r=spawnSync(command,args,{input,encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:16*1024*1024});assert.equal(r.status,0,r.stderr||String(r.error));return r.stdout.trim().split(/\r?\n/).map(JSON.parse);}
 try{
  const fixtures={'/small.conf':{body:'host=api\nport=8080'},'/tree.conf':{body:'include "part1.conf"\ninclude "part2.conf"\ninclude "part3.conf"\nroot=1'},'/part1.conf':{body:'a=1'},'/part2.conf':{body:'b=2'},'/part3.conf':{body:'c=3'},'/large.json':{body:JSON.stringify(Object.fromEntries(Array.from({length:256},(_,i)=>['k'+i,i]))),headers:{'Content-Type':'application/json'}}};
  const fixtureFile=path.join(temp,'fixtures.json');fs.writeFileSync(fixtureFile,JSON.stringify(fixtures));
  server=fork(fileURLToPath(new URL('./http-test-server.mjs',import.meta.url)),[fixtureFile],{windowsHide:true,stdio:['ignore','ignore','pipe','ipc']});
  let errors='';server.stderr.on('data',chunk=>errors+=chunk);
  const timer=setTimeout(()=>server.kill(),10000);
  const [addresses]=await Promise.race([once(server,'message'),once(server,'exit').then(()=>{throw new Error('Fixture startup: '+errors);})]);clearTimeout(timer);
  const entries=[
   {name:'local-flat-128',request:{source:Array.from({length:128},(_,i)=>'k'+i+'='+i).join('\n')}},
   {name:'local-fallback-64',request:{source:Array.from({length:64},(_,i)=>'k'+i+'={high=1}').join('\n'),fallbacks:[Array.from({length:64},(_,i)=>'k'+i+'={low=2}').join('\n')]}},
   {name:'http-small',async:true,request:{url:addresses.http+'/small.conf'}},
   {name:'http-tree',async:true,request:{url:addresses.http+'/tree.conf'}},
   {name:'https-small',request:{url:addresses.https+'/small.conf'}},
   {name:'http-json-256',request:{url:addresses.http+'/large.json'}},
  ];
  const inputsFile=path.join(temp,'inputs.json');fs.writeFileSync(inputsFile,JSON.stringify(entries));
  const baseline='97d7be6f64e67571b4aa1b0ab5905b1d1a9f61e6',baselineDir=path.join(temp,'baseline');
  for(const file of ['tools/config.mjs','web/engine.mjs']){const result=spawnSync('git',['show',baseline+':'+file],{cwd:root,maxBuffer:16*1024*1024});assert.equal(result.status,0,String(result.stderr));const dest=path.join(baselineDir,file);fs.mkdirSync(path.dirname(dest),{recursive:true});fs.writeFileSync(dest,result.stdout);}
  const trust=path.join(temp,'trust.p12'),jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
  const imported=spawnSync(process.env.KEYTOOL??'keytool',['-importcert','-noprompt','-alias','local-test','-file',caFile,'-keystore',trust,'-storetype','PKCS12','-storepass','local-test-only'],{windowsHide:true,encoding:'utf8',timeout:15000});assert.equal(imported.status,0,imported.stderr||String(imported.error));
  const records={baseline:[],current:[],upstream:[],async:[]};
  for(let campaign=0;campaign<5;campaign++){
   for(const mode of campaign%2?['current','baseline','upstream','async']:['upstream','baseline','current','async']){
    records[mode].push(mode==='upstream'?run(process.env.JAVA??'java',['-Djavax.net.ssl.trustStore='+trust,'-Djavax.net.ssl.trustStorePassword=local-test-only','-Dsun.net.client.defaultConnectTimeout=5000','-Dsun.net.client.defaultReadTimeout=5000','-cp',jar,fileURLToPath(new URL('./HoconOracle.java',import.meta.url)),'--benchmark'],entries.map(x=>JSON.stringify(x.request)).join('\n')+'\n'):run(process.execPath,[fileURLToPath(import.meta.url),'--worker',mode==='baseline'?path.join(baselineDir,'tools/config.mjs'):fileURLToPath(new URL('./config.mjs',import.meta.url)),inputsFile,mode]));
   }
   console.log(`HTTP performance campaign ${campaign+1}/5 complete`);
  }
  const median=values=>[...values].sort((a,b)=>a-b)[Math.floor(values.length/2)];
  const summaries=entries.map((entry,i)=>{
   const expected=JSON.parse(records.upstream[0][i].result),summary={name:entry.name};
   for(const mode of ['current','upstream',...(!entry.request.url?['baseline']:[]),...(entry.async?['async']:[])]){
    const runs=records[mode].map(run=>mode==='upstream'?run[i]:run.find(x=>x.name===entry.name));
    for(const r of runs)assert.deepEqual(JSON.parse(r.result),expected,entry.name+' '+mode);
    const processMedians=runs.map(r=>median(r.samplesMs));summary[mode]={processMedians,medianMs:median(processMedians),processSpread:Math.max(...processMedians)/Math.min(...processMedians)};
   }
   summary.currentOverUpstream=summary.current.medianMs/summary.upstream.medianMs;
   if(summary.baseline)summary.currentOverBaseline=summary.current.medianMs/summary.baseline.medianMs;
   if(summary.async)summary.asyncOverSync=summary.async.medianMs/summary.current.medianMs;
   return summary;
  });
  const unstable=summaries.some(s=>['current','baseline','upstream','async'].some(k=>s[k]?.processSpread>2));
  const report={utc:new Date().toISOString(),cpu:os.cpus()[0]?.model,node:process.version,java:records.upstream[0][0].java,processesPerVariant:5,unstableMeasurements:unstable,performanceParityEstablished:false,baselineCommit:baseline,engineSha256:hash(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))),hostSha256:hash(fs.readFileSync(new URL('./config.mjs',import.meta.url))),jarSha256:hash(fs.readFileSync(jar)),scope:'Loopback HTTP/HTTPS fixture; request JSON decoding, configuration source fetch/parse/resolve and response JSON encoding. Sync: 30 warmups, 15 samples of three executions per process; async: three warmups, seven single-call samples using the reusable bounded worker pool. Java default keep-alive and bounded Node agent reuse. Startup of each benchmark process excluded; a process-median max/min spread above 2 is flagged as unstable. No WAN, sustained load, peak memory or cross-platform claim.',summaries,records};
  fs.writeFileSync(new URL('../evidence/http-performance.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
  for(const entry of summaries)console.log(JSON.stringify(entry));
 }finally{
  if(server&&server.exitCode===null){const exited=once(server,'exit');if(server.connected)server.send('stop');const timer=setTimeout(()=>server.kill(),2000);await exited;clearTimeout(timer);}
  assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});
 }
}
