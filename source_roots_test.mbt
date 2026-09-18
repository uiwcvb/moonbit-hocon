///|
test "configuration host rejects array primary and fallback sources" {
  let object = @hocon.IncludeSource::{
    name: "object.conf",
    content: "a=1",
    format: "hocon",
  }
  let array = @hocon.IncludeSource::{
    name: "array.json",
    content: "[1,2]",
    format: "json",
  }
  for (primary, fallbacks) in [(array, []), (object, [array])] {
    assert_true(
      try {
        ignore(@hocon.parse_sources(primary, fallbacks~, object_only=true))
        false
      } catch {
        _ => true
      },
    )
  }
  assert_eq(@hocon.parse_sources(array).to_json_string(), "[1,2]")
  assert_eq(
    @hocon.get_int(@hocon.parse_sources(object, object_only=true), "a"),
    1,
  )
}

///|
test "JSON configuration BOM and duplicate member spelling follow the reference" {
  let source = @hocon.IncludeSource::{
    name: "config.json",
    content: "\uFEFF{\"x\":\"\uFEFF\"}",
    format: "json",
  }
  assert_eq(@hocon.get_string(@hocon.parse_sources(source), "x"), "\uFEFF")
  for content in ["{\"x\":1,\"x\":2}", "{\"n\":{\"x\":1,\"\\u0078\":2}}"] {
    assert_true(
      try {
        ignore(@hocon.parse_sources({ ..source, content, }))
        false
      } catch {
        _ => true
      },
    )
  }
  assert_eq(
    @hocon.parse_sources({
      ..source,
      content: "{\"a\":{\"x\":1},\"b\":{\"x\":2}}",
    }).to_json_string(),
    "{\"a\":{\"x\":1},\"b\":{\"x\":2}}",
  )
}
