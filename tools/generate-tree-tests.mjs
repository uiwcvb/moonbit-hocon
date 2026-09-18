import assert from 'node:assert/strict';
import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/tree-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify;
function sortedProblems(problems){return problems.map(p=>p.path+'\n'+p.kind).sort();}
let output=`// Independent saved Lightbend 1.4.9 results; node tools/generate-tree-tests.mjs then moon fmt.
///|
fn tree_test_problems(problems : Array[@hocon.ValidationProblem]) -> Json {
  let items = problems.map(p => p.path + "\\n" + p.kind)
  items.sort_by((a, b) => a.lexical_compare(b))
  items.to_json()
}
`;
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i];let body=`    let ${req.operations?.length?'mut ':''}config = @hocon.parse_sources({name:"<string>",content:${q(req.source)},format:"hocon"}, object_only=true)\n`;
 for(const op of req.operations??[]){
  const fn=op.op.replaceAll('-','_');
  if(op.op==='with-value'||op.op==='with-key-value')body+=`    config = @hocon.${fn}(config, ${q(op.path)}, @hocon.get_path(@hocon.parse(${q('value='+(op.valueSource??JSON.stringify(op.value)))}), ["value"]).unwrap())\n`;
  else if(op.op==='with-fallback')body+=`    config = @hocon.with_fallback(config, @hocon.parse(${q(op.source)}))\n`;
  else body+=`    config = @hocon.${fn}(config, ${q(op.path)})\n`;
 }
 if(req.checkValid)body+=`    @hocon.check_valid(config, @hocon.parse(${q(req.checkValid.source)}), paths=${q(req.checkValid.paths??[])})\n`;
 let value;
 switch(req.getter){
  case 'entries':value='@json.parse(@hocon.Object(@hocon.entry_set(config)).to_json_string())';break;
  case 'empty':value='@hocon.is_empty(config).to_json()';break;
  case 'resolved':value='@hocon.is_resolved(config).to_json()';break;
  case 'has-or-null':value=`@hocon.has_path_or_null(config, ${q(req.path)}).to_json()`;break;
  case 'validation':value=`tree_test_problems(@hocon.validation_problems(config, @hocon.parse(${q(req.referenceSource)}), paths=${q(req.validationPaths??[])}))`;break;
  default:value='@json.parse(config.to_json_string())';
 }
 body+=`    (true, ${value})\n`;
 const expected=ref.accepted?(req.getter==='validation'?sortedProblems(ref.value):ref.value):ref.problems?sortedProblems(ref.problems):null;
 const catchValidation=req.checkValid?'    @hocon.ValidationFailed(problems) => (false, tree_test_problems(problems))\n':'';
 output+=`\n///|\ntest "official tree ${i}" {\n  let actual = try {\n${body}  } catch {\n${catchValidation}    _ => (false, Json::null())\n  }\n  assert_eq(actual, (${ref.accepted}, @json.parse(${q(JSON.stringify(expected))})))\n}\n`;
}
fs.writeFileSync(new URL('../tree_reference_test.mbt',import.meta.url),output);
console.log(saved.requests.length+' independent public tree API tests generated');
