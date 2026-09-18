// Generated from saved unmodified Lightbend Config 1.4.9 results.
// Regenerate with node tools/generate-collection-tests.mjs, then moon fmt.

///|
fn collection_result(
  source : String,
  fallbacks : Array[String],
  kind : String,
  path : String,
) -> (Bool, Json) {
  try {
    let config = @hocon.parse(source, fallbacks~)
    let value = match kind {
      "string-list" => @hocon.get_string_list(config, path).to_json()
      "boolean-list" => @hocon.get_bool_list(config, path).to_json()
      "int-list" => @hocon.get_int_list(config, path).to_json()
      "long-list" =>
        @hocon.get_long_list(config, path).map(n => n.to_string()).to_json()
      "double-list" =>
        @hocon.get_double_list(config, path)
        .map(n => {
          if n.is_nan() {
            "NaN".to_json()
          } else if n.is_inf() {
            (if n > 0 { "Infinity" } else { "-Infinity" }).to_json()
          } else {
            n.to_json()
          }
        })
        .to_json()
      "duration-list" =>
        @hocon.get_duration_list(config, path).map(n => n.to_string()).to_json()
      "bytes-list" =>
        @hocon.get_bytes_list(config, path).map(n => n.to_string()).to_json()
      "memory-list" => @hocon.get_memory_size_list(config, path).to_json()
      "config" => @json.parse(@hocon.get_config(config, path).to_json_string())
      "config-list" =>
        @json.parse(
          @hocon.List(@hocon.get_config_list(config, path)).to_json_string(),
        )
      _ => abort("unknown generated collection getter")
    }
    (true, value)
  } catch {
    _ => (false, Json::null())
  }
}

///|
test "official collection 0: string-list" {
  assert_eq(
    collection_result("a=[]", [], "string-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 1: string-list" {
  assert_eq(
    collection_result("a=[null]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 2: string-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "string-list", "a"),
    (true, @json.parse("[\"1\",\"true\",\"false\"]")),
  )
}

///|
test "official collection 3: string-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1\",\"2.5\"]")),
  )
}

///|
test "official collection 4: string-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "string-list", "a"),
    (true, @json.parse("[\"2147483648\",\"-2147483649\"]")),
  )
}

///|
test "official collection 5: string-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "string-list", "a"),
    (true, @json.parse("[\"2147483648\"]")),
  )
}

///|
test "official collection 6: string-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "string-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 7: string-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "string-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 8: string-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"NaN\",\"Infinity\",\"-Infinity\"]")),
  )
}

///|
test "official collection 9: string-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "string-list", "a"),
    (true, @json.parse("[\"yes\",\"off\"]")),
  )
}

///|
test "official collection 10: string-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "string-list", "a"),
    (true, @json.parse("[\"1.5\",\"-1.5\"]")),
  )
}

///|
test "official collection 11: string-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1.5ms\",\"2s\"]")),
  )
}

///|
test "official collection 12: string-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1 KiB\",\"2 GB\"]")),
  )
}

///|
test "official collection 13: string-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 14: string-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "string-list", "a"),
    (true, @json.parse("[\"a\",\"b\"]")),
  )
}

///|
test "official collection 15: string-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 16: string-list" {
  assert_eq(
    collection_result("a={}", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 17: string-list" {
  assert_eq(
    collection_result("a=null", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 18: string-list" {
  assert_eq(
    collection_result("a=1", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 19: string-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 20: string-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "string-list", "a"),
    (true, @json.parse("[\"on\",\"false\"]")),
  )
}

///|
test "official collection 21: string-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "string-list", "a"),
    (true, @json.parse("[\"TRUE\"]")),
  )
}

///|
test "official collection 22: string-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "string-list", "a"),
    (true, @json.parse("[\" 1 \",\"0x1p3\"]")),
  )
}

///|
test "official collection 23: string-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e309\"]")),
  )
}

///|
test "official collection 24: string-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"9223372036854775808\",\"-9223372036854775809\"]")),
  )
}

///|
test "official collection 25: string-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "string-list", "a"),
    (true, @json.parse("[\"-0.5\",\"0\",\"1e3\"]")),
  )
}

///|
test "official collection 26: string-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 27: string-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 28: string-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 29: string-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "string-list", "a"),
    (true, @json.parse("[\"a\",\"b\",\"c\"]")),
  )
}

///|
test "official collection 30: string-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "string-list", "a"),
    (true, @json.parse("[\"c\"]")),
  )
}

///|
test "official collection 31: string-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "string-list", "a"),
    (true, @json.parse("[\"a\"]")),
  )
}

///|
test "official collection 32: string-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "string-list", "a"),
    (true, @json.parse("[\"b\"]")),
  )
}

///|
test "official collection 33: string-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 34: string-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "string-list", "a"),
    (true, @json.parse("[\"0.001ns\",\"-0.001ns\"]")),
  )
}

///|
test "official collection 35: string-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e30 bytes\"]")),
  )
}

///|
test "official collection 36: string-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "string-list", "a"),
    (true, @json.parse("[\"-1 byte\"]")),
  )
}

///|
test "official collection 37: string-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1.5 KiB\"]")),
  )
}

