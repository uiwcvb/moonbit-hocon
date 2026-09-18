"""Regenerate independent tests, formatting, API and engine; require byte stability."""
from pathlib import Path
import hashlib, json, os, shutil, subprocess, sys

root = Path(__file__).resolve().parents[1]
moon = Path(sys.argv[1]).resolve()
env = dict(os.environ, MOON_HOME=str(moon.parent.parent))
env['PATH'] = str(moon.parent) + os.pathsep + env['PATH']

def snapshot():
    paths = [p for p in root.rglob('*') if p.is_file()
             and not any(part in {'.git', '_build', '.mooncakes', 'target'} for part in p.relative_to(root).parts)
             and p.suffix in {'.mbt', '.mbti', '.mjs', '.java', '.mod', '.pkg', '.py'}]
    return {p.relative_to(root).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(paths)}

before = snapshot()
for command in [['node', 'tools/generate-collection-tests.mjs'], ['node', 'tools/generate-http-json-tests.mjs'], ['node', 'tools/generate-path-characters.mjs'], ['node', 'tools/generate-tree-tests.mjs'], ['node', 'tools/generate-document-tests.mjs'], ['node', 'tools/generate-numeric-characters.mjs'], ['node', 'tools/generate-accessor-tests.mjs'], ['node', 'tools/generate-temporal-tests.mjs'], [str(moon), 'fmt'],
                [str(moon), 'info'], [str(moon), 'build', '--target', 'js', '--deny-warn']]:
    subprocess.run(command, cwd=root, env=env, check=True)
shutil.copyfile(root / '_build/js/debug/build/cmd/web/web.js', root / 'web/engine.mjs')
after = snapshot()
assert before == after, [p for p in before.keys() | after.keys() if before.get(p) != after.get(p)]
report = dict(passed=True, files=len(after), checks=['independent collection, HTTP JSON, JDK path, tree, document and extended accessor and temporal API test generation', 'format', 'API generation', 'JS build and engine copy'], sha256=after)
(root / 'evidence/temporal-generation.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
print(f'{len(after)} generated/source files unchanged')
