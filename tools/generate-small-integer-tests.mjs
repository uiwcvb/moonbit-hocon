import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {sourceHashes} from './evidence.mjs';
const vectors=new URL('../evidence/small-integer-vectors.json',import.meta.url),target=new URL('../small_integer_wbtest.mbt',import.meta.url);
const texts=new Set(['','+','-','--1','++1','+-1','-+1',' 1','1 ','\t1','1\n','0x10','1_0','1.0','1e0','NaN','Infinity','a','😀']);
const add=s=>{if(s.length<=11)texts.add(s);};
for(const edge of [-2147483648,-1,0,1,2147483647])for(let d=-32;d<=32;d++){const n=edge+d;for(const sign of n<0?['-']:['','+'])for(const pad of [0,1,2,7,10])add(sign+'0'.repeat(pad)+Math.abs(n));}
let seed=0x792375;
for(let i=0;i<1024;i++){seed=(Math.imul(seed,1664525)+1013904223)|0;add(String(seed));if(seed>=0)add('+'+seed);}
for(let c=0;c<128;c++){const ch=String.fromCharCode(c);if(ch>='0'&&ch<='9')continue;add('12'+ch+'34');}
const inputs=[...texts];let saved;
if(process.argv.includes('--live')){
 const run=spawnSync(process.env.JAVA??'java',[fileURLToPath(new URL('./SmallIntegerOracle.java',import.meta.url))],{input:inputs.map(s=>Buffer.from(s).toString('base64')).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:30000});assert.equal(run.status,0,run.stderr||String(run.error));const expected=run.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(expected.length,inputs.length);
 const version=spawnSync(process.env.JAVA??'java',['-version'],{encoding:'utf8',windowsHide:true});assert.equal(version.status,0);saved={reference:'Unmodified JDK Integer.valueOf, bounded ASCII spellings with <=11 UTF-16 units; invalid samples also include one supplementary non-digit.',java:version.stderr.split(/\r?\n/)[0],inputs,expected};
 if(process.argv.includes('--check'))assert.deepEqual(JSON.parse(fs.readFileSync(vectors,'utf8')),saved);else fs.writeFileSync(vectors,JSON.stringify(saved,null,2)+'\n');
}else{saved=JSON.parse(fs.readFileSync(vectors,'utf8'));assert.deepEqual(saved.inputs,inputs);}
let output='// Independent JDK integer boundary and malformed input observations.\n';
for(let at=0;at<inputs.length;at+=128){output+=`\n///|\ntest "native small integer batch ${at/128}" {\n let cases : Array[(String,Int?)] = [\n`;for(let i=at;i<Math.min(at+128,inputs.length);i++)output+=` (${JSON.stringify(inputs[i])},${saved.expected[i]===null?'None':'Some('+saved.expected[i]+')'}),\n`;output+=' ]\n for (text,expected) in cases { assert_eq(small_number(text),expected) }\n}\n';}
if(process.argv.includes('--check')){const tokens=s=>s.match(/"(?:\\.|[^"\\])*"|[A-Za-z_][A-Za-z_0-9]*|-?[0-9]+|[^\s]/g);assert.deepEqual(tokens(fs.readFileSync(target,'utf8')),tokens(output));}else fs.writeFileSync(target,output);
fs.writeFileSync(new URL('../evidence/small-integer-native.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),mode:process.argv.includes('--live')?'live JDK '+(process.argv.includes('--check')?'recapture matches saved vectors':'capture'):'saved JDK vectors',total:inputs.length,unique:new Set(inputs).size,groups:Math.ceil(inputs.length/128),java:saved.java,scope:saved.reference,sourceHashes:sourceHashes()},null,2)+'\n');console.log(inputs.length+' distinct native Integer inputs '+(process.argv.includes('--check')?'checked':'generated')+' in '+Math.ceil(inputs.length/128)+' groups');
