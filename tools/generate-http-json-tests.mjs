import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/http-reference-vectors.json',import.meta.url),'utf8'));
let output='// Generated from saved official HTTP JSON-source results.\n',count=0;
for(let i=0;i<saved.cases.length;i++){
 const name=saved.cases[i].url?.replace(/^@HTTP@/,'');
 if(!name||!(['/empty.json','/bom.json','/duplicate.json','/nested-duplicate.json'].includes(name)||name.startsWith('/json-space-')))continue;
 const source=saved.fixtures[name].body,expected=saved.references[i];count++;
 output+=`\n///|\ntest "official HTTP JSON source ${count}" {\n  let actual = try {\n    let value = @hocon.parse_sources({name: "source.json", content: ${JSON.stringify(source)}, format: "json"}, object_only=true)\n    (true, @json.parse(value.to_json_string()))\n  } catch { _ => (false, Json::null()) }\n  assert_eq(actual, (${expected.accepted}, @json.parse(${JSON.stringify(JSON.stringify(expected.accepted?expected.value:null))})))\n}\n`;
}
fs.writeFileSync(new URL('../http_json_reference_test.mbt',import.meta.url),output);
console.log(`Generated ${count} independent JSON-source public API cases`);
