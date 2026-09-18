import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/accessor-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify,map=v=>'{'+Object.entries(v??{}).map(([k,v])=>q(k)+':'+q(v)).join(',')+'}';
let output='// Independent Lightbend Config 1.4.9 results; node tools/generate-accessor-tests.mjs then moon fmt.\n';
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i],path=q(req.path);
 const calls={
  number:`@hocon.get_number(config, ${path}).to_json()`,
  'number-list':`@hocon.get_number_list(config, ${path}).to_json()`,
  object:`@json.parse(@hocon.Object(@hocon.get_object(config, ${path})).to_json_string())`,
  'object-list':`@json.parse(@hocon.List(@hocon.get_object_list(config, ${path}).map(fields => @hocon.Object(fields))).to_json_string())`,
  'any-ref':`@json.parse(@hocon.get_any_ref(config, ${path}).to_json_string())`,
  'any-ref-list':`@json.parse(@hocon.List(@hocon.get_any_ref_list(config, ${path})).to_json_string())`,
  enum:`@hocon.get_enum(config, ${path}, ${map(Object.fromEntries((req.enumChoices??[]).map(v=>[v,v])))}).to_json()`,
  'enum-list':`@hocon.get_enum_list(config, ${path}, ${map(Object.fromEntries((req.enumChoices??[]).map(v=>[v,v])))}).to_json()`,
  'long-list':`@hocon.get_long_list(config, ${path}).map(n => n.to_string()).to_json()`,
  'double-list':`@hocon.get_double_list(config, ${path}).to_json()`,
 };
 const fallbacks='['+(req.fallbacks??[]).map((content,i)=>`{name:${q('<fallback '+i+'>')},content:${q(content)},format:"hocon"}`).join(',')+']';
 output+=`\n///|\ntest "official extended accessor ${i}" {\n  let actual = try {\n    let config = @hocon.parse_sources({name:"<string>",content:${q(req.source)},format:${q(req.format??'hocon')}}, object_only=true, includes=${map(req.includes)}, environment=${map(req.environment)}, fallbacks=${fallbacks})\n    (true, ${calls[req.getter]})\n  } catch { _ => (false, Json::null()) }\n  assert_eq(actual, (${ref.accepted}, @json.parse(${q(JSON.stringify(ref.accepted?ref.value:null))})))\n}\n`;
}
fs.writeFileSync(new URL('../accessor_reference_test.mbt',import.meta.url),output);
console.log(saved.requests.length+' independent public extended accessor tests generated');
