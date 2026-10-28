import pathlib,json,hashlib,zipfile,difflib,re
HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parent.parent
sha=lambda b:hashlib.sha256(b).hexdigest()
read=lambda p:json.loads(p.read_text(encoding='utf-8'))
baseline=read(HERE/'BASELINE.json')['filesSHA256']
changed={n:{'beforeSHA256':h,'afterSHA256':sha((ROOT/n).read_bytes())} for n,h in baseline.items() if sha((ROOT/n).read_bytes())!=h}
expected={'config.mbt','resolver.mbt','document.mbt','tree_operations.mbt','value_semantics.mbt','value_render.mbt','cmd/web/config_transfer.mbt','pkg.generated.mbti','web/engine.mjs','README.md','FEATURES.md'}
assert set(changed)==expected,set(changed)^expected
new=['unresolved_origin_test.mbt','unresolved_origin_reference_test.mbt']
current={p.relative_to(ROOT).as_posix():sha(p.read_bytes()) for p in ROOT.rglob('*.mbt') if not any(n in ('_build','evidence','.mooncakes') for n in p.relative_to(ROOT).parts)}
with zipfile.ZipFile(HERE/'sources-before.zip') as z:
 diffs=[]
 for n in sorted(expected-{'web/engine.mjs'}):
  diff=''.join(difflib.unified_diff(z.read(n).decode('utf-8').splitlines(True),(ROOT/n).read_text(encoding='utf-8').splitlines(True),fromfile='before/'+n,tofile='after/'+n))
  diffs.append(diff)
  if n=='pkg.generated.mbti':
   (HERE/'api.diff').write_text(diff,encoding='utf-8')
   added=[l for l in diff.splitlines() if l.startswith('+') and not l.startswith('+++')]
   assert added==['+  LocatedSubstitution(Array[Array[String]], Bool, Bool, Int, SourcePosition)'],added
 for n in new:diffs.append(''.join(difflib.unified_diff([], (ROOT/n).read_text(encoding='utf-8').splitlines(True),fromfile='/dev/null',tofile='after/'+n)))
(HERE/'implementation.diff').write_text('\n'.join(diffs),encoding='utf-8')
with zipfile.ZipFile(HERE/'increment-source-and-engine.zip','x',zipfile.ZIP_DEFLATED) as z:
 for n in sorted(set(changed)|set(new)):z.write(ROOT/n,n)
phases={}
for phase in ['new-js','new-wasm','related-js','related-wasm','build-js','info','fmt-check']:
 d=HERE/phase;r=read(d/'receipt.json')
 assert r['exitCode']==0 and r['sourcesStable'] and read(d/'inputs.json')==current,(phase,r)
 assert sha((d/'stdout.bin').read_bytes())==r['stdoutSHA256']
 assert sha((d/'stderr.bin').read_bytes())==r['stderrSHA256']
 out=(d/'stdout.bin').read_text(encoding='utf-8')
 m=re.search(r'Total tests: (\d+), passed: (\d+), failed: (\d+)\.',out)
 phases[phase]={'receipt':str((d/'receipt.json').relative_to(ROOT)).replace('\\','/'),'receiptSHA256':sha((d/'receipt.json').read_bytes()),'exitCode':0}
 if m:
  counts=list(map(int,m.groups()));assert counts==([17,17,0] if phase.startswith('new-') else [40,40,0])
  phases[phase]['tests']={'total':counts[0],'passed':counts[1],'failed':counts[2]}
reference=read(HERE/'REFERENCE-RECEIPT.json');assert reference['exitCode']==0 and reference['results']==13
host=read(HERE/'HOST-REFERENCE-RESULTS.json');assert (host['total'],host['passed'],host['failed'])==(30,30,0)
engine=read(HERE/'ENGINE-COPY.json');assert sha((ROOT/'web/engine.mjs').read_bytes())==engine['readBackSHA256']==host['engineSHA256']
protected=[n for n in baseline if n not in changed]
artifacts=['BASELINE.json','sources-before.zip','requests.jsonl','OriginReference.java','reference.stdout.jsonl','reference.stderr.bin','REFERENCE-RECEIPT.json','GENERATED-TESTS.json','HOST-REFERENCE-RESULTS.json','ENGINE-COPY.json','api.diff','implementation.diff','increment-source-and-engine.zip','RESULTS.md','check.stdout.log','check.stderr.log','fmt.stdout.log','fmt.stderr.log','host.stdout.log','host.stderr.log']
report={'scope':'missing mandatory substitution source origins only; not complete HOCON/JVM exceptions','baselineFilesReadBack':len(baseline),'unchangedBaselineFiles':len(protected),'protectedOriginalFilesStable':True,'changedFiles':changed,'addedTests':{n:sha((ROOT/n).read_bytes()) for n in new},'allMoonSourceSHA256':current,'allVerificationPhasesUseSameMoonSources':True,'phases':phases,'strictCheck':{'command':'moon check --target all --deny-warn','actualExitCode':0,'observedToolSession':3938,'terminalChunk':'81399a','rawStdout':'check.stdout.log','rawStderr':'check.stderr.log','notRerunAfterPassing':True},'independentReference':{'jarSHA256':reference['jarSHA256'],'requests':13,'missingSubstitutionErrors':9,'successfulValues':4,'compared':['missing-reference category mapping','actual origin description/source','line','successful values'],'notProvidedByReference':['column','offset'],'referenceReceiptSHA256':sha((HERE/'REFERENCE-RECEIPT.json').read_bytes())},'host':{'total':30,'passed':30,'failed':0,'resultSHA256':sha((HERE/'HOST-REFERENCE-RESULTS.json').read_bytes())},'engineSHA256':host['engineSHA256'],'apiSHA256':sha((ROOT/'pkg.generated.mbti').read_bytes()),'apiChange':'additive LocatedSubstitution variant; exhaustive pattern matches/raw representation/structural Eq compatibility cost explicitly documented','notChanged':['ParseError.Invalid constructor','legacy four-argument Substitution constructor','manual unlocated values Invalid behavior','resolved success semantics','semantic value_equals/value_hash/render contract','other projects','portfolio state','historical outputs','judges ZIP'],'notClaimed':['all HOCON complete','all diagnostics located','upstream column/offset equality','full suite rerun','remote CI/publish'],'artifactsSHA256':{n:sha((HERE/n).read_bytes()) for n in artifacts}}
(HERE/'CHECKS.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
assert read(HERE/'CHECKS.json')==report
print(json.dumps({'changedFiles':sorted(changed),'addedTests':new,'protectedStable':len(protected),'apiSHA256':report['apiSHA256'],'engineSHA256':report['engineSHA256'],'CHECKSsha256':sha((HERE/'CHECKS.json').read_bytes()),'diffSHA256':sha((HERE/'implementation.diff').read_bytes()),'incrementZIPsha256':sha((HERE/'increment-source-and-engine.zip').read_bytes())},ensure_ascii=False,indent=2))
