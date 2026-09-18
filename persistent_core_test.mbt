///|
test "child config deeply isolates mutable core values" {
  let original = @hocon.parse_unresolved("a={x=[1],b={ref=${missing}}}")
  let child = @hocon.get_config(original, "a")
  if @hocon.get(child, "x") is Some(@hocon.List(items)) {
    items.clear()
  }
  if @hocon.get(child, "b") is Some(@hocon.Object(fields)) {
    fields.clear()
  }
  assert_eq(@hocon.get_list(original, "a.x"), [@hocon.Number("1")])
  assert_false(@hocon.is_resolved(original))
  assert_true(@hocon.is_resolved(child))
}
