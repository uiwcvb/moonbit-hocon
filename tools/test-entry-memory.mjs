import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {Config} from './config.mjs';
import {sourceHashes} from './evidence.mjs';
if(process.argv.includes('--worker')){
 assert(global.gc);const collected={config:0,set:0,entry:0,value:0},registry=new FinalizationRegistry(kind=>collected[kind]++),rounds=[];
 const retained=[...Config.parse('values=[1,{x=2}]').entrySet()][0].getValue();
 async function settle(){for(let n=0;n<3;n++){global.gc();await new Promise(resolve=>setImmediate(resolve));}}
 await settle();const baselineHeapBytes=process.memoryUsage().heapUsed;
 for(let round=0;round<6;round++){
  for(let i=0;i<400;i++){
   const config=Config.parse('values=[1,{x=2}],other=${missing}'),set=config.entrySet(),entry=[...set].find(e=>e.getKey()==='values'),value=entry.getValue();
   for(const [kind,object] of Object.entries({config,set,entry,value}))registry.register(object,kind);
   assert.equal(value.get(1).get('x').unwrapped(),2);set.clear();
  }
  await settle();rounds.push(process.memoryUsage().heapUsed);
 }
 await settle();for(const count of Object.values(collected))assert(count>=2000,JSON.stringify(collected));assert.deepEqual(retained.unwrapped(),[1,{x:2}]);const maxRetainedGrowthBytes=Math.max(...rounds)-baselineHeapBytes;assert(maxRetainedGrowthBytes<64*1024*1024);
 console.log(JSON.stringify({createdPerKind:2400,collected,baselineHeapBytes,afterGCRoundHeapBytes:rounds,maxRetainedGrowthBytes,retainedLeafReadable:true}));
}else{
 const run=spawnSync(process.execPath,['--expose-gc',fileURLToPath(import.meta.url),'--worker'],{encoding:'utf8',windowsHide:true,timeout:90000});assert.equal(run.status,0,run.stderr||String(run.error));const observed=JSON.parse(run.stdout);
 fs.writeFileSync(new URL('../evidence/entry-memory.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),passed:true,node:process.version,scope:'Six bounded explicit-GC rounds of 2400 released Config, set, entry and value wrappers each, plus a retained readable leaf. This does not establish peak, long-term or native memory parity.',observed,sourceHashes:sourceHashes()},null,2)+'\n');console.log('Entry wrapper bounded collection passed: '+JSON.stringify(observed.collected));
}
