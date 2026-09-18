import assert from 'node:assert/strict';
import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {texts} from './double-parse-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const vectors=new URL('../evidence/double-parse-vectors.json',import.meta.url),check=process.argv.includes('--check');let saved;
if(process.argv.includes('--live')){
 const run=spawnSync(process.env.JAVA??'java',[fileURLToPath(new URL('./DoubleParseOracle.java',import.meta.url))],{input:texts.map(s=>Buffer.from(s,'utf8').toString('base64')).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:64*1024*1024});assert.equal(run.status,0,run.stderr||String(run.error));
 const expected=run.stdout.trim().split(/\r?\n/);assert.equal(expected.length,texts.length);
 const version=spawnSync(process.env.JAVA??'java',['-version'],{encoding:'utf8',windowsHide:true});assert.equal(version.status,0);
 saved={reference:'unmodified JDK Double.doubleToLongBits(Double.parseDouble(text)); ERROR for NumberFormatException',java:version.stderr.trim(),texts,expected};
 if(check)assert.deepEqual(saved,JSON.parse(fs.readFileSync(vectors,'utf8')));else fs.writeFileSync(vectors,JSON.stringify(saved,null,2)+'\n');
}else saved=JSON.parse(fs.readFileSync(vectors,'utf8'));
assert.deepEqual(saved.texts,texts);assert.equal(saved.expected.length,texts.length);
let source='// Independent JDK parse results; exact canonical bits or rejection.\n';
for(let start=0;start<texts.length;start+=128){
 source+=`\n///|\ntest "native binary64 parsing batch ${start/128}" {\n  let cases : Array[String] = [\n`;
 for(const text of texts.slice(start,start+128))source+='    '+JSON.stringify(text)+',\n';
 source+='  ]\n  let expected : Array[String] = [\n';
 for(const result of saved.expected.slice(start,start+128))source+='    '+JSON.stringify(result)+',\n';
 source+='  ]\n  for i = 0; i < cases.length(); i = i + 1 {\n    let actual = try {\n      let value = double_value(cases[i])\n      if value.is_nan() {\n        "9221120237041090560"\n      } else {\n        value.reinterpret_as_int64().to_string()\n      }\n    } catch {\n      _ => "ERROR"\n    }\n    assert_eq(actual, expected[i])\n  }\n}\n';
}
const target=new URL('../double_parse_wbtest.mbt',import.meta.url);
// Moon formats string arrays into packed lines. Ignore only whitespace outside
// string literals/comments; all generated test tokens and literal bytes match.
const tokens=s=>s.match(/"(?:\\.|[^"\\])*"|\/\/[^\n]*|[^\s]/g).join('');
if(check)assert(tokens(fs.readFileSync(target,'utf8').replaceAll('\r\n','\n'))===tokens(source),'Regenerate double_parse_wbtest.mbt');else fs.writeFileSync(target,source);
if(process.argv.includes('--live'))fs.writeFileSync(new URL('../evidence/double-parse-native.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),mode:check?'live JDK primitive parser recapture matches saved vectors and generated tests':'live JDK primitive parser capture; outputs checked by generated backend tests',total:texts.length,unique:new Set(texts).size,accepted:saved.expected.filter(s=>s!=='ERROR').length,rejected:saved.expected.filter(s=>s==='ERROR').length,java:saved.java,sourceHashes:sourceHashes()},null,2)+'\n');
console.log(texts.length+' distinct native binary64 parse vectors '+(check?'checked':'generated')+' in '+Math.ceil(texts.length/128)+' backend groups');
