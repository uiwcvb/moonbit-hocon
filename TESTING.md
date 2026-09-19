# Validation contract

`./verify.ps1 -MoonPath /absolute/path/to/moon` runs formatting/API generation, deny-warn checks, explicit Wasm-GC and JS public API tests, build/example, compiled browser engine, old CLI contracts, file-host integration, all saved reference suites, 72 typed-collection checks and the HTTP/HTTPS/async and tree/validation/document/extended-accessor host suites, 307 bounded malformed inputs and the local example benchmark.

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


## 0.10 calendar periods and duration units

`test-temporal-reference.mjs` compares 2,171 independent requests with unmodified Lightbend Config 1.4.9. Cases cover period unit spellings/case, calendar fields, Int32/week multiplication boundaries, duration-first TemporalAmount selection, all seven TimeUnit scalar and list conversions, legacy millisecond/nanosecond aliases, signed truncation, Int64 saturation including values adjacent to every unit multiplier threshold, numeric versus string list semantics, all 37 fixed-JDK BMP digit blocks, Unicode whitespace, paths, includes, fallback and environment. Acceptance and typed values are compared; exact Java exception classes/messages/origins remain outside this contract.

`generate-temporal-tests.mjs` carries native expectations to both MoonBit backends. Three public API regressions verify period fields/TemporalAmount variants, direct millisecond-list conversion, and reading known raw values without resolving unrelated substitutions. `test-temporal-host.mjs` provides 57 real file/include, sync/async, CLI file/stdin, invalid-option/error-code and HTTP/HTTPS checks. Both suites are mandatory in verify/CI.

`benchmark-temporal.mjs` compares two old loads with fixed 0.9 commit b35035a and six new period/temporal/list loads against native Java. Five fresh processes per variant, 30 warmups, 15 samples of three calls and per-process result equality are retained. JSON request decoding through JSON response rendering is measured; startup, I/O, memory, sustained load and cross-platform behavior are not measured.

Fresh commands: `node tools/test-temporal-reference.mjs`, `node tools/test-temporal-host.mjs`, `node tools/benchmark-temporal.mjs`, `python tools/check-temporal-generation.py /absolute/path/to/moon`, and `python tools/check-temporal-proof.py --index`. The 0.10 manifest is `evidence/temporal-upgrade.json`; earlier manifests and reports are historical.

The first temporal timing campaign is retained in `evidence/temporal-performance-initial.json`. It exposed allocation overhead in integer duration conversion; the final implementation checks Int64 multiplication bounds directly, then multiplies or saturates. Native boundary cases cover the threshold and its neighbors in both directions. The final fingerprint is `evidence/temporal-performance.json`.

Final 0.10 verification: 14,001 tests on each backend, 14,861/14,861 live native comparisons across eight suites, 57 new host checks and all earlier mandatory gates; 104 generated/source files unchanged. Final five-process new/current-native ratios are 0.271-1.267, old/current-0.9 ratios 1.007 and 1.021. The large-millisecond-list load remains about 26.7% slower than native. The maximum process-median spread is 1.783; unstableMeasurements is false. Full performance parity remains unproven.


## 0.11 persistent immutable JavaScript Config

`test-persistent-reference.mjs` compares 842 independently authored programs with the unmodified Config 1.4.9 JAR. The Java adapter retains actual Config objects; every program compares reads, intermediate operations and all final parent/child states. Cases cover raw/resolved factories, typed getters, immutable branches, child/list views, self/external resolution, fallback/value transfer, validation, a 160-step chain and 204 wrapped history/lookback programs. Acceptance and values are compared, not exact exception classes/messages, origins or Java sharing identity. Native output lines are saved directly so negative-zero literals survive replay.

`test-persistent-async.mjs` replays all 842 native expectations through four concurrent worker factories. Its bounded tagged-tree transfer reconstructs every MoonBit Value variant, including raw binding/reference identities and exact numeric text. `generate-persistent-core-tests.mjs` generates 242 public raw-child/wrapped-resolution cases for both MoonBit backends; one further public regression verifies deep isolation of mutable core get_config results.

