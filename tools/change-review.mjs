import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
import {Config} from './config.mjs';

const hash=bytes=>createHash('sha256').update(bytes).digest('hex');

/** Parse policy JSON without exposing expected values in syntax diagnostics. */
export function parseChangePolicy(text){
  if(typeof text!=='string')throw new TypeError('Policy JSON must be a string');
  try{return JSON.parse(text);}
  catch{throw new Error('Policy must contain valid JSON');}
}

function descriptor(value){
  if(!value||typeof value.file!=='string')throw new TypeError('Each configuration needs a file');
  const fallbackFiles=value.fallbackFiles??[],classpath=value.classpath??[];
  for(const list of [fallbackFiles,classpath])if(!Array.isArray(list)||list.length>64||list.some(x=>typeof x!=='string'))throw new TypeError('Paths must be arrays of at most 64 strings');
  for(const dir of classpath)if(!fs.statSync(dir).isDirectory())throw new TypeError('Classpath entry must be a directory');
  return {file:path.resolve(value.file),fallbackFiles,classpath};
}

/** Read trusted local configurations and apply exact change permissions in MoonBit. */
export function reviewFiles({before,after,rules,transitions,requireAllRulesUsed=false}){
  if(typeof requireAllRulesUsed!=='boolean')throw new TypeError('requireAllRulesUsed must be boolean');
  if(transitions!==undefined&&rules!==undefined)throw new TypeError('Choose permissions or value-bound transitions');
  const permissions=rules===undefined?[]:rules;
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
  const report=transitions===undefined?old.reviewChanges(next,permissions):old.reviewTransition(next,transitions);
  const unusedRules=transitions===undefined?old.unusedChangeRules(next,permissions):report.unusedRules;
  const strict=transitions===undefined?requireAllRulesUsed:true;
  for(const event of reads.values())if(hash(fs.readFileSync(event.path))!==event.sha256)throw Error('Configuration changed during review: '+event.path);
  for(const list of Object.values(sides))list.sort((a,b)=>a.path.localeCompare(b.path));
  return {...report,accepted:report.accepted&&(!strict||unusedRules.length===0),unusedRules,requireAllRulesUsed:strict,readSets:sides,scope:transitions===undefined?'trusted local files; explicit fallback and classpath; empty environment; no HTTP; exact permissions, not deployment safety; read recheck is not an atomic snapshot':'trusted local files; explicit fallback and classpath; empty environment; no HTTP; exact required before/after values; read recheck is not an atomic snapshot or deployment safety'};
}

function previewInput(value){
  const spec=descriptor(value);
  return {file:spec.file,fallbackFiles:spec.fallbackFiles.map(file=>path.resolve(file)),classpath:spec.classpath.map(dir=>path.resolve(dir))};
}

/** Bind a value-free preview to its complete local inputs and transition plan. */
export function previewTransitionFiles(options){
  if(options.rules!==undefined||!Array.isArray(options.transitions))throw new TypeError('Preview receipt requires a transition policy');
  const wire=JSON.stringify(options.transitions);
  if(wire.length>524288)throw new TypeError('Transition policy exceeds 524288 UTF-16 units');
  const inputs={before:previewInput(options.before),after:previewInput(options.after)};
  const transitions=parseChangePolicy(wire);
  const report=reviewFiles({...inputs,transitions});
  const policy=transitions.map(rule=>({path:rule.path,...(Object.hasOwn(rule,'beforeSource')?{beforeSource:rule.beforeSource}:{}),...(Object.hasOwn(rule,'afterSource')?{afterSource:rule.afterSource}:{})}));
  const reads=Object.fromEntries(['before','after'].map(side=>[side,[...report.readSets[side]].sort((a,b)=>a.path<b.path?-1:a.path>b.path?1:0)]));
  const previewVersion='hocon-transition-preview-v1';
  const engineSHA256=hash(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url)));
  const result={accepted:report.accepted,changes:report.changes,unexpected:report.unexpected,mismatches:report.mismatches,unusedRules:report.unusedRules};
  const previewHash=hash(JSON.stringify({version:previewVersion,engineSHA256,inputs,policy,reads,result}));
  return {...report,previewVersion,engineSHA256,previewHash,previewInputs:inputs};
}

/** Read shared CLI options and a bounded policy file; paths stay relative to cwd. */
export function readReviewOptions(args){
  const value={before:{fallbackFiles:[],classpath:[]},after:{fallbackFiles:[],classpath:[]}};
  let policy,transitionPolicy=false;
  for(let i=0;i<args.length;i++){
    const flag=args[i];
    if(flag==='--preview-receipt'){if(value.previewReceipt)throw Error('Duplicate preview receipt flag');value.previewReceipt=true;continue;}
    if(flag==='--require-all-rules-used'){if(value.requireAllRulesUsed)throw Error('Duplicate strict policy flag');value.requireAllRulesUsed=true;continue;}
    const arg=args[++i];
    if(!arg||!['--before','--after','--policy','--transition-policy','--before-fallback','--after-fallback','--before-classpath','--after-classpath'].includes(flag))throw Error('Usage: node tools/change-review.mjs --before old.conf --after new.conf (--policy permissions.json | --transition-policy transitions.json [--preview-receipt]) [--before-fallback FILE] [--after-fallback FILE] [--before-classpath DIR] [--after-classpath DIR]');
    if(flag==='--policy'||flag==='--transition-policy'){if(policy)throw Error('Duplicate or conflicting policy');policy=arg;transitionPolicy=flag==='--transition-policy';continue;}
    const parts=flag.slice(2).split('-'),target=value[parts[0]];
    if(parts.length===1){if(target.file)throw Error('Duplicate input');target.file=arg;}
    else target[parts[1]==='fallback'?'fallbackFiles':'classpath'].push(arg);
  }
  if(!policy)throw Error('A policy file is required; use [] to reject all changes');
  const stat=fs.statSync(policy);
  if(!stat.isFile()||stat.size>524288)throw Error('Policy must be a regular JSON file of at most 524288 bytes');
  value[transitionPolicy?'transitions':'rules']=parseChangePolicy(fs.readFileSync(policy,'utf8'));
  return value;
}

if(process.argv[1]&&path.resolve(process.argv[1])===fileURLToPath(import.meta.url)){
  try{const options=readReviewOptions(process.argv.slice(2));const report=options.previewReceipt?previewTransitionFiles(options):reviewFiles(options);process.stdout.write(JSON.stringify(report,null,2)+'\n');if(!report.accepted)process.exitCode=2;}
  catch(error){process.stderr.write(error.message+'\n');process.exitCode=1;}
}
