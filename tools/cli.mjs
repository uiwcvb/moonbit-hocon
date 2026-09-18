import {load,loadFile,ConfigError} from './config.mjs';
const args=process.argv.slice(2);let input,file,json=false,resolved=false,query,type;
const options={fallbackFiles:[],classpath:[]};
try {
 for(let i=0;i<args.length;i++){
  const a=args[i];
  if(a==='--help'){
   process.stdout.write('Usage: node tools/cli.mjs [--input TEXT | --file PATH] [--json] [--resolved-json]\n  --fallback FILE   Add a lower-priority configuration file (repeatable)\n  --env             Enable process environment substitutions\n  --classpath DIR   Add a directory of classpath resources (repeatable)\n  --get PATH        Read one resolved path\n  --type TYPE       value|string|boolean|int|long|double|duration|bytes|memory|list|has|null\n  Collection types: string-list|boolean-list|int-list|long-list|double-list|duration-list|bytes-list|memory-list|config|config-list\nWithout --input/--file, reads UTF-8 stdin. Duration is nanoseconds. Long/bytes/memory use exact decimal strings.\nExit: 0 success, 2 invalid configuration or getter, 1 host/argument error.\n');process.exit(0);
  }else if(a==='--json')json=true;
  else if(a==='--resolved-json')resolved=true;
  else if(a==='--env')options.environment={...process.env};
  else if(['--input','--file','--fallback','--classpath','--get','--type'].includes(a)){
   if(i+1>=args.length)throw new Error('Missing value for '+a);const value=args[++i];
   if(a==='--input'||a==='--file'){if(input!==undefined||file!==undefined)throw new Error('Exactly one input source is required');if(a==='--file')file=value;else input=value;}
   else if(a==='--fallback')options.fallbackFiles.push(value);
   else if(a==='--classpath')options.classpath.push(value);
   else if(a==='--get')query=value;
   else type=value;
  }else throw new Error('Unknown argument: '+a);
 }
 if(type!==undefined&&query===undefined)throw new Error('--type requires --get');
 if(type!==undefined&&!['value','string','boolean','int','long','double','duration','bytes','memory','list','has','null','string-list','boolean-list','int-list','long-list','double-list','duration-list','bytes-list','memory-list','config','config-list'].includes(type))throw new Error('Unknown getter type: '+type);
 if(input===undefined&&file===undefined){let size=0;const chunks=[];for await(const chunk of process.stdin){size+=chunk.length;if(size>400000)throw new Error('Input exceeds file limit');chunks.push(chunk);}input=new TextDecoder('utf-8',{fatal:true,ignoreBOM:true}).decode(Buffer.concat(chunks));}
 if(query!==undefined){options.path=query;options.getter=type??'value';}else if(!resolved)options.getter='debug';
 let output,ok=true;
 try { const value=file!==undefined?loadFile(file,options):load(input,options);output=options.getter==='debug'?value:JSON.stringify(value); }
 catch(e){if(!(e instanceof ConfigError))throw e;ok=false;output='ERROR: '+e.message+(e.position?` (${e.position.source}:${e.position.line}:${e.position.column})`:'');}
 process.stdout.write(json?JSON.stringify({ok,output})+'\n':output+(output.endsWith('\n')?'':'\n'));
 process.exitCode=ok?0:2;
}catch(e){process.stderr.write(JSON.stringify({ok:false,error:String(e.message||e)})+'\n');process.exitCode=1;}