`test-persistent-host.mjs` has 54 checks for file/include and HTTPS factories, source deletion/server shutdown after construction, result/input/branch isolation, a 1000-edit chain, raw child transfer, Int64/signed-zero transport, environment snapshots, shared ConfigError/structured diagnostics, invalid options/transfer inputs, cancellation and worker reuse. `test-persistent-memory.mjs` checks collection of 2400 released instances with explicit V8 GC and a retained readable control. This bounded check does not establish peak-memory, long-running or native memory parity. All four suites are mandatory in verify/CI.

`benchmark-persistent.mjs` measures two old JSON-request workloads against fixed 0.10 commit a469b59 and six retained-object workloads against native Config. Construction is outside the latter timers; typed getter transport and immutable operations are included; final result serialization is outside. Five fresh processes per workload, 30 warmups and 15 samples of three calls are retained. Java legacy and retained workloads run in separate processes. Every process result must match. Startup, I/O, sustained load, peak memory and cross-platform performance are not measured.

The first timing campaign is retained as `evidence/persistent-performance-initial.json`. It exposed repeated request JSON parsing, child copying and constructor/environment overhead. The final bridge accepts getter fields directly, passes child paths directly, shares opaque read-only child nodes and frozen environment snapshots, and keeps defensive copies for public mutable MoonBit values. Final timings belong in `evidence/persistent-performance.json`.

Fresh commands: `node tools/test-persistent-reference.mjs` (with HOCON_REFERENCE_JAR), `node tools/test-persistent-async.mjs`, `node tools/test-persistent-host.mjs`, `node tools/test-persistent-memory.mjs`, `node tools/benchmark-persistent.mjs`, `python tools/check-persistent-generation.py /absolute/path/to/moon`, and `python tools/check-persistent-proof.py --index`. The 0.11 manifest is `evidence/persistent-upgrade.json`; previous manifests remain historical.


Final 0.11 verification: 14,244 tests per backend, 15,703/15,703 live native comparisons over nine suites, 842 async native programs, 54 new host checks and all existing gates; 123 generated/source files unchanged. The bounded GC check observed 2399/2400 instances collected and 766344 bytes maximum retained heap growth. Five-process retained/current-native ratios are 1.003-8.576; old/current-0.10 ratios 0.986 and 0.978. Maximum process-median spread is 1.415; unstableMeasurements is false. Per-workload results remain in the report; complete performance parity is not established. `persistent-performance-initial.json` and `persistent-performance-read-fields.json` retain earlier development engines, not the final fingerprint.


## 0.12 direct result transport and API path parsing

The Config wrapper now receives ordinary JS results directly from MoonBit. The bridge constructs fresh arrays and own data properties without relying on generated union layouts or round-tripping a success envelope through JSON text. Getter dispatch remains shared with the legacy JSON bridge. Finite doubles retain signed zero; exact integer strings, Number tags/bits, nonfinite strings and shared structured ConfigError behavior are preserved.

PathOracle.java is an independently authored adapter around native ConfigUtil.splitPath. The test-path-reference.mjs suite compares 1,898 cases covering every ASCII character in several positions, Unicode whitespace/letters, quoted/concatenated/empty components, comments, numeric spellings, randomized ordinary names and depths 1–32. New native evidence found 31 differences in the initial implementation, retained in path-reference-initial.json: API comments were being silently ignored and simple paths surrounded by newlines were rejected. The corrected core rejects unquoted comments only in API paths and preserves the reference's conditional whitespace behavior. Exact native exception diagnostics and beyond-budget inputs remain excluded.

The generate-path-tests.mjs generator carries all 1,898 native results into public JS/Wasm-GC tests. One further public group verifies depth/length limits, returned-array independence and continued support for configuration-source comments. The test-native-read-host.mjs suite supplies 24 sync/async ownership, property-descriptor/prototype-key, inherited-setter, numeric transport, structured-error, malformed-option and UTF-16/path checks. Both suites are mandatory in verify/CI.

The benchmark-native-read.mjs harness compares current code, the complete JS module dependency tree from fixed 0.11 commit 0cddd1f, and native Config 1.4.9. It measures two existing JSON-request loads and eight retained-object loads, including new dotted/quoted paths. Five fresh processes per workload, 30 warmups and 15 samples of three executions are retained; every process result must match. Construction and final output serialization are outside retained-object timers; getter transport and immutable operations are inside. Startup, I/O, peak memory, sustained load and cross-platform behavior remain unmeasured.

