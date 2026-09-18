import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {networkOptions,readHttp} from './http-client.mjs';

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
  const network=networkOptions(options.network),started=Date.now();
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
  function url(name,optional=true,syntax){
    const parsed=new URL(name);
    if(parsed.protocol==='file:'){
      const source=read(fileURLToPath(parsed),optional);return source?[source]:[];
    }
    if(!['http:','https:'].includes(parsed.protocol))throw new Error('Unsupported include URL protocol: '+parsed.protocol);
    if(network===false)throw new Error('HTTP(S) configuration loading is disabled');
    const remaining=network.totalTimeoutMs-(Date.now()-started);
    if(remaining<=0)throw new Error('Configuration network total timeout');
    if(++count>512)throw new Error('Configuration file resource limit');
    let format=syntax??(parsed.pathname.endsWith('.json')?'json':parsed.pathname.endsWith('.properties')?'properties':'hocon');
    if(!['hocon','json','properties'].includes(format))throw new Error('Unknown configuration URL syntax: '+format);
    const response=readHttp(parsed.href,{...network,timeoutMs:Math.min(network.timeoutMs,remaining),maxRedirects:Math.min(network.maxRedirects,512-count),maxResponseBytes:Math.min(network.maxResponseBytes,4000000-bytes)},({json:'application/json',properties:'text/x-java-properties',hocon:'application/hocon'})[format]);
    count+=response.requests-1;bytes+=response.bytes;
    if(count>512||bytes>4000000)throw new Error('Configuration file resource limit');
    if(response.missing){if(optional)return [];throw new Error('Missing configuration URL: '+parsed.href);}
    const type=response.contentType.trim().split(';')[0];
    if(type==='application/json')format='json';
    else if(type==='text/x-java-properties')format='properties';
    else if(type==='application/hocon')format='hocon';
    // Relative includes retain the requested origin, including across redirects.
    return [{name:parsed.href,content:format==='properties'?JSON.stringify(parseProperties(response.content)):response.content,format:format==='properties'?'json':format}];
  }
  function include(req){
    if(options.includes&&Object.hasOwn(options.includes,req.name)){
      const content=options.includes[req.name];if(typeof content!=='string')throw new TypeError('include source must be a string');
      if(++count>512||(bytes+=Buffer.byteLength(content))>4000000||content.length>100000)throw new Error('Configuration include resource limit');
      return [{name:req.name,content,format:'hocon'}];
    }
    if(req.kind==='url')return url(req.name);
    if(req.kind==='classpath')return resources(req.name);
    if(req.kind==='file')return files(path.resolve(cwd,req.name));
    if(/^(file|https?):/i.test(req.name))return url(req.name);
    if(/^[a-z][a-z0-9+.-]*:\/\//i.test(req.name))throw new Error('Unsupported include URL: '+req.name);
    if(/^https?:/i.test(req.from)){
      // Java File.isAbsolute differs for root-relative Windows paths.
      if((process.platform!=='win32'&&path.isAbsolute(req.name))||/^[A-Za-z]:[\\/]/.test(req.name))return [];
      if(/\s|[\\<>"{}|^`]/.test(req.name))return [];
      const known=/\.(conf|json|properties)$/.test(req.name);
      const names=known?[req.name]:[req.name+'.conf',req.name+'.json',req.name+'.properties'];
      const sources=names.flatMap(name=>url(new URL(name,req.from).href,true,known?'hocon':name.endsWith('.properties')?'properties':name.endsWith('.json')?'json':'hocon'));
      return known?sources:sources.reverse();
    }
    if(metadata.has(req.from))return resources(req.name.startsWith('/')?req.name:path.posix.join(path.posix.dirname(metadata.get(req.from)),req.name));
    const base=path.isAbsolute(req.from)?path.dirname(req.from):cwd;
    // Lightbend's explicit heuristic suffix inherits CONF; extension search selects each format.
    const found=files(path.resolve(base,req.name),true);return found.length?found:resources(req.name);
  }
  return {read,include,url};
}


export function prepare(source,options,kind){
  const host=createHost(options);
  const primary=kind==='url'?host.url(source,false,options.format)[0]:kind==='file'?host.read(path.resolve(options.cwd??process.cwd(),source)):{name:options.sourceName??'<string>',content:source,format:options.format??'hocon'};
  const fallbackSources=(options.fallbacks??[]).map((content,i)=>typeof content==='string'?{name:`<fallback ${i}>`,content,format:'hocon'}:content);
  for(const name of options.fallbackFiles??[])fallbackSources.push(host.read(path.resolve(options.cwd??process.cwd(),name)));
  for(const name of options.fallbackURLs??[])fallbackSources.push(host.url(name,false)[0]);
  const request={primary,fallbackSources,includes:options.includes,environment:options.environment??{},getter:options.getter,path:options.path,operations:options.operations,checkValid:options.checkValid,referenceSource:options.referenceSource,validationPaths:options.validationPaths,document:options.document,steps:options.steps,probes:options.probes,enumChoices:options.enumChoices,unit:options.unit};
  const callback=input=>{try{return JSON.stringify(host.include(JSON.parse(input)));}catch(e){return JSON.stringify({error:e.message});}};
  return {request,callback};
}