///|
test "official collection 38: string-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 39: string-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "string-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 40: boolean-list" {
  assert_eq(
    collection_result("a=[]", [], "boolean-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 41: boolean-list" {
  assert_eq(
    collection_result("a=[null]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 42: boolean-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 43: boolean-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 44: boolean-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 45: boolean-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 46: boolean-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 47: boolean-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 48: boolean-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "boolean-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 49: boolean-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "boolean-list", "a"),
    (true, @json.parse("[true,false]")),
  )
}

///|
test "official collection 50: boolean-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 51: boolean-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 52: boolean-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 53: boolean-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 54: boolean-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 55: boolean-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 56: boolean-list" {
  assert_eq(
    collection_result("a={}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 57: boolean-list" {
  assert_eq(
    collection_result("a=null", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 58: boolean-list" {
  assert_eq(
    collection_result("a=1", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 59: boolean-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 60: boolean-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "boolean-list", "a"),
    (true, @json.parse("[true,false]")),
  )
}

///|
test "official collection 61: boolean-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 62: boolean-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 63: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 64: boolean-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "boolean-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 65: boolean-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 66: boolean-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 67: boolean-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 68: boolean-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 69: boolean-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 70: boolean-list" {
  assert_eq(
    collection_result(
      "a={\"01\"=a,\"1\"=b,\"0001\"=c}",
      [],
      "boolean-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 71: boolean-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 72: boolean-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 73: boolean-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 74: boolean-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 75: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 76: boolean-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 77: boolean-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 78: boolean-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 79: boolean-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "boolean-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 80: int-list" {
  assert_eq(
    collection_result("a=[]", [], "int-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 81: int-list" {
  assert_eq(
    collection_result("a=[null]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 82: int-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 83: int-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "int-list", "a"),
    (true, @json.parse("[1,2]")),
  )
}

///|
test "official collection 84: int-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 85: int-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 86: int-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 87: int-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 88: int-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "int-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 89: int-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 90: int-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "int-list", "a"),
    (true, @json.parse("[1,-1]")),
  )
}

///|
test "official collection 91: int-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 92: int-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 93: int-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 94: int-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 95: int-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 96: int-list" {
  assert_eq(
    collection_result("a={}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 97: int-list" {
  assert_eq(
    collection_result("a=null", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 98: int-list" {
  assert_eq(
    collection_result("a=1", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 99: int-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 100: int-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 101: int-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 102: int-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "int-list", "a"),
    (true, @json.parse("[1,8]")),
  )
}

///|
test "official collection 103: int-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 104: int-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "int-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 105: int-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "int-list", "a"),
    (true, @json.parse("[0,0,1000]")),
  )
}

///|
test "official collection 106: int-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 107: int-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 108: int-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 109: int-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 110: int-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 111: int-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 112: int-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 113: int-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 114: int-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 115: int-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 116: int-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 117: int-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 118: int-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 119: int-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "int-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 120: long-list" {
  assert_eq(
    collection_result("a=[]", [], "long-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 121: long-list" {
  assert_eq(
    collection_result("a=[null]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 122: long-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 123: long-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 124: long-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "long-list", "a"),
    (true, @json.parse("[\"2147483648\",\"-2147483649\"]")),
  )
}

///|
test "official collection 125: long-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "long-list", "a"),
    (true, @json.parse("[\"2147483648\"]")),
  )
}

///|
test "official collection 126: long-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 127: long-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 128: long-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "long-list",
      "a",
    ),
    (
      true,
      @json.parse("[\"0\",\"9223372036854775807\",\"-9223372036854775808\"]"),
    ),
  )
}

///|
test "official collection 129: long-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 130: long-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "long-list", "a"),
    (true, @json.parse("[\"1\",\"-1\"]")),
  )
}

///|
test "official collection 131: long-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 132: long-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 133: long-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 134: long-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 135: long-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 136: long-list" {
  assert_eq(
    collection_result("a={}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 137: long-list" {
  assert_eq(
    collection_result("a=null", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 138: long-list" {
  assert_eq(
    collection_result("a=1", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 139: long-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 140: long-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 141: long-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 142: long-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\",\"8\"]")),
  )
}

///|
test "official collection 143: long-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 144: long-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "long-list",
      "a",
    ),
    (true, @json.parse("[\"9223372036854775807\",\"-9223372036854775808\"]")),
  )
}

///|
test "official collection 145: long-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "long-list", "a"),
    (true, @json.parse("[\"0\",\"0\",\"1000\"]")),
  )
}

///|
test "official collection 146: long-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 147: long-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 148: long-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 149: long-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 150: long-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 151: long-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 152: long-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 153: long-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 154: long-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 155: long-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 156: long-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 157: long-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 158: long-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 159: long-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "long-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 160: double-list" {
  assert_eq(
    collection_result("a=[]", [], "double-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 161: double-list" {
  assert_eq(
    collection_result("a=[null]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 162: double-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 163: double-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "double-list", "a"),
    (true, @json.parse("[1,2.5]")),
  )
}

///|
test "official collection 164: double-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "double-list", "a"),
    (true, @json.parse("[2147483648,-2147483649]")),
  )
}

///|
test "official collection 165: double-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "double-list", "a"),
    (true, @json.parse("[2147483648]")),
  )
}

///|
test "official collection 166: double-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "double-list", "a"),
    (true, @json.parse("[9223372036854776000]")),
  )
}

///|
test "official collection 167: double-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "double-list", "a"),
    (true, @json.parse("[9223372036854776000]")),
  )
}

///|
test "official collection 168: double-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "double-list",
      "a",
    ),
    (true, @json.parse("[\"NaN\",\"Infinity\",\"-Infinity\"]")),
  )
}

///|
test "official collection 169: double-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 170: double-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "double-list", "a"),
    (true, @json.parse("[1.5,-1.5]")),
  )
}

///|
test "official collection 171: double-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 172: double-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 173: double-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 174: double-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 175: double-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 176: double-list" {
  assert_eq(
    collection_result("a={}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 177: double-list" {
  assert_eq(
    collection_result("a=null", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 178: double-list" {
  assert_eq(
    collection_result("a=1", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 179: double-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 180: double-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 181: double-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 182: double-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "double-list", "a"),
    (true, @json.parse("[1,8]")),
  )
}

///|
test "official collection 183: double-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "double-list", "a"),
    (true, @json.parse("[\"Infinity\"]")),
  )
}

///|
test "official collection 184: double-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "double-list",
      "a",
    ),
    (true, @json.parse("[9223372036854776000,-9223372036854776000]")),
  )
}

///|
test "official collection 185: double-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "double-list", "a"),
    (true, @json.parse("[-0.5,0,1000]")),
  )
}

///|
test "official collection 186: double-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 187: double-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 188: double-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 189: double-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 190: double-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 191: double-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 192: double-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 193: double-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 194: double-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 195: double-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 196: double-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 197: double-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 198: double-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 199: double-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "double-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 200: duration-list" {
  assert_eq(
    collection_result("a=[]", [], "duration-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 201: duration-list" {
  assert_eq(
    collection_result("a=[null]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 202: duration-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 203: duration-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\",\"2500000\"]")),
  )
}

///|
test "official collection 204: duration-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "duration-list", "a"),
    (true, @json.parse("[\"2147483648000000\",\"-2147483649000000\"]")),
  )
}

///|
test "official collection 205: duration-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"2147483648000000\"]")),
  )
}

///|
test "official collection 206: duration-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 207: duration-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 208: duration-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "duration-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 209: duration-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 210: duration-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\",\"-1000000\"]")),
  )
}

///|
test "official collection 211: duration-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1500000\",\"2000000000\"]")),
  )
}

///|
test "official collection 212: duration-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 213: duration-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 214: duration-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 215: duration-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 216: duration-list" {
  assert_eq(
    collection_result("a={}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 217: duration-list" {
  assert_eq(
    collection_result("a=null", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 218: duration-list" {
  assert_eq(
    collection_result("a=1", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 219: duration-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 220: duration-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 221: duration-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 222: duration-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\",\"8000000\"]")),
  )
}

///|
test "official collection 223: duration-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 224: duration-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "duration-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 225: duration-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "duration-list", "a"),
    (true, @json.parse("[\"0\",\"0\",\"1000000000\"]")),
  )
}

///|
test "official collection 226: duration-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 227: duration-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 228: duration-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 229: duration-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 230: duration-list" {
  assert_eq(
    collection_result(
      "a={\"01\"=a,\"1\"=b,\"0001\"=c}",
      [],
      "duration-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 231: duration-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 232: duration-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 233: duration-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 234: duration-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"0\",\"0\"]")),
  )
}

