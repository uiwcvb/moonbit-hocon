# Cold standalone MoonBit transition consumer

This application module consumes the public `uiwcvb/hocon` package without the
Node bridge or library test hooks. It decodes a JSON rollout request, parses the
active and candidate configuration, constructs a typed transition plan, and
selects the candidate only when review accepts it. On rejection or a located
candidate parse error, its observable active ports remain the baseline ports.
It serializes the public review/diagnostic through `ToJson` in the new module,
emits explicit JSON nulls for absent top-level wire fields, and also checks the old
path-only review's default behavior.

Run with the [pinned toolchain](../../TOOLCHAIN.md) and Node 24:

```sh
node tools/test-transition-consumer.mjs
```

The runner creates a different fresh workspace for JS and Wasm-GC. Each contains
two distinct modules: a production-source-only copy of the library, and the
application from `app/`. No product `_build`, `.mooncakes`, library test files,
`cmd/web` or `web/engine.mjs` enter that copy. The compiler and its standard
library bundles are reused; this is cold product/module integration, not a
claim of reinstalling the SDK or of testing an uncached registry download.

For a new application using current GitHub source, use a local workspace:

```text
work/
  moon.work       # members = ["hocon", "app"]
  hocon/moon.mod  # this repository's source
  app/moon.mod    # import { "uiwcvb/hocon@0.25.0" }
  app/moon.pkg    # import { "uiwcvb/hocon", ... }
  app/main.mbt
```

In `moon.work`, the local module supplies that import; its version is not fetched
from Mooncakes. See the [official local dependency configuration](https://docs.moonbitlang.com/en/latest/toolchain/moon/module.html#dependency-management).
This repository retains `0.25.0` metadata and has not republished the added
transition API to Mooncakes. A plain registry dependency does not establish that
the installed code contains the current GitHub additions.

`cases.mjs` contains hand-authored full JSON expectations for six requests:
acceptance, wrong target, stale baseline, missing indirect permission, an unused
transition with the legacy default still accepted, and a source-counted located
parse error. The driver compares every field, including selected active values,
mismatch sides and diagnostics. Only ordering of the report's set-like arrays
is ignored; path segment order and values remain exact. The oracle is recorded
before compilation and is not obtained from the library/Node bridge.

Reports under `output/transition-consumer/` include compiler identity, source
hashes, cold workspace assertions, compiled JS/Wasm hashes, every request/result,
and complete stdout/stderr, including failures. CI retains these reports in
`quality-evidence`. Workspaces are retained for diagnosis; set
`HOCON_CONSUMER_CACHE` to a project-owned cache when needed. CI uses its own runner
temporary directory.

The application is an acceptance fixture for a valid active baseline and the
declared port rollout protocol. It is not a generic schema validator, listener,
atomic deployment/rollback system, published package verification, or evidence
of external adoption. Existing library APIs and defaults are unchanged.
