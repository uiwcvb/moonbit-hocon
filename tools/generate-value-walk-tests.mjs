import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/value-walk-reference-vectors.json',import.meta.url),'utf8')),q=JSON.stringify;
let output='// Independent native numeric, traversal-order and search results.\n';const names=[];
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],ref=saved.references[i];if(!ref.accepted)continue;
 const name='value_walk_case_'+i;names.push(name);
 output+=`\n///|\nfn ${name}() -> Unit raise {\n let a = value_native_create(${q(req.calls[0].source)})\n let b = value_native_create(${q(req.calls[1].source)})\n`;
 for(let n=2;n<req.calls.length;n++){
  const call=req.calls[n],value=call.target===2?'b':'a',other=call.other===1?'a':'b';let operation;
  switch(call.op){
   case 'equals':operation=`@hocon.value_equals(${value},${other}).to_json()`;break;
   case 'hash':operation=`@hocon.value_hash(${value}).to_json()`;break;
   case 'index-of':operation=`@hocon.list_index_of(${value},${other}).to_json()`;break;
   case 'last-index-of':operation=`@hocon.list_index_of(${value},${other},last=true).to_json()`;break;
   case 'contains-value':operation=`(if @hocon.value_type(${value}) == "OBJECT" { @hocon.object_contains_value(${value},${other}) } else { @hocon.list_index_of(${value},${other}) >= 0 }).to_json()`;break;
   default:throw new Error(call.op);
  }
  output+=` assert_eq(value_native_attempt(() => ${operation}),@json.parse(${q(JSON.stringify(ref.value.results[n]))}))\n`;
 }
 output+='}\n';
}
for(let start=0;start<names.length;start+=64)output+=`\n///|\ntest "native value traversal batch ${start/64}" {\n${names.slice(start,start+64).map(name=>' '+name+'()').join('\n')}\n}\n`;
fs.writeFileSync(new URL('../value_walk_reference_test.mbt',import.meta.url),output);
console.log(names.length+' independent value traversal programs generated');
