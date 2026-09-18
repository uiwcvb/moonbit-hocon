import fs from 'node:fs';
const saved=JSON.parse(fs.readFileSync(new URL('../evidence/render-reference-vectors.json',import.meta.url),'utf8')),q=JSON.stringify;
let output='// Independent exact native render results; generated from the unmodified JAR.\n';const names=[];
for(let i=0;i<saved.requests.length;i++){
 const req=saved.requests[i],expected=saved.references[i],name='render_native_case_'+i;names.push(name);
 const includes=req.includes?',includes=Map(['+Object.entries(req.includes).map(([key,value])=>'('+q(key)+','+q(value)+')').join(',')+'])':'';
 let init=req.value!==undefined?`value_native_create(${q(req.value)})`:`@hocon.${req.resolved?'parse':'parse_unresolved'}(${q(req.source)}${includes})`;
 const steps=req.steps??[];
 output+=`\n///|\nfn ${name}() -> Unit raise {\n let actual = value_native_attempt(() => {\n let ${steps.length?'mut ':''}value = ${init}\n`;
 for(const step of steps){let code;
  switch(step.op){
   case 'key':code=`match @hocon.object_get(value,${q(step.key)}) { Some(child) => child; None => raise Failure("missing render key") }`;break;
   case 'index':code=`@hocon.list_get(value,${step.index})`;break;
   case 'path':code=`@hocon.get_value(value,${q(step.key)})`;break;
   case 'fallback':code=`@hocon.value_with_fallback(value,value_native_create(${q(step.value)}))`;break;
   case 'with-key':code=`@hocon.with_key_value(value,${q(step.key)},value_native_create(${q(step.value)}))`;break;
   case 'without-key':code=`@hocon.without_key(value,${q(step.key)})`;break;
   case 'at-key':code=`@hocon.at_key(value,${q(step.key)})`;break;
   case 'at-path':code=`@hocon.at_path(value,${q(step.key)})`;break;
   case 'resolve':code=`@hocon.resolve(value,allow_unresolved=${step.allowUnresolved??false})`;break;
   default:throw new Error(step.op);
  }
  output+=` value = ${code}\n`;
 }
 output+=` @hocon.render_value(value,json=${req.json??true},formatted=${req.formatted??false}).to_json()\n })\n assert_eq(actual,@json.parse(${q(JSON.stringify(expected))}))\n}\n`;
}
for(let start=0;start<names.length;start+=64)output+=`\n///|\ntest "native rendering batch ${start/64}" {\n${names.slice(start,start+64).map(name=>' '+name+'()').join('\n')}\n}\n`;
fs.writeFileSync(new URL('../render_reference_test.mbt',import.meta.url),output);
console.log(names.length+' independent exact render cases generated');
