// Native reference results for core child views and enclosing lookback after wrapping.

///|
fn persistent_state(config : @hocon.Value, paths : Array[String]) -> Json raise {
  let result : Map[String, Json] = {
    "resolved": @hocon.is_resolved(config).to_json(),
  }
  if @hocon.is_resolved(config) {
    result["value"] = @json.parse(config.to_json_string())
  }
  let probes : Map[String, Json] = Map([])
  for path in paths {
    probes[path] = Json::object({
      "accepted": true,
      "value": @json.parse(@hocon.get_value(config, path).to_json_string()),
    }) catch {
      _ => Json::object({ "accepted": false })
    }
  }
  result["probes"] = Json::object(probes)
  Json::object(result)
}

///|
test "native persistent core 3" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "{}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{}}",
    ),
  )
}

///|
test "native persistent core 4" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "{}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{}}",
    ),
  )
}

///|
test "native persistent core 31" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\nb=null", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":1},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":1,\"b\":null}}",
    ),
  )
}

///|
test "native persistent core 32" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\nb=null", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":1},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":1,\"b\":null}}",
    ),
  )
}

///|
test "native persistent core 59" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=bare", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":\"bare\"},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":\"bare\"}}",
    ),
  )
}

///|
test "native persistent core 60" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=bare", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":\"bare\"},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":\"bare\"}}",
    ),
  )
}

///|
test "native persistent core 87" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 88" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 115" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 116" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 143" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${missing},known=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":true,\"value\":1},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":true,\"value\":1},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 144" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${missing},known=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":true,\"value\":1},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 171" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[${missing},1]", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 172" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[${missing},1]", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 199" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 200" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 227" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 228" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 255" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x={z=1}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 256" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x={z=1}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 283" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 284" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 311" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 312" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 339" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":true,\"value\":2},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 340" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":true,\"value\":2},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 367" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 368" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 395" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"x\":1}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":1}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 396" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":1}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 423" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${missing}}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 424" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${missing}}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 451" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\nb=[{x=2},{x=3}]", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"x\":1}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":1}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":true,\"value\":[{\"x\":2},{\"x\":3}]},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":1},\"b\":[{\"x\":2},{\"x\":3}]}}",
    ),
  )
}

///|
test "native persistent core 452" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\nb=[{x=2},{x=3}]", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":1}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":true,\"value\":[{\"x\":2},{\"x\":3}]},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":1},\"b\":[{\"x\":2},{\"x\":3}]}}",
    ),
  )
}

///|
test "native persistent core 479" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "\"quoted.key\"={x=1}\na={\"x.y\"=2}",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"x.y\":2}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":true,\"value\":{\"x\":1}},\"a\":{\"accepted\":true,\"value\":{\"x.y\":2}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x.y\":2},\"quoted.key\":{\"x\":1}}}",
    ),
  )
}

///|
test "native persistent core 480" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "\"quoted.key\"={x=1}\na={\"x.y\"=2}",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"x\":1}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":true,\"value\":{\"x\":1}},\"a\":{\"accepted\":true,\"value\":{\"x.y\":2}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x.y\":2},\"quoted.key\":{\"x\":1}}}",
    ),
  )
}