///|
test "official collection 235: duration-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 236: duration-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 237: duration-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 238: duration-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 239: duration-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "duration-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 240: bytes-list" {
  assert_eq(
    collection_result("a=[]", [], "bytes-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 241: bytes-list" {
  assert_eq(
    collection_result("a=[null]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 242: bytes-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 243: bytes-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 244: bytes-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 245: bytes-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"2147483648\"]")),
  )
}

///|
test "official collection 246: bytes-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "bytes-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 247: bytes-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 248: bytes-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "bytes-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 249: bytes-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 250: bytes-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 251: bytes-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 252: bytes-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1024\",\"2000000000\"]")),
  )
}

///|
test "official collection 253: bytes-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 254: bytes-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 255: bytes-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 256: bytes-list" {
  assert_eq(
    collection_result("a={}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 257: bytes-list" {
  assert_eq(
    collection_result("a=null", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 258: bytes-list" {
  assert_eq(
    collection_result("a=1", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 259: bytes-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 260: bytes-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 261: bytes-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 262: bytes-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 263: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 264: bytes-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "bytes-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 265: bytes-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\",\"0\",\"1000\"]")),
  )
}

///|
test "official collection 266: bytes-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 267: bytes-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 268: bytes-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 269: bytes-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 270: bytes-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 271: bytes-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 272: bytes-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 273: bytes-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 274: bytes-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 275: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 276: bytes-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 277: bytes-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1536\"]")),
  )
}

///|
test "official collection 278: bytes-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 279: bytes-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "bytes-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 280: memory-list" {
  assert_eq(
    collection_result("a=[]", [], "memory-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 281: memory-list" {
  assert_eq(
    collection_result("a=[null]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 282: memory-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 283: memory-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 284: memory-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 285: memory-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"2147483648\"]")),
  )
}

///|
test "official collection 286: memory-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "memory-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 287: memory-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 288: memory-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "memory-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 289: memory-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 290: memory-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 291: memory-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 292: memory-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1024\",\"2000000000\"]")),
  )
}

///|
test "official collection 293: memory-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 294: memory-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 295: memory-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 296: memory-list" {
  assert_eq(
    collection_result("a={}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 297: memory-list" {
  assert_eq(
    collection_result("a=null", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 298: memory-list" {
  assert_eq(
    collection_result("a=1", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 299: memory-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 300: memory-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 301: memory-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 302: memory-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 303: memory-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "memory-list", "a"),
    (
      true,
      @json.parse(
        "[\"1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\"]",
      ),
    ),
  )
}

///|
test "official collection 304: memory-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "memory-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 305: memory-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\",\"0\",\"1000\"]")),
  )
}

///|
test "official collection 306: memory-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 307: memory-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 308: memory-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 309: memory-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 310: memory-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 311: memory-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 312: memory-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 313: memory-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 314: memory-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 315: memory-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1000000000000000000000000000000\"]")),
  )
}

///|
test "official collection 316: memory-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 317: memory-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1536\"]")),
  )
}

