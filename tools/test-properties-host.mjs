import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {Worker} from 'node:worker_threads';
import {Config,load,loadFile,loadFileAsync,loadURL,loadURLAsync} from './config.mjs';

// Frozen full-tree expectations from unmodified Lightbend Config 1.4.9 / JDK 22.
// Includes meaningful negative controls: explicit empty keys, nonempty continued
// comments, escaped comment markers, malformed Unicode, and distinct EOF endings.
const vectors=[
  {
    "id": "comment-trailing-slash-lf",
    "source": "\\\n  #literal=value\\\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "bang-trailing-slash-lf",
    "source": "\\\n\t!literal=value\\\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "comment-eof-lf",
    "source": "\\\n#literal=value",
    "expected": {
      "accepted": true,
      "value": {}
    }
  },
  {
    "id": "spaces-eof-lf",
    "source": "\\\n \t\f",
    "expected": {
      "accepted": true,
      "value": {}
    }
  },
  {
    "id": "repeated-empty-continuation-lf",
    "source": "\\\n\\\n\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "repeated-comment-continuation-lf",
    "source": "\\\n\\\n!comment\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "ordinary-next-key-lf",
    "source": "\\\n key=value\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "key": "value",
        "next": "other"
      }
    }
  },
  {
    "id": "explicit-empty-key-lf",
    "source": "\\\n=value\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "": "value",
        "next": "other"
      }
    }
  },
  {
    "id": "escaped-comment-key-lf",
    "source": "\\\n\\#literal=value\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "#literal": "value",
        "next": "other"
      }
    }
  },
  {
    "id": "nonempty-comment-content-lf",
    "source": "key=left\\\n #value\\\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "key": "left#valuenext=other"
      }
    }
  },
  {
    "id": "nonempty-empty-continuation-lf",
    "source": "key=left\\\n\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "key": "left",
        "next": "other"
      }
    }
  },
  {
    "id": "comment-then-empty-key-lf",
    "source": "\\\n#comment\\\n=value",
    "expected": {
      "accepted": true,
      "value": {
        "": "value"
      }
    }
  },
  {
    "id": "empty-then-eof-slash-lf",
    "source": "\\\n\n\\",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "empty-before-ordinary-lf",
    "source": "\\\n \nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "lone-slash",
    "source": "\\",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "slash-lf",
    "source": "\\\n",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "slash-crlf",
    "source": "\\\r\n",
    "expected": {
      "accepted": true,
      "value": {}
    }
  },
  {
    "id": "slash-cr",
    "source": "\\\r",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "repeated-eof-slash",
    "source": "\\\n\\",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "repeated-final-newline",
    "source": "\\\n\\\n",
    "expected": {
      "accepted": true,
      "value": {
        "": ""
      }
    }
  },
  {
    "id": "two-final-newlines",
    "source": "\\\n\n",
    "expected": {
      "accepted": true,
      "value": {}
    }
  },
  {
    "id": "comment-continuation-lf",
    "source": "a=left\\\n  #literal\\\n !literal\nnext=value",
    "expected": {
      "accepted": true,
      "value": {
        "a": "left#literal!literal",
        "next": "value"
      }
    }
  },
  {
    "id": "initial-slash-empty-lf",
    "source": "\\\n\nnext=other",
    "expected": {
      "accepted": true,
      "value": {
        "next": "other"
      }
    }
  },
  {
    "id": "unicode-pair-lf",
    "source": "a=\\uD83D\\uDE00\n\\uD83D\\uDE00=value",
    "expected": {
      "accepted": true,
      "value": {
        "a": "\ud83d\ude00",
        "\ud83d\ude00": "value"
      }
    }
  },
  {
    "id": "unicode-invalid-short-lf",
    "source": "a=\\u0A",
    "expected": {
      "accepted": false,
      "error": "IllegalArgumentException"
    }
  },
  {
    "id": "collision-20-reverse",
    "source": "__proto__.x.child.deep=deep\n__proto__.x.child=nested\n__proto__.x=leaf",
    "expected": {
      "accepted": true,
      "value": {
        ["__proto__"]: {
          "x": {
            "child": {
              "deep": "deep"
            }
          }
        }
      }
    }
  }
];
const dir=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-properties-'));
const cli=fileURLToPath(new URL('cli.mjs',import.meta.url));
let checks=0,server;
const check=(actual,expected,label)=>{assert.deepEqual(actual,expected,label);checks++;};
try {
 for(const vector of vectors){
  const file=path.join(dir,vector.id+'.properties');fs.writeFileSync(file,vector.source);
  if(vector.expected.accepted)check(loadFile(file),vector.expected.value,vector.id);
  else {assert.throws(()=>loadFile(file),/Unicode escape/);checks++;}
 }
 // The comment's trailing slash must not swallow a real service setting.
 const content='\\\n# optional settings\\\nport=8080\nmessage=\\u4e2d\\u6587\nservice.name=demo';
 const expected={port:'8080',message:'中文',service:{name:'demo'}};
 const file=path.join(dir,'service.properties');fs.writeFileSync(file,content);
 check(loadFile(file),expected,'direct file');
 check(Config.parseFile(file).resolve().toJSON(),expected,'parseFile / resolve');
 check(Config.loadFile(file).toJSON(),expected,'loadFile factory');
 check(await loadFileAsync(file),expected,'worker file');
 check((await Config.parseFileAsync(file)).resolve().toJSON(),expected,'worker parseFile / resolve');
 check((await Config.loadFileAsync(file)).toJSON(),expected,'worker loadFile factory');
 const marker=JSON.stringify(file.replaceAll('\\','/'));
 check(load(`include file(${marker})`),expected,'explicit file include');
 check(load('include "service"',{cwd:dir}),expected,'extension search include');
 check(load('include classpath("service.properties")',{classpath:[dir]}),expected,'directory classpath');
 check(load('port=9090',{fallbackFiles:[file]}),{...expected,port:9090},'properties fallback priority');
 check(loadURL(pathToFileURL(file).href),expected,'file URL');
 const result=spawnSync(process.execPath,[cli,'--file',file,'--resolved-json'],{encoding:'utf8',windowsHide:true,timeout:15000});
 assert.equal(result.status,0,result.stderr);check(JSON.parse(result.stdout),expected,'CLI real file');
 // Serve in another thread so sync host APIs can make real loopback requests.
 server=new Worker(`
  const {parentPort,workerData}=require('node:worker_threads');
  const http=require('node:http');
  const server=http.createServer((req,res)=>{
   res.setHeader('Content-Type','text/x-java-properties; charset=utf-8');
   res.end(workerData);
  });
  server.listen(0,'127.0.0.1',()=>parentPort.postMessage(server.address().port));
 `,{eval:true,workerData:content});
 const [port]=await once(server,'message');
 const url=`http://127.0.0.1:${port}/service.properties`;
 check(loadURL(url),expected,'HTTP properties');
 check(await loadURLAsync(url),expected,'worker HTTP properties');
 check(Config.parseURL(url).resolve().toJSON(),expected,'HTTP parseURL / resolve');
 check((await Config.loadURLAsync(url)).toJSON(),expected,'worker HTTP factory');
 console.log(JSON.stringify({vectors:vectors.length,consumerChecks:checks-vectors.length,total:checks,passed:true}));
} finally {
 if(server)await server.terminate();
 fs.rmSync(dir,{recursive:true,force:true});
}
