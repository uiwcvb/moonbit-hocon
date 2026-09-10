///|
test "nested merge dotted overwrite" {
  let v = @hocon.parse("a { x=1, y=2 }\na.x=3")
  assert_eq(@hocon.get(v, "a.x"), Some(@hocon.Text("3")))
  assert_eq(@hocon.get(v, "a.y"), Some(@hocon.Text("2")))
}

///|
test "include explicit memory map" {
  let v = @hocon.parse("include \"base\"\nport=9090", includes={
    "base": "host=\"localhost\"\nport=8080",
  })
  assert_eq(@hocon.get(v, "host"), Some(@hocon.Text("localhost")))
  assert_eq(@hocon.get(v, "port"), Some(@hocon.Text("9090")))
}

///|
test "forward reference resolved after merge" {
  let v = @hocon.parse("x=${y}\ny=42")
  assert_eq(@hocon.get(v, "x"), Some(@hocon.Text("42")))
}

///|
test "object substitution" {
  let v = @hocon.parse("a {x=1}\nb=${a}")
  assert_eq(@hocon.get(v, "a"), @hocon.get(v, "b"))
}

///|
test "cycle missing references and missing include" {
  for s in ["x=${y}\ny=${x}", "x=${missing}", "include \"missing\"", "a { x=1"] {
    assert_true(
      try {
        ignore(@hocon.parse(s))
        false
      } catch {
        _ => true
      },
    )
  }
}

///|
test "include cycle" {
  assert_true(
    try {
      ignore(
        @hocon.parse("include \"a\"", includes={
          "a": "include \"b\"",
          "b": "include \"a\"",
        }),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "quoted periods remain literal keys" {
  let v = @hocon.parse("\"a.b\"=1\na.b=2")
  match v {
    @hocon.Object(m) => {
      assert_eq(m.get("a.b"), Some(@hocon.Text("1")))
      assert_eq(@hocon.get(v, "a.b"), Some(@hocon.Text("2")))
    }
    _ => fail("expected object")
  }
}

///|
test "quoted punctuation preserved" {
  let v = @hocon.parse("a=\"{\"\nb=\"}\"\nc=\";\"")
  assert_eq(@hocon.get(v, "a"), Some(@hocon.Text("{")))
  assert_eq(@hocon.get(v, "b"), Some(@hocon.Text("}")))
}
