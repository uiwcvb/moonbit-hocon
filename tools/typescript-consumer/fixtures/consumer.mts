import {Config, ConfigError, ConfigValue, ConfigObject, ConfigList, ConfigEntry, ConfigEntrySet} from './product/tools/config.mjs';
const filename = process.argv[2];
if (!filename) throw new Error('configuration filename required');
try {
  const settings: Config = process.argv[3] === 'async'
    ? await Config.loadFileAsync(filename, {network: false})
    : Config.loadFile(filename, {network: false});
  const app: ConfigObject = settings.getObject('app');
  const paths: ConfigList = settings.getList('paths');
  const pathNames: string[] = [];
  for (const item of paths) {
    const value: ConfigValue = item;
    const text = value.unwrapped();
    if (typeof text !== 'string') throw new Error('expected path text');
    pathNames.push(text);
  }
  const selected = new ConfigEntry('app.build', settings.getValue('app.build'));
  const entries = new ConfigEntrySet([selected]);
  const cursor = entries.iterator();
  const entry = cursor.next();
  if (entry === null) throw new Error('missing entry');
  const next = settings.withValue('app.retries', 4);
  const review = settings.reviewTransition(next, [
    {path: ['app', 'retries'], beforeSource: '3', afterSource: '4'}
  ]);
  const result: {
    name: string; retries: number; enabled: boolean; build: string;
    timeoutNs: string; paths: string[]; appKeys: string[];
    buildKind: string; entry: {path: string | null; type: string | undefined};
    nextAccepted: boolean;
  } = {
    name: settings.getString('app.name'), retries: settings.getInt('app.retries'),
    enabled: settings.getBoolean('app.enabled'), build: settings.getLong('app.build'),
    timeoutNs: settings.getDuration('timeout'), paths: pathNames,
    appKeys: [...app.keySet()].sort(), buildKind: settings.getNumber('app.build').kind,
    entry: {path: entry.getKey(), type: entry.getValue()?.valueType()},
    nextAccepted: review.accepted
  };
  console.log(JSON.stringify(result));
} catch (error: unknown) {
  if (!(error instanceof ConfigError)) throw error;
  console.log(JSON.stringify({error: error.name, position: error.position}));
  process.exitCode = 2;
}
