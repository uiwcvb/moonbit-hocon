# Changes

## 0.4.0

- Resolve definition history, self-reference, append assignments, included-reference relocation and ordered fallback barriers.
- Add source origins, triple-quoted strings, Unicode whitespace/path rules and located syntax errors.
- Add explicit environments, list-environment substitutions, synchronous source loaders and Node filesystem/format/classpath-directory host.
- Add coercing getters, exact long/duration/byte access, arbitrary precision memory quantities and Java-compatible floating-point string conversion.
- Extend CLI and add live independent Lightbend Config 1.4.9 comparisons plus portable replay in the mandatory verifier and CI.
- Retain strict original getters. New Value variants and parse_sources require downstream exhaustive matches to be updated.

Known gaps and resource bounds remain explicit in FEATURES.md and README.md; this release does not claim full parity.