///|
test "official collection 318: memory-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 319: memory-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "memory-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 320: config-list" {
  assert_eq(
    collection_result("a=[]", [], "config-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 321: config-list" {
  assert_eq(
    collection_result("a=[null]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 322: config-list" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 323: config-list" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 324: config-list" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 325: config-list" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 326: config-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 327: config-list" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 328: config-list" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "config-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 329: config-list" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 330: config-list" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 331: config-list" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 332: config-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 333: config-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "config-list", "a"),
    (true, @json.parse("[{\"x\":1},{\"x\":null}]")),
  )
}

///|
test "official collection 334: config-list" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 335: config-list" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "config-list", "a"),
    (true, @json.parse("[{\"x\":1},{\"x\":2}]")),
  )
}

///|
test "official collection 336: config-list" {
  assert_eq(
    collection_result("a={}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 337: config-list" {
  assert_eq(
    collection_result("a=null", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 338: config-list" {
  assert_eq(
    collection_result("a=1", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 339: config-list" {
  assert_eq(
    collection_result("a=\"x\"", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 340: config-list" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 341: config-list" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 342: config-list" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 343: config-list" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 344: config-list" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "config-list",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 345: config-list" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 346: config-list" {
  assert_eq(
    collection_result("a=[[],{}]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 347: config-list" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 348: config-list" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 349: config-list" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 350: config-list" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 351: config-list" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 352: config-list" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 353: config-list" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 354: config-list" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 355: config-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 356: config-list" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 357: config-list" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 358: config-list" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "config-list", "a"),
    (true, @json.parse("[{\"a.b\":1},{\"a\":{\"b\":2}}]")),
  )
}

///|
test "official collection 359: config-list" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "config-list", "a"),
    (true, @json.parse("[]")),
  )
}

///|
test "official collection 360: config" {
  assert_eq(
    collection_result("a=[]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 361: config" {
  assert_eq(
    collection_result("a=[null]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 362: config" {
  assert_eq(
    collection_result("a=[1,true,false]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 363: config" {
  assert_eq(
    collection_result("a=[\"1\",\"2.5\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 364: config" {
  assert_eq(
    collection_result("a=[2147483648,-2147483649]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 365: config" {
  assert_eq(
    collection_result("a=[\"2147483648\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 366: config" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 367: config" {
  assert_eq(
    collection_result("a=[\"9223372036854775807\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 368: config" {
  assert_eq(
    collection_result(
      "a=[\"NaN\",\"Infinity\",\"-Infinity\"]",
      [],
      "config",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 369: config" {
  assert_eq(
    collection_result("a=[\"yes\",\"off\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 370: config" {
  assert_eq(
    collection_result("a=[1.5,-1.5]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 371: config" {
  assert_eq(
    collection_result("a=[\"1.5ms\",\"2s\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 372: config" {
  assert_eq(
    collection_result("a=[\"1 KiB\",\"2 GB\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 373: config" {
  assert_eq(
    collection_result("a=[{x=1},{x=null}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 374: config" {
  assert_eq(
    collection_result("a={0=a,2=b,foo=c}", [], "config", "a"),
    (true, @json.parse("{\"0\":\"a\",\"2\":\"b\",\"foo\":\"c\"}")),
  )
}

///|
test "official collection 375: config" {
  assert_eq(
    collection_result("a={0={x=1},2={x=2}}", [], "config", "a"),
    (true, @json.parse("{\"0\":{\"x\":1},\"2\":{\"x\":2}}")),
  )
}

///|
test "official collection 376: config" {
  assert_eq(
    collection_result("a={}", [], "config", "a"),
    (true, @json.parse("{}")),
  )
}

///|
test "official collection 377: config" {
  assert_eq(
    collection_result("a=null", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 378: config" {
  assert_eq(
    collection_result("a=1", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 379: config" {
  assert_eq(
    collection_result("a=\"x\"", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 380: config" {
  assert_eq(
    collection_result("a=[\"on\",\"false\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 381: config" {
  assert_eq(
    collection_result("a=[\"TRUE\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 382: config" {
  assert_eq(
    collection_result("a=[\" 1 \",\"0x1p3\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 383: config" {
  assert_eq(
    collection_result("a=[\"1e309\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 384: config" {
  assert_eq(
    collection_result(
      "a=[\"9223372036854775808\",\"-9223372036854775809\"]",
      [],
      "config",
      "a",
    ),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 385: config" {
  assert_eq(
    collection_result("a=[-0.5,0,1e3]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 386: config" {
  assert_eq(
    collection_result("a=[[],{}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 387: config" {
  assert_eq(
    collection_result("a=[[1,2]]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 388: config" {
  assert_eq(
    collection_result("a=[true,false,null]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 389: config" {
  assert_eq(
    collection_result("a={2=c,0=a,1=b}", [], "config", "a"),
    (true, @json.parse("{\"0\":\"a\",\"1\":\"b\",\"2\":\"c\"}")),
  )
}

///|
test "official collection 390: config" {
  assert_eq(
    collection_result("a={\"01\"=a,\"1\"=b,\"0001\"=c}", [], "config", "a"),
    (true, @json.parse("{\"1\":\"b\",\"01\":\"a\",\"0001\":\"c\"}")),
  )
}

///|
test "official collection 391: config" {
  assert_eq(
    collection_result("a={\"+1\"=a,\"1\"=b,\"-1\"=c}", [], "config", "a"),
    (true, @json.parse("{\"1\":\"b\",\"+1\":\"a\",\"-1\":\"c\"}")),
  )
}

///|
test "official collection 392: config" {
  assert_eq(
    collection_result("a={9999999999=a,0=b}", [], "config", "a"),
    (true, @json.parse("{\"0\":\"b\",\"9999999999\":\"a\"}")),
  )
}

///|
test "official collection 393: config" {
  assert_eq(
    collection_result("a={\"0\"=null,2=a}", [], "config", "a"),
    (true, @json.parse("{\"0\":null,\"2\":\"a\"}")),
  )
}

///|
test "official collection 394: config" {
  assert_eq(
    collection_result("a=[\"0.001ns\",\"-0.001ns\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 395: config" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 396: config" {
  assert_eq(
    collection_result("a=[\"-1 byte\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 397: config" {
  assert_eq(
    collection_result("a=[\"1.5 KiB\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 398: config" {
  assert_eq(
    collection_result("a=[{\"a.b\"=1},{a={b=2}}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 399: config" {
  assert_eq(
    collection_result("a=[${?MISSING}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 400: string-list" {
  assert_eq(
    collection_result("{}", [], "string-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 401: string-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "string-list", "a.\"x.y\""),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 402: string-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "string-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 403: string-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "string-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 404: boolean-list" {
  assert_eq(
    collection_result("{}", [], "boolean-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 405: boolean-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "boolean-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 406: boolean-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "boolean-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 407: boolean-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "boolean-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 408: int-list" {
  assert_eq(
    collection_result("{}", [], "int-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 409: int-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "int-list", "a.\"x.y\""),
    (true, @json.parse("[1,2]")),
  )
}

///|
test "official collection 410: int-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "int-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 411: int-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "int-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 412: long-list" {
  assert_eq(
    collection_result("{}", [], "long-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 413: long-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "long-list", "a.\"x.y\""),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 414: long-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "long-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 415: long-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "long-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 416: double-list" {
  assert_eq(
    collection_result("{}", [], "double-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 417: double-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "double-list", "a.\"x.y\""),
    (true, @json.parse("[1,2]")),
  )
}

///|
test "official collection 418: double-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "double-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 419: double-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "double-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 420: duration-list" {
  assert_eq(
    collection_result("{}", [], "duration-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 421: duration-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "duration-list", "a.\"x.y\""),
    (true, @json.parse("[\"1000000\",\"2000000\"]")),
  )
}

///|
test "official collection 422: duration-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "duration-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 423: duration-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "duration-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 424: bytes-list" {
  assert_eq(
    collection_result("{}", [], "bytes-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 425: bytes-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "bytes-list", "a.\"x.y\""),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 426: bytes-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "bytes-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 427: bytes-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "bytes-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 428: memory-list" {
  assert_eq(
    collection_result("{}", [], "memory-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 429: memory-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "memory-list", "a.\"x.y\""),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 430: memory-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "memory-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 431: memory-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "memory-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 432: config-list" {
  assert_eq(
    collection_result("{}", [], "config-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 433: config-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "config-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 434: config-list" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "config-list", "a.\"x.y\""),
    (true, @json.parse("[{\"b\":1}]")),
  )
}

///|
test "official collection 435: config-list" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "config-list", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 436: config" {
  assert_eq(
    collection_result("{}", [], "config", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 437: config" {
  assert_eq(
    collection_result("a={\"x.y\"=[1,2]}", [], "config", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 438: config" {
  assert_eq(
    collection_result("a={\"x.y\"=[{b=1}]}", [], "config", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 439: config" {
  assert_eq(
    collection_result("a={\"x.y\"=null}", [], "config", "a.\"x.y\""),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 440: string-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 441: string-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "string-list", "a"),
    (true, @json.parse("[\"2\",\"1\"]")),
  )
}

///|
test "official collection 442: string-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "string-list", "a"),
    (true, @json.parse("[\"true\",\"off\"]")),
  )
}

///|
test "official collection 443: string-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "string-list", "a"),
    (true, @json.parse("[\"off\",\"true\"]")),
  )
}

///|
test "official collection 444: string-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 445: string-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 446: string-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 447: string-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "string-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 448: string-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1s\",\"2ms\"]")),
  )
}

///|
test "official collection 449: string-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "string-list", "a"),
    (true, @json.parse("[\"2ms\",\"1s\"]")),
  )
}

///|
test "official collection 450: string-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1KiB\",\"2MB\"]")),
  )
}

///|
test "official collection 451: string-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "string-list", "a"),
    (true, @json.parse("[\"2MB\",\"1KiB\"]")),
  )
}

///|
test "official collection 452: boolean-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 453: boolean-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 454: boolean-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "boolean-list", "a"),
    (true, @json.parse("[true,false]")),
  )
}

///|
test "official collection 455: boolean-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "boolean-list", "a"),
    (true, @json.parse("[false,true]")),
  )
}

///|
test "official collection 456: boolean-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 457: boolean-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 458: boolean-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 459: boolean-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 460: boolean-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 461: boolean-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 462: boolean-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 463: boolean-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 464: int-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "int-list", "a"),
    (true, @json.parse("[1,2]")),
  )
}

///|
test "official collection 465: int-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "int-list", "a"),
    (true, @json.parse("[2,1]")),
  )
}

///|
test "official collection 466: int-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 467: int-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 468: int-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 469: int-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 470: int-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 471: int-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 472: int-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 473: int-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 474: int-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 475: int-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 476: long-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 477: long-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "long-list", "a"),
    (true, @json.parse("[\"2\",\"1\"]")),
  )
}

///|
test "official collection 478: long-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 479: long-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 480: long-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 481: long-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 482: long-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 483: long-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 484: long-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 485: long-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 486: long-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 487: long-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 488: double-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "double-list", "a"),
    (true, @json.parse("[1,2]")),
  )
}

///|
test "official collection 489: double-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "double-list", "a"),
    (true, @json.parse("[2,1]")),
  )
}

///|
test "official collection 490: double-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 491: double-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 492: double-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 493: double-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 494: double-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 495: double-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 496: double-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 497: double-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 498: double-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 499: double-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 500: duration-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\",\"2000000\"]")),
  )
}

///|
test "official collection 501: duration-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "duration-list", "a"),
    (true, @json.parse("[\"2000000\",\"1000000\"]")),
  )
}

///|
test "official collection 502: duration-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 503: duration-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 504: duration-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 505: duration-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 506: duration-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 507: duration-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 508: duration-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000000\",\"2000000\"]")),
  )
}

///|
test "official collection 509: duration-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"2000000\",\"1000000000\"]")),
  )
}

///|
test "official collection 510: duration-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 511: duration-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 512: bytes-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 513: bytes-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "bytes-list", "a"),
    (true, @json.parse("[\"2\",\"1\"]")),
  )
}

///|
test "official collection 514: bytes-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 515: bytes-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 516: bytes-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 517: bytes-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 518: bytes-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 519: bytes-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 520: bytes-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 521: bytes-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 522: bytes-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1024\",\"2000000\"]")),
  )
}

///|
test "official collection 523: bytes-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"2000000\",\"1024\"]")),
  )
}

///|
test "official collection 524: memory-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1\",\"2\"]")),
  )
}

///|
test "official collection 525: memory-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "memory-list", "a"),
    (true, @json.parse("[\"2\",\"1\"]")),
  )
}

///|
test "official collection 526: memory-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 527: memory-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 528: memory-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 529: memory-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 530: memory-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 531: memory-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 532: memory-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 533: memory-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 534: memory-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1024\",\"2000000\"]")),
  )
}

///|
test "official collection 535: memory-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"2000000\",\"1024\"]")),
  )
}

///|
test "official collection 536: config-list" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 537: config-list" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 538: config-list" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 539: config-list" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 540: config-list" {
  assert_eq(
    collection_result("a=[null,1]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 541: config-list" {
  assert_eq(
    collection_result("a=[1,null]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 542: config-list" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "config-list", "a"),
    (true, @json.parse("[{\"x\":1},{\"x\":2}]")),
  )
}

///|
test "official collection 543: config-list" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "config-list", "a"),
    (true, @json.parse("[{\"x\":2},{\"x\":1}]")),
  )
}

///|
test "official collection 544: config-list" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 545: config-list" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 546: config-list" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 547: config-list" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 548: config" {
  assert_eq(
    collection_result("a=[1,\"2\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 549: config" {
  assert_eq(
    collection_result("a=[\"2\",1]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 550: config" {
  assert_eq(
    collection_result("a=[true,\"off\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 551: config" {
  assert_eq(
    collection_result("a=[\"off\",true]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 552: config" {
  assert_eq(
    collection_result("a=[null,1]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 553: config" {
  assert_eq(
    collection_result("a=[1,null]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 554: config" {
  assert_eq(
    collection_result("a=[{x=1},{x=2}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 555: config" {
  assert_eq(
    collection_result("a=[{x=2},{x=1}]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 556: config" {
  assert_eq(
    collection_result("a=[\"1s\",\"2ms\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 557: config" {
  assert_eq(
    collection_result("a=[\"2ms\",\"1s\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 558: config" {
  assert_eq(
    collection_result("a=[\"1KiB\",\"2MB\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 559: config" {
  assert_eq(
    collection_result("a=[\"2MB\",\"1KiB\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 560: string-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "string-list", "a"),
    (true, @json.parse("[\"1.999\",\"-1.999\"]")),
  )
}

///|
test "official collection 561: string-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "string-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 562: string-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "string-list", "a"),
    (true, @json.parse("[\"-9223372036854775808\"]")),
  )
}

///|
test "official collection 563: string-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "string-list", "a"),
    (true, @json.parse("[\"1e30\"]")),
  )
}

///|
test "official collection 564: string-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e30\"]")),
  )
}

///|
test "official collection 565: string-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e30 ms\"]")),
  )
}

///|
test "official collection 566: string-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e30 bytes\"]")),
  )
}

///|
test "official collection 567: string-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "string-list", "a"),
    (true, @json.parse("[\"-0.9\"]")),
  )
}

///|
test "official collection 568: string-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "string-list", "a"),
    (true, @json.parse("[\"-0.9 bytes\"]")),
  )
}

///|
test "official collection 569: string-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "string-list", "a"),
    (true, @json.parse("[\"0x1p3\"]")),
  )
}

///|
test "official collection 570: string-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "string-list", "a"),
    (true, @json.parse("[\"NaN\"]")),
  )
}

///|
test "official collection 571: string-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "string-list", "a"),
    (true, @json.parse("[\"Infinity\"]")),
  )
}

///|
test "official collection 572: string-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1d\"]")),
  )
}

///|
test "official collection 573: string-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "string-list", "a"),
    (true, @json.parse("[\".5\"]")),
  )
}

///|
test "official collection 574: string-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1.\"]")),
  )
}

///|
test "official collection 575: string-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "string-list", "a"),
    (true, @json.parse("[\"1e-3\"]")),
  )
}

///|
test "official collection 576: string-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "string-list", "a"),
    (true, @json.parse("[\"+1\"]")),
  )
}

///|
test "official collection 577: string-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "string-list", "a"),
    (true, @json.parse("[\" 1 \"]")),
  )
}

///|
test "official collection 578: string-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "string-list", "a"),
    (true, @json.parse("[\"1 KiB\",\"1024\"]")),
  )
}

///|
test "official collection 579: string-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "string-list", "a"),
    (true, @json.parse("[\"0\",\"-0\"]")),
  )
}

///|
test "official collection 580: boolean-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 581: boolean-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 582: boolean-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 583: boolean-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 584: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 585: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 586: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 587: boolean-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 588: boolean-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 589: boolean-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 590: boolean-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 591: boolean-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 592: boolean-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 593: boolean-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 594: boolean-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 595: boolean-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 596: boolean-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 597: boolean-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 598: boolean-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 599: boolean-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "boolean-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 600: int-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "int-list", "a"),
    (true, @json.parse("[1,-1]")),
  )
}

///|
test "official collection 601: int-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 602: int-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 603: int-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 604: int-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 605: int-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 606: int-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 607: int-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "int-list", "a"),
    (true, @json.parse("[0]")),
  )
}

///|
test "official collection 608: int-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 609: int-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "int-list", "a"),
    (true, @json.parse("[8]")),
  )
}

///|
test "official collection 610: int-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "int-list", "a"),
    (true, @json.parse("[0]")),
  )
}

///|
test "official collection 611: int-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 612: int-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "int-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 613: int-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "int-list", "a"),
    (true, @json.parse("[0]")),
  )
}

///|
test "official collection 614: int-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "int-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 615: int-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "int-list", "a"),
    (true, @json.parse("[0]")),
  )
}

///|
test "official collection 616: int-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "int-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 617: int-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "int-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 618: int-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "int-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 619: int-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "int-list", "a"),
    (true, @json.parse("[0,0]")),
  )
}

