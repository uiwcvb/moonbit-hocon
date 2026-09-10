///|
test "typed JSON arrays scalars and exact number spelling" {
  let v = @hocon.parse(
    "n=-1.25e+3\nb=true\nx=null\ns=\"123\"\na=[1,false,null,{x=2},[3,4],]",
  )
  assert_eq(@hocon.get(v, "n"), Some(@hocon.Number("-1.25e+3")))
  assert_eq(@hocon.get(v, "x"), Some(@hocon.Null))
  assert_eq(@hocon.get_string(v, "s"), "123")
  assert_true(@hocon.get_bool(v, "b"))
  assert_eq(@hocon.get_list(v, "a").length(), 5)
  assert_eq(@hocon.parse("[1\n2\n3]").to_json_string(), "[1,2,3]")
  assert_true(
    try {
      ignore(@hocon.get_int(v, "s"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(@hocon.get_string(v, "b"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "typed substitutions preserve values and quoted path segments" {
  let v = @hocon.parse(
    "a=[1,true]\nb=${a}\nc=${?missing}\nx=[0,${?missing},${a}]\n\"a.b\"=7\nz=${\"a.b\"}",
  )
  assert_eq(@hocon.get(v, "a"), @hocon.get(v, "b"))
  assert_eq(@hocon.get_int(@hocon.parse("a={x=1}\nb=${a}\nc=${b.x}"), "c"), 1)
  assert_eq(@hocon.get(v, "c"), None)
  assert_eq(@hocon.get_path(v, ["a.b"]), Some(@hocon.Number("7")))
  assert_eq(@hocon.get_int(v, "z"), 7)
  assert_eq(@hocon.get_list(v, "x").length(), 2)
  assert_eq(@hocon.get_int(@hocon.parse("x=7\nx=${?absent}"), "x"), 7)
}

///|
test "typed concatenations and merging respect type barriers" {
  let v = @hocon.parse(
    "port=80\nhost=api\nurl=${host}\":\"${port}\nmessage=hello  world\na=[1] [2,3]\nb={x=1} {y=2}\nc={x=1}\nc=null\nc={y=2}",
  )
  assert_eq(@hocon.get_string(v, "url"), "api:80")
  assert_eq(@hocon.get_string(v, "message"), "hello  world")
  assert_eq(@hocon.get_list(v, "a"), [
    @hocon.Number("1"),
    @hocon.Number("2"),
    @hocon.Number("3"),
  ])
  assert_eq(@hocon.get_int(v, "b.x"), 1)
  assert_eq(@hocon.get_int(v, "b.y"), 2)
  assert_eq(@hocon.get(v, "c.x"), None)
  for
    source in [
      "a=[1] text", "a={} [1]", "a=[1,,2]", "a=[,1]", "a=1,,b=2", "a=[1", "a={x=1",
      "a=\"bad\nstring\"",
    ] {
    assert_true(
      try {
        ignore(@hocon.parse(source))
        false
      } catch {
        _ => true
      },
      msg=source,
    )
  }
}

///|
test "typed required and optional includes merge before resolution" {
  let v = @hocon.parse(
    "include \"missing\"\ninclude required(file(\"base\"))\nport=9090",
    includes={
      "base": "include \"nested\"\nport=8080\nendpoint=${port}",
      "nested": "enabled=true\nitems=[1,2]",
    },
  )
  assert_eq(@hocon.get_int(v, "endpoint"), 9090)
  assert_true(@hocon.get_bool(v, "enabled"))
  assert_eq(@hocon.get_list(v, "items").length(), 2)
  assert_true(
    try {
      ignore(@hocon.parse("include required(\"missing\")"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(@hocon.parse("include \"a\"", includes={ "a": "include \"a\"" }))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "typed JSON escaping preserves Unicode and control characters" {
  let v = @hocon.parse("a=\"\\u4e2d\\u6587\\n\\t\"\nb=\"\\ud83d\\ude00\"")
  assert_eq(@hocon.get_string(v, "a"), "中文\n\t")
  assert_eq(@hocon.get_string(v, "b"), "😀")
  assert_eq(@hocon.parse(v.to_json_string()), v)
}
