import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/path-reference-vectors.json',import.meta.url),'utf8'));
const q=JSON.stringify;
let output='// Independently captured ConfigUtil.splitPath results from the pinned native JAR.\n';
for(let i=0;i<saved.requests.length;i++){
 const expected=saved.references[i];
 output+=`\n///|\ntest "native API path ${i}" {\n  let observed = try { (true,@hocon.split_path(${q(saved.requests[i].path)})) } catch { _ => (false,[]) }\n  assert_eq(observed,(${expected.accepted},[${(expected.value??[]).map(q).join(',')}]))\n}\n`;
}
fs.writeFileSync(new URL('../path_reference_test.mbt',import.meta.url),output);
console.log(saved.requests.length+' independent public path tests generated');
