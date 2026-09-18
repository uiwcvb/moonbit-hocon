// Independent native numeric, traversal-order and search results.

///|
fn value_walk_case_0() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_1() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_2() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_3() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_4() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_5() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_6() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_7() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_8() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_9() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_10() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_11() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_12() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_13() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_14() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_15() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_16() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_17() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_18() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_19() -> Unit raise {
  let a = value_native_create("-2147483648")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_20() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_21() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_22() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_23() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_24() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_25() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_26() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_27() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_28() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_29() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_30() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_31() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_32() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_33() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_34() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_35() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_36() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_37() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_38() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_39() -> Unit raise {
  let a = value_native_create("-2147483647")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_40() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_41() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_42() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_43() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_44() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_45() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_46() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_47() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_48() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_49() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_50() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_51() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_52() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_53() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_54() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_55() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_56() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_57() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_58() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_59() -> Unit raise {
  let a = value_native_create("2147483647")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_60() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_61() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_62() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_63() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_64() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_65() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_66() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_67() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_68() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_69() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_70() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_71() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_72() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_73() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_74() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_75() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_76() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_77() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_78() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_79() -> Unit raise {
  let a = value_native_create("2147483648")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_80() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_81() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_82() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_83() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_84() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_85() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_86() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_87() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_88() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_89() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_90() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_91() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_92() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_93() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_94() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_95() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_96() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_97() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_98() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_99() -> Unit raise {
  let a = value_native_create("-4294967296")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_100() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_101() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_102() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_103() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_104() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_105() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_106() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_107() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_108() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_109() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_110() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_111() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_112() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_113() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_114() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_115() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_116() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_117() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_118() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_119() -> Unit raise {
  let a = value_native_create("4294967296")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_120() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_121() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_122() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_123() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_124() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_125() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_126() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_127() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_128() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_129() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_130() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_131() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_132() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_133() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_134() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_135() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_136() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_137() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_138() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_139() -> Unit raise {
  let a = value_native_create("-9223372036854775808")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_140() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_141() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_142() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_143() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_144() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_145() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_146() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_147() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_148() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_149() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_150() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_151() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_152() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_153() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_154() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_155() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_156() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_157() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_158() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_159() -> Unit raise {
  let a = value_native_create("9223372036854775807")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_160() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_161() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_162() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_163() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_164() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_165() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_166() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_167() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_168() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_169() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_170() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_171() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_172() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_173() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_174() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_175() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_176() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_177() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_178() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_179() -> Unit raise {
  let a = value_native_create("9007199254740993")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_180() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_181() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_182() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_183() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_184() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_185() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_186() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_187() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_188() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_189() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_190() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_191() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_192() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_193() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_194() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_195() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_196() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_197() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_198() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_199() -> Unit raise {
  let a = value_native_create("9007199254740993.0")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_200() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_201() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_202() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_203() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_204() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_205() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_206() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_207() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_208() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_209() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_210() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_211() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_212() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_213() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_214() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_215() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_216() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_217() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_218() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_219() -> Unit raise {
  let a = value_native_create("1")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_220() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_221() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_222() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_223() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_224() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_225() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_226() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_227() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_228() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_229() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_230() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_231() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_232() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_233() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_234() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_235() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_236() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_237() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_238() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_239() -> Unit raise {
  let a = value_native_create("1.0000000000000002")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_240() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_241() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_242() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_243() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_244() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_245() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_246() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_247() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_248() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_249() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_250() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_251() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_252() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_253() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_254() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_255() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_256() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_257() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_258() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_259() -> Unit raise {
  let a = value_native_create("1e30")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_260() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_261() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_262() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_263() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_264() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_265() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_266() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_267() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_268() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_269() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_270() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_271() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_272() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_273() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_274() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_275() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_276() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_277() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_278() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_279() -> Unit raise {
  let a = value_native_create("1e-300")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_280() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_281() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_282() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_283() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_284() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_285() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_286() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_287() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_288() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_289() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_290() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_291() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_292() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_293() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_294() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_295() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_296() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_297() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_298() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_299() -> Unit raise {
  let a = value_native_create("-5e-324")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_300() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_301() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_302() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_303() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_304() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_305() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_306() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_307() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_308() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_309() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_310() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_311() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_312() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_313() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_314() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_315() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_316() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_317() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_318() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_319() -> Unit raise {
  let a = value_native_create("-0.0")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_320() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_321() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_322() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_323() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_324() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_325() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_326() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_327() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_328() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_329() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_330() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_331() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_332() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_333() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_334() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_335() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_336() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_337() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_338() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_339() -> Unit raise {
  let a = value_native_create("0.0")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_340() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_341() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_342() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_343() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_344() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_345() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_346() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_347() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_348() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_349() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_350() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_351() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_352() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_353() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_354() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_355() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_356() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_357() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_358() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_359() -> Unit raise {
  let a = value_native_create("0")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_360() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_361() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_362() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_363() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_364() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_365() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_366() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_367() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_368() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_369() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_370() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_371() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_372() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_373() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_374() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_375() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_376() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_377() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_378() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_379() -> Unit raise {
  let a = value_native_create("-1")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_380() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_381() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483646}"),
  )
}

///|
fn value_walk_case_382() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("2147483647")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2147483647}"),
  )
}

///|
fn value_walk_case_383() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("2147483648")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_384() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
}

///|
fn value_walk_case_385() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("4294967296")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_386() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-9223372036854775808")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_387() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("9223372036854775807")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483648}"),
  )
}

///|
fn value_walk_case_388() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("9007199254740993")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097153}"),
  )
}

///|
fn value_walk_case_389() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("9007199254740993.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2097152}"),
  )
}

///|
fn value_walk_case_390() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
}

///|
fn value_walk_case_391() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("1.0000000000000002")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1072693249}"),
  )
}

///|
fn value_walk_case_392() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("1e30")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2139730611}"),
  )
}

///|
fn value_walk_case_393() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("1e-300")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1017275066}"),
  )
}

///|
fn value_walk_case_394() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-5e-324")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2147483647}"),
  )
}

///|
fn value_walk_case_395() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_396() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("0.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_397() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_398() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_399() -> Unit raise {
  let a = value_native_create("-1.0")
  let b = value_native_create("-1.0")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
}

///|
fn value_walk_case_400() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"z\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307584812}"),
  )
}

///|
fn value_walk_case_401() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"z\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-354616074}"),
  )
}

///|
fn value_walk_case_402() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_403() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"a\"=text}")
  let b = value_native_create("{\"z\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307584812}"),
  )
}

///|
fn value_walk_case_404() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"a\"=text}")
  let b = value_native_create("{\"z\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-354616074}"),
  )
}

///|
fn value_walk_case_405() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_406() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_407() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"Aa\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_408() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_409() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"a\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_410() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"a\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_411() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_412() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"BB\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_413() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"BB\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"BB\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_414() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_415() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"a\"=text}")
  let b = value_native_create("{\"BB\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_416() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"a\"=text}")
  let b = value_native_create("{\"BB\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_417() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_418() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1079789043}"),
  )
}

///|
fn value_walk_case_419() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"a\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2062052181}"),
  )
}

///|
fn value_walk_case_420() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_421() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"a\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1079789043}"),
  )
}

///|
fn value_walk_case_422() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"a\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"a\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2062052181}"),
  )
}

///|
fn value_walk_case_423() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_424() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"k10\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311859964}"),
  )
}

///|
fn value_walk_case_425() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"k10\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"k10\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":837179074}"),
  )
}

///|
fn value_walk_case_426() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_427() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"a\"=text}")
  let b = value_native_create("{\"k10\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311859964}"),
  )
}

///|
fn value_walk_case_428() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"a\"=text}")
  let b = value_native_create("{\"k10\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":837179074}"),
  )
}

///|
fn value_walk_case_429() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_430() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"k2\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307717857}"),
  )
}

///|
fn value_walk_case_431() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"k2\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"k2\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":708773757}"),
  )
}

///|
fn value_walk_case_432() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_433() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"a\"=text}")
  let b = value_native_create("{\"k2\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307717857}"),
  )
}

