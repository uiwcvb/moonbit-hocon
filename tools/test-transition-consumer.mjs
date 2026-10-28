import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import cases from './transition-consumer/cases.mjs';

const repo = fileURLToPath(new URL('../', import.meta.url));
const appTemplate = path.join(repo, 'tools/transition-consumer/app');
const output = path.join(repo, 'output/transition-consumer');
const cache = path.resolve(process.env.HOCON_CONSUMER_CACHE || path.join(output, 'workspaces'));
fs.mkdirSync(output, { recursive: true });
fs.mkdirSync(cache, { recursive: true });
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const writeJSON = (name, value) => fs.writeFileSync(path.join(output, name), JSON.stringify(value, null, 2) + '\n');
const sourceFiles = fs.readdirSync(repo).filter(name => name.endsWith('.mbt')
  && !name.endsWith('_test.mbt') && !name.endsWith('_wbtest.mbt'));
sourceFiles.push('moon.mod', 'moon.pkg', 'pkg.generated.mbti', 'README.md', 'LICENSE', 'THIRD_PARTY_NOTICES.md');
const sourceIdentity = Object.fromEntries(sourceFiles.sort().map(name => [name, hash(fs.readFileSync(path.join(repo, name)))]));
// Record the complete oracle before executing any compiler or application.
writeJSON('expected.json', cases);
const manifest = {
  success: false, sourceIdentity, casesPerTarget: cases.length, targets: [],
  applicationIdentity: Object.fromEntries(['moon.mod', 'moon.pkg', 'main.mbt']
    .map(name => [name, hash(fs.readFileSync(path.join(appTemplate, name)))])),
  coldScope: 'Fresh application/library modules and product build dirs; the pinned compiler and its standard-library bundles are reused.',
  moduleResolution: 'moon.work local-source members, with a separate app moon.mod import of uiwcvb/hocon@0.25.0',
};

function canonical(value) {
  const result = structuredClone(value);
  // Report order is not a documented contract. Paths and all fields remain exact.
  if (result.review) {
    for (const name of ['changes', 'unexpected', 'mismatches', 'unused_rules']) {
      result.review[name].sort((a, b) => JSON.stringify([a.path, a.kind, a.side || ''])
        .localeCompare(JSON.stringify([b.path, b.kind, b.side || ''])));
    }
  }
  return result;
}

function artifacts(dir, root = dir) {
  const result = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) result.push(...artifacts(full, root));
    else if (entry.isFile() && /\.(?:js|wasm)$/.test(entry.name)) {
      result.push({ path: path.relative(root, full), sha256: hash(fs.readFileSync(full)), bytes: fs.statSync(full).size });
    }
  }
  return result;
}

try {
  const version = spawnSync('moon', ['version', '--all'], { cwd: repo, encoding: 'utf8' });
  fs.writeFileSync(path.join(output, 'toolchain.txt'), (version.stdout || '') + (version.stderr || ''));
  assert.equal(version.status, 0, version.stderr);
  manifest.compiler = { expectedRelease: fs.readFileSync(path.join(repo, '.moonbit-version'), 'utf8').trim(), output: version.stdout };
  for (const target of ['js', 'wasm-gc']) {
    const workspace = fs.mkdtempSync(path.join(cache, `${target}-`));
    const library = path.join(workspace, 'library');
    const app = path.join(workspace, 'consumer');
    const logs = path.join(output, target);
    fs.mkdirSync(library);
    fs.mkdirSync(app);
    fs.mkdirSync(logs, { recursive: true });
    for (const name of sourceFiles) fs.copyFileSync(path.join(repo, name), path.join(library, name));
    fs.cpSync(path.join(repo, 'licenses'), path.join(library, 'licenses'), { recursive: true });
    for (const name of ['moon.mod', 'moon.pkg', 'main.mbt']) {
      fs.copyFileSync(path.join(appTemplate, name), path.join(app, name));
    }
    fs.writeFileSync(path.join(workspace, 'moon.work'), 'members = ["library", "consumer"]\n');
    const coldPaths = [workspace, library, app].flatMap(dir => ['_build', '.mooncakes', 'target'].map(name => path.join(dir, name)));
    assert(coldPaths.every(name => !fs.existsSync(name)), 'Product caches must not enter a cold consumer workspace');
    assert(!fs.existsSync(path.join(library, 'cmd')) && !fs.existsSync(path.join(library, 'web')));
    assert(!fs.readdirSync(library).some(name => name.endsWith('_test.mbt') || name.endsWith('_wbtest.mbt')));
    const proof = { target, workspace, freshProductCaches: true, productionOnlyDependency: true, commands: [], results: [] };
    manifest.targets.push(proof);

    function moon(label, args) {
      const result = spawnSync('moon', args, {
        cwd: app, encoding: 'utf8', timeout: 120_000, maxBuffer: 16 * 1024 * 1024,
      });
      fs.writeFileSync(path.join(logs, `${label}.stdout.txt`), result.stdout || '');
      fs.writeFileSync(path.join(logs, `${label}.stderr.txt`), result.stderr || '');
      proof.commands.push({ label, args, exitCode: result.status, error: result.error?.message || null });
      assert.equal(result.status, 0, `${target}/${label}: ${result.error || result.stderr}`);
      return result.stdout;
    }

    for (const fixture of cases) {
      const result = { id: fixture.id, passed: false };
      proof.results.push(result);
      const stdout = moon(fixture.id, ['run', '.', '--target', target, '--deny-warn', '--', JSON.stringify(fixture.request)]);
      result.actual = JSON.parse(stdout);
      assert.deepEqual(canonical(result.actual), canonical(fixture.expected), `${target}/${fixture.id}`);
      result.passed = true;
    }
    // Check the new application's source format and generated public interface.
    moon('format', ['fmt']);
    assert.equal(fs.readFileSync(path.join(app, 'main.mbt'), 'utf8'),
      fs.readFileSync(path.join(appTemplate, 'main.mbt'), 'utf8'), 'Format the consumer fixture before committing it');
    moon('interface', ['info']);
    proof.appInterfaceSHA256 = hash(fs.readFileSync(path.join(app, 'pkg.generated.mbti')));
    proof.artifacts = artifacts(workspace);
    assert(proof.artifacts.some(item => item.path.endsWith(target === 'js' ? '.js' : '.wasm')));
    console.log(`${target}: ${proof.results.length} independent cold-module consumer cases passed`);
  }
  manifest.success = true;
} finally {
  // Keep failed inputs, full stdout/stderr and cold workspaces for diagnosis.
  writeJSON('manifest.json', manifest);
}
