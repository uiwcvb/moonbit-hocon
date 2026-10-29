import {Config, ConfigError, joinPath, splitPath} from './product/tools/config.mjs';
import {samples} from './cases.mjs';
import {resolve} from 'node:path';
const beforeFile = process.argv[2], afterFile = process.argv[3];
if (!beforeFile || !afterFile) throw new Error('before/after files required');
const before = Config.loadFile(resolve(beforeFile));
const after = await Config.loadFileAsync(resolve(afterFile));
const paths = samples.map(sample => ({name: sample.name, joined: joinPath(sample.parts),
  split: splitPath(sample.expression), roundTrip: splitPath(joinPath(sample.parts))}));
const plans = [
  {path: ['service', 'a.b', 'port'], beforeSource: '8000', afterSource: '9000'},
  {path: ['service', 'a.b', ''], beforeSource: '"old"', afterSource: '"new"'}
];
const review = before.reviewTransition(after, plans);
if (!review.accepted) throw new Error('literal-path transition should be accepted');
const selected = plans.map(plan => {
  const path = joinPath(plan.path);
  return {segments: plan.path, path, split: splitPath(path), before: before.getAnyRef(path), after: after.getAnyRef(path)};
});
const wrong = before.reviewChanges(after, [{path: ['service', 'a', 'b', 'port'], kind: 'changed'}]);
const errors: {name: string; error: string; position: unknown}[] = [];
const invalid: readonly (readonly [string, () => unknown])[] = [
  ['empty-join', () => joinPath([])],
  ['depth33', () => joinPath(Array(33).fill('p'))],
  ['double-dot', () => splitPath('a..b')],
  ['trailing-dot', () => splitPath('a.')],
  ['oversize', () => splitPath('x'.repeat(100001))]
];
for (const [name, run] of invalid) {
  try {run(); throw new Error('invalid path accepted: ' + name);}
  catch (error: unknown) {
    if (!(error instanceof ConfigError)) throw error;
    errors.push({name, error: error.name, position: error.position ?? null});
  }
}
console.log(JSON.stringify({paths, review: {accepted: review.accepted, selected, decoyPort: after.getInt('service.a.b.port')},
  rejectedPolicy: {accepted: wrong.accepted, unexpected: wrong.unexpected.map(change => joinPath(change.path)).sort()},
  errors, recovery: after.getConfig(joinPath(['service', 'a.b'])).getInt('port')}));
