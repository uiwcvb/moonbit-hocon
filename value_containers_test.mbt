///|
test "value container copies retain barriers without sharing mutable maps" {
  let high = @hocon.Object({ "x": @hocon.List([@hocon.Number("1")]) })
  let bounded = @hocon.value_with_fallback(high, @hocon.Null)
  let fallback = @hocon.Object({ "y": @hocon.Number("2") })
  let copied = @hocon.copy_value(bounded)
  guard @hocon.object_get(copied, "x") is Some(@hocon.List(items)) else {
    abort("expected list")
  }
  items.push(@hocon.Number("9"))
  assert_eq(
    @hocon.value_with_fallback(copied, fallback).to_json_string(),
    "{\"x\":[1]}",
  )
  let embedded = @hocon.at_path(copied, "outer.a")
  let selected = @hocon.with_only_path(embedded, "outer.a.x")
  let edited = @hocon.with_value(selected, "outer.a.z", @hocon.Number("3"))
  let child = @hocon.get_config(edited, "outer.a")
  assert_eq(
    @hocon.with_fallback(child, fallback).to_json_string(),
    "{\"x\":[1],\"z\":3}",
  )
  assert_eq(high.to_json_string(), "{\"x\":[1]}")
}

///|
test "value container null versus missing and detached list items" {
  let root = @hocon.parse_unresolved("a=null\nb=[{x=1}]\nc={x=1}\nc=0\nc={y=2}")
  assert_eq(@hocon.object_get(root, "a"), Some(@hocon.Null))
  assert_eq(@hocon.object_get(root, "missing"), None)
  let list = @hocon.get_value(root, "b")
  guard @hocon.list_get(list, 0) is @hocon.Object(fields) else {
    abort("expected object")
  }
  fields["x"] = @hocon.Number("99")
  assert_eq(@hocon.list_get(list, 0).to_json_string(), "{\"x\":1}")
  assert_eq(@hocon.value_type(@hocon.get_value(root, "c")), "OBJECT")
  assert_eq(@hocon.value_size(list), 1)
}
