///|
test "render reads mutable core values without changing or caching them" {
  let parsed = @hocon.parse("raw=a_b\nquoted=\"a_b\"")
  assert_eq(@hocon.object_get(parsed, "raw"), Some(@hocon.Bare("a_b")))
  assert_eq(@hocon.object_get(parsed, "quoted"), Some(@hocon.Text("a_b")))
  assert_eq(
    @hocon.get_string(parsed, "raw"),
    @hocon.get_string(parsed, "quoted"),
  )
  assert_true(@hocon.value_equals(@hocon.Bare("a_b"), @hocon.Text("a_b")))
  let fields = { "a": @hocon.Number("1.0") }
  let value = @hocon.Object(fields)
  assert_eq(@hocon.render_value(value), "{\"a\":1}")
  fields["a"] = @hocon.Reference("missing")
  assert_eq(@hocon.render_value(value), "{\"a\":${missing}}")
  assert_eq(fields["a"], @hocon.Reference("missing"))
}

///|
test "render bounds cyclic graphs and output expansion" {
  let fields : Map[String, @hocon.Value] = Map([])
  let cycle = @hocon.Object(fields)
  fields["self"] = cycle
  assert_eq(
    value_native_attempt(() => @hocon.render_value(cycle).to_json()),
    Json::object({ "accepted": false }),
  )
  let text = String::from_array(Array::make(60000, 'x'))
  let large = @hocon.List(Array::make(30, @hocon.Text(text)))
  assert_eq(
    value_native_attempt(() => @hocon.render_value(large).to_json()),
    Json::object({ "accepted": false }),
  )
}

///|
test "partial resolve consolidates adjacent known objects above an unknown fallback" {
  let raw = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
  let partial = @hocon.resolve(raw, allow_unresolved=true)
  let expected = @hocon.parse_unresolved("a=${missing}\na={x=1,y=2}")
  assert_eq(@hocon.render_value(partial), @hocon.render_value(expected))
  let complete = @hocon.resolve(
    @hocon.with_value(partial, "missing", @hocon.Number("7")),
  )
  assert_eq(@hocon.get_int(complete, "a.x"), 1)
  assert_eq(@hocon.get_int(complete, "a.y"), 2)
  assert_eq(
    @hocon.render_value(raw),
    "{\"a\":${missing},\"a\":{\"x\":1},\"a\":{\"y\":2}}",
  )
}
