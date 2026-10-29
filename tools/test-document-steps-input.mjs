import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';

const repo = fileURLToPath(new URL('../', import.meta.url));
const fixtureFile = path.join(repo, 'tools/document-steps-input/cases.json');
const spec = JSON.parse(fs.readFileSync(fixtureFile, 'utf8'));
const args = process.argv.slice(2);
assert(args.length === 0 || (args.length === 2 && args[0] === '--evidence-dir'), 'Use --evidence-dir PATH');
const base = path.resolve(args[1] ?? path.join(repo, 'output/document-steps-input'));
fs.mkdirSync(base, {recursive: true});
const root = fs.mkdtempSync(path.join(base, 'run-'));
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const env = {...process.env};
delete env.NODE_OPTIONS;
delete env.NODE_V8_COVERAGE;
env.NODE_DISABLE_COMPILE_CACHE = '1';
const observations = [];

function context(id, bytes = Buffer.from(spec.validSteps)) {
  const dir = path.join(root, id);
  fs.mkdirSync(dir);
  for (const [name, text] of Object.entries(spec.sourceFiles)) fs.writeFileSync(path.join(dir, name), text);
  const steps = path.join(dir, 'steps.json');
  fs.writeFileSync(steps, bytes);
  return {id, dir, steps};
}

function run(ctx, {mode = 'file', json = false, steps = ctx.steps, tag = 'result'} = {}) {
  const source = spec.sourceFiles['base.conf'];
  const input = mode === 'stdin' ? Buffer.from(source) : undefined;
  const argv = [path.join(repo, 'tools/cli.mjs'),
    ...(mode === 'file' ? ['--file', path.join(ctx.dir, 'main.conf')] :
      mode === 'input' ? ['--input', source] : []),
    '--document-steps', steps, ...(json ? ['--json'] : [])];
  const suppliedSteps = fs.existsSync(steps) ? fs.readFileSync(steps) : null;
  if (suppliedSteps !== null) fs.writeFileSync(path.join(ctx.dir, tag + '.steps.raw.json'), suppliedSteps);
  if (input !== undefined) fs.writeFileSync(path.join(ctx.dir, tag + '.stdin.raw.txt'), input);
  const sources = Object.fromEntries(Object.keys(spec.sourceFiles).map(name =>
    [name, hash(fs.readFileSync(path.join(ctx.dir, name)))]));
  const startedAtUTC = new Date().toISOString();
  const result = spawnSync(process.execPath, argv, {
    cwd: ctx.dir, env, input, timeout: 15000, windowsHide: true, maxBuffer: 4 * 1024 * 1024,
  });
  const stdout = result.stdout ?? Buffer.alloc(0), stderr = result.stderr ?? Buffer.alloc(0);
  // The caller receives and stores the original streams, including its real log sink.
  const log = path.join(ctx.dir, tag + '.diagnostic.log');
  fs.writeFileSync(log, stderr);
  fs.writeFileSync(path.join(ctx.dir, tag + '.stdout.txt'), stdout);
  assert(fs.readFileSync(log).equals(stderr));
  const receipt = {id: ctx.id, tag, mode, json, argv, startedAtUTC, completedAtUTC: new Date().toISOString(),
    exitCode: result.status, signal: result.signal, pid: result.pid,
    stepsBytes: suppliedSteps?.length ?? null, stepsSHA256: suppliedSteps === null ? null : hash(suppliedSteps),
    stdinSHA256: input === undefined ? null : hash(input), sourceSHA256: sources,
    stdoutBytes: stdout.length, stderrBytes: stderr.length,
    stdoutSHA256: hash(stdout), stderrSHA256: hash(stderr), callerLogByteEqual: true,
    ...(result.error === undefined ? {} : {error: result.error.message})};
  fs.writeFileSync(path.join(ctx.dir, tag + '.process.json'), JSON.stringify(receipt, null, 2) + '\n');
  observations.push(receipt);
  assert(!result.error, result.error?.message);
  assert.equal(result.signal, null);
  return {status: result.status, stdout, stderr};
}

function valid(result, json = false) {
  assert.equal(result.status, 0, result.stderr.toString());
  assert.equal(result.stderr.length, 0);
  const wire = JSON.parse(result.stdout.toString('utf8'));
  if (json) {
    assert.deepEqual(Object.keys(wire).sort(), ['ok', 'output']);
    assert.equal(wire.ok, true);
    assert.equal(typeof wire.output, 'string');
    assert.deepEqual(JSON.parse(wire.output), spec.expectedStates);
  } else assert.deepEqual(wire, spec.expectedStates);
  assert(result.stdout.includes(Buffer.from('R06_VALID_VALUE')), 'Requested valid values are not silently removed');
}

