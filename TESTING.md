# Validation contract

`./verify.ps1 -MoonPath /absolute/path/to/moon` runs formatting/API generation, deny-warn checks, explicit Wasm-GC and JS public API tests, build/example, compiled browser engine, old CLI contracts, file-host integration, all three saved reference suites and 72 typed-collection host/CLI checks, 307 bounded malformed inputs and the local example benchmark.

Live independent comparison (Java 11+; the tested host used Java 22.0.1):

```powershell
$env:HOCON_REFERENCE_JAR='C:/path/to/config-1.4.9.jar'
node tools/test-config-reference.mjs
node tools/test-file-reference.mjs
node tools/test-collections.mjs
node tools/benchmark-collections.mjs
```

`tools/HoconOracle.java` is an original JSON-lines adapter around the unmodified upstream JAR. The adapter calls parseString/parseFile/withFallback/resolve and official getters. All source fixtures and matrices were independently authored. The upstream binary is neither copied into production nor redistributed here.

The configuration suite compares acceptance and typed results, with explicit environment/fallback/include inputs; long/duration/bytes/memory results are decimal strings and non-finite double results use strings. Failures retain both results. The file suite creates real UTF-8 trees and compares native relative includes, extension search, explicit file/classpath/file-URL, properties, JSON, cycles, missing/required errors and fallback origins. Temporary trees are removed after the run. Absolute temporary paths are not used in portable golden cases.

Use `--golden` to replay saved official results without Java. Golden replay writes `*-replay.json` and does not overwrite live `*-validation.json`. CI rebuilds the engine before replay. A green replay proves consistency with saved vectors, not that a live upstream program ran in CI.

Reports contain source/API/engine/adapter/test SHA256 values. `evidence/config-upgrade.json` records the completed local verification and final source/evidence fingerprint. `evidence/collection-upgrade.json` supersedes the 0.4 manifest for 0.5. Historical `typed-reference-validation.json` and old current-validation reports retain their original dates and are superseded for 0.4.

Public regressions cover history, three-layer fallback barriers, include relocation, explicit environment/list environment, lexical paths/triple quotes, precise long/memory units, Java float coercion, source-loader contracts and lexical locations. File-host integration checks actual CLI exit status, fallback origins, environment opt-in, duration getter, invalid UTF-8, missing resources and depth/size limits.

Robustness uses a deterministic 307-input worker with a 20-second bound. The local benchmark uses 5 warmups and 30 executions, reports Node/CPU/median/p95, and does not compare upstream performance. Coverage, if requested, can be measured locally with `moon coverage analyze -p localreview/hocon -- -f summary`.

Remote CI, broad platform/version support, full upstream conformance and production performance remain unverified. No upload or publication is configured or performed by this validation.

## 0.5 collection evidence

The ten new getters add 1,300 live independent Lightbend 1.4.9 cases: type/null/missing/mixed lists, number bounds, exact units, quoted paths, non-finite double transport, numeric-index aliases, hash growth and fallback ordering. `generate-collection-tests.mjs` translates the saved official results into public-API tests for both JS and Wasm-GC; expected values never come from this implementation. Each backend runs 1,323 tests including the 23 existing groups. Golden replay is mandatory in verify and CI. Error classes/messages are not compared.

`test-collection-host.mjs` checks 72 actual Node/CLI operations across direct input, UTF-8 stdin, relative include files, quoted paths and error exit codes. The compiled bridge is tested; a new interactive browser UI was not introduced or claimed.

`benchmark-collections.mjs` uses five fresh processes per variant, alternating order, 30 warmup executions and 15 samples of three executions per process. It compares the fixed 0.4 commit, current engine and unmodified Java library; every process output is compared. The measured boundary includes request JSON decoding, HOCON parse/resolve/getter and response JSON rendering, excludes startup and disk I/O, and does not establish steady-load or peak-memory parity. Four existing workload ratios to 0.4 are 0.977–1.019; seven current/upstream ratios are 0.520–1.094. Raw samples are in `evidence/collection-performance.json`. High-collision tree bins and retained map capacity after deletions are not reproduced; complete Unicode numeric-key conversion remains missing.
