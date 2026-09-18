///|
test "entry leaves and paths own their mutable data" {
  let input = @hocon.parse_unresolved("a=[1,{x=2}],b=null,empty={}")
  let entries = @hocon.entry_set(input)
  assert_eq(entries.length(), 1)
  guard entries["a"] is List(items) else { fail("list leaf missing") }
  items.push(@hocon.Number("3"))
  guard items[1] is Object(fields) else { fail("object in list missing") }
  fields["x"] = @hocon.Number("99")
  entries["extra"] = @hocon.Boolean(true)
  assert_eq(
    @hocon.render_value(input),
    "{\"a\":[1,{\"x\":2}],\"b\":null,\"empty\":{}}",
  )
  assert_eq(@hocon.entry_set(input).length(), 1)
}

///|
test "enumeration keeps bounded depth and copies substitution paths" {
  let paths = ["missing"]
  let input = @hocon.Object(Map([("a", @hocon.PathReference(paths, false))]))
  let output = @hocon.entry_set(input)
  guard output["a"] is PathReference(copied, false) else {
    fail("reference lost")
  }
  copied[0] = "changed"
  assert_eq(paths[0], "missing")
  let mut deep = @hocon.Number("1")
  for _ in 0..<70 {
    deep = @hocon.Object(Map([("a", deep)]))
  }
  assert_eq(
    value_native_attempt(() => @hocon.entry_set(deep).length().to_json()),
    Json::object({ "accepted": false }),
  )
}
