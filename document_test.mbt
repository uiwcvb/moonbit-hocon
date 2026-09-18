///|
test "independent parses have independent substitution caches" {
  let target = @hocon.parse_unresolved("a=${x}\nb=${y}")
  let source = @hocon.parse_unresolved("x=${z}\ny=8\nz=7")
  let resolved = @hocon.resolve_with(target, source)
  assert_eq(resolved.to_json_string(), "{\"a\":7,\"b\":8}")
  assert_false(@hocon.is_resolved(target))
  assert_false(@hocon.is_resolved(source))
}

///|
test "partial resolution retains mandatory and removes optional references" {
  let raw = @hocon.parse_unresolved("a=${missing}\nb=${?missing}\nx=known")
  let partial = @hocon.resolve(raw, allow_unresolved=true)
  assert_eq(@hocon.get_string(partial, "x"), "known")
  assert_false(@hocon.has_path_or_null(partial, "b"))
  let ready = @hocon.resolve(
    @hocon.with_value(partial, "missing", @hocon.Number("3")),
  )
  assert_eq(@hocon.get_int(ready, "a"), 3)
  assert_false(@hocon.has_path_or_null(ready, "b"))
  assert_true(@hocon.has_path_or_null(raw, "b"))
}

///|
test "resolution and required getters detach mutable source branches" {
  let source = @hocon.parse_unresolved("x=[{n=1}]")
  let target = @hocon.parse_unresolved("a=${x}")
  let result = @hocon.resolve_with(target, source)
  if @hocon.get(result, "a") is Some(@hocon.List(items)) {
    items.clear()
  }
  assert_eq(@hocon.get_list(source, "x").length(), 1)
  let copied = @hocon.get_value(source, "x")
  if copied is @hocon.List(items) {
    items.clear()
  }
  assert_eq(@hocon.get_list(source, "x").length(), 1)
  let resolved = @hocon.resolve(source)
  if @hocon.get(resolved, "x") is Some(@hocon.List(items)) {
    items.clear()
  }
  assert_eq(@hocon.get_list(source, "x").length(), 1)
}

///|
test "raw bare strings support required typed getters and validation" {
  let raw = @hocon.parse_unresolved("s=hello\nn=42\nx=null")
  assert_true(@hocon.is_resolved(raw))
  assert_eq(@hocon.get_string(raw, "s"), "hello")
  assert_eq(@hocon.get_int(raw, "n"), 42)
  assert_true(@hocon.get_is_null(raw, "x"))
  @hocon.check_valid(raw, @hocon.parse("s=text\nn=0\nx=true"))
}

///|
test "allow unresolved still rejects real cycles" {
  for source in ["a=${a}", "a=${b}\nb=${a}", "a={x=${a}}"] {
    assert_true(
      try {
        ignore(
          @hocon.resolve(@hocon.parse_unresolved(source), allow_unresolved=true),
        )
        false
      } catch {
        _ => true
      },
    )
  }
}

///|
test "resolve with only searches its source and recognizes self identity" {
  let raw = @hocon.parse_unresolved("a=1\na=${a}tail")
  assert_eq(@hocon.resolve_with(raw, raw).to_json_string(), "{\"a\":\"1tail\"}")
  let target = @hocon.parse_unresolved("x=1\na=${x}")
  assert_true(
    try {
      ignore(@hocon.resolve_with(target, @hocon.parse_unresolved("{}")))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(
    @hocon.get_int(
      @hocon.resolve_with(target, @hocon.parse_unresolved("x=9")),
      "a",
    ),
    9,
  )
}

///|
test "known delayed leaves resolve but uncertain nested merges reject" {
  let raw = @hocon.parse_unresolved("a=${missing}\na={x=1}\nb=${a.x}")
  assert_eq(@hocon.get_int(raw, "a.x"), 1)
  assert_eq(@hocon.get_int(@hocon.resolve(raw, allow_unresolved=true), "b"), 1)
  let nested = @hocon.parse_unresolved("a=${missing}\na={x={z=1}}")
  assert_true(
    try {
      ignore(@hocon.get_value(nested, "a.x.z"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "caller constructed cycles and deep unresolved input remain bounded" {
  let cycle : Map[String, @hocon.Value] = Map([])
  cycle["self"] = @hocon.Object(cycle)
  assert_true(
    try {
      ignore(@hocon.resolve(@hocon.Object(cycle), allow_unresolved=true))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(
        @hocon.resolve_with(
          @hocon.parse_unresolved("a=${x}"),
          @hocon.Object(cycle),
        ),
      )
      false
    } catch {
      _ => true
    },
  )
}
