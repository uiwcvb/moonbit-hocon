# Explicit ConfigError snapshots for JSON consumers

`ConfigError.toDiagnostic()` returns a plain detached snapshot with name/message
and, when present, source position and validation problems. It is useful when a
Node application hands an error to a JSON logger or a local error-view process:

~~~javascript
import {Config, ConfigError} from './tools/config.mjs';
try { Config.loadFile('application.conf'); }
catch (error) {
  if (!(error instanceof ConfigError)) throw error;
  console.log(JSON.stringify(error.toDiagnostic()));
}
~~~

The public TypeScript return type is `ConfigDiagnostic`. Position and problem
objects/arrays are copied, so a view can format its snapshot without changing the
original exception. Undefined optional metadata is omitted; an explicitly empty
problems array stays present. There is no toJSON hook: JSON.stringify(error),
instanceof ConfigError, message/stack access, existing CLI output and exception
construction retain their previous behavior. Callers explicitly select the new
snapshot when they want a metadata transport value.

The snapshot contains only name, message, source/offset/line/column and each
problem's path/kind/expected/actual. It does not include stack, cause or arbitrary
custom fields. Error messages and source metadata are preserved as provided;
this method does not redact content or decide which recipient should receive it.

This fills a host integration gap rather than changing parser diagnostics or
claiming a Node Error bug. Native Error's message is non-enumerable, and ordinary
JSON serialization does not promise an error transport schema. The library
already supplies structured positions and validation failures; the explicit
snapshot makes those existing fields convenient to consume together. See
[Node's Error documentation](https://nodejs.org/api/errors.html#errorMessage).

The real consumer generates synchronous and Worker file errors, a missing-field
validation error, a metadata-free manual error and an explicit empty-problems
error. It mutates one view snapshot, verifies the original exception is unchanged,
and emits five complete independently expected JSON records. A separate process
reads the actual captured log bytes and renders a full diagnostic summary. Input,
strict-compiled producer, received log, complete streams, real exit/signal and
source/engine hashes are retained under `output/error-diagnostics/`.

With Node24 and the existing fixed development dependencies:

~~~sh
npm ci --prefix tools/typescript-consumer --ignore-scripts --no-audit --no-fund
node tools/test-error-diagnostics.mjs
~~~

The method does not create new source positions, change validation semantics,
serialize every JavaScript Error field or prove an external system adopted it.
