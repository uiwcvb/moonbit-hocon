import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/temporal-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify,map=v=>'{'+Object.entries(v??{}).map(([k,v])=>q(k)+':'+q(v)).join(',')+'}';
let output='// Independent Lightbend Config 1.4.9 results; node tools/generate-temporal-tests.mjs then moon fmt.\n';
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i],path=q(req.path),unit='@hocon.'+(req.unit?.[0].toUpperCase()+req.unit?.slice(1));
 const calls={
  period:`@hocon.get_period(config, ${path}).to_json()`,
  temporal:`@hocon.get_temporal(config, ${path}).to_json()`,
  'duration-in':`@hocon.get_duration_in(config, ${path}, ${unit}).to_string().to_json()`,
  'duration-list-in':`@hocon.get_duration_list_in(config, ${path}, ${unit}).map(n => n.to_string()).to_json()`,
  milliseconds:`@hocon.get_milliseconds(config, ${path}).to_string().to_json()`,
  nanoseconds:`@hocon.get_nanoseconds(config, ${path}).to_string().to_json()`,
  'milliseconds-list':`@hocon.get_milliseconds_list(config, ${path}).map(n => n.to_string()).to_json()`,
  'nanoseconds-list':`@hocon.get_nanoseconds_list(config, ${path}).map(n => n.to_string()).to_json()`,
 };
 const fallbacks='['+(req.fallbacks??[]).map((content,i)=>`{name:${q('<fallback '+i+'>')},content:${q(content)},format:"hocon"}`).join(',')+']';
 output+=`\n///|\ntest "official temporal ${i}" {\n  let actual = try {\n    let config = @hocon.parse_sources({name:"<string>",content:${q(req.source)},format:"hocon"}, object_only=true, includes=${map(req.includes)}, environment=${map(req.environment)}, fallbacks=${fallbacks})\n    (true, ${calls[req.getter]})\n  } catch { _ => (false, Json::null()) }\n  assert_eq(actual, (${ref.accepted}, @json.parse(${q(JSON.stringify(ref.accepted?ref.value:null))})))\n}\n`;
}
fs.writeFileSync(new URL('../temporal_reference_test.mbt',import.meta.url),output);
console.log(saved.requests.length+' independent public temporal tests generated');
