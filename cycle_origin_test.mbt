///|
fn cycle_origin(value : @hocon.Value) -> @hocon.SourcePosition? {
  try {
    ignore(@hocon.resolve(value))
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
}

///|
test "cycle origin survives copying wrapping fallback and unresolved mode" {
  let value = @hocon.parse_unresolved(
    "service {include \"child.conf\"}",
    source_name="main.conf",
    includes={ "child.conf": "# child\na={b=${a}}" },
  )
  let expected = Some(@hocon.SourcePosition::{
    source: "child.conf",
    offset: 13,
    line: 2,
    column: 6,
  })
  for
    candidate in [
      value,
      @hocon.copy_value(value),
      @hocon.at_key(value, "wrapped"),
      @hocon.value_with_fallback(value, @hocon.parse("unrelated=1")),
    ] {
    assert_eq(cycle_origin(candidate), expected)
  }
  let partial = try {
    ignore(@hocon.resolve(value, allow_unresolved=true))
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(partial, expected)
}

///|
test "cycle errors without parsed sources retain Invalid variant" {
  for
    reference in [
      @hocon.Reference("a"),
      @hocon.PathReference(["a"], false),
      @hocon.Substitution([["a"]], false, false, 42),
    ] {
    let legacy = try {
      ignore(@hocon.resolve(@hocon.Object({ "a": reference })))
      false
    } catch {
      @hocon.Invalid(_) => true
      _ => false
    }
    assert_true(legacy)
  }
}
