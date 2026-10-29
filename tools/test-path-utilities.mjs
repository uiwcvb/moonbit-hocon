import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';

const repo = fileURLToPath(new URL('../', import.meta.url));
const output = path.join(repo, 'output/path-utilities');
fs.mkdirSync(output, {recursive: true});
const work = fs.mkdtempSync(path.join(output, 'consumer-'));
const deps = path.resolve(process.env.HOCON_TYPESCRIPT_DEPS || path.join(repo, 'tools/typescript-consumer/node_modules'));
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const manifest = {passed: false, work, commands: [], sourceFiles: [], outputs: []};
const writeJSON = (name, value) => fs.writeFileSync(path.join(work, name), JSON.stringify(value, null, 2) + '\n');
function run(name, args, expectedExitCode) {
  const startedAtUTC = new Date().toISOString();
  const result = spawnSync(process.execPath, args, {cwd: work, timeout: 60_000, windowsHide: true, maxBuffer: 4 * 1024 * 1024});
  const stdout = result.stdout || Buffer.alloc(0), stderr = result.stderr || Buffer.alloc(0);
  fs.writeFileSync(path.join(work, name + '.stdout.raw'), stdout);
  fs.writeFileSync(path.join(work, name + '.stderr.raw'), stderr);
  const receipt = {name, executable: process.execPath, argv: args, cwd: work, pid: result.pid, startedAtUTC,
    completedAtUTC: new Date().toISOString(), exitCode: result.status, signal: result.signal, error: result.error?.message || null,
    stdout: {bytes: stdout.length, sha256: hash(stdout)}, stderr: {bytes: stderr.length, sha256: hash(stderr)}};
  manifest.commands.push(receipt); writeJSON(name + '.process.json', receipt);
  assert.equal(result.error, undefined, name + ': process launch/timeout');
  assert.equal(result.signal, null, name + ': unexpected signal');
  assert.equal(result.status, expectedExitCode, name + ': ' + stdout + stderr);
  assert.equal(stderr.length, 0, name + ': unexpected stderr');
  return stdout.toString('utf8');
}
try {
  assert.equal(JSON.parse(fs.readFileSync(path.join(deps, 'typescript/package.json'))).version, '5.9.3');
  assert.equal(JSON.parse(fs.readFileSync(path.join(deps, '@types/node/package.json'))).version, '24.0.0');
  const fixtures = path.join(repo, 'tools/path-utilities');
  for (const name of fs.readdirSync(fixtures)) fs.copyFileSync(path.join(fixtures, name), path.join(work, name));
  for (const name of ['tools/config.mjs', 'tools/config.d.mts', 'tools/config-object.mjs', 'tools/config-error.mjs',
    'tools/config-host.mjs', 'tools/config-async.mjs', 'tools/config-async-worker.mjs', 'tools/http-client.mjs', 'tools/http-worker.mjs', 'web/engine.mjs']) {
    const bytes = fs.readFileSync(path.join(repo, name)), target = path.join(work, 'product', name);
    fs.mkdirSync(path.dirname(target), {recursive: true}); fs.writeFileSync(target, bytes);
    manifest.sourceFiles.push({path: name, bytes: bytes.length, sha256: hash(bytes)});
  }
  const tsc = path.join(deps, 'typescript/bin/tsc'), compile = ['--typeRoots', path.join(deps, '@types'), '--pretty', 'false'];
  assert.equal(run('compile-consumer', [tsc, '--project', 'tsconfig.json', ...compile], 0), '');
  assert(fs.existsSync(path.join(work, 'consumer.mjs')) && fs.existsSync(path.join(work, 'cases.mjs')));
  assert.equal(run('review-consumer', [path.join(work, 'consumer.mjs'), path.join(work, 'before.json'), path.join(work, 'after.json')], 0),
    fs.readFileSync(path.join(work, 'expected.stdout'), 'utf8'));
  assert.equal(run('invalid-js', [path.join(work, 'invalid-js.mjs')], 0), fs.readFileSync(path.join(work, 'expected-invalid-js.stdout'), 'utf8'));
  const negative = JSON.parse(fs.readFileSync(path.join(work, 'tsconfig.json'), 'utf8'));
  negative.files = ['negative.mts']; writeJSON('tsconfig-negative.json', negative);
  const diagnostics = run('compile-negative', [tsc, '--project', 'tsconfig-negative.json', ...compile], 1);
  assert.equal(diagnostics.replace(/\r\n/g, '\n'), fs.readFileSync(path.join(work, 'expected-negative.stdout'), 'utf8'));
  assert(!fs.existsSync(path.join(work, 'negative.mjs')));
  for (const name of fs.readdirSync(work)) if (fs.statSync(path.join(work, name)).isFile() && name !== 'RESULT.json') {
    const bytes = fs.readFileSync(path.join(work, name)); manifest.outputs.push({path: name, bytes: bytes.length, sha256: hash(bytes)});
  }
  manifest.passed = true;
  console.log('Public path utilities: 6 canonical cases, real reviewed config/getters, 5 core errors, 3 JS errors and 2 type rejections passed');
} finally {
  writeJSON('RESULT.json', manifest);
  fs.writeFileSync(path.join(output, 'latest.json'), JSON.stringify({work, passed: manifest.passed}, null, 2) + '\n');
}
