"""Read every package member, verify the pre-package contract, then extract."""
import argparse
import copy
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import stat
import zipfile

ATTRIBUTION = [
    'LICENSE', 'THIRD_PARTY_NOTICES.md',
    'licenses/MoonBit-core-LICENSE.txt', 'licenses/MoonBit-core-NOTICE.txt',
    'examples/openwhisk/SOURCE.json',
    'examples/openwhisk/OPENWHISK-LICENSE.txt', 'examples/openwhisk/OPENWHISK-NOTICE.txt',
    'examples/openwhisk/PEKKO-LICENSE.txt', 'examples/openwhisk/PEKKO-NOTICE.txt',
]
CACHE_PREFIXES = [
    'tools/browser/node_modules/', 'output/playwright/',
    'output/transition-consumer/', 'output/package-consumer/',
]
CONTROL_FILES = {
    'PROJECT.json', 'STATE.json', 'GOAL.md', 'READY.json',
    'auth_helper.py', 'credential.bin', '.npmrc', '.netrc', '_netrc',
}
PUBLIC_KEY_PATH = 'tools/fixtures/http-key.pem'
PUBLIC_KEY_SHA256 = 'd536405308c7ab59eebb526c68334de5037bcf3dc64926b049b7119c7a1d000c'
PRIVATE_KEY = re.compile(rb'-----BEGIN (?:RSA |EC |OPENSSH |ENCRYPTED )?PRIVATE KEY-----')
CREDENTIAL = re.compile(rb'github_pat_[A-Za-z0-9_]{20,}|gh[pousr]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}')


class Rejected(Exception):
    def __init__(self, reason, member=None):
        self.reason, self.member = reason, member


def inspect(archive, contract, destination):
    observed = {}
    with zipfile.ZipFile(archive) as package:
        entries = package.infolist()
        seen = set()
        for entry in entries:
            name = entry.filename
            parts = PurePosixPath(name).parts
            if (not parts or '\\' in name or name.startswith('/') or ':' in parts[0]
                    or name.rstrip('/') != PurePosixPath(name).as_posix()
                    or any(p in {'.', '..'} for p in parts)
                    or stat.S_ISLNK(entry.external_attr >> 16)):
                raise Rejected('unsafe-member', name)
            if name in seen:
                raise Rejected('duplicate-member', name)
            seen.add(name)
            if (any(name.startswith(p) for p in CACHE_PREFIXES)
                    or any(p in {'_build', 'target', '.mooncakes', '__pycache__', '.git', '.codex'} for p in parts)
                    or name in CONTROL_FILES):
                raise Rejected('forbidden-member', name)
            if entry.is_dir():
                continue
            data = package.read(entry)  # zipfile verifies CRC while reading.
            if CREDENTIAL.search(data):
                raise Rejected('credential-pattern', name)
            if PRIVATE_KEY.search(data):
                canonical = hashlib.sha256(data.replace(b'\r\n', b'\n')).hexdigest()
                if name != PUBLIC_KEY_PATH or canonical != PUBLIC_KEY_SHA256:
                    raise Rejected('private-key', name)
            observed[name] = hashlib.sha256(data).hexdigest()

        for name in ATTRIBUTION:
            if name not in observed:
                raise Rejected('missing-attribution', name)
        for name, digest in contract['members'].items():
            if name not in observed:
                raise Rejected('missing-required-member', name)
            if observed[name] != digest:
                raise Rejected('source-byte-mismatch', name)
        module = package.read('moon.mod').decode('utf-8-sig')
        for field, value in [('name', 'uiwcvb/hocon'), ('version', '0.25.0'), ('license', 'MIT')]:
            if not re.search(r'^\s*' + field + r'\s*=\s*' + re.escape(json.dumps(value)) + r'\s*$', module, re.M):
                raise Rejected('module-identity-mismatch', 'moon.mod')

        if destination is not None:
            destination = Path(destination)
            if destination.exists() and any(destination.iterdir()):
                raise Rejected('nonempty-extraction-destination')
            destination.mkdir(parents=True, exist_ok=True)
            root = destination.resolve()
            for entry in entries:
                target = (destination / entry.filename).resolve()
                if not target.is_relative_to(root):
                    raise Rejected('unsafe-member', entry.filename)
                if entry.is_dir():
                    target.mkdir(parents=True, exist_ok=True)
                else:
                    target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(package.read(entry))
    return {
        'accepted': True, 'archiveSHA256': hashlib.sha256(Path(archive).read_bytes()).hexdigest(),
        'memberCount': len(observed), 'memberSHA256': observed,
        'requiredMemberCount': len(contract['members']), 'attributionFiles': ATTRIBUTION,
        'publicLocalhostTestKey': {'path': PUBLIC_KEY_PATH, 'canonicalSHA256': PUBLIC_KEY_SHA256},
        'extractedTo': str(destination) if destination is not None else None,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--archive', required=True)
    parser.add_argument('--expect', required=True)
    parser.add_argument('--extract')
    parser.add_argument('--negative-copies')
    args = parser.parse_args()
    if args.negative_copies:
        folder = Path(args.negative_copies)
        folder.mkdir(parents=True, exist_ok=True)
        mutations = {
            'missing-notice': ('licenses/MoonBit-core-NOTICE.txt', None),
            'changed-source': ('config_transition.mbt', b'// modified package source\n'),
            'unsafe-path': ('../outside.txt', b'not extracted'),
            'live-control': ('credential.bin', b'TEST-ONLY-NOT-A-CREDENTIAL'),
            'credential-value': ('unexpected.txt', b'ghp_' + b'A' * 40),
        }
        paths = {}
        with zipfile.ZipFile(args.archive) as original:
            for label, (member, replacement) in mutations.items():
                target = folder / (label + '.zip')
                with zipfile.ZipFile(target, 'w', zipfile.ZIP_DEFLATED) as mutated:
                    for entry in original.infolist():
                        if entry.filename != member:
                            mutated.writestr(copy.copy(entry), original.read(entry))
                    if replacement is not None:
                        mutated.writestr(member, replacement)
                paths[label] = str(target)
        print(json.dumps(paths))
        return 0
    try:
        contract = json.loads(Path(args.expect).read_text(encoding='utf-8'))
        print(json.dumps(inspect(args.archive, contract, args.extract), ensure_ascii=False))
        return 0
    except Rejected as failure:
        print(json.dumps({'accepted': False, 'reason': failure.reason, 'member': failure.member}))
        return 1
    except (zipfile.BadZipFile, OSError, ValueError) as failure:
        print(json.dumps({'accepted': False, 'reason': type(failure).__name__}))
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