function syntaxFailure(result) {
  assert.equal(result.status, spec.expectedSyntaxFailure.exitCode);
  assert.equal(result.stdout.toString(), spec.expectedSyntaxFailure.stdout);
  assert.equal(result.stderr.toString(), spec.expectedSyntaxFailure.stderr);
}

let failure;
try {
  for (const c of spec.malformed) for (const json of [false, true]) {
    const ctx = context(c.id + (json ? '-json' : '-ordinary'), Buffer.from(c.text));
    const result = run(ctx, {json});
    syntaxFailure(result);
    assert(!result.stderr.includes(Buffer.from(c.canary)));
    assert(!fs.readFileSync(path.join(ctx.dir, 'result.diagnostic.log')).includes(Buffer.from(c.canary)));
  }
  for (const mode of ['file', 'input', 'stdin']) for (const json of [false, true]) {
    const ctx = context('valid-' + mode + (json ? '-json' : '-ordinary'));
    valid(run(ctx, {mode, json}), json);
  }
  const nonArray = context('non-array', Buffer.from(spec.controls.nonArray.text));
  const shape = run(nonArray);
  assert.equal(shape.status, 1);
  assert.equal(JSON.parse(shape.stderr).error, spec.controls.nonArray.error);
  assert.equal(shape.stdout.length, 0);
  const semantic = context('semantic-error', Buffer.from(spec.controls.semantic.text));
  const core = run(semantic);
  assert.equal(core.status, 2);
  assert.equal(core.stderr.length, 0);
  assert(core.stdout.toString().startsWith('ERROR:'));
  const encoding = context('invalid-utf8', Buffer.from(spec.controls.invalidUTF8.bytes));
  const decode = run(encoding);
  assert.equal(decode.status, 1);
  assert(JSON.parse(decode.stderr).error.toLowerCase().includes('utf-8'));
  const over = context('oversize', Buffer.alloc(spec.controls.oversize.bytes, 32));
  const size = run(over);
  assert.equal(size.status, 1);
  assert.equal(JSON.parse(size.stderr).error, spec.controls.oversize.error);
  const text = Buffer.from(spec.validSteps);
  const exact = context('exact-byte-limit', Buffer.concat([text, Buffer.alloc(400000 - text.length, 32)]));
  valid(run(exact));
  const missing = context('missing-steps-file');
  const io = run(missing, {steps: path.join(missing.dir, 'absent.json')});
  assert.equal(io.status, 1);
  assert(JSON.parse(io.stderr).error.includes('ENOENT'));

  // Real recovery: the same original files and same step filename are retried.
  const retry = context('caller-recovery', Buffer.from(spec.malformed[0].text));
  syntaxFailure(run(retry, {tag: 'failed'}));
  const before = Object.fromEntries(Object.keys(spec.sourceFiles).map(name =>
    [name, hash(fs.readFileSync(path.join(retry.dir, name)))]));
  fs.writeFileSync(retry.steps, spec.validSteps);
  const recovered = run(retry, {tag: 'recovered'});
  valid(recovered);
  fs.writeFileSync(path.join(retry.dir, 'received-states.json'), recovered.stdout);
  assert.deepEqual(JSON.parse(fs.readFileSync(path.join(retry.dir, 'received-states.json'))), spec.expectedStates);
  for (const [name, digest] of Object.entries(before)) assert.equal(hash(fs.readFileSync(path.join(retry.dir, name))), digest);
} catch (error) { failure = error; }
const identities = Object.fromEntries(['tools/cli.mjs', 'tools/test-document-steps-input.mjs',
  'tools/document-steps-input/cases.json', 'web/engine.mjs'].map(name =>
  [name, hash(fs.readFileSync(path.join(repo, name)))]));
const result = {utc: new Date().toISOString(), passed: failure === undefined, node: process.version,
  runHead: process.env.GITHUB_SHA ?? null, identities, observations, evidenceDirectory: root,
  boundary: 'Only document-step JSON syntax diagnostics exclude input excerpts. Valid output may intentionally contain values; other config errors, paths and caller logging are not generally redacted.',
  ...(failure === undefined ? {} : {failure: failure.stack})};
fs.writeFileSync(path.join(root, 'RESULT.json'), JSON.stringify(result, null, 2) + '\n');
console.log(JSON.stringify({passed: result.passed, observations: observations.length, evidenceDirectory: root}));
if (failure) throw failure;