///|
test "official collection 620: long-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "long-list", "a"),
    (true, @json.parse("[\"1\",\"-1\"]")),
  )
}

///|
test "official collection 621: long-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 622: long-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "long-list", "a"),
    (true, @json.parse("[\"-9223372036854775808\"]")),
  )
}

///|
test "official collection 623: long-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 624: long-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 625: long-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 626: long-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 627: long-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "long-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 628: long-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 629: long-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "long-list", "a"),
    (true, @json.parse("[\"8\"]")),
  )
}

///|
test "official collection 630: long-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "long-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 631: long-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "long-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 632: long-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 633: long-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "long-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 634: long-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 635: long-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "long-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 636: long-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 637: long-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "long-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 638: long-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "long-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 639: long-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "long-list", "a"),
    (true, @json.parse("[\"0\",\"0\"]")),
  )
}

///|
test "official collection 640: double-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "double-list", "a"),
    (true, @json.parse("[1.999,-1.999]")),
  )
}

///|
test "official collection 641: double-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "double-list", "a"),
    (true, @json.parse("[9223372036854776000]")),
  )
}

///|
test "official collection 642: double-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "double-list", "a"),
    (true, @json.parse("[-9223372036854776000]")),
  )
}

///|
test "official collection 643: double-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "double-list", "a"),
    (true, @json.parse("[1e+30]")),
  )
}

