import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {spawn, spawnSync} from 'node:child_process';
import {once} from 'node:events';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
import {Config, ConfigError, loadFile, loadFileAsync} from './config.mjs';

const repo = fileURLToPath(new URL('../', import.meta.url));
const caseFile = path.join(repo, 'tools/classpath-priority/cases.json');
const referenceFile = path.join(repo, 'tools/classpath-priority/reference.json');
const spec = JSON.parse(fs.readFileSync(caseFile, 'utf8'));
const reference = JSON.parse(fs.readFileSync(referenceFile, 'utf8'));
const args = process.argv.slice(2);
assert(args.length === 0 || (args.length === 2 && args[0] === '--evidence-dir'), 'Use --evidence-dir PATH');
const base = path.resolve(args[1] ?? path.join(repo, 'output/classpath-priority'));
fs.mkdirSync(base, {recursive: true});
const root = fs.mkdtempSync(path.join(base, 'run-'));
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const env = {...process.env};
delete env.NODE_OPTIONS;
delete env.NODE_V8_COVERAGE;
env.NODE_DISABLE_COMPILE_CACHE = '1';
const observations = [];

function inputs(id, value) {
  const dir = path.join(root, id);
  for (const [name, text] of Object.entries(value.files)) {
    const target = path.join(dir, name);
    fs.mkdirSync(path.dirname(target), {recursive: true});
    fs.writeFileSync(target, text);
  }
  return {dir, file: path.join(dir, value.entry), classpath: value.classpath.map(name => path.join(dir, name))};
}

function position(actual, expected) {
  assert(actual, 'Required source position');
  assert.equal(actual.offset, expected.offset);
  assert.equal(actual.line, expected.line);
  assert.equal(actual.column, expected.column);
  assert(actual.source.replaceAll('\\', '/').endsWith('/' + expected.file));
}

function equal(actual, expected) {
  assert.equal(actual.accepted, expected.accepted);
  if (expected.accepted) assert.deepEqual(actual.value, expected.value);
}

async function observe(c, route, operation) {
  let actual;
  try { actual = {accepted: true, value: await operation()}; }
  catch (error) {
    assert(error instanceof ConfigError);
    actual = {accepted: false, error: error.message, position: error.position};
  }
  observations.push({id: c.id, route, actual});
  equal(actual, c.expected);
  if (c.expectedPosition) position(actual.position, c.expectedPosition);
}

