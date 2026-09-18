import assert from 'node:assert/strict';
import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/document-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify;
let output=`// Independent Lightbend Config 1.4.9 snapshots; node tools/generate-document-tests.mjs then moon fmt.
///|
fn document_test_state(config : @hocon.Value, probes : Array[String]) -> Json raise {
  let fields : Map[String, Json] = Map([])
  let resolved = @hocon.is_resolved(config)
  fields["resolved"] = resolved.to_json()
  if resolved { fields["value"] = @json.parse(config.to_json_string()) }
  let values : Map[String, Json] = Map([])
  for path in probes {
    values[path] = try {
      Json::object({"accepted": true, "value": @json.parse(@hocon.get_value(config, path).to_json_string())})
    } catch { _ => Json::object({"accepted": false}) }
  }
  fields["probes"] = Json::object(values)
  Json::object(fields)
}

///|
fn document_test_parse(source : String) -> @hocon.Value raise {
  @hocon.parse_sources_unresolved({name:"<string>", content:source, format:"hocon"}, includes={"part":"x=inner\\ny=\${x}"}, object_only=true)
}
`;
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i];
 assert.deepEqual(req.includes,{part:'x=inner\ny=${x}'});
 const environment='{'+Object.entries(req.environment).map(([k,v])=>q(k)+':'+q(v)).join(',')+'}';
 let body=`    let ${req.steps.length?'mut ':''}config = document_test_parse(${q(req.source)})\n    let states = [document_test_state(config, ${q(req.probes)})]\n`;
 for(const op of req.steps){
  const allow=`environment=${environment}, allow_unresolved=${!!op.allowUnresolved}`;
  if(op.op==='resolve')body+=`    config = @hocon.resolve(config, ${allow})\n`;
  else if(op.op==='resolve-with'||op.op==='resolve-with-self')body+=`    config = @hocon.resolve_with(config, ${op.op==='resolve-with-self'?'config':`document_test_parse(${q(op.source)})`}, ${allow})\n`;
  else if(op.op==='with-fallback')body+=`    config = @hocon.with_fallback(config, document_test_parse(${q(op.source)}))\n`;
  else if(['with-value','with-key-value'].includes(op.op))body+=`    config = @hocon.${op.op.replaceAll('-','_')}(config, ${q(op.path)}, @hocon.get_path(document_test_parse(${q('value='+(op.valueSource??JSON.stringify(op.value)))}), ["value"]).unwrap())\n`;
  else body+=`    config = @hocon.${op.op.replaceAll('-','_')}(config, ${q(op.path)})\n`;
  body+=`    states.push(document_test_state(config, ${q(req.probes)}))\n`;
 }
 body+='    (true, states.to_json())\n';
 output+=`\n///|\ntest "official document lifecycle ${i}" {\n  let actual = try {\n${body}  } catch { _ => (false, Json::null()) }\n  assert_eq(actual, (${ref.accepted}, @json.parse(${q(JSON.stringify(ref.accepted?ref.value:null))})))\n}\n`;
}
fs.writeFileSync(new URL('../document_reference_test.mbt',import.meta.url),output);
console.log(saved.requests.length+' independent public lifecycle API tests generated');
