import assert from 'node:assert/strict';
import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {bits} from './double-render-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const vectors=new URL('../evidence/double-render-vectors.json',import.meta.url);
const check=process.argv.includes('--check');let saved;
if(process.argv.includes('--live')){
 const run=spawnSync(process.env.JAVA??'java',[fileURLToPath(new URL('./DoubleRenderOracle.java',import.meta.url))],{input:bits.join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:32*1024*1024});assert.equal(run.status,0,run.stderr||String(run.error));
 const expected=run.stdout.trim().split(/\r?\n/);assert.equal(expected.length,bits.length);
 const version=spawnSync(process.env.JAVA??'java',['-version'],{encoding:'utf8',windowsHide:true});assert.equal(version.status,0);
 saved={reference:'unmodified JDK Double.toString(Double.longBitsToDouble(bits))',java:version.stderr.trim(),bits,expected};if(check)assert.deepEqual(saved,JSON.parse(fs.readFileSync(vectors,'utf8')));
 else fs.writeFileSync(vectors,JSON.stringify(saved,null,2)+'\n');
}else saved=JSON.parse(fs.readFileSync(vectors,'utf8'));
assert.deepEqual(saved.bits,bits);assert.equal(saved.expected.length,bits.length);
let source='// Independent JDK outputs; tests the formatter directly, including non-finite bit patterns.\n';
for(let start=0;start<bits.length;start+=128){source+=`\n///|\ntest "native binary64 rendering batch ${start/128}" {\n  let cases : Array[(String, String)] = [\n`;
 for(let i=start;i<Math.min(start+128,bits.length);i++)source+=`    (${JSON.stringify(bits[i])}, ${JSON.stringify(saved.expected[i])}),\n`;
 source+='  ]\n  for (bits, expected) in cases {\n    let value = @string.parse_int64(bits).reinterpret_as_double()\n    assert_eq(render_double(value), expected)\n  }\n}\n';
}
const target=new URL('../double_render_wbtest.mbt',import.meta.url);
if(check)assert.equal(fs.readFileSync(target,'utf8').replaceAll('\r\n','\n'),source,'Regenerate double_render_wbtest.mbt from saved independent vectors');
else fs.writeFileSync(target,source);
if(process.argv.includes('--live'))fs.writeFileSync(new URL('../evidence/double-render-native.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),mode:check?'live JDK primitive formatter recapture matches saved vectors and generated tests':'live JDK primitive formatter capture; outputs checked by generated backend tests',total:bits.length,unique:new Set(bits).size,java:saved.java,sourceHashes:sourceHashes()},null,2)+'\n');
console.log(bits.length+' distinct native binary64 vectors '+(check?'checked':'generated')+' in '+Math.ceil(bits.length/128)+' backend groups');
