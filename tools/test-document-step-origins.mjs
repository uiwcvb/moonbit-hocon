import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fork, spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {fileURLToPath, pathToFileURL} from 'node:url';

const args = process.argv.slice(2), opts = {};
for (let i = 0; i < args.length; i++) {
  if (args[i] === '--observe-before') opts.before = true;
  else {
    assert(['--repo', '--spec', '--evidence-dir'].includes(args[i]), 'Unknown argument');
    assert(i + 1 < args.length, 'Missing argument');
    opts[args[i].slice(2)] = args[++i];
  }
}
const repo = path.resolve(opts.repo ?? fileURLToPath(new URL('../', import.meta.url)));
const specPath = path.resolve(opts.spec ?? path.join(repo, 'tools/document-step-origins/cases.json'));
const rawSpec = fs.readFileSync(specPath), spec = JSON.parse(rawSpec);
const base = path.resolve(opts['evidence-dir'] ?? path.join(repo, 'output/document-step-origins'));
const output = path.join(base, 'run-' + Date.now() + '-' + process.pid);
fs.mkdirSync(output, {recursive: true});
const hash = data => createHash('sha256').update(data).digest('hex');
const save = (name, value) => fs.writeFileSync(path.join(output, name), JSON.stringify(value, null, 2) + '\n');
const {loadFile, loadFileAsync, loadURL, loadURLAsync, ConfigError} =
  await import(pathToFileURL(path.join(repo, 'tools/config.mjs')).href);
const observations = [], processes = [], contexts = [];
let server, serverExit, serverStarted, serverOut = [], serverErr = [], serverMessages = [], failure;
const report = {mode: opts.before ? 'original-code observation' : 'regression',
  startedAtUTC: new Date().toISOString(), processPID: process.pid, repo, specPath,
  specBytes: rawSpec.length, specSHA256: hash(rawSpec), observations, processes,
  scope: 'Existing document-step fragment origins and original include bases; no new document/editor/numeric or redaction policy.'};

