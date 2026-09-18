///|
enum SelectedColor {
  Red
  Green
} derive(Eq, Debug)

///|
test "enum getters return caller-defined enum values" {
  let choices = { "RED": Red, "GREEN": Green }
  assert_eq(@hocon.get_enum(@hocon.parse("a=RED"), "a", choices), Red)
  assert_eq(@hocon.get_enum_list(@hocon.parse("a=[RED,GREEN]"), "a", choices), [
    Red,
    Green,
  ])
  assert_true(
    try {
      ignore(@hocon.get_enum(@hocon.parse("a=red"), "a", choices))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "number subtypes and negative zero bits survive serialization" {
  let config = @hocon.parse("a=1\nb=\"1\"\nc=1.0\nd=\"1.0\"\ne=\"-0.0\"")
  assert_eq(@hocon.get_number(config, "a"), @hocon.Integer(1))
  assert_eq(@hocon.get_number(config, "b"), @hocon.Long(1L))
  assert_eq(@hocon.get_number(config, "c"), @hocon.Integer(1))
  assert_eq(@hocon.get_number(config, "d"), @hocon.Floating(1.0))
  assert_eq(
    @hocon.get_number(config, "e").to_json(),
    @json.parse(
      "{\"kind\":\"double\",\"value\":\"-0.0\",\"bits\":\"-9223372036854775808\"}",
    ),
  )
}

///|
test "object and generic collections detach all nested mutable values" {
  let config = @hocon.parse("a={x=[1]}\nb=[{x=[2]},null]")
  let fields = @hocon.get_object(config, "a")
  if fields["x"] is @hocon.List(xs) {
    xs.clear()
  }
  let values = @hocon.get_any_ref_list(config, "b")
  if values[0] is @hocon.Object(fields) {
    fields.clear()
  }
  let value = @hocon.get_any_ref(config, "a")
  if value is @hocon.Object(fields) {
    fields.clear()
  }
  let objects = @hocon.get_object_list(@hocon.parse("a=[{x=[1]}]"), "a")
  if objects[0]["x"] is @hocon.List(xs) {
    xs.clear()
  }
  assert_eq(
    config.to_json_string(),
    "{\"a\":{\"x\":[1]},\"b\":[{\"x\":[2]},null]}",
  )
}

///|
test "raw objects can be copied but generic unwrap requires resolution" {
  let raw = @hocon.parse_unresolved("a={x=${missing}}\nb=[${missing}]\nc=bare")
  assert_false(@hocon.is_resolved(@hocon.Object(@hocon.get_object(raw, "a"))))
  for path in ["a", "b"] {
    assert_true(
      try {
        ignore(@hocon.get_any_ref(raw, path))
        false
      } catch {
        _ => true
      },
    )
  }
  assert_true(
    try {
      ignore(@hocon.get_any_ref_list(raw, "b"))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(@hocon.get_any_ref(raw, "c"), @hocon.Text("bare"))
  let nested = @hocon.get_any_ref(
    @hocon.parse_unresolved("a={s=bare,items=[bare]}"),
    "a",
  )
  assert_eq(@hocon.get(nested, "s"), Some(@hocon.Text("bare")))
  assert_eq(@hocon.get_list(nested, "items"), [@hocon.Text("bare")])
}

///|
test "HOCON oversized integer becomes text and JSON oversized integer rejects" {
  let config = @hocon.parse("a=9223372036854775808")
  assert_eq(@hocon.get_any_ref(config, "a"), @hocon.Text("9223372036854775808"))
  assert_true(
    try {
      ignore(
        @hocon.parse_sources({
          name: "source.json",
          content: "{\"a\":9223372036854775808}",
          format: "json",
        }),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "JSON number spellings retain traversal order across arrays and quoted keys" {
  let config = @hocon.parse_sources({
    name: "source.json",
    content: "{\"9\":1.00,\"2\":[2e3,{\"1\":3.0}],\"x\\u0031\":9223372036854775807}",
    format: "json",
  })
  assert_eq(@hocon.get_as_string(config, "9"), "1.00")
  assert_eq(@hocon.get_long(config, "x1"), 9223372036854775807L)
  assert_eq(
    config.to_json_string(),
    "{\"2\":[2e3,{\"1\":3.0}],\"9\":1.00,\"x1\":9223372036854775807}",
  )
}

///|
test "Unicode decimal integer conversion uses BMP Java char semantics" {
  let config = @hocon.parse("a=\"１２\"\nb={\"١\"=2,\"٠\"=1}")
  assert_eq(@hocon.get_number(config, "a"), @hocon.Long(12L))
  assert_eq(@hocon.get_double(config, "a"), 12.0)
  assert_eq(@hocon.get_int_list(config, "b"), [1, 2])
  assert_true(
    try {
      ignore(@hocon.get_number(@hocon.parse("a=\"𝟙\""), "a"))
      false
    } catch {
      _ => true
    },
  )
}
