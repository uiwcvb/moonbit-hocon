import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {load_json} from '../web/engine.mjs';

export class ConfigError extends Error {
  constructor(result) { super(result.error); this.name='ConfigError'; this.position=result.position; }
}

// Java Properties logical lines, escaping and the HOCON object-wins conversion.
export function parseProperties(text) {
  const properties=new Map(), physical=text.split(/\r\n|\n|\r/);
  const decode=s=>s.replace(/\\(u[0-9a-fA-F]{4}|[\s\S])/g,(_,v)=>{
    if(v[0]==='u') { if(v.length!==5)throw new Error('Malformed properties Unicode escape'); return String.fromCharCode(parseInt(v.slice(1),16)); }
    return ({t:'\t',n:'\n',r:'\r',f:'\f'})[v]??v;
  });
  for(let i=0;i<physical.length;i++) {
    let line=physical[i].replace(/^[ \t\f]+/,'');
    if(!line||line[0]==='#'||line[0]==='!')continue;
    while((line.match(/\\+$/)?.[0].length??0)%2===1) {
      line=line.slice(0,-1);
      if(++i>=physical.length)break;
      line+=physical[i].replace(/^[ \t\f]+/,'');
    }
    let end=0;
    for(;end<line.length;end++){if(line[end]==='\\'){end++;continue}if(/[=: \t\f]/.test(line[end]))break;}
    let start=end;
    if(/[ \t\f]/.test(line[start]??'')){while(/[ \t\f]/.test(line[start]??''))start++;}
    if(line[start]==='='||line[start]===':')start++;
    while(/[ \t\f]/.test(line[start]??''))start++;
    properties.set(decode(line.slice(0,end)),decode(line.slice(start)));
  }
  const root=Object.create(null);
  const sorted=[...properties].sort(([a],[b])=>a.split('.').length-b.split('.').length);
  for(const [key,value] of sorted){const parts=key.split('.');let parent=root;for(const part of parts.slice(0,-1)){if(typeof parent[part]!=='object')parent[part]=Object.create(null);parent=parent[part];}parent[parts.at(-1)]=value;}
  return root;
}

function createHost(options) {
  const cwd=path.resolve(options.cwd??process.cwd());
  const roots=(options.classpath??[]).map(p=>path.resolve(cwd,p));
  const metadata=new Map();let bytes=0, count=0;
  function read(name,optional=false,resource,forceHocon=false) {
    let real;
    try{real=fs.realpathSync(name);}catch(e){if(optional&&['ENOENT','ENOTDIR'].includes(e.code))return null;throw e;}
    const stat=fs.statSync(real);
    if(!stat.isFile())throw new Error('Configuration is not a regular file: '+name);
    bytes+=stat.size;count++;
    if(stat.size>400000||bytes>4000000||count>512)throw new Error('Configuration file resource limit');
    const content=new TextDecoder('utf-8',{fatal:true,ignoreBOM:true}).decode(fs.readFileSync(real));
    if(content.length>100000)throw new Error('Configuration source exceeds 100000 UTF-16 units');
    if(resource!==undefined)metadata.set(real,resource);
    const extension=forceHocon?'.conf':path.extname(name);
    return {name:real,content:extension==='.properties'?JSON.stringify(parseProperties(content)):content,format:extension==='.properties'||extension==='.json'?'json':'hocon'};
  }
  function candidates(name){return /\.(conf|json|properties)$/.test(name)?[name]:[name+'.properties',name+'.json',name+'.conf'];}
  function files(name,heuristic=false){return candidates(name).flatMap(p=>{const source=read(p,true,undefined,heuristic&&/\.(conf|json|properties)$/.test(name));return source?[source]:[];});}
  function resources(name){
    const relative=name.replace(/^\/+/,''), out=[];
    // First classpath root has highest priority, as with ClassLoader resources.
    for(const root of roots.toReversed())for(const candidate of candidates(relative)){
      const source=read(path.resolve(root,candidate),true,candidate);if(source)out.push(source);
    }
    return out;
  }
  function url(name){
    const parsed=new URL(name);
    if(parsed.protocol!=='file:')throw new Error('Unsupported include URL protocol: '+parsed.protocol);
    const source=read(fileURLToPath(parsed),true);return source?[source]:[];
  }
  function include(req){
    if(req.kind==='url')return url(req.name);
    if(req.kind==='classpath')return resources(req.name);
    if(req.kind==='file')return files(path.resolve(cwd,req.name));
    if(/^file:/i.test(req.name))return url(req.name);
    if(/^[a-z][a-z0-9+.-]*:\/\//i.test(req.name))throw new Error('Unsupported include URL: '+req.name);
    if(metadata.has(req.from))return resources(req.name.startsWith('/')?req.name:path.posix.join(path.posix.dirname(metadata.get(req.from)),req.name));
    const base=path.isAbsolute(req.from)?path.dirname(req.from):cwd;
    // Lightbend's explicit heuristic suffix inherits CONF; extension search selects each format.
    const found=files(path.resolve(base,req.name),true);return found.length?found:resources(req.name);
  }
  return {read,include};
}

function execute(source,options,file) {
  const host=createHost(options);
  const primary=file?host.read(path.resolve(options.cwd??process.cwd(),source)):{name:options.sourceName??'<string>',content:source,format:options.format??'hocon'};
  const fallbackSources=(options.fallbacks??[]).map((content,i)=>typeof content==='string'?{name:`<fallback ${i}>`,content,format:'hocon'}:content);
  for(const name of options.fallbackFiles??[])fallbackSources.push(host.read(path.resolve(options.cwd??process.cwd(),name)));
  const request={primary,fallbackSources,environment:options.environment??{},getter:options.getter,path:options.path};
  const result=JSON.parse(load_json(JSON.stringify(request),input=>{
    try{return JSON.stringify(host.include(JSON.parse(input)));}catch(e){return JSON.stringify({error:e.message});}
  }));
  if(!result.accepted)throw new ConfigError(result);
  return result.value;
}

/** Resolve a string. Includes use sourceName (if absolute) or cwd. Environment is opt-in. */
export function load(source,options={}) { return execute(source,options,false); }
/** Resolve an exact UTF-8 file, with per-file origins retained for all fallback files. */
export function loadFile(filename,options={}) { return execute(filename,options,true); }