Fresh commands: node tools/test-path-reference.mjs; node tools/test-native-read-host.mjs; node tools/benchmark-native-read.mjs; python tools/check-native-read-generation.py /absolute/path/to/moon; python tools/check-native-read-proof.py --index. Live Java commands use HOCON_REFERENCE_JAR. Final results and release fingerprints are evidence/native-read-performance.json and evidence/native-read-upgrade.json; earlier manifests/reports remain historical.


The direct-result reference suite reuses 7,033 existing collection/accessor/temporal requests through the actual Config.get API, plus 30 root JSON numeric cases. It runs the native JAR again and preserves raw output lines, including signed zero. Its 7,063 comparisons overlap the older suites and are not claimed as newly unique coverage. Generic unwrapped numeric zero follows native source-number compaction; explicit double conversions preserve negative zero. Root JSON uses one native parse of the already budget-checked core rendering, avoiding a second MoonBit JSON parse/render cycle. The first performance campaign is retained as native-read-performance-initial.json; it exposed a regression in immutable-edit output conversion, addressed before final timing.


Final 0.12 verification: 16,143 tests per backend; 17,601/17,601 existing/path live native comparisons and 7,063/7,063 direct-result live comparisons (7,033 overlapping prior requests plus 30 root numeric requests); 24 new host checks and all existing mandatory gates; 135 generated/source files unchanged. Five-process current/native retained ratios are 0.596-3.595; int and child reads use 0.307 and 0.314 of fixed 0.11 time. Immutable edits/current-0.11 is 0.682; two legacy/current-0.11 ratios are 0.899 and 0.953. Maximum process-median spread 1.336, unstableMeasurements=false. Full performance parity remains unproven. Development reports native-read-performance-initial.json and native-read-performance-json-root.json retain earlier code fingerprints. The final root conversion skips per-property zero normalization only when JSON text contains no minus sign; negative literals, including underflow, retain the normalization path.

Pinned implementation consulted for API path behavior: [Lightbend 1.4.9 PathParser](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/PathParser.java). Native expectations come from the unmodified JAR through the original local adapter; upstream implementation/test files are not copied into this repository.


## 0.13 immutable values and containers

Final verification: 16,174 tests per backend; 2,810 new native value/container programs, including 1,827 equality/hash/fallback programs replayed as 29 MoonBit test groups. Another 983 host-container programs remain in the JavaScript comparison; all 2,810 run through asynchronous initial loading too. Two additional public-core isolation groups and 22 host checks pass. The existing 17,601 native comparisons and 7,063 direct-read comparisons pass; the latter overlap 7,033 prior requests and add 30 root-number cases. All required verifier gates pass, and 150 generated/source files remain byte-stable.

The original ValueOracle.java adapter executes the unmodified 1.4.9 JAR. Cases compare type, exact accepted/rejected outcome, unwrapped JSON, equality, signed 32-bit hashes, immutable operations and retained branches. Object values() preserves the pinned implementation's HashSet deduplication and ordinary-bucket behavior. High-collision tree bins, capacity history, exact diagnostics/origins, all shared identities and unresolved rendering are not established. No upstream implementation or test source is copied into this project.

An initial performance validation exposed a genuine object-hash disagreement for varied-length keys. The default MoonBit String ordering is shortlex; the hash now explicitly sorts UTF-16 code units in Java lexical order. New native vectors cover varied-length, supplementary-plane and private-use keys and sizes up to 135 keys. Continued root fallback tests also preserve the native rejection when a delayed object root would be replaced by a non-object resolution source.

Five fresh-process campaigns compare ten existing workloads with fixed 0.12 commit c34c00d1b43f9c4acb16803922823bc2cb6fb680 and native Config, plus five new retained-value workloads with native ConfigValue. Warmup 30 executions, 15 samples of 3 executions; construction and final serialization outside retained timings. All measured outputs agree. New current/native ratios: 3.499–69.916; existing current/0.12 ratios: 0.941–1.052. Maximum process-median spread 1.564; unstableMeasurements=false. List search and object equality remain substantial performance gaps. Peak memory, startup, I/O and sustained production parity are not measured.

Consulted pinned primary sources: [ConfigValue](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/ConfigValue.java), [SimpleConfigObject](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/SimpleConfigObject.java), [ConfigNumber](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigNumber.java), [SubstitutionExpression](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/SubstitutionExpression.java). The native expectations, rather than descriptions of these sources, are the regression oracle.