///|
fn value_walk_case_434() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"a\"=text}")
  let b = value_native_create("{\"k2\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":708773757}"),
  )
}

///|
fn value_walk_case_435() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_436() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"😀\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380268669}"),
  )
}

///|
fn value_walk_case_437() -> Unit raise {
  let a = value_native_create("{\"a\"=text,\"😀\"=0}")
  let b = value_native_create("{\"a\"=${missing},\"😀\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-281932217}"),
  )
}

///|
fn value_walk_case_438() -> Unit raise {
  let a = value_native_create("{\"a\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_439() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"a\"=text}")
  let b = value_native_create("{\"😀\"=1,\"a\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380268669}"),
  )
}

///|
fn value_walk_case_440() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"a\"=text}")
  let b = value_native_create("{\"😀\"=1,\"a\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-281932217}"),
  )
}

///|
fn value_walk_case_441() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"a\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_442() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"a\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307584812}"),
  )
}

///|
fn value_walk_case_443() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"a\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-354616074}"),
  )
}

///|
fn value_walk_case_444() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_445() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"z\"=text}")
  let b = value_native_create("{\"a\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307584812}"),
  )
}

///|
fn value_walk_case_446() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"z\"=text}")
  let b = value_native_create("{\"a\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3726024}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-354616074}"),
  )
}

///|
fn value_walk_case_447() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_448() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_449() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"Aa\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_450() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_451() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"z\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_452() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"z\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_453() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_454() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"BB\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_455() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"BB\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"BB\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_456() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_457() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"z\"=text}")
  let b = value_native_create("{\"BB\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_458() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"z\"=text}")
  let b = value_native_create("{\"BB\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_459() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_460() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1459084956}"),
  )
}

///|
fn value_walk_case_461() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"z\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-222032962}"),
  )
}

///|
fn value_walk_case_462() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_463() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"z\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1459084956}"),
  )
}

///|
fn value_walk_case_464() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"z\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"z\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-222032962}"),
  )
}

///|
fn value_walk_case_465() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_466() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"k10\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440146299}"),
  )
}

///|
fn value_walk_case_467() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"k10\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"k10\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-540177273}"),
  )
}

///|
fn value_walk_case_468() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_469() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"z\"=text}")
  let b = value_native_create("{\"k10\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440146299}"),
  )
}

///|
fn value_walk_case_470() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"z\"=text}")
  let b = value_native_create("{\"k10\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-540177273}"),
  )
}

///|
fn value_walk_case_471() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_472() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"k2\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311740982}"),
  )
}

///|
fn value_walk_case_473() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"k2\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"k2\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-225774804}"),
  )
}

///|
fn value_walk_case_474() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_475() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"z\"=text}")
  let b = value_native_create("{\"k2\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311740982}"),
  )
}

///|
fn value_walk_case_476() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"z\"=text}")
  let b = value_native_create("{\"k2\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-225774804}"),
  )
}

///|
fn value_walk_case_477() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_478() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"😀\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380300444}"),
  )
}

///|
fn value_walk_case_479() -> Unit raise {
  let a = value_native_create("{\"z\"=text,\"😀\"=0}")
  let b = value_native_create("{\"z\"=${missing},\"😀\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1241562660}"),
  )
}

///|
fn value_walk_case_480() -> Unit raise {
  let a = value_native_create("{\"z\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_481() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"z\"=text}")
  let b = value_native_create("{\"😀\"=1,\"z\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380300444}"),
  )
}

///|
fn value_walk_case_482() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"z\"=text}")
  let b = value_native_create("{\"😀\"=1,\"z\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1241562660}"),
  )
}

///|
fn value_walk_case_483() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"z\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_484() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"a\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_485() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"a\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_486() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_487() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"a\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_488() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"a\"=1,\"Aa\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_489() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_490() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"z\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_491() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"z\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_492() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_493() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"z\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_494() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"z\"=1,\"Aa\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_495() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_496() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"BB\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310227467}"),
  )
}

///|
fn value_walk_case_497() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"BB\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"BB\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":786571667}"),
  )
}

///|
fn value_walk_case_498() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_499() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"BB\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310227467}"),
  )
}

///|
fn value_walk_case_500() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"BB\"=1,\"Aa\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":786571667}"),
  )
}

///|
fn value_walk_case_501() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_502() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_503() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"Aa\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_504() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_505() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_506() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"Aa\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"Aa\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_507() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_508() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"k10\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_509() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"k10\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"k10\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_510() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_511() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"k10\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_512() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"k10\"=1,\"Aa\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_513() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_514() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"k2\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_515() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"k2\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"k2\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_516() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_517() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"k2\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_518() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"k2\"=1,\"Aa\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_519() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_520() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"😀\"=0}")
  let b = value_native_create("{\"Aa\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_521() -> Unit raise {
  let a = value_native_create("{\"Aa\"=text,\"😀\"=0}")
  let b = value_native_create(
    "{\"Aa\"=${missing},\"😀\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_522() -> Unit raise {
  let a = value_native_create("{\"Aa\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_523() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"Aa\"=text}")
  let b = value_native_create("{\"😀\"=1,\"Aa\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_524() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"Aa\"=text}")
  let b = value_native_create(
    "{\"😀\"=1,\"Aa\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_525() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"Aa\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_526() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"a\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_527() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"a\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_528() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_529() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"BB\"=text}")
  let b = value_native_create("{\"a\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310144852}"),
  )
}

///|
fn value_walk_case_530() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"BB\"=text}")
  let b = value_native_create("{\"a\"=1,\"BB\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6286064}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":784010602}"),
  )
}

///|
fn value_walk_case_531() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_532() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"z\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_533() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"z\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_534() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_535() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"BB\"=text}")
  let b = value_native_create("{\"z\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310145877}"),
  )
}

///|
fn value_walk_case_536() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"BB\"=text}")
  let b = value_native_create("{\"z\"=1,\"BB\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6287089}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-275223059}"),
  )
}

///|
fn value_walk_case_537() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_538() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310227467}"),
  )
}

///|
fn value_walk_case_539() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"Aa\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":786571667}"),
  )
}

///|
fn value_walk_case_540() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_541() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"BB\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310227467}"),
  )
}

///|
fn value_walk_case_542() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"BB\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"BB\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6368679}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":786571667}"),
  )
}

///|
fn value_walk_case_543() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_544() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_545() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"BB\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_546() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_547() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"BB\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_548() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"BB\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"BB\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_549() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_550() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"k10\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_551() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"k10\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"k10\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_552() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_553() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"BB\"=text}")
  let b = value_native_create("{\"k10\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_554() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"BB\"=text}")
  let b = value_native_create("{\"k10\"=1,\"BB\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_555() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_556() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"k2\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_557() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"k2\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"k2\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_558() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_559() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"BB\"=text}")
  let b = value_native_create("{\"k2\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_560() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"BB\"=text}")
  let b = value_native_create("{\"k2\"=1,\"BB\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_561() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_562() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"😀\"=0}")
  let b = value_native_create("{\"BB\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_563() -> Unit raise {
  let a = value_native_create("{\"BB\"=text,\"😀\"=0}")
  let b = value_native_create(
    "{\"BB\"=${missing},\"😀\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_564() -> Unit raise {
  let a = value_native_create("{\"BB\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_565() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"BB\"=text}")
  let b = value_native_create("{\"😀\"=1,\"BB\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_566() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"BB\"=text}")
  let b = value_native_create(
    "{\"😀\"=1,\"BB\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_567() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"BB\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_568() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"a\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1079789043}"),
  )
}

///|
fn value_walk_case_569() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"a\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"a\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2062052181}"),
  )
}

///|
fn value_walk_case_570() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_571() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"a\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1079789043}"),
  )
}

///|
fn value_walk_case_572() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"a\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-224069745}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-2062052181}"),
  )
}

///|
fn value_walk_case_573() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_574() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"z\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1459084956}"),
  )
}

///|
fn value_walk_case_575() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"z\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"z\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-222032962}"),
  )
}

///|
fn value_walk_case_576() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_577() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"z\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1459084956}"),
  )
}

///|
fn value_walk_case_578() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"z\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532023552}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-222032962}"),
  )
}

