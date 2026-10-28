# Public demo browser regression

This isolated Playwright 1.64.1 suite opens the real `web/index.html` in Chromium,
fills the input, and clicks the public Run and Reset buttons. It checks explicit
values and `Value` types, exact large integers, substitution/override behavior,
error styling and diagnostics, recovery, and Unicode scalar source positions.
Expected values are hand-authored in `fixtures.mjs`; Node output is not the oracle.

First build with the pinned MoonBit toolchain, then copy
`_build/js/debug/build/cmd/web/web.js` to `web/engine.mjs`, as CI does. The suite
requires both files to match and verifies the browser received those engine bytes.

```sh
moon build --target js --deny-warn
cp _build/js/debug/build/cmd/web/web.js web/engine.mjs
npm ci --prefix tools/browser --ignore-scripts --no-audit --no-fund
node tools/browser/node_modules/playwright/cli.js install chromium
npm test --prefix tools/browser
```

For Linux runner dependencies, use `install --with-deps chromium`. Set
`PLAYWRIGHT_BROWSERS_PATH` to a project-owned cache if the default cache is shared.
The browser uses a fresh test profile and a loopback server on an ephemeral port.
No installed user browser/profile or external website is used.

Reports, screenshots, failure traces, and engine/browser identity attachments are
written under `output/playwright/`, which CI includes in `quality-evidence` even
after failure. Retries are disabled. Coverage is limited to Chromium and the
declared consumer scenarios; Firefox, WebKit, mobile, and complete HOCON
compatibility are not claimed.