///|
test "official collection 644: double-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "double-list", "a"),
    (true, @json.parse("[1e+30]")),
  )
}

///|
test "official collection 645: double-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 646: double-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 647: double-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "double-list", "a"),
    (true, @json.parse("[-0.9]")),
  )
}

///|
test "official collection 648: double-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 649: double-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "double-list", "a"),
    (true, @json.parse("[8]")),
  )
}

///|
test "official collection 650: double-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "double-list", "a"),
    (true, @json.parse("[\"NaN\"]")),
  )
}

///|
test "official collection 651: double-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "double-list", "a"),
    (true, @json.parse("[\"Infinity\"]")),
  )
}

///|
test "official collection 652: double-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "double-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 653: double-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "double-list", "a"),
    (true, @json.parse("[0.5]")),
  )
}

///|
test "official collection 654: double-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "double-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 655: double-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "double-list", "a"),
    (true, @json.parse("[0.001]")),
  )
}

///|
test "official collection 656: double-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "double-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 657: double-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "double-list", "a"),
    (true, @json.parse("[1]")),
  )
}

///|
test "official collection 658: double-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "double-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 659: double-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "double-list", "a"),
    (true, @json.parse("[0,0]")),
  )
}

///|
test "official collection 660: duration-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\",\"-1000000\"]")),
  )
}

///|
test "official collection 661: duration-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 662: duration-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "duration-list", "a"),
    (true, @json.parse("[\"-9223372036854775808\"]")),
  )
}

///|
test "official collection 663: duration-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 664: duration-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 665: duration-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 666: duration-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 667: duration-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"-900000\"]")),
  )
}

///|
test "official collection 668: duration-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 669: duration-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"8000000\"]")),
  )
}

///|
test "official collection 670: duration-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 671: duration-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 672: duration-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"86400000000000\"]")),
  )
}

///|
test "official collection 673: duration-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"500000\"]")),
  )
}

///|
test "official collection 674: duration-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\"]")),
  )
}

///|
test "official collection 675: duration-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000\"]")),
  )
}

///|
test "official collection 676: duration-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\"]")),
  )
}

///|
test "official collection 677: duration-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "duration-list", "a"),
    (true, @json.parse("[\"1000000\"]")),
  )
}

///|
test "official collection 678: duration-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "duration-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 679: duration-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "duration-list", "a"),
    (true, @json.parse("[\"0\",\"0\"]")),
  )
}

///|
test "official collection 680: bytes-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 681: bytes-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "bytes-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 682: bytes-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 683: bytes-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "bytes-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 684: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 685: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 686: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 687: bytes-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 688: bytes-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 689: bytes-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 690: bytes-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 691: bytes-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 692: bytes-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "bytes-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 693: bytes-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 694: bytes-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 695: bytes-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 696: bytes-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 697: bytes-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 698: bytes-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "bytes-list", "a"),
    (true, @json.parse("[\"1024\",\"1024\"]")),
  )
}

///|
test "official collection 699: bytes-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "bytes-list", "a"),
    (true, @json.parse("[\"0\",\"0\"]")),
  )
}

///|
test "official collection 700: memory-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 701: memory-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "memory-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 702: memory-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 703: memory-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "memory-list", "a"),
    (true, @json.parse("[\"9223372036854775807\"]")),
  )
}

///|
test "official collection 704: memory-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1000000000000000000000000000000\"]")),
  )
}

///|
test "official collection 705: memory-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 706: memory-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1000000000000000000000000000000\"]")),
  )
}

///|
test "official collection 707: memory-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 708: memory-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 709: memory-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 710: memory-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 711: memory-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 712: memory-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "memory-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 713: memory-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 714: memory-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 715: memory-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\"]")),
  )
}

///|
test "official collection 716: memory-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 717: memory-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "memory-list", "a"),
    (true, @json.parse("[\"1\"]")),
  )
}

///|
test "official collection 718: memory-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "memory-list", "a"),
    (true, @json.parse("[\"1024\",\"1024\"]")),
  )
}

