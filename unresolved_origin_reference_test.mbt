// Source/line/category cases come from actual unmodified Lightbend 1.4.9 output.
// Column/offset are independently checked against the supplied text, not upstream fields.

///|
test "unresolved origin reference direct" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "direct.conf",
        content: "ready=1\nvalue = ${missing}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "direct.conf",
      offset: 16,
      line: 2,
      column: 9,
    }),
  )
}

///|
test "unresolved origin reference unicode-crlf" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "中文.conf",
        content: "# 注释😀\r\n  value = ${不存在}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "中文.conf",
      offset: 17,
      line: 2,
      column: 11,
    }),
  )
}

///|
test "unresolved origin reference concat" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "concat.conf",
        content: "x = prefix ${missing} suffix",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "concat.conf",
      offset: 11,
      line: 1,
      column: 12,
    }),
  )
}

///|
test "unresolved origin reference array" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "array.conf",
        content: "items=[1,\n  ${missing}\n]",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "array.conf",
      offset: 12,
      line: 2,
      column: 3,
    }),
  )
}

///|
test "unresolved origin reference quoted-path" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "quoted.conf",
        content: "x=${\"missing.key\"}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "quoted.conf",
      offset: 2,
      line: 1,
      column: 3,
    }),
  )
}

///|
test "unresolved origin reference include" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        {
          name: "main.conf",
          content: "include \"child.conf\"",
          format: "hocon",
        },
        includes=Map([("child.conf", "# child\nvalue = ${missing}")]),
      ),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "child.conf",
      offset: 16,
      line: 2,
      column: 9,
    }),
  )
}

///|
test "unresolved origin reference nested-include" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        {
          name: "nested-main.conf",
          content: "service {\n include \"child.conf\"\n}",
          format: "hocon",
        },
        includes=Map([("child.conf", "# child\nvalue = ${missing}")]),
      ),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "child.conf",
      offset: 16,
      line: 2,
      column: 9,
    }),
  )
}

///|
test "unresolved origin reference include-chain" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        {
          name: "chain-main.conf",
          content: "include \"middle.conf\"",
          format: "hocon",
        },
        includes=Map([
          ("middle.conf", "include \"leaf.conf\""),
          ("leaf.conf", "# leaf\nvalue = ${missing}"),
        ]),
      ),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "leaf.conf",
      offset: 15,
      line: 2,
      column: 9,
    }),
  )
}

///|
test "unresolved origin reference fallback" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        { name: "primary.conf", content: "ready=1", format: "hocon", },
        fallbacks=[
          {
            name: "fallback.conf",
            content: "# lower\nvalue = ${missing}",
            format: "hocon",
          },
        ],
      ),
    )
    None
  } catch {
    @hocon.Located(_, position) => Some(position)
    _ => None
  }
  assert_eq(
    position,
    Some(@hocon.SourcePosition::{
      source: "fallback.conf",
      offset: 16,
      line: 2,
      column: 9,
    }),
  )
}

///|
test "unresolved origin reference optional-success" {
  assert_eq(
    @hocon.parse_sources({
      name: "optional.conf",
      content: "x=${?missing}\nready=1",
      format: "hocon",
    }).to_json_string(),
    "{\"ready\":1}",
  )
}

///|
test "unresolved origin reference override-success" {
  assert_eq(
    @hocon.parse_sources({
      name: "override.conf",
      content: "x=${missing}\nx=2",
      format: "hocon",
    }).to_json_string(),
    "{\"x\":2}",
  )
}

///|
test "unresolved origin reference include-success" {
  assert_eq(
    @hocon.parse_sources(
      {
        name: "main-ok.conf",
        content: "include \"base.conf\"\ny=${x}",
        format: "hocon",
      },
      includes=Map([("base.conf", "x=3")]),
    ).to_json_string(),
    "{\"x\":3,\"y\":3}",
  )
}

///|
test "unresolved origin reference fallback-overridden-success" {
  assert_eq(
    @hocon.parse_sources(
      { name: "primary-ok.conf", content: "x=2", format: "hocon", },
      fallbacks=[
        { name: "lower.conf", content: "x=${missing}", format: "hocon", },
      ],
    ).to_json_string(),
    "{\"x\":2}",
  )
}
