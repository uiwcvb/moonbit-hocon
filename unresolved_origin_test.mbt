///|
fn observed_origin(value : @hocon.Value) -> @hocon.SourcePosition? {
  try {
    ignore(@hocon.resolve(value))
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
}

///|
test "unresolved origin survives copy partial resolution include and reindex" {
  let source = @hocon.parse_unresolved(
    "service {include \"child.conf\"}",
    source_name="main.conf",
    includes={ "child.conf": "# child\nvalue = ${missing}" },
  )
  let expected = Some(@hocon.SourcePosition::{
    source: "child.conf",
    offset: 16,
    line: 2,
    column: 9,
  })
  for
    value in [
      source,
      @hocon.copy_value(source),
      @hocon.resolve(source, allow_unresolved=true),
      @hocon.at_key(@hocon.copy_value(source), "wrapped"),
      @hocon.value_with_fallback(source, @hocon.parse("unrelated=1")),
    ] {
    assert_eq(observed_origin(value), expected)
  }
  let external = try {
    ignore(@hocon.resolve_with(source, @hocon.parse("other=1")))
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(external, expected)
}

///|
test "unresolved origin leaves old constructors and Invalid compatible" {
  for
    reference in [
      @hocon.Reference("missing"),
      @hocon.PathReference(["missing"], false),
      @hocon.Substitution([["missing"]], false, false, 4),
    ] {
    let actual = try {
      ignore(@hocon.resolve(@hocon.Object({ "x": reference })))
      "accepted"
    } catch {
      @hocon.Invalid(message) => message
      _ => "unexpected error variant"
    }
    assert_eq(actual, "unresolved missing")
  }
}

///|
test "unresolved origin does not change semantic equality hash or rendering" {
  let a = @hocon.parse_unresolved("x=${missing}", source_name="a.conf")
  let b = @hocon.parse_unresolved("\n  x=${missing}", source_name="b.conf")
  let legacy = @hocon.Object({
    "x": @hocon.Substitution([["missing"]], false, false, 99),
  })
  for value in [b, legacy, @hocon.copy_value(a)] {
    assert_true(@hocon.value_equals(a, value))
    assert_eq(@hocon.value_hash(a), @hocon.value_hash(value))
    assert_eq(@hocon.render_value(a), @hocon.render_value(value))
    assert_eq(
      @hocon.render_value(a, json=false),
      @hocon.render_value(value, json=false),
    )
  }
}

///|
test "unresolved origin successful evaluation and config change contract" {
  let raw = @hocon.parse_unresolved(
    "service.port=${PORT}\nservice.copy=${service.port}\noptional=${?missing}",
  )
  let first = @hocon.resolve(raw, environment={ "PORT": "8080" })
  let second = @hocon.resolve(raw, environment={ "PORT": "9080" })
  assert_eq(
    first.to_json_string(),
    "{\"service\":{\"copy\":\"8080\",\"port\":\"8080\"}}",
  )
  assert_eq(@hocon.diff_resolved_configs(first, second).map(c => c.path), [
    ["service", "copy"],
    ["service", "port"],
  ])
  assert_eq(
    @hocon.resolve(@hocon.parse_unresolved("x=${missing}\nx=2")).to_json_string(),
    "{\"x\":2}",
  )
}
