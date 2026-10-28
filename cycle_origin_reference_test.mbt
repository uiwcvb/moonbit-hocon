// Generated from same-input observed Config 1.4.9 results. See reports/hocon/evidence/cycle.
// Offset/column are text contracts, not fields returned by the upstream oracle.

///|
test "cycle reference direct" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "direct.conf",
        content: "a=${a}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "direct.conf",
      offset: 2,
      line: 1,
      column: 3,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference two" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "two.conf",
        content: "a=${b}\nb=${a}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "two.conf",
      offset: 2,
      line: 1,
      column: 3,
    }),
    Some(@hocon.SourcePosition::{
      source: "two.conf",
      offset: 9,
      line: 2,
      column: 3,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference three" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "three.conf",
        content: "a=${b}\nb=${c}\nc=${a}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "three.conf",
      offset: 2,
      line: 1,
      column: 3,
    }),
    Some(@hocon.SourcePosition::{
      source: "three.conf",
      offset: 9,
      line: 2,
      column: 3,
    }),
    Some(@hocon.SourcePosition::{
      source: "three.conf",
      offset: 16,
      line: 3,
      column: 3,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference enclosing" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "enclosing.conf",
        content: "a={b=${a}}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "enclosing.conf",
      offset: 5,
      line: 1,
      column: 6,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference include" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        {
          name: "main.conf",
          content: "include \"child.conf\"",
          format: "hocon",
        },
        includes=Map([("child.conf", "# child\na={b=${a}}")]),
      ),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "child.conf",
      offset: 13,
      line: 2,
      column: 6,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference fallback" {
  let position = try {
    ignore(
      @hocon.parse_sources(
        { name: "main.conf", content: "unrelated=1", format: "hocon", },
        fallbacks=[
          {
            name: "defaults.conf",
            content: "# default\na=${a}",
            format: "hocon",
          },
        ],
      ),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "defaults.conf",
      offset: 12,
      line: 2,
      column: 3,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference unicode" {
  let position = try {
    ignore(
      @hocon.parse_sources({
        name: "unicode.conf",
        content: "# 中文😀\r\n  a=${a}",
        format: "hocon",
      }),
    )
    None
  } catch {
    @hocon.Located(_, p) => Some(p)
    _ => None
  }
  let candidates = [
    Some(@hocon.SourcePosition::{
      source: "unicode.conf",
      offset: 11,
      line: 2,
      column: 5,
    }),
  ]
  assert_true(candidates.contains(position))
}

///|
test "cycle reference optional" {
  assert_eq(
    @hocon.parse_sources({
      name: "optional.conf",
      content: "a=${?a}",
      format: "hocon",
    }).to_json_string(),
    "{}",
  )
}

///|
test "cycle reference history" {
  assert_eq(
    @hocon.parse_sources({
      name: "history.conf",
      content: "a=[1]\na=${a} [2]",
      format: "hocon",
    }).to_json_string(),
    "{\"a\":[1,2]}",
  )
}

///|
test "cycle reference overridden" {
  assert_eq(
    @hocon.parse_sources({
      name: "overridden.conf",
      content: "a=${a}\na=3",
      format: "hocon",
    }).to_json_string(),
    "{\"a\":3}",
  )
}
