///|
test "definition history self references append and aliased object fields" {
  let v = @hocon.parse(
    "a=1\na=${a}x\na=${a}y\nitems=[1]\nitems+=[2,3]\nobj={x=1,y=3}\nalias=${obj}\nalias.x=2\nz=${alias.y}",
  )
  assert_eq(@hocon.get_string(v, "a"), "1xy")
  assert_eq(@hocon.get_list(v, "items"), [
    @hocon.Number("1"),
    @hocon.List([@hocon.Number("2"), @hocon.Number("3")]),
  ])
  assert_eq(@hocon.get_int(v, "alias.x"), 2)
  assert_eq(@hocon.get_int(v, "z"), 3)
  assert_eq(@hocon.parse("a=[${?a}]").to_json_string(), "{\"a\":[]}")
}

///|
test "ordered fallback layers preserve scalar barriers and history" {
  let v = @hocon.parse("a={hi=1}", fallbacks=["a=0", "a={low=2}"])
  assert_eq(@hocon.get(v, "a.low"), None)
  let v = @hocon.parse("a=${a}z", fallbacks=["a=${a}y", "a=x"])
  assert_eq(@hocon.get_string(v, "a"), "xyz")
  let v = @hocon.parse("a={hi=1}", fallbacks=["a=${x}\nx=0", "a={low=2}"])
  assert_eq(@hocon.get(v, "a.low"), None)
}

///|
test "included substitutions relocate and fall back to the document root" {
  let v = @hocon.parse("nested {include \"part\"}\nnested.x=9\nroot=7", includes={
    "part": "x=1\ny=${x}\nz=${root}",
  })
  assert_eq(@hocon.get_int(v, "nested.y"), 9)
  assert_eq(@hocon.get_int(v, "nested.z"), 7)
}

///|
test "environment is explicit and null blocks fallback" {
  let v = @hocon.parse("a=${HOST}\nb=${?NONE}\nn=null\nz=${n}", environment={
    "HOST": "api",
    "n": "hidden",
  })
  assert_eq(@hocon.get_string(v, "a"), "api")
  assert_eq(@hocon.get(v, "b"), None)
  assert_true(@hocon.get_is_null(v, "z"))
  assert_true(!@hocon.has_path(v, "n"))
  assert_true(@hocon.has_path(v, "n", include_null=true))
  let list = @hocon.parse("a=${HOSTS[]}\nb=[1]\nc=${b[]}", environment={
    "HOSTS_0": "first",
    "HOSTS_1": "second",
    "HOSTS_3": "ignored",
  })
  assert_eq(@hocon.get_list(list, "a"), [
    @hocon.Text("first"),
    @hocon.Text("second"),
  ])
  assert_eq(@hocon.get_list(list, "c"), [@hocon.Number("1")])
}

///|
test "quoted paths triple quotes and Unicode whitespace" {
  let v = @hocon.parse(
    "a.\"b.c\"=\"\"\"one\nline\\n\"\"\"\nx=one\u00a0two\n\"\"=7\nflag=truefoo",
  )
  assert_eq(@hocon.get_string(v, "a.\"b.c\""), "one\nline\\n")
  assert_eq(@hocon.get_string(v, "x"), "one\u00a0two")
  assert_eq(@hocon.get_int(v, "\"\""), 7)
  assert_eq(@hocon.get_string(v, "flag"), "truefoo")
  assert_eq(@hocon.split_path("a.\"b.c\""), ["a", "b.c"])
}

///|
test "coercing accessors retain exact long and memory quantities" {
  let v = @hocon.parse(
    "n=\"1.5\"\nb=on\ns=7\nlong=\"9223372036854775807\"\nd=\"1.25ms\"\nbytes=\"2 KiB\"\nhuge=\"2 YiB\"\nindexed={2=b,0=a,x=ignore}",
  )
  assert_eq(@hocon.get_as_int(v, "n"), 1)
  assert_true(@hocon.get_as_bool(v, "b"))
  assert_eq(@hocon.get_as_string(v, "s"), "7")
  assert_eq(@hocon.get_long(v, "long").to_string(), "9223372036854775807")
  assert_eq(@hocon.get_duration(v, "d").to_string(), "1250000")
  assert_eq(@hocon.get_bytes(v, "bytes").to_string(), "2048")
  assert_eq(@hocon.get_memory_size(v, "huge"), "2417851639229258349412352")
  assert_eq(@hocon.get_as_list(v, "indexed"), [
    @hocon.Bare("a"),
    @hocon.Bare("b"),
  ])
}

///|
test "source loader carries origin required flag and syntax" {
  let observed : Array[@hocon.IncludeRequest] = []
  let loader = fn(
    req : @hocon.IncludeRequest,
  ) -> Result[Array[@hocon.IncludeSource], String] {
    observed.push(req)
    Ok([
      {
        name: "included.json",
        content: "{\"a.b\":7,\"s\":\"${literal}\"}",
        format: "json",
      },
    ])
  }
  let v = @hocon.parse_sources(
    {
      name: "app.conf",
      content: "nested {include required(file(\"part\"))}",
      format: "hocon",
    },
    loader=Some(loader),
  )
  assert_eq(observed, [
    { name: "part", kind: "file", from: "app.conf", required: true, },
  ])
  assert_eq(@hocon.get_int(v, "nested.\"a.b\""), 7)
  assert_eq(@hocon.get_string(v, "nested.s"), "${literal}")
}

///|
test "lexical errors report origin and Unicode scalar location" {
  let caught = try {
    ignore(@hocon.parse("a=1\nb=\"unfinished", source_name="app.conf"))
    false
  } catch {
    @hocon.Located(_, position) => {
      assert_eq(position.source, "app.conf")
      assert_eq(position.line, 2)
      assert_eq(position.column, 3)
      true
    }
    _ => false
  }
  assert_true(caught)
}

///|
test "Java numeric coercion accepts hexadecimal floats and rejects underscores" {
  let v = @hocon.parse(
    "hex=\"0x1.8p3\"\nmax=\"0x1.fffffffffffffp1023\"\ntiny=\"0x1p-1074\"\nover=\"1e309\"\nbad=\"1_000\"\nsuffix=\"1.5d\"",
  )
  assert_eq(@hocon.get_double(v, "hex"), 12.0)
  assert_true(!@hocon.get_double(v, "max").is_inf())
  assert_true(@hocon.get_double(v, "tiny") > 0.0)
  assert_true(@hocon.get_double(v, "over").is_inf())
  assert_eq(@hocon.get_double(v, "suffix"), 1.5)
  assert_true(
    try {
      ignore(@hocon.get_long(v, "bad"))
      false
    } catch {
      _ => true
    },
  )
}
