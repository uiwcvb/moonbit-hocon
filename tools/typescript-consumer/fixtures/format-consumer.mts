import {Config, ConfigValue, load, loadAsync, loadFile, loadURL, loadFileAsync, loadURLAsync} from './product/tools/config.mjs';
import {pathToFileURL} from 'node:url';
const filename = process.argv[2];
if (!filename) throw new Error('properties filename required');
const url = pathToFileURL(filename).href;
const results: {entry: string; value: unknown}[] = [];
function configData(config: Config) {return {name: config.getString('name'), count: config.getInt('count')};}
function propertyData(config: Config) {return {name: config.getString('typed.name'), port: config.getInt('typed.port'), enabled: config.getBoolean('typed.enabled'), build: config.getLong('typed.build')};}
function fallbackData(config: Config) {return {name: config.getString('service.name'), port: config.getInt('service.port'), enabled: config.getBoolean('service.enabled'), build: config.getLong('service.build')};}
function text(value: unknown): string {if (typeof value !== 'string') throw new Error('expected string getter output'); return value;}
for (const format of ['hocon', 'json'] as const) {
  const source = format === 'json' ? '{"name":"string-client","count":7}' : 'name="string-client"\ncount=7';
  results.push({entry: 'Config.parse.' + format, value: configData(Config.parse(source, {format}).resolve())});
  results.push({entry: 'Config.load.' + format, value: configData(Config.load(source, {format}))});
  results.push({entry: 'Config.parseAsync.' + format, value: configData((await Config.parseAsync(source, {format})).resolve())});
  results.push({entry: 'Config.loadAsync.' + format, value: configData(await Config.loadAsync(source, {format}))});
  results.push({entry: 'load.' + format, value: text(load(source, {format, getter: 'string', path: 'name'}))});
  results.push({entry: 'loadAsync.' + format, value: text(await loadAsync(source, {format, getter: 'string', path: 'name'}))});
}
results.push({entry: 'ConfigValue.parse.default', value: ConfigValue.parse('"fragment-client"').unwrapped()});
results.push({entry: 'ConfigValue.parse.hocon', value: ConfigValue.parse('"fragment-client"', {format: 'hocon'}).unwrapped()});
results.push({entry: 'ConfigValue.parse.hocon.resolved', value: ConfigValue.parse('"fragment-client"', {format: 'hocon', resolved: true}).unwrapped()});
results.push({entry: 'Config.parseFile.properties', value: propertyData(Config.parseFile(filename, {format: 'properties'}).resolve())});
results.push({entry: 'Config.loadFile.properties', value: propertyData(Config.loadFile(filename, {format: 'properties'}))});
results.push({entry: 'Config.parseURL.properties', value: propertyData(Config.parseURL(url, {format: 'properties'}).resolve())});
results.push({entry: 'Config.loadURL.properties', value: propertyData(Config.loadURL(url, {format: 'properties'}))});
results.push({entry: 'Config.parseFileAsync.properties', value: propertyData((await Config.parseFileAsync(filename, {format: 'properties'})).resolve())});
results.push({entry: 'Config.loadFileAsync.properties', value: propertyData(await Config.loadFileAsync(filename, {format: 'properties'}))});
results.push({entry: 'Config.parseURLAsync.properties', value: propertyData((await Config.parseURLAsync(url, {format: 'properties'})).resolve())});
results.push({entry: 'Config.loadURLAsync.properties', value: propertyData(await Config.loadURLAsync(url, {format: 'properties'}))});
results.push({entry: 'loadFile.properties', value: text(loadFile(filename, {format: 'properties', getter: 'long', path: 'typed.build'}))});
results.push({entry: 'loadURL.properties', value: text(loadURL(url, {format: 'properties', getter: 'long', path: 'typed.build'}))});
results.push({entry: 'loadFileAsync.properties', value: text(await loadFileAsync(filename, {format: 'properties', getter: 'long', path: 'typed.build'}))});
results.push({entry: 'loadURLAsync.properties', value: text(await loadURLAsync(url, {format: 'properties', getter: 'long', path: 'typed.build'}))});
const fallbacks = [
  {name: 'defaults.conf', content: 'service {name="fallback-client", port=8123, build=9007199254740997}', format: 'hocon'},
  {name: 'defaults.json', content: '{"service":{"enabled":true}}', format: 'json'}
] as const;
const primary = 'service.name="primary-client"';
results.push({entry: 'fallback.Config.load', value: fallbackData(Config.load(primary, {fallbacks}))});
results.push({entry: 'fallback.Config.loadAsync', value: fallbackData(await Config.loadAsync(primary, {fallbacks}))});
results.push({entry: 'fallback.load', value: text(load(primary, {fallbacks, getter: 'long', path: 'service.build'}))});
results.push({entry: 'fallback.loadAsync', value: text(await loadAsync(primary, {fallbacks, getter: 'long', path: 'service.build'}))});
console.log(JSON.stringify(results));
