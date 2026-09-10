import { spawnSync } from 'node:child_process';
import { readFileSync, writeFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { isDeepStrictEqual } from 'node:util';
import { fileURLToPath } from 'node:url';
import { json } from '../web/engine.mjs';
const jar = process.env.HOCON_REFERENCE_JAR;
if (!jar) throw new Error('Set HOCON_REFERENCE_JAR to the upstream Lightbend Config jar');
const cases = [
  'a=1\nb=true\nc=null\nd="1"', 'a=-1.25e+3', 'a=[1,false,null,{x=2},[3,4],]',
  'a=[1\n2\n3]', 'a=[1 2]', 'a=hello  world', 'a=foo-bar',
  'a="\\u4e2d\\u6587\\n\\t"\nb="\\ud83d\\ude00"',
  'a={x=1}\na={y=2}', 'a={x=1}\na=null\na={y=2}',
  'a=[1] [2,3]', 'a={x=1} {y=2}', 'a=[1,true]\nb=${a}',
  'a=${?MISSING_HOCON_TEST_VALUE}', 'a=7\na=${?MISSING_HOCON_TEST_VALUE}',
  'a=[0,${?MISSING_HOCON_TEST_VALUE},1]', 'a=${?MISSING_HOCON_TEST_VALUE}suffix',
  'a="prefix"${?MISSING_HOCON_TEST_VALUE}', '"a.b"=7\nz=${"a.b"}',
  'host=api\nport=80\nurl=${host}":"${port}', 'a={x=1}\nb=${a}\nb={y=2}',
  'a={x=1}\nb=${a}\nc=${b.x}',
  'include "__missing_hocon_fixture_2026.conf"\na=1',
  'include required("__missing_hocon_fixture_2026.conf")',
  'a=[1] text', 'a={} [1]', 'a=[1,,2]', 'a=[,1]', 'a=1,,b=2',
  'a=[1', 'a={x=1', 'a=${missing}', 'a=${b}\nb=${a}', 'a="bad\nstring"',
];
const reference = spawnSync(process.env.JAVA ?? 'java', ['-cp', jar, fileURLToPath(new URL('./HoconReference.java', import.meta.url))], {
  input: cases.map(s => Buffer.from(s).toString('base64')).join('\n') + '\n', encoding: 'utf8', timeout: 30000, windowsHide: true,
});
if (reference.error || reference.status !== 0) throw reference.error ?? new Error(reference.stderr);
const lines = reference.stdout.trim().split(/\r?\n/);
if (lines.length !== cases.length) throw new Error('Reference response count mismatch');
const results = cases.map((source, i) => {
  const line = lines[i], split = line.indexOf(':');
  const referenceAccepted = line.startsWith('OK:');
  const expected = Buffer.from(line.slice(split + 1), 'base64').toString('utf8');
  const actual = json(source), actualAccepted = !actual.startsWith('ERROR:');
  const passed = referenceAccepted === actualAccepted && (!referenceAccepted || isDeepStrictEqual(JSON.parse(actual), JSON.parse(expected)));
  return { source, referenceAccepted, actualAccepted, expected, actual, passed };
});
const failed = results.filter(r => !r.passed);
const hash = data => createHash('sha256').update(data).digest('hex');
writeFileSync(new URL('../evidence/typed-reference-validation.json', import.meta.url), JSON.stringify({
  date: new Date().toISOString(), reference: 'Lightbend Config 1.4.5',
  source: 'https://repo.maven.apache.org/maven2/com/typesafe/config/1.4.5/config-1.4.5.jar',
  jarSha256: hash(readFileSync(jar)), engineSha256: hash(readFileSync(new URL('../web/engine.mjs', import.meta.url))),
  total: results.length, passed: results.length - failed.length, failed: failed.length, results,
}, null, 2) + '\n');
console.log(`${results.length - failed.length}/${results.length} upstream typed configuration cases agree`);
for (const result of failed) console.log(JSON.stringify(result));
if (failed.length) process.exitCode = 1;
