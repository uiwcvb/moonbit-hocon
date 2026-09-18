///|
test "core hashes and searches observe caller mutations without retaining a cache" {
  let fields = { "a": @hocon.Number("1") }
  let value = @hocon.Object(fields)
  let initial_hash = @hocon.value_hash(value)
  fields["a"] = @hocon.Number("2")
  assert_not_eq(initial_hash, @hocon.value_hash(value))
  assert_eq(
    @hocon.value_hash(value),
    @hocon.value_hash(value_native_create("{a=2}")),
  )
  let items = [@hocon.Number("1"), value]
  let list = @hocon.List(items)
  assert_eq(@hocon.list_index_of(list, value_native_create("{a=2}")), 1)
  fields["a"] = @hocon.Number("3")
  assert_eq(@hocon.list_index_of(list, value_native_create("{a=2}")), -1)
  assert_eq(@hocon.list_index_of(list, value_native_create("{a=3}")), 1)
  items[0] = @hocon.Number("3")
  assert_eq(@hocon.list_index_of(list, @hocon.Number("3")), 0)
  assert_eq(items.length(), 2)
  assert_eq(fields.length(), 1)
}

///|
test "direct traversal bounds cyclic caller-created values" {
  let fields : Map[String, @hocon.Value] = Map([])
  let value = @hocon.Object(fields)
  fields["self"] = value
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(value).to_json()),
    Json::object({ "accepted": false }),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(value, value).to_json()),
    Json::object({ "accepted": false }),
  )
  assert_eq(
    value_native_attempt(() => {
      @hocon.list_index_of(@hocon.List([value]), value).to_json()
    }),
    Json::object({ "accepted": false }),
  )
}
