import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {compare} from './migration-gate.mjs';
import {Config,loadFile} from './config.mjs';
const root=fileURLToPath(new URL('../',import.meta.url)),source=path.join(root,'examples/openwhisk');
const jar=process.env.HOCON_REFERENCE_JAR;
assert(jar,'Set HOCON_REFERENCE_JAR to an unmodified upstream jar');
const hash=data=>createHash('sha256').update(data).digest('hex');
const manifest=JSON.parse(fs.readFileSync(path.join(source,'SOURCE.json'),'utf8'));
for(const [name,digest] of Object.entries(manifest.files))assert.equal(hash(fs.readFileSync(path.join(source,name))),digest,name);
const file=path.join(source,'controller/application.conf'),fallbacks=[path.join(source,'controller/reference.conf')],classpath=[path.join(source,'resources')];
const baseline=compare({file,fallbacks,classpath,jar});
assert.equal(baseline.equivalent,true);assert.equal(baseline.pathsCompared,36);
assert.equal(baseline.localReadSet.length,4);
assert(baseline.localReadSet.some(x=>x.path.endsWith('pekko-http-version.conf')&&x.bytes===29));
assert(!JSON.stringify(baseline).includes('controller.pass'));
const options={fallbackFiles:fallbacks,classpath,environment:{},network:false};
const typed=[['int','pekko.http.server.default-http-port'],['string','pekko.http.server.bind-host'],
  ['duration','pekko.http.server.request-timeout'],['duration','pekko.http.server.idle-timeout'],
  ['bytes','pekko.http.server.parsing.max-content-length'],['boolean','pekko.http.server.stats-support'],
  ['boolean','pekko.http.server.transparent-head-requests'],['string','pekko.http.version'],
  ['string','whisk.controller.protocol'],['string','pekko.loglevel'],['string-list','ssl-config.enabledProtocols']];
const requests=typed.map(([getter,key])=>({file,fallbackFiles:fallbacks,classpath,environment:{},getter,path:key}));
const java=spawnSync(process.env.JAVA??'java',['-cp',jar,path.join(root,'tools/HoconOracle.java')],{
  input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:30000,maxBuffer:4*1024*1024});
assert.equal(java.status,0,java.stderr||String(java.error));
const references=java.stdout.trim().split(/\r?\n/).map(JSON.parse),config=Config.loadFile(file,options);
assert.equal(references.length,typed.length);
typed.forEach(([type,key],i)=>{assert(references[i].accepted);assert.deepEqual(config.get(key,{type}),references[i].value);});
// Optional include absence can make both implementations agree on an incomplete
// tree; a consumer must still require its own keys before using the result.
const missing=Config.loadFile(file,{...options,classpath:[]});
assert.throws(()=>missing.getString('pekko.http.version'),/missing/i);
assert.throws(()=>loadFile(file,{...options,onRead:1}),/onRead/);
assert.throws(()=>compare({file,jar,classpath:[file]}),/directory/);
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-public-'));
let changed;
try {
  fs.cpSync(source,temp,{recursive:true});
  const logging=path.join(temp,'resources/logging.conf');
  fs.writeFileSync(logging,fs.readFileSync(logging,'utf8').replace('loglevel = "DEBUG"','loglevel = "TRACE"'));
  changed=compare({file:path.join(temp,'controller/application.conf'),fallbacks:[path.join(temp,'controller/reference.conf')],classpath:[path.join(temp,'resources')],jar});
  assert(changed.equivalent);
  assert.equal(changed.sourceSha256,baseline.sourceSha256);
  assert.notEqual(changed.localReadSet.find(x=>x.path.endsWith('logging.conf')).sha256,baseline.localReadSet.find(x=>x.path.endsWith('logging.conf')).sha256);
  // A changed baseline is detected by values, while include fingerprint drift
  // remains observable even when both implementations read the same new file.
  const old=path.join(temp,'old.conf');
  fs.writeFileSync(old,'include required("'+file.replaceAll('\\','/')+'")\npekko.http.server.default-http-port=9999');
  const drift=compare({file,referenceFile:old,fallbacks,classpath,jar});
  assert.deepEqual(drift.differences,[{path:['pekko','http','server','default-http-port'],kind:'different-value-or-type'}]);
  fs.writeFileSync(old,'include required("missing-resource.conf")');
  assert.throws(()=>compare({file,referenceFile:old,fallbacks,classpath,jar}),/reference rejected/);
} finally {
  // Only this newly-created verified temporary directory is removed.
  assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));
  fs.rmSync(temp,{recursive:true,force:true});
}
const receipt={utc:new Date().toISOString(),referenceJarSha256:hash(fs.readFileSync(jar)),
  configPaths:36,typedGetters:typed.length,localReads:baseline.localReadSet.map(x=>({...x,path:path.relative(root,x.path).split(path.sep).join('/')})),
  equivalent:baseline.equivalent,checks:['actual upstream controller fragment','two real include resources','controller fallback','11 typed reads against live Java','missing optional include fails required getter','changed include recorded with unchanged main hash','changed old baseline detected','reference missing required include rejects','invalid observer and classpath rejected'],
  limits:['not full OpenWhisk runtimeClasspath or application execution','empty environment','local read audit is not atomic or a reference-side include trace'],
  engineSha256:hash(fs.readFileSync(path.join(root,'web/engine.mjs')))};
const output=process.env.HOCON_PUBLIC_EVIDENCE??path.join(root,'evidence/openwhisk-public.json');
fs.mkdirSync(path.dirname(output),{recursive:true});fs.writeFileSync(output,JSON.stringify(receipt,null,2)+'\n');
console.log(JSON.stringify(receipt,null,2));
