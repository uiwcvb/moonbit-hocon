import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {spawn, spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {fileURLToPath} from 'node:url';
import {exportTypedConfigFile, ConfigExportError} from './typed-config-export.mjs';

const repo = fileURLToPath(new URL('../', import.meta.url));
const cli = path.join(repo, 'tools/typed-config-export.mjs');
const receiver = path.join(repo, 'examples/config-file-receiver.mjs');
const fixtureFile = path.join(repo, 'tools/typed-config-export/cases.json');
const fixture = JSON.parse(fs.readFileSync(fixtureFile, 'utf8'));
const compatibility = JSON.parse(fs.readFileSync(new URL('./typed-config-export/compatibility.json', import.meta.url), 'utf8'));
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const args = process.argv.slice(2);
assert(args.length === 0 || (args.length === 2 && args[0] === '--evidence-dir'), 'Use --evidence-dir PATH');
const base = path.resolve(args[1] ?? path.join(repo, 'output/typed-config-export'));
fs.mkdirSync(base, {recursive: true});
const root = fs.mkdtempSync(path.join(base, 'run-'));
const env = {...process.env};
delete env.NODE_OPTIONS;
delete env.NODE_V8_COVERAGE;
env.NODE_DISABLE_COMPILE_CACHE = '1';
const observations = [];
let startedReceivers = 0;

function context(id, spec = fixture.positives[0], query = fixture.query) {
  const dir = path.join(root, id);
  fs.mkdirSync(dir, {recursive: true});
  const files = {};
  for (const [name, source] of Object.entries(spec.files)) {
    const target = path.join(dir, name);
    fs.mkdirSync(path.dirname(target), {recursive: true});
    fs.writeFileSync(target, source);
    files[name] = target;
  }
  const queries = path.join(dir, 'fields.json');
  fs.writeFileSync(queries, JSON.stringify(query, null, 2) + '\n');
  return {id, dir, files, options: {file: files[spec.file], queries,
    output: path.join(dir, 'app-settings.json'), ...(spec.format === undefined ? {} : {format: spec.format}),
    fallbackFiles: (spec.fallbackFiles ?? []).map(name => files[name])}};
}

function invoke(ctx, customArgs, childEnv = env) {
  const o = ctx.options;
  const argv = customArgs ?? ['--file', o.file, '--queries', o.queries, '--output', o.output,
    ...(o.format === undefined ? [] : ['--format', o.format]),
    ...o.fallbackFiles.flatMap(file => ['--fallback', file])];
  const result = spawnSync(process.execPath, [cli, ...argv], {
    cwd: ctx.dir, env: childEnv, encoding: 'utf8', timeout: 20000, windowsHide: true, maxBuffer: 4 * 1024 * 1024,
  });
  fs.writeFileSync(path.join(ctx.dir, 'stdout.txt'), result.stdout ?? '');
  fs.writeFileSync(path.join(ctx.dir, 'stderr.txt'), result.stderr ?? '');
  const record = {id: ctx.id, argv, status: result.status, signal: result.signal,
    ...(result.error === undefined ? {} : {error: result.error.message})};
  observations.push(record);
  fs.writeFileSync(path.join(ctx.dir, 'process.json'), JSON.stringify(record, null, 2) + '\n');
  assert(!result.error, result.error?.message);
  return result;
}

function delivered(ctx, expected) {
  const bytes = fs.readFileSync(ctx.options.output);
  assert(bytes.at(-1) === 10, 'Artifact ends with a JSON newline');
  const value = JSON.parse(bytes.toString('utf8'));
  assert.deepEqual(value, expected);
  assert.deepEqual(Object.keys(value).sort(), Object.keys(expected).sort());
  return bytes;
}

async function receive(ctx) {
  const dir = path.join(ctx.dir, 'receiver-only');
  fs.mkdirSync(dir);
  const input = path.join(dir, 'app-settings.json');
  fs.copyFileSync(ctx.options.output, input);
  const child = spawn(process.execPath, [receiver, input], {
    cwd: dir, env, stdio: ['ignore', 'pipe', 'pipe'], windowsHide: true,
  });
  startedReceivers++;
  let stdout = '', stderr = '', timer;
  child.stdout.setEncoding('utf8');
  child.stderr.setEncoding('utf8');
  child.stderr.on('data', text => { stderr += text; });
  const closed = once(child, 'close');
  try {
    const ready = await new Promise((resolve, reject) => {
      timer = setTimeout(() => reject(new Error('Receiver readiness timeout')), 10000);
      child.once('error', reject);
      child.once('exit', code => reject(new Error('Receiver exited before readiness: ' + code + ' ' + stderr)));
      child.stdout.on('data', text => {
        stdout += text;
        if (stdout.includes('\n')) {
          try { resolve(JSON.parse(stdout.split('\n')[0])); } catch (error) { reject(error); }
        }
      });
    });
    clearTimeout(timer);
    assert.equal(ready.ready, true);
    assert(/^http:\/\/127\.0\.0\.1:\d+\/$/.test(ready.url));
    const response = await fetch(ready.url, {signal: AbortSignal.timeout(10000)});
    const body = await response.text();
    fs.writeFileSync(path.join(dir, 'http-body.txt'), body);
    assert.equal(response.status, 200);
    assert.deepEqual(JSON.parse(body), fixture.receiver.expectedHTTP);
    assert.deepEqual(Object.keys(JSON.parse(body)).sort(), Object.keys(fixture.receiver.expectedHTTP).sort());
    observations.push({id: ctx.id + '/http-receiver', receiverStarted: true, ready,
      responseStatus: response.status, responseBodySHA256: hash(Buffer.from(body))});
  } finally {
    clearTimeout(timer);
    if (child.exitCode === null) child.kill();
    await closed;
    fs.writeFileSync(path.join(dir, 'stdout.txt'), stdout);
    fs.writeFileSync(path.join(dir, 'stderr.txt'), stderr);
  }
}

// The caller's real handoff branches on the export process result before spawning.
async function handoff(ctx) {
  const result = invoke(ctx);
  if (result.status !== 0) return {status: result.status, receiverStarted: false};
  await receive(ctx);
  return {status: result.status, receiverStarted: true};
}

function unchangedFailure(id, setup, expectedCode) {
  for (const exists of [false, true]) {
    const ctx = context(id + (exists ? '-existing' : '-absent'));
    setup(ctx);
    if (exists) fs.writeFileSync(ctx.options.output, fixture.delivery.sentinelUTF8);
    const result = invoke(ctx);
    assert.equal(result.status, expectedCode, result.stderr);
    if (exists) assert.equal(fs.readFileSync(ctx.options.output, 'utf8'), fixture.delivery.sentinelUTF8);
    else assert(!fs.existsSync(ctx.options.output));
  }
}

let failure;
try {
  for (const spec of fixture.positives) {
    const ctx = context('cli-' + spec.id, spec);
    const result = invoke(ctx);
    assert.equal(result.status, spec.exitCode, result.stderr);
    delivered(ctx, spec.expected);
    const receipt = JSON.parse(result.stdout);
    assert.equal(receipt.ok, true);
    assert.equal(receipt.bytes, fs.statSync(ctx.options.output).size);
  }
  const api = context('public-api');
  const receipt = exportTypedConfigFile(api.options);
  delivered(api, fixture.positives[0].expected);
  assert.equal(receipt.fields, 4);
  observations.push({id: api.id, publicAPI: true, receipt});
  const literal = context('literal-output-names', fixture.positives[0], fixture.literalNames.query);
  assert.equal(invoke(literal).status, 0);
  const literalBytes = delivered(literal, fixture.literalNames.expected);
  assert(Object.hasOwn(JSON.parse(literalBytes), '__proto__'));
  const limit = context('field-limit-64', fixture.positives[0], {version: 1,
    fields: Array.from({length: 64}, (_, i) => ({name: 'f' + i, path: 'service.label', type: 'string'}))});
  assert.equal(invoke(limit).status, 0);
  delivered(limit, Object.fromEntries(Array.from({length: 64}, (_, i) => ['f' + i, fixture.limits.field64ExpectedValue])));
  const exact = context('query-byte-limit-exact');
  const text = fs.readFileSync(exact.options.queries);
  fs.writeFileSync(exact.options.queries, Buffer.concat([text, Buffer.alloc(400000 - text.length, 32)]));
  assert.equal(invoke(exact).status, 0);
  delivered(exact, fixture.positives[0].expected);

  for (const spec of fixture.errors) {
    if (spec.id === compatibility.caseId) {
      assert.equal(spec.exitCode, compatibility.originalExpectedExitCode);
      for (const exists of [false, true]) {
        const ctx = context(spec.id + '-preserved-saturation-' + exists);
        fs.writeFileSync(ctx.options.file, spec.source);
        ctx.options.format = spec.format;
        if (exists) fs.writeFileSync(ctx.options.output, fixture.delivery.sentinelUTF8);
        assert.equal(invoke(ctx).status, compatibility.correctedExpectedExitCode);
        delivered(ctx, compatibility.expectedArtifact);
      }
    } else unchangedFailure(spec.id, ctx => {
      fs.writeFileSync(ctx.options.file, spec.source);
      ctx.options.format = spec.format;
    }, spec.exitCode);
  }
  unchangedFailure('source-invalid-utf8', ctx => {
    fs.writeFileSync(ctx.options.file, Buffer.from(compatibility.additionalIndependentError.sourceBytes));
  }, compatibility.additionalIndependentError.expectedExitCode);
  const invalidQueries = {
    'duplicate-name': {version: 1, fields: [fixture.query.fields[0], fixture.query.fields[0]]},
    'unsupported-type': {version: 1, fields: [{name: 'x', path: 'service.port', type: 'double'}]},
    'empty-fields': {version: 1, fields: []},
    'field-limit-65': {version: 1, fields: Array.from({length: 65}, (_, i) => ({name: 'f' + i, path: 'service.label', type: 'string'}))},
    'empty-name': {version: 1, fields: [{name: '', path: 'service.label', type: 'string'}]},
    'non-string-path': {version: 1, fields: [{name: 'x', path: 1, type: 'int'}]},
    'unknown-version': {version: 2, fields: fixture.query.fields},
    'unknown-field': {version: 1, fields: [{...fixture.query.fields[0], default: 8080}]},
  };
  for (const [id, query] of Object.entries(invalidQueries)) unchangedFailure(id, ctx => {
    fs.writeFileSync(ctx.options.queries, JSON.stringify(query));
  }, 1);
  for (const [id, bytes] of [['query-syntax', Buffer.from('{')],
    ['query-utf8', Buffer.from([255])], ['query-byte-limit-over', Buffer.alloc(400001, 32)]]) {
    unchangedFailure(id, ctx => fs.writeFileSync(ctx.options.queries, bytes), 1);
  }
  unchangedFailure('invalid-format', ctx => { ctx.options.format = 'yaml'; }, 1);
  unchangedFailure('missing-source', ctx => { ctx.options.file = path.join(ctx.dir, 'absent'); }, 1);
  unchangedFailure('missing-queries', ctx => { ctx.options.queries = path.join(ctx.dir, 'absent'); }, 1);
  unchangedFailure('queries-directory', ctx => { ctx.options.queries = ctx.dir; }, 1);
  const missingParent = context('output-parent-missing');
  missingParent.options.output = path.join(missingParent.dir, 'absent/output.json');
  assert.equal(invoke(missingParent).status, 1);
  assert(!fs.existsSync(missingParent.options.output));

  const noEnv = context('no-implicit-environment', {file: 'source.conf', files: {
    'source.conf': 'service.port=$' + '{HOCON_EXPORT_TEST_PORT}\n',
  }}, {version: 1, fields: [fixture.query.fields[0]]});
  assert.equal(invoke(noEnv, undefined, {...env, HOCON_EXPORT_TEST_PORT: '8080'}).status, 2);
  assert(!fs.existsSync(noEnv.options.output));
  for (const [id, argv] of [
    ['missing-argument', ['--file']], ['unknown-argument', ['--wat']],
    ['duplicate-argument', ['--file', 'a', '--file', 'b']],
    ['no-url-input', ['--url', 'http://127.0.0.1/']],
    ['missing-required', []], ['inherited-option-name', ['constructor', 'x']],
  ]) {
    const ctx = context(id);
    assert.equal(invoke(ctx, argv).status, 1);
    assert(!fs.existsSync(ctx.options.output));
  }
  const help = context('help');
  assert.equal(invoke(help, ['--help']).status, 0);

  for (const role of ['source', 'queries', 'fallback', 'relative', 'hardlink', 'symlink-parent', 'include']) {
    const ctx = context('protect-' + role, role === 'fallback' ? fixture.positives[3] :
      role === 'include' ? fixture.positives[1] : fixture.positives[0]);
    const source = ctx.options.file;
    let link;
    if (role === 'queries') ctx.options.output = ctx.options.queries;
    else if (role === 'fallback') ctx.options.output = ctx.options.fallbackFiles[0];
    else if (role === 'include') ctx.options.output = ctx.files['shared.conf'];
    else if (role === 'hardlink') fs.linkSync(source, ctx.options.output);
    else if (role === 'symlink-parent') {
      link = path.join(ctx.dir, 'alias');
      fs.symlinkSync(ctx.dir, link, process.platform === 'win32' ? 'junction' : 'dir');
      ctx.options.output = path.join(link, path.basename(source));
    } else ctx.options.output = role === 'relative' ? path.join(ctx.dir, 'sub', '..', path.basename(source)) : source;
    const before = fs.readFileSync(ctx.options.output);
    try {
      assert.equal(invoke(ctx).status, 1);
      assert.deepEqual(fs.readFileSync(ctx.options.output), before);
    } finally { if (link !== undefined) fs.unlinkSync(link); }
  }
  const directError = context('api-error-class');
  assert.throws(() => exportTypedConfigFile({...directError.options, output: directError.options.file}),
    error => error instanceof ConfigExportError && error.exitCode === 1);

  const good = context('handoff-success', fixture.receiver);
  assert.deepEqual(await handoff(good), {status: 0, receiverStarted: true});
  delivered(good, fixture.receiver.expectedArtifact);
  const bad = context('handoff-rejected', fixture.receiver);
  fs.writeFileSync(bad.options.queries, '{');
  fs.writeFileSync(bad.options.output, fixture.delivery.sentinelUTF8);
  const beforeStarts = startedReceivers;
  assert.deepEqual(await handoff(bad), {status: 1, receiverStarted: false});
  assert.equal(startedReceivers, beforeStarts);
  assert.equal(fs.readFileSync(bad.options.output, 'utf8'), fixture.delivery.sentinelUTF8);
  const invalidReceiver = path.join(root, 'receiver-invalid.json');
  fs.writeFileSync(invalidReceiver, '{"listenPort":0,"enabled":true,"banner":"你好","deploymentId":9007199254740993}');
  const rejected = spawnSync(process.execPath, [receiver, invalidReceiver], {env, encoding: 'utf8', timeout: 10000, windowsHide: true});
  assert.equal(rejected.status, 1);
  assert.equal(rejected.stdout, '');
  fs.writeFileSync(path.join(root, 'invalid-receiver.stderr.txt'), rejected.stderr);
  observations.push({id: 'receiver-rejects-numeric-long', status: rejected.status, ready: false});
} catch (error) { failure = error; }
const identities = Object.fromEntries(['tools/typed-config-export.mjs', 'examples/config-file-receiver.mjs',
  'tools/test-typed-config-export.mjs', 'tools/typed-config-export/cases.json',
  'tools/typed-config-export/compatibility.json', 'web/engine.mjs']
  .map(name => [name, hash(fs.readFileSync(path.join(repo, name)))]));
const report = {utc: new Date().toISOString(), passed: failure === undefined, node: process.version,
  runHead: process.env.GITHUB_SHA ?? null, identities, fixtureSHA256: hash(fs.readFileSync(fixtureFile)),
  observations, startedReceivers, evidenceDirectory: root,
  ...(failure === undefined ? {} : {failure: failure.stack})};
fs.writeFileSync(path.join(root, 'RESULT.json'), JSON.stringify(report, null, 2) + '\n');
console.log(JSON.stringify({passed: report.passed, observations: observations.length, startedReceivers,
  evidenceDirectory: root}));
if (failure) throw failure;
