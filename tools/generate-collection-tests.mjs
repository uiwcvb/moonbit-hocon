import assert from 'node:assert/strict';
import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/collection-reference-vectors.json',import.meta.url),'utf8'));
assert.equal(saved.requests.length,saved.references.length);
const quote=JSON.stringify;
let output=`// Generated from saved unmodified Lightbend Config 1.4.9 results.
// Regenerate with node tools/generate-collection-tests.mjs, then moon fmt.
///|
fn collection_result(source : String, fallbacks : Array[String], kind : String, path : String) -> (Bool, Json) {
  try {
    let config = @hocon.parse(source, fallbacks~)
    let value = match kind {
      "string-list" => @hocon.get_string_list(config, path).to_json()
      "boolean-list" => @hocon.get_bool_list(config, path).to_json()
      "int-list" => @hocon.get_int_list(config, path).to_json()
      "long-list" => @hocon.get_long_list(config, path).map(n => n.to_string()).to_json()
      "double-list" => @hocon.get_double_list(config, path).map(n => {
        if n.is_nan() { "NaN".to_json() }
        else if n.is_inf() { (if n > 0 { "Infinity" } else { "-Infinity" }).to_json() }
        else { n.to_json() }
      }).to_json()
      "duration-list" => @hocon.get_duration_list(config, path).map(n => n.to_string()).to_json()
      "bytes-list" => @hocon.get_bytes_list(config, path).map(n => n.to_string()).to_json()
      "memory-list" => @hocon.get_memory_size_list(config, path).to_json()
      "config" => @json.parse(@hocon.get_config(config, path).to_json_string())
      "config-list" => @json.parse(@hocon.List(@hocon.get_config_list(config, path)).to_json_string())
      _ => abort("unknown generated collection getter")
    }
    (true, value)
  } catch { _ => (false, Json::null()) }
}
`;
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i];
 assert.deepEqual(Object.keys(req).sort(),(req.fallbacks?['fallbacks','getter','path','source']:['getter','path','source']));
 output+=`\n///|\ntest "official collection ${i}: ${req.getter}" {\n  assert_eq(collection_result(${quote(req.source)}, ${quote(req.fallbacks??[])}, ${quote(req.getter)}, ${quote(req.path)}), (${ref.accepted}, @json.parse(${quote(JSON.stringify(ref.accepted?ref.value:null))})))\n}\n`;
}
fs.writeFileSync(new URL('../collection_reference_test.mbt',import.meta.url),output);
console.log(`Generated ${saved.requests.length} independent public API cases`);
