import json,pathlib,hashlib
HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parent.parent
cases=[json.loads(s) for s in (HERE/'requests.jsonl').read_text(encoding='utf-8').splitlines()]
refs=[json.loads(s) for s in (HERE/'reference.stdout.jsonl').read_text(encoding='utf-8').splitlines()]
def q(s):return json.dumps(s,ensure_ascii=False)
def source(s):return '{ name: '+q(s['name'])+', content: '+q(s['source'])+', format: "hocon", }'
def call(c):
 args=[source(c)]
 if c.get('includes'):args.append('includes=Map(['+','.join('('+q(k)+','+q(v)+')' for k,v in c['includes'].items())+'])')
 if c.get('fallbacks'):args.append('fallbacks=['+','.join(source(s) for s in c['fallbacks'])+']')
 return '@hocon.parse_sources('+','.join(args)+')'
out=['// Source/line/category cases come from actual unmodified Lightbend 1.4.9 output.',
 '// Column/offset are independently checked against the supplied text, not upstream fields.']
for c,r in zip(cases,refs):
 assert c['id']==r['id']
 out+=['///|','test "unresolved origin reference '+c['id']+'" {']
 if not r['accepted']:
  assert r['errorClass']=='com.typesafe.config.ConfigException$UnresolvedSubstitution'
  name=r['originDescription'].removesuffix(': '+str(r['line']))
  sources={c['name']:c['source'],**c.get('includes',{}),**{s['name']:s['source'] for s in c.get('fallbacks',[])}}
  text=sources[name];offset=text.index('$');line=text[:offset].count('\n')+1;column=len(text[:offset].rsplit('\n',1)[-1])+1
  assert line==r['line']
  out+=['  let position = try { ignore('+call(c)+'); None } catch {',
        '    @hocon.Located(_, position) => Some(position)', '    _ => None', '  }',
        '  assert_eq(position, Some(@hocon.SourcePosition::{source: '+q(name)+', offset: '+str(offset)+', line: '+str(line)+', column: '+str(column)+', }))']
 else:
  expected=json.dumps(r['value'],ensure_ascii=False,separators=(',',':'),sort_keys=True)
  out+=['  assert_eq('+call(c)+'.to_json_string(), '+q(expected)+')']
 out+=['}','']
target=ROOT/'unresolved_origin_reference_test.mbt'
assert not target.exists()
target.write_text('\n'.join(out),encoding='utf-8')
manifest={'referenceSHA256':hashlib.sha256((HERE/'reference.stdout.jsonl').read_bytes()).hexdigest(),'requestsSHA256':hashlib.sha256((HERE/'requests.jsonl').read_bytes()).hexdigest(),'testSHA256':hashlib.sha256(target.read_bytes()).hexdigest(),'cases':len(cases),'errorCases':sum(not x['accepted'] for x in refs),'upstreamComparableFields':['errorClass (mapped to missing-reference Located branch)','originDescription','line'],'inputContractOnlyFields':['offset (Unicode scalar index)','column (one-based Unicode scalar column)'],'noUpstreamColumnOrOffsetClaim':True}
(HERE/'GENERATED-TESTS.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
print(json.dumps(manifest))
