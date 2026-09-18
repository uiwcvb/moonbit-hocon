# Validation contract

`./verify.ps1 -MoonPath /absolute/path/to/moon` runs formatting/API generation, deny-warn checks, explicit Wasm-GC and JS public API tests, build/example, compiled browser engine, old CLI contracts, file-host integration, all seven saved reference suites, 72 typed-collection checks and the HTTP/HTTPS/async and tree/validation/document/extended-accessor host suites, 307 bounded malformed inputs and the local example benchmark.

Live independent comparison (Java 11+; the tested host used Java 22.0.1):

```powershell
$env:HOCON_REFERENCE_JAR='C:/path/to/config-1.4.9.jar'
node tools/test-config-reference.mjs
node tools/test-file-reference.mjs
node tools/test-collections.mjs
node tools/benchmark-collections.mjs
node tools/test-http-reference.mjs
node tools/benchmark-http.mjs
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

`benchmark-collections.mjs` uses five fresh processes per variant, alternating order, 30 warmup executions and 15 samples of three executions per process. It compares the fixed 0.4 commit, current engine and unmodified Java library; every process output is compared. The measured boundary includes request JSON decoding, HOCON parse/resolve/getter and response JSON rendering, excludes startup and disk I/O, and does not establish steady-load or peak-memory parity. Four existing workload ratios to 0.4 are 0.977–1.019; seven current/upstream ratios are 0.520–1.094. Raw samples are in `evidence/collection-performance.json`. High-collision tree bins and retained map capacity after deletions are not reproduced; this 0.5 snapshot lacked Unicode numeric-key conversion, subsequently covered for the pinned JDK in 0.9.

## 0.6 network and JSON evidence

`test-http-reference.mjs` runs a separate real HTTP/HTTPS fixture server and compares live unmodified Lightbend Config 1.4.9. Java/keytool are needed only for fresh independent results; set `KEYTOOL` when the JDK keytool is not on PATH. Saved replay still makes real network requests and verifies certificate trust. The public fixture certificate/key are test-only and expire in 2036. The Windows root-relative URL include vector is explicitly skipped by golden replay on other platforms; it requires a fresh native run there, and is never counted as passed.

The matrix includes status codes, optional/required failures, content type/extension/Accept, request order, source origin across redirects, exact redirect limits, cycles, timeout/connection errors, chunked bodies, object roots and JSON BOM/Unicode-space/duplicate-key semantics. `generate-http-json-tests.mjs` carries 22 saved independent JSON-source results into both MoonBit backends. `test-http-host.mjs` checks real sync/async/CLI flows, trusted/untrusted TLS, strict UTF-8 and partial-body refusal, deadlines, actual request counts, total bytes, bounded queues, cancellation reasons, concurrent loads and process exit with idle workers.

`evidence/http-upgrade.json` is the historical 0.6 manifest; 0.5 collection and 0.4 configuration manifests remain historical. `check-http-generation.py /absolute/path/to/moon` regenerates both independent test files, formatting, interfaces and the compiled engine and requires byte stability. `check-http-proof.py --index` checks the staged release fingerprint.

The HTTP performance harness uses five processes per variant and loopback-only fixtures. Synchronous variants use 30 warmup executions and 15 samples of three calls per process; async uses three warmups and seven single-call samples through the reusable worker pool. It compares two old local workloads against the fixed 0.5 commit and four network workloads against the native library. Raw process variation is retained; noisy ratios do not establish performance parity. WAN latency, long-running memory, production load and other platforms remain unverified.

The completed 0.6 verifier passed 1,347 tests on each backend, all 2,228 saved reference cases and the existing host/robustness checks. Fresh live independent runs cover 714 configuration, 58 file, 1,300 collection and 156 HTTP cases. Host suites contain 72 collection and 58 HTTP/async/CLI checks. The final five-process campaign reports current/native ratios 0.852–1.180 for network workloads and current/0.5 ratios 0.995 and 1.149 for local workloads. Several current network process-median spreads exceed 2, so `unstableMeasurements` is true and `performanceParityEstablished` is false. Warm async medians are 2.106 ms and 5.632 ms; these loopback observations are not stable performance guarantees.

## 0.7 tree and validation evidence

`node tools/test-tree-reference.mjs` runs 4,380 independently authored cases against the pinned, unmodified JAR. It compares exact resolved outputs/acceptance, and the sorted multiset of validation path/kind (including duplicate restrictions). Diagnostic message wording, origins and enumeration order are not asserted. Matrices cover path vs literal key edits, scalar replacement, nulls, empty parents, object/list validation, numeric-index conversion, Unicode path rendering and chained operations. `generate-tree-tests.mjs` translates saved native results into public API tests on both backends. Three additional groups check deep detachment, typed validation exceptions, unresolved input and cycle/resource rejection.

`PathCharacters.java` is an original JDK Character adapter, not copied upstream code. `generate-path-characters.mjs --live` captures BMP letter/digit ranges from the tested JDK 22.0.1; without --live it regenerates the checked-in table from saved data. Native entry-set tests cover every range boundary and neighbor. Other JDK Unicode versions remain a compatibility boundary.

`test-tree-host.mjs` checks 39 real sync/async string/file and CLI flows, option validation, exact long transport, preserved structured errors, ordering and reference-file includes. Both saved native replay and host tests are mandatory in verify/CI. The 0.7 full verifier count was 5,730 per backend; the total live reference count is 6,608 (714 config + 58 file + 1,300 collection + 156 HTTP + 4,380 tree).

`benchmark-tree.mjs` compares two old loads to the fixed 0.6 commit and five new workloads to native Java, using five processes, 30 warmups and 15 samples of three requests. Request JSON decoding, parse/resolve/edit/validation and response rendering are included; process startup, I/O, sustained load and memory peaks are excluded. Every process result must match. Independent process spreads are retained, and full performance parity remains unproven.

`evidence/tree-upgrade.json` is the 0.7 manifest; earlier manifests and performance campaigns remain historical. Generation and proof checks use `check-tree-generation.py /absolute/path/to/moon` and `check-tree-proof.py --index`.

Final 0.7 five-process ratios: new workloads/current-native 0.416–0.722; existing/current-0.6 1.027 and 1.052 (about 2.7% and 5.2% slower). No process-median max/min spread exceeds 2 in this campaign. Raw samples are retained; no full performance parity is claimed.


## 0.8 unresolved document lifecycle evidence

`test-document-reference.mjs` compares 2,520 independent lifecycle sequences against the unmodified Config 1.4.9 JAR. Every initial/intermediate/final state compares `isResolved`, the resolved root (when available), and required-value probes via native `getValue(...).unwrapped()`. The matrix covers raw parsing and concatenation, path/literal-key edits, fallback, missing/optional/environment/list-environment references, self/history/cycles, `allowUnresolved`, external `resolveWith` and repeated partial continuation. Reference process environment is explicitly populated for the list-environment cases, which cannot be emulated by the scalar resolver callback alone.

`generate-document-tests.mjs` turns saved native results into public MoonBit tests for both JS and Wasm-GC. Eight further public regressions exercise independently parsed node-ID collisions, deep detachment, raw strict getters/validation, cycle rejection, self identity, delayed known fields and bounded caller-created cyclic data. The original raw graphs remain unchanged by resolution. Comparisons do not establish native delayed ConfigObject container return behavior, retained sharing identity across derived trees, unresolved rendering, source/comment fidelity or exception type/message equivalence.

`test-document-host.mjs` exercises 45 sync/async string, file/include, HTTP/HTTPS, source-stage include, CLI, rejection and limit checks. It checks actual request counts to ensure the root source and include are loaded once per pipeline, not reparsed from changing external files each time resolution continues. The saved replay and host suite are mandatory in verify/CI.

Fresh runs: `node tools/test-document-reference.mjs`, `node tools/test-document-host.mjs`, and `node tools/benchmark-document.mjs` (same `HOCON_REFERENCE_JAR` as above). The performance harness uses five fresh processes per variant and verifies every result, compares two existing loads against the fixed 0.7 commit, and five raw/partial/external/staged lifecycle workloads against native Java. It retains 30 warmups and 15 samples of three executions, excludes startup/I/O/memory/sustained load and does not establish complete performance parity.

`evidence/document-upgrade.json` is the 0.8 manifest. All earlier upgrade/performance manifests remain historical. `check-document-generation.py /absolute/path/to/moon` regenerates independent tests, paths, API, formatting and engine and requires byte stability. `check-document-proof.py --index` checks staged Git blob hashes. Live source fingerprints are refreshed only after the final source/API/engine is fixed.

Final 0.8 validation: 8,258 tests per backend, 9,128/9,128 live native cases across six suites, 45 new lifecycle host checks, all earlier mandatory checks, and 81 regenerated/source files unchanged. Five-process new/current-native ratios are 0.435–0.556; two old/current-0.7 ratios are 0.999 and 0.997. No process-median max/min spread exceeds 2 in this campaign. These bounded results do not establish complete performance parity.


## 0.9 extended getter and numeric-source evidence

`test-accessor-reference.mjs` runs 3,562 independently authored cases against Config 1.4.9. It compares Number's Integer/Long/Double subtype, exact integer strings, canonical IEEE-754 bits (including signed zero, infinities and NaN), object/any/enum scalar and list reads, missing/null/error cases, quoted paths, resolved substitutions/includes/fallback/environment, numeric-index objects and all 37 JDK 22.0.1 BMP decimal digit blocks with adjacent non-digit boundaries. JSON syntax is explicitly selected in the oracle and engine for JSON numeric overflow/exponent cases. Native enum tests use an actual Java enum; MoonBit's generic API maps exact names to caller-defined values instead of Java reflection.

`generate-accessor-tests.mjs` carries independent native expectations into both MoonBit backends. Seven extra public regressions cover generic enum return types, object/value deep isolation, unresolved unwrap rejection, source-mode overflow distinctions, nested JSON numeric spelling/order and UTF-16 digit semantics. `NumericCharacters.java` is an original data adapter that exhaustively scans BMP `Character.digit(char,10)` and validates contiguous 0-9 blocks; `generate-numeric-characters.mjs --live` records the JDK version. This closes the fixed-JDK digit conversion gap, not cross-JDK Unicode or high-collision/retained-capacity map iteration.

`test-accessor-host.mjs` verifies each getter through real CLI file/stdin and async file includes, exact numeric transport, choice validation/limits, JSON mode, Unicode indices and HTTP/HTTPS worker boundaries. Mandatory verify and CI include both new reference replay and host checks. No new browser UI or Java-compatible ConfigObject identity is claimed.

`benchmark-accessor.mjs` compares two old loads with the fixed 0.8 commit and six extended-getter workloads with native Java. It keeps five fresh processes, 30 warmups and 15 samples of three calls; every process result must match. The boundary is JSON request to rendered result; startup, I/O, peak memory, long-running and cross-platform performance remain outside the measurement.

Fresh commands are `node tools/test-accessor-reference.mjs`, `node tools/test-accessor-host.mjs`, `node tools/benchmark-accessor.mjs`, `python tools/check-accessor-generation.py /absolute/path/to/moon`, and `python tools/check-accessor-proof.py --index`. The 0.9 manifest is `evidence/accessor-upgrade.json`; previous manifests remain historical.

Final 0.9 verification: 11,827 tests on each backend, 12,690/12,690 live native comparisons over seven suites, 55 new host checks and all earlier gates, 94 generated/source files unchanged. Final five-process new/current-native ratios are 0.372-0.907; old/current-0.8 ratios are 1.057 and 1.048 (about 5.7% and 4.8% slower). The maximum process-median spread is 2.636; unstableMeasurements is true and complete performance parity remains unproven. Development reports accessor-performance-initial.json, accessor-performance-ascii.json and accessor-performance-enum.json retain the earlier engines' results; they are not the final performance fingerprint.
