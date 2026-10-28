// Independent application decisions, authored before executing the consumer.
// No library, Node bridge, or generated product output is used as an oracle.
const before = 'service.port=8080\nexposedPort=${service.port}';
const after = 'service.port=9080\nexposedPort=${service.port}';
const port = ['service', 'port'];
const copy = ['exposedPort'];
const changed = path => ({ path, kind: 'changed', before_type: 'NUMBER', after_type: 'NUMBER' });
const changes = [changed(port), changed(copy)];
const request = (overrides = {}) => ({
  before_source: before, after_source: after,
  expected_before: '8080', expected_after: '9080', approve_copy: true,
  ...overrides,
});
const report = (overrides = {}) => ({
  accepted: false, changes, unexpected: [], mismatches: [], unused_rules: [],
  ...overrides,
});
const output = (overrides = {}) => ({
  decision: 'kept', active_port: 8080, active_exposed_port: 8080,
  legacy_accepted: true, review: report(), diagnostic: null,
  ...overrides,
});

export default [
  {
    id: 'approved-activation', request: request(),
    expected: output({
      decision: 'activated', active_port: 9080, active_exposed_port: 9080,
      review: report({ accepted: true }),
    }),
  },
  {
    id: 'wrong-target-keeps-baseline',
    request: request({ after_source: 'service.port=9081\nexposedPort=${service.port}' }),
    expected: output({ review: report({ mismatches: [
      { path: port, kind: 'changed', side: 'after' },
      { path: copy, kind: 'changed', side: 'after' },
    ] }) }),
  },
  {
    id: 'stale-baseline-is-not-activated',
    request: request({ before_source: 'service.port=8081\nexposedPort=${service.port}' }),
    expected: output({
      active_port: 8081, active_exposed_port: 8081,
      review: report({ mismatches: [
        { path: port, kind: 'changed', side: 'before' },
        { path: copy, kind: 'changed', side: 'before' },
      ] }),
    }),
  },
  {
    id: 'indirect-change-needs-its-own-permission', request: request({ approve_copy: false }),
    expected: output({ legacy_accepted: false, review: report({ unexpected: [changed(copy)] }) }),
  },
  {
    id: 'unused-transition-rejects-but-legacy-default-accepts',
    request: request({ after_source: before }),
    expected: output({ review: report({ changes: [], unused_rules: [
      { path: port, kind: 'changed' }, { path: copy, kind: 'changed' },
    ] }) }),
  },
  {
    id: 'invalid-candidate-retains-baseline-and-public-location',
    request: request({ after_source: 'service {\n  port = ]\n}' }),
    expected: output({
      decision: 'input-error', legacy_accepted: null, review: null,
      diagnostic: { message: 'value required', position: {
        source: 'consumer-after.conf', offset: 19, line: 2, column: 10,
      } },
    }),
  },
];
