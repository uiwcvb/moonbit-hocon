// Generated from saved official HTTP JSON-source results.

///|
test "official HTTP JSON source 1" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (false, @json.parse("null")))
}

///|
test "official HTTP JSON source 2" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "﻿{\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 3" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":1,\"x\":2}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (false, @json.parse("null")))
}

///|
test "official HTTP JSON source 4" {
  let actual = try {
    let value = @hocon.parse_sources(
      {
        name: "source.json",
        content: "{\"n\":{\"x\":1,\"\\u0078\":2}}",
        format: "json",
      },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (false, @json.parse("null")))
}

///|
test "official HTTP JSON source 5" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "﻿{\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 6" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\"﻿:1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 7" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\"﻿\"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":\"﻿\"}")))
}

///|
test "official HTTP JSON source 8" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: " {\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 9" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\" :1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 10" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\" \"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":\" \"}")))
}

///|
test "official HTTP JSON source 11" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: " {\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 12" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\" :1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 13" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\" \"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":\" \"}")))
}

///|
test "official HTTP JSON source 14" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "　{\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 15" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\"　:1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 16" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\"　\"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":\"　\"}")))
}

///|
test "official HTTP JSON source 17" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "\u000b{\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 18" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\"\u000b:1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 19" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\"\u000b\"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (false, @json.parse("null")))
}

///|
test "official HTTP JSON source 20" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "\f{\"x\":1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 21" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\"\f:1}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (true, @json.parse("{\"x\":1}")))
}

///|
test "official HTTP JSON source 22" {
  let actual = try {
    let value = @hocon.parse_sources(
      { name: "source.json", content: "{\"x\":\"\f\"}", format: "json", },
      object_only=true,
    )
    (true, @json.parse(value.to_json_string()))
  } catch {
    _ => (false, Json::null())
  }
  assert_eq(actual, (false, @json.parse("null")))
}