## 0.14 direct value traversal

`test-value-walk-reference.mjs` adds 906 distinct independently authored programs across 936 matrix runs against the same unmodified 1.4.9 JAR. Cases cover exact numeric identities and floating boundaries, object key-set prechecks, native ordinary-bucket comparison order, directional unresolved errors, early/late/absent list searches through 512 elements, and varied-size objects through 128 keys. Values and acceptance are compared; exact diagnostics, tree bins and retained map-capacity history remain outside coverage.

`generate-value-walk-tests.mjs` translates all 936 native expectations into 15 groups shared by JS and Wasm-GC. Two additional core regressions ensure mutable caller-owned values do not use stale caches and cyclic values are rejected within the operation budget. `test-value-walk-host.mjs` checks eight sync/async immutable ownership, cached hash, raw child/path, directional search, 2048-element list, own-property/zero and opaque-selector contracts. Both saved replay and host checks are mandatory in verify/CI. Existing 2810 value programs and their async replay remain mandatory; the new 936 cases are not claimed as additional async programs.

`benchmark-value-walk.mjs` compares fixed 0.13 commit 1ab3b1af96331cf811b42301e36f55fd9263d443, current code and native Config over 16 workloads in five fresh-process campaigns. The same ten prior workloads are retained. Six value workloads distinguish repeatedly hashing the same immutable wrapper from obtaining a fresh wrapper and computing its first hash; the cache speedup applies only to the former. Every process output is verified; 30 warmups and 15 samples of three calls are retained. Startup, I/O, peak memory and sustained production load are excluded. Development timing is preserved separately as value-walk-performance-initial.json.

Fresh checks use `node tools/test-value-walk-reference.mjs`, `node tools/test-value-walk-host.mjs`, `node tools/benchmark-value-walk.mjs`, `python tools/check-value-walk-generation.py /absolute/path/to/moon` and `python tools/check-value-walk-proof.py --index`. The current manifest is `evidence/value-walk-upgrade.json`; previous manifests remain historical.

Final 0.14 verification: 16,191 tests per backend, all 936 traversal matrix runs across 906 distinct new programs, eight new host checks and all earlier mandatory gates pass. Thirty requests repeat because early/late positions coincide for empty/single-element lists; none of the 906 distinct programs exactly duplicates a prior value program. Thirteen live reference suites total 28,410 comparisons including the documented 7,063 overlapping direct-read comparisons. All 159 generated/source files remain byte-stable. Five-process current/native ratios for value read, fresh-wrapper hash, equality and search are 4.775, 3.249, 9.027, 16.933; cached repeated hash is 0.010. The ten prior workloads/current-0.13 range is 0.919-1.073; maximum process-median spread is 1.795, unstableMeasurements=false. These bounded measurements do not establish complete performance parity.


## 0.15 exact raw-value rendering

`RenderOracle.java` is an original adapter around the unchanged Config 1.4.9 JAR. `test-render-reference.mjs` compares 2,140 complete accepted/rejected outcomes and exact output strings for concise/formatted JSON and HOCON. Inputs cover scalar quotes/control characters and numeric boundaries, 600 deterministic binary64 draws (non-finite samples skipped), decimal exponent edges, numeric/Unicode keys, raw substitution/concatenation/merge history, immutable selection/wrapping/editing, partial resolution and relocated includes. Expected strings come only from Java; implementation round trips are not the oracle. Comments and origins are disabled in these comparisons.

`generate-render-tests.mjs` replays all native programs in 34 groups on both MoonBit backends. Three further public groups cover mutable ownership, cyclic/output limits and retained partial-resolution history. `test-render-async.mjs` replays all 2,140 programs after worker transfer through four concurrent factories. `test-render-host.mjs` has 17 real sync/async string/file/file-URL/HTTP/HTTPS, source-shutdown, raw-state, ownership, options, legacy API and numeric-spelling checks. These suites are mandatory in verify/CI.

The new renderer uses bounded traversal and output emission. Binary64 formatting constructs the exact integer/decimal value and selects the nearest shortest round-tripping decimal with the pinned JDK's minimum scientific precision; tests include signed zero, infinities, subnormals and exponent notation. This is an independently written implementation. A discovered partial-resolution mismatch is fixed in the resolver rather than hidden by formatting: adjacent concrete objects above an unknown fallback consolidate after resolution.

