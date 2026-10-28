import assert from 'node:assert/strict';
import { createHash, randomUUID } from 'node:crypto';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import cases from './transition-consumer/cases.mjs';

const repo = fileURLToPath(new URL('../', import.meta.url));
const output = path.join(repo, 'output/package-consumer');
const cache = path.resolve(process.env.HOCON_PACKAGE_CACHE || path.join(output, 'workspaces'));
fs.mkdirSync(output, { recursive: true });
fs.mkdirSync(cache, { recursive: true });
const work = fs.mkdtempSync(path.join(cache, 'package-'));
const python = process.env.HOCON_PACKAGE_PYTHON || (process.platform === 'win32' ? 'python' : 'python3');
const inspector = path.join(repo, 'tools/package-consumer/inspect_archive.py');
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const writeJSON = (name, value) => fs.writeFileSync(path.join(output, name), JSON.stringify(value, null, 2) + '\n');
const manifest = { success: false, workspace: work, commands: [], negativeControls: [] };

function command(label, executable, args, expectedStatus = 0, options = {}) {
  const result = spawnSync(executable, args, {
    cwd: repo, encoding: 'utf8', timeout: 180_000, maxBuffer: 16 * 1024 * 1024, ...options,
  });
  fs.writeFileSync(path.join(output, `${label}.stdout.txt`), result.stdout || '');
  fs.writeFileSync(path.join(output, `${label}.stderr.txt`), result.stderr || '');
  manifest.commands.push({ label, executable: path.basename(executable), args, status: result.status, error: result.error?.message || null });
  assert.equal(result.status, expectedStatus, `${label}: ${result.error || result.stderr || result.stdout}`);
  return result.stdout;
}

const gitEnv = { ...process.env };
for (const key of Object.keys(gitEnv)) if (/^(GIT_|GH_|GITHUB_)/i.test(key)) delete gitEnv[key];
gitEnv.GIT_CONFIG_NOSYSTEM = '1';
gitEnv.GIT_CONFIG_GLOBAL = process.platform === 'win32' ? 'NUL' : os.devNull;
const tracked = command('tracked-inputs', 'git', ['-c', 'core.quotepath=false', 'ls-files', '-z'], 0, { env: gitEnv }).split('\0').filter(Boolean);
// These were already omitted by the package policy before this gate was added.
const exempt = new Set(['.gitattributes', '.gitignore', 'evidence/benchmark.json', 'evidence/robustness.json']);
const required = new Set(tracked.filter(name => !exempt.has(name) && !name.startsWith('.github/')));
for (const name of ['tools/test-package-consumer.mjs', 'tools/package-consumer/inspect_archive.py', 'tools/package-consumer/README.md']) required.add(name);
const contract = {
  module: 'uiwcvb/hocon', version: '0.25.0',
  members: Object.fromEntries([...required].sort().map(name => [name, hash(fs.readFileSync(path.join(repo, name)))])),
  exemptMetadataAndGeneratedScores: tracked.filter(name => !required.has(name)),
};
const expectedFile = path.join(output, 'expected-members.json');
writeJSON('expected-members.json', contract);
const originalOracle = Buffer.from(JSON.stringify(cases, null, 2) + '\n');
writeJSON('expected-consumer.json', cases);
manifest.sourceExpectations = { requiredMembers: required.size, rawWorkingInputSHA256: contract.members };
const created = [];

