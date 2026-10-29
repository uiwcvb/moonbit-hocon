import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';

const repo = fileURLToPath(new URL('../', import.meta.url));
const output = path.join(repo, 'output/typescript-consumer');
fs.mkdirSync(output, {recursive: true});
const work = fs.mkdtempSync(path.join(output, 'consumer-'));
const deps = path.resolve(process.env.HOCON_TYPESCRIPT_DEPS || path.join(repo, 'tools/typescript-consumer/node_modules'));
const fixtures = path.join(repo, 'tools/typescript-consumer/fixtures');
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const manifest = {passed: false, work, compilerVersion: '5.9.3', commands: [], sourceFiles: [], outputs: []};
const writeJSON = (name, value) => fs.writeFileSync(path.join(work, name), JSON.stringify(value, null, 2) + '\n');
const lf = text => text.replace(/\r\n/g, '\n');

function run(name, args, expectedExitCode) {
  const startedAtUTC = new Date().toISOString();
  const result = spawnSync(process.execPath, args, {cwd: work, timeout: 60_000, windowsHide: true, maxBuffer: 4 * 1024 * 1024});
  const stdout = result.stdout || Buffer.alloc(0), stderr = result.stderr || Buffer.alloc(0);
  fs.writeFileSync(path.join(work, name + '.stdout.raw'), stdout);
  fs.writeFileSync(path.join(work, name + '.stderr.raw'), stderr);
  const receipt = {name, executable: process.execPath, argv: args, cwd: work, pid: result.pid,
    startedAtUTC, completedAtUTC: new Date().toISOString(), exitCode: result.status, signal: result.signal,
    error: result.error?.message || null, stdout: {bytes: stdout.length, sha256: hash(stdout)}, stderr: {bytes: stderr.length, sha256: hash(stderr)}};
  writeJSON(name + '.process.json', receipt);
  manifest.commands.push(receipt);
  assert.equal(result.error, undefined, name + ': process launch/timeout');
  assert.equal(result.signal, null, name + ': unexpected signal');
  assert.equal(result.status, expectedExitCode, name + ': ' + stdout + stderr);
  assert.equal(stderr.length, 0, name + ': unexpected stderr');
  return stdout.toString('utf8');
}

try {
  assert.equal(JSON.parse(fs.readFileSync(path.join(deps, 'typescript/package.json'))).version, '5.9.3');
  assert.equal(JSON.parse(fs.readFileSync(path.join(deps, '@types/node/package.json'))).version, '24.0.0');
  for (const name of fs.readdirSync(fixtures)) fs.copyFileSync(path.join(fixtures, name), path.join(work, name));
  for (const name of ['tools/config.mjs', 'tools/config.d.mts', 'tools/config-object.mjs', 'tools/config-error.mjs',
    'tools/config-host.mjs', 'tools/config-async.mjs', 'tools/config-async-worker.mjs', 'tools/http-client.mjs', 'tools/http-worker.mjs', 'web/engine.mjs']) {
    const bytes = fs.readFileSync(path.join(repo, name)), target = path.join(work, 'product', name);
    fs.mkdirSync(path.dirname(target), {recursive: true}); fs.writeFileSync(target, bytes);
    manifest.sourceFiles.push({path: name, bytes: bytes.length, sha256: hash(bytes)});
  }
  const tsc = path.join(deps, 'typescript/bin/tsc');
  const compile = ['--typeRoots', path.join(deps, '@types'), '--pretty', 'false'];
  assert(!fs.existsSync(path.join(work, 'consumer.mjs')));
  assert.equal(run('compile-consumer', [tsc, '--project', 'tsconfig.json', ...compile], 0), '');
  assert(fs.existsSync(path.join(work, 'consumer.mjs')), 'actual compiler must emit the runtime consumer');
  const success = fs.readFileSync(path.join(work, 'expected-success.stdout'), 'utf8');
  for (const mode of ['sync', 'async']) {
    assert.equal(run('settings-' + mode, [path.join(work, 'consumer.mjs'), path.join(work, 'settings.conf'), mode], 0), success);
    const input = fs.realpathSync(path.join(work, 'broken.conf'));
    const error = fs.readFileSync(path.join(work, 'expected-error.stdout'), 'utf8').replace('<INPUT>', JSON.stringify(input).slice(1, -1));
    assert.equal(run('broken-' + mode, [path.join(work, 'consumer.mjs'), input, mode], 2), error);
  }
  const negative = JSON.parse(fs.readFileSync(path.join(work, 'tsconfig.json'), 'utf8'));
  negative.files = ['negative.mts']; writeJSON('tsconfig-negative.json', negative);
  const diagnostics = run('compile-negative', [tsc, '--project', 'tsconfig-negative.json', ...compile], 1);
  assert.equal(lf(diagnostics), lf(fs.readFileSync(path.join(work, 'expected-negative.stdout'), 'utf8')));
  assert(!fs.existsSync(path.join(work, 'negative.mjs')), 'misuses must not emit JavaScript');
  const formats = JSON.parse(fs.readFileSync(path.join(work, 'tsconfig.json'), 'utf8'));
  formats.files = ['format-consumer.mts']; writeJSON('tsconfig-formats.json', formats);
  assert.equal(run('compile-formats', [tsc, '--project', 'tsconfig-formats.json', ...compile], 0), '');
  assert(fs.existsSync(path.join(work, 'format-consumer.mjs')), 'format consumer must be emitted by the real compiler');
  const formatResult = run('formats-runtime', [path.join(work, 'format-consumer.mjs'), path.join(work, 'properties.input')], 0);
  assert.equal(formatResult, fs.readFileSync(path.join(work, 'expected-format.stdout'), 'utf8'));
  formats.files = ['format-negative.mts']; writeJSON('tsconfig-formats-negative.json', formats);
  const formatDiagnostics = run('compile-formats-negative', [tsc, '--project', 'tsconfig-formats-negative.json', ...compile], 1);
  assert.equal(lf(formatDiagnostics), lf(fs.readFileSync(path.join(work, 'expected-format-negative.stdout'), 'utf8')));
  assert(!fs.existsSync(path.join(work, 'format-negative.mjs')), 'invalid formats/fallbacks must not emit JavaScript');
  manifest.formatRuntimeResults = 31;
  manifest.formatRejectedMisuses = 9;
  for (const name of ['consumer.mts', 'consumer.mjs', 'negative.mts', 'tsconfig.json', 'tsconfig-negative.json', 'settings.conf', 'broken.conf',
    'expected-success.stdout', 'expected-error.stdout', 'expected-negative.stdout',
    'format-consumer.mts', 'format-consumer.mjs', 'format-negative.mts', 'tsconfig-formats.json', 'tsconfig-formats-negative.json',
    'properties.input', 'expected-format.stdout', 'expected-format-negative.stdout']) {
    const bytes = fs.readFileSync(path.join(work, name)); manifest.outputs.push({path: name, bytes: bytes.length, sha256: hash(bytes)});
  }
  manifest.passed = true;
  console.log('Strict TypeScript consumer: 4 original outputs/4 rejections, 31 format results/9 rejections passed');
} finally {
  writeJSON('RESULT.json', manifest);
  fs.writeFileSync(path.join(output, 'latest.json'), JSON.stringify({work, passed: manifest.passed}, null, 2) + '\n');
}