async function receiver(ctx) {
  const argv = [path.join(repo, 'examples/classpath-service.mjs'), '--file', ctx.file,
    ...ctx.classpath.flatMap(dir => ['--classpath', dir])];
  const child = spawn(process.execPath, argv, {cwd: ctx.dir, env,
    stdio: ['ignore', 'pipe', 'pipe'], windowsHide: true});
  let stdout = '', stderr = '', timer;
  child.stdout.setEncoding('utf8');
  child.stderr.setEncoding('utf8');
  child.stderr.on('data', text => { stderr += text; });
  const closed = once(child, 'close');
  try {
    const ready = await new Promise((resolve, reject) => {
      timer = setTimeout(() => reject(new Error('Startup receiver timeout')), 10000);
      child.once('error', reject);
      child.once('exit', code => reject(new Error('Receiver exited before ready: ' + code + ' ' + stderr)));
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
    const result = await fetch(ready.url, {signal: AbortSignal.timeout(10000)});
    const body = await result.text();
    fs.writeFileSync(path.join(ctx.dir, 'http-body.txt'), body);
    assert.equal(result.status, 200);
    assert.deepEqual(JSON.parse(body), spec.receiver.expectedHTTP);
    assert.deepEqual(Object.keys(JSON.parse(body)).sort(), Object.keys(spec.receiver.expectedHTTP).sort());
    observations.push({id: 'startup-http', argv, ready, status: result.status,
      body: JSON.parse(body), rawBodySHA256: hash(Buffer.from(body))});
  } finally {
    clearTimeout(timer);
    if (child.exitCode === null && child.signalCode === null) child.kill();
    const [code, signal] = await closed;
    fs.writeFileSync(path.join(ctx.dir, 'receiver.stdout.txt'), stdout);
    fs.writeFileSync(path.join(ctx.dir, 'receiver.stderr.txt'), stderr);
    fs.writeFileSync(path.join(ctx.dir, 'receiver-close.json'), JSON.stringify({code, signal}) + '\n');
    observations.push({id: 'receiver-close', code, signal, interpretation: 'Observed owned-service shutdown, not an assumed exit code.'});
  }
}

let failure;
try {
  assert.equal(reference.jarSHA256, '47d13e3196c84f2a8ccd014ae563738c3da5b7406b38e03505ec0601a2f4fc37');
  assert.deepEqual(reference.caseIds, spec.cases.map(c => c.id));
  assert.equal(reference.references.length, spec.cases.length);
  for (let i = 0; i < spec.cases.length; i++) {
    const c = spec.cases[i];
    equal(reference.references[i], c.expected);
    const ctx = inputs(c.id, c);
    const reads = [];
    await observe(c, 'public-loadFile', () => loadFile(ctx.file, {
      classpath: ctx.classpath, network: false, environment: {}, onRead: event => reads.push(event),
    }));
    fs.writeFileSync(path.join(ctx.dir, 'reads.json'), JSON.stringify(reads, null, 2) + '\n');
    await observe(c, 'public-Config.loadFile', () => Config.loadFile(ctx.file, {
      classpath: ctx.classpath, network: false, environment: {},
    }).toJSON());
    await observe(c, 'public-worker-loadFileAsync', () => loadFileAsync(ctx.file, {
      classpath: ctx.classpath, network: false, environment: {},
    }));
    const argv = [path.join(repo, 'tools/cli.mjs'), '--file', ctx.file, '--resolved-json',
      ...ctx.classpath.flatMap(dir => ['--classpath', dir])];
    const cli = spawnSync(process.execPath, argv, {
      cwd: ctx.dir, env, encoding: 'utf8', windowsHide: true, timeout: 15000,
    });
    fs.writeFileSync(path.join(ctx.dir, 'cli.stdout.txt'), cli.stdout ?? '');
    fs.writeFileSync(path.join(ctx.dir, 'cli.stderr.txt'), cli.stderr ?? '');
    assert(!cli.error, cli.error?.message);
    assert.equal(cli.status, c.expected.accepted ? 0 : 2, cli.stderr);
    if (c.expected.accepted) assert.deepEqual(JSON.parse(cli.stdout), c.expected.value);
    else {
      assert(cli.stdout.includes('ERROR:'));
      assert(cli.stdout.includes(':1:28'));
    }
    observations.push({id: c.id, route: 'public-CLI', argv, exitCode: cli.status,
      stdoutSHA256: hash(Buffer.from(cli.stdout)), stderrSHA256: hash(Buffer.from(cli.stderr))});
  }
  const good = inputs('receiver-success', spec.receiver);
  await receiver(good);
  const invalid = spec.cases.find(c => !c.expected.accepted);
  const bad = inputs('receiver-rejected', invalid);
  const argv = [path.join(repo, 'examples/classpath-service.mjs'), '--file', bad.file,
    ...bad.classpath.flatMap(dir => ['--classpath', dir])];
  const rejected = spawnSync(process.execPath, argv, {
    cwd: bad.dir, env, encoding: 'utf8', windowsHide: true, timeout: 15000,
  });
  fs.writeFileSync(path.join(bad.dir, 'receiver.stdout.txt'), rejected.stdout ?? '');
  fs.writeFileSync(path.join(bad.dir, 'receiver.stderr.txt'), rejected.stderr ?? '');
  assert(!rejected.error, rejected.error?.message);
  assert.equal(rejected.status, 1);
  assert.equal(rejected.stdout, '');
  const diagnostic = JSON.parse(rejected.stderr);
  assert.equal(diagnostic.ready, false);
  position(diagnostic.position, invalid.expectedPosition);
  observations.push({id: 'receiver-rejected', argv, exitCode: rejected.status, signal: rejected.signal,
    ready: false, diagnostic});
} catch (error) { failure = error; }
const identities = Object.fromEntries(['tools/config-host.mjs', 'tools/test-classpath-priority.mjs',
  'examples/classpath-service.mjs', 'tools/classpath-priority/cases.json',
  'tools/classpath-priority/reference.json', 'web/engine.mjs']
  .map(name => [name, hash(fs.readFileSync(path.join(repo, name)))]));
const result = {utc: new Date().toISOString(), passed: failure === undefined, node: process.version,
  runHead: process.env.GITHUB_SHA ?? null, identities, frozenOriginalReference: reference,
  observations, evidenceDirectory: root, ...(failure === undefined ? {} : {failure: failure.stack})};
fs.writeFileSync(path.join(root, 'RESULT.json'), JSON.stringify(result, null, 2) + '\n');
console.log(JSON.stringify({passed: result.passed, observations: observations.length, evidenceDirectory: root}));
if (failure) throw failure;
