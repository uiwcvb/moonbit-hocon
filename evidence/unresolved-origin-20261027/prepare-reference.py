import hashlib,json,pathlib,subprocess,os
HERE=pathlib.Path(__file__).resolve().parent
CASES=[
 {'id':'direct','name':'direct.conf','source':'ready=1\nvalue = ${missing}'},
 {'id':'unicode-crlf','name':'中文.conf','source':'# 注释😀\r\n  value = ${不存在}'},
 {'id':'concat','name':'concat.conf','source':'x = prefix ${missing} suffix'},
 {'id':'array','name':'array.conf','source':'items=[1,\n  ${missing}\n]'},
 {'id':'quoted-path','name':'quoted.conf','source':'x=${"missing.key"}'},
 {'id':'include','name':'main.conf','source':'include "child.conf"','includes':{'child.conf':'# child\nvalue = ${missing}'}},
 {'id':'nested-include','name':'nested-main.conf','source':'service {\n include "child.conf"\n}','includes':{'child.conf':'# child\nvalue = ${missing}'}},
 {'id':'include-chain','name':'chain-main.conf','source':'include "middle.conf"','includes':{'middle.conf':'include "leaf.conf"','leaf.conf':'# leaf\nvalue = ${missing}'}},
 {'id':'fallback','name':'primary.conf','source':'ready=1','fallbacks':[{'name':'fallback.conf','source':'# lower\nvalue = ${missing}'}]},
 {'id':'optional-success','name':'optional.conf','source':'x=${?missing}\nready=1'},
 {'id':'override-success','name':'override.conf','source':'x=${missing}\nx=2'},
 {'id':'include-success','name':'main-ok.conf','source':'include "base.conf"\ny=${x}','includes':{'base.conf':'x=3'}},
 {'id':'fallback-overridden-success','name':'primary-ok.conf','source':'x=2','fallbacks':[{'name':'lower.conf','source':'x=${missing}'}]},
]
def sha(b):return hashlib.sha256(b).hexdigest()
requests=''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in CASES).encode('utf-8')
(HERE/'requests.jsonl').write_bytes(requests)
jar=pathlib.Path(r'D:/CodexLocal/ban/work/acceptance-20260928/hocon-config-1.4.9.jar')
java=pathlib.Path(r'C:/Program Files/Java/jdk-22/bin/java.exe')
assert sha(jar.read_bytes())=='47d13e3196c84f2a8ccd014ae563738c3da5b7406b38e03505ec0601a2f4fc37'
cmd=[str(java),'-Dfile.encoding=UTF-8','-cp',str(jar),str(HERE/'OriginReference.java')]
process=subprocess.run(cmd,input=requests,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=60,creationflags=subprocess.CREATE_NO_WINDOW)
(HERE/'reference.stdout.jsonl').write_bytes(process.stdout)
(HERE/'reference.stderr.bin').write_bytes(process.stderr)
results=[json.loads(s) for s in process.stdout.decode('utf-8').splitlines()]
receipt={'command':cmd,'exitCode':process.returncode,'requests':len(CASES),'results':len(results),'jarSHA256':sha(jar.read_bytes()),'javaSHA256':sha(java.read_bytes()),'adapterSHA256':sha((HERE/'OriginReference.java').read_bytes()),'requestsSHA256':sha(requests),'stdoutSHA256':sha(process.stdout),'stderrSHA256':sha(process.stderr),'unavailableReferenceFields':['offset','column'],'scope':'Actual unmodified Lightbend Config 1.4.9 class, origin description, line and success values. Memory include adapter supplies exact named source bytes; no fabricated expected fields.'}
(HERE/'REFERENCE-RECEIPT.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
assert process.returncode==0 and len(results)==len(CASES),receipt
for c,r in zip(CASES,results):
 assert r['id']==c['id']
 print(json.dumps({k:v for k,v in r.items() if k!='message'},ensure_ascii=False))
