// Hand-authored semantic expectations, not snapshots copied from the Node engine.
// Public Value constructors: config.mbt. Position units: README.md and
// HOCON-COVERAGE.md (zero-based Unicode scalar offset, one-based line/column).
export const exampleSource = 'service { host = "localhost", port = 8080 }\n'
  + 'service.port = 9090\nendpoint = ${service.host}';

export const exampleFields = [
  '"service": Object({ "host": Text("localhost"), "port": Number("9090") })',
  '"endpoint": Text("localhost")',
];

export const typedSource = [
  'enabled = true',
  'retries = 3',
  'ratio = 1.5',
  'label = "🐉"',
  'nothing = null',
  'items = [1, false, "ok"]',
  'big = 9007199254740993',
  'source.host = "localhost"',
  'endpoint = ${source.host}',
].join('\n');

export const typedFields = [
  '"enabled": Boolean(true)',
  '"retries": Number("3")',
  '"ratio": Number("1.5")',
  '"label": Text("🐉")',
  '"nothing": Null',
  '"items": List([Number("1"), Boolean(false), Text("ok")])',
  '"big": Number("9007199254740993")',
  '"source": Object({ "host": Text("localhost") })',
  '"endpoint": Text("localhost")',
];

export const invalidSource = 'service {\n  port = ]\n}';
export const invalidDiagnostic = 'ERROR: Located( "value required", '
  + '{ source: "<string>", offset: 19, line: 2, column: 10 }, )';

// The dragon occupies one Unicode scalar. The bad ] follows 32 scalars and
// is the 23rd scalar on line 2, despite occupying a different DOM UTF-16 index.
export const unicodeInvalidSource = 'service {\n  label = "🐉", port = ]\n}';
export const unicodeInvalidDiagnostic = 'ERROR: Located( "value required", '
  + '{ source: "<string>", offset: 32, line: 2, column: 23 }, )';