///|
fn value_walk_case_579() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_580() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_581() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"Aa\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"Aa\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_582() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_583() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_584() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"Aa\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_585() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_586() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"BB\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_587() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"BB\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"BB\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_588() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_589() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"BB\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1082350108}"),
  )
}

///|
fn value_walk_case_590() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"BB\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-221508680}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1982659166}"),
  )
}

///|
fn value_walk_case_591() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_592() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"k10\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1454809804}"),
  )
}

///|
fn value_walk_case_593() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"k10\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"k10\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":969762186}"),
  )
}

///|
fn value_walk_case_594() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_595() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"k10\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1454809804}"),
  )
}

///|
fn value_walk_case_596() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"k10\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":969762186}"),
  )
}

///|
fn value_walk_case_597() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_598() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"k2\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1458951911}"),
  )
}

///|
fn value_walk_case_599() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"k2\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"k2\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":841356869}"),
  )
}

///|
fn value_walk_case_600() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_601() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"k2\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1458951911}"),
  )
}

///|
fn value_walk_case_602() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"k2\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":841356869}"),
  )
}

///|
fn value_walk_case_603() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_604() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"😀\"=0}")
  let b = value_native_create("{\"a.long\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1386401099}"),
  )
}

///|
fn value_walk_case_605() -> Unit raise {
  let a = value_native_create("{\"a.long\"=text,\"😀\"=0}")
  let b = value_native_create(
    "{\"a.long\"=${missing},\"😀\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-149349105}"),
  )
}

///|
fn value_walk_case_606() -> Unit raise {
  let a = value_native_create("{\"a.long\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_607() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"a.long\"=text}")
  let b = value_native_create("{\"😀\"=1,\"a.long\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1386401099}"),
  )
}

///|
fn value_walk_case_608() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"a.long\"=text}")
  let b = value_native_create(
    "{\"😀\"=1,\"a.long\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-149349105}"),
  )
}

///|
fn value_walk_case_609() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"a.long\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_610() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"a\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311859964}"),
  )
}

///|
fn value_walk_case_611() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"a\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":837179074}"),
  )
}

///|
fn value_walk_case_612() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_613() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"k10\"=text}")
  let b = value_native_create("{\"a\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311859964}"),
  )
}

///|
fn value_walk_case_614() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"k10\"=text}")
  let b = value_native_create("{\"a\"=1,\"k10\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":8001176}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":837179074}"),
  )
}

///|
fn value_walk_case_615() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_616() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"z\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440146299}"),
  )
}

///|
fn value_walk_case_617() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"z\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-540177273}"),
  )
}

///|
fn value_walk_case_618() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_619() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"k10\"=text}")
  let b = value_native_create("{\"z\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440146299}"),
  )
}

///|
fn value_walk_case_620() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"k10\"=text}")
  let b = value_native_create("{\"z\"=1,\"k10\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136287511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-540177273}"),
  )
}

///|
fn value_walk_case_621() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_622() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_623() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"Aa\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_624() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_625() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"k10\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_626() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"k10\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"k10\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_627() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_628() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"BB\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_629() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"BB\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"BB\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_630() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_631() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"k10\"=text}")
  let b = value_native_create("{\"BB\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1314421029}"),
  )
}

///|
fn value_walk_case_632() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"k10\"=text}")
  let b = value_native_create("{\"BB\"=1,\"k10\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":10562241}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":916572089}"),
  )
}

///|
fn value_walk_case_633() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_634() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1454809804}"),
  )
}

///|
fn value_walk_case_635() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"k10\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":969762186}"),
  )
}

///|
fn value_walk_case_636() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_637() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"k10\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1454809804}"),
  )
}

///|
fn value_walk_case_638() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"k10\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"k10\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1536298704}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":969762186}"),
  )
}

///|
fn value_walk_case_639() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_640() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"k2\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440279344}"),
  )
}

///|
fn value_walk_case_641() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"k2\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"k2\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":523212558}"),
  )
}

///|
fn value_walk_case_642() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_643() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"k10\"=text}")
  let b = value_native_create("{\"k2\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440279344}"),
  )
}

///|
fn value_walk_case_644() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"k10\"=text}")
  let b = value_native_create("{\"k2\"=1,\"k10\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":523212558}"),
  )
}

///|
fn value_walk_case_645() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_646() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"😀\"=0}")
  let b = value_native_create("{\"k10\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1512830156}"),
  )
}

///|
fn value_walk_case_647() -> Unit raise {
  let a = value_native_create("{\"k10\"=text,\"😀\"=0}")
  let b = value_native_create(
    "{\"k10\"=${missing},\"😀\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-467493416}"),
  )
}

///|
fn value_walk_case_648() -> Unit raise {
  let a = value_native_create("{\"k10\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_649() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"k10\"=text}")
  let b = value_native_create("{\"😀\"=1,\"k10\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1512830156}"),
  )
}

///|
fn value_walk_case_650() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"k10\"=text}")
  let b = value_native_create(
    "{\"😀\"=1,\"k10\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-467493416}"),
  )
}

///|
fn value_walk_case_651() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"k10\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_652() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"a\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307717857}"),
  )
}

///|
fn value_walk_case_653() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"a\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":708773757}"),
  )
}

///|
fn value_walk_case_654() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_655() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"k2\"=text}")
  let b = value_native_create("{\"a\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1307717857}"),
  )
}

///|
fn value_walk_case_656() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"k2\"=text}")
  let b = value_native_create("{\"a\"=1,\"k2\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":3859069}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":708773757}"),
  )
}

///|
fn value_walk_case_657() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_658() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"z\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311740982}"),
  )
}

///|
fn value_walk_case_659() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"z\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-225774804}"),
  )
}

///|
fn value_walk_case_660() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_661() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"k2\"=text}")
  let b = value_native_create("{\"z\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1311740982}"),
  )
}

///|
fn value_walk_case_662() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"k2\"=text}")
  let b = value_native_create("{\"z\"=1,\"k2\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7882194}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-225774804}"),
  )
}

///|
fn value_walk_case_663() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_664() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_665() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"Aa\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_666() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_667() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"k2\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_668() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"k2\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"k2\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_669() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_670() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"BB\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_671() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"BB\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"BB\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_672() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_673() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"k2\"=text}")
  let b = value_native_create("{\"BB\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1310278922}"),
  )
}

///|
fn value_walk_case_674() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"k2\"=text}")
  let b = value_native_create("{\"BB\"=1,\"k2\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":6420134}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":788166772}"),
  )
}

///|
fn value_walk_case_675() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_676() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1458951911}"),
  )
}

///|
fn value_walk_case_677() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"k2\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":841356869}"),
  )
}

///|
fn value_walk_case_678() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_679() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"k2\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1458951911}"),
  )
}

///|
fn value_walk_case_680() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"k2\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"k2\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1532156597}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":841356869}"),
  )
}

///|
fn value_walk_case_681() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_682() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"k10\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440279344}"),
  )
}

///|
fn value_walk_case_683() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"k10\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"k10\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":523212558}"),
  )
}

///|
fn value_walk_case_684() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_685() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"k2\"=text}")
  let b = value_native_create("{\"k10\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1440279344}"),
  )
}

///|
fn value_walk_case_686() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"k2\"=text}")
  let b = value_native_create("{\"k10\"=1,\"k2\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":136420556}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":523212558}"),
  )
}

///|
fn value_walk_case_687() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_688() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"😀\"=0}")
  let b = value_native_create("{\"k2\"=${missing},\"😀\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1384424839}"),
  )
}

///|
fn value_walk_case_689() -> Unit raise {
  let a = value_native_create("{\"k2\"=text,\"😀\"=0}")
  let b = value_native_create(
    "{\"k2\"=${missing},\"😀\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-153090947}"),
  )
}

///|
fn value_walk_case_690() -> Unit raise {
  let a = value_native_create("{\"k2\"=${missing},\"😀\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_691() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"k2\"=text}")
  let b = value_native_create("{\"😀\"=1,\"k2\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1384424839}"),
  )
}