`benchmark-render.mjs` retains sixteen existing workloads against fixed 0.14 commit c09f48e1e66f1d130be39752d92ae33f5447b244 and native Config, and adds six rendering workloads against native ConfigValue. Render construction/partial resolution and final result-array serialization are outside timing; rendering and returned strings are inside. Five fresh-process campaigns, 30 warmups and 15 samples of three operations are preserved; every output must match. Memory, I/O, startup and sustained/cross-platform production parity remain outside coverage.

Use `python tools/check-render-generation.py /absolute/path/to/moon` for byte-stable regeneration and `python tools/check-render-proof.py --index` for staged release hashes. The current manifest is `evidence/render-upgrade.json`. Origin/user-comment metadata, native verbose default rendering, environment-origin masking, complete identities/diagnostics and full API/performance parity remain open.

Pinned primary API and semantics consulted: [ConfigRenderOptions](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/ConfigRenderOptions.java), [SimpleConfigObject](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/SimpleConfigObject.java), [ConfigString](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigString.java) and [ConfigDelayedMerge](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigDelayedMerge.java). Native implementation and test sources are not copied into the project.

Resolved unquoted-string cases exposed lost quoting provenance: the resolver had converted every Bare to Text. It now preserves Bare, matching native HOCON output. A former direct enum expectation is updated for this documented representation change, while new public checks require identical typed string access and semantic equality for Bare/Text.

Final 0.15 verification: 16,228 tests on each backend; 2,140/2,140 exact native rendering programs and async replay; 17 new host checks and all prior mandatory gates; 172 generated/source files remain byte-stable. Fourteen live suites total 30,550 comparisons including previously documented overlapping requests. Six rendering current/native ratios are 1.740-44.265, sixteen prior workloads/current-0.14 ratios are 0.972-1.096. Maximum process-median spread is 2.246; unstableMeasurements=true. These bounded measurements do not establish full performance parity.

## 0.16 primitive binary64 rendering

`DoubleRenderOracle.java` calls the unmodified JDK primitive formatter directly. `node tools/generate-double-render-tests.mjs --live` captures 24,254 distinct signed bit patterns and generates 190 whitebox groups for both backends. These are primitive formatter cases, separate from the 2,140 public Config rendering programs; ConfigNumber can classify integral doubles as Int/Long. The vectors include both signs at every exponent field, decimal-power neighbors, initial subnormals, non-finite patterns and deterministic random bits. This is stratified coverage, not an exhaustive binary64 proof. The pinned native output is JDK 22.0.1; historical JDK formatter versions may differ.

`--check` verifies the checked-in test source against the saved native vectors without changing it and is mandatory in verify/CI. `--live --check` also recaptures the same JDK outputs and fingerprints final sources. The native capture report alone does not claim the implementation passed; backend test results supply that evidence. `check-double-render-generation.py` additionally regenerates all portable suites, formatting, API and JS engine and requires byte stability.

`benchmark-double-render.mjs` measures all previous 22 workloads plus subnormal and decimal-power rendering against fixed 0.15 and native Config in five fresh processes. No rendered strings are cached. Real returned output is compared for every variant/process; parsing is outside retained-value timers. Java retains render options; JS creates the options object inside each call. Full performance and memory parity remains unestablished.

A separate exact-BigInt test proves that the integer interval constant encloses 2^-1074. The native matrix contains every one of the first 2,048 positive and negative subnormals, spanning the specialized branch and its exponent threshold. Initial measurements/verification are retained separately in `double-render-performance-initial.json` and `double-render-verify-initial.log`; final results refer to the final source fingerprint.

Final 0.16 verifier: JS/Wasm-GC each 16,419 passed; 24,254 distinct primitive patterns in 190 groups plus one exact interval-bound proof. All mandatory saved-reference/host/async/resource checks passed. Final-source live Config renderer comparison: 2,140/2,140. 180 source/generated files were byte-stable. Fourteen saved-reference suites replayed 30,550 runs; historical overlap counts remain documented, and these are not claimed as 30,550 fresh live upstream executions.

