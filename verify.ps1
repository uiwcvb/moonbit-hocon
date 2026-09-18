param([string]$MoonPath)
$ErrorActionPreference='Stop'
if (-not $MoonPath) {
  $available=Get-Command moon -ErrorAction SilentlyContinue
  if ($available) { $MoonPath=$available.Source }
  else { throw 'Install MoonBit or pass -MoonPath with the absolute moon.exe path.' }
}
$env:MOON_HOME=Split-Path (Split-Path $MoonPath -Parent) -Parent
$env:PATH="$(Split-Path $MoonPath -Parent);$env:PATH"
Push-Location $PSScriptRoot
try {
  & $MoonPath fmt
  if ($LASTEXITCODE -ne 0) {throw 'format failed'}
  & $MoonPath info
  if ($LASTEXITCODE -ne 0) {throw 'API generation failed'}
  & $MoonPath check --deny-warn
  if ($LASTEXITCODE -ne 0) {throw 'check failed'}
  node tools/generate-double-render-tests.mjs --check
  if ($LASTEXITCODE -ne 0) {throw 'native binary64 vector generation is stale'}
  & $MoonPath test --target wasm-gc --deny-warn
  if ($LASTEXITCODE -ne 0) {throw 'tests failed'}
  & $MoonPath test --target js --deny-warn
  if ($LASTEXITCODE -ne 0) {throw 'JS tests failed'}
  & $MoonPath build --target js --deny-warn
  if ($LASTEXITCODE -ne 0) {throw 'build failed'}
  & $MoonPath run cmd/main
  if ($LASTEXITCODE -ne 0) {throw 'example failed'}
  $engine=Get-ChildItem '_build/js' -Recurse -File | Where-Object { $_.Name -in @('main.js','web.js') -and $_.FullName -match '[\\/]cmd[\\/]web[\\/]' } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if (-not $engine) {throw 'Missing browser engine'}
  Copy-Item -LiteralPath $engine.FullName -Destination 'web/engine.mjs' -Force
  node tools/test-demo.mjs
  if ($LASTEXITCODE -ne 0) {throw 'browser engine test failed'}
  node tools/test-cli.mjs
  if ($LASTEXITCODE -ne 0) {throw 'CLI test failed'}
  node tools/test-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'file host integration failed'}
  node tools/test-config-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'configuration reference replay failed'}
  node tools/test-file-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'file reference replay failed'}
  node tools/test-collections.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'collection reference replay failed'}
  node tools/test-collection-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'collection CLI/host tests failed'}
  node tools/test-http-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'HTTP reference replay failed'}
  node tools/test-http-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'HTTP host/async/CLI tests failed'}
  node tools/test-tree-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'tree reference replay failed'}
  node tools/test-tree-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'tree host/async/CLI tests failed'}
  node tools/test-document-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'document reference replay failed'}
  node tools/test-document-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'document file/HTTP/async/CLI tests failed'}
  node tools/test-accessor-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'extended accessor reference replay failed'}
  node tools/test-accessor-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'extended accessor file/HTTP/async/CLI tests failed'}
  node tools/test-temporal-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'temporal reference replay failed'}
  node tools/test-temporal-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'temporal file/HTTP/async/CLI tests failed'}
  node tools/test-persistent-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'persistent reference replay failed'}
  node tools/test-persistent-async.mjs
  if ($LASTEXITCODE -ne 0) {throw 'persistent async native replay failed'}
  node tools/test-persistent-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'persistent file/HTTP/ownership failed'}
  node tools/test-persistent-memory.mjs
  if ($LASTEXITCODE -ne 0) {throw 'persistent bounded collection failed'}
  node tools/test-path-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'API path reference replay failed'}
  node tools/test-native-read-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'direct result native reference replay failed'}
  node tools/test-native-read-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'native result transport failed'}
  node tools/test-value-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'value/container reference replay failed'}
  node tools/test-value-async.mjs
  if ($LASTEXITCODE -ne 0) {throw 'value/container async replay failed'}
  node tools/test-value-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'value/container host checks failed'}
  node tools/test-value-walk-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'value traversal reference replay failed'}
  node tools/test-value-walk-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'value traversal host checks failed'}
  node tools/test-render-reference.mjs --golden
  if ($LASTEXITCODE -ne 0) {throw 'render reference replay failed'}
  node tools/test-render-async.mjs
  if ($LASTEXITCODE -ne 0) {throw 'render async replay failed'}
  node tools/test-render-host.mjs
  if ($LASTEXITCODE -ne 0) {throw 'render file/HTTP/ownership checks failed'}
  node tools/robustness.mjs
  if ($LASTEXITCODE -ne 0) {throw 'robustness failed'}
  node tools/benchmark.mjs
  if ($LASTEXITCODE -ne 0) {throw 'benchmark failed'}
} finally {Pop-Location}