try {
  // Reproduce a populated developer/CI checkout without touching any existing file.
  for (const prefix of ['tools/browser/node_modules', 'output/playwright', 'output/transition-consumer', 'output/package-consumer']) {
    const directory = path.join(repo, prefix);
    fs.mkdirSync(directory, { recursive: true });
    const relative = path.relative(fs.realpathSync(repo), fs.realpathSync(directory));
    assert(!relative.startsWith('..') && !path.isAbsolute(relative), 'Cache probe must remain inside this checkout');
    const marker = path.join(directory, `package-cache-canary-${randomUUID()}.txt`);
    fs.writeFileSync(marker, 'GENERATED-CACHE-NOT-DISTRIBUTION\n', { flag: 'wx' });
    created.push(marker);
  }
  const packageTarget = path.join(work, 'build');
  command('moon-package', 'moon', ['package', '--target-dir', packageTarget]);
  const archive = path.join(packageTarget, 'publish/uiwcvb-hocon-0.25.0.zip');
  assert(fs.statSync(archive).isFile());
  const extraction = path.join(work, 'extracted');
  const inspectArgs = ['-I', '-B', '-X', 'utf8', inspector, '--archive', archive, '--expect', expectedFile];
  const readback = JSON.parse(command('readback', python, [...inspectArgs, '--extract', extraction]));
  assert.equal(readback.accepted, true);
  assert.equal(readback.requiredMemberCount, required.size);
  assert.equal(readback.archiveSHA256, hash(fs.readFileSync(archive)));
  manifest.archive = { path: archive, sha256: readback.archiveSHA256, bytes: fs.statSync(archive).size, members: readback.memberCount };
  manifest.readback = readback;

  const variants = JSON.parse(command('negative-copies', python, [...inspectArgs, '--negative-copies', path.join(work, 'negative')]));
  const rejectedReasons = {
    'missing-notice': 'missing-attribution', 'changed-source': 'source-byte-mismatch',
    'unsafe-path': 'unsafe-member', 'live-control': 'forbidden-member', 'credential-value': 'credential-pattern',
  };
  for (const [label, reason] of Object.entries(rejectedReasons)) {
    const rejection = JSON.parse(command(label, python,
      ['-I', '-B', '-X', 'utf8', inspector, '--archive', variants[label], '--expect', expectedFile], 1));
    assert.equal(rejection.accepted, false);
    assert.equal(rejection.reason, reason, label);
    manifest.negativeControls.push({ label, expectedReason: reason, observed: rejection });
  }

  // Execute only the source, driver and oracle read back from the verified archive.
  command('archived-consumer', process.execPath,
    [path.join(extraction, 'tools/test-transition-consumer.mjs')], 0, {
      cwd: extraction,
      env: { ...process.env, HOCON_CONSUMER_CACHE: path.join(work, 'consumer-builds') },
    });
  const consumerOutput = path.join(extraction, 'output/transition-consumer');
  assert.deepEqual(fs.readFileSync(path.join(consumerOutput, 'expected.json')), originalOracle);
  const consumer = JSON.parse(fs.readFileSync(path.join(consumerOutput, 'manifest.json'), 'utf8'));
  assert.equal(consumer.success, true);
  assert.deepEqual(consumer.targets.map(t => t.target), ['js', 'wasm-gc']);
  for (const target of consumer.targets) {
    assert.equal(target.results.length, cases.length);
    assert(target.results.every(result => result.passed));
    assert.equal(target.freshProductCaches, true);
  }
  fs.cpSync(consumerOutput, path.join(output, 'archived-consumer'), { recursive: true });
  const artifactName = `uiwcvb-hocon-0.25.0-${readback.archiveSHA256.slice(0, 12)}.zip`;
  fs.copyFileSync(archive, path.join(output, artifactName));
  assert.equal(hash(fs.readFileSync(path.join(output, artifactName))), readback.archiveSHA256);
  manifest.consumer = { distinctRequests: cases.length, observations: cases.length * consumer.targets.length, compiler: consumer.compiler, targets: consumer.targets };
  manifest.distributionCopy = artifactName;
  manifest.success = true;
  console.log(`package: ${readback.memberCount} members read back with exact source/attribution identity; 5 damaged archives rejected`);
  console.log(`archive consumers: ${cases.length} independent requests on each of JS/Wasm-GC passed`);
} finally {
  for (const marker of created) if (fs.existsSync(marker)) fs.unlinkSync(marker);
  writeJSON('manifest.json', manifest);
}