function identity(filename) {
  const bytes = fs.readFileSync(filename);
  return {path: filename, bytes: bytes.length, sha256: hash(bytes)};
}
function inputs(ctx) {
  return Object.keys(ctx.files).map(name => identity(path.join(ctx.dir, name)));
}
function position(ctx, before = false) {
  const expected = {...ctx.test.expected.position};
  if (expected.source.startsWith('@CANONICAL_CASE_ROOT@/'))
    expected.source = fs.realpathSync(path.join(ctx.dir, expected.source.slice('@CANONICAL_CASE_ROOT@/'.length)));
  if (before && expected.source.startsWith('<document-step'))
    expected.source = fs.realpathSync(path.join(ctx.dir, ctx.test.entry));
  return expected;
}
function materialize(test) {
  const dir = path.join(output, test.id); fs.mkdirSync(dir);
  const files = test.files ?? {'steps.json': test.stepsJSON};
  for (const [name, content] of Object.entries(files)) {
    const filename = path.join(dir, name);
    fs.mkdirSync(path.dirname(filename), {recursive: true});
    fs.writeFileSync(filename, content);
  }
  const ctx = {test, dir, files, original: inputs({dir, files})};
  contexts.push(ctx); return ctx;
}
function writeObservation(ctx, mode, actual, consumed) {
  const name = ctx.test.id + '.' + mode;
  const observation = {caseId: ctx.test.id, mode, kind: 'public API call',
    processPID: process.pid, inputs: consumed, actual};
  if (!ctx.test.expected.accepted) {
    observation.expectedPosition = position(ctx);
    observation.matchesNewSourceContract = JSON.stringify(actual.position) === JSON.stringify(observation.expectedPosition);
  }
  observations.push(observation); save(name + '.observation.json', observation);
  return observation;
}
async function api(ctx, mode) {
  const consumed = inputs(ctx), options = {...ctx.test.options, steps: JSON.parse(fs.readFileSync(path.join(ctx.dir, 'steps.json'))), cwd: ctx.dir};
  if (options.classpath) options.classpath = options.classpath.map(p => path.resolve(ctx.dir, p));
  let actual;
  try {
    const entry = ctx.url ?? path.join(ctx.dir, ctx.test.entry);
    const fn = ctx.url ? (mode === 'sync' ? loadURL : loadURLAsync) : (mode === 'sync' ? loadFile : loadFileAsync);
    actual = {accepted: true, states: await fn(entry, options)};
  } catch (error) {
    actual = {accepted: false, name: error.name, message: error.message, position: error.position,
      isConfigError: error instanceof ConfigError, stack: error.stack};
  }
  writeObservation(ctx, mode, actual, consumed);
  assert.equal(actual.accepted, ctx.test.expected.accepted, ctx.test.id + ': acceptance');
  if (actual.accepted) assert.deepEqual(actual.states, ctx.test.expected.states);
  else {
    assert.equal(actual.isConfigError, true);
    assert.deepEqual(actual.position, position(ctx, opts.before), ctx.test.id + ': complete source position');
  }
}
function cli(ctx, tag = 'cli', expected = ctx.test.expected, json = true) {
  const stepFile = path.join(ctx.dir, 'steps.json'), supplied = fs.readFileSync(stepFile);
  const name = ctx.test.id + '.' + tag;
  fs.writeFileSync(path.join(output, name + '.steps.raw.json'), supplied);
  const argv = [path.join(repo, 'tools/cli.mjs'), ...(ctx.url ? ['--url', ctx.url] : ['--file', path.join(ctx.dir, ctx.test.entry)]),
    '--document-steps', stepFile, ...(json ? ['--json'] : [])];
  for (const probe of ctx.test.options.probes ?? []) argv.push('--probe', probe);
  for (const cp of ctx.test.options.classpath ?? []) argv.push('--classpath', path.resolve(ctx.dir, cp));
  const consumed = inputs(ctx), startedAtUTC = new Date().toISOString(), start = performance.now();
  const child = spawnSync(process.execPath, argv, {cwd: ctx.dir, windowsHide: true, timeout: 15000, maxBuffer: 4 * 1024 * 1024});
  const stdout = child.stdout ?? Buffer.alloc(0), stderr = child.stderr ?? Buffer.alloc(0);
  fs.writeFileSync(path.join(output, name + '.stdout.raw'), stdout);
  fs.writeFileSync(path.join(output, name + '.stderr.raw'), stderr);
  fs.writeFileSync(path.join(output, name + '.received.log'), stdout);
  const receipt = {name, kind: 'CLI process', argv: [process.execPath, ...argv], cwd: ctx.dir, pid: child.pid,
    startedAtUTC, completedAtUTC: new Date().toISOString(), milliseconds: performance.now() - start,
    exitCode: child.status, signal: child.signal, error: child.error ? String(child.error) : null, inputs: consumed,
    steps: {bytes: supplied.length, sha256: hash(supplied)},
    stdout: {path: name + '.stdout.raw', bytes: stdout.length, sha256: hash(stdout)},
    stderr: {path: name + '.stderr.raw', bytes: stderr.length, sha256: hash(stderr)},
    receivedLogByteEqual: fs.readFileSync(path.join(output, name + '.received.log')).equals(stdout)};
  processes.push(receipt); save(name + '.process.json', receipt);
  assert.equal(child.error, undefined); assert.equal(child.signal, null);
  assert.equal(child.status, expected.cliExitCode); assert.equal(stderr.toString(), expected.cliStderr);
  assert(receipt.receivedLogByteEqual);
  let text = stdout.toString();
  if (json) {
    const envelope = JSON.parse(text);
    assert.deepEqual(Object.keys(envelope).sort(), ['ok', 'output']);
    assert.equal(envelope.ok, expected.accepted); text = envelope.output;
  }
  if (expected.accepted) {
    const states = JSON.parse(text); assert.deepEqual(states, expected.states);
    fs.writeFileSync(path.join(output, name + '.received-states.json'), JSON.stringify(states, null, 2) + '\n');
  } else {
    const failedCtx = {...ctx, test: {...ctx.test, expected}};
    const expectedPosition = position(failedCtx, opts.before);
    const expectedSuffix = ' (' + expectedPosition.source + ':' + expectedPosition.line + ':' + expectedPosition.column + ')';
    assert(text.startsWith('ERROR: ')); assert(text.trimEnd().endsWith(expectedSuffix));
    receipt.newContractSourcePresent = text.includes(position(failedCtx).source);
    save(name + '.process.json', receipt);
  }
}
async function startServer(ctx) {
  const fixtureFile = path.join(ctx.dir, 'http-fixtures.json');
  fs.writeFileSync(fixtureFile, JSON.stringify(ctx.test.httpFixtures, null, 2) + '\n');
  serverStarted = new Date().toISOString();
  server = fork(path.join(repo, 'tools/http-test-server.mjs'), [fixtureFile],
    {cwd: ctx.dir, windowsHide: true, stdio: ['ignore', 'pipe', 'pipe', 'ipc']});
  server.stdout.on('data', bytes => serverOut.push(bytes));
  server.stderr.on('data', bytes => serverErr.push(bytes));
  server.on('message', message => serverMessages.push(message));
  serverExit = once(server, 'exit');
  const timer = setTimeout(() => server.kill(), 10000);
  try {
    const [addresses] = await Promise.race([once(server, 'message'), serverExit.then(() => {throw new Error('Fixture exited before ready');})]);
    ctx.url = addresses.http + '/app/main.conf';
  } finally { clearTimeout(timer); }
}
async function stopServer() {
  if (!server) return;
  if (server.exitCode === null && server.signalCode === null && server.connected) server.send('stop');
  const timer = setTimeout(() => server.kill(), 3000);
  const [exitCode, signal] = await serverExit; clearTimeout(timer);
  const stdout = Buffer.concat(serverOut), stderr = Buffer.concat(serverErr);
  fs.writeFileSync(path.join(output, 'http-server.stdout.raw'), stdout);
  fs.writeFileSync(path.join(output, 'http-server.stderr.raw'), stderr);
  save('http-server.messages.json', serverMessages);
  const receipt = {name: 'owned HTTP fixture', kind: 'fixture process', pid: server.pid,
    argv: server.spawnargs, startedAtUTC: serverStarted, completedAtUTC: new Date().toISOString(), exitCode, signal,
    stdout: {path: 'http-server.stdout.raw', bytes: stdout.length, sha256: hash(stdout)},
    stderr: {path: 'http-server.stderr.raw', bytes: stderr.length, sha256: hash(stderr)}};
  processes.push(receipt); save('http-server.process.json', receipt);
  assert.equal(exitCode, 0); assert.equal(signal, null);
}
try {
  for (const test of spec.cases) {
    const ctx = materialize(test);
    if (test.httpFixtures) await startServer(ctx);
    await api(ctx, 'sync'); await api(ctx, 'async'); cli(ctx);
    if (test.recovery) {
      fs.writeFileSync(path.join(ctx.dir, 'steps.json'), test.recovery.firstStepsJSON);
      cli(ctx, 'recovery-bad', test.recovery.firstExpected, false);
      fs.writeFileSync(path.join(ctx.dir, 'steps.json'), test.recovery.correctedStepsJSON);
      cli(ctx, 'recovery-fixed', test.expected, false);
    }
  }
  if (server) {
    const pending = once(server, 'message'); server.send('logs');
    const [snapshot] = await pending;
    assert(snapshot.requests.some(req => req.url === '/app/extra.conf'));
    assert(!snapshot.requests.some(req => req.url === '/extra.conf'));
  }
  for (const ctx of contexts) for (const original of ctx.original)
    assert.equal(identity(original.path).sha256, original.sha256, 'Source input changed');
  report.passed = true;
} catch (error) {
  failure = error; report.passed = false; report.error = String(error.stack ?? error);
} finally {
  try { await stopServer(); } catch (error) { failure ??= error; report.passed = false; report.cleanupError = String(error.stack ?? error); }
  report.completedAtUTC = new Date().toISOString();
  report.sourceIdentities = Object.fromEntries(['cmd/web/document.mbt', 'tools/config-host.mjs', 'tools/config.mjs',
    'tools/cli.mjs', 'web/engine.mjs'].map(name => [name, identity(path.join(repo, name))]));
  report.originalAPIOriginMismatches = observations.filter(x => x.matchesNewSourceContract === false).length;
  save('RESULT.json', report);
}
console.log(JSON.stringify({passed: report.passed, mode: report.mode, apiCalls: observations.length,
  processes: processes.length, originalAPIOriginMismatches: report.originalAPIOriginMismatches,
  reportPath: path.join(output, 'RESULT.json')}));
if (failure) throw failure;
