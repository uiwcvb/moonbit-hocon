# Literal keys and HOCON path expressions

Node applications can import `joinPath` and `splitPath` from `tools/config.mjs`.
They use the existing MoonBit `join_path`/`split_path` core, without a second path
parser in JavaScript. The adjacent declaration accepts readonly string arrays for
joining and returns detached string arrays when splitting.

~~~javascript
import {Config, joinPath, splitPath} from './tools/config.mjs';
const settings = Config.load('service."a.b".port=9000');
const path = joinPath(['service', 'a.b', 'port']);
// path is service."a.b".port; the literal key a.b stays one segment.
const port = settings.getInt(path);
const keys = splitPath(path); // ['service', 'a.b', 'port']
~~~

The functions bridge a concrete API boundary: change-review reports and plans
use literal key arrays, while Config getters and edits use HOCON path syntax.
Joining with a plain period would address a different nested value for dotted
keys. Empty keys, quotes, backslashes and Unicode also retain their literal
meaning. These utilities convert HOCON paths, not filesystem paths or JSON
Pointers. Lightbend documents the same distinction in
[ConfigUtil](https://lightbend.github.io/config/latest/api/com/typesafe/config/ConfigUtil.html).
No new syntax or ecosystem-uniqueness claim is made.

Existing core limits remain: 1–32 segments and a path expression of at most
100000 UTF-16 units. Empty arrays, invalid syntax and core budget failures throw
the shared ConfigError; existing core positions are preserved when available.
Unquoted empty components are invalid, while a quoted empty key is valid.
Wrong JavaScript argument shapes throw TypeError. Conversion does not validate
whether the resulting path exists or whether a migration is safe.

The independent consumer reads real before/after files, approves exact changes
under a dotted literal key, converts report/plan keys into getter paths, checks
the unchanged nested decoy, rejects a policy aimed at that decoy, and continues
reading after invalid-path failures. Full hand-written expectations cover six
canonical expressions, five core grammar/budget errors, three untyped JS argument
errors and two rejected TypeScript calls. The actual strict-compiled ESM runs
against the product facade and engine; input, compiler output, raw process
streams, real exit codes/signals and consumed file hashes are retained under
`output/path-utilities/`.

With Node24 and the existing isolated development dependencies:

~~~sh
npm ci --prefix tools/typescript-consumer --ignore-scripts --no-audit --no-fund
node tools/test-path-utilities.mjs
~~~

The source engine must include the path bridge; build it using [TOOLCHAIN](TOOLCHAIN.md)
when consuming an edited source tree. The test does not regenerate old core path
references or claim complete Java ConfigUtil compatibility, HTTP coverage,
package publication, or external application adoption.
