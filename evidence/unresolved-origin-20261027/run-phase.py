import pathlib,sys,subprocess,hashlib,json,os,time
HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parent.parent
MOON=pathlib.Path(r'D:/CodexLocal/ban/work/acceptance-20260928/moon/bin/moon.exe')
phase=sys.argv[1]
related=['core_test.mbt','configuration_test.mbt','document_test.mbt','tree_operations_test.mbt','persistent_core_test.mbt','value_containers_test.mbt','render_test.mbt','config_diff_test.mbt','config_change_policy_test.mbt']
commands={
 'new-js':[str(MOON),'test','unresolved_origin_test.mbt','unresolved_origin_reference_test.mbt','--target','js','--deny-warn','--target-dir','_build/origin-js'],
 'new-wasm':[str(MOON),'test','unresolved_origin_test.mbt','unresolved_origin_reference_test.mbt','--target','wasm-gc','--deny-warn','--target-dir','_build/origin-wasm'],
 'related-js':[str(MOON),'test',*related,'--target','js','--deny-warn','--target-dir','_build/origin-js'],
 'related-wasm':[str(MOON),'test',*related,'--target','wasm-gc','--deny-warn','--target-dir','_build/origin-wasm'],
 'build-js':[str(MOON),'build','--target','js','--deny-warn','--target-dir','_build/origin-host'],
 'info':[str(MOON),'info'],
 'fmt-check':[str(MOON),'fmt','--check'],
}
command=commands[phase]
dest=HERE/phase;dest.mkdir()
def sha(b):return hashlib.sha256(b).hexdigest()
def sources():return {p.relative_to(ROOT).as_posix():sha(p.read_bytes()) for p in ROOT.rglob('*.mbt') if not any(n in ('_build','evidence','.mooncakes') for n in p.relative_to(ROOT).parts)}
before=sources();(dest/'inputs.json').write_text(json.dumps(before,indent=2)+'\n',encoding='utf-8')
env=os.environ.copy();env['MOON_HOME']=str(MOON.parent.parent);env['PATH']=str(MOON.parent)+os.pathsep+env['PATH']
start=time.time_ns();process=subprocess.run(command,cwd=ROOT,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=180,creationflags=subprocess.CREATE_NO_WINDOW)
(dest/'stdout.bin').write_bytes(process.stdout);(dest/'stderr.bin').write_bytes(process.stderr)
receipt={'command':command,'cwd':str(ROOT),'moonSHA256':sha(MOON.read_bytes()),'startTimeNs':start,'endTimeNs':time.time_ns(),'exitCode':process.returncode,'sourceFiles':len(before),'sourcesStable':before==sources(),'inputsSHA256':sha((dest/'inputs.json').read_bytes()),'stdoutSHA256':sha(process.stdout),'stderrSHA256':sha(process.stderr)}
(dest/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(process.stdout.decode('utf-8',errors='replace')[-7000:]);print(process.stderr.decode('utf-8',errors='replace')[-7000:]);print(json.dumps(receipt));sys.exit(process.returncode)
