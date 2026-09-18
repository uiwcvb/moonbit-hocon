///|
test "edits and entry enumeration detach every mutable branch" {
  let original = @hocon.parse("a={b=[{n=1}]}\nz={q=2}")
  let inserted = @hocon.parse("x=[{n=3}]")
  let edits = [
    @hocon.copy_value(original),
    @hocon.with_value(original, "other", inserted),
    @hocon.with_key_value(original, "other", inserted),
    @hocon.without_path(original, "absent"),
    @hocon.with_only_path(original, "a"),
    @hocon.without_key(original, "absent"),
    @hocon.with_only_key(original, "a"),
    @hocon.with_fallback(original, inserted),
  ]
  for edited in edits {
    if @hocon.get(edited, "a.b") is Some(@hocon.List(items)) {
      if items[0] is @hocon.Object(fields) {
        fields["n"] = @hocon.Number("99")
      }
      items.push(@hocon.Null)
    }
    assert_eq(
      original.to_json_string(),
      "{\"a\":{\"b\":[{\"n\":1}]},\"z\":{\"q\":2}}",
    )
  }
  let output = @hocon.with_value(original, "other", inserted)
  if @hocon.get(output, "other.x") is Some(@hocon.List(xs)) {
    xs.clear()
  }
  assert_eq(inserted.to_json_string(), "{\"x\":[{\"n\":3}]}")
  let entries = @hocon.entry_set(original)
  if entries["a.b"] is @hocon.List(xs) {
    xs.clear()
  }
  assert_eq(@hocon.get_list(original, "a.b").length(), 1)
}

///|
test "unresolved values and cyclic caller constructed trees are bounded" {
  assert_false(
    @hocon.is_resolved(@hocon.Object({ "x": @hocon.Reference("missing") })),
  )
  assert_true(@hocon.is_resolved(@hocon.parse("x=1")))
  let cycle : Map[String, @hocon.Value] = Map([])
  cycle["self"] = @hocon.Object(cycle)
  for operation in [@hocon.copy_value, v => @hocon.without_path(v, "x")] {
    assert_true(
      try {
        ignore(operation(@hocon.Object(cycle)))
        false
      } catch {
        _ => true
      },
    )
  }
  assert_true(
    try {
      @hocon.check_valid(
        @hocon.Object({ "x": @hocon.Reference("x") }),
        @hocon.parse("x=1"),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "validation exposes all problems and duplicate restrictions" {
  let actual = @hocon.parse("a=false\nb=[true,{},1]\nx=null")
  let reference = @hocon.parse("a=1\nb=[1]\nc={d=1}\nx={required=1}")
  let problems = @hocon.validation_problems(actual, reference)
  assert_eq(problems.length(), 3)
  let repeated = @hocon.validation_problems(actual, reference, paths=[
    "a", "a", "absent",
  ])
  assert_eq(repeated.length(), 2)
  assert_eq(repeated[0].kind, "wrong-type")
  assert_eq(repeated[0].expected, "number")
  assert_eq(repeated[0].actual, "boolean")
  assert_true(
    try {
      @hocon.check_valid(actual, reference)
      false
    } catch {
      @hocon.ValidationFailed(items) => items.length() == 3
      _ => false
    },
  )
}