///|
test "official collection 719: memory-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "memory-list", "a"),
    (true, @json.parse("[\"0\",\"0\"]")),
  )
}

///|
test "official collection 720: config-list" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 721: config-list" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 722: config-list" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 723: config-list" {
  assert_eq(
    collection_result("a=[1e30]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 724: config-list" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 725: config-list" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 726: config-list" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 727: config-list" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 728: config-list" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 729: config-list" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 730: config-list" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 731: config-list" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 732: config-list" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 733: config-list" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 734: config-list" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 735: config-list" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 736: config-list" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 737: config-list" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 738: config-list" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 739: config-list" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "config-list", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 740: config" {
  assert_eq(
    collection_result("a=[1.999,-1.999]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 741: config" {
  assert_eq(
    collection_result("a=[9223372036854775807]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 742: config" {
  assert_eq(
    collection_result("a=[-9223372036854775808]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 743: config" {
  assert_eq(
    collection_result("a=[1e30]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 744: config" {
  assert_eq(
    collection_result("a=[\"1e30\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 745: config" {
  assert_eq(
    collection_result("a=[\"1e30 ms\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 746: config" {
  assert_eq(
    collection_result("a=[\"1e30 bytes\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 747: config" {
  assert_eq(
    collection_result("a=[\"-0.9\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 748: config" {
  assert_eq(
    collection_result("a=[\"-0.9 bytes\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 749: config" {
  assert_eq(
    collection_result("a=[\"0x1p3\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 750: config" {
  assert_eq(
    collection_result("a=[\"NaN\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 751: config" {
  assert_eq(
    collection_result("a=[\"Infinity\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 752: config" {
  assert_eq(
    collection_result("a=[\"1d\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 753: config" {
  assert_eq(
    collection_result("a=[\".5\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 754: config" {
  assert_eq(
    collection_result("a=[\"1.\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 755: config" {
  assert_eq(
    collection_result("a=[\"1e-3\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 756: config" {
  assert_eq(
    collection_result("a=[\"+1\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 757: config" {
  assert_eq(
    collection_result("a=[\" 1 \"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 758: config" {
  assert_eq(
    collection_result("a=[\"1 KiB\",1024]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 759: config" {
  assert_eq(
    collection_result("a=[0,\"-0\"]", [], "config", "a"),
    (false, @json.parse("null")),
  )
}

///|
test "official collection 760: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 761: string-list" {
  assert_eq(
    collection_result(
      "base={\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 762: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 763: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      ["a={\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 764: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 765: string-list" {
  assert_eq(
    collection_result(
      "a={\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 766: string-list" {
  assert_eq(
    collection_result(
      "base={\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 767: string-list" {
  assert_eq(
    collection_result(
      "a={\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 768: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      ["a={\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 769: string-list" {
  assert_eq(
    collection_result(
      "a={\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 770: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 771: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 772: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 773: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 774: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 775: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 776: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 777: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 778: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 779: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 780: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 781: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 782: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 783: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 784: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 785: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 786: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 787: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 788: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 789: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 790: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 791: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 792: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 793: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 794: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 795: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 796: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 797: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 798: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 799: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 800: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 801: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 802: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 803: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 804: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 805: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 806: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 807: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 808: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 809: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 810: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 811: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 812: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 813: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 814: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 815: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 816: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 817: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 818: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 819: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 820: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 821: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 822: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 823: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 824: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 825: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 826: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 827: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 828: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 829: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 830: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 831: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 832: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 833: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 834: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 835: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 836: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 837: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 838: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 839: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 840: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 841: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 842: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 843: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 844: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"0\"=\"v0\",\"00\"=\"v1\",\"000\"=\"v2\",\"+0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 845: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 846: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 847: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 848: string-list" {
  assert_eq(
    collection_result(
      "a={\"0\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 849: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+0\"=\"v0\",\"000\"=\"v1\",\"00\"=\"v2\",\"0\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 850: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 851: string-list" {
  assert_eq(
    collection_result(
      "base={\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 852: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 853: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      ["a={\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 854: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 855: string-list" {
  assert_eq(
    collection_result(
      "a={\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 856: string-list" {
  assert_eq(
    collection_result(
      "base={\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 857: string-list" {
  assert_eq(
    collection_result(
      "a={\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 858: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      ["a={\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 859: string-list" {
  assert_eq(
    collection_result(
      "a={\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 860: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 861: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 862: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 863: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 864: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 865: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 866: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 867: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 868: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 869: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 870: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 871: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 872: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 873: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 874: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 875: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 876: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 877: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 878: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 879: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 880: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 881: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 882: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 883: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 884: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 885: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 886: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 887: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 888: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 889: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 890: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 891: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 892: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 893: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 894: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 895: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 896: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 897: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 898: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 899: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 900: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 901: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 902: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 903: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 904: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 905: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 906: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 907: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 908: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 909: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 910: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 911: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 912: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 913: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 914: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 915: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 916: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 917: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 918: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 919: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 920: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 921: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 922: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 923: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 924: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 925: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 926: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 927: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 928: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 929: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 930: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 931: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 932: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 933: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 934: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"1\"=\"v0\",\"01\"=\"v1\",\"001\"=\"v2\",\"+1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 935: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 936: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 937: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 938: string-list" {
  assert_eq(
    collection_result(
      "a={\"1\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 939: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+1\"=\"v0\",\"001\"=\"v1\",\"01\"=\"v2\",\"1\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 940: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 941: string-list" {
  assert_eq(
    collection_result(
      "base={\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 942: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 943: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      ["a={\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 944: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 945: string-list" {
  assert_eq(
    collection_result(
      "a={\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 946: string-list" {
  assert_eq(
    collection_result(
      "base={\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 947: string-list" {
  assert_eq(
    collection_result(
      "a={\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 948: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      ["a={\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 949: string-list" {
  assert_eq(
    collection_result(
      "a={\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 950: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 951: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 952: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 953: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 954: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 955: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 956: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 957: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 958: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 959: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 960: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 961: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 962: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 963: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 964: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 965: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 966: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 967: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 968: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 969: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 970: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 971: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 972: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 973: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 974: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 975: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 976: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 977: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 978: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 979: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 980: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 981: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 982: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 983: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 984: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 985: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 986: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 987: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 988: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 989: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 990: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 991: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 992: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 993: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 994: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 995: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 996: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 997: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 998: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 999: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1000: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1001: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1002: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1003: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1004: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1005: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1006: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1007: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1008: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1009: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1010: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1011: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1012: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1013: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1014: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1015: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1016: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1017: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1018: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1019: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1020: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1021: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1022: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1023: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1024: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"2\"=\"v0\",\"02\"=\"v1\",\"002\"=\"v2\",\"+2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1025: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1026: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1027: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1028: string-list" {
  assert_eq(
    collection_result(
      "a={\"2\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1029: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+2\"=\"v0\",\"002\"=\"v1\",\"02\"=\"v2\",\"2\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1030: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1031: string-list" {
  assert_eq(
    collection_result(
      "base={\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1032: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1033: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      ["a={\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1034: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1035: string-list" {
  assert_eq(
    collection_result(
      "a={\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1036: string-list" {
  assert_eq(
    collection_result(
      "base={\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1037: string-list" {
  assert_eq(
    collection_result(
      "a={\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1038: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      ["a={\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1039: string-list" {
  assert_eq(
    collection_result(
      "a={\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1040: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1041: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1042: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1043: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1044: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1045: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1046: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1047: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1048: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1049: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1050: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1051: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1052: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1053: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1054: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1055: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1056: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1057: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1058: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1059: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1060: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1061: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1062: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1063: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1064: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1065: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1066: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1067: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1068: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1069: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1070: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1071: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1072: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1073: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1074: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1075: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1076: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1077: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1078: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1079: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1080: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1081: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1082: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1083: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1084: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1085: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1086: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1087: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1088: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1089: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1090: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1091: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1092: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1093: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1094: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1095: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1096: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1097: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1098: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1099: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1100: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1101: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1102: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1103: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1104: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1105: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1106: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1107: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1108: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1109: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1110: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1111: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1112: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1113: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1114: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"15\"=\"v0\",\"015\"=\"v1\",\"0015\"=\"v2\",\"+15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1115: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1116: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1117: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1118: string-list" {
  assert_eq(
    collection_result(
      "a={\"15\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1119: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+15\"=\"v0\",\"0015\"=\"v1\",\"015\"=\"v2\",\"15\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1120: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1121: string-list" {
  assert_eq(
    collection_result(
      "base={\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1122: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1123: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      ["a={\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1124: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1125: string-list" {
  assert_eq(
    collection_result(
      "a={\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1126: string-list" {
  assert_eq(
    collection_result(
      "base={\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1127: string-list" {
  assert_eq(
    collection_result(
      "a={\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1128: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      ["a={\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1129: string-list" {
  assert_eq(
    collection_result(
      "a={\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1130: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1131: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1132: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1133: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1134: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1135: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1136: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1137: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1138: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1139: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1140: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1141: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1142: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1143: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1144: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1145: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1146: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1147: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1148: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1149: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1150: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1151: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1152: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1153: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1154: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1155: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1156: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1157: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1158: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1159: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1160: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1161: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1162: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1163: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1164: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1165: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1166: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1167: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1168: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1169: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1170: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1171: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1172: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1173: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1174: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1175: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1176: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1177: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1178: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1179: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1180: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1181: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1182: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1183: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1184: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1185: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1186: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1187: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1188: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1189: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1190: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1191: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1192: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1193: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1194: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1195: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1196: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1197: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1198: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1199: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1200: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1201: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1202: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1203: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1204: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"16\"=\"v0\",\"016\"=\"v1\",\"0016\"=\"v2\",\"+16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1205: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1206: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1207: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1208: string-list" {
  assert_eq(
    collection_result(
      "a={\"16\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1209: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+16\"=\"v0\",\"0016\"=\"v1\",\"016\"=\"v2\",\"16\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1210: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1211: string-list" {
  assert_eq(
    collection_result(
      "base={\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1212: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1213: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      ["a={\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1214: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1215: string-list" {
  assert_eq(
    collection_result(
      "a={\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1216: string-list" {
  assert_eq(
    collection_result(
      "base={\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1217: string-list" {
  assert_eq(
    collection_result(
      "a={\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1218: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      ["a={\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}"],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1219: string-list" {
  assert_eq(
    collection_result(
      "a={\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1220: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1221: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1222: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1223: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1224: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v3\"]")),
  )
}

///|
test "official collection 1225: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1226: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1227: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1228: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1229: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v0\"]")),
  )
}

///|
test "official collection 1230: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1231: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1232: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1233: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1234: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1235: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1236: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1237: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1238: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1239: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1240: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1241: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1242: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1243: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1244: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1245: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1246: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1247: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1248: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1249: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1250: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1251: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1252: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1253: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1254: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1255: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1256: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1257: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1258: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1259: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1260: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1261: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1262: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1263: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1264: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1265: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1266: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1267: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1268: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1269: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1270: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1271: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1272: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1273: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1274: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1275: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1276: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1277: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1278: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1279: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1280: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1281: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1282: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1283: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1284: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1285: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1286: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1287: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1288: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1289: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1290: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1291: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1292: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1293: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1294: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"99\"=\"v0\",\"099\"=\"v1\",\"0099\"=\"v2\",\"+99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v1\"]")),
  )
}

///|
test "official collection 1295: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1296: string-list" {
  assert_eq(
    collection_result(
      "base={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na=${base}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1297: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=added",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1298: string-list" {
  assert_eq(
    collection_result(
      "a={\"99\"=primary}",
      [
        "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}",
      ],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}

///|
test "official collection 1299: string-list" {
  assert_eq(
    collection_result(
      "a={\"padding0\"=ignored,\"padding1\"=ignored,\"padding2\"=ignored,\"padding3\"=ignored,\"padding4\"=ignored,\"padding5\"=ignored,\"padding6\"=ignored,\"padding7\"=ignored,\"padding8\"=ignored,\"padding9\"=ignored,\"padding10\"=ignored,\"padding11\"=ignored,\"padding12\"=ignored,\"padding13\"=ignored,\"padding14\"=ignored,\"padding15\"=ignored,\"padding16\"=ignored,\"padding17\"=ignored,\"padding18\"=ignored,\"padding19\"=ignored,\"padding20\"=ignored,\"padding21\"=ignored,\"padding22\"=ignored,\"padding23\"=ignored,\"padding24\"=ignored,\"padding25\"=ignored,\"padding26\"=ignored,\"padding27\"=ignored,\"padding28\"=ignored,\"padding29\"=ignored,\"padding30\"=ignored,\"padding31\"=ignored,\"padding32\"=ignored,\"padding33\"=ignored,\"padding34\"=ignored,\"padding35\"=ignored,\"padding36\"=ignored,\"padding37\"=ignored,\"padding38\"=ignored,\"padding39\"=ignored,\"padding40\"=ignored,\"padding41\"=ignored,\"padding42\"=ignored,\"padding43\"=ignored,\"padding44\"=ignored,\"padding45\"=ignored,\"padding46\"=ignored,\"padding47\"=ignored,\"padding48\"=ignored,\"+99\"=\"v0\",\"0099\"=\"v1\",\"099\"=\"v2\",\"99\"=\"v3\"}\na.x=${?MISSING}",
      [],
      "string-list",
      "a",
    ),
    (true, @json.parse("[\"v2\"]")),
  )
}
