import {load,loadFile,loadURL,ConfigError} from './config.mjs';
import fs from 'node:fs';
const args=process.argv.slice(2);let input,file,url,json=false,resolved=false,query,type,validateFile,entries=false,stepsFile;
const options={fallbackFiles:[],fallbackURLs:[],classpath:[]};
try {
 for(let i=0;i<args.length;i++){
  const a=args[i];
  if(a==='--help'){
   process.stdout.write('Usage: node tools/cli.mjs [--input TEXT | --file PATH | --url URL] [--json] [--resolved-json]\n  --fallback FILE   Add a lower-priority configuration file (repeatable)\n  --fallback-url URL  Add a lower-priority URL (after fallback files)\n  --ca FILE         Trust a PEM CA certificate for HTTPS (repeatable)\n  --http-timeout-ms N  Per-request total timeout, default 5000\n  --http-total-timeout-ms N  Whole load network deadline, default 30000\n  --http-max-redirects N  Redirect budget, default 19 (max 64)\n  --http-max-bytes N  Response byte budget, maximum/default 400000\n  --no-network      Disable all HTTP(S) loading\n  --env             Enable process environment substitutions\n  --classpath DIR   Add a directory of classpath resources (repeatable)\n  --get PATH        Read one resolved path\n  --type TYPE       value|string|boolean|int|long|double|duration|bytes|memory|list|has|null\n  Collection types: string-list|boolean-list|int-list|long-list|double-list|duration-list|bytes-list|memory-list|config|config-list\n  --set PATH VALUE  Set a path from a HOCON value (repeatable; ordered)\n  --unset PATH      Remove a path (repeatable; ordered)\n  --only PATH       Keep only one path\n  --at-path PATH    Wrap at a path; --at-key KEY wraps one literal key\n  More getters: number|number-list|object|object-list|any-ref|any-ref-list|enum|enum-list\n  --enum-choice NAME  Define an allowed enum name (repeatable)\n  --document-steps FILE  Run raw parse/edit/resolve stages from a JSON array\n  --probe PATH      Add a required-value probe to every document state\n  --entries         Print flattened non-null leaf paths\n  --validate FILE   Check against a resolved reference file after edits\n  --validate-path PATH  Restrict validation (repeatable)\nWithout --input/--file/--url, reads UTF-8 stdin. Duration is nanoseconds. Long/bytes/memory use exact decimal strings.\nExit: 0 success, 2 invalid configuration or getter, 1 host/argument error.\n');process.exit(0);
  }else if(a==='--enum-choice'){
   if(i+1>=args.length)throw new Error('--enum-choice requires NAME');options.enumChoices??=[];options.enumChoices.push(args[++i]);
  }else if(a==='--document-steps'){
   if(i+1>=args.length||stepsFile!==undefined)throw new Error('--document-steps requires one JSON file');stepsFile=args[++i];options.document=true;
  }else if(a==='--probe'){
   if(i+1>=args.length)throw new Error('--probe requires PATH');options.probes??=[];options.probes.push(args[++i]);
  }else if(a==='--set'){
   if(i+2>=args.length)throw new Error('--set requires PATH and HOCON_VALUE');options.operations??=[];options.operations.push({op:'with-value',path:args[++i],valueSource:args[++i]});resolved=true;
  }else if(['--unset','--only','--at-path','--at-key'].includes(a)){
   if(i+1>=args.length)throw new Error('Missing value for '+a);options.operations??=[];options.operations.push({op:({'--unset':'without-path','--only':'with-only-path','--at-path':'at-path','--at-key':'at-key'})[a],path:args[++i]});resolved=true;
  }else if(a==='--entries'){if(type!==undefined||query!==undefined)throw new Error('--entries conflicts with --get/--type');entries=true;type='entries';query='';}
  else if(a==='--validate'){
   if(i+1>=args.length)throw new Error('Missing validation reference file');if(validateFile!==undefined)throw new Error('Only one validation reference is allowed');validateFile=args[++i];resolved=true;
  }else if(a==='--validate-path'){
   if(i+1>=args.length)throw new Error('Missing validation path');options.validationPaths??=[];options.validationPaths.push(args[++i]);
  }else if(a==='--json')json=true;
  else if(a==='--no-network'){if(options.network&&Object.keys(options.network).length)throw new Error('--no-network conflicts with HTTP options');options.network=false;}
  else if(a==='--resolved-json')resolved=true;
  else if(a==='--env')options.environment={...process.env};
  else if(['--input','--file','--url','--fallback','--fallback-url','--classpath','--get','--type','--ca','--http-timeout-ms','--http-total-timeout-ms','--http-max-redirects','--http-max-bytes'].includes(a)){
   if(i+1>=args.length)throw new Error('Missing value for '+a);const value=args[++i];
   if(['--input','--file','--url'].includes(a)){if(input!==undefined||file!==undefined||url!==undefined)throw new Error('Exactly one input source is required');if(a==='--file')file=value;else if(a==='--url')url=value;else input=value;}
   else if(a==='--fallback')options.fallbackFiles.push(value);
   else if(a==='--fallback-url')options.fallbackURLs.push(value);
   else if(a==='--ca'||a.startsWith('--http-')){
    if(options.network===false)throw new Error('--no-network conflicts with HTTP options');options.network??={};
    if(a==='--ca'){options.network.ca??=[];options.network.ca.push(fs.readFileSync(value,'utf8'));}
    else {const keys={'--http-timeout-ms':'timeoutMs','--http-total-timeout-ms':'totalTimeoutMs','--http-max-redirects':'maxRedirects','--http-max-bytes':'maxResponseBytes'};if(!/^\d+$/.test(value))throw new Error('Expected an unsigned integer for '+a);options.network[keys[a]]=Number(value);}
   }
   else if(a==='--classpath')options.classpath.push(value);
   else if(a==='--get'){if(entries)throw new Error('--get conflicts with --entries');query=value;}
   else {if(entries)throw new Error('--type conflicts with --entries');type=value;}
  }else throw new Error('Unknown argument: '+a);
 }
 if(type!==undefined&&query===undefined)throw new Error('--type requires --get');
 if(type!==undefined&&!['value','string','boolean','int','long','double','duration','bytes','memory','list','has','has-or-null','null','entries','empty','resolved','string-list','boolean-list','int-list','long-list','double-list','duration-list','bytes-list','memory-list','config','config-list','number','number-list','object','object-list','any-ref','any-ref-list','enum','enum-list'].includes(type))throw new Error('Unknown getter type: '+type);
 if(options.enumChoices&&!['enum','enum-list'].includes(type))throw new Error('--enum-choice requires enum or enum-list getter');
 if(['enum','enum-list'].includes(type)&&!options.enumChoices)throw new Error('Enum getters require --enum-choice');
 if(options.validationPaths&&validateFile===undefined)throw new Error('--validate-path requires --validate');
 if(options.probes&&!options.document)throw new Error('--probe requires --document-steps');
 if(options.document){
  if(resolved||query!==undefined||validateFile!==undefined||options.operations)throw new Error('--document-steps conflicts with resolved output/getters/edits/validation');
  const fd=fs.openSync(stepsFile,'r');let bytes;try{const buffer=Buffer.alloc(400001);let count=0;while(count<buffer.length){const n=fs.readSync(fd,buffer,count,buffer.length-count,null);if(n===0)break;count+=n;}if(count>400000)throw new Error('Document steps file exceeds limit');bytes=buffer.subarray(0,count);}finally{fs.closeSync(fd);}
  options.steps=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));if(!Array.isArray(options.steps))throw new Error('Document steps must be an array');
 }
 if(input===undefined&&file===undefined&&url===undefined){let size=0;const chunks=[];for await(const chunk of process.stdin){size+=chunk.length;if(size>400000)throw new Error('Input exceeds file limit');chunks.push(chunk);}input=new TextDecoder('utf-8',{fatal:true,ignoreBOM:true}).decode(Buffer.concat(chunks));}
 if(query!==undefined){options.path=query;options.getter=type??'value';}else if(!resolved&&!options.document)options.getter='debug';
 let output,ok=true;
 try {
 if(validateFile!==undefined){
  const reference=loadFile(validateFile,{environment:options.environment,classpath:options.classpath,network:options.network,getter:'json-text'});
  options.checkValid={source:reference,paths:options.validationPaths??[]};
 }
 const value=url!==undefined?loadURL(url,options):file!==undefined?loadFile(file,options):load(input,options);output=options.getter==='debug'?value:JSON.stringify(value); }
 catch(e){if(!(e instanceof ConfigError))throw e;ok=false;output='ERROR: '+e.message+(e.position?` (${e.position.source}:${e.position.line}:${e.position.column})`:'');}
 process.stdout.write(json?JSON.stringify({ok,output})+'\n':output+(output.endsWith('\n')?'':'\n'));
 process.exitCode=ok?0:2;
}catch(e){process.stderr.write(JSON.stringify({ok:false,error:String(e.message||e)})+'\n');process.exitCode=1;}
