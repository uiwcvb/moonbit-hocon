import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {pathToFileURL} from 'node:url';
import {once} from 'node:events';
import {Worker} from 'node:worker_threads';
import {Config,ConfigError,loadFile,loadURL,loadFileAsync,loadURLAsync} from './config.mjs';

// Frozen full-tree/rejection expectations from Config 1.4.9 on JDK 22.
// The suffix deliberately differs from the requested syntax in failure cases.
const vectors=[
  {
    "id": "hocon-conf-json-file",
    "source": "a=1\ncopy=${a}\nitems=[1,2]",
    "suffix": "conf",
    "format": "json",
    "expected": {
      "accepted": false,
      "error": "D:\\CodexLocal\\ban\\work\\isolated14-20261027\\reports\\hocon\\deep-repair-08-max-20261028\\syntax-fixtures\\hocon.conf: 1: Token not allowed in valid JSON: 'a'",
      "errorClass": "Parse"
    }
  },
  {
    "id": "hocon-json-hocon-file",
    "source": "a=1\ncopy=${a}\nitems=[1,2]",
    "suffix": "json",
    "format": "hocon",
    "expected": {
      "accepted": true,
      "value": {
        "a": 1,
        "copy": 1,
        "items": [
          1,
          2
        ]
      }
    }
  },
  {
    "id": "hocon-properties-hocon-file",
    "source": "a=1\ncopy=${a}\nitems=[1,2]",
    "suffix": "properties",
    "format": "hocon",
    "expected": {
      "accepted": true,
      "value": {
        "a": 1,
        "copy": 1,
        "items": [
          1,
          2
        ]
      }
    }
  },
  {
    "id": "properties-conf-properties-file",
    "source": "a.b=one\\\n two\nliteral=${missing}\nport=08080",
    "suffix": "conf",
    "format": "properties",
    "expected": {
      "accepted": true,
      "value": {
        "a": {
          "b": "onetwo"
        },
        "literal": "${missing}",
        "port": "08080"
      }
    }
  },
  {
    "id": "properties-comment-json-properties-file",
    "source": "\\\n# optional settings\\\nport=8080\nmessage=\\u4e2d\\u6587",
    "suffix": "json",
    "format": "properties",
    "expected": {
      "accepted": true,
      "value": {
        "message": "\u4e2d\u6587",
        "port": "8080"
      }
    }
  },
  {
    "id": "duplicate-json-hocon-file",
    "source": "{\"x\":1,\"x\":2}",
    "suffix": "json",
    "format": "hocon",
    "expected": {
      "accepted": true,
      "value": {
        "x": 2
      }
    }
  },
  {
    "id": "duplicate-conf-json-file",
    "source": "{\"x\":1,\"x\":2}",
    "suffix": "conf",
    "format": "json",
    "expected": {
      "accepted": false,
      "error": "D:\\CodexLocal\\ban\\work\\isolated14-20261027\\reports\\hocon\\deep-repair-08-max-20261028\\syntax-fixtures\\duplicate.conf: 1: JSON does not allow duplicate fields: 'x' was already seen",
      "errorClass": "Parse"
    }
  },
  {
    "id": "empty-conf-json-file",
    "source": "",
    "suffix": "conf",
    "format": "json",
    "expected": {
      "accepted": false,
      "error": "D:\\CodexLocal\\ban\\work\\isolated14-20261027\\reports\\hocon\\deep-repair-08-max-20261028\\syntax-fixtures\\empty.conf: 1: Empty document",
      "errorClass": "Parse"
    }
  },
  {
    "id": "empty-json-hocon-file",
    "source": "",
    "suffix": "json",
    "format": "hocon",
    "expected": {
      "accepted": true,
      "value": {}
    }
  },
  {
    "id": "json-properties-json-file",
    "source": "{\"a.b\":1,\"literal\":\"${missing}\"}",
    "suffix": "properties",
    "format": "json",
    "expected": {
      "accepted": true,
      "value": {
        "a.b": 1,
        "literal": "${missing}"
      }
    }
  },
  {
    "id": "json-json-default-file",
    "source": "{\"a.b\":1,\"literal\":\"${missing}\"}",
    "suffix": "json",
    "expected": {
      "accepted": true,
      "value": {
        "a.b": 1,
        "literal": "${missing}"
      }
    }
  },
  {
    "id": "hocon-properties-default-file",
    "source": "a=1\ncopy=${a}\nitems=[1,2]",
    "suffix": "properties",
    "expected": {
      "accepted": true,
      "value": {
        "a": "1",
        "copy": "${a}",
        "items": "[1,2]"
      }
    }
  }
];
const httpVectors=[
  {
    "id": "mime-hocon",
    "format": "json",
    "type": "application/hocon",
    "body": "x=1",
    "expected": {
      "accepted": true,
      "value": {
        "x": 1
      }
    }
  },
  {
    "id": "mime-json",
    "format": "hocon",
    "type": "application/json",
    "body": "{\"x\":1,\"x\":2}",
    "expected": {
      "accepted": false,
      "error": "http://127.0.0.1:52632/mime-json: 1: JSON does not allow duplicate fields: 'x' was already seen",
      "errorClass": "Parse"
    }
  },
  {
    "id": "mime-properties",
    "format": "json",
    "type": "text/x-java-properties; charset=UTF-8",
    "body": "a.b=value\nliteral=${missing}\ncount=01",
    "expected": {
      "accepted": true,
      "value": {
        "a": {
          "b": "value"
        },
        "count": "01",
        "literal": "${missing}"
      }
    }
  },
  {
    "id": "unknown-mime-json",
    "format": "json",
    "type": "text/plain",
    "body": "x=1",
    "expected": {
      "accepted": false,
      "error": "http://127.0.0.1:52632/unknown-mime-json: 1: Token not allowed in valid JSON: 'x'",
      "errorClass": "Parse"
    }
  },
  {
    "id": "unknown-mime-properties",
    "format": "properties",
    "type": "text/plain",
    "body": "x=1",
    "expected": {
      "accepted": true,
      "value": {
        "x": "1"
      }
    }
  },
  {
    "id": "case-sensitive-mime",
    "format": "json",
    "type": "Text/x-java-properties",
    "body": "x=1",
    "expected": {
      "accepted": false,
      "error": "http://127.0.0.1:52632/case-sensitive-mime: 1: Token not allowed in valid JSON: 'x'",
      "errorClass": "Parse"
    }
  },
  {
    "id": "accept-hocon",
    "format": "hocon",
    "type": "application/json",
    "echo": true,
    "expected": {
      "accepted": true,
      "value": {
        "accept": "application/hocon"
      }
    }
  },
  {
    "id": "accept-json",
    "format": "json",
    "type": "application/json",
    "echo": true,
    "expected": {
      "accepted": true,
      "value": {
        "accept": "application/json"
      }
    }
  },
  {
    "id": "accept-properties",
    "format": "properties",
    "type": "application/json",
    "echo": true,
    "expected": {
      "accepted": true,
      "value": {
        "accept": "text/x-java-properties"
      }
    }
  }
];
const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-file-syntax-'));
let checks=0,server;
const fileFactories=[
 ['loadFile',loadFile],
 ['Config.parseFile',(file,options)=>Config.parseFile(file,options).resolve().toJSON()],
 ['Config.loadFile',(file,options)=>Config.loadFile(file,options).toJSON()],
 ['loadFileAsync',loadFileAsync],
 ['Config.parseFileAsync',async(file,options)=>(await Config.parseFileAsync(file,options)).resolve().toJSON()],
 ['Config.loadFileAsync',async(file,options)=>(await Config.loadFileAsync(file,options)).toJSON()]
];
const urlFactories=[
 ['loadURL',loadURL],
 ['Config.parseURL',(url,options)=>Config.parseURL(url,options).resolve().toJSON()],
 ['Config.loadURL',(url,options)=>Config.loadURL(url,options).toJSON()],
 ['loadURLAsync',loadURLAsync],
 ['Config.parseURLAsync',async(url,options)=>(await Config.parseURLAsync(url,options)).resolve().toJSON()],
 ['Config.loadURLAsync',async(url,options)=>(await Config.loadURLAsync(url,options)).toJSON()]
];
async function expect(fn,expected,label){
 if(expected.accepted)assert.deepEqual(await fn(),expected.value,label);
 else await assert.rejects(async()=>fn(),ConfigError,label);
 checks++;
}
try{
 for(const [i,vector] of vectors.entries()){
  const file=path.join(dir,`${i}.${vector.suffix}`);fs.writeFileSync(file,vector.source);
  for(const [name,factory] of fileFactories)await expect(()=>factory(file,{format:vector.format}),vector.expected,vector.id+'/'+name);
  for(const [name,factory] of urlFactories)await expect(()=>factory(pathToFileURL(file).href,{format:vector.format}),vector.expected,vector.id+'/'+name);
 }
 const factoryChecks=checks;
 fs.writeFileSync(path.join(dir,'main.json'),'include "child.json"\nport=9000');
 fs.writeFileSync(path.join(dir,'child.json'),'child=1\ncopy=${child}');
 fs.writeFileSync(path.join(dir,'fallback.properties'),'port=08080\nretries=3');
 const main=path.join(dir,'main.json'),options={format:'hocon',fallbackFiles:[path.join(dir,'fallback.properties')]};
 const expected={accepted:true,value:{child:1,copy:1,port:9000,retries:'3'}};
 await expect(()=>loadFile(main,options),expected,'relative include and fallback syntax independence');
 await expect(()=>Config.loadURLAsync(pathToFileURL(main).href,options).then(config=>config.toJSON()),expected,'worker file URL include and fallback');
 fs.writeFileSync(path.join(dir,'primary.properties'),'{"x":1}');
 fs.writeFileSync(path.join(dir,'fallback.conf'),'y=2');
 await expect(()=>loadFile(path.join(dir,'primary.properties'),{format:'json',fallbackFiles:[path.join(dir,'fallback.conf')]}),{accepted:true,value:{x:1,y:2}},'JSON override applies only to primary');
 const bad=path.join(dir,'origin.json'),text='missing = ${NO_SUCH_VALUE}';fs.writeFileSync(bad,text);
 for(const loader of [()=>loadFile(bad,{format:'hocon'}),()=>loadURL(pathToFileURL(bad).href,{format:'hocon'}),()=>Config.loadFileAsync(bad,{format:'hocon'}),()=>Config.loadURLAsync(pathToFileURL(bad).href,{format:'hocon'})]){
  await assert.rejects(async()=>loader(),error=>{assert(error instanceof ConfigError);assert.equal(error.position.source,fs.realpathSync(bad));assert.equal(error.position.line,1);assert.equal(error.position.column,text.indexOf('$')+1);return true});checks++;
 }
 for(const loader of [()=>loadFile(main,{format:'toml'}),()=>loadURL(pathToFileURL(main).href,{format:'toml'})]){assert.throws(loader,/Unknown configuration file syntax/);checks++;}
 const integrationChecks=checks-factoryChecks;
 server=new Worker(`
  const {parentPort,workerData}=require('node:worker_threads');const http=require('node:http');
  const fixtures=new Map(workerData.map(v=>['/'+v.id,v]));
  const server=http.createServer((req,res)=>{const v=fixtures.get(req.url);if(!v){res.statusCode=404;return res.end()}res.setHeader('Content-Type',v.type);res.end(v.echo?JSON.stringify({accept:req.headers.accept}):v.body)});
  server.listen(0,'127.0.0.1',()=>parentPort.postMessage(server.address().port));
 `,{eval:true,workerData:httpVectors});
 const [port]=await once(server,'message');
 for(const vector of httpVectors)for(const [name,factory] of [['loadURL',loadURL],['loadURLAsync',loadURLAsync]])await expect(()=>factory(`http://127.0.0.1:${port}/${vector.id}`,{format:vector.format}),vector.expected,vector.id+'/'+name);
 console.log(JSON.stringify({vectors:vectors.length,factoryChecks,integrationChecks,httpReferenceCases:httpVectors.length,httpChecks:checks-factoryChecks-integrationChecks,total:checks,passed:true}));
}finally{
 if(server)await server.terminate();
 fs.rmSync(dir,{recursive:true,force:true});
}