///|
test "native persistent core 507" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "include \"part\"\na=${x}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (true, persistent_state(@hocon.get_config(raw, "a"), paths)) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 508" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "include \"part\"\na=${x}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(@hocon.get_config(raw, "\"quoted.key\""), paths),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 638" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 639" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 640" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 641" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 642" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 643" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 644" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 645" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 646" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 647" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 648" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 649" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}tail", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 650" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 651" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 652" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 653" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 654" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 655" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 656" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":[2]}},\"resolved\":true,\"value\":{\"outer\":{\"a\":[2]}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 657" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":[2]}},\"resolved\":true,\"value\":{\"outer\":{\"a\":[2]}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 658" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":[2]}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":[2]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 659" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":[2]}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":[2]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 660" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":[2]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 661" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":[2]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 662" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":1},\"x\":1,\"y\":2}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":1},\"x\":1,\"y\":2}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 663" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":1},\"x\":1,\"y\":2}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":1},\"x\":1,\"y\":2}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 664" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 665" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}},\"y\":2}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 666" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"x\":1}},\"x\":1,\"y\":2}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"x\":1}},\"x\":1,\"y\":2}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 667" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"x\":1}},\"x\":1,\"y\":2}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"x\":1}},\"x\":1,\"y\":2}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 668" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 669" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 670" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 671" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 672" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 673" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na=${a} {y=2}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 674" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 675" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 676" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 677" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 678" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 679" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 680" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 681" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 682" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 683" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 684" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 685" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 686" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 687" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 688" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 689" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 690" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 691" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 692" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 693" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 694" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":{}}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 695" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":{}}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 696" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 697" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=${?a}}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":{}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 698" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 699" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 700" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 701" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 702" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 703" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 704" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 705" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 706" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 707" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 708" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 709" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 710" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 711" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 712" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 713" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"x\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 714" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 715" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"x\":{\"a\":{\"a\":{\"x\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 716" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"x\":1}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"x\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 717" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"x\":1}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"x\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 718" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":1}}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":{\"x\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 719" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":{\"x\":1}}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":{\"x\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 720" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":{\"x\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 721" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na.x=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":{\"x\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 722" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 723" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 724" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 725" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 726" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 727" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 728" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 729" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 730" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 731" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 732" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 733" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 734" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 735" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 736" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 737" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 738" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 739" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 740" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 741" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 742" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 743" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 744" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 745" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 746" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 747" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 748" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 749" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 750" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 751" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 752" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 753" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 754" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 755" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 756" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 757" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${?a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 758" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 759" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 760" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 761" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 762" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 763" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 764" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 765" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 766" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 767" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 768" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 769" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${b}\nb=${a}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 770" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 771" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 772" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 773" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 774" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 775" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 776" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 777" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 778" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 779" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 780" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 781" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 782" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 783" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":1}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 784" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 785" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":1}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 786" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 787" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 788" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 789" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 790" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 791" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 792" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 793" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=1\na=${a}${?missing}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 794" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 795" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":1}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 796" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 797" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 798" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 799" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":{\"a\":1}}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 800" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 801" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 802" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 803" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 804" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 805" {
  let raw = @hocon.parse_sources_unresolved(
    {
      name: "<string>",
      content: "a=1\na=${a}tail\na=${a}more",
      format: "hocon",
    },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 806" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 807" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 808" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 809" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 810" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 811" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 812" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":[3]}},\"resolved\":true,\"value\":{\"outer\":{\"a\":[3]}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 813" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":[3]}},\"resolved\":true,\"value\":{\"outer\":{\"a\":[3]}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 814" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":[3]}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":[3]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 815" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":true,\"value\":{\"a\":[3]}}},\"resolved\":true,\"value\":{\"outer\":{\"a\":{\"a\":[3]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 816" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":[3]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 817" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=[1]\na+=2\na+=3", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"outer\":{\"x\":{\"a\":[3]}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 818" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 819" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 820" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 821" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":true,\"value\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":true,\"value\":{\"a\":{\"x\":{\"a\":{\"x\":{\"a\":{\"x\":1}}}}}}}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 822" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 823" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 824" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 825" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 826" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 827" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 828" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 829" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a={x=1}\na={x=${a.x}tail}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 830" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 831" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 832" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 833" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 834" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 835" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "a.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 836" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 837" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 838" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 839" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.a"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 840" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=false),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(observed, (false, @json.parse("null")))
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}

///|
test "native persistent core 841" {
  let raw = @hocon.parse_sources_unresolved(
    { name: "<string>", content: "a=${missing}\na={x=1}", format: "hocon", },
    includes={ "part": "x=3" },
    object_only=true,
  )
  let paths = [
    "a", "a.x", "a.known", "b", "missing", "known", "outer.a", "\"quoted.key\"",
  ]
  let observed = (
    true,
    persistent_state(
      @hocon.resolve(@hocon.at_path(raw, "outer.x"), allow_unresolved=true),
      paths,
    ),
  ) catch {
    _ => (false, Json::null())
  }
  assert_eq(
    observed,
    (
      true,
      @json.parse(
        "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":false},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
      ),
    ),
  )
  assert_eq(
    persistent_state(raw, paths),
    @json.parse(
      "{\"probes\":{\"\\\"quoted.key\\\"\":{\"accepted\":false},\"a\":{\"accepted\":false},\"a.known\":{\"accepted\":false},\"a.x\":{\"accepted\":true,\"value\":1},\"b\":{\"accepted\":false},\"known\":{\"accepted\":false},\"missing\":{\"accepted\":false},\"outer.a\":{\"accepted\":false}},\"resolved\":false}",
    ),
  )
}
