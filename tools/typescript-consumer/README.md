# TypeScript consumer of the Node ESM facade

The supported source entry is `tools/config.mjs`; its adjacent `config.d.mts`
describes the existing exports. In a Node TypeScript project, use NodeNext module
resolution, Node types, and the explicit `.mjs` import path:

~~~typescript
import {Config, ConfigError} from './tools/config.mjs';
const settings: Config = await Config.loadFileAsync('application.conf');
const build: string = settings.getLong('app.build');
const enabled: boolean = settings.getBoolean('app.enabled');
~~~

The declaration covers the Config/Value/Object/List views, detached entries and
entry sets, sync and async factories, host options, review reports, and ConfigError.
Long, byte sizes and fixed durations return decimal strings. Double reads may
also return the explicit strings `NaN`, `Infinity`, or `-Infinity`. A literal
object lookup returns `ConfigValue | null`; object/list mutation methods that
always throw are omitted. The detached entry set remains mutable. Worker factory
options accept AbortSignal but cannot carry an onRead function.

Dynamic `get` and legacy `load`/document results are `unknown`: these declarations
do not infer configuration schemas or validate wire operations. Parsing, value
validation, ranges, and runtime exceptions retain their existing contracts.
Only the public config facade has declarations, not internal tools or example
applications. This is source consumption, not an npm or Mooncakes publication.

From the source root, using Node 24, run the pinned compatibility check:

~~~sh
npm ci --prefix tools/typescript-consumer --ignore-scripts --no-audit --no-fund
node tools/test-typescript-consumer.mjs
~~~

The test uses TypeScript 5.9.3 and @types/node 24.0.0 as isolated development
dependencies; neither is needed at application runtime. It compiles a separate
strict NodeNext `.mts` application with noEmitOnError and exact optional property
types, then executes the emitted `.mjs`. Real file success and located parse
failure are checked in both synchronous and Worker modes against complete,
manually specified output. Another source must reject four actual API misuses
with the full expected diagnostics and emit no JavaScript. Generated source
copies, compiler output, raw streams, numeric exit codes/signals and file hashes
remain under `output/typescript-consumer/`. Existing successful runs are retained.

The declaration follows TypeScript's documented
[extension substitution](https://www.typescriptlang.org/docs/handbook/modules/reference.html#file-extension-substitution).
MoonBit's official [JS integration overview](https://www.moonbitlang.com/pearls/moonbit-jsffi)
also describes declaration files for TypeScript integration; generated MoonBit
engine declarations alone do not describe this manually written host facade.
