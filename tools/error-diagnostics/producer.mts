import {Config, ConfigError, type ConfigDiagnostic} from './product/tools/config.mjs';
const file = process.argv[2];
if (!file) throw new Error('broken configuration filename required');
async function capture(stage: string, operation: () => unknown | Promise<unknown>): Promise<void> {
  try {await operation(); throw new Error('expected ConfigError: ' + stage);}
  catch (error: unknown) {
    if (!(error instanceof ConfigError)) throw error;
    const original = JSON.stringify(error);
    const formatted: ConfigDiagnostic = error.toDiagnostic();
    if (formatted.position) formatted.position.source = 'local-view-only';
    if (formatted.problems?.length) formatted.problems[0].path = 'local-view-only';
    if (JSON.stringify(error) !== original) throw new Error('diagnostic snapshot changed original exception');
    const diagnostic: ConfigDiagnostic = error.toDiagnostic();
    process.stdout.write(JSON.stringify({stage, diagnostic}) + '\n');
  }
}
await capture('sync-file', () => Config.loadFile(file));
await capture('async-file', () => Config.loadFileAsync(file));
await capture('validation', () => Config.load('existing=1').checkValid(Config.load('required=1')));
await capture('manual', () => {throw new ConfigError({error: 'manual Ω😀'});});
await capture('empty-problems', () => {throw new ConfigError({error: 'empty problems', problems: []});});
