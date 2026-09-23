import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {loadFile} from './config.mjs';

const oracle=fileURLToPath(new URL('./HoconOracle.java',import.meta.url));
const hash=data=>createHash('sha256').update(data).digest('hex');

function inputFile(name){
  const absolute=path.resolve(name),stat=fs.statSync(absolute);
  if(!stat.isFile()||stat.size>400000)throw Error('Configuration must be a regular file of at most 400000 bytes: '+name);
  return absolute;
}

function sorted(value){
  if(Array.isArray(value))return value.map(sorted);
  if(value!==null&&typeof value==='object')return Object.fromEntries(Object.keys(value).sort().map(key=>[key,sorted(value[key])]));
  if(typeof value==='number'&&Number.isInteger(value)&&!Number.isSafeInteger(value))throw Error('Value outside safe JSON integer range; use a typed migration check');
  return value;
}

function leaves(value,path=[],out=new Map()){
  if(value!==null&&typeof value==='object'&&!Array.isArray(value)){
    const keys=Object.keys(value);
    if(!keys.length)out.set(JSON.stringify(path),hash('{}'));
    for(const key of keys)leaves(value[key],[...path,key],out);
  }else out.set(JSON.stringify(path),hash(JSON.stringify(sorted(value))));
  return out;
}

function parse(args){
  const options={fallbacks:[]};
  for(let i=0;i<args.length;i++){
    const key=args[i];
    if(!['--file','--reference-file','--fallback','--jar'].includes(key)||!args[i+1])throw Error('Usage: node tools/migration-gate.mjs --file application.conf --jar config-1.4.9.jar [--fallback defaults.conf] [--reference-file old.conf]');
    const value=args[++i];
    if(key==='--fallback')options.fallbacks.push(inputFile(value));
    else if(key==='--file')options.file=inputFile(value);
    else if(key==='--reference-file')options.referenceFile=inputFile(value);
    else options.jar=inputFile(value);
  }
  if(!options.file||!options.jar)throw Error('Both --file and --jar are required');
  return options;
}

export function compare({file,referenceFile=file,fallbacks=[],jar,java=process.env.JAVA??'java'}){
  const application=inputFile(file),reference=inputFile(referenceFile),defaults=fallbacks.map(inputFile),referenceJar=inputFile(jar);
  const local=sorted(loadFile(application,{fallbackFiles:defaults,network:false,environment:{}}));
  const request={file:reference,fallbackFiles:defaults,environment:{}};
  const run=spawnSync(java,['-cp',referenceJar,oracle],{input:JSON.stringify(request)+'\n',encoding:'utf8',windowsHide:true,timeout:30000,maxBuffer:4*1024*1024});
  if(run.error||run.status!==0)throw Error('Lightbend reference could not run: '+(run.error?.message??run.stderr.trim().slice(0,300)));
  const lines=run.stdout.trim().split(/\r?\n/);
  if(lines.length!==1)throw Error('Lightbend reference returned an invalid response count');
  const result=JSON.parse(lines[0]);
  if(!result.accepted)throw Error('Lightbend reference rejected the configuration: '+(result.error??'unknown'));
  const expected=leaves(result.value),actual=leaves(local),differences=[];
  for(const key of new Set([...expected.keys(),...actual.keys()])){
    if(expected.get(key)===actual.get(key))continue;
    differences.push({path:JSON.parse(key),kind:!expected.has(key)?'only-in-moonbit':!actual.has(key)?'only-in-lightbend':'different-value-or-type'});
  }
  differences.sort((a,b)=>JSON.stringify(a.path).localeCompare(JSON.stringify(b.path)));
  return {equivalent:!differences.length,pathsCompared:new Set([...expected.keys(),...actual.keys()]).size,differences,sourceSha256:hash(fs.readFileSync(application)),referenceSha256:hash(fs.readFileSync(reference)),fallbackSha256:defaults.map(name=>hash(fs.readFileSync(name))),referenceJarSha256:hash(fs.readFileSync(referenceJar)),scope:'trusted local files; explicit empty environment; MoonBit HTTP disabled; JSON-safe values; no production traffic'};
}

if(process.argv[1]&&path.resolve(process.argv[1])===fileURLToPath(import.meta.url)){
  try{
    const report=compare(parse(process.argv.slice(2)));
    process.stdout.write(JSON.stringify(report,null,2)+'\n');
    if(!report.equivalent)process.exitCode=2;
  }catch(error){process.stderr.write(error.message+'\n');process.exitCode=1;}
}
