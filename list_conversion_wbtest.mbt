///|
test "list conversion preserves element errors and raw scalar coercion" {
  for
    (value, expected) in [
      (Null, "null path: value"),
      (Reference("missing"), "unresolved path: value"),
    ] {
    let config = Object({ "items": List([value]) })
    let error = try {
      ignore(get_double_list(config, "items"))
      "accepted"
    } catch {
      Invalid(message) => message
      _ => "different error"
    }
    assert_eq(error, expected)
  }
  let config = Object({ "items": List([Bare("yes"), Bare("off")]) })
  assert_eq(get_bool_list(config, "items"), [true, false])
  assert_eq(get_string_list(config, "items"), ["yes", "off"])
}

///|
test "list conversion returns fresh arrays and deep object copies" {
  let child = Object({ "nested": List([Number("1")]) })
  let config = Object({
    "numbers": List([Number("0.1"), Text("-0.0")]),
    "objects": List([child]),
  })
  let numbers = get_double_list(config, "numbers")
  numbers[0] = 123.0
  assert_eq(get_double_list(config, "numbers")[0], 0.1)
  assert_eq(
    get_double_list(config, "numbers")[1].reinterpret_as_int64(),
    -9223372036854775808L,
  )
  let objects = get_object_list(config, "objects")
  objects[0]["nested"] = Null
  assert_eq(get_as_list(get_config_list(config, "objects")[0], "nested"), [
    Number("1"),
  ])
}

///|
test "config lists retain known unresolved objects and reject scalar elements" {
  let document = parse_unresolved("items=[{x=${missing}}]")
  let objects = get_config_list(document, "items")
  assert_eq(objects.length(), 1)
  assert_true(!is_resolved(objects[0]))
  let error = try {
    ignore(get_config_list(Object({ "items": List([Null]) }), "items"))
    "accepted"
  } catch {
    Invalid(message) => message
    _ => "different error"
  }
  assert_eq(error, "expected object-compatible value")
}
