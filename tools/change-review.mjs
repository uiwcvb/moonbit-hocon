import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
import {Config} from './config.mjs';

const hash=bytes=>createHash('sha256').update(bytes).digest('hex');
function descriptor(value){
  if(!value||typeof value.file!=='string')throw new TypeError('Each configuration needs a file');
  const fallbackFiles=value.fallbackFiles??[],classpath=value.classpath??[];
  for(const list of [fallbackFiles,classpath])if(!Array.isArray(list)||list.length>64||list.some(x=>typeof x!=='string'))throw new TypeError('Paths must be arrays of at most 64 strings');
  for(const dir of classpath)if(!fs.statSync(dir).isDirectory())throw new TypeError('Classpath entry must be a directory');
  return {file:path.resolve(value.file),fallbackFiles,classpath};
}

/** Read trusted local configurations and apply exact change permissions in MoonBit. */
export function reviewFiles({before,after,rules=[]}){
  const reads=new Map(),sides={before:[],after:[]};
  const load=(value,side)=>{
    const spec=descriptor(value);
    return Config.loadFile(spec.file,{fallbackFiles:spec.fallbackFiles,classpath:spec.classpath,network:false,environment:{},onRead:event=>{
      const previous=reads.get(event.path);
      if(previous&&previous.sha256!==event.sha256)throw Error('Configuration changed while reading: '+event.path);
      reads.set(event.path,event);
      if(!sides[side].some(x=>x.path===event.path))sides[side].push(event);
    }});
  };
  const old=load(before,'before'),next=load(after,'after');
  const report=old.reviewChanges(next,rules);
  for(const event of reads.values())if(hash(fs.readFileSync(event.path))!==event.sha256)throw Error('Configuration changed during review: '+event.path);
  for(const list of Object.values(sides))list.sort((a,b)=>a.path.localeCompare(b.path));
  return {...report,readSets:sides,scope:'trusted local files; explicit fallback and classpath; empty environment; no HTTP; exact permissions, not deployment safety; read recheck is not an atomic snapshot'};
}

function parse(args){
  const value={before:{fallbackFiles:[],classpath:[]},after:{fallbackFiles:[],classpath:[]}};
  let policy;
  for(let i=0;i<args.length;i++){
    const flag=args[i],arg=args[++i];
    if(!arg||!['--before','--after','--policy','--before-fallback','--after-fallback','--before-classpath','--after-classpath'].includes(flag))throw Error('Usage: node tools/change-review.mjs --before old.conf --after new.conf --policy permissions.json [--before-fallback FILE] [--after-fallback FILE] [--before-classpath DIR] [--after-classpath DIR]');
    if(flag==='--policy'){if(policy)throw Error('Duplicate policy');policy=arg;continue;}
    const parts=flag.slice(2).split('-'),target=value[parts[0]];
    if(parts.length===1){if(target.file)throw Error('Duplicate input');target.file=arg;}
    else target[parts[1]==='fallback'?'fallbackFiles':'classpath'].push(arg);
  }
  if(!policy)throw Error('A policy file is required; use [] to reject all changes');
  const stat=fs.statSync(policy);
  if(!stat.isFile()||stat.size>524288)throw Error('Policy must be a regular JSON file of at most 524288 bytes');
  value.rules=JSON.parse(fs.readFileSync(policy,'utf8'));
  return value;
}

if(process.argv[1]&&path.resolve(process.argv[1])===fileURLToPath(import.meta.url)){
  try{const report=reviewFiles(parse(process.argv.slice(2)));process.stdout.write(JSON.stringify(report,null,2)+'\n');if(!report.accepted)process.exitCode=2;}
  catch(error){process.stderr.write(error.message+'\n');process.exitCode=1;}
}
