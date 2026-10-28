# Actual local package acceptance

Run from a Git checkout with the pinned MoonBit toolchain, Node 24 and Python 3.9+:

```sh
node tools/test-package-consumer.mjs
```

The gate invokes real `moon package`; it does not manufacture a ZIP from selected
source files. Before packaging, it records exact working-input hashes for all
tracked public distribution files. Only the pre-existing omissions of Git/CI
metadata and `evidence/benchmark.json` / `evidence/robustness.json` are exempt.
Fixed attribution members include the root license, standard-library license
and NOTICE, and the OpenWhisk/Pekko source manifest and full license/NOTICE files.
Module name, version and license stay `uiwcvb/hocon`, `0.25.0`, and MIT.

Cache canaries are placed in the declared browser dependency and generated-report
directories, without changing existing files. `.moonignore` excludes those
directories. The original package policy omitted these new exclusions and could
ship `tools/browser/node_modules` and `output` reports, including machine paths.
Legitimate source, host tools, examples and test fixtures remain included.

Python's standard ZIP reader reads every member, checks CRC and exact source
bytes, requires the attribution files, rejects cache/control/credential payloads
and ambiguous extraction paths, then extracts to a new private directory. The
public localhost TLS test key is retained only at its known committed path and
fixed content hash; it is not treated as a deployment credential. Five separately
damaged copies must be rejected: missing NOTICE, altered production source,
traversal, a control credential file, and a synthetic token. No real credential
is used or copied into these fixtures, and the valid archive is not changed.

The already accepted standalone transition consumer is then run **from the
extracted archive**, using its verified driver, source and oracle. Its six
hand-authored rollout requests execute in new JS and Wasm-GC workspaces and must
produce the complete expected decisions, active values, reports and diagnostics.
Its oracle bytes must equal the original pre-package expectations. This reuses
the semantic contract while checking a different artifact boundary; ZIP opening
or extraction alone does not pass the gate.

`output/package-consumer/` contains the full member/hash readback, negative-control
results, stdout/stderr, extracted-consumer evidence, and a hash-named copy of the
validated local ZIP. Set `HOCON_PACKAGE_CACHE` to a project-owned cache as needed;
CI uses its runner's temporary directory. Temporary workspaces and negative ZIPs
are retained for diagnosis. Only this run's uniquely named canary files are
removed. The generated output directory is excluded from later packages.

This verifies a local distribution artifact and declared consumer scenarios. It
does not publish or verify a new registry release, attest signatures, prove all
HOCON/JVM compatibility, or establish external adoption. CI artifact upload is
separate from this local readback; external download/readback is not claimed.