Final five-process results: ordinary floating rendering takes 0.174761 times fixed 0.15 (82.5% less time), with current/native 7.056862. Subnormal and decimal-power rendering current/0.15 ratios are 0.478432 and 0.596699; current/native 945.942116 and 13.106250. Sixteen existing non-render workloads range 0.917604–1.042453 versus 0.15. Maximum process spread is 2.094398, unstableMeasurements=true. All variant/process outputs match; full performance parity remains false.

`evidence/double-render-upgrade.json` supersedes the 0.15 manifest. Older live suite reports retain their original fingerprints; `double-render-reference-replays.json` contains the fresh mandatory saved-output replay reports. Initial timing and verification remain separately labeled development evidence.

## 0.17 tiny decimal parsing

`DoubleParseOracle.java` independently calls JDK Double.parseDouble and returns canonical bits or rejection. Its Base64 line transport preserves control characters. `generate-double-parse-tests.mjs --live` captures 27,505 unique strings in 215 whitebox groups; `--check` compares generated tokens and literal bytes while ignoring formatting whitespace outside literals/comments. The check is mandatory in verify/CI. `--live --check` recaptures native expectations without overwriting the saved vectors or test source and records final source fingerprints.

The matrix starts with prior JDK formatter output strings, then adds exact decimal midpoints and immediate decimal neighbors, both signs, every early subnormal formatter output, boundary exponent/coefficients, long-coefficient fallback inputs, huge exponents, suffixes, whitespace, malformed decimals and selected hexadecimal inputs. Accepted results are compared by all 64 bits, with canonical NaN. These primitive parser inputs are separate from Config public API cases and do not prove exhaustive parsing compatibility. The tested reference is JDK 22.0.1.

The optimized path applies to decimal magnitudes <= -308 and at most 768 significant coefficient digits; larger coefficients retain the existing runtime converter. It computes N/5^-p times 2^p exactly, locates the binary exponent and rounds the quotient/remainder once at the binary64 spacing, including ties to even and the subnormal/normal transition. Huge exponent cutoffs account for all significant input digits before deciding underflow/overflow. The outer 10,000-character bound, sign/suffix/hexadecimal behavior and diagnostics are preserved.

`benchmark-double-parse.mjs` compares the fixed 0.16 engine and native Config across the prior 24 workloads plus long-coefficient rendering and two retained Double-list reads. List results are encoded to exact bit strings after timing; getter calls/list creation remain inside timing. This does not claim full throughput, memory, startup or platform parity.

Final 0.17 verifier: JS/Wasm-GC each 16,634 passed, including 215 new parser groups; all mandatory saved-reference/host/async/resource checks passed. Final-source live Config comparisons: accessors 3,562/3,562 and rendering 2,140/2,140. 189 source/generated files were byte-stable. Fourteen saved-reference suites replayed 30,550 runs; these are not counted as fresh independent live programs.

Final five-process results: tiny-value rendering and retained tiny-Double-list reads take 0.022187 and 0.025509 times fixed 0.16 (97.8% and 97.4% less time); current/native ratios are 21.277328 and 4.455193. Ordinary Double-list reads/current-0.16 is 1.065590 (measured regression 6.6%), current/native 25.331754; long-coefficient fallback rendering/current-0.16 is 0.969596, current/native 607.936508. Maximum process spread is 2.217391, unstableMeasurements=true. All variant/process outputs match; full performance parity remains false.

`evidence/double-parse-upgrade.json` supersedes the 0.16 manifest. The fresh saved-reference replay reports are consolidated in `double-parse-reference-replays.json`; older live capture reports retain their own fingerprints.

## 0.18 direct numeric scans and long coefficients

The existing primitive parsing matrix now contains 27,851 distinct strings (346 additions to 0.17), in 218 groups. New inputs include long random nonzero suffixes and more exact-midpoint/neighbor extensions. Existing parser and formatter captures are refreshed at final source; native Config accessor/render comparisons and all mandatory saved-native/host checks remain required.

Numeric preprocessing now indexes UTF-16 directly for ASCII trim/sign/suffix checks. It keeps the original NaN conversion and error behavior. ASCII integer candidates reject punctuation immediately; the first non-ASCII character switches to the existing full Unicode digit converter. This preserves the pinned JDK BMP digit rules.

For a long tiny decimal, a kept prefix bounds the exact value between consecutive prefix integers at an adjusted decimal power. Monotonic correctly rounded conversion means identical rounded endpoints prove the full suffix cannot change the result. Try 32 then 768 digits; ambiguous long intervals retain the runtime converter. Prefix trailing zeros are removed before exact rational computation. This does not assume random tails or discard a rounding tie.

