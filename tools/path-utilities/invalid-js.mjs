import {joinPath, splitPath} from './product/tools/config.mjs';
const invalid = [
  ['join-not-array', () => joinPath('a.b')],
  ['join-not-string', () => joinPath(['a', 1])],
  ['split-not-string', () => splitPath(null)]
];
const errors = [];
for (const [name, run] of invalid) {
  try {run(); throw new Error('invalid JS argument accepted: ' + name);}
  catch (error) {if (!(error instanceof TypeError)) throw error; errors.push({name, error: error.name, message: error.message});}
}
console.log(JSON.stringify(errors));