///|
fn value_walk_case_692() -> Unit raise {
  let a = value_native_create("{\"😀\"=0,\"k2\"=text}")
  let b = value_native_create(
    "{\"😀\"=1,\"k2\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-153090947}"),
  )
}

///|
fn value_walk_case_693() -> Unit raise {
  let a = value_native_create("{\"😀\"=1,\"k2\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_694() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"a\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"a\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380268669}"),
  )
}

///|
fn value_walk_case_695() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"a\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"a\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-281932217}"),
  )
}

///|
fn value_walk_case_696() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"a\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_697() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"😀\"=text}")
  let b = value_native_create("{\"a\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380268669}"),
  )
}

///|
fn value_walk_case_698() -> Unit raise {
  let a = value_native_create("{\"a\"=0,\"😀\"=text}")
  let b = value_native_create("{\"a\"=1,\"😀\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76409881}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-281932217}"),
  )
}

///|
fn value_walk_case_699() -> Unit raise {
  let a = value_native_create("{\"a\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_700() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"z\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"z\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380300444}"),
  )
}

///|
fn value_walk_case_701() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"z\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"z\"=1,\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1241562660}"),
  )
}

///|
fn value_walk_case_702() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"z\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_703() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"😀\"=text}")
  let b = value_native_create("{\"z\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1380300444}"),
  )
}

///|
fn value_walk_case_704() -> Unit raise {
  let a = value_native_create("{\"z\"=0,\"😀\"=text}")
  let b = value_native_create("{\"z\"=1,\"😀\"=${missing},\"missing-key\"=2}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":76441656}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1241562660}"),
  )
}

///|
fn value_walk_case_705() -> Unit raise {
  let a = value_native_create("{\"z\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_706() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"Aa\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"Aa\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_707() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"Aa\"=0}")
  let b = value_native_create(
    "{\"😀\"=${missing},\"Aa\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_708() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"Aa\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_709() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"😀\"=text}")
  let b = value_native_create("{\"Aa\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_710() -> Unit raise {
  let a = value_native_create("{\"Aa\"=0,\"😀\"=text}")
  let b = value_native_create(
    "{\"Aa\"=1,\"😀\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_711() -> Unit raise {
  let a = value_native_create("{\"Aa\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_712() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"BB\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"BB\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_713() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"BB\"=0}")
  let b = value_native_create(
    "{\"😀\"=${missing},\"BB\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_714() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"BB\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_715() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"😀\"=text}")
  let b = value_native_create("{\"BB\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1382829734}"),
  )
}

///|
fn value_walk_case_716() -> Unit raise {
  let a = value_native_create("{\"BB\"=0,\"😀\"=text}")
  let b = value_native_create(
    "{\"BB\"=1,\"😀\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":78970946}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-202539202}"),
  )
}

///|
fn value_walk_case_717() -> Unit raise {
  let a = value_native_create("{\"BB\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_718() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"a.long\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"a.long\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1386401099}"),
  )
}

///|
fn value_walk_case_719() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"a.long\"=0}")
  let b = value_native_create(
    "{\"😀\"=${missing},\"a.long\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-149349105}"),
  )
}

///|
fn value_walk_case_720() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"a.long\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_721() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"😀\"=text}")
  let b = value_native_create("{\"a.long\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1386401099}"),
  )
}

///|
fn value_walk_case_722() -> Unit raise {
  let a = value_native_create("{\"a.long\"=0,\"😀\"=text}")
  let b = value_native_create(
    "{\"a.long\"=1,\"😀\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1604707409}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-149349105}"),
  )
}

///|
fn value_walk_case_723() -> Unit raise {
  let a = value_native_create("{\"a.long\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_724() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"k10\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"k10\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1512830156}"),
  )
}

///|
fn value_walk_case_725() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"k10\"=0}")
  let b = value_native_create(
    "{\"😀\"=${missing},\"k10\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-467493416}"),
  )
}

///|
fn value_walk_case_726() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"k10\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_727() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"😀\"=text}")
  let b = value_native_create("{\"k10\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1512830156}"),
  )
}

///|
fn value_walk_case_728() -> Unit raise {
  let a = value_native_create("{\"k10\"=0,\"😀\"=text}")
  let b = value_native_create(
    "{\"k10\"=1,\"😀\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":208971368}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-467493416}"),
  )
}

///|
fn value_walk_case_729() -> Unit raise {
  let a = value_native_create("{\"k10\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_730() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"k2\"=0}")
  let b = value_native_create("{\"😀\"=${missing},\"k2\"=1}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1384424839}"),
  )
}

///|
fn value_walk_case_731() -> Unit raise {
  let a = value_native_create("{\"😀\"=text,\"k2\"=0}")
  let b = value_native_create(
    "{\"😀\"=${missing},\"k2\"=1,\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-153090947}"),
  )
}

///|
fn value_walk_case_732() -> Unit raise {
  let a = value_native_create("{\"😀\"=${missing},\"k2\"=1}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_733() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"😀\"=text}")
  let b = value_native_create("{\"k2\"=1,\"😀\"=${missing}}")
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1384424839}"),
  )
}

///|
fn value_walk_case_734() -> Unit raise {
  let a = value_native_create("{\"k2\"=0,\"😀\"=text}")
  let b = value_native_create(
    "{\"k2\"=1,\"😀\"=${missing},\"missing-key\"=2}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":80566051}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-153090947}"),
  )
}

///|
fn value_walk_case_735() -> Unit raise {
  let a = value_native_create("{\"k2\"=1,\"😀\"=${missing}}")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_736() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_737() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_738() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_739() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_740() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_741() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_742() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_743() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_744() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_745() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_746() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_747() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_748() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_749() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_750() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_751() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_752() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_753() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_754() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_755() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_756() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_757() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_758() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_759() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_760() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_761() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_762() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_763() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_764() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_765() -> Unit raise {
  let a = value_native_create("[]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_766() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_767() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_768() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_769() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_770() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_771() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_772() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_773() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_774() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_775() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_776() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_777() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_778() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_779() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_780() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_781() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_782() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_783() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_784() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_785() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_786() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_787() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_788() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_789() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_790() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_791() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_792() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_793() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_794() -> Unit raise {
  let a = value_native_create("[1]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_795() -> Unit raise {
  let a = value_native_create("[2]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_796() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_797() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_798() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_799() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_800() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":7}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_801() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_802() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_803() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_804() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_805() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_806() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_807() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_808() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_809() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_810() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_811() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_812() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_813() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_814() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_815() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_816() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_817() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_818() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_819() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_820() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_821() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_822() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_823() -> Unit raise {
  let a = value_native_create("[1,3,4,5,6,7,8,9]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_824() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,1]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_825() -> Unit raise {
  let a = value_native_create("[2,3,4,5,6,7,8,9]")
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_826() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_827() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":63}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":63}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_828() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_829() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_830() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":63}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":63}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_831() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_832() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_833() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_834() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_835() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_836() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_837() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_838() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_839() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_840() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_841() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_842() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_843() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_844() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_845() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_846() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_847() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_848() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_849() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_850() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_851() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_852() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_853() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_854() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,1]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_855() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_856() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_857() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":511}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_858() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_859() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_860() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":511}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":511}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_861() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("1.0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_862() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_863() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_864() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("0")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_865() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_866() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_867() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("-1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_868() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_869() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_870() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("null")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_871() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_872() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_873() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("\"1\"")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_874() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_875() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_876() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_877() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_878() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_879() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_880() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_881() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_882() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("{x=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_883() -> Unit raise {
  let a = value_native_create(
    "[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_884() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,1]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_885() -> Unit raise {
  let a = value_native_create(
    "[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513]",
  )
  let b = value_native_create("{x=1.0}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_886() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_887() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_888() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_889() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("{a=text}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_890() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("{b=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_891() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("[text]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_892() -> Unit raise {
  let a = value_native_create("[${missing},text,1]")
  let b = value_native_create("[]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_893() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_894() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_895() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_896() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("{a=text}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_897() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("{b=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_898() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("[text]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_899() -> Unit raise {
  let a = value_native_create("[text,${missing},1]")
  let b = value_native_create("[]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_900() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_901() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":0}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_902() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_903() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("{a=text}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_904() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("{b=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_905() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("[text]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_906() -> Unit raise {
  let a = value_native_create("[1,text,${missing}]")
  let b = value_native_create("[]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_907() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_908() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_909() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_910() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("{a=text}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_911() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("{b=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_912() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("[text]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_913() -> Unit raise {
  let a = value_native_create("[{a=${missing}},{a=text},{b=1}]")
  let b = value_native_create("[]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_914() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("text")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_915() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("1")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_916() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("${missing}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_917() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("{a=text}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_918() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("{b=1}")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
}

///|
fn value_walk_case_919() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("[text]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":false}"),
  )
}

///|
fn value_walk_case_920() -> Unit raise {
  let a = value_native_create("[[${missing}],[text],[]]")
  let b = value_native_create("[]")
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.list_index_of(a, b, last=true).to_json()),
    @json.parse("{\"accepted\":true,\"value\":2}"),
  )
  assert_eq(
    value_native_attempt(() => {
      (if @hocon.value_type(a) == "OBJECT" {
        @hocon.object_contains_value(a, b)
      } else {
        @hocon.list_index_of(a, b) >= 0
      }).to_json()
    }),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
}

///|
fn value_walk_case_921() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
}

///|
fn value_walk_case_922() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  let b = value_native_create(
    "{\"k0\"=-1,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
}

///|
fn value_walk_case_923() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=-1}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051907}"),
  )
}

///|
fn value_walk_case_924() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  let b = value_native_create(
    "{\"new-key\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1245044359}"),
  )
}

///|
fn value_walk_case_925() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1267051962}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":179417301}"),
  )
}

///|
fn value_walk_case_926() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
}

///|
fn value_walk_case_927() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  let b = value_native_create(
    "{\"k0\"=-1,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
}

///|
fn value_walk_case_928() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=-1}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112989068}"),
  )
}