`benchmark-numeric-scan.mjs` compares fixed 0.17, current and native Config in five processes over all prior 27 workloads plus long midpoint rendering and quoted long-Double-list reading. The midpoint values are exact 2^-1075 and decimal neighbors 10^-2099 away, exercising conclusive and ambiguous prefix boundaries. Getter/render work remains inside timing and output comparison occurs after timing; no result cache is introduced. Full performance, startup, peak-memory and cross-platform parity remain open.

Development timing before the decimal-token scan change is retained in `numeric-scan-performance-initial.json`; final timing is separately fingerprinted. Decimal token recognition also scans UTF-16 directly, preserving its ASCII-only sign/dot/exponent grammar.

Final 0.18 verifier: JS/Wasm-GC each 16,637 passed; 27,851 primitive parser inputs in 218 groups and all existing mandatory checks passed. Final-source live Config comparisons: accessors 3,562/3,562 and rendering 2,140/2,140. 192 source/generated files were byte-stable. Fourteen saved-reference suites replayed 30,550 runs; historical overlaps remain and these are not claimed as new independent live programs.

Final five-process results: ordinary Double-list reads and long-tiny rendering take 0.786934 and 0.037540 times fixed 0.17 (21.3% and 96.2% less time), with current/native ratios 20.349515 and 18.625000. Long-midpoint rendering and long quoted-Double-list reads/current-0.17 are 0.321857 and 0.320848; current/native 501.844720 and 7.978477. Legacy parse-64/current-0.17 is 1.025773. Maximum process spread is 2.465961, unstableMeasurements=true. All variant/process outputs match; full performance parity remains false.

`evidence/numeric-scan-upgrade.json` supersedes the 0.17 manifest; final saved-reference replays are consolidated in `numeric-scan-reference-replays.json`. Prior manifests and separately named development performance remain historical evidence.

## 0.19 typed configuration entry sets

`EntryOracle.java` runs original observation programs against the unmodified pinned Config 1.4.9 JAR. The 1,226 programs cover typed raw/resolved leaves, escaped paths, empty/null omission, delayed objects, fallback and partial resolution, semantic equality/hash, mutable detached sets, immutable entries/values, null inserted entries, bulk operations, collisions and iterator state. Observations normalize set order; order and precise exception text are not conformance claims. The JS fail-fast category names are also checked directly. The 406 `core` programs are included in the 1,226, not additional independent coverage; generation produces 13 core groups. Two separate public-core tests check mutable ownership and resource bounds.

`test-entry-async.mjs` replays the same 1,226 saved native results after four concurrent worker factories. `test-entry-host.mjs` exercises 17 source/ownership/API checks across strings, files, file URLs, HTTP and trusted HTTPS; retained values remain usable after source deletion/shutdown. Legacy persistent test adapters explicitly use `entrySetData()` for the former plain-data contract. Existing object entry arrays keep their interface.

The native comparisons exposed extra fallback history after appending a lower configuration to a previously parsed delayed stack. The core now left-associates that history, preserves the lowest scalar fallback barrier, consolidates known delayed-object concatenations, and drops older objects fully shadowed during partial resolution. Fresh document/value/render native comparisons and all existing mandatory replay suites guard these changes.

Implementation semantics were checked against pinned primary sources: [Config entrySet contract](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/Config.java), [SimpleConfig enumeration](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/SimpleConfig.java), [delayed merge resolution](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigDelayedMerge.java), and [concatenation behavior](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigConcatenation.java). The adapters are original and use the JAR as the oracle.

`benchmark-entries.mjs` uses five fresh processes per runtime over 12 workloads, 30 warmup calls and 15 samples of three calls, each call performing 16 enumerations. Parsing is outside timing. Results are compared after timing. The five fixed-0.18 comparisons use resolved entry count: the baseline serializes plain values, while current/native create typed sets. Hash and unresolved enumeration are new capabilities and have no baseline API comparison. This is a functional upgrade cost comparison, not a claim of identical internal work. No timing result cache is used; complete throughput, memory, startup and platform parity remain open.

## 0.19 最终验证

