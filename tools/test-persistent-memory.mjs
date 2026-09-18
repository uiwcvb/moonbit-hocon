import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {Config} from './config-object.mjs';
import {sourceHashes} from './evidence.mjs';
if(process.argv.includes('--worker')){
 assert(global.gc,'Run worker with --expose-gc');
 const kept=Config.load('kept=1');let collected=0;
 const registry=new FinalizationRegistry(()=>collected++),rounds=[];
 async function settle(){for(let i=0;i<3;i++){global.gc();await new Promise(resolve=>setImmediate(resolve));}}
 await settle();const baseline=process.memoryUsage().heapUsed;
 for(let round=0;round<6;round++){
  for(let i=0;i<400;i++){const config=Config.load('a={x=[1,2,3],s="'+('data'.repeat(128))+'"}');registry.register(config,round*400+i);assert.equal(config.getConfig('a').getIntList('x')[2],3);}
  await settle();rounds.push(process.memoryUsage().heapUsed);
 }
 await settle();assert.equal(kept.getInt('kept'),1);assert(collected>=2000,'Unreachable Config objects were not collected');
 assert(Math.max(...rounds)-baseline<64*1024*1024,'Retained heap growth exceeded 64 MiB');
 console.log(JSON.stringify({created:2400,collected,baselineHeapBytes:baseline,afterGCRoundHeapBytes:rounds,maxRetainedGrowthBytes:Math.max(...rounds)-baseline,retainedControlReadable:true}));
}else{
 const run=spawnSync(process.execPath,['--expose-gc',fileURLToPath(import.meta.url),'--worker'],{encoding:'utf8',windowsHide:true,timeout:90000});assert.equal(run.status,0,run.stderr||String(run.error));
 const observed=JSON.parse(run.stdout);fs.writeFileSync(new URL('../evidence/persistent-memory.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),passed:true,node:process.version,scope:'Bounded V8 collection check for 2400 released Config objects, six rounds with explicit GC, and one retained readable control. Does not prove peak-memory, long-running or upstream memory parity.',observed,sourceHashes:sourceHashes()},null,2)+'\n');console.log('Persistent Config bounded collection check passed: '+observed.collected+'/2400 collected');
}
