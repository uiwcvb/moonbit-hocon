import {Config, ConfigValue, ConfigError, load, loadAsync} from './product/tools/config.mjs';
const cases: readonly (readonly [string, () => unknown | Promise<unknown>])[] = [
  ['fallback-missing', () => Config.load('name=primary', {fallbacks: [{name: 'f.conf', content: 'port=3'}]})],
  ['Config.parse.properties', () => Config.parse('name=x', {format: 'properties'})],
  ['Config.load.properties', () => Config.load('name=x', {format: 'properties'})],
  ['Config.parseAsync.properties', () => Config.parseAsync('name=x', {format: 'properties'})],
  ['Config.loadAsync.properties', () => Config.loadAsync('name=x', {format: 'properties'})],
  ['load.properties', () => load('name=x', {format: 'properties'})],
  ['loadAsync.properties', () => loadAsync('name=x', {format: 'properties'})],
  ['ConfigValue.parse.properties', () => ConfigValue.parse('"x"', {format: 'properties'})],
  ['ConfigValue.parse.json', () => ConfigValue.parse('"x"', {format: 'json'})]
];
const failures: {entry: string; error: string}[] = [];
for (const [entry, run] of cases) {
  try {await run(); throw new Error('unsupported input unexpectedly accepted: ' + entry);}
  catch (error: unknown) {
    if (!(error instanceof ConfigError)) throw error;
    failures.push({entry, error: error.name});
  }
}
console.log(JSON.stringify(failures));