JS/Wasm-GC 各 16,652 项；新增 1,226 个实时原版程序通过，含 406 个核心程序/13 分组，另有 2 个核心所有权/限额测试。17 项新宿主检查及同组 1,226 次异步回放通过。文档/值/渲染也重新实时比较，共 8,696 次；15 个保存原版套件回放共 31,776 次，包含原有重叠，不能计为全部新独立案例。205 文件再生一致；编译引擎与交付引擎相同；307 项有界异常输入通过；受控 GC 回收 2,399/2,400 个丢弃配置。

五进程枚举计时中，64 字段计数、哈希当前/原版耗时比为 7.058、7.921；512 字段哈希为 30.204。64 字段计数相对旧 0.18 普通数据接口为 2.234，旧接口展开数据，新接口构造类型化集合，内部工作量不同。最大进程中位数波动比 3.032，不稳定标记 true。该功能升级仍有明显性能差距。 最终清单见 `evidence/entry-upgrade.json`，原始五进程样本见 `evidence/entry-performance.json`。完整目标仍未完成。

## 0.20 allocation and scan reduction

The initial CPU sample on fixed 0.19 attributed most sampled time to ConfigEntry/ConfigValue construction and GC, followed by generic integer parsing and path generation. This motivated native private fields, direct immutable-leaf enumeration, a small integer scan, and direct path-segment validation. Profiling is diagnostic; final timings come from separate uninstrumented fresh processes.

`SmallIntegerOracle.java` uses unmodified JDK Integer.valueOf on 2,342 distinct bounded inputs. The generator covers signed int32 boundaries and neighbors, leading zeros, plus/minus, fixed random int32 strings and malformed ASCII. Inputs are <=11 UTF-16 units; the matrix is for the helper's bounded domain, not all numeric strings or Unicode integer rules. Nineteen whitebox groups verify the independent results on both backends. `--live --check` recaptures JDK results and checks generated tokens while preserving quoted-string contents.

Existing live entry/value/value-walk/tree/render comparisons cover public semantics. The 4,380 tree programs include BMP character-range boundary enumeration, supplementing quoted/unquoted key tests. Twenty entry host checks include the three new private-brand, detached-derivation and core-versus-bridge error checks. `test-entry-memory.mjs` uses six explicit-GC rounds with 2,400 objects of each of four kinds and a retained readable leaf. It bounds accidental retention; it does not measure production peak or full native memory parity.

The direct bridge still validates leaf descendants using the original copy traversal's resource costs, then returns opaque handles to immutable retained values. The public core continues to copy leaves. Collection order remains outside parity claims. The twelve entry workloads now compare identical typed API behavior against fixed 0.19, including raw values and hash calls. No enumeration result cache is added. A separate five-process run of the existing 29 workloads covers earlier parse/read/edit/value/render behavior and detects regressions. Both runs retain raw per-process samples and result agreement checks.

## 0.20 最终验证

JS/Wasm-GC 各 16,671 项通过；2,342 个新增 JDK 整数输入进入 19 个分组，20 项条目宿主检查通过；四类包装分别回收 2,399/2,400 个。相关五个原版套件重新实时运行共 11,492 次，15 个保存原版套件回放共 31,776 次，包含历史重叠，不作为全部新独立案例。213 个源码/生成文件再生一致，编译引擎与交付引擎相同；既有异步、资源限额与其他强制检查通过。

最终五进程计时中，64 字段枚举、512 字段枚举哈希相对 0.19 耗时减少 63.7%、86.1%，当前/原版仍为 2.192、3.753。新枚举最大进程中位数波动比 2.581，不稳定标记 true。

既有 29 类负载均与原版输出一致。缓存哈希、冷哈希、值比较、列表搜索的当前/0.19 耗时比分别为 0.946、0.527、0.461、0.329；旧负载最大当前/0.19 耗时比为 1.107（legacy-fallback-32）。回归计时最大进程中位数波动比 2.338，不稳定标记 true。长中点渲染当前/原版仍为 517.804，完整性能尚未追平。

初测观察到缓存哈希热调用回退，随后改为方法内部直接访问私有字段。初测的两份 `*-performance-initial.json` 保留原始样本和当时的源码指纹；最终结果以 `entry-scan-performance.json`、`entry-scan-regression-performance.json` 和 `entry-scan-upgrade.json` 为准。CPU 采样仅用于定位问题，最终计时未启用采样器。
