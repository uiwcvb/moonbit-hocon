"""Verify the 0.23 release fingerprint against staged Git blobs or working files."""
from pathlib import Path
import hashlib, json, subprocess, sys

root = Path(__file__).resolve().parents[1]
indexed = '--index' in sys.argv
def read(name):
    if indexed:
        return subprocess.check_output(['git', 'show', ':' + name], cwd=root)
    return (root / name).read_bytes().replace(b'\r\n', b'\n')

manifest = json.loads(read('evidence/double-direct-upgrade.json'))
count = 0
for group in ['sourceGitBlobSHA256', 'evidenceGitBlobSHA256']:
    for name, digest in manifest[group].items():
        assert hashlib.sha256(read(name)).hexdigest() == digest, name
        count += 1
print(f'{count} release source/evidence blobs verified')
