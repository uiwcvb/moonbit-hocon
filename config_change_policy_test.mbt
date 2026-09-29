///|
test "change policy rejects a substitution side effect not explicitly allowed" {
  let before = @hocon.parse("service.port=8080\nservice.copy=${service.port}")
  let after = @hocon.parse("service.port=9080\nservice.copy=${service.port}")
  let one = @hocon.review_config_changes(before, after, [
    { path: ["service", "port"], kind: "changed", },
  ])
  assert_false(one.accepted)
  assert_eq(one.unexpected.map(c => c.path), [["service", "copy"]])
  let both = @hocon.review_config_changes(before, after, [
    { path: ["service", "port"], kind: "changed", },
    { path: ["service", "copy"], kind: "changed", },
  ])
  assert_true(both.accepted)
  assert_eq(both.changes.length(), 2)
}

///|
test "change policy preserves literal keys, operation kind and parent boundary" {
  let before = @hocon.parse("\"a.b\"=1\na.b=1\nservice.port=8080")
  let after = @hocon.parse("\"a.b\"=2\na.b=2")
  let report = @hocon.review_config_changes(before, after, [
    { path: ["a.b"], kind: "changed", },
    { path: ["service", "port"], kind: "removed", },
    { path: ["a", "b"], kind: "added", },
  ])
  assert_false(report.accepted)
  assert_eq(report.unexpected.map(c => c.path), [["a", "b"], ["service"]])
  assert_eq(report.unexpected.map(c => c.kind), ["changed", "removed"])
}

///|
test "empty policy allows semantic equality and unused permissions" {
  let before = @hocon.parse("a=1")
  let after = @hocon.parse("a=1.0")
  assert_true(@hocon.review_config_changes(before, after, []).accepted)
  assert_true(
    @hocon.review_config_changes(before, after, [
      { path: ["unused"], kind: "removed", },
    ]).accepted,
  )
  assert_false(
    @hocon.review_config_changes(before, @hocon.parse("a=2"), []).accepted,
  )
}

///|
test "change policy rejects invalid and ambiguous rules" {
  let value = @hocon.parse("a=1")
  let bad_rules : Array[Array[@hocon.ConfigChangeRule]] = [
    [{ path: [], kind: "changed", }],
    [{ path: ["a"], kind: "anything", }],
    [{ path: ["a"], kind: "changed", }, { path: ["a"], kind: "changed", }],
  ]
  for rules in bad_rules {
    assert_true(
      try {
        ignore(@hocon.review_config_changes(value, value, rules))
        false
      } catch {
        _ => true
      },
    )
  }
}
