import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/persistent-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify,map=v=>'{'+Object.entries(v??{}).map(([k,v])=>q(k)+':'+q(v)).join(',')+'}';
let output=`// Native reference results for core child views and enclosing lookback after wrapping.
///|
fn persistent_state(config : @hocon.Value, paths : Array[String]) -> Json raise {
  let result : Map[String,Json] = { "resolved": @hocon.is_resolved(config).to_json() }
  if @hocon.is_resolved(config) { result["value"] = @json.parse(config.to_json_string()) }
  let probes : Map[String,Json] = Map([])
  for path in paths {
    probes[path] = try { Json::object({"accepted":true,"value":@json.parse(@hocon.get_value(config,path).to_json_string())}) }
    catch { _ => Json::object({"accepted":false}) }
  }
  result["probes"] = Json::object(probes)
  Json::object(result)
}
`;
let count=0;
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i],first=req.calls[0];
 const child=first.action==='derive'&&first.op==='get-config';
 const wrapped=first.action==='derive'&&first.op==='at-path'&&req.calls.length===3;
 if(!child&&!wrapped)continue;
 const operation=child?`@hocon.get_config(raw,${q(first.path)})`:`@hocon.resolve(@hocon.at_path(raw,${q(first.path)}),allow_unresolved=${req.calls[1].allowUnresolved})`;
 const expected=ref.value.results[child?0:1];
 const state=expected.accepted?ref.value.final[expected.value]:null;
 output+=`\n///|\ntest "native persistent core ${i}" {\n  let raw = @hocon.parse_sources_unresolved({name:"<string>",content:${q(req.source)},format:"hocon"},includes=${map(req.includes)},object_only=true)\n  let paths = [${req.probes.map(q).join(',')}]\n  let observed = try { (true,persistent_state(${operation},paths)) } catch { _ => (false,Json::null()) }\n  assert_eq(observed,(${expected.accepted},@json.parse(${q(JSON.stringify(state))})))\n  assert_eq(persistent_state(raw,paths),@json.parse(${q(JSON.stringify(ref.value.initial))}))\n}\n`;
 count++;
}
fs.writeFileSync(new URL('../persistent_core_reference_test.mbt',import.meta.url),output);
console.log(count+' independent persistent core tests generated');
