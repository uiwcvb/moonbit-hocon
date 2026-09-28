///|
test "resolved config diff tracks literal paths and changed types" {
  let before = @hocon.parse(
    "service.port=8080\nservice.copy=${service.port}\n\"a.b\"=old\nitems=[1,2]\nremoved=true",
  )
  let after = @hocon.parse(
    "service.port=9080\nservice.copy=${service.port}\n\"a.b\"=new\nitems=[1,3]\nadded=null",
  )
  let changes = @hocon.diff_resolved_configs(before, after)
  assert_eq(changes.map(change => change.path), [
    ["a.b"],
    ["added"],
    ["items"],
    ["removed"],
    ["service", "copy"],
    ["service", "port"],
  ])
  assert_eq(changes.map(change => change.kind), [
    "changed", "added", "changed", "removed", "changed", "changed",
  ])
  assert_eq(changes[1].after_type, Some("NULL"))
  assert_eq(changes[3].before_type, Some("BOOLEAN"))
  assert_eq(changes[4].before_type, Some("NUMBER"))
  assert_eq(changes[4].after_type, Some("NUMBER"))
}

///|
test "resolved config diff ignores formatting but rejects unresolved input" {
  let before = @hocon.parse("x=1\ny={a:2}")
  let after = @hocon.parse("x=1.0\ny.a=2")
  assert_true(@hocon.diff_resolved_configs(before, after).is_empty())
  let unresolved = @hocon.parse_unresolved("x=${missing}")
  assert_true(
    try {
      ignore(@hocon.diff_resolved_configs(unresolved, after))
      false
    } catch {
      _ => true
    },
  )
}
