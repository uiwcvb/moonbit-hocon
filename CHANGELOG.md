# Changes

## 0.19.0

- Return detached mutable ConfigEntrySet collections with immutable typed ConfigEntry values; preserve the old plain-data API as entrySetData. Keep unresolved references opaque, omit null/empty objects, reject unresolved delayed-object traversal.
- Add semantic set equality, hashing, mutations and fail-fast cursors without changing the immutable configuration tree. Expose tuple iteration and detached arrays.
- Normalize delayed fallback stacks, preserve scalar barriers, consolidate known delayed objects, and omit fully shadowed older objects during partial resolution.
- Add 1,226 independent native programs, 406 portable core programs in 13 groups plus two ownership/resource tests, 17 host checks and the full worker replay. Compare 12 entry workloads against native Config and five resolved count workloads against fixed 0.18. Full parity remains open.

## 0.18.0

- Validate decimal token spelling, trim and classify numeric strings by direct UTF-16 indexing, avoiding repeated character arrays; reject invalid ASCII integer candidates before entering Unicode digit conversion, while preserving the Unicode fallback.
- Bound long tiny decimal coefficients by 32-digit then 768-digit prefixes. Return only when both exact rounded endpoints agree; ambiguous inputs retain full conversion. Remove trailing prefix zeros before exact rational work.
- Extend the independent primitive parser matrix to 27,851 strings (346 additions, 218 groups), including long nonzero tails and midpoint boundary extensions. Keep all earlier public/native and backend checks.
- Compare 29 workloads against fixed 0.17 and native Config, including long midpoint rendering and retained quoted Double-list parsing. Full parity remains open.

## 0.17.0

- Parse tiny decimal coefficients with exact rational arithmetic and one quotient/remainder rounding, preserving subnormal/normal transitions and ties to even. Ordinary values and coefficients above 768 significant digits retain the runtime conversion.
- Validate unsigned decimal grammar and magnitude in one pass; preserve outer sign, Java suffix/hex handling, diagnostics and the existing input-length limit.
- Independently compare 27,505 JDK parsing inputs as exact canonical binary64 bits or rejection, including decimal midpoints, long coefficient fallbacks and huge exponents, in 215 groups on both backends.
- Measure real retained Double-list reads plus ordinary, subnormal, decimal-power and long-coefficient rendering against fixed 0.16 and native Config. Full parity remains open.

## 0.16.0

- Normalize the runtime shortest decimal for ordinary binary64 rendering; use a proven integer interval for the smallest one-digit subnormals, with full exact arithmetic if the interval overlaps a rounding boundary. No rendered-result cache is introduced.
- Check 24,254 distinct independently captured JDK bit patterns in 190 whitebox groups on both backends, alongside all existing public Config rendering and host tests. Samples span every exponent field, signs, decimal boundaries, subnormals, non-finite values and deterministic random patterns; they do not exhaust binary64.
- Require saved-vector/generated-test consistency in verification and CI, and compare ordinary and exceptional rendering workloads against fixed 0.15 and native Config. Full functional and performance parity remains open.

## 0.15.0

- Core representation migration: resolved unquoted strings retain Bare rather than becoming Text; direct Value matches must support both. Typed string/data access and semantic equality remain unchanged.

- Add bounded JSON/HOCON rendering of raw and resolved ConfigValue trees, concise or formatted; preserve substitutions, concatenations and delayed merge order.
- Match numeric-key ordering, pinned JDK shortest decimal formatting and root/list indentation, with exact native-output and async comparisons.
- Consolidate adjacent known objects above an unresolved fallback after partial resolution.
- Preserve legacy no-argument Config.render; explicit options select the new value renderer. Value rendering defaults to concise output; default origin/comments and environment-origin masking remain unsupported and explicit requests reject.
- Add portable native rendering regressions, real file/HTTP/async host checks and separate native performance measurements.

## 0.14.0

- Traverse ordinary values directly for equality/hash and search, preserving directional unresolved-value failures and native short-circuit order.
- Read opaque immutable children without copying the full subtree or serializing selector commands; retain detached unwrapped output.
- Cache successful hashes only in immutable JavaScript value wrappers; public mutable MoonBit values retain live computation.
- Add 906 distinct native traversal programs across 936 matrix runs, 15 portable test groups, two core ownership/resource regressions and eight host checks to the mandatory verifier.
- Measure repeated retained hashes separately from fresh-wrapper hashes against fixed 0.13 and native Config. Full performance and functional parity remain open.

## 0.13.0

- Add immutable ConfigValue, ConfigObject and ConfigList views, raw/null-aware reads, literal-key edits, value equality/hash, list search/ranges and arbitrary-value fallbacks.
- Preserve scalar fallback barriers in SealedObject through copies, path edits, resolution and worker transfer.
- Allow getValue to retain known delayed objects while their unresolved Map operations still reject.
- Breaking 0.x change: getObject/getList/getObjectList return wrappers; the former ordinary-data getters are available with a Data suffix. Update exhaustive MoonBit Value matches for SealedObject.
- Add independent value/container programs, portable core groups and host/async regressions; retain shared-identity, rendering/origin, full factory/ecosystem and performance gaps.

## 0.7.0

- Add detached path/key tree edits, filtering, wrapping, fallback, copying and entry enumeration.
- Add structural validation with complete structured problem lists, restricted paths and async error preservation.
- Add ordered CLI edits, file-reference validation and flattened entries without overwriting inputs.
- Match JDK 22 BMP path character rendering, with 4,372 new independent native cases and both-backend regressions.
- Keep unresolved document/resolveWith, remaining getters, diagnostic fidelity and full performance parity open.

## 0.6.0

- Add real HTTP/HTTPS URL sources and includes, content negotiation, request-order/relative-origin handling, redirects and trusted TLS.
- Add bounded reusable async workers, queued/running cancellation, network deadlines/byte/read limits, and URL/CA/network CLI options.
- Require object roots in Node/CLI configurations (including fallback sources); keep the core parse_sources default compatible and add object_only.
- Match JSON configuration BOM/Unicode whitespace and reject duplicate/escaped-equivalent member names.
- Add independent live HTTP/HTTPS comparisons, both-backend JSON vectors, host/async/CLI regressions and five-process performance evidence. Proxy/305, remaining APIs, source preservation and full performance/platform parity remain open.

## 0.5.0

- Add eight typed-list getters and config/config-list access, with Node bridge and CLI selection.
- Match collection-specific duration truncation and exact memory-string conversion.
- Deduplicate numeric-index aliases and align ordinary bucket/fallback traversal; preserve the fast path for ordinary objects.
- Add 1,300 independent official vectors on both backends, 72 host/CLI checks and seven five-process end-to-end performance workloads.
- Keep remaining hash-tree/capacity-history, API, loading, diagnostics and platform gaps explicit.

## 0.4.0

- Resolve definition history, self-reference, append assignments, included-reference relocation and ordered fallback barriers.
- Add source origins, triple-quoted strings, Unicode whitespace/path rules and located syntax errors.
- Add explicit environments, list-environment substitutions, synchronous source loaders and Node filesystem/format/classpath-directory host.
- Add coercing getters, exact long/duration/byte access, arbitrary precision memory quantities and Java-compatible floating-point string conversion.
- Extend CLI and add live independent Lightbend Config 1.4.9 comparisons plus portable replay in the mandatory verifier and CI.
- Retain strict original getters. New Value variants and parse_sources require downstream exhaustive matches to be updated.

Known gaps and resource bounds remain explicit in FEATURES.md and README.md; this release does not claim full parity.
