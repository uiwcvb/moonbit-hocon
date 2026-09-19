import assert from 'node:assert/strict';
import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {cases} from './double-getter-cases.mjs';
import {sourceHashes} from './evidence.mjs';
const check=process.argv.includes('--check'),live=process.argv.includes('--live'),vectorFile=new URL('../evidence/double-getter-vectors.json',import.meta.url);
let saved;
if(live){
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const run=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('./DoubleGetterOracle.java',import.meta.url))],{input:cases.map(c=>c.kind+'\t'+Buffer.from(c.value,'utf8').toString('base64')).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:120000,maxBuffer:32*1024*1024});assert.equal(run.status,0,run.stderr||String(run.error));
 const expected=run.stdout.trim().split(/\r?\n/).map(s=>s.split('\t'));assert.equal(expected.length,cases.length);for(const row of expected)assert.equal(row.length,2);
 saved={reference:'unmodified Lightbend Config 1.4.9 getDouble/getDoubleList; canonical binary64 bits or ERROR',jarSha256:createHash('sha256').update(fs.readFileSync(jar)).digest('hex'),cases,expected};
 if(check)assert.deepEqual(saved,JSON.parse(fs.readFileSync(vectorFile,'utf8')));else fs.writeFileSync(vectorFile,JSON.stringify(saved,null,2)+'\n');
}else saved=JSON.parse(fs.readFileSync(vectorFile,'utf8'));
assert.deepEqual(saved.cases,cases);
let source=`// Public native getter expectations, distinct from primitive Double.parseDouble.
///|
fn double_getter_case(kind : String, text : String, list : Bool) -> String {
  try {
    let config = if kind == "text" { Object({ "v": Text(text) }) } else { parse("v=" + text) }
    let value = if list {
      get_double_list(Object({ "items": List([get_value(config, "v")]) }), "items")[0]
    } else { get_double(config, "v") }
    if value.is_nan() { "9221120237041090560" } else { value.reinterpret_as_int64().to_string() }
  } catch { _ => "ERROR" }
}
`;
for(let start=0;start<cases.length;start+=128){
 source+=`\n///|\ntest "native public double getter batch ${start/128}" {\n  let cases : Array[(String, String, String, String)] = [\n`;
 for(let i=start;i<Math.min(cases.length,start+128);i++)source+='    ('+[cases[i].kind,cases[i].value,...saved.expected[i]].map(JSON.stringify).join(', ')+'),\n';
 source+='  ]\n  for (kind, text, scalar, list) in cases {\n    assert_eq(double_getter_case(kind, text, false), scalar)\n    assert_eq(double_getter_case(kind, text, true), list)\n  }\n}\n';
}
const file=new URL('../double_getter_wbtest.mbt',import.meta.url);
// Formatting can add trailing commas to multiline tuples and calls. Preserve
// every string literal and meaningful token; normalize only optional commas.
const tokens=s=>{const parts=s.match(/"(?:\\.|[^"\\])*"|\/\/[^\n]*|[^\s]/g);return parts.filter((t,i)=>!(t===','&&[')',']','}'].includes(parts[i+1]))).join('');};
if(check)assert(tokens(fs.readFileSync(file,'utf8'))===tokens(source),'Regenerate double_getter_wbtest.mbt');else fs.writeFileSync(file,source);
if(live)fs.writeFileSync(new URL('../evidence/double-getter-native.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),mode:check?'live public getter recapture matches saved vectors and generated tests':'live public getter capture',inputs:cases.length,unique:new Set(cases.map(JSON.stringify)).size,getterComparisons:cases.length*2,groups:Math.ceil(cases.length/128),jarSha256:saved.jarSha256,sourceHashes:sourceHashes()},null,2)+'\n');
if(process.argv.includes('--bridge')){
 const {Config}=await import('./config-object.mjs'),view=new DataView(new ArrayBuffer(8));
 const bits=n=>{if(n==='NaN')return '9221120237041090560';if(n==='Infinity')n=Infinity;if(n==='-Infinity')n=-Infinity;view.setFloat64(0,n);return view.getBigInt64(0).toString();};
 for(let i=0;i<cases.length;i++)for(const list of [false,true]){
  const c=cases[i];let actual;
  try{const config=c.kind==='text'?Config.fromObject(list?{items:[c.value]}:{v:c.value}):Config.load(list?'items=['+c.value+']':'v='+c.value);actual=bits(list?config.getDoubleList('items')[0]:config.getDouble('v'));}catch{actual='ERROR';}
  assert.equal(actual,saved.expected[i][Number(list)],JSON.stringify({case:c,list}));
 }
 fs.writeFileSync(new URL('../evidence/double-getter-bridge.json',import.meta.url),JSON.stringify({utc:new Date().toISOString(),inputs:cases.length,comparisons:cases.length*2,passed:cases.length*2,failed:0,sourceHashes:sourceHashes()},null,2)+'\n');
}
console.log(cases.length+' distinct public double inputs '+(check?'checked':'generated')+' in '+Math.ceil(cases.length/128)+' groups; '+cases.length*2+' scalar/list comparisons'+(process.argv.includes('--bridge')?' also passed in native JS bridge':''));