///|
fn value_walk_case_929() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  let b = value_native_create(
    "{\"new-key\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":513215123}"),
  )
}

///|
fn value_walk_case_930() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1112990698}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":-718664811}"),
  )
}

///|
fn value_walk_case_931() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":true}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
}

///|
fn value_walk_case_932() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  let b = value_native_create(
    "{\"k0\"=-1,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
}

///|
fn value_walk_case_933() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=-1}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290007814}"),
  )
}

///|
fn value_walk_case_934() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  let b = value_native_create(
    "{\"new-key\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":1434530917}"),
  )
}

///|
fn value_walk_case_935() -> Unit raise {
  let a = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126,\"k127\"=\"127\"}",
  )
  let b = value_native_create(
    "{\"k0\"=0,\"k1\"=\"1\",\"k2\"=2,\"k3\"=\"3\",\"k4\"=4,\"k5\"=\"5\",\"k6\"=6,\"k7\"=\"7\",\"k8\"=8,\"k9\"=\"9\",\"k10\"=10,\"k11\"=\"11\",\"k12\"=12,\"k13\"=\"13\",\"k14\"=14,\"k15\"=\"15\",\"k16\"=16,\"k17\"=\"17\",\"k18\"=18,\"k19\"=\"19\",\"k20\"=20,\"k21\"=\"21\",\"k22\"=22,\"k23\"=\"23\",\"k24\"=24,\"k25\"=\"25\",\"k26\"=26,\"k27\"=\"27\",\"k28\"=28,\"k29\"=\"29\",\"k30\"=30,\"k31\"=\"31\",\"k32\"=32,\"k33\"=\"33\",\"k34\"=34,\"k35\"=\"35\",\"k36\"=36,\"k37\"=\"37\",\"k38\"=38,\"k39\"=\"39\",\"k40\"=40,\"k41\"=\"41\",\"k42\"=42,\"k43\"=\"43\",\"k44\"=44,\"k45\"=\"45\",\"k46\"=46,\"k47\"=\"47\",\"k48\"=48,\"k49\"=\"49\",\"k50\"=50,\"k51\"=\"51\",\"k52\"=52,\"k53\"=\"53\",\"k54\"=54,\"k55\"=\"55\",\"k56\"=56,\"k57\"=\"57\",\"k58\"=58,\"k59\"=\"59\",\"k60\"=60,\"k61\"=\"61\",\"k62\"=62,\"k63\"=\"63\",\"k64\"=64,\"k65\"=\"65\",\"k66\"=66,\"k67\"=\"67\",\"k68\"=68,\"k69\"=\"69\",\"k70\"=70,\"k71\"=\"71\",\"k72\"=72,\"k73\"=\"73\",\"k74\"=74,\"k75\"=\"75\",\"k76\"=76,\"k77\"=\"77\",\"k78\"=78,\"k79\"=\"79\",\"k80\"=80,\"k81\"=\"81\",\"k82\"=82,\"k83\"=\"83\",\"k84\"=84,\"k85\"=\"85\",\"k86\"=86,\"k87\"=\"87\",\"k88\"=88,\"k89\"=\"89\",\"k90\"=90,\"k91\"=\"91\",\"k92\"=92,\"k93\"=\"93\",\"k94\"=94,\"k95\"=\"95\",\"k96\"=96,\"k97\"=\"97\",\"k98\"=98,\"k99\"=\"99\",\"k100\"=100,\"k101\"=\"101\",\"k102\"=102,\"k103\"=\"103\",\"k104\"=104,\"k105\"=\"105\",\"k106\"=106,\"k107\"=\"107\",\"k108\"=108,\"k109\"=\"109\",\"k110\"=110,\"k111\"=\"111\",\"k112\"=112,\"k113\"=\"113\",\"k114\"=114,\"k115\"=\"115\",\"k116\"=116,\"k117\"=\"117\",\"k118\"=118,\"k119\"=\"119\",\"k120\"=120,\"k121\"=\"121\",\"k122\"=122,\"k123\"=\"123\",\"k124\"=124,\"k125\"=\"125\",\"k126\"=126}",
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(a, b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_equals(b, a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":false}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(a).to_json()),
    @json.parse("{\"accepted\":true,\"value\":290056508}"),
  )
  assert_eq(
    value_native_attempt(() => @hocon.value_hash(b).to_json()),
    @json.parse("{\"accepted\":true,\"value\":810428077}"),
  )
}

///|
test "native value traversal batch 0" {
  value_walk_case_0()
  value_walk_case_1()
  value_walk_case_2()
  value_walk_case_3()
  value_walk_case_4()
  value_walk_case_5()
  value_walk_case_6()
  value_walk_case_7()
  value_walk_case_8()
  value_walk_case_9()
  value_walk_case_10()
  value_walk_case_11()
  value_walk_case_12()
  value_walk_case_13()
  value_walk_case_14()
  value_walk_case_15()
  value_walk_case_16()
  value_walk_case_17()
  value_walk_case_18()
  value_walk_case_19()
  value_walk_case_20()
  value_walk_case_21()
  value_walk_case_22()
  value_walk_case_23()
  value_walk_case_24()
  value_walk_case_25()
  value_walk_case_26()
  value_walk_case_27()
  value_walk_case_28()
  value_walk_case_29()
  value_walk_case_30()
  value_walk_case_31()
  value_walk_case_32()
  value_walk_case_33()
  value_walk_case_34()
  value_walk_case_35()
  value_walk_case_36()
  value_walk_case_37()
  value_walk_case_38()
  value_walk_case_39()
  value_walk_case_40()
  value_walk_case_41()
  value_walk_case_42()
  value_walk_case_43()
  value_walk_case_44()
  value_walk_case_45()
  value_walk_case_46()
  value_walk_case_47()
  value_walk_case_48()
  value_walk_case_49()
  value_walk_case_50()
  value_walk_case_51()
  value_walk_case_52()
  value_walk_case_53()
  value_walk_case_54()
  value_walk_case_55()
  value_walk_case_56()
  value_walk_case_57()
  value_walk_case_58()
  value_walk_case_59()
  value_walk_case_60()
  value_walk_case_61()
  value_walk_case_62()
  value_walk_case_63()
}

///|
test "native value traversal batch 1" {
  value_walk_case_64()
  value_walk_case_65()
  value_walk_case_66()
  value_walk_case_67()
  value_walk_case_68()
  value_walk_case_69()
  value_walk_case_70()
  value_walk_case_71()
  value_walk_case_72()
  value_walk_case_73()
  value_walk_case_74()
  value_walk_case_75()
  value_walk_case_76()
  value_walk_case_77()
  value_walk_case_78()
  value_walk_case_79()
  value_walk_case_80()
  value_walk_case_81()
  value_walk_case_82()
  value_walk_case_83()
  value_walk_case_84()
  value_walk_case_85()
  value_walk_case_86()
  value_walk_case_87()
  value_walk_case_88()
  value_walk_case_89()
  value_walk_case_90()
  value_walk_case_91()
  value_walk_case_92()
  value_walk_case_93()
  value_walk_case_94()
  value_walk_case_95()
  value_walk_case_96()
  value_walk_case_97()
  value_walk_case_98()
  value_walk_case_99()
  value_walk_case_100()
  value_walk_case_101()
  value_walk_case_102()
  value_walk_case_103()
  value_walk_case_104()
  value_walk_case_105()
  value_walk_case_106()
  value_walk_case_107()
  value_walk_case_108()
  value_walk_case_109()
  value_walk_case_110()
  value_walk_case_111()
  value_walk_case_112()
  value_walk_case_113()
  value_walk_case_114()
  value_walk_case_115()
  value_walk_case_116()
  value_walk_case_117()
  value_walk_case_118()
  value_walk_case_119()
  value_walk_case_120()
  value_walk_case_121()
  value_walk_case_122()
  value_walk_case_123()
  value_walk_case_124()
  value_walk_case_125()
  value_walk_case_126()
  value_walk_case_127()
}

///|
test "native value traversal batch 2" {
  value_walk_case_128()
  value_walk_case_129()
  value_walk_case_130()
  value_walk_case_131()
  value_walk_case_132()
  value_walk_case_133()
  value_walk_case_134()
  value_walk_case_135()
  value_walk_case_136()
  value_walk_case_137()
  value_walk_case_138()
  value_walk_case_139()
  value_walk_case_140()
  value_walk_case_141()
  value_walk_case_142()
  value_walk_case_143()
  value_walk_case_144()
  value_walk_case_145()
  value_walk_case_146()
  value_walk_case_147()
  value_walk_case_148()
  value_walk_case_149()
  value_walk_case_150()
  value_walk_case_151()
  value_walk_case_152()
  value_walk_case_153()
  value_walk_case_154()
  value_walk_case_155()
  value_walk_case_156()
  value_walk_case_157()
  value_walk_case_158()
  value_walk_case_159()
  value_walk_case_160()
  value_walk_case_161()
  value_walk_case_162()
  value_walk_case_163()
  value_walk_case_164()
  value_walk_case_165()
  value_walk_case_166()
  value_walk_case_167()
  value_walk_case_168()
  value_walk_case_169()
  value_walk_case_170()
  value_walk_case_171()
  value_walk_case_172()
  value_walk_case_173()
  value_walk_case_174()
  value_walk_case_175()
  value_walk_case_176()
  value_walk_case_177()
  value_walk_case_178()
  value_walk_case_179()
  value_walk_case_180()
  value_walk_case_181()
  value_walk_case_182()
  value_walk_case_183()
  value_walk_case_184()
  value_walk_case_185()
  value_walk_case_186()
  value_walk_case_187()
  value_walk_case_188()
  value_walk_case_189()
  value_walk_case_190()
  value_walk_case_191()
}

///|
test "native value traversal batch 3" {
  value_walk_case_192()
  value_walk_case_193()
  value_walk_case_194()
  value_walk_case_195()
  value_walk_case_196()
  value_walk_case_197()
  value_walk_case_198()
  value_walk_case_199()
  value_walk_case_200()
  value_walk_case_201()
  value_walk_case_202()
  value_walk_case_203()
  value_walk_case_204()
  value_walk_case_205()
  value_walk_case_206()
  value_walk_case_207()
  value_walk_case_208()
  value_walk_case_209()
  value_walk_case_210()
  value_walk_case_211()
  value_walk_case_212()
  value_walk_case_213()
  value_walk_case_214()
  value_walk_case_215()
  value_walk_case_216()
  value_walk_case_217()
  value_walk_case_218()
  value_walk_case_219()
  value_walk_case_220()
  value_walk_case_221()
  value_walk_case_222()
  value_walk_case_223()
  value_walk_case_224()
  value_walk_case_225()
  value_walk_case_226()
  value_walk_case_227()
  value_walk_case_228()
  value_walk_case_229()
  value_walk_case_230()
  value_walk_case_231()
  value_walk_case_232()
  value_walk_case_233()
  value_walk_case_234()
  value_walk_case_235()
  value_walk_case_236()
  value_walk_case_237()
  value_walk_case_238()
  value_walk_case_239()
  value_walk_case_240()
  value_walk_case_241()
  value_walk_case_242()
  value_walk_case_243()
  value_walk_case_244()
  value_walk_case_245()
  value_walk_case_246()
  value_walk_case_247()
  value_walk_case_248()
  value_walk_case_249()
  value_walk_case_250()
  value_walk_case_251()
  value_walk_case_252()
  value_walk_case_253()
  value_walk_case_254()
  value_walk_case_255()
}

///|
test "native value traversal batch 4" {
  value_walk_case_256()
  value_walk_case_257()
  value_walk_case_258()
  value_walk_case_259()
  value_walk_case_260()
  value_walk_case_261()
  value_walk_case_262()
  value_walk_case_263()
  value_walk_case_264()
  value_walk_case_265()
  value_walk_case_266()
  value_walk_case_267()
  value_walk_case_268()
  value_walk_case_269()
  value_walk_case_270()
  value_walk_case_271()
  value_walk_case_272()
  value_walk_case_273()
  value_walk_case_274()
  value_walk_case_275()
  value_walk_case_276()
  value_walk_case_277()
  value_walk_case_278()
  value_walk_case_279()
  value_walk_case_280()
  value_walk_case_281()
  value_walk_case_282()
  value_walk_case_283()
  value_walk_case_284()
  value_walk_case_285()
  value_walk_case_286()
  value_walk_case_287()
  value_walk_case_288()
  value_walk_case_289()
  value_walk_case_290()
  value_walk_case_291()
  value_walk_case_292()
  value_walk_case_293()
  value_walk_case_294()
  value_walk_case_295()
  value_walk_case_296()
  value_walk_case_297()
  value_walk_case_298()
  value_walk_case_299()
  value_walk_case_300()
  value_walk_case_301()
  value_walk_case_302()
  value_walk_case_303()
  value_walk_case_304()
  value_walk_case_305()
  value_walk_case_306()
  value_walk_case_307()
  value_walk_case_308()
  value_walk_case_309()
  value_walk_case_310()
  value_walk_case_311()
  value_walk_case_312()
  value_walk_case_313()
  value_walk_case_314()
  value_walk_case_315()
  value_walk_case_316()
  value_walk_case_317()
  value_walk_case_318()
  value_walk_case_319()
}

///|
test "native value traversal batch 5" {
  value_walk_case_320()
  value_walk_case_321()
  value_walk_case_322()
  value_walk_case_323()
  value_walk_case_324()
  value_walk_case_325()
  value_walk_case_326()
  value_walk_case_327()
  value_walk_case_328()
  value_walk_case_329()
  value_walk_case_330()
  value_walk_case_331()
  value_walk_case_332()
  value_walk_case_333()
  value_walk_case_334()
  value_walk_case_335()
  value_walk_case_336()
  value_walk_case_337()
  value_walk_case_338()
  value_walk_case_339()
  value_walk_case_340()
  value_walk_case_341()
  value_walk_case_342()
  value_walk_case_343()
  value_walk_case_344()
  value_walk_case_345()
  value_walk_case_346()
  value_walk_case_347()
  value_walk_case_348()
  value_walk_case_349()
  value_walk_case_350()
  value_walk_case_351()
  value_walk_case_352()
  value_walk_case_353()
  value_walk_case_354()
  value_walk_case_355()
  value_walk_case_356()
  value_walk_case_357()
  value_walk_case_358()
  value_walk_case_359()
  value_walk_case_360()
  value_walk_case_361()
  value_walk_case_362()
  value_walk_case_363()
  value_walk_case_364()
  value_walk_case_365()
  value_walk_case_366()
  value_walk_case_367()
  value_walk_case_368()
  value_walk_case_369()
  value_walk_case_370()
  value_walk_case_371()
  value_walk_case_372()
  value_walk_case_373()
  value_walk_case_374()
  value_walk_case_375()
  value_walk_case_376()
  value_walk_case_377()
  value_walk_case_378()
  value_walk_case_379()
  value_walk_case_380()
  value_walk_case_381()
  value_walk_case_382()
  value_walk_case_383()
}

///|
test "native value traversal batch 6" {
  value_walk_case_384()
  value_walk_case_385()
  value_walk_case_386()
  value_walk_case_387()
  value_walk_case_388()
  value_walk_case_389()
  value_walk_case_390()
  value_walk_case_391()
  value_walk_case_392()
  value_walk_case_393()
  value_walk_case_394()
  value_walk_case_395()
  value_walk_case_396()
  value_walk_case_397()
  value_walk_case_398()
  value_walk_case_399()
  value_walk_case_400()
  value_walk_case_401()
  value_walk_case_402()
  value_walk_case_403()
  value_walk_case_404()
  value_walk_case_405()
  value_walk_case_406()
  value_walk_case_407()
  value_walk_case_408()
  value_walk_case_409()
  value_walk_case_410()
  value_walk_case_411()
  value_walk_case_412()
  value_walk_case_413()
  value_walk_case_414()
  value_walk_case_415()
  value_walk_case_416()
  value_walk_case_417()
  value_walk_case_418()
  value_walk_case_419()
  value_walk_case_420()
  value_walk_case_421()
  value_walk_case_422()
  value_walk_case_423()
  value_walk_case_424()
  value_walk_case_425()
  value_walk_case_426()
  value_walk_case_427()
  value_walk_case_428()
  value_walk_case_429()
  value_walk_case_430()
  value_walk_case_431()
  value_walk_case_432()
  value_walk_case_433()
  value_walk_case_434()
  value_walk_case_435()
  value_walk_case_436()
  value_walk_case_437()
  value_walk_case_438()
  value_walk_case_439()
  value_walk_case_440()
  value_walk_case_441()
  value_walk_case_442()
  value_walk_case_443()
  value_walk_case_444()
  value_walk_case_445()
  value_walk_case_446()
  value_walk_case_447()
}

///|
test "native value traversal batch 7" {
  value_walk_case_448()
  value_walk_case_449()
  value_walk_case_450()
  value_walk_case_451()
  value_walk_case_452()
  value_walk_case_453()
  value_walk_case_454()
  value_walk_case_455()
  value_walk_case_456()
  value_walk_case_457()
  value_walk_case_458()
  value_walk_case_459()
  value_walk_case_460()
  value_walk_case_461()
  value_walk_case_462()
  value_walk_case_463()
  value_walk_case_464()
  value_walk_case_465()
  value_walk_case_466()
  value_walk_case_467()
  value_walk_case_468()
  value_walk_case_469()
  value_walk_case_470()
  value_walk_case_471()
  value_walk_case_472()
  value_walk_case_473()
  value_walk_case_474()
  value_walk_case_475()
  value_walk_case_476()
  value_walk_case_477()
  value_walk_case_478()
  value_walk_case_479()
  value_walk_case_480()
  value_walk_case_481()
  value_walk_case_482()
  value_walk_case_483()
  value_walk_case_484()
  value_walk_case_485()
  value_walk_case_486()
  value_walk_case_487()
  value_walk_case_488()
  value_walk_case_489()
  value_walk_case_490()
  value_walk_case_491()
  value_walk_case_492()
  value_walk_case_493()
  value_walk_case_494()
  value_walk_case_495()
  value_walk_case_496()
  value_walk_case_497()
  value_walk_case_498()
  value_walk_case_499()
  value_walk_case_500()
  value_walk_case_501()
  value_walk_case_502()
  value_walk_case_503()
  value_walk_case_504()
  value_walk_case_505()
  value_walk_case_506()
  value_walk_case_507()
  value_walk_case_508()
  value_walk_case_509()
  value_walk_case_510()
  value_walk_case_511()
}

///|
test "native value traversal batch 8" {
  value_walk_case_512()
  value_walk_case_513()
  value_walk_case_514()
  value_walk_case_515()
  value_walk_case_516()
  value_walk_case_517()
  value_walk_case_518()
  value_walk_case_519()
  value_walk_case_520()
  value_walk_case_521()
  value_walk_case_522()
  value_walk_case_523()
  value_walk_case_524()
  value_walk_case_525()
  value_walk_case_526()
  value_walk_case_527()
  value_walk_case_528()
  value_walk_case_529()
  value_walk_case_530()
  value_walk_case_531()
  value_walk_case_532()
  value_walk_case_533()
  value_walk_case_534()
  value_walk_case_535()
  value_walk_case_536()
  value_walk_case_537()
  value_walk_case_538()
  value_walk_case_539()
  value_walk_case_540()
  value_walk_case_541()
  value_walk_case_542()
  value_walk_case_543()
  value_walk_case_544()
  value_walk_case_545()
  value_walk_case_546()
  value_walk_case_547()
  value_walk_case_548()
  value_walk_case_549()
  value_walk_case_550()
  value_walk_case_551()
  value_walk_case_552()
  value_walk_case_553()
  value_walk_case_554()
  value_walk_case_555()
  value_walk_case_556()
  value_walk_case_557()
  value_walk_case_558()
  value_walk_case_559()
  value_walk_case_560()
  value_walk_case_561()
  value_walk_case_562()
  value_walk_case_563()
  value_walk_case_564()
  value_walk_case_565()
  value_walk_case_566()
  value_walk_case_567()
  value_walk_case_568()
  value_walk_case_569()
  value_walk_case_570()
  value_walk_case_571()
  value_walk_case_572()
  value_walk_case_573()
  value_walk_case_574()
  value_walk_case_575()
}

///|
test "native value traversal batch 9" {
  value_walk_case_576()
  value_walk_case_577()
  value_walk_case_578()
  value_walk_case_579()
  value_walk_case_580()
  value_walk_case_581()
  value_walk_case_582()
  value_walk_case_583()
  value_walk_case_584()
  value_walk_case_585()
  value_walk_case_586()
  value_walk_case_587()
  value_walk_case_588()
  value_walk_case_589()
  value_walk_case_590()
  value_walk_case_591()
  value_walk_case_592()
  value_walk_case_593()
  value_walk_case_594()
  value_walk_case_595()
  value_walk_case_596()
  value_walk_case_597()
  value_walk_case_598()
  value_walk_case_599()
  value_walk_case_600()
  value_walk_case_601()
  value_walk_case_602()
  value_walk_case_603()
  value_walk_case_604()
  value_walk_case_605()
  value_walk_case_606()
  value_walk_case_607()
  value_walk_case_608()
  value_walk_case_609()
  value_walk_case_610()
  value_walk_case_611()
  value_walk_case_612()
  value_walk_case_613()
  value_walk_case_614()
  value_walk_case_615()
  value_walk_case_616()
  value_walk_case_617()
  value_walk_case_618()
  value_walk_case_619()
  value_walk_case_620()
  value_walk_case_621()
  value_walk_case_622()
  value_walk_case_623()
  value_walk_case_624()
  value_walk_case_625()
  value_walk_case_626()
  value_walk_case_627()
  value_walk_case_628()
  value_walk_case_629()
  value_walk_case_630()
  value_walk_case_631()
  value_walk_case_632()
  value_walk_case_633()
  value_walk_case_634()
  value_walk_case_635()
  value_walk_case_636()
  value_walk_case_637()
  value_walk_case_638()
  value_walk_case_639()
}

///|
test "native value traversal batch 10" {
  value_walk_case_640()
  value_walk_case_641()
  value_walk_case_642()
  value_walk_case_643()
  value_walk_case_644()
  value_walk_case_645()
  value_walk_case_646()
  value_walk_case_647()
  value_walk_case_648()
  value_walk_case_649()
  value_walk_case_650()
  value_walk_case_651()
  value_walk_case_652()
  value_walk_case_653()
  value_walk_case_654()
  value_walk_case_655()
  value_walk_case_656()
  value_walk_case_657()
  value_walk_case_658()
  value_walk_case_659()
  value_walk_case_660()
  value_walk_case_661()
  value_walk_case_662()
  value_walk_case_663()
  value_walk_case_664()
  value_walk_case_665()
  value_walk_case_666()
  value_walk_case_667()
  value_walk_case_668()
  value_walk_case_669()
  value_walk_case_670()
  value_walk_case_671()
  value_walk_case_672()
  value_walk_case_673()
  value_walk_case_674()
  value_walk_case_675()
  value_walk_case_676()
  value_walk_case_677()
  value_walk_case_678()
  value_walk_case_679()
  value_walk_case_680()
  value_walk_case_681()
  value_walk_case_682()
  value_walk_case_683()
  value_walk_case_684()
  value_walk_case_685()
  value_walk_case_686()
  value_walk_case_687()
  value_walk_case_688()
  value_walk_case_689()
  value_walk_case_690()
  value_walk_case_691()
  value_walk_case_692()
  value_walk_case_693()
  value_walk_case_694()
  value_walk_case_695()
  value_walk_case_696()
  value_walk_case_697()
  value_walk_case_698()
  value_walk_case_699()
  value_walk_case_700()
  value_walk_case_701()
  value_walk_case_702()
  value_walk_case_703()
}

///|
test "native value traversal batch 11" {
  value_walk_case_704()
  value_walk_case_705()
  value_walk_case_706()
  value_walk_case_707()
  value_walk_case_708()
  value_walk_case_709()
  value_walk_case_710()
  value_walk_case_711()
  value_walk_case_712()
  value_walk_case_713()
  value_walk_case_714()
  value_walk_case_715()
  value_walk_case_716()
  value_walk_case_717()
  value_walk_case_718()
  value_walk_case_719()
  value_walk_case_720()
  value_walk_case_721()
  value_walk_case_722()
  value_walk_case_723()
  value_walk_case_724()
  value_walk_case_725()
  value_walk_case_726()
  value_walk_case_727()
  value_walk_case_728()
  value_walk_case_729()
  value_walk_case_730()
  value_walk_case_731()
  value_walk_case_732()
  value_walk_case_733()
  value_walk_case_734()
  value_walk_case_735()
  value_walk_case_736()
  value_walk_case_737()
  value_walk_case_738()
  value_walk_case_739()
  value_walk_case_740()
  value_walk_case_741()
  value_walk_case_742()
  value_walk_case_743()
  value_walk_case_744()
  value_walk_case_745()
  value_walk_case_746()
  value_walk_case_747()
  value_walk_case_748()
  value_walk_case_749()
  value_walk_case_750()
  value_walk_case_751()
  value_walk_case_752()
  value_walk_case_753()
  value_walk_case_754()
  value_walk_case_755()
  value_walk_case_756()
  value_walk_case_757()
  value_walk_case_758()
  value_walk_case_759()
  value_walk_case_760()
  value_walk_case_761()
  value_walk_case_762()
  value_walk_case_763()
  value_walk_case_764()
  value_walk_case_765()
  value_walk_case_766()
  value_walk_case_767()
}

///|
test "native value traversal batch 12" {
  value_walk_case_768()
  value_walk_case_769()
  value_walk_case_770()
  value_walk_case_771()
  value_walk_case_772()
  value_walk_case_773()
  value_walk_case_774()
  value_walk_case_775()
  value_walk_case_776()
  value_walk_case_777()
  value_walk_case_778()
  value_walk_case_779()
  value_walk_case_780()
  value_walk_case_781()
  value_walk_case_782()
  value_walk_case_783()
  value_walk_case_784()
  value_walk_case_785()
  value_walk_case_786()
  value_walk_case_787()
  value_walk_case_788()
  value_walk_case_789()
  value_walk_case_790()
  value_walk_case_791()
  value_walk_case_792()
  value_walk_case_793()
  value_walk_case_794()
  value_walk_case_795()
  value_walk_case_796()
  value_walk_case_797()
  value_walk_case_798()
  value_walk_case_799()
  value_walk_case_800()
  value_walk_case_801()
  value_walk_case_802()
  value_walk_case_803()
  value_walk_case_804()
  value_walk_case_805()
  value_walk_case_806()
  value_walk_case_807()
  value_walk_case_808()
  value_walk_case_809()
  value_walk_case_810()
  value_walk_case_811()
  value_walk_case_812()
  value_walk_case_813()
  value_walk_case_814()
  value_walk_case_815()
  value_walk_case_816()
  value_walk_case_817()
  value_walk_case_818()
  value_walk_case_819()
  value_walk_case_820()
  value_walk_case_821()
  value_walk_case_822()
  value_walk_case_823()
  value_walk_case_824()
  value_walk_case_825()
  value_walk_case_826()
  value_walk_case_827()
  value_walk_case_828()
  value_walk_case_829()
  value_walk_case_830()
  value_walk_case_831()
}

///|
test "native value traversal batch 13" {
  value_walk_case_832()
  value_walk_case_833()
  value_walk_case_834()
  value_walk_case_835()
  value_walk_case_836()
  value_walk_case_837()
  value_walk_case_838()
  value_walk_case_839()
  value_walk_case_840()
  value_walk_case_841()
  value_walk_case_842()
  value_walk_case_843()
  value_walk_case_844()
  value_walk_case_845()
  value_walk_case_846()
  value_walk_case_847()
  value_walk_case_848()
  value_walk_case_849()
  value_walk_case_850()
  value_walk_case_851()
  value_walk_case_852()
  value_walk_case_853()
  value_walk_case_854()
  value_walk_case_855()
  value_walk_case_856()
  value_walk_case_857()
  value_walk_case_858()
  value_walk_case_859()
  value_walk_case_860()
  value_walk_case_861()
  value_walk_case_862()
  value_walk_case_863()
  value_walk_case_864()
  value_walk_case_865()
  value_walk_case_866()
  value_walk_case_867()
  value_walk_case_868()
  value_walk_case_869()
  value_walk_case_870()
  value_walk_case_871()
  value_walk_case_872()
  value_walk_case_873()
  value_walk_case_874()
  value_walk_case_875()
  value_walk_case_876()
  value_walk_case_877()
  value_walk_case_878()
  value_walk_case_879()
  value_walk_case_880()
  value_walk_case_881()
  value_walk_case_882()
  value_walk_case_883()
  value_walk_case_884()
  value_walk_case_885()
  value_walk_case_886()
  value_walk_case_887()
  value_walk_case_888()
  value_walk_case_889()
  value_walk_case_890()
  value_walk_case_891()
  value_walk_case_892()
  value_walk_case_893()
  value_walk_case_894()
  value_walk_case_895()
}

///|
test "native value traversal batch 14" {
  value_walk_case_896()
  value_walk_case_897()
  value_walk_case_898()
  value_walk_case_899()
  value_walk_case_900()
  value_walk_case_901()
  value_walk_case_902()
  value_walk_case_903()
  value_walk_case_904()
  value_walk_case_905()
  value_walk_case_906()
  value_walk_case_907()
  value_walk_case_908()
  value_walk_case_909()
  value_walk_case_910()
  value_walk_case_911()
  value_walk_case_912()
  value_walk_case_913()
  value_walk_case_914()
  value_walk_case_915()
  value_walk_case_916()
  value_walk_case_917()
  value_walk_case_918()
  value_walk_case_919()
  value_walk_case_920()
  value_walk_case_921()
  value_walk_case_922()
  value_walk_case_923()
  value_walk_case_924()
  value_walk_case_925()
  value_walk_case_926()
  value_walk_case_927()
  value_walk_case_928()
  value_walk_case_929()
  value_walk_case_930()
  value_walk_case_931()
  value_walk_case_932()
  value_walk_case_933()
  value_walk_case_934()
  value_walk_case_935()
}
