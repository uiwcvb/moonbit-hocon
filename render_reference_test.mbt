// Independent exact native render results; generated from the unmodified JAR.

///|
fn render_native_case_0() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"null\"}"))
}

///|
fn render_native_case_1() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"null\"}"))
}

///|
fn render_native_case_2() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"null\"}"))
}

///|
fn render_native_case_3() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"null\"}"))
}

///|
fn render_native_case_4() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=null")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":null}\"}"),
  )
}

///|
fn render_native_case_5() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=null")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : null\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_6() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=null")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=null\"}"))
}

///|
fn render_native_case_7() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=null")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=null\\n\"}"))
}

///|
fn render_native_case_8() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=null")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":null}\"}"),
  )
}

///|
fn render_native_case_9() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=null")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : null\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_10() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=null")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=null\"}"))
}

///|
fn render_native_case_11() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=null")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=null\\n\"}"))
}

///|
fn render_native_case_12() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"true\"}"))
}

///|
fn render_native_case_13() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"true\"}"))
}

///|
fn render_native_case_14() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"true\"}"))
}

///|
fn render_native_case_15() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"true\"}"))
}

///|
fn render_native_case_16() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=true")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":true}\"}"),
  )
}

///|
fn render_native_case_17() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=true")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : true\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_18() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=true")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=true\"}"))
}

///|
fn render_native_case_19() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=true")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=true\\n\"}"))
}

///|
fn render_native_case_20() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=true")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":true}\"}"),
  )
}

///|
fn render_native_case_21() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=true")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : true\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_22() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=true")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=true\"}"))
}

///|
fn render_native_case_23() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=true")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=true\\n\"}"))
}

///|
fn render_native_case_24() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("false")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"false\"}"))
}

///|
fn render_native_case_25() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("false")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"false\"}"))
}

///|
fn render_native_case_26() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("false")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"false\"}"))
}

///|
fn render_native_case_27() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("false")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"false\"}"))
}

///|
fn render_native_case_28() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=false")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":false}\"}"),
  )
}

///|
fn render_native_case_29() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=false")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : false\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_30() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=false")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=false\"}"))
}

///|
fn render_native_case_31() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=false")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=false\\n\"}"))
}

///|
fn render_native_case_32() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=false")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":false}\"}"),
  )
}

///|
fn render_native_case_33() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=false")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : false\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_34() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=false")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=false\"}"))
}

///|
fn render_native_case_35() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=false")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=false\\n\"}"))
}

///|
fn render_native_case_36() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_37() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_38() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_39() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_40() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_41() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_42() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_43() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_44() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_45() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_46() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_47() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_48() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_49() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_50() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_51() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_52() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_53() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_54() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_55() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_56() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_57() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_58() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_59() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_60() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_61() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_62() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_63() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_64() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_65() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_66() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_67() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-0.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_68() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_69() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_70() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_71() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-0.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_72() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_73() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_74() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_75() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_76() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_77() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_78() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\"}"))
}

///|
fn render_native_case_79() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\\n\"}"))
}

///|
fn render_native_case_80() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_81() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_82() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\"}"))
}

///|
fn render_native_case_83() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\\n\"}"))
}

///|
fn render_native_case_84() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.50")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.5\"}"))
}

///|
fn render_native_case_85() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.50")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.5\"}"))
}

///|
fn render_native_case_86() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.50")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.5\"}"))
}

///|
fn render_native_case_87() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.50")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.5\"}"))
}

///|
fn render_native_case_88() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.50")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.5}\"}"),
  )
}

///|
fn render_native_case_89() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.50")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_90() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.50")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.5\"}"))
}

///|
fn render_native_case_91() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1.50")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.5\\n\"}"))
}

///|
fn render_native_case_92() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.50")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.5}\"}"),
  )
}

///|
fn render_native_case_93() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.50")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_94() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.50")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.5\"}"))
}

///|
fn render_native_case_95() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1.50")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.5\\n\"}"))
}

///|
fn render_native_case_96() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1000\"}"))
}

///|
fn render_native_case_97() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1000\"}"))
}

///|
fn render_native_case_98() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1000\"}"))
}

///|
fn render_native_case_99() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1000\"}"))
}

///|
fn render_native_case_100() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1000}\"}"),
  )
}

///|
fn render_native_case_101() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e3")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1000\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_102() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e3")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1000\"}"))
}

///|
fn render_native_case_103() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e3")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1000\\n\"}"))
}

///|
fn render_native_case_104() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1000}\"}"),
  )
}

///|
fn render_native_case_105() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e3")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1000\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_106() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e3")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1000\"}"))
}

///|
fn render_native_case_107() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e3")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1000\\n\"}"))
}

///|
fn render_native_case_108() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E30\"}"))
}

///|
fn render_native_case_109() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E30\"}"))
}

///|
fn render_native_case_110() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E30\"}"))
}

///|
fn render_native_case_111() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E30\"}"))
}

///|
fn render_native_case_112() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.0E30}\"}"),
  )
}

///|
fn render_native_case_113() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e30")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.0E30\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_114() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e30")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.0E30\"}"))
}

///|
fn render_native_case_115() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e30")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.0E30\\n\"}"),
  )
}

///|
fn render_native_case_116() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.0E30}\"}"),
  )
}

///|
fn render_native_case_117() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e30")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.0E30\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_118() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e30")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.0E30\"}"))
}

///|
fn render_native_case_119() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e30")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.0E30\\n\"}"),
  )
}

///|
fn render_native_case_120() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-9\"}"))
}

///|
fn render_native_case_121() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-9")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-9\"}"))
}

///|
fn render_native_case_122() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-9")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-9\"}"))
}

///|
fn render_native_case_123() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-9")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-9\"}"))
}

///|
fn render_native_case_124() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e-9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.0E-9}\"}"),
  )
}

///|
fn render_native_case_125() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e-9")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.0E-9\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_126() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e-9")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.0E-9\"}"))
}

///|
fn render_native_case_127() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e-9")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.0E-9\\n\"}"),
  )
}

///|
fn render_native_case_128() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e-9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1.0E-9}\"}"),
  )
}

///|
fn render_native_case_129() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e-9")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.0E-9\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_130() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e-9")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1.0E-9\"}"))
}

///|
fn render_native_case_131() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e-9")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.0E-9\\n\"}"),
  )
}

///|
fn render_native_case_132() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-324\"}"))
}

///|
fn render_native_case_133() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5e-324")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-324\"}"))
}

///|
fn render_native_case_134() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5e-324")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-324\"}"))
}

///|
fn render_native_case_135() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5e-324")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-324\"}"))
}

///|
fn render_native_case_136() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=5e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":4.9E-324}\"}"),
  )
}

///|
fn render_native_case_137() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=5e-324")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 4.9E-324\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_138() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=5e-324")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=4.9E-324\"}"))
}

///|
fn render_native_case_139() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=5e-324")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=4.9E-324\\n\"}"),
  )
}

///|
fn render_native_case_140() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=5e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":4.9E-324}\"}"),
  )
}

///|
fn render_native_case_141() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=5e-324")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 4.9E-324\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_142() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=5e-324")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=4.9E-324\"}"))
}

///|
fn render_native_case_143() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=5e-324")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=4.9E-324\\n\"}"),
  )
}

///|
fn render_native_case_144() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_145() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_146() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_147() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_148() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e-999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_149() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e-999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_150() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e-999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_151() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e-999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_152() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e-999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":0}\"}"),
  )
}

///|
fn render_native_case_153() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e-999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 0\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_154() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e-999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\"}"))
}

///|
fn render_native_case_155() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e-999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=0\\n\"}"))
}

///|
fn render_native_case_156() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_157() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_158() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_159() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_160() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":Infinity}\"}"),
  )
}

///|
fn render_native_case_161() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : Infinity\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_162() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=Infinity\"}"))
}

///|
fn render_native_case_163() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=Infinity\\n\"}"),
  )
}

///|
fn render_native_case_164() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":Infinity}\"}"),
  )
}

///|
fn render_native_case_165() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : Infinity\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_166() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=Infinity\"}"))
}

///|
fn render_native_case_167() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=Infinity\\n\"}"),
  )
}

///|
fn render_native_case_168() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_169() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_170() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_171() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_172() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":-Infinity}\"}"),
  )
}

///|
fn render_native_case_173() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : -Infinity\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_174() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=-Infinity\"}"),
  )
}

///|
fn render_native_case_175() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=-1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=-Infinity\\n\"}"),
  )
}

///|
fn render_native_case_176() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e999")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":-Infinity}\"}"),
  )
}

///|
fn render_native_case_177() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e999")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : -Infinity\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_178() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e999")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=-Infinity\"}"),
  )
}

///|
fn render_native_case_179() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=-1e999")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=-Infinity\\n\"}"),
  )
}

///|
fn render_native_case_180() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2147483648")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"2147483648\"}"))
}

///|
fn render_native_case_181() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2147483648")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"2147483648\"}"))
}

///|
fn render_native_case_182() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2147483648")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"2147483648\"}"))
}

///|
fn render_native_case_183() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2147483648")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"2147483648\"}"))
}

///|
fn render_native_case_184() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=2147483648")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":2147483648}\"}"),
  )
}

///|
fn render_native_case_185() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=2147483648")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 2147483648\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_186() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=2147483648")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=2147483648\"}"),
  )
}

///|
fn render_native_case_187() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=2147483648")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=2147483648\\n\"}"),
  )
}

///|
fn render_native_case_188() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=2147483648")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":2147483648}\"}"),
  )
}

///|
fn render_native_case_189() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=2147483648")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 2147483648\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_190() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=2147483648")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=2147483648\"}"),
  )
}

///|
fn render_native_case_191() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=2147483648")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=2147483648\\n\"}"),
  )
}

///|
fn render_native_case_192() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775807")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775807\"}"),
  )
}

///|
fn render_native_case_193() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775807")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775807\"}"),
  )
}

///|
fn render_native_case_194() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775807")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775807\"}"),
  )
}

///|
fn render_native_case_195() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775807")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775807\"}"),
  )
}

///|
fn render_native_case_196() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775807")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":9223372036854775807}\"}",
    ),
  )
}

///|
fn render_native_case_197() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775807")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 9223372036854775807\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_198() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775807")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775807\"}"),
  )
}

///|
fn render_native_case_199() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775807")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775807\\n\"}"),
  )
}

///|
fn render_native_case_200() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775807")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":9223372036854775807}\"}",
    ),
  )
}

///|
fn render_native_case_201() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775807")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 9223372036854775807\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_202() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775807")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775807\"}"),
  )
}

///|
fn render_native_case_203() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775807")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775807\\n\"}"),
  )
}

///|
fn render_native_case_204() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9007199254740993")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9007199254740993\"}"),
  )
}

///|
fn render_native_case_205() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9007199254740993")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9007199254740993\"}"),
  )
}

///|
fn render_native_case_206() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9007199254740993")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9007199254740993\"}"),
  )
}

///|
fn render_native_case_207() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9007199254740993")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9007199254740993\"}"),
  )
}

///|
fn render_native_case_208() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9007199254740993")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":9007199254740993}\"}",
    ),
  )
}

///|
fn render_native_case_209() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9007199254740993")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 9007199254740993\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_210() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9007199254740993")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9007199254740993\"}"),
  )
}

///|
fn render_native_case_211() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9007199254740993")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9007199254740993\\n\"}"),
  )
}

///|
fn render_native_case_212() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9007199254740993")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":9007199254740993}\"}",
    ),
  )
}

///|
fn render_native_case_213() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9007199254740993")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 9007199254740993\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_214() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9007199254740993")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9007199254740993\"}"),
  )
}

///|
fn render_native_case_215() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9007199254740993")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9007199254740993\\n\"}"),
  )
}

///|
fn render_native_case_216() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775808")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"9223372036854775808\\\"\"}"),
  )
}

///|
fn render_native_case_217() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775808")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"9223372036854775808\\\"\"}"),
  )
}

///|
fn render_native_case_218() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775808")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775808\"}"),
  )
}

///|
fn render_native_case_219() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9223372036854775808")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9223372036854775808\"}"),
  )
}

///|
fn render_native_case_220() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775808")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"9223372036854775808\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_221() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775808")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"9223372036854775808\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_222() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775808")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775808\"}"),
  )
}

///|
fn render_native_case_223() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=9223372036854775808")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775808\\n\"}"),
  )
}

///|
fn render_native_case_224() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775808")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"9223372036854775808\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_225() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775808")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"9223372036854775808\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_226() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775808")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775808\"}"),
  )
}

///|
fn render_native_case_227() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=9223372036854775808")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=9223372036854775808\\n\"}"),
  )
}

///|
fn render_native_case_228() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("text")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"text\\\"\"}"),
  )
}

///|
fn render_native_case_229() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("text")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"text\\\"\"}"),
  )
}

///|
fn render_native_case_230() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("text")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"text\"}"))
}

///|
fn render_native_case_231() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("text")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"text\"}"))
}

///|
fn render_native_case_232() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=text")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"text\\\"}\"}"),
  )
}

///|
fn render_native_case_233() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=text")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"text\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_234() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=text")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\"}"))
}

///|
fn render_native_case_235() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=text")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\\n\"}"))
}

///|
fn render_native_case_236() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=text")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"text\\\"}\"}"),
  )
}

///|
fn render_native_case_237() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=text")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"text\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_238() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=text")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\"}"))
}

///|
fn render_native_case_239() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=text")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\\n\"}"))
}

///|
fn render_native_case_240() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a-b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a-b\\\"\"}"),
  )
}

///|
fn render_native_case_241() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a-b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a-b\\\"\"}"),
  )
}

///|
fn render_native_case_242() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a-b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a-b\"}"))
}

///|
fn render_native_case_243() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a-b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a-b\"}"))
}

///|
fn render_native_case_244() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a-b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a-b\\\"}\"}"),
  )
}

///|
fn render_native_case_245() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a-b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a-b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_246() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a-b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a-b\"}"))
}

///|
fn render_native_case_247() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a-b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a-b\\n\"}"))
}

///|
fn render_native_case_248() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a-b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a-b\\\"}\"}"),
  )
}

///|
fn render_native_case_249() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a-b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a-b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_250() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a-b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a-b\"}"))
}

///|
fn render_native_case_251() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a-b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a-b\\n\"}"))
}

///|
fn render_native_case_252() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a_b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a_b\\\"\"}"),
  )
}

///|
fn render_native_case_253() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a_b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a_b\\\"\"}"),
  )
}

///|
fn render_native_case_254() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a_b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a_b\"}"))
}

///|
fn render_native_case_255() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("a_b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a_b\"}"))
}

///|
fn render_native_case_256() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a_b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a_b\\\"}\"}"),
  )
}

///|
fn render_native_case_257() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a_b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a_b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_258() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a_b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a_b\"}"))
}

///|
fn render_native_case_259() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=a_b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a_b\\n\"}"))
}

///|
fn render_native_case_260() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a_b")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a_b\\\"}\"}"),
  )
}

///|
fn render_native_case_261() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a_b")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a_b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_262() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a_b")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a_b\"}"))
}

///|
fn render_native_case_263() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=a_b")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=a_b\\n\"}"))
}

///|
fn render_native_case_264() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("http://a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_265() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("http://a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_266() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("http://a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_267() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("http://a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_268() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=http://a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_269() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=http://a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_270() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=http://a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_271() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=http://a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_272() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=http://a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_273() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=http://a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_274() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=http://a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_275() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=http://a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_276() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"\\\"\"}"))
}

///|
fn render_native_case_277() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"\\\"\"}"))
}

///|
fn render_native_case_278() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"\\\"\"}"))
}

///|
fn render_native_case_279() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"\\\"\"}"))
}

///|
fn render_native_case_280() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"\\\"}\"}"),
  )
}

///|
fn render_native_case_281() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_282() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=\\\"\\\"\"}"))
}

///|
fn render_native_case_283() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"\\\"\\n\"}"),
  )
}

///|
fn render_native_case_284() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"\\\"}\"}"),
  )
}

///|
fn render_native_case_285() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_286() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=\\\"\\\"\"}"))
}

///|
fn render_native_case_287() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"\\\"\\n\"}"),
  )
}

///|
fn render_native_case_288() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"123\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_289() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"123\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_290() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"123\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_291() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"123\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_292() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"123\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"123\\\"}\"}"),
  )
}

///|
fn render_native_case_293() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"123\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"123\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_294() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"123\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_295() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"123\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"123\\\"\\n\"}"),
  )
}

///|
fn render_native_case_296() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"123\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"123\\\"}\"}"),
  )
}

///|
fn render_native_case_297() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"123\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"123\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_298() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"123\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"123\\\"\"}"),
  )
}

///|
fn render_native_case_299() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"123\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"123\\\"\\n\"}"),
  )
}

///|
fn render_native_case_300() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"truex\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_301() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"truex\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_302() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"truex\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_303() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"truex\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_304() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"truex\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"truex\\\"}\"}"),
  )
}

///|
fn render_native_case_305() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"truex\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"truex\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_306() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"truex\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_307() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"truex\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"truex\\\"\\n\"}"),
  )
}

///|
fn render_native_case_308() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"truex\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"truex\\\"}\"}"),
  )
}

///|
fn render_native_case_309() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"truex\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"truex\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_310() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"truex\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"truex\\\"\"}"),
  )
}

///|
fn render_native_case_311() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"truex\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"truex\\\"\\n\"}"),
  )
}

///|
fn render_native_case_312() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"falsey\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_313() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"falsey\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_314() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"falsey\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_315() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"falsey\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_316() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"falsey\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"falsey\\\"}\"}"),
  )
}

///|
fn render_native_case_317() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"falsey\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"falsey\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_318() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"falsey\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_319() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"falsey\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"falsey\\\"\\n\"}"),
  )
}

///|
fn render_native_case_320() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"falsey\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"falsey\\\"}\"}"),
  )
}

///|
fn render_native_case_321() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"falsey\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"falsey\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_322() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"falsey\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"falsey\\\"\"}"),
  )
}

///|
fn render_native_case_323() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"falsey\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"falsey\\\"\\n\"}"),
  )
}

///|
fn render_native_case_324() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"includeA\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_325() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"includeA\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_326() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"includeA\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_327() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"includeA\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_328() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"includeA\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"includeA\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_329() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"includeA\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"includeA\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_330() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"includeA\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_331() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"includeA\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"includeA\\\"\\n\"}"),
  )
}

///|
fn render_native_case_332() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"includeA\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"includeA\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_333() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"includeA\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"includeA\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_334() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"includeA\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"includeA\\\"\"}"),
  )
}

///|
fn render_native_case_335() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"includeA\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"includeA\\\"\\n\"}"),
  )
}

///|
fn render_native_case_336() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"nulls\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_337() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"nulls\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_338() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"nulls\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_339() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"nulls\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_340() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"nulls\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"nulls\\\"}\"}"),
  )
}

///|
fn render_native_case_341() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"nulls\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"nulls\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_342() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"nulls\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_343() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"nulls\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"nulls\\\"\\n\"}"),
  )
}

///|
fn render_native_case_344() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"nulls\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"nulls\\\"}\"}"),
  )
}

///|
fn render_native_case_345() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"nulls\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"nulls\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_346() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"nulls\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"nulls\\\"\"}"),
  )
}

///|
fn render_native_case_347() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"nulls\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"nulls\\\"\\n\"}"),
  )
}

///|
fn render_native_case_348() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"text\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"text\\\"\"}"),
  )
}

///|
fn render_native_case_349() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"text\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"text\\\"\"}"),
  )
}

///|
fn render_native_case_350() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"text\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"text\"}"))
}

///|
fn render_native_case_351() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"text\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"text\"}"))
}

///|
fn render_native_case_352() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"text\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"text\\\"}\"}"),
  )
}

///|
fn render_native_case_353() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"text\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"text\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_354() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"text\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\"}"))
}

///|
fn render_native_case_355() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"text\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\\n\"}"))
}

///|
fn render_native_case_356() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"text\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"text\\\"}\"}"),
  )
}

///|
fn render_native_case_357() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"text\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"text\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_358() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"text\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\"}"))
}

///|
fn render_native_case_359() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"text\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=text\\n\"}"))
}

///|
fn render_native_case_360() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"中文\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"中文\\\"\"}"),
  )
}

///|
fn render_native_case_361() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"中文\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"中文\\\"\"}"),
  )
}

///|
fn render_native_case_362() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"中文\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"中文\"}"))
}

///|
fn render_native_case_363() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"中文\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"中文\"}"))
}

///|
fn render_native_case_364() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"中文\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"中文\\\"}\"}"),
  )
}

///|
fn render_native_case_365() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"中文\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"中文\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_366() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"中文\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=中文\"}"))
}

///|
fn render_native_case_367() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"中文\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=中文\\n\"}"),
  )
}

///|
fn render_native_case_368() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"中文\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"中文\\\"}\"}"),
  )
}

///|
fn render_native_case_369() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"中文\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"中文\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_370() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"中文\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=中文\"}"))
}

///|
fn render_native_case_371() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"中文\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=中文\\n\"}"),
  )
}

///|
fn render_native_case_372() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"é\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"é\\\"\"}"))
}

///|
fn render_native_case_373() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"é\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"\\\"é\\\"\"}"))
}

///|
fn render_native_case_374() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"é\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"é\"}"))
}

///|
fn render_native_case_375() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"é\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"é\"}"))
}

///|
fn render_native_case_376() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"é\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"é\\\"}\"}"),
  )
}

///|
fn render_native_case_377() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"é\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"é\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_378() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"é\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=é\"}"))
}

///|
fn render_native_case_379() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"é\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=é\\n\"}"))
}

///|
fn render_native_case_380() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"é\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"é\\\"}\"}"),
  )
}

///|
fn render_native_case_381() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"é\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"é\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_382() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"é\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=é\"}"))
}

///|
fn render_native_case_383() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"é\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=é\\n\"}"))
}

///|
fn render_native_case_384() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"١x\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_385() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"١x\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_386() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"١x\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_387() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"١x\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_388() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"١x\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"١x\\\"}\"}"),
  )
}

///|
fn render_native_case_389() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"١x\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"١x\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_390() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"١x\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_391() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"١x\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"١x\\\"\\n\"}"),
  )
}

///|
fn render_native_case_392() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"١x\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"١x\\\"}\"}"),
  )
}

///|
fn render_native_case_393() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"١x\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"١x\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_394() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"١x\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"١x\\\"\"}"),
  )
}

///|
fn render_native_case_395() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"١x\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"١x\\\"\\n\"}"),
  )
}

///|
fn render_native_case_396() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x_y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_397() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x_y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_398() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x_y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_399() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x_y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_400() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x_y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"x_y\\\"}\"}"),
  )
}

///|
fn render_native_case_401() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x_y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"x_y\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_402() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x_y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_403() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x_y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x_y\\\"\\n\"}"),
  )
}

///|
fn render_native_case_404() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x_y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"x_y\\\"}\"}"),
  )
}

///|
fn render_native_case_405() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x_y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"x_y\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_406() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x_y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x_y\\\"\"}"),
  )
}

///|
fn render_native_case_407() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x_y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x_y\\\"\\n\"}"),
  )
}

///|
fn render_native_case_408() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_409() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_410() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_411() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"x y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_412() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"x y\\\"}\"}"),
  )
}

///|
fn render_native_case_413() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"x y\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_414() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_415() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"x y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x y\\\"\\n\"}"),
  )
}

///|
fn render_native_case_416() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x y\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"x y\\\"}\"}"),
  )
}

///|
fn render_native_case_417() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x y\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"x y\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_418() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x y\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x y\\\"\"}"),
  )
}

///|
fn render_native_case_419() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"x y\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"x y\\\"\\n\"}"),
  )
}

///|
fn render_native_case_420() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a.b\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_421() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a.b\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_422() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a.b\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_423() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a.b\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_424() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"a.b\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a.b\\\"}\"}"),
  )
}

///|
fn render_native_case_425() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"a.b\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a.b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_426() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"a.b\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_427() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"a.b\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"a.b\\\"\\n\"}"),
  )
}

///|
fn render_native_case_428() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a.b\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a.b\\\"}\"}"),
  )
}

///|
fn render_native_case_429() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a.b\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a.b\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_430() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a.b\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"a.b\\\"\"}"),
  )
}

///|
fn render_native_case_431() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a.b\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"a.b\\\"\\n\"}"),
  )
}

///|
fn render_native_case_432() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"😀\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_433() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"😀\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_434() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"😀\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_435() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"😀\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_436() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"😀\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"😀\\\"}\"}"),
  )
}

///|
fn render_native_case_437() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"😀\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"😀\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_438() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"😀\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_439() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=\"😀\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"😀\\\"\\n\"}"),
  )
}

///|
fn render_native_case_440() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"😀\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"😀\\\"}\"}"),
  )
}

///|
fn render_native_case_441() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"😀\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"😀\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_442() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"😀\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"😀\\\"\"}"),
  )
}

///|
fn render_native_case_443() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"😀\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=\\\"😀\\\"\\n\"}"),
  )
}

///|
fn render_native_case_444() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_445() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_446() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_447() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_448() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_449() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_450() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_451() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\\n\"}",
    ),
  )
}

///|
fn render_native_case_452() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_453() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_454() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\"}",
    ),
  )
}

///|
fn render_native_case_455() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=\"a\\nb\\tc\\r\\b\\f\\u0000\\u001f\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"a\\\\nb\\\\tc\\\\r\\\\b\\\\f\\\\u0000\\\\u001f\\\"\\n\"}",
    ),
  )
}

///|
fn render_native_case_456() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${missing}\"}"))
}

///|
fn render_native_case_457() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${missing}\"}"))
}

///|
fn render_native_case_458() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${missing}\"}"))
}

///|
fn render_native_case_459() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${missing}\"}"))
}

///|
fn render_native_case_460() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":${missing}}\"}"),
  )
}

///|
fn render_native_case_461() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${missing}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_462() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${missing}\"}"),
  )
}

///|
fn render_native_case_463() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${missing}\\n\"}"),
  )
}

///|
fn render_native_case_464() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_465() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_466() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_467() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_468() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_469() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_470() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_471() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_472() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":${?missing}}\"}"),
  )
}

///|
fn render_native_case_473() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${?missing}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_474() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?missing}\"}"),
  )
}

///|
fn render_native_case_475() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?missing}\\n\"}"),
  )
}

///|
fn render_native_case_476() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_477() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_478() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_479() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_480() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${\\\"a.b\\\".x}\"}"),
  )
}

///|
fn render_native_case_481() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${\\\"a.b\\\".x}\"}"),
  )
}

///|
fn render_native_case_482() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${\\\"a.b\\\".x}\"}"),
  )
}

///|
fn render_native_case_483() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${\\\"a.b\\\".x}\"}"),
  )
}

///|
fn render_native_case_484() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${\\\"a.b\\\".x}}\"}",
    ),
  )
}

///|
fn render_native_case_485() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${\\\"a.b\\\".x}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_486() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${\\\"a.b\\\".x}\"}"),
  )
}

///|
fn render_native_case_487() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${\\\"a.b\\\".x}\\n\"}"),
  )
}

///|
fn render_native_case_488() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_489() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${\"a.b\".x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_490() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_491() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${\"a.b\".x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_492() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${?ENV[]}\"}"))
}

///|
fn render_native_case_493() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${?ENV[]}\"}"))
}

///|
fn render_native_case_494() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${?ENV[]}\"}"))
}

///|
fn render_native_case_495() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${?ENV[]}\"}"))
}

///|
fn render_native_case_496() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":${?ENV[]}}\"}"),
  )
}

///|
fn render_native_case_497() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${?ENV[]}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_498() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?ENV[]}\"}"),
  )
}

///|
fn render_native_case_499() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?ENV[]}\\n\"}"),
  )
}

///|
fn render_native_case_500() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_501() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?ENV[]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_502() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_503() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${?ENV[]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_504() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\\\" world\\\"\"}",
    ),
  )
}

///|
fn render_native_case_505() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\\\" world\\\"\"}",
    ),
  )
}

///|
fn render_native_case_506() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\\\" world\\\"\"}",
    ),
  )
}

///|
fn render_native_case_507() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\\\" world\\\"\"}",
    ),
  )
}

///|
fn render_native_case_508() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":\\\"hello \\\"${missing}\\\" world\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_509() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : \\\"hello \\\"${missing}\\\" world\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_510() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"hello \\\"${missing}\\\" world\\\"\"}",
    ),
  )
}

///|
fn render_native_case_511() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=\\\"hello \\\"${missing}\\\" world\\\"\\n\"}",
    ),
  )
}

///|
fn render_native_case_512() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_513() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=hello ${missing} world")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_514() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_515() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=hello ${missing} world")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_516() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${x}${y}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}${y}\"}"))
}

///|
fn render_native_case_517() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${x}${y}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}${y}\"}"))
}

///|
fn render_native_case_518() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${x}${y}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}${y}\"}"))
}

///|
fn render_native_case_519() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${x}${y}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}${y}\"}"))
}

///|
fn render_native_case_520() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}${y}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":${x}${y}}\"}"),
  )
}

///|
fn render_native_case_521() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}${y}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x}${y}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_522() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}${y}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=${x}${y}\"}"))
}

///|
fn render_native_case_523() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}${y}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x}${y}\\n\"}"),
  )
}

///|
fn render_native_case_524() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${x}${y}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_525() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${x}${y}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_526() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${x}${y}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_527() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${x}${y}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_528() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1,2]${missing}\"}"),
  )
}

///|
fn render_native_case_529() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1,\\n    2\\n]${missing}\"}",
    ),
  )
}

///|
fn render_native_case_530() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1,2]${missing}\"}"),
  )
}

///|
fn render_native_case_531() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1,\\n    2\\n]${missing}\"}",
    ),
  )
}

///|
fn render_native_case_532() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":[1,2]${missing}}\"}"),
  )
}

///|
fn render_native_case_533() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : [\\n        1,\\n        2\\n    ]${missing}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_534() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=[1,2]${missing}\"}"),
  )
}

///|
fn render_native_case_535() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=[\\n    1,\\n    2\\n]${missing}\\n\"}",
    ),
  )
}

///|
fn render_native_case_536() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_537() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[1,2] ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_538() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_539() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[1,2] ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_540() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"x\\\":1}${missing}\"}"),
  )
}

///|
fn render_native_case_541() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x\\\" : 1\\n}\\n${missing}\"}",
    ),
  )
}

///|
fn render_native_case_542() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"x=1${missing}\"}"),
  )
}

///|
fn render_native_case_543() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"x=1\\n${missing}\"}"),
  )
}

///|
fn render_native_case_544() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"x\\\":1}${missing}}\"}",
    ),
  )
}

///|
fn render_native_case_545() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1\\n    }${missing}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_546() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a={x=1}${missing}\"}"),
  )
}

///|
fn render_native_case_547() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a={\\n    x=1\\n}${missing}\\n\"}",
    ),
  )
}

///|
fn render_native_case_548() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_549() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={x=1} ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_550() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_551() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={x=1} ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_552() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}{\\\"x\\\":2}\"}"),
  )
}

///|
fn render_native_case_553() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${missing}{\\n    \\\"x\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_554() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}x=2\"}"),
  )
}

///|
fn render_native_case_555() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}x=2\\n\"}"),
  )
}

///|
fn render_native_case_556() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${missing}{\\\"x\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_557() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${missing}{\\n        \\\"x\\\" : 2\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_558() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${missing}{x=2}\"}"),
  )
}

///|
fn render_native_case_559() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=${missing}{\\n    x=2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_560() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_561() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing} {x=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_562() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_563() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=${missing} {x=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_564() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[${missing},\\\"text\\\",null,1]\"}",
    ),
  )
}

///|
fn render_native_case_565() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    ${missing},\\n    \\\"text\\\",\\n    null,\\n    1\\n]\"}",
    ),
  )
}

///|
fn render_native_case_566() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[${missing},text,null,1]\"}"),
  )
}

///|
fn render_native_case_567() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    ${missing},\\n    text,\\n    null,\\n    1\\n]\"}",
    ),
  )
}

///|
fn render_native_case_568() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":[${missing},\\\"text\\\",null,1]}\"}",
    ),
  )
}

///|
fn render_native_case_569() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : [\\n        ${missing},\\n        \\\"text\\\",\\n        null,\\n        1\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_570() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=[${missing},text,null,1]\"}"),
  )
}

///|
fn render_native_case_571() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=[\\n    ${missing},\\n    text,\\n    null,\\n    1\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_572() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_573() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_574() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_575() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[${missing},text,null,1.0]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_576() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_577() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_578() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_579() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("{}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_580() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":{}}\"}"),
  )
}

///|
fn render_native_case_581() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_582() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a{}\"}"))
}

///|
fn render_native_case_583() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a {}\\n\"}"))
}

///|
fn render_native_case_584() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":{}}\"}"),
  )
}

///|
fn render_native_case_585() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_586() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a{}\"}"))
}

///|
fn render_native_case_587() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a={}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a {}\\n\"}"))
}

///|
fn render_native_case_588() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"[]\"}"))
}

///|
fn render_native_case_589() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"[]\"}"))
}

///|
fn render_native_case_590() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"[]\"}"))
}

///|
fn render_native_case_591() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("[]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"[]\"}"))
}

///|
fn render_native_case_592() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":[]}\"}"),
  )
}

///|
fn render_native_case_593() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : []\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_594() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=[]\"}"))
}

///|
fn render_native_case_595() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=[]\\n\"}"))
}

///|
fn render_native_case_596() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":[]}\"}"),
  )
}

///|
fn render_native_case_597() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : []\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_598() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=[]\"}"))
}

///|
fn render_native_case_599() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("a=[]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=[]\\n\"}"))
}

///|
fn render_native_case_600() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_601() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_602() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_603() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_604() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_605() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_606() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_607() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_608() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a.b\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a.b\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_609() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a.b\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a.b\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_610() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a.b\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_611() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"a.b\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_612() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"true\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"true\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_613() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"true\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"true\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_614() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"true\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_615() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"true\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_616() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"falseX\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"falseX\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_617() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"falseX\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"falseX\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_618() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"falseX\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"falseX\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_619() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"falseX\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"falseX\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_620() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"include-me\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"include-me\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_621() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"include-me\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"include-me\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_622() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"include-me\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"include-me\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_623() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"include-me\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"include-me\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_624() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"nullThing\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"nullThing\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_625() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"nullThing\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"nullThing\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_626() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"nullThing\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"nullThing\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_627() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"nullThing\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"nullThing\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_628() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"x_y\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"x_y\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_629() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"x_y\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x_y\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_630() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"x_y\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"x_y\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_631() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"x_y\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"x_y\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_632() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"-x\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"-x\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_633() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"-x\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"-x\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_634() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"-x\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-x\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_635() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"-x\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-x\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_636() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"1\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"1\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_637() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"1\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"1\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_638() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"1\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_639() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"1\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_640() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"01\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"01\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_641() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"01\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"01\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_642() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"01\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_643() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"01\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_644() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"١\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"١\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_645() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"١\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"١\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_646() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"١\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_647() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"١\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_648() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"中文\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"中文\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_649() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"中文\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"中文\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_650() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"中文\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"中文{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_651() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"中文\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"中文 {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_652() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"😀\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"😀\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_653() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"😀\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"😀\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_654() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"😀\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"😀\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_655() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"😀\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"😀\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_656() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"x\\ny\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"x\\\\ny\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_657() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"x\\ny\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x\\\\ny\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_658() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"x\\ny\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"x\\\\ny\\\"{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_659() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"x\\ny\"={child=[1,{x=${missing}},[]]}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"x\\\\ny\\\" {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_660() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"Aa\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"Aa\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_661() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"Aa\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"Aa\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_662() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"Aa\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"Aa{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_663() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"Aa\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"Aa {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_664() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"BB\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"BB\\\":{\\\"child\\\":[1,{\\\"x\\\":${missing}},[]]}}\"}",
    ),
  )
}

///|
fn render_native_case_665() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"BB\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"BB\\\" : {\\n        \\\"child\\\" : [\\n            1,\\n            {\\n                \\\"x\\\" : ${missing}\\n            },\\n            []\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_666() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"BB\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"BB{child=[1,{x=${missing}},[]]}\"}",
    ),
  )
}

///|
fn render_native_case_667() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("\"BB\"={child=[1,{x=${missing}},[]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"BB {\\n    child=[\\n        1,\\n        {\\n            x=${missing}\\n        },\\n        []\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_668() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"x\\\":1,\\\"y\\\":2},\\\"z\\\":3}\"}",
    ),
  )
}

///|
fn render_native_case_669() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1,\\n        \\\"y\\\" : 2\\n    },\\n    \\\"z\\\" : 3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_670() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{x=1,y=2},z=3\"}"),
  )
}

///|
fn render_native_case_671() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    x=1\\n    y=2\\n}\\nz=3\\n\"}",
    ),
  )
}

///|
fn render_native_case_672() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"x\\\":1,\\\"y\\\":2}\"}"),
  )
}

///|
fn render_native_case_673() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x\\\" : 1,\\n    \\\"y\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_674() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"x=1,y=2\"}"))
}

///|
fn render_native_case_675() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"x=1\\ny=2\\n\"}"),
  )
}

///|
fn render_native_case_676() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":{\\\"x\\\":1,\\\"y\\\":2},\\\"z\\\":3}}\"}",
    ),
  )
}

///|
fn render_native_case_677() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : {\\n            \\\"x\\\" : 1,\\n            \\\"y\\\" : 2\\n        },\\n        \\\"z\\\" : 3\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_678() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped{a{x=1,y=2},z=3}\"}"),
  )
}

///|
fn render_native_case_679() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    a {\\n        x=1\\n        y=2\\n    }\\n    z=3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_680() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"x\\\":1,\\\"y\\\":2},\\\"z\\\":3}\"}",
    ),
  )
}

///|
fn render_native_case_681() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1,\\n        \\\"y\\\" : 2\\n    },\\n    \\\"z\\\" : 3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_682() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{x=1,y=2},z=3\"}"),
  )
}

///|
fn render_native_case_683() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={x=1,y=2}\nz=3")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    x=1\\n    y=2\\n}\\nz=3\\n\"}",
    ),
  )
}

///|
fn render_native_case_684() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"1\\\":\\\"one\\\",\\\"2\\\":\\\"two\\\",\\\"10\\\":\\\"ten\\\",\\\"Z\\\":\\\"zed\\\",\\\"a\\\":\\\"alpha\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_685() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"1\\\" : \\\"one\\\",\\n    \\\"2\\\" : \\\"two\\\",\\n    \\\"10\\\" : \\\"ten\\\",\\n    \\\"Z\\\" : \\\"zed\\\",\\n    \\\"a\\\" : \\\"alpha\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_686() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\"=one,\\\"2\\\"=two,\\\"10\\\"=ten,Z=zed,a=alpha\"}",
    ),
  )
}

///|
fn render_native_case_687() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\"=one\\n\\\"2\\\"=two\\n\\\"10\\\"=ten\\nZ=zed\\na=alpha\\n\"}",
    ),
  )
}

///|
fn render_native_case_688() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"alpha\\\"\"}"),
  )
}

///|
fn render_native_case_689() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"alpha\\\"\"}"),
  )
}

///|
fn render_native_case_690() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"alpha\"}"))
}

///|
fn render_native_case_691() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"alpha\"}"))
}

///|
fn render_native_case_692() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"1\\\":\\\"one\\\",\\\"2\\\":\\\"two\\\",\\\"10\\\":\\\"ten\\\",\\\"Z\\\":\\\"zed\\\",\\\"a\\\":\\\"alpha\\\"}}\"}",
    ),
  )
}

///|
fn render_native_case_693() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"1\\\" : \\\"one\\\",\\n        \\\"2\\\" : \\\"two\\\",\\n        \\\"10\\\" : \\\"ten\\\",\\n        \\\"Z\\\" : \\\"zed\\\",\\n        \\\"a\\\" : \\\"alpha\\\"\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_694() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"1\\\"=one,\\\"2\\\"=two,\\\"10\\\"=ten,Z=zed,a=alpha}\"}",
    ),
  )
}

///|
fn render_native_case_695() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    \\\"1\\\"=one\\n    \\\"2\\\"=two\\n    \\\"10\\\"=ten\\n    Z=zed\\n    a=alpha\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_696() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"1\\\":\\\"one\\\",\\\"2\\\":\\\"two\\\",\\\"10\\\":\\\"ten\\\",\\\"Z\\\":\\\"zed\\\",\\\"a\\\":\\\"alpha\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_697() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"1\\\" : \\\"one\\\",\\n    \\\"2\\\" : \\\"two\\\",\\n    \\\"10\\\" : \\\"ten\\\",\\n    \\\"Z\\\" : \\\"zed\\\",\\n    \\\"a\\\" : \\\"alpha\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_698() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\"=one,\\\"2\\\"=two,\\\"10\\\"=ten,Z=zed,a=alpha\"}",
    ),
  )
}

///|
fn render_native_case_699() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"10\"=ten\n\"2\"=two\n\"1\"=one\na=alpha\nZ=zed",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1\\\"=one\\n\\\"2\\\"=two\\n\\\"10\\\"=ten\\nZ=zed\\na=alpha\\n\"}",
    ),
  )
}

///|
fn render_native_case_700() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"01\\\":\\\"a\\\",\\\"1\\\":\\\"b\\\",\\\"001\\\":\\\"c\\\",\\\"٠١\\\":\\\"d\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_701() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"01\\\" : \\\"a\\\",\\n    \\\"1\\\" : \\\"b\\\",\\n    \\\"001\\\" : \\\"c\\\",\\n    \\\"٠١\\\" : \\\"d\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_702() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\"=a,\\\"1\\\"=b,\\\"001\\\"=c,\\\"٠١\\\"=d\"}",
    ),
  )
}

///|
fn render_native_case_703() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\"=a\\n\\\"1\\\"=b\\n\\\"001\\\"=c\\n\\\"٠١\\\"=d\\n\"}",
    ),
  )
}

///|
fn render_native_case_704() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_705() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_706() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_707() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_708() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"01\\\":\\\"a\\\",\\\"1\\\":\\\"b\\\",\\\"001\\\":\\\"c\\\",\\\"٠١\\\":\\\"d\\\"}}\"}",
    ),
  )
}

///|
fn render_native_case_709() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"01\\\" : \\\"a\\\",\\n        \\\"1\\\" : \\\"b\\\",\\n        \\\"001\\\" : \\\"c\\\",\\n        \\\"٠١\\\" : \\\"d\\\"\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_710() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"01\\\"=a,\\\"1\\\"=b,\\\"001\\\"=c,\\\"٠١\\\"=d}\"}",
    ),
  )
}

///|
fn render_native_case_711() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    \\\"01\\\"=a\\n    \\\"1\\\"=b\\n    \\\"001\\\"=c\\n    \\\"٠١\\\"=d\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_712() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"01\\\":\\\"a\\\",\\\"1\\\":\\\"b\\\",\\\"001\\\":\\\"c\\\",\\\"٠١\\\":\\\"d\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_713() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"01\\\" : \\\"a\\\",\\n    \\\"1\\\" : \\\"b\\\",\\n    \\\"001\\\" : \\\"c\\\",\\n    \\\"٠١\\\" : \\\"d\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_714() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\"=a,\\\"1\\\"=b,\\\"001\\\"=c,\\\"٠١\\\"=d\"}",
    ),
  )
}

///|
fn render_native_case_715() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"01\"=a\n\"1\"=b\n\"001\"=c\n\"٠١\"=d",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"01\\\"=a\\n\\\"1\\\"=b\\n\\\"001\\\"=c\\n\\\"٠١\\\"=d\\n\"}",
    ),
  )
}

///|
fn render_native_case_716() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"111111111111111111111111111\\\":\\\"b\\\",\\\"999999999999999999999999999\\\":\\\"a\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_717() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"111111111111111111111111111\\\" : \\\"b\\\",\\n    \\\"999999999999999999999999999\\\" : \\\"a\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_718() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"111111111111111111111111111\\\"=b,\\\"999999999999999999999999999\\\"=a\"}",
    ),
  )
}

///|
fn render_native_case_719() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"111111111111111111111111111\\\"=b\\n\\\"999999999999999999999999999\\\"=a\\n\"}",
    ),
  )
}

///|
fn render_native_case_720() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_721() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_722() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_723() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":false}"))
}

///|
fn render_native_case_724() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"111111111111111111111111111\\\":\\\"b\\\",\\\"999999999999999999999999999\\\":\\\"a\\\"}}\"}",
    ),
  )
}

///|
fn render_native_case_725() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"111111111111111111111111111\\\" : \\\"b\\\",\\n        \\\"999999999999999999999999999\\\" : \\\"a\\\"\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_726() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"111111111111111111111111111\\\"=b,\\\"999999999999999999999999999\\\"=a}\"}",
    ),
  )
}

///|
fn render_native_case_727() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    \\\"111111111111111111111111111\\\"=b\\n    \\\"999999999999999999999999999\\\"=a\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_728() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"111111111111111111111111111\\\":\\\"b\\\",\\\"999999999999999999999999999\\\":\\\"a\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_729() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"111111111111111111111111111\\\" : \\\"b\\\",\\n    \\\"999999999999999999999999999\\\" : \\\"a\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_730() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"111111111111111111111111111\\\"=b,\\\"999999999999999999999999999\\\"=a\"}",
    ),
  )
}

///|
fn render_native_case_731() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"999999999999999999999999999\"=a\n\"111111111111111111111111111\"=b",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"111111111111111111111111111\\\"=b\\n\\\"999999999999999999999999999\\\"=a\\n\"}",
    ),
  )
}

///|
fn render_native_case_732() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=1")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_733() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=1")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_734() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=1")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\"}"))
}

///|
fn render_native_case_735() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=1")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\\n\"}"))
}

///|
fn render_native_case_736() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_737() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_738() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_739() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_740() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_741() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_742() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped{a=1}\"}"),
  )
}

///|
fn render_native_case_743() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped {\\n    a=1\\n}\\n\"}"),
  )
}

///|
fn render_native_case_744() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_745() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_746() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\"}"))
}

///|
fn render_native_case_747() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=1")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\\n\"}"))
}

///|
fn render_native_case_748() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1\na=${x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"a\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_749() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1\na=${x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : 1,\\n    \\\"a\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_750() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1\na=${x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a\\\":1,\\\"a\\\":${x}\"}"),
  )
}

///|
fn render_native_case_751() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=1\na=${x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : 1,\\n\\\"a\\\" : ${x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_752() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1,${x}\"}"))
}

///|
fn render_native_case_753() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1,\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_754() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1,${x}\"}"))
}

///|
fn render_native_case_755() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1,\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_756() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":1,\\\"a\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_757() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : 1,\\n        \\\"a\\\" : ${x}\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_758() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":1,\\\"a\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_759() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : 1,\\n    \\\"a\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_760() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"a\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_761() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : 1,\\n    \\\"a\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_762() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"a\\\":1,\\\"a\\\":${x}\"}"),
  )
}

///|
fn render_native_case_763() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : 1,\\n\\\"a\\\" : ${x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_764() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"a\\\":{\\\"b\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_765() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : {\\n        \\\"b\\\" : 2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_766() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${x},\\\"a\\\":{b=2}\"}",
    ),
  )
}

///|
fn render_native_case_767() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${x},\\n\\\"a\\\" : {\\n    b=2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_768() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${x},{\\\"b\\\":2}\"}"),
  )
}

///|
fn render_native_case_769() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${x},\\n{\\n    \\\"b\\\" : 2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_770() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x},b=2\"}"))
}

///|
fn render_native_case_771() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${x},\\nb=2\\n\\n\"}"),
  )
}

///|
fn render_native_case_772() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":${x},\\\"a\\\":{\\\"b\\\":2}}}\"}",
    ),
  )
}

///|
fn render_native_case_773() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : ${x},\\n        \\\"a\\\" : {\\n            \\\"b\\\" : 2\\n        }\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_774() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":${x},\\\"a\\\":{b=2}}\"}",
    ),
  )
}

///|
fn render_native_case_775() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : {\\n        b=2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_776() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"a\\\":{\\\"b\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_777() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : {\\n        \\\"b\\\" : 2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_778() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${x},\\\"a\\\":{b=2}\"}",
    ),
  )
}

///|
fn render_native_case_779() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na={b=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${x},\\n\\\"a\\\" : {\\n    b=2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_780() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"b\\\":${x},\\\"c\\\":3}}\"}",
    ),
  )
}

///|
fn render_native_case_781() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"b\\\" : ${x},\\n        \\\"c\\\" : 3\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_782() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{b=${x},c=3}\"}"),
  )
}

///|
fn render_native_case_783() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    b=${x}\\n    c=3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_784() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"b\\\":${x},\\\"c\\\":3}\"}",
    ),
  )
}

///|
fn render_native_case_785() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"b\\\" : ${x},\\n    \\\"c\\\" : 3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_786() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=${x},c=3\"}"))
}

///|
fn render_native_case_787() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"b=${x}\\nc=3\\n\"}"),
  )
}

///|
fn render_native_case_788() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":{\\\"b\\\":${x},\\\"c\\\":3}}}\"}",
    ),
  )
}

///|
fn render_native_case_789() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : {\\n            \\\"b\\\" : ${x},\\n            \\\"c\\\" : 3\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_790() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped{a{b=${x},c=3}}\"}"),
  )
}

///|
fn render_native_case_791() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    a {\\n        b=${x}\\n        c=3\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_792() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"b\\\":${x},\\\"c\\\":3}}\"}",
    ),
  )
}

///|
fn render_native_case_793() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"b\\\" : ${x},\\n        \\\"c\\\" : 3\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_794() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{b=${x},c=3}\"}"),
  )
}

///|
fn render_native_case_795() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={b=${x}}\na={c=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    b=${x}\\n    c=3\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_796() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{\\\"z\\\":3}}\"}",
    ),
  )
}

///|
fn render_native_case_797() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : ${y},\\n    \\\"a\\\" : {\\n        \\\"z\\\" : 3\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_798() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{z=3}\"}",
    ),
  )
}

///|
fn render_native_case_799() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${x},\\n\\\"a\\\" : ${y},\\n\\\"a\\\" : {\\n    z=3\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_800() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${x},${y},{\\\"z\\\":3}\"}"),
  )
}

///|
fn render_native_case_801() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${x},\\n${y},\\n{\\n    \\\"z\\\" : 3\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_802() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${x},${y},z=3\"}"),
  )
}

///|
fn render_native_case_803() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${x},\\n${y},\\nz=3\\n\\n\"}"),
  )
}

///|
fn render_native_case_804() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{\\\"z\\\":3}}}\"}",
    ),
  )
}

///|
fn render_native_case_805() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : ${x},\\n        \\\"a\\\" : ${y},\\n        \\\"a\\\" : {\\n            \\\"z\\\" : 3\\n        }\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_806() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{z=3}}\"}",
    ),
  )
}

///|
fn render_native_case_807() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : ${y},\\n    \\\"a\\\" : {\\n        z=3\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_808() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{\\\"z\\\":3}}\"}",
    ),
  )
}

///|
fn render_native_case_809() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${x},\\n    \\\"a\\\" : ${y},\\n    \\\"a\\\" : {\\n        \\\"z\\\" : 3\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_810() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${x},\\\"a\\\":${y},\\\"a\\\":{z=3}\"}",
    ),
  )
}

///|
fn render_native_case_811() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${x}\na=${y}\na={z=3}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${x},\\n\\\"a\\\" : ${y},\\n\\\"a\\\" : {\\n    z=3\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_812() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":[1],\\\"a\\\":${?a}[2]}\"}",
    ),
  )
}

///|
fn render_native_case_813() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=2")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : [\\n        1\\n    ],\\n    \\\"a\\\" : ${?a}[\\n        2\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_814() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=2")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":[1],\\\"a\\\":${?a}[2]\"}",
    ),
  )
}

///|
fn render_native_case_815() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=2")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : [\\n    1\\n],\\n\\\"a\\\" : ${?a}[\\n    2\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_816() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1],${?a}[2]\"}"),
  )
}

///|
fn render_native_case_817() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1\\n],\\n${?a}[\\n    2\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_818() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1],${?a}[2]\"}"),
  )
}

///|
fn render_native_case_819() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1\\n],\\n${?a}[\\n    2\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_820() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":[1],\\\"a\\\":${?a}[2]}}\"}",
    ),
  )
}

///|
fn render_native_case_821() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : [\\n            1\\n        ],\\n        \\\"a\\\" : ${?a}[\\n            2\\n        ]\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_822() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":[1],\\\"a\\\":${?a}[2]}\"}",
    ),
  )
}

///|
fn render_native_case_823() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : [\\n        1\\n    ],\\n    \\\"a\\\" : ${?a}[\\n        2\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_824() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":[1,2]}\"}"),
  )
}

///|
fn render_native_case_825() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : [\\n        1,\\n        2\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_826() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=[1,2]\"}"))
}

///|
fn render_native_case_827() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=[\\n    1,\\n    2\\n]\\n\"}"),
  )
}

///|
fn render_native_case_828() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":[1],\\\"a\\\":${?a}[${missing}]}\"}",
    ),
  )
}

///|
fn render_native_case_829() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : [\\n        1\\n    ],\\n    \\\"a\\\" : ${?a}[\\n        ${missing}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_830() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":[1],\\\"a\\\":${?a}[${missing}]\"}",
    ),
  )
}

///|
fn render_native_case_831() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : [\\n    1\\n],\\n\\\"a\\\" : ${?a}[\\n    ${missing}\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_832() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1],${?a}[${missing}]\"}"),
  )
}

///|
fn render_native_case_833() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1\\n],\\n${?a}[\\n    ${missing}\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_834() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"[1],${?a}[${missing}]\"}"),
  )
}

///|
fn render_native_case_835() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"[\\n    1\\n],\\n${?a}[\\n    ${missing}\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_836() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":[1],\\\"a\\\":${?a}[${missing}]}}\"}",
    ),
  )
}

///|
fn render_native_case_837() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : [\\n            1\\n        ],\\n        \\\"a\\\" : ${?a}[\\n            ${missing}\\n        ]\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_838() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":[1],\\\"a\\\":${?a}[${missing}]}\"}",
    ),
  )
}

///|
fn render_native_case_839() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : [\\n        1\\n    ],\\n    \\\"a\\\" : ${?a}[\\n        ${missing}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_840() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":[1],\\\"a\\\":[1,${missing}]}\"}",
    ),
  )
}

///|
fn render_native_case_841() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : [\\n        1\\n    ],\\n    \\\"a\\\" : [\\n        1,\\n        ${missing}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_842() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":[1],\\\"a\\\":[1,${missing}]\"}",
    ),
  )
}

///|
fn render_native_case_843() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=[1]\na+=${missing}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : [\\n    1\\n],\\n\\\"a\\\" : [\\n    1,\\n    ${missing}\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_844() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"v\\\":1},\\\"a\\\":${a}{\\\"x\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_845() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : {\\n        \\\"v\\\" : 1\\n    },\\n    \\\"a\\\" : ${a}{\\n        \\\"x\\\" : 2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_846() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":{v=1},\\\"a\\\":${a}{x=2}\"}",
    ),
  )
}

///|
fn render_native_case_847() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : {\\n    v=1\\n},\\n\\\"a\\\" : ${a}{\\n    x=2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_848() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"v\\\":1},${a}{\\\"x\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_849() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"v\\\" : 1\\n}\\n,\\n${a}{\\n    \\\"x\\\" : 2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_850() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"v=1,${a}x=2\"}"),
  )
}

///|
fn render_native_case_851() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"v=1\\n,\\n${a}x=2\\n\\n\"}"),
  )
}

///|
fn render_native_case_852() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":{\\\"v\\\":1},\\\"a\\\":${a}{\\\"x\\\":2}}}\"}",
    ),
  )
}

///|
fn render_native_case_853() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n                \\\"a\\\" : {\\n            \\\"v\\\" : 1\\n        },\\n        \\\"a\\\" : ${a}{\\n            \\\"x\\\" : 2\\n        }\\n\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_854() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"a\\\":{v=1},\\\"a\\\":${a}{x=2}}\"}",
    ),
  )
}

///|
fn render_native_case_855() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n        \\\"a\\\" : {\\n        v=1\\n    },\\n    \\\"a\\\" : ${a}{\\n        x=2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_856() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"v\\\":1,\\\"x\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_857() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"v\\\" : 1,\\n        \\\"x\\\" : 2\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_858() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a{v=1,x=2}\"}"))
}

///|
fn render_native_case_859() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={v=1}\na=${a}{x=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    v=1\\n    x=2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_860() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${?missing},\\\"b\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_861() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${?missing},\\n    \\\"b\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_862() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?missing},b=2\"}"),
  )
}

///|
fn render_native_case_863() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${?missing}\\nb=2\\n\"}"),
  )
}

///|
fn render_native_case_864() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_865() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_866() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_867() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${?missing}\"}"),
  )
}

///|
fn render_native_case_868() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":${?missing},\\\"b\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_869() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : ${?missing},\\n        \\\"b\\\" : 2\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_870() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped{a=${?missing},b=2}\"}"),
  )
}

///|
fn render_native_case_871() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    a=${?missing}\\n    b=2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_872() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"b\\\":2}\"}"),
  )
}

///|
fn render_native_case_873() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"b\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_874() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=2\"}"))
}

///|
fn render_native_case_875() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${?missing}\nb=2")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=2\\n\"}"))
}

///|
fn render_native_case_876() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("# top\na=1 # inline\n# next\nb=[2,3]")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"b\\\":[2,3]}\"}",
    ),
  )
}

///|
fn render_native_case_877() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("# top\na=1 # inline\n# next\nb=[2,3]")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1,\\n    \\\"b\\\" : [\\n        2,\\n        3\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_878() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("# top\na=1 # inline\n# next\nb=[2,3]")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1,b=[2,3]\"}"),
  )
}

///|
fn render_native_case_879() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("# top\na=1 # inline\n# next\nb=[2,3]")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=1\\nb=[\\n    2,\\n    3\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_880() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_881() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_882() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_883() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_884() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":1,\\\"b\\\":[2,3]}}\"}",
    ),
  )
}

///|
fn render_native_case_885() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : 1,\\n        \\\"b\\\" : [\\n            2,\\n            3\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_886() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"wrapped{a=1,b=[2,3]}\"}"),
  )
}

///|
fn render_native_case_887() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    a=1\\n    b=[\\n        2,\\n        3\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_888() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"b\\\":[2,3]}\"}",
    ),
  )
}

///|
fn render_native_case_889() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1,\\n    \\\"b\\\" : [\\n        2,\\n        3\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_890() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1,b=[2,3]\"}"),
  )
}

///|
fn render_native_case_891() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "# top\na=1 # inline\n# next\nb=[2,3]",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=1\\nb=[\\n    2,\\n    3\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_892() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"b\\\":2},${x}\"}"),
  )
}

///|
fn render_native_case_893() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"b\\\" : 2\\n}\\n,\\n${x}\\n\"}",
    ),
  )
}

///|
fn render_native_case_894() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=2,${x}\"}"))
}

///|
fn render_native_case_895() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"b=2\\n,\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_896() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"b\\\":2},\\\"merged\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_897() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : {\\n        \\\"b\\\" : 2\\n    },\\n    \\\"merged\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_898() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":{b=2},\\\"merged\\\":${x}\"}",
    ),
  )
}

///|
fn render_native_case_899() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : {\\n    b=2\\n},\\n\\\"merged\\\" : ${x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_900() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,${x}\"}"))
}

///|
fn render_native_case_901() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_902() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,${x}\"}"))
}

///|
fn render_native_case_903() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_904() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":0,\\\"merged\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_905() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : 0,\\n    \\\"merged\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_906() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":0,\\\"merged\\\":${x}\"}",
    ),
  )
}

///|
fn render_native_case_907() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : 0,\\n\\\"merged\\\" : ${x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_908() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${y},${x}\"}"))
}

///|
fn render_native_case_909() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_910() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${y},${x}\"}"))
}

///|
fn render_native_case_911() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n${x}\\n\"}"),
  )
}

///|
fn render_native_case_912() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":${y},\\\"merged\\\":${x}}\"}",
    ),
  )
}

///|
fn render_native_case_913() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : ${y},\\n    \\\"merged\\\" : ${x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_914() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":${y},\\\"merged\\\":${x}\"}",
    ),
  )
}

///|
fn render_native_case_915() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : ${y},\\n\\\"merged\\\" : ${x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_916() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"b\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_917() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"b\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_918() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=${x},b=2\"}"))
}

///|
fn render_native_case_919() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x}\\nb=2\\n\"}"),
  )
}

///|
fn render_native_case_920() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"a\\\":${x},\\\"b\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_921() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : ${x},\\n        \\\"b\\\" : 2\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_922() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged{a=${x},b=2}\"}"),
  )
}

///|
fn render_native_case_923() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"merged {\\n    a=${x}\\n    b=2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_924() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,{\\\"a\\\":${x}}\"}"),
  )
}

///|
fn render_native_case_925() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"0,\\n{\\n    \\\"a\\\" : ${x}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_926() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,a=${x}\"}"))
}

///|
fn render_native_case_927() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\na=${x}\\n\\n\"}"),
  )
}

///|
fn render_native_case_928() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":0,\\\"merged\\\":{\\\"a\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_929() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : 0,\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : ${x}\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_930() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":0,\\\"merged\\\":{a=${x}}\"}",
    ),
  )
}

///|
fn render_native_case_931() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : 0,\\n\\\"merged\\\" : {\\n    a=${x}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_932() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},{\\\"a\\\":${x}}\"}"),
  )
}

///|
fn render_native_case_933() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${y},\\n{\\n    \\\"a\\\" : ${x}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_934() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},a=${x}\"}"),
  )
}

///|
fn render_native_case_935() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\na=${x}\\n\\n\"}"),
  )
}

///|
fn render_native_case_936() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":${y},\\\"merged\\\":{\\\"a\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_937() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : ${y},\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : ${x}\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_938() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":${y},\\\"merged\\\":{a=${x}}\"}",
    ),
  )
}

///|
fn render_native_case_939() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=${x}}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : ${y},\\n\\\"merged\\\" : {\\n    a=${x}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_940() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"b\\\":2},[${x}]\"}"),
  )
}

///|
fn render_native_case_941() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"b\\\" : 2\\n}\\n,\\n[\\n    ${x}\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_942() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=2,[${x}]\"}"))
}

///|
fn render_native_case_943() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"b=2\\n,\\n[\\n    ${x}\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_944() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"b\\\":2},\\\"merged\\\":[${x}]}\"}",
    ),
  )
}

///|
fn render_native_case_945() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : {\\n        \\\"b\\\" : 2\\n    },\\n    \\\"merged\\\" : [\\n        ${x}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_946() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":{b=2},\\\"merged\\\":[${x}]\"}",
    ),
  )
}

///|
fn render_native_case_947() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : {\\n    b=2\\n},\\n\\\"merged\\\" : [\\n    ${x}\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_948() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,[${x}]\"}"))
}

///|
fn render_native_case_949() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n[\\n    ${x}\\n]\\n\"}"),
  )
}

///|
fn render_native_case_950() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,[${x}]\"}"))
}

///|
fn render_native_case_951() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n[\\n    ${x}\\n]\\n\"}"),
  )
}

///|
fn render_native_case_952() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":0,\\\"merged\\\":[${x}]}\"}",
    ),
  )
}

///|
fn render_native_case_953() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : 0,\\n    \\\"merged\\\" : [\\n        ${x}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_954() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":0,\\\"merged\\\":[${x}]\"}",
    ),
  )
}

///|
fn render_native_case_955() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : 0,\\n\\\"merged\\\" : [\\n    ${x}\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_956() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},[${x}]\"}"),
  )
}

///|
fn render_native_case_957() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n[\\n    ${x}\\n]\\n\"}"),
  )
}

///|
fn render_native_case_958() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},[${x}]\"}"),
  )
}

///|
fn render_native_case_959() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n[\\n    ${x}\\n]\\n\"}"),
  )
}

///|
fn render_native_case_960() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":${y},\\\"merged\\\":[${x}]}\"}",
    ),
  )
}

///|
fn render_native_case_961() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : ${y},\\n    \\\"merged\\\" : [\\n        ${x}\\n    ]\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_962() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":${y},\\\"merged\\\":[${x}]\"}",
    ),
  )
}

///|
fn render_native_case_963() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[${x}]")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : ${y},\\n\\\"merged\\\" : [\\n    ${x}\\n]\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_964() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"b\\\":2}\"}"),
  )
}

///|
fn render_native_case_965() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1,\\n    \\\"b\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_966() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1,b=2\"}"))
}

///|
fn render_native_case_967() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1\\nb=2\\n\"}"),
  )
}

///|
fn render_native_case_968() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"a\\\":1,\\\"b\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_969() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : 1,\\n        \\\"b\\\" : 2\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_970() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged{a=1,b=2}\"}"),
  )
}

///|
fn render_native_case_971() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"merged {\\n    a=1\\n    b=2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_972() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_973() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_974() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\"}"))
}

///|
fn render_native_case_975() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1\\n\"}"))
}

///|
fn render_native_case_976() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"a\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_977() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_978() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged{a=1}\"}"),
  )
}

///|
fn render_native_case_979() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged {\\n    a=1\\n}\\n\"}"),
  )
}

///|
fn render_native_case_980() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},{\\\"a\\\":1}\"}"),
  )
}

///|
fn render_native_case_981() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${y},\\n{\\n    \\\"a\\\" : 1\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_982() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${y},a=1\"}"))
}

///|
fn render_native_case_983() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\na=1\\n\\n\"}"),
  )
}

///|
fn render_native_case_984() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":${y},\\\"merged\\\":{\\\"a\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_985() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : ${y},\\n    \\\"merged\\\" : {\\n        \\\"a\\\" : 1\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_986() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":${y},\\\"merged\\\":{a=1}\"}",
    ),
  )
}

///|
fn render_native_case_987() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : ${y},\\n\\\"merged\\\" : {\\n    a=1\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_988() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_989() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_990() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_991() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_992() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"merged\\\":1}\"}"),
  )
}

///|
fn render_native_case_993() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_994() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"merged=1\"}"))
}

///|
fn render_native_case_995() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged=1\\n\"}"),
  )
}

///|
fn render_native_case_996() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_997() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_998() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_999() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1000() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"merged\\\":1}\"}"),
  )
}

///|
fn render_native_case_1001() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1002() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"merged=1\"}"))
}

///|
fn render_native_case_1003() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged=1\\n\"}"),
  )
}

///|
fn render_native_case_1004() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1005() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1006() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1007() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1008() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"merged\\\":1}\"}"),
  )
}

///|
fn render_native_case_1009() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"merged\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1010() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"merged=1\"}"))
}

///|
fn render_native_case_1011() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("1")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"merged=1\\n\"}"),
  )
}

///|
fn render_native_case_1012() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"b\\\":2},${?x}\"}"),
  )
}

///|
fn render_native_case_1013() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"b\\\" : 2\\n}\\n,\\n${?x}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1014() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"b=2,${?x}\"}"))
}

///|
fn render_native_case_1015() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"b=2\\n,\\n${?x}\\n\"}"),
  )
}

///|
fn render_native_case_1016() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":{\\\"b\\\":2},\\\"merged\\\":${?x}}\"}",
    ),
  )
}

///|
fn render_native_case_1017() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : {\\n        \\\"b\\\" : 2\\n    },\\n    \\\"merged\\\" : ${?x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1018() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":{b=2},\\\"merged\\\":${?x}\"}",
    ),
  )
}

///|
fn render_native_case_1019() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("{b=2}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : {\\n    b=2\\n},\\n\\\"merged\\\" : ${?x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1020() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,${?x}\"}"))
}

///|
fn render_native_case_1021() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n${?x}\\n\"}"),
  )
}

///|
fn render_native_case_1022() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0,${?x}\"}"))
}

///|
fn render_native_case_1023() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0,\\n${?x}\\n\"}"),
  )
}

///|
fn render_native_case_1024() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":0,\\\"merged\\\":${?x}}\"}",
    ),
  )
}

///|
fn render_native_case_1025() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : 0,\\n    \\\"merged\\\" : ${?x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1026() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":0,\\\"merged\\\":${?x}\"}",
    ),
  )
}

///|
fn render_native_case_1027() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("0"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : 0,\\n\\\"merged\\\" : ${?x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1028() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${y},${?x}\"}"))
}

///|
fn render_native_case_1029() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n${?x}\\n\"}"),
  )
}

///|
fn render_native_case_1030() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${y},${?x}\"}"))
}

///|
fn render_native_case_1031() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${y},\\n${?x}\\n\"}"),
  )
}

///|
fn render_native_case_1032() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"merged\\\":${y},\\\"merged\\\":${?x}}\"}",
    ),
  )
}

///|
fn render_native_case_1033() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"merged\\\" : ${y},\\n    \\\"merged\\\" : ${?x}\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1034() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\":${y},\\\"merged\\\":${?x}\"}",
    ),
  )
}

///|
fn render_native_case_1035() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("${?x}")
    value = @hocon.value_with_fallback(value, value_native_create("${y}"))
    value = @hocon.at_key(value, "merged")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"merged\\\" : ${y},\\n\\\"merged\\\" : ${?x}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1036() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.inner\\\":{\\\"a\\\":1,\\\"b\\\":${missing}}}\"}",
    ),
  )
}

///|
fn render_native_case_1037() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.inner\\\" : {\\n        \\\"a\\\" : 1,\\n        \\\"b\\\" : ${missing}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1038() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"{a=1,b=${missing}}\"}",
    ),
  )
}

///|
fn render_native_case_1039() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\" {\\n    a=1\\n    b=${missing}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1040() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":{\\\"a\\\":1,\\\"b\\\":${missing}}}}\"}",
    ),
  )
}

///|
fn render_native_case_1041() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : {\\n            \\\"a\\\" : 1,\\n            \\\"b\\\" : ${missing}\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1042() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{inner{a=1,b=${missing}}}\"}",
    ),
  )
}

///|
fn render_native_case_1043() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{a=1,b=${missing}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner {\\n        a=1\\n        b=${missing}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1044() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.inner\\\":[null,${missing},{\\\"a\\\":1}]}\"}",
    ),
  )
}

///|
fn render_native_case_1045() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.inner\\\" : [\\n        null,\\n        ${missing},\\n        {\\n            \\\"a\\\" : 1\\n        }\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1046() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"=[null,${missing},{a=1}]\"}",
    ),
  )
}

///|
fn render_native_case_1047() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"=[\\n    null,\\n    ${missing},\\n    {\\n        a=1\\n    }\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_1048() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":[null,${missing},{\\\"a\\\":1}]}}\"}",
    ),
  )
}

///|
fn render_native_case_1049() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : [\\n            null,\\n            ${missing},\\n            {\\n                \\\"a\\\" : 1\\n            }\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1050() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{inner=[null,${missing},{a=1}]}\"}",
    ),
  )
}

///|
fn render_native_case_1051() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("[null,${missing},{a=1}]")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner=[\\n        null,\\n        ${missing},\\n        {\\n            a=1\\n        }\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1052() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.inner\\\":\\\"text\\\"}\"}",
    ),
  )
}

///|
fn render_native_case_1053() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.inner\\\" : \\\"text\\\"\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1054() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"=text\"}"),
  )
}

///|
fn render_native_case_1055() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"=text\\n\"}"),
  )
}

///|
fn render_native_case_1056() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":\\\"text\\\"}}\"}",
    ),
  )
}

///|
fn render_native_case_1057() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : \\\"text\\\"\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1058() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"outer{inner=text}\"}"),
  )
}

///|
fn render_native_case_1059() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("\"text\"")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner=text\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1060() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.inner\\\":{\\\"nested\\\":{\\\"a\\\":1}}}\"}",
    ),
  )
}

///|
fn render_native_case_1061() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.inner\\\" : {\\n        \\\"nested\\\" : {\\n            \\\"a\\\" : 1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1062() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\"{nested{a=1}}\"}",
    ),
  )
}

///|
fn render_native_case_1063() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_key(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.inner\\\" {\\n    nested {\\n        a=1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1064() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":{\\\"nested\\\":{\\\"a\\\":1}}}}\"}",
    ),
  )
}

///|
fn render_native_case_1065() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : {\\n            \\\"nested\\\" : {\\n                \\\"a\\\" : 1\\n            }\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1066() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"outer{inner{nested{a=1}}}\"}"),
  )
}

///|
fn render_native_case_1067() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = value_native_create("{nested={a=1}}")
    value = @hocon.at_path(value, "outer.inner")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner {\\n        nested {\\n            a=1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1068() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1069() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1070() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1071() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1072() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1.0\\\"\"}"),
  )
}

///|
fn render_native_case_1073() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1.0\\\"\"}"),
  )
}

///|
fn render_native_case_1074() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1.0\\\"\"}"),
  )
}

///|
fn render_native_case_1075() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1.0\\\"\"}"),
  )
}

///|
fn render_native_case_1076() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1077() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1078() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1079() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1080() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e3 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1081() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e3 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1082() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e3 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1083() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e3 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1084() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e3\\\"\"}"),
  )
}

///|
fn render_native_case_1085() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e3")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e3\\\"\"}"),
  )
}

///|
fn render_native_case_1086() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e3")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e3\\\"\"}"),
  )
}

///|
fn render_native_case_1087() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e3")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e3\\\"\"}"),
  )
}

///|
fn render_native_case_1088() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e3 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1089() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e3 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1090() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e3 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1091() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e3 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e3 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1092() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e30 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1093() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e30 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1094() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e30 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1095() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"1e30 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1096() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e30\\\"\"}"),
  )
}

///|
fn render_native_case_1097() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e30")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e30\\\"\"}"),
  )
}

///|
fn render_native_case_1098() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e30")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e30\\\"\"}"),
  )
}

///|
fn render_native_case_1099() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 1e30")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 1e30\\\"\"}"),
  )
}

///|
fn render_native_case_1100() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e30 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1101() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e30 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1102() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e30 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1103() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e30 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"1e30 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1104() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"-0.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1105() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"-0.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1106() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"-0.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1107() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"-0.0 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1108() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} -0.0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" -0.0\\\"\"}"),
  )
}

///|
fn render_native_case_1109() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} -0.0")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" -0.0\\\"\"}"),
  )
}

///|
fn render_native_case_1110() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} -0.0")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" -0.0\\\"\"}"),
  )
}

///|
fn render_native_case_1111() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} -0.0")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" -0.0\\\"\"}"),
  )
}

///|
fn render_native_case_1112() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-0.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1113() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-0.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1114() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-0.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1115() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-0.0 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"-0.0 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1116() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"0.0001 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1117() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"0.0001 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1118() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"0.0001 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1119() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"0.0001 \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1120() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 0.0001")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 0.0001\\\"\"}"),
  )
}

///|
fn render_native_case_1121() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 0.0001")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 0.0001\\\"\"}"),
  )
}

///|
fn render_native_case_1122() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 0.0001")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 0.0001\\\"\"}"),
  )
}

///|
fn render_native_case_1123() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} 0.0001")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" 0.0001\\\"\"}"),
  )
}

///|
fn render_native_case_1124() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"0.0001 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1125() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"0.0001 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1126() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"0.0001 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1127() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("0.0001 suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"0.0001 suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1128() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"true \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1129() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"true \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1130() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"true \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1131() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"true \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1132() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} true")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" true\\\"\"}"),
  )
}

///|
fn render_native_case_1133() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} true")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" true\\\"\"}"),
  )
}

///|
fn render_native_case_1134() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} true")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" true\\\"\"}"),
  )
}

///|
fn render_native_case_1135() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} true")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" true\\\"\"}"),
  )
}

///|
fn render_native_case_1136() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1137() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1138() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1139() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("true suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"true suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1140() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"null \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1141() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"null \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1142() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"null \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1143() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"null \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1144() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} null")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" null\\\"\"}"),
  )
}

///|
fn render_native_case_1145() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} null")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" null\\\"\"}"),
  )
}

///|
fn render_native_case_1146() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} null")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" null\\\"\"}"),
  )
}

///|
fn render_native_case_1147() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} null")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" null\\\"\"}"),
  )
}

///|
fn render_native_case_1148() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"null suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1149() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"null suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1150() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"null suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1151() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("null suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"null suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1152() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1153() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1154() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1155() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"hello \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1156() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} \"hello\"")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" hello\\\"\"}"),
  )
}

///|
fn render_native_case_1157() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} \"hello\"")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" hello\\\"\"}"),
  )
}

///|
fn render_native_case_1158() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} \"hello\"")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" hello\\\"\"}"),
  )
}

///|
fn render_native_case_1159() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} \"hello\"")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" hello\\\"\"}"),
  )
}

///|
fn render_native_case_1160() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1161() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1162() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1163() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("\"hello\" suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"hello suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1164() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"plain \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1165() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"plain \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1166() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"plain \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1167() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"\\\"plain \\\"${missing}\"}"),
  )
}

///|
fn render_native_case_1168() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} plain")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" plain\\\"\"}"),
  )
}

///|
fn render_native_case_1169() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} plain")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" plain\\\"\"}"),
  )
}

///|
fn render_native_case_1170() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} plain")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" plain\\\"\"}"),
  )
}

///|
fn render_native_case_1171() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("${missing} plain")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing}\\\" plain\\\"\"}"),
  )
}

///|
fn render_native_case_1172() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"plain suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1173() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain suffix ${missing}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"plain suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1174() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"plain suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1175() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("plain suffix ${missing}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"plain suffix \\\"${missing}\"}",
    ),
  )
}

///|
fn render_native_case_1176() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1\na=${x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"x\\\":1}\"}",
    ),
  )
}

///|
fn render_native_case_1177() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1\na=${x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1178() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1\na=${x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=${x},x=1\"}"))
}

///|
fn render_native_case_1179() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1\na=${x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x}\\nx=1\\n\"}"),
  )
}

///|
fn render_native_case_1180() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1181() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1182() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1183() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1184() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"added\\\":{\\\"v\\\":${x}},\\\"x\\\":1}\"}",
    ),
  )
}

///|
fn render_native_case_1185() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"added\\\" : {\\n        \\\"v\\\" : ${x}\\n    },\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1186() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x},added{v=${x}},x=1\"}"),
  )
}

///|
fn render_native_case_1187() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=${x}\\nadded {\\n    v=${x}\\n}\\nx=1\\n\"}",
    ),
  )
}

///|
fn render_native_case_1188() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"x\\\":1}\"}"),
  )
}

///|
fn render_native_case_1189() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1190() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"x=1\"}"))
}

///|
fn render_native_case_1191() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"x=1\\n\"}"))
}

///|
fn render_native_case_1192() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"x\\\":1}\"}"),
  )
}

///|
fn render_native_case_1193() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1,\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1194() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"a=1,x=1\"}"))
}

///|
fn render_native_case_1195() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1\\nx=1\\n\"}"),
  )
}

///|
fn render_native_case_1196() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1.50\na=${x}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"x\\\":1.5}\"}",
    ),
  )
}

///|
fn render_native_case_1197() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1.50\na=${x}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"x\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1198() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1.50\na=${x}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x},x=1.5\"}"),
  )
}

///|
fn render_native_case_1199() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("x=1.50\na=${x}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x}\\nx=1.5\\n\"}"),
  )
}

///|
fn render_native_case_1200() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1201() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1202() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1203() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"${x}\"}"))
}

///|
fn render_native_case_1204() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"added\\\":{\\\"v\\\":${x}},\\\"x\\\":1.5}\"}",
    ),
  )
}

///|
fn render_native_case_1205() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"added\\\" : {\\n        \\\"v\\\" : ${x}\\n    },\\n    \\\"x\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1206() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=${x},added{v=${x}},x=1.5\"}"),
  )
}

///|
fn render_native_case_1207() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=${x}\\nadded {\\n    v=${x}\\n}\\nx=1.5\\n\"}",
    ),
  )
}

///|
fn render_native_case_1208() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"{\\\"x\\\":1.5}\"}"),
  )
}

///|
fn render_native_case_1209() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"x\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1210() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"x=1.5\"}"))
}

///|
fn render_native_case_1211() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"x=1.5\\n\"}"))
}

///|
fn render_native_case_1212() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1.5,\\\"x\\\":1.5}\"}",
    ),
  )
}

///|
fn render_native_case_1213() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1.5,\\n    \\\"x\\\" : 1.5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1214() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.5,x=1.5\"}"),
  )
}

///|
fn render_native_case_1215() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("x=1.50\na=${x}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a=1.5\\nx=1.5\\n\"}"),
  )
}

///|
fn render_native_case_1216() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"nested\\\":{\\\"list\\\":[1,2]}}}\"}",
    ),
  )
}

///|
fn render_native_case_1217() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"nested\\\" : {\\n            \\\"list\\\" : [\\n                1,\\n                2\\n            ]\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1218() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{nested{list=[1,2]}}\"}"),
  )
}

///|
fn render_native_case_1219() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    nested {\\n        list=[\\n            1,\\n            2\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1220() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"nested\\\":{\\\"list\\\":[1,2]}}\"}",
    ),
  )
}

///|
fn render_native_case_1221() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"nested\\\" : {\\n        \\\"list\\\" : [\\n            1,\\n            2\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1222() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"nested{list=[1,2]}\"}"),
  )
}

///|
fn render_native_case_1223() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"nested {\\n    list=[\\n        1,\\n        2\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1224() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"nested\\\":{\\\"list\\\":[1,2]}},\\\"added\\\":{\\\"v\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_1225() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"nested\\\" : {\\n            \\\"list\\\" : [\\n                1,\\n                2\\n            ]\\n        }\\n    },\\n    \\\"added\\\" : {\\n        \\\"v\\\" : ${x}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1226() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a{nested{list=[1,2]}},added{v=${x}}\"}",
    ),
  )
}

///|
fn render_native_case_1227() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    nested {\\n        list=[\\n            1,\\n            2\\n        ]\\n    }\\n}\\nadded {\\n    v=${x}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1228() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1229() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1230() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1231() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1232() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"nested\\\":{\\\"list\\\":[1,2]}}}\"}",
    ),
  )
}

///|
fn render_native_case_1233() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"nested\\\" : {\\n            \\\"list\\\" : [\\n                1,\\n                2\\n            ]\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1234() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{nested{list=[1,2]}}\"}"),
  )
}

///|
fn render_native_case_1235() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a={nested={list=[1,2]}}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    nested {\\n        list=[\\n            1,\\n            2\\n        ]\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1236() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${missing},\\\"a\\\":{\\\"x\\\":1},\\\"a\\\":{\\\"y\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_1237() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${missing},\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1\\n    },\\n    \\\"a\\\" : {\\n        \\\"y\\\" : 2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1238() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${missing},\\\"a\\\":{x=1},\\\"a\\\":{y=2}\"}",
    ),
  )
}

///|
fn render_native_case_1239() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${missing},\\n\\\"a\\\" : {\\n    x=1\\n},\\n\\\"a\\\" : {\\n    y=2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1240() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${missing},{\\\"x\\\":1},{\\\"y\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_1241() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${missing},\\n{\\n    \\\"x\\\" : 1\\n}\\n,\\n{\\n    \\\"y\\\" : 2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1242() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"${missing},x=1,y=2\"}"),
  )
}

///|
fn render_native_case_1243() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${missing},\\nx=1\\n,\\ny=2\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1244() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${missing},\\\"a\\\":{\\\"x\\\":1},\\\"a\\\":{\\\"y\\\":2},\\\"added\\\":{\\\"v\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_1245() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${missing},\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1\\n    },\\n    \\\"a\\\" : {\\n        \\\"y\\\" : 2\\n    }\\n,\\n    \\\"added\\\" : {\\n        \\\"v\\\" : ${x}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1246() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${missing},\\\"a\\\":{x=1},\\\"a\\\":{y=2},added{v=${x}}\"}",
    ),
  )
}

///|
fn render_native_case_1247() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${missing},\\n\\\"a\\\" : {\\n    x=1\\n},\\n\\\"a\\\" : {\\n    y=2\\n}\\n\\nadded {\\n    v=${x}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1248() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1249() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1250() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1251() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1252() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${missing},\\\"a\\\":{\\\"x\\\":1,\\\"y\\\":2}}\"}",
    ),
  )
}

///|
fn render_native_case_1253() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${missing},\\n    \\\"a\\\" : {\\n        \\\"x\\\" : 1,\\n        \\\"y\\\" : 2\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1254() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${missing},\\\"a\\\":{x=1,y=2}\"}",
    ),
  )
}

///|
fn render_native_case_1255() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved("a=${missing}\na={x=1}\na={y=2}")
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${missing},\\n\\\"a\\\" : {\\n    x=1\\n    y=2\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1256() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${?missing},\\\"a\\\":${?other},\\\"a\\\":{\\\"x\\\":${optional}}}\"}",
    ),
  )
}

///|
fn render_native_case_1257() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${?missing},\\n    \\\"a\\\" : ${?other},\\n    \\\"a\\\" : {\\n        \\\"x\\\" : ${optional}\\n    }\\n\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1258() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${?missing},\\\"a\\\":${?other},\\\"a\\\":{x=${optional}}\"}",
    ),
  )
}

///|
fn render_native_case_1259() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${?missing},\\n\\\"a\\\" : ${?other},\\n\\\"a\\\" : {\\n    x=${optional}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1260() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${?missing},${?other},{\\\"x\\\":${optional}}\"}",
    ),
  )
}

///|
fn render_native_case_1261() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${?missing},\\n${?other},\\n{\\n    \\\"x\\\" : ${optional}\\n}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1262() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${?missing},${?other},x=${optional}\"}",
    ),
  )
}

///|
fn render_native_case_1263() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = match @hocon.object_get(value, "a") {
      Some(child) => child
      None => raise Failure("missing render key")
    }
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"${?missing},\\n${?other},\\nx=${optional}\\n\\n\"}",
    ),
  )
}

///|
fn render_native_case_1264() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${?missing},\\\"a\\\":${?other},\\\"a\\\":{\\\"x\\\":${optional}},\\\"added\\\":{\\\"v\\\":${x}}}\"}",
    ),
  )
}

///|
fn render_native_case_1265() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n        \\\"a\\\" : ${?missing},\\n    \\\"a\\\" : ${?other},\\n    \\\"a\\\" : {\\n        \\\"x\\\" : ${optional}\\n    }\\n,\\n    \\\"added\\\" : {\\n        \\\"v\\\" : ${x}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1266() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\":${?missing},\\\"a\\\":${?other},\\\"a\\\":{x=${optional}},added{v=${x}}\"}",
    ),
  )
}

///|
fn render_native_case_1267() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.with_key_value(
      value,
      "added",
      value_native_create("{v=${x}}"),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a\\\" : ${?missing},\\n\\\"a\\\" : ${?other},\\n\\\"a\\\" : {\\n    x=${optional}\\n}\\n\\nadded {\\n    v=${x}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1268() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1269() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1270() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\"}"))
}

///|
fn render_native_case_1271() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.without_key(value, "a")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"{}\\n\"}"))
}

///|
fn render_native_case_1272() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":{\\\"x\\\":${optional}}}\"}",
    ),
  )
}

///|
fn render_native_case_1273() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : {\\n        \\\"x\\\" : ${optional}\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1274() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"a{x=${optional}}\"}"),
  )
}

///|
fn render_native_case_1275() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "a=${?missing}\na=${?other}\na={x=${optional}}",
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a {\\n    x=${optional}\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_1276() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.838639451725799e-92")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.838639451725799E-92\"}"),
  )
}

///|
fn render_native_case_1277() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.084938291167941e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.084938291167941E48\"}"),
  )
}

///|
fn render_native_case_1278() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7257423766123035e-279")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7257423766123035E-279\"}"),
  )
}

///|
fn render_native_case_1279() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.6778909169587644e+164")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.6778909169587644E164\"}"),
  )
}

///|
fn render_native_case_1280() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.832911260854019e+29")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.832911260854019E29\"}"),
  )
}

///|
fn render_native_case_1281() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.404283677272497e-288")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.404283677272497E-288\"}"),
  )
}

///|
fn render_native_case_1282() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.393859848927963e+266")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.393859848927963E266\"}"),
  )
}

///|
fn render_native_case_1283() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.611040628554583e+117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.611040628554583E117\"}"),
  )
}

///|
fn render_native_case_1284() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.549197886606312e-250")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.549197886606312E-250\"}"),
  )
}

///|
fn render_native_case_1285() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3560094091984846e-241")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3560094091984846E-241\"}"),
  )
}

///|
fn render_native_case_1286() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.8976830634895363e+173")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.8976830634895363E173\"}"),
  )
}

///|
fn render_native_case_1287() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.727729718970044e-37")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.727729718970044E-37\"}"),
  )
}

///|
fn render_native_case_1288() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.84046789284113e+260")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.84046789284113E260\"}"),
  )
}

///|
fn render_native_case_1289() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.074274142550697e-35")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.074274142550697E-35\"}"),
  )
}

///|
fn render_native_case_1290() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.8474773167913083e+304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.8474773167913083E304\"}"),
  )
}

///|
fn render_native_case_1291() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.85473395791945e-16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.85473395791945E-16\"}"),
  )
}

///|
fn render_native_case_1292() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.5110431046370852e-216")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.5110431046370852E-216\"}"),
  )
}

///|
fn render_native_case_1293() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8136979596815955e+132")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8136979596815955E132\"}"),
  )
}

///|
fn render_native_case_1294() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.9624189847497747e+5")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"196241.89847497747\"}"),
  )
}

///|
fn render_native_case_1295() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.2664852351984844e+219")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.2664852351984844E219\"}"),
  )
}

///|
fn render_native_case_1296() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8897079234047594e-57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8897079234047594E-57\"}"),
  )
}

///|
fn render_native_case_1297() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.6869706031560697e-122")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.6869706031560697E-122\"}"),
  )
}

///|
fn render_native_case_1298() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.557529638364818e-256")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.557529638364818E-256\"}"),
  )
}

///|
fn render_native_case_1299() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.2319881056703685e-301")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.2319881056703685E-301\"}"),
  )
}

///|
fn render_native_case_1300() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.0800133924936872e+81")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.0800133924936872E81\"}"),
  )
}

///|
fn render_native_case_1301() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.678335062300151e+219")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.678335062300151E219\"}"),
  )
}

///|
fn render_native_case_1302() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.05594838659739e+270")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.05594838659739E270\"}"),
  )
}

///|
fn render_native_case_1303() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.40491750692601e+28")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.40491750692601E28\"}"),
  )
}

///|
fn render_native_case_1304() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.121236397969704e+47")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.121236397969704E47\"}"),
  )
}

///|
fn render_native_case_1305() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.872186791538027e+275")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.872186791538027E275\"}"),
  )
}

///|
fn render_native_case_1306() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.174892873459945e-74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.174892873459945E-74\"}"),
  )
}

///|
fn render_native_case_1307() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.809017782312399e-32")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.809017782312399E-32\"}"),
  )
}

///|
fn render_native_case_1308() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.695158453050163e-244")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.695158453050163E-244\"}"),
  )
}

///|
fn render_native_case_1309() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.588106010271807e+78")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.588106010271807E78\"}"),
  )
}

///|
fn render_native_case_1310() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.2761370805218615e+89")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.2761370805218615E89\"}"),
  )
}

///|
fn render_native_case_1311() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.412576076230184e-263")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.412576076230184E-263\"}"),
  )
}

///|
fn render_native_case_1312() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3486596039712763e+3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1348.6596039712763\"}"),
  )
}

///|
fn render_native_case_1313() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.227501220073862e+22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.227501220073862E22\"}"),
  )
}

///|
fn render_native_case_1314() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2879544639715102e-99")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2879544639715102E-99\"}"),
  )
}

///|
fn render_native_case_1315() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.0435605821657462e+236")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.0435605821657462E236\"}"),
  )
}

///|
fn render_native_case_1316() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.440325844232788e-151")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.440325844232788E-151\"}"),
  )
}

///|
fn render_native_case_1317() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.8624758428302e+300")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.8624758428302E300\"}"),
  )
}

///|
fn render_native_case_1318() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.4016817084376002e+249")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.4016817084376002E249\"}"),
  )
}

///|
fn render_native_case_1319() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.252123921797031e+307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.252123921797031E307\"}"),
  )
}

///|
fn render_native_case_1320() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.2251498974838465e+204")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.2251498974838465E204\"}"),
  )
}

///|
fn render_native_case_1321() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.814626771485747e-49")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.814626771485747E-49\"}"),
  )
}

///|
fn render_native_case_1322() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.733102515223168e+95")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.733102515223168E95\"}"),
  )
}

///|
fn render_native_case_1323() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.653101557681945e-191")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.653101557681945E-191\"}"),
  )
}

///|
fn render_native_case_1324() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8265324877553238e+72")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8265324877553238E72\"}"),
  )
}

///|
fn render_native_case_1325() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.961271497104303e-17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.961271497104303E-17\"}"),
  )
}

///|
fn render_native_case_1326() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.7434774644453e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.7434774644453E-274\"}"),
  )
}

///|
fn render_native_case_1327() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.3368057942107098e+4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-23368.057942107098\"}"),
  )
}

///|
fn render_native_case_1328() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.230616019922692e+251")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.230616019922692E251\"}"),
  )
}

///|
fn render_native_case_1329() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.814808444531666e+117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.814808444531666E117\"}"),
  )
}

///|
fn render_native_case_1330() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.750265691328495e+3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7750.265691328495\"}"),
  )
}

///|
fn render_native_case_1331() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.666302801791479e-299")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.666302801791479E-299\"}"),
  )
}

///|
fn render_native_case_1332() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.5664533534510914e-222")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.5664533534510914E-222\"}"),
  )
}

///|
fn render_native_case_1333() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.458102874269058e+80")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.458102874269058E80\"}"),
  )
}

///|
fn render_native_case_1334() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6536507233274227e-235")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6536507233274227E-235\"}"),
  )
}

///|
fn render_native_case_1335() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.844305662864655e-146")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.844305662864655E-146\"}"),
  )
}

///|
fn render_native_case_1336() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.5965703101435727e+272")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.5965703101435727E272\"}"),
  )
}

///|
fn render_native_case_1337() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.72045838247068e-282")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.72045838247068E-282\"}"),
  )
}

///|
fn render_native_case_1338() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.03201279808757e+147")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.03201279808757E147\"}"),
  )
}

///|
fn render_native_case_1339() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0885166434228e+44")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0885166434228E44\"}"),
  )
}

///|
fn render_native_case_1340() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0239200177046957e-280")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0239200177046957E-280\"}"),
  )
}

///|
fn render_native_case_1341() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.3616950024491665e-277")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.3616950024491665E-277\"}"),
  )
}

///|
fn render_native_case_1342() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.8856365884030948e-254")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.8856365884030948E-254\"}"),
  )
}

///|
fn render_native_case_1343() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.951189004794606e+292")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.951189004794606E292\"}"),
  )
}

///|
fn render_native_case_1344() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5064700675761495e-131")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5064700675761495E-131\"}"),
  )
}

///|
fn render_native_case_1345() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.924423619599833e+100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.924423619599833E100\"}"),
  )
}

///|
fn render_native_case_1346() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.762236199651372e-243")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.762236199651372E-243\"}"),
  )
}

///|
fn render_native_case_1347() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.146919511860452e+263")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.146919511860452E263\"}"),
  )
}

///|
fn render_native_case_1348() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.152324259133145e-190")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.152324259133145E-190\"}"),
  )
}

///|
fn render_native_case_1349() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.7898562655931915e+218")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.7898562655931915E218\"}"),
  )
}

///|
fn render_native_case_1350() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.907050853074898e+85")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.907050853074898E85\"}"),
  )
}

///|
fn render_native_case_1351() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.8001458714606365e+150")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.8001458714606365E150\"}"),
  )
}

///|
fn render_native_case_1352() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.193963186550753e-53")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.193963186550753E-53\"}"),
  )
}

///|
fn render_native_case_1353() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2818686551778714e-116")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2818686551778714E-116\"}"),
  )
}

///|
fn render_native_case_1354() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.441250333065188e-57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.441250333065188E-57\"}"),
  )
}

///|
fn render_native_case_1355() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.070707272587974e-82")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.070707272587974E-82\"}"),
  )
}

///|
fn render_native_case_1356() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2243696590553058e-158")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2243696590553058E-158\"}"),
  )
}

///|
fn render_native_case_1357() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.236476100730223e-298")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.236476100730223E-298\"}"),
  )
}

///|
fn render_native_case_1358() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.7303624690951605e-36")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.7303624690951605E-36\"}"),
  )
}

///|
fn render_native_case_1359() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0336193172874115e+33")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0336193172874115E33\"}"),
  )
}

///|
fn render_native_case_1360() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7401603205037184e+211")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7401603205037184E211\"}"),
  )
}

///|
fn render_native_case_1361() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.5886380677678635e-14")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.5886380677678635E-14\"}"),
  )
}

///|
fn render_native_case_1362() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.143785573485899e-291")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.143785573485899E-291\"}"),
  )
}

///|
fn render_native_case_1363() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.34525487174293e-211")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.34525487174293E-211\"}"),
  )
}

///|
fn render_native_case_1364() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7372411760900763e-150")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7372411760900763E-150\"}"),
  )
}

///|
fn render_native_case_1365() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.1051933394196035e+77")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.1051933394196035E77\"}"),
  )
}

///|
fn render_native_case_1366() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2219028918759064e+163")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2219028918759064E163\"}"),
  )
}

///|
fn render_native_case_1367() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.1840823308616475e-248")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.1840823308616475E-248\"}"),
  )
}

///|
fn render_native_case_1368() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.405766780951539e-79")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.405766780951539E-79\"}"),
  )
}

///|
fn render_native_case_1369() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.022404891407614e-116")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.022404891407614E-116\"}"),
  )
}

///|
fn render_native_case_1370() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.856727339997709e-7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.856727339997709E-7\"}"),
  )
}

///|
fn render_native_case_1371() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.05121889872239e+243")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.05121889872239E243\"}"),
  )
}

///|
fn render_native_case_1372() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.392427528665577e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.392427528665577E-307\"}"),
  )
}

///|
fn render_native_case_1373() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.105303989121456e+105")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.105303989121456E105\"}"),
  )
}

///|
fn render_native_case_1374() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.0037731026620494e+200")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.0037731026620494E200\"}"),
  )
}

///|
fn render_native_case_1375() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.987820251632813e+231")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.987820251632813E231\"}"),
  )
}

///|
fn render_native_case_1376() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3408080257934636e-70")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3408080257934636E-70\"}"),
  )
}

///|
fn render_native_case_1377() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.16205207872961e+283")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.16205207872961E283\"}"),
  )
}

///|
fn render_native_case_1378() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.637373370386052e-211")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.637373370386052E-211\"}"),
  )
}

///|
fn render_native_case_1379() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.852265616146451e-80")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.852265616146451E-80\"}"),
  )
}

///|
fn render_native_case_1380() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2168785089910635e-22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2168785089910635E-22\"}"),
  )
}

///|
fn render_native_case_1381() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.125344034138596e+91")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.125344034138596E91\"}"),
  )
}

///|
fn render_native_case_1382() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.1540889539606024e-130")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.1540889539606024E-130\"}"),
  )
}

///|
fn render_native_case_1383() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3050685067111134e-125")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3050685067111134E-125\"}"),
  )
}

///|
fn render_native_case_1384() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0252673529913689e+126")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0252673529913689E126\"}"),
  )
}

///|
fn render_native_case_1385() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.484745371482957e-215")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.484745371482957E-215\"}"),
  )
}

///|
fn render_native_case_1386() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.561111459589616e+72")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.561111459589616E72\"}"),
  )
}

///|
fn render_native_case_1387() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4664163770592162e-80")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4664163770592162E-80\"}"),
  )
}

///|
fn render_native_case_1388() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7714580598897134e-209")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7714580598897134E-209\"}"),
  )
}

///|
fn render_native_case_1389() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4786584862256407e-23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4786584862256407E-23\"}"),
  )
}

///|
fn render_native_case_1390() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.075717517476047e-137")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.075717517476047E-137\"}"),
  )
}

///|
fn render_native_case_1391() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.742310194025934e+204")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.742310194025934E204\"}"),
  )
}

///|
fn render_native_case_1392() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6598375842241597e-243")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6598375842241597E-243\"}"),
  )
}

///|
fn render_native_case_1393() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.629362228302693e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.629362228302693E-307\"}"),
  )
}

///|
fn render_native_case_1394() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0100348973311504e-157")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0100348973311504E-157\"}"),
  )
}

///|
fn render_native_case_1395() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.173965453386544e+288")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.173965453386544E288\"}"),
  )
}

///|
fn render_native_case_1396() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.028484453317471e-192")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.028484453317471E-192\"}"),
  )
}

///|
fn render_native_case_1397() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.1269990779389647e+303")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.1269990779389647E303\"}"),
  )
}

///|
fn render_native_case_1398() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.934277448532343e-54")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.934277448532343E-54\"}"),
  )
}

///|
fn render_native_case_1399() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.7208861802487706e+242")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.7208861802487706E242\"}"),
  )
}

///|
fn render_native_case_1400() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7279660905674928e+98")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7279660905674928E98\"}"),
  )
}

///|
fn render_native_case_1401() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.1081046355252594e+74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.1081046355252594E74\"}"),
  )
}

///|
fn render_native_case_1402() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.4286764593178516e-193")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.4286764593178516E-193\"}"),
  )
}

///|
fn render_native_case_1403() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.237550982605568e-230")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.237550982605568E-230\"}"),
  )
}

///|
fn render_native_case_1404() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.445287808464343e+123")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.445287808464343E123\"}"),
  )
}

///|
fn render_native_case_1405() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.335644807438205e+30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.335644807438205E30\"}"),
  )
}

///|
fn render_native_case_1406() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.4648243884572624e-182")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.4648243884572624E-182\"}"),
  )
}

///|
fn render_native_case_1407() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.9251776124356275e+102")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.9251776124356275E102\"}"),
  )
}

///|
fn render_native_case_1408() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.492128861607603e-246")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.492128861607603E-246\"}"),
  )
}

///|
fn render_native_case_1409() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.9924391300903795e+114")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.9924391300903795E114\"}"),
  )
}

///|
fn render_native_case_1410() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.43284118584183e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.43284118584183E-4\"}"),
  )
}

///|
fn render_native_case_1411() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.771472724685752e-292")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.771472724685752E-292\"}"),
  )
}

///|
fn render_native_case_1412() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.9544391530015705e+45")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.9544391530015705E45\"}"),
  )
}

///|
fn render_native_case_1413() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5129104148530037e-209")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5129104148530037E-209\"}"),
  )
}

///|
fn render_native_case_1414() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.279405659994628e-31")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.279405659994628E-31\"}"),
  )
}

///|
fn render_native_case_1415() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0613755120711156e-151")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0613755120711156E-151\"}"),
  )
}

///|
fn render_native_case_1416() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.0311944715963894e+76")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.0311944715963894E76\"}"),
  )
}

///|
fn render_native_case_1417() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.5269734316308346e+273")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.5269734316308346E273\"}"),
  )
}

///|
fn render_native_case_1418() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.109077685954108e+181")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.109077685954108E181\"}"),
  )
}

///|
fn render_native_case_1419() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.9361279434044495e-23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.9361279434044495E-23\"}"),
  )
}

///|
fn render_native_case_1420() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.728516142246205e-44")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.728516142246205E-44\"}"),
  )
}

///|
fn render_native_case_1421() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.317377294169886e+140")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.317377294169886E140\"}"),
  )
}

///|
fn render_native_case_1422() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.8263922808447314e+91")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.8263922808447314E91\"}"),
  )
}

///|
fn render_native_case_1423() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.008583107276487e+267")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.008583107276487E267\"}"),
  )
}

///|
fn render_native_case_1424() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.96127818073138e+129")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.96127818073138E129\"}"),
  )
}

///|
fn render_native_case_1425() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5787448594431031e+22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5787448594431031E22\"}"),
  )
}

///|
fn render_native_case_1426() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.416671563620852e+280")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.416671563620852E280\"}"),
  )
}

///|
fn render_native_case_1427() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.6364158094010754e+276")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.6364158094010754E276\"}"),
  )
}

///|
fn render_native_case_1428() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.9871906124778693e+76")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.9871906124778693E76\"}"),
  )
}

///|
fn render_native_case_1429() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.7406850117083165e-104")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.7406850117083165E-104\"}"),
  )
}

///|
fn render_native_case_1430() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.66748060787232e+28")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.66748060787232E28\"}"),
  )
}

///|
fn render_native_case_1431() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.215156397841523e+192")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.215156397841523E192\"}"),
  )
}

///|
fn render_native_case_1432() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6633044731866805e-220")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6633044731866805E-220\"}"),
  )
}

///|
fn render_native_case_1433() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.422398852284236e+173")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.422398852284236E173\"}"),
  )
}

///|
fn render_native_case_1434() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.6902404942435863e+81")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.6902404942435863E81\"}"),
  )
}

///|
fn render_native_case_1435() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.813230917875194e-194")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.813230917875194E-194\"}"),
  )
}

///|
fn render_native_case_1436() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0716302021238523e+254")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0716302021238523E254\"}"),
  )
}

///|
fn render_native_case_1437() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.346439456191239e-266")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.346439456191239E-266\"}"),
  )
}

///|
fn render_native_case_1438() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.559931028996521e-24")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.559931028996521E-24\"}"),
  )
}

///|
fn render_native_case_1439() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.8643461097454687e+168")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.8643461097454687E168\"}"),
  )
}

///|
fn render_native_case_1440() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8439537146811364e-75")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8439537146811364E-75\"}"),
  )
}

///|
fn render_native_case_1441() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.921000369700283e+243")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.921000369700283E243\"}"),
  )
}

///|
fn render_native_case_1442() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.5497246120261784e+9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.5497246120261784E9\"}"),
  )
}

///|
fn render_native_case_1443() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7704948590126477e-200")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7704948590126477E-200\"}"),
  )
}

///|
fn render_native_case_1444() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.956691583269147e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.956691583269147E48\"}"),
  )
}

///|
fn render_native_case_1445() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9782516767525787e+85")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9782516767525787E85\"}"),
  )
}

///|
fn render_native_case_1446() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.0323454425303517e-117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.0323454425303517E-117\"}"),
  )
}

///|
fn render_native_case_1447() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.6319125614739974e-288")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.6319125614739974E-288\"}"),
  )
}

///|
fn render_native_case_1448() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.07636238066995e+116")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.07636238066995E116\"}"),
  )
}

///|
fn render_native_case_1449() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.158701629498534e+234")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.158701629498534E234\"}"),
  )
}

///|
fn render_native_case_1450() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5948352242454308e+245")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5948352242454308E245\"}"),
  )
}

///|
fn render_native_case_1451() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.822289006201805e+182")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.822289006201805E182\"}"),
  )
}

///|
fn render_native_case_1452() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.099711264854821e-53")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.099711264854821E-53\"}"),
  )
}

///|
fn render_native_case_1453() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4996955474190841e-9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4996955474190841E-9\"}"),
  )
}

///|
fn render_native_case_1454() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4593674821141787e-265")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4593674821141787E-265\"}"),
  )
}

///|
fn render_native_case_1455() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.976508162653506e+54")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.976508162653506E54\"}"),
  )
}

///|
fn render_native_case_1456() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0014082596188545e-122")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0014082596188545E-122\"}"),
  )
}

///|
fn render_native_case_1457() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.5987292632378835e+255")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.5987292632378835E255\"}"),
  )
}

///|
fn render_native_case_1458() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.6929154319427528e-161")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.6929154319427528E-161\"}"),
  )
}

///|
fn render_native_case_1459() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.787953857773648e-24")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.787953857773648E-24\"}"),
  )
}

///|
fn render_native_case_1460() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.2883271663986633e+145")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.2883271663986633E145\"}"),
  )
}

///|
fn render_native_case_1461() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.0896043503957816e+182")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.0896043503957816E182\"}"),
  )
}

///|
fn render_native_case_1462() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0537636375342792e+167")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0537636375342792E167\"}"),
  )
}

///|
fn render_native_case_1463() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.481594789877794e-234")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.481594789877794E-234\"}"),
  )
}

///|
fn render_native_case_1464() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.4602082970748975e+131")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.4602082970748975E131\"}"),
  )
}

///|
fn render_native_case_1465() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.105037379945838e+107")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.105037379945838E107\"}"),
  )
}

///|
fn render_native_case_1466() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5154544023817104e-169")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5154544023817104E-169\"}"),
  )
}

///|
fn render_native_case_1467() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0661254327367788e-177")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0661254327367788E-177\"}"),
  )
}

///|
fn render_native_case_1468() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.819584543557167e+208")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.819584543557167E208\"}"),
  )
}

///|
fn render_native_case_1469() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.6162085458440182e-76")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.6162085458440182E-76\"}"),
  )
}

///|
fn render_native_case_1470() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0546658370735707e+270")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0546658370735707E270\"}"),
  )
}

///|
fn render_native_case_1471() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.032915525113405e+290")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.032915525113405E290\"}"),
  )
}

///|
fn render_native_case_1472() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8301206756457788e+83")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8301206756457788E83\"}"),
  )
}

///|
fn render_native_case_1473() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.056728009969806e+250")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.056728009969806E250\"}"),
  )
}

///|
fn render_native_case_1474() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.998703848380332e+145")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.998703848380332E145\"}"),
  )
}

///|
fn render_native_case_1475() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.1651342815338613e-256")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.1651342815338613E-256\"}"),
  )
}

///|
fn render_native_case_1476() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.829719208841905e-45")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.829719208841905E-45\"}"),
  )
}

///|
fn render_native_case_1477() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.818770932825481e-282")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.818770932825481E-282\"}"),
  )
}

///|
fn render_native_case_1478() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.5324932185882342e-300")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.5324932185882342E-300\"}"),
  )
}

///|
fn render_native_case_1479() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.5832087610535884e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.5832087610535884E48\"}"),
  )
}

///|
fn render_native_case_1480() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.356953867315619e+265")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.356953867315619E265\"}"),
  )
}

///|
fn render_native_case_1481() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.7746288025195034e+289")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.7746288025195034E289\"}"),
  )
}

///|
fn render_native_case_1482() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.8602755204137905e-119")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.8602755204137905E-119\"}"),
  )
}

///|
fn render_native_case_1483() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3957685635670189e-248")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3957685635670189E-248\"}"),
  )
}

///|
fn render_native_case_1484() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.99946234778708e-214")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.99946234778708E-214\"}"),
  )
}

///|
fn render_native_case_1485() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.523392272748572e-38")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.523392272748572E-38\"}"),
  )
}

///|
fn render_native_case_1486() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.274266918736901e-281")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.274266918736901E-281\"}"),
  )
}

///|
fn render_native_case_1487() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.779298692774988e+64")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.779298692774988E64\"}"),
  )
}

///|
fn render_native_case_1488() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.4898874425467265e+116")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.4898874425467265E116\"}"),
  )
}

///|
fn render_native_case_1489() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3390233450313502e-281")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3390233450313502E-281\"}"),
  )
}

///|
fn render_native_case_1490() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.966377195663765e-263")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.966377195663765E-263\"}"),
  )
}

///|
fn render_native_case_1491() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.269255105815533e-260")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.269255105815533E-260\"}"),
  )
}

///|
fn render_native_case_1492() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.6110359832643503e-35")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.6110359832643503E-35\"}"),
  )
}

///|
fn render_native_case_1493() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4946751257543019e-115")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4946751257543019E-115\"}"),
  )
}

///|
fn render_native_case_1494() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.378093449299324e-42")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.378093449299324E-42\"}"),
  )
}

///|
fn render_native_case_1495() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.570200352595911e-200")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.570200352595911E-200\"}"),
  )
}

///|
fn render_native_case_1496() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.9129877439967665e-208")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.9129877439967665E-208\"}"),
  )
}

///|
fn render_native_case_1497() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4323124882401501e-31")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4323124882401501E-31\"}"),
  )
}

///|
fn render_native_case_1498() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.289923832867551e-200")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.289923832867551E-200\"}"),
  )
}

///|
fn render_native_case_1499() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.548721717943443e+114")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.548721717943443E114\"}"),
  )
}

///|
fn render_native_case_1500() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.046744565227925e+210")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.046744565227925E210\"}"),
  )
}

///|
fn render_native_case_1501() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.34537416967497e+114")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.34537416967497E114\"}"),
  )
}

///|
fn render_native_case_1502() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.8347705389341426e-258")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.8347705389341426E-258\"}"),
  )
}

///|
fn render_native_case_1503() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.143960431778676e+17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-814396043177867648\"}"),
  )
}

///|
fn render_native_case_1504() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.769495218503494e+64")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.769495218503494E64\"}"),
  )
}

///|
fn render_native_case_1505() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.717752403996188e-124")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.717752403996188E-124\"}"),
  )
}

///|
fn render_native_case_1506() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.125515472615779e+26")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.125515472615779E26\"}"),
  )
}

///|
fn render_native_case_1507() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.1569570544488783e+74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.1569570544488783E74\"}"),
  )
}

///|
fn render_native_case_1508() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.580864664238884e-249")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.580864664238884E-249\"}"),
  )
}

///|
fn render_native_case_1509() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2229526751866525e+205")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2229526751866525E205\"}"),
  )
}

///|
fn render_native_case_1510() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.994731363091383e-141")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.994731363091383E-141\"}"),
  )
}

///|
fn render_native_case_1511() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.5282300943085354e+79")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.5282300943085354E79\"}"),
  )
}

///|
fn render_native_case_1512() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.323929104792983e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.323929104792983E-274\"}"),
  )
}

///|
fn render_native_case_1513() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7366539323007685e-133")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7366539323007685E-133\"}"),
  )
}

///|
fn render_native_case_1514() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.1633707734060816e-305")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.1633707734060816E-305\"}"),
  )
}

///|
fn render_native_case_1515() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.6430743077024213e+24")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.6430743077024213E24\"}"),
  )
}

///|
fn render_native_case_1516() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.1514239782527233e-40")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.1514239782527233E-40\"}"),
  )
}

///|
fn render_native_case_1517() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.842102940118601e+195")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.842102940118601E195\"}"),
  )
}

///|
fn render_native_case_1518() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0455731240036311e-291")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0455731240036311E-291\"}"),
  )
}

///|
fn render_native_case_1519() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.490953014520586e-36")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.490953014520586E-36\"}"),
  )
}

///|
fn render_native_case_1520() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.192261108904494e-106")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.192261108904494E-106\"}"),
  )
}

///|
fn render_native_case_1521() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9173251024369475e+22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9173251024369475E22\"}"),
  )
}

///|
fn render_native_case_1522() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.630141934821792e+304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.630141934821792E304\"}"),
  )
}

///|
fn render_native_case_1523() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.84643483275594e-258")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.84643483275594E-258\"}"),
  )
}

///|
fn render_native_case_1524() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3723018110070316e-8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3723018110070316E-8\"}"),
  )
}

///|
fn render_native_case_1525() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.089121443899581e+277")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.089121443899581E277\"}"),
  )
}

///|
fn render_native_case_1526() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.1486931697122405e-28")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.1486931697122405E-28\"}"),
  )
}

///|
fn render_native_case_1527() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2869957740038958e+223")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2869957740038958E223\"}"),
  )
}

///|
fn render_native_case_1528() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.1069268719890573e-112")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.1069268719890573E-112\"}"),
  )
}

///|
fn render_native_case_1529() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.399946732710162e+25")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.399946732710162E25\"}"),
  )
}

///|
fn render_native_case_1530() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2364564951580793e+49")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2364564951580793E49\"}"),
  )
}

///|
fn render_native_case_1531() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.961383713337417e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.005961383713337417\"}"),
  )
}

///|
fn render_native_case_1532() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7161534693799027e+105")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7161534693799027E105\"}"),
  )
}

///|
fn render_native_case_1533() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3237712147551244e-157")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3237712147551244E-157\"}"),
  )
}

///|
fn render_native_case_1534() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.424228806558208e+130")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.424228806558208E130\"}"),
  )
}

///|
fn render_native_case_1535() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.869570954986905e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.869570954986905E-100\"}"),
  )
}

///|
fn render_native_case_1536() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.8290006506380654e+274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.8290006506380654E274\"}"),
  )
}

///|
fn render_native_case_1537() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.074622170351958e-49")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.074622170351958E-49\"}"),
  )
}

///|
fn render_native_case_1538() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.4042483417744143e+81")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.4042483417744143E81\"}"),
  )
}

///|
fn render_native_case_1539() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1586924254851881e+24")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1586924254851881E24\"}"),
  )
}

///|
fn render_native_case_1540() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2277184941816972e-28")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2277184941816972E-28\"}"),
  )
}

///|
fn render_native_case_1541() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.096723233771819e-304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.096723233771819E-304\"}"),
  )
}

///|
fn render_native_case_1542() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.794742112234032e+248")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.794742112234032E248\"}"),
  )
}

///|
fn render_native_case_1543() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.828994977034321e-86")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.828994977034321E-86\"}"),
  )
}

///|
fn render_native_case_1544() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.775066483367422e-55")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.775066483367422E-55\"}"),
  )
}

///|
fn render_native_case_1545() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.50054978224048e+34")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.50054978224048E34\"}"),
  )
}

///|
fn render_native_case_1546() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.9810451414787475e+167")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.9810451414787475E167\"}"),
  )
}

///|
fn render_native_case_1547() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.423074753481451e-239")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.423074753481451E-239\"}"),
  )
}

///|
fn render_native_case_1548() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.676525715491103e+306")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.676525715491103E306\"}"),
  )
}

///|
fn render_native_case_1549() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.5853500457647333e-67")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.5853500457647333E-67\"}"),
  )
}

///|
fn render_native_case_1550() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.919771850143782e-75")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.919771850143782E-75\"}"),
  )
}

///|
fn render_native_case_1551() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1994119432189248e+111")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1994119432189248E111\"}"),
  )
}

///|
fn render_native_case_1552() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0777467287566793e-242")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0777467287566793E-242\"}"),
  )
}

///|
fn render_native_case_1553() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.650265378156746e+156")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.650265378156746E156\"}"),
  )
}

///|
fn render_native_case_1554() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.896644271171805e+228")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.896644271171805E228\"}"),
  )
}

///|
fn render_native_case_1555() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.711300915461972e+142")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.711300915461972E142\"}"),
  )
}

///|
fn render_native_case_1556() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.926424091108051e-54")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.926424091108051E-54\"}"),
  )
}

///|
fn render_native_case_1557() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.937431817458157e-21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.937431817458157E-21\"}"),
  )
}

///|
fn render_native_case_1558() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.1668659205486696e-207")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.1668659205486696E-207\"}"),
  )
}

///|
fn render_native_case_1559() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.927672471933757e+255")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.927672471933757E255\"}"),
  )
}

///|
fn render_native_case_1560() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.738365975780457e-50")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.738365975780457E-50\"}"),
  )
}

///|
fn render_native_case_1561() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.814371368659896e+121")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.814371368659896E121\"}"),
  )
}

///|
fn render_native_case_1562() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.223446543596453e-117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.223446543596453E-117\"}"),
  )
}

///|
fn render_native_case_1563() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.218333816254429e+224")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.218333816254429E224\"}"),
  )
}

///|
fn render_native_case_1564() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.34484032043445e+100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.34484032043445E100\"}"),
  )
}

///|
fn render_native_case_1565() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.337256574437784e-61")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.337256574437784E-61\"}"),
  )
}

///|
fn render_native_case_1566() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.4844756602187356e-55")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.4844756602187356E-55\"}"),
  )
}

///|
fn render_native_case_1567() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.089212067227636e+275")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.089212067227636E275\"}"),
  )
}

///|
fn render_native_case_1568() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.382116195960311e-131")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.382116195960311E-131\"}"),
  )
}

///|
fn render_native_case_1569() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.5315575548235808e+1")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"15.315575548235808\"}"),
  )
}

///|
fn render_native_case_1570() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.77519231477222e+286")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.77519231477222E286\"}"),
  )
}

///|
fn render_native_case_1571() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.601635830287568e-210")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.601635830287568E-210\"}"),
  )
}

///|
fn render_native_case_1572() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6513259596142903e+243")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6513259596142903E243\"}"),
  )
}

///|
fn render_native_case_1573() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3001700168966498e-92")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3001700168966498E-92\"}"),
  )
}

///|
fn render_native_case_1574() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3336037561064302e+2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-133.36037561064302\"}"),
  )
}

///|
fn render_native_case_1575() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5105082768253104e+57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5105082768253104E57\"}"),
  )
}

///|
fn render_native_case_1576() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.666583611356982e-280")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.666583611356982E-280\"}"),
  )
}

///|
fn render_native_case_1577() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.495317092341522e-26")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.495317092341522E-26\"}"),
  )
}

///|
fn render_native_case_1578() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3670036084389376e+161")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3670036084389376E161\"}"),
  )
}

///|
fn render_native_case_1579() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2892891515976355e-303")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2892891515976355E-303\"}"),
  )
}

///|
fn render_native_case_1580() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.467338613830577e-210")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.467338613830577E-210\"}"),
  )
}

///|
fn render_native_case_1581() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.945371174009447e-245")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.945371174009447E-245\"}"),
  )
}

///|
fn render_native_case_1582() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.809027029420907e+144")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.809027029420907E144\"}"),
  )
}

///|
fn render_native_case_1583() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.229660292312249e-272")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.229660292312249E-272\"}"),
  )
}

///|
fn render_native_case_1584() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8214251813424723e-142")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8214251813424723E-142\"}"),
  )
}

///|
fn render_native_case_1585() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.804860347338585e+180")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.804860347338585E180\"}"),
  )
}

///|
fn render_native_case_1586() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0901617378676542e+151")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0901617378676542E151\"}"),
  )
}

///|
fn render_native_case_1587() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1359604546871714e-257")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1359604546871714E-257\"}"),
  )
}

///|
fn render_native_case_1588() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.077087946273017e-141")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.077087946273017E-141\"}"),
  )
}

///|
fn render_native_case_1589() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0187105023020074e-58")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0187105023020074E-58\"}"),
  )
}

///|
fn render_native_case_1590() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7166823218347792e-224")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7166823218347792E-224\"}"),
  )
}

///|
fn render_native_case_1591() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.243135430027896e-232")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.243135430027896E-232\"}"),
  )
}

///|
fn render_native_case_1592() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.5400652933504217e+117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.5400652933504217E117\"}"),
  )
}

///|
fn render_native_case_1593() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.0191436694805035e-229")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.0191436694805035E-229\"}"),
  )
}

///|
fn render_native_case_1594() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.1788005133012124e+181")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.1788005133012124E181\"}"),
  )
}

///|
fn render_native_case_1595() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.0590135776493463e-142")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.0590135776493463E-142\"}"),
  )
}

///|
fn render_native_case_1596() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.590615723570733e+231")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.590615723570733E231\"}"),
  )
}

///|
fn render_native_case_1597() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2668265036161514e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2668265036161514E-307\"}"),
  )
}

///|
fn render_native_case_1598() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.3506123875598854e-12")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.3506123875598854E-12\"}"),
  )
}

///|
fn render_native_case_1599() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3699232935695766e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3699232935695766E-308\"}"),
  )
}

///|
fn render_native_case_1600() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.494585849005249e+70")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.494585849005249E70\"}"),
  )
}

///|
fn render_native_case_1601() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.784177590271224e+250")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.784177590271224E250\"}"),
  )
}

///|
fn render_native_case_1602() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.95314836750635e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.95314836750635E48\"}"),
  )
}

///|
fn render_native_case_1603() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.476374056290635e-55")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.476374056290635E-55\"}"),
  )
}

///|
fn render_native_case_1604() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.416029819540991e-241")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.416029819540991E-241\"}"),
  )
}

///|
fn render_native_case_1605() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.778827824720599e-201")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.778827824720599E-201\"}"),
  )
}

///|
fn render_native_case_1606() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9645185641317557e-71")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9645185641317557E-71\"}"),
  )
}

///|
fn render_native_case_1607() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2403046520989185e-117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2403046520989185E-117\"}"),
  )
}

///|
fn render_native_case_1608() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.721238342403707e-201")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.721238342403707E-201\"}"),
  )
}

///|
fn render_native_case_1609() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1478917003597486e+256")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1478917003597486E256\"}"),
  )
}

///|
fn render_native_case_1610() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.5927990136294808e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.5927990136294808E48\"}"),
  )
}

///|
fn render_native_case_1611() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3840870700046308e+231")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3840870700046308E231\"}"),
  )
}

///|
fn render_native_case_1612() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.50745912795122e-83")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.50745912795122E-83\"}"),
  )
}

///|
fn render_native_case_1613() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3180710505100967e-120")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3180710505100967E-120\"}"),
  )
}

///|
fn render_native_case_1614() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.2458844847743938e-14")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.2458844847743938E-14\"}"),
  )
}

///|
fn render_native_case_1615() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.0206106240919085e-34")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.0206106240919085E-34\"}"),
  )
}

///|
fn render_native_case_1616() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.075901497031663e-177")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.075901497031663E-177\"}"),
  )
}

///|
fn render_native_case_1617() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.78937644382496e-53")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.78937644382496E-53\"}"),
  )
}

///|
fn render_native_case_1618() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3824332979960536e+128")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3824332979960536E128\"}"),
  )
}

///|
fn render_native_case_1619() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0906906309338423e+92")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0906906309338423E92\"}"),
  )
}

///|
fn render_native_case_1620() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.329580534102805e+179")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.329580534102805E179\"}"),
  )
}

///|
fn render_native_case_1621() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.0328020939670055e+54")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.0328020939670055E54\"}"),
  )
}

///|
fn render_native_case_1622() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.1811397947298254e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.1811397947298254E48\"}"),
  )
}

///|
fn render_native_case_1623() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.0277589308672925e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.0277589308672925E-274\"}"),
  )
}

///|
fn render_native_case_1624() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.748682127387334e+73")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.748682127387334E73\"}"),
  )
}

///|
fn render_native_case_1625() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.04909888877896e+232")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.04909888877896E232\"}"),
  )
}

///|
fn render_native_case_1626() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7081271746672108e-222")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7081271746672108E-222\"}"),
  )
}

///|
fn render_native_case_1627() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.7053582640509063e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.7053582640509063E-274\"}"),
  )
}

///|
fn render_native_case_1628() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.944957654689687e+282")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.944957654689687E282\"}"),
  )
}

///|
fn render_native_case_1629() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.082549152666132e+3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2082.549152666132\"}"),
  )
}

///|
fn render_native_case_1630() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.402512860502265e+65")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.402512860502265E65\"}"),
  )
}

///|
fn render_native_case_1631() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.02746211052774e-83")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.02746211052774E-83\"}"),
  )
}

///|
fn render_native_case_1632() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.695643569418121e-129")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.695643569418121E-129\"}"),
  )
}

///|
fn render_native_case_1633() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.858128158457985e+66")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.858128158457985E66\"}"),
  )
}

///|
fn render_native_case_1634() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.445234323518341e-158")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.445234323518341E-158\"}"),
  )
}

///|
fn render_native_case_1635() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.182346084037973e+209")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.182346084037973E209\"}"),
  )
}

///|
fn render_native_case_1636() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.04506421984193e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.04506421984193E-309\"}"),
  )
}

///|
fn render_native_case_1637() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.0794684057601436e+40")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.0794684057601436E40\"}"),
  )
}

///|
fn render_native_case_1638() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.7966582033986857e-303")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.7966582033986857E-303\"}"),
  )
}

///|
fn render_native_case_1639() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.1159910125915234e-183")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.1159910125915234E-183\"}"),
  )
}

///|
fn render_native_case_1640() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.080809536953187e+83")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.080809536953187E83\"}"),
  )
}

///|
fn render_native_case_1641() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2297633984447482e+259")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2297633984447482E259\"}"),
  )
}

///|
fn render_native_case_1642() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.176819428347803e+295")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.176819428347803E295\"}"),
  )
}

///|
fn render_native_case_1643() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.129756435363114e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.129756435363114E-4\"}"),
  )
}

///|
fn render_native_case_1644() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.6723206864806917e+22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.6723206864806917E22\"}"),
  )
}

///|
fn render_native_case_1645() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.836155896185147e+233")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.836155896185147E233\"}"),
  )
}

///|
fn render_native_case_1646() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0757975644161007e-82")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0757975644161007E-82\"}"),
  )
}

///|
fn render_native_case_1647() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.8994600656522953e-303")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.8994600656522953E-303\"}"),
  )
}

///|
fn render_native_case_1648() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.938928888021235e+247")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.938928888021235E247\"}"),
  )
}

///|
fn render_native_case_1649() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.370604500345923e+143")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.370604500345923E143\"}"),
  )
}

///|
fn render_native_case_1650() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0285831415193389e-185")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0285831415193389E-185\"}"),
  )
}

///|
fn render_native_case_1651() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.808152336009633e+228")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.808152336009633E228\"}"),
  )
}

///|
fn render_native_case_1652() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9471191251801896e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9471191251801896E-274\"}"),
  )
}

///|
fn render_native_case_1653() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.6145174464291373e+104")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.6145174464291373E104\"}"),
  )
}

///|
fn render_native_case_1654() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0962658732485063e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0962658732485063E-4\"}"),
  )
}

///|
fn render_native_case_1655() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.8973402871489404e-306")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.8973402871489404E-306\"}"),
  )
}

///|
fn render_native_case_1656() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.667183558151016e-80")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.667183558151016E-80\"}"),
  )
}

///|
fn render_native_case_1657() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7990362963399776e+220")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7990362963399776E220\"}"),
  )
}

///|
fn render_native_case_1658() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.654513972238059e+162")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.654513972238059E162\"}"),
  )
}

///|
fn render_native_case_1659() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.916829672049109e-223")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.916829672049109E-223\"}"),
  )
}

///|
fn render_native_case_1660() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.945017282070735e+46")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.945017282070735E46\"}"),
  )
}

///|
fn render_native_case_1661() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4619042360325365e+0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4619042360325365\"}"),
  )
}

///|
fn render_native_case_1662() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.747124265387148e+33")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.747124265387148E33\"}"),
  )
}

///|
fn render_native_case_1663() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.563227842741395e-135")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.563227842741395E-135\"}"),
  )
}

///|
fn render_native_case_1664() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.212611292130337e+170")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.212611292130337E170\"}"),
  )
}

///|
fn render_native_case_1665() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3844190541515403e+253")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3844190541515403E253\"}"),
  )
}

///|
fn render_native_case_1666() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1361140769467405e+299")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1361140769467405E299\"}"),
  )
}

///|
fn render_native_case_1667() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.377143089103053e-298")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.377143089103053E-298\"}"),
  )
}

///|
fn render_native_case_1668() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.376886348614549e+39")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.376886348614549E39\"}"),
  )
}

///|
fn render_native_case_1669() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.0277791220633043e-300")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.0277791220633043E-300\"}"),
  )
}

///|
fn render_native_case_1670() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.677606956217541e-1")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.8677606956217541\"}"),
  )
}

///|
fn render_native_case_1671() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4275208470331542e+271")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4275208470331542E271\"}"),
  )
}

///|
fn render_native_case_1672() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.008517726432084e-57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.008517726432084E-57\"}"),
  )
}

///|
fn render_native_case_1673() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.7237474619311995e+204")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.7237474619311995E204\"}"),
  )
}

///|
fn render_native_case_1674() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3258204790025865e+95")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3258204790025865E95\"}"),
  )
}

///|
fn render_native_case_1675() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4892190707341172e-136")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4892190707341172E-136\"}"),
  )
}

///|
fn render_native_case_1676() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.547500942894366e+179")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.547500942894366E179\"}"),
  )
}

///|
fn render_native_case_1677() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.792524700210573e+273")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.792524700210573E273\"}"),
  )
}

///|
fn render_native_case_1678() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4306069810684937e-245")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4306069810684937E-245\"}"),
  )
}

///|
fn render_native_case_1679() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7448852218457835e-275")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7448852218457835E-275\"}"),
  )
}

///|
fn render_native_case_1680() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.648189744240544e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.648189744240544E-308\"}"),
  )
}

///|
fn render_native_case_1681() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.57554889788983e-71")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.57554889788983E-71\"}"),
  )
}

///|
fn render_native_case_1682() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.96506550276148e+86")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.96506550276148E86\"}"),
  )
}

///|
fn render_native_case_1683() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.451831823418848e-109")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.451831823418848E-109\"}"),
  )
}

///|
fn render_native_case_1684() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.3929773786486077e-209")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.3929773786486077E-209\"}"),
  )
}

///|
fn render_native_case_1685() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.1530665470008778e-38")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.1530665470008778E-38\"}"),
  )
}

///|
fn render_native_case_1686() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.417326717284634e+251")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.417326717284634E251\"}"),
  )
}

///|
fn render_native_case_1687() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.86216595591016e-272")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.86216595591016E-272\"}"),
  )
}

///|
fn render_native_case_1688() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3710032802738382e+237")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3710032802738382E237\"}"),
  )
}

///|
fn render_native_case_1689() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4380633107047412e+48")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4380633107047412E48\"}"),
  )
}

///|
fn render_native_case_1690() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.6437709904479846e+18")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3643770990447984640\"}"),
  )
}

///|
fn render_native_case_1691() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1295896995242847e-122")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1295896995242847E-122\"}"),
  )
}

///|
fn render_native_case_1692() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.906716282267935e+5")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-290671.6282267935\"}"),
  )
}

///|
fn render_native_case_1693() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.298678542800781e+263")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.298678542800781E263\"}"),
  )
}

///|
fn render_native_case_1694() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8182174512153927e-27")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8182174512153927E-27\"}"),
  )
}

///|
fn render_native_case_1695() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.3294103819413316e-218")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.3294103819413316E-218\"}"),
  )
}

///|
fn render_native_case_1696() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6192984172294685e+304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6192984172294685E304\"}"),
  )
}

///|
fn render_native_case_1697() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.7896747558941583e+11")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.7896747558941583E11\"}"),
  )
}

///|
fn render_native_case_1698() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.20619305604892e+76")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.20619305604892E76\"}"),
  )
}

///|
fn render_native_case_1699() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0294889932947622e+206")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0294889932947622E206\"}"),
  )
}

///|
fn render_native_case_1700() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.2855160406291106e+122")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.2855160406291106E122\"}"),
  )
}

///|
fn render_native_case_1701() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.335093151757479e-17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.335093151757479E-17\"}"),
  )
}

///|
fn render_native_case_1702() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.334509657750789e-12")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.334509657750789E-12\"}"),
  )
}

///|
fn render_native_case_1703() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.21207731175097e-117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.21207731175097E-117\"}"),
  )
}

///|
fn render_native_case_1704() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.981890295384022e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.981890295384022E-274\"}"),
  )
}

///|
fn render_native_case_1705() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0142740501338452e+158")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0142740501338452E158\"}"),
  )
}

///|
fn render_native_case_1706() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.41482654223062e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.41482654223062E-308\"}"),
  )
}

///|
fn render_native_case_1707() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.4672290922849107e-217")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.4672290922849107E-217\"}"),
  )
}

///|
fn render_native_case_1708() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.984313393094189e-290")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.984313393094189E-290\"}"),
  )
}

///|
fn render_native_case_1709() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.2920786461869993e+58")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.2920786461869993E58\"}"),
  )
}

///|
fn render_native_case_1710() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.8681730503613605e+9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.8681730503613605E9\"}"),
  )
}

///|
fn render_native_case_1711() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2815171648994098e-69")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2815171648994098E-69\"}"),
  )
}

///|
fn render_native_case_1712() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.700912153077338e-53")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.700912153077338E-53\"}"),
  )
}

///|
fn render_native_case_1713() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.172059346869557e-126")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.172059346869557E-126\"}"),
  )
}

///|
fn render_native_case_1714() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.126272381746526e-195")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.126272381746526E-195\"}"),
  )
}

///|
fn render_native_case_1715() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.58190373010241e+187")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.58190373010241E187\"}"),
  )
}

///|
fn render_native_case_1716() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.082816529755514e-265")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.082816529755514E-265\"}"),
  )
}

///|
fn render_native_case_1717() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.2115173547205324e+215")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.2115173547205324E215\"}"),
  )
}

///|
fn render_native_case_1718() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.6748561996368715e+78")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.6748561996368715E78\"}"),
  )
}

///|
fn render_native_case_1719() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.246479830685124e+124")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.246479830685124E124\"}"),
  )
}

///|
fn render_native_case_1720() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2524240829227973e+74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2524240829227973E74\"}"),
  )
}

///|
fn render_native_case_1721() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.627877607983802e-83")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.627877607983802E-83\"}"),
  )
}

///|
fn render_native_case_1722() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.9278648199247865e+54")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.9278648199247865E54\"}"),
  )
}

///|
fn render_native_case_1723() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.6127814585086415e+167")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.6127814585086415E167\"}"),
  )
}

///|
fn render_native_case_1724() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.505883709941423e-267")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.505883709941423E-267\"}"),
  )
}

///|
fn render_native_case_1725() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.896377940696702e-213")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.896377940696702E-213\"}"),
  )
}

///|
fn render_native_case_1726() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.9151336592587655e+177")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.9151336592587655E177\"}"),
  )
}

///|
fn render_native_case_1727() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2472901829044139e-207")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2472901829044139E-207\"}"),
  )
}

///|
fn render_native_case_1728() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1447518601556103e+10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1447518601556103E10\"}"),
  )
}

///|
fn render_native_case_1729() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.1128916021343104e-12")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.1128916021343104E-12\"}"),
  )
}

///|
fn render_native_case_1730() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.0837549666743817e-270")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.0837549666743817E-270\"}"),
  )
}

///|
fn render_native_case_1731() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.3717013750611566e+5")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-337170.13750611566\"}"),
  )
}

///|
fn render_native_case_1732() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.3955708679267949e-167")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.3955708679267949E-167\"}"),
  )
}

///|
fn render_native_case_1733() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.7765709938323573e-114")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.7765709938323573E-114\"}"),
  )
}

///|
fn render_native_case_1734() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.2354116697268165e-117")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.2354116697268165E-117\"}"),
  )
}

///|
fn render_native_case_1735() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8428201330836328e+302")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8428201330836328E302\"}"),
  )
}

///|
fn render_native_case_1736() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.8241384804972766e+253")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.8241384804972766E253\"}"),
  )
}

///|
fn render_native_case_1737() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.296135315836688e+64")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.296135315836688E64\"}"),
  )
}

///|
fn render_native_case_1738() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.1225006317658292e+93")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.1225006317658292E93\"}"),
  )
}

///|
fn render_native_case_1739() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.0235831492300469e+152")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.0235831492300469E152\"}"),
  )
}

///|
fn render_native_case_1740() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.4287370098801155e-304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.4287370098801155E-304\"}"),
  )
}

///|
fn render_native_case_1741() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4957623395984065e-257")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4957623395984065E-257\"}"),
  )
}

///|
fn render_native_case_1742() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3457272949032215e-150")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3457272949032215E-150\"}"),
  )
}

///|
fn render_native_case_1743() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4248025020124866e+167")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4248025020124866E167\"}"),
  )
}

///|
fn render_native_case_1744() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0191333071627144e+104")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0191333071627144E104\"}"),
  )
}

///|
fn render_native_case_1745() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.421371888780377e-13")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.421371888780377E-13\"}"),
  )
}

///|
fn render_native_case_1746() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2710951128073188e-31")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2710951128073188E-31\"}"),
  )
}

///|
fn render_native_case_1747() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3603227056951843e+224")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3603227056951843E224\"}"),
  )
}

///|
fn render_native_case_1748() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2019665015558334e+226")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2019665015558334E226\"}"),
  )
}

///|
fn render_native_case_1749() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.671380486179211e-146")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.671380486179211E-146\"}"),
  )
}

///|
fn render_native_case_1750() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9847649335161473e+21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9847649335161473E21\"}"),
  )
}

///|
fn render_native_case_1751() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.304105556541234e-282")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.304105556541234E-282\"}"),
  )
}

///|
fn render_native_case_1752() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.558614347041132e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0.02558614347041132\"}"),
  )
}

///|
fn render_native_case_1753() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.5705267767703926e+291")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.5705267767703926E291\"}"),
  )
}

///|
fn render_native_case_1754() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.55194480491529e-6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.55194480491529E-6\"}"),
  )
}

///|
fn render_native_case_1755() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.9464147005960673e-97")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.9464147005960673E-97\"}"),
  )
}

///|
fn render_native_case_1756() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.777443462084527e-131")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.777443462084527E-131\"}"),
  )
}

///|
fn render_native_case_1757() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.464827312490117e-226")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.464827312490117E-226\"}"),
  )
}

///|
fn render_native_case_1758() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.964356418877124e-302")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.964356418877124E-302\"}"),
  )
}

///|
fn render_native_case_1759() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.217629742798021e+171")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.217629742798021E171\"}"),
  )
}

///|
fn render_native_case_1760() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.441288385913225e-180")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.441288385913225E-180\"}"),
  )
}

///|
fn render_native_case_1761() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.896912759906725e-235")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.896912759906725E-235\"}"),
  )
}

///|
fn render_native_case_1762() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.437715931939017e+73")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.437715931939017E73\"}"),
  )
}

///|
fn render_native_case_1763() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.042179911414318e+144")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.042179911414318E144\"}"),
  )
}

///|
fn render_native_case_1764() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.8452261934269273e-271")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.8452261934269273E-271\"}"),
  )
}

///|
fn render_native_case_1765() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.542639329457868e-131")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.542639329457868E-131\"}"),
  )
}

///|
fn render_native_case_1766() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.8668684260836347e+258")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.8668684260836347E258\"}"),
  )
}

///|
fn render_native_case_1767() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.3530662324239933e-15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.3530662324239933E-15\"}"),
  )
}

///|
fn render_native_case_1768() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.5105701541205087e-213")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.5105701541205087E-213\"}"),
  )
}

///|
fn render_native_case_1769() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.12990551525164e+46")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.12990551525164E46\"}"),
  )
}

///|
fn render_native_case_1770() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.011638786706415e-21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.011638786706415E-21\"}"),
  )
}

///|
fn render_native_case_1771() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.1079274158656153e+57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.1079274158656153E57\"}"),
  )
}

///|
fn render_native_case_1772() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.540026739575032e+283")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.540026739575032E283\"}"),
  )
}

///|
fn render_native_case_1773() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.8593864878164885e-265")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.8593864878164885E-265\"}"),
  )
}

///|
fn render_native_case_1774() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.160140247443923e-123")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.160140247443923E-123\"}"),
  )
}

///|
fn render_native_case_1775() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.2657323091200465e+262")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.2657323091200465E262\"}"),
  )
}

///|
fn render_native_case_1776() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.96115775655279e+157")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.96115775655279E157\"}"),
  )
}

///|
fn render_native_case_1777() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.072161300102341e-160")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.072161300102341E-160\"}"),
  )
}

///|
fn render_native_case_1778() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.391322791168595e-45")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.391322791168595E-45\"}"),
  )
}

///|
fn render_native_case_1779() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.224419778184028e-239")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.224419778184028E-239\"}"),
  )
}

///|
fn render_native_case_1780() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.1135120593387795e+189")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.1135120593387795E189\"}"),
  )
}

///|
fn render_native_case_1781() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.201369375848267e-174")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.201369375848267E-174\"}"),
  )
}

///|
fn render_native_case_1782() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.9776529231383587e-204")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.9776529231383587E-204\"}"),
  )
}

///|
fn render_native_case_1783() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.696143110408036e+215")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.696143110408036E215\"}"),
  )
}

///|
fn render_native_case_1784() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.1134188204280849e+9")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.1134188204280849E9\"}"),
  )
}

///|
fn render_native_case_1785() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-8.698262843448121e+162")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-8.698262843448121E162\"}"),
  )
}

///|
fn render_native_case_1786() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.821560083821767e+189")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.821560083821767E189\"}"),
  )
}

///|
fn render_native_case_1787() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.1330787582969215e-280")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.1330787582969215E-280\"}"),
  )
}

///|
fn render_native_case_1788() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.256212988443984e-74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.256212988443984E-74\"}"),
  )
}

///|
fn render_native_case_1789() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.5694162269590002e-160")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.5694162269590002E-160\"}"),
  )
}

///|
fn render_native_case_1790() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.3596929513763584e+219")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.3596929513763584E219\"}"),
  )
}

///|
fn render_native_case_1791() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.7771699434038688e+291")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.7771699434038688E291\"}"),
  )
}

///|
fn render_native_case_1792() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2707173352080899e+69")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2707173352080899E69\"}"),
  )
}

///|
fn render_native_case_1793() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("7.651786801886546e+279")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"7.651786801886546E279\"}"),
  )
}

///|
fn render_native_case_1794() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0717433394583255e+191")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0717433394583255E191\"}"),
  )
}

///|
fn render_native_case_1795() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.2889458281792643e-191")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.2889458281792643E-191\"}"),
  )
}

///|
fn render_native_case_1796() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7649593882099607e-182")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7649593882099607E-182\"}"),
  )
}

///|
fn render_native_case_1797() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4026498599270555e+1")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"14.026498599270555\"}"),
  )
}

///|
fn render_native_case_1798() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.4595660121648228e+209")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.4595660121648228E209\"}"),
  )
}

///|
fn render_native_case_1799() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.009755835148166e+279")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.009755835148166E279\"}"),
  )
}

///|
fn render_native_case_1800() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.515700363311137e-71")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.515700363311137E-71\"}"),
  )
}

///|
fn render_native_case_1801() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.195034024331483e-134")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.195034024331483E-134\"}"),
  )
}

///|
fn render_native_case_1802() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.3022726207961285e-284")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.3022726207961285E-284\"}"),
  )
}

///|
fn render_native_case_1803() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.945659957724043e+88")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.945659957724043E88\"}"),
  )
}

///|
fn render_native_case_1804() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.703139080669066e+12")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.703139080669066E12\"}"),
  )
}

///|
fn render_native_case_1805() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.379754592637793e-274")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.379754592637793E-274\"}"),
  )
}

///|
fn render_native_case_1806() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.8397521058778975e-154")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.8397521058778975E-154\"}"),
  )
}

///|
fn render_native_case_1807() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0503784918484951e+156")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0503784918484951E156\"}"),
  )
}

///|
fn render_native_case_1808() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.237208516059229e-133")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.237208516059229E-133\"}"),
  )
}

///|
fn render_native_case_1809() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.3491143445736124e-296")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.3491143445736124E-296\"}"),
  )
}

///|
fn render_native_case_1810() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.85936756577492e-86")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.85936756577492E-86\"}"),
  )
}

///|
fn render_native_case_1811() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.202114374387044e+18")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3202114374387043840\"}"),
  )
}

///|
fn render_native_case_1812() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.89654594775462e-238")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.89654594775462E-238\"}"),
  )
}

///|
fn render_native_case_1813() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.3769824490589608e-296")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.3769824490589608E-296\"}"),
  )
}

///|
fn render_native_case_1814() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.393254407089408e-124")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.393254407089408E-124\"}"),
  )
}

///|
fn render_native_case_1815() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.636677872158446e+110")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.636677872158446E110\"}"),
  )
}

///|
fn render_native_case_1816() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.186571672650311e+80")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.186571672650311E80\"}"),
  )
}

///|
fn render_native_case_1817() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.292379459717426e-141")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.292379459717426E-141\"}"),
  )
}

///|
fn render_native_case_1818() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.1139698460486766e-68")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.1139698460486766E-68\"}"),
  )
}

///|
fn render_native_case_1819() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0104640759342044e-69")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0104640759342044E-69\"}"),
  )
}

///|
fn render_native_case_1820() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.6336185158086505e-174")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.6336185158086505E-174\"}"),
  )
}

///|
fn render_native_case_1821() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.3612068857261764e+284")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.3612068857261764E284\"}"),
  )
}

///|
fn render_native_case_1822() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.884895120783486e+26")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.884895120783486E26\"}"),
  )
}

///|
fn render_native_case_1823() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.125775825358633e+141")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.125775825358633E141\"}"),
  )
}

///|
fn render_native_case_1824() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.184143410845072e-85")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.184143410845072E-85\"}"),
  )
}

///|
fn render_native_case_1825() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.2290299395367196e+156")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.2290299395367196E156\"}"),
  )
}

///|
fn render_native_case_1826() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0061834018065774e-255")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0061834018065774E-255\"}"),
  )
}

///|
fn render_native_case_1827() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.691311439822466e+152")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.691311439822466E152\"}"),
  )
}

///|
fn render_native_case_1828() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.7048747523912365e+27")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.7048747523912365E27\"}"),
  )
}

///|
fn render_native_case_1829() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.8207301549563116e+77")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.8207301549563116E77\"}"),
  )
}

///|
fn render_native_case_1830() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0296844394239815e+74")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0296844394239815E74\"}"),
  )
}

///|
fn render_native_case_1831() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.734848716687197e-236")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.734848716687197E-236\"}"),
  )
}

///|
fn render_native_case_1832() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.537275794979659e-266")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.537275794979659E-266\"}"),
  )
}

///|
fn render_native_case_1833() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.28427908911138e-67")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.28427908911138E-67\"}"),
  )
}

///|
fn render_native_case_1834() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.3857216976619517e-147")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.3857216976619517E-147\"}"),
  )
}

///|
fn render_native_case_1835() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.43257763610233e+251")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.43257763610233E251\"}"),
  )
}

///|
fn render_native_case_1836() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.607091869067039e+43")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.607091869067039E43\"}"),
  )
}

///|
fn render_native_case_1837() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.790989137451816e+185")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.790989137451816E185\"}"),
  )
}

///|
fn render_native_case_1838() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.2946027295842447e-90")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.2946027295842447E-90\"}"),
  )
}

///|
fn render_native_case_1839() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.242391961003177e+197")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.242391961003177E197\"}"),
  )
}

///|
fn render_native_case_1840() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0794764142822935e-57")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0794764142822935E-57\"}"),
  )
}

///|
fn render_native_case_1841() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-3.175802620704463e-43")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-3.175802620704463E-43\"}"),
  )
}

///|
fn render_native_case_1842() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.02473968882698e-180")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.02473968882698E-180\"}"),
  )
}

///|
fn render_native_case_1843() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.700647961345821e-178")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.700647961345821E-178\"}"),
  )
}

///|
fn render_native_case_1844() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.7519755679940974e-248")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.7519755679940974E-248\"}"),
  )
}

///|
fn render_native_case_1845() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.991564570390863e+172")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.991564570390863E172\"}"),
  )
}

///|
fn render_native_case_1846() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.8719444563298936e-17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4.8719444563298936E-17\"}"),
  )
}

///|
fn render_native_case_1847() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.7142630712356782e+306")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.7142630712356782E306\"}"),
  )
}

///|
fn render_native_case_1848() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("5.4478274528249625e+244")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"5.4478274528249625E244\"}"),
  )
}

///|
fn render_native_case_1849() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.4054591081363437e+101")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.4054591081363437E101\"}"),
  )
}

///|
fn render_native_case_1850() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.425592972268534e+24")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.425592972268534E24\"}"),
  )
}

///|
fn render_native_case_1851() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.478476481446157e-25")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.478476481446157E-25\"}"),
  )
}

///|
fn render_native_case_1852() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.2768565291634404e-191")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.2768565291634404E-191\"}"),
  )
}

///|
fn render_native_case_1853() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.561891674868092e-19")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.561891674868092E-19\"}"),
  )
}

///|
fn render_native_case_1854() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.293498634038676e+185")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.293498634038676E185\"}"),
  )
}

///|
fn render_native_case_1855() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.169685419494094e+30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.169685419494094E30\"}"),
  )
}

///|
fn render_native_case_1856() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("6.513476380158421e-260")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"6.513476380158421E-260\"}"),
  )
}

///|
fn render_native_case_1857() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.1161178394320904e-163")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.1161178394320904E-163\"}"),
  )
}

///|
fn render_native_case_1858() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.5021275915784575e+41")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.5021275915784575E41\"}"),
  )
}

///|
fn render_native_case_1859() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.464034104273266e-304")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.464034104273266E-304\"}"),
  )
}

///|
fn render_native_case_1860() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-6.915532602456009e+29")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-6.915532602456009E29\"}"),
  )
}

///|
fn render_native_case_1861() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.6103076784182484e+238")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.6103076784182484E238\"}"),
  )
}

///|
fn render_native_case_1862() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-2.8356575188736873e+112")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-2.8356575188736873E112\"}"),
  )
}

///|
fn render_native_case_1863() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.3626585960235e+92")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.3626585960235E92\"}"),
  )
}

///|
fn render_native_case_1864() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.322353769128887e-145")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.322353769128887E-145\"}"),
  )
}

///|
fn render_native_case_1865() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2980323674163503e+70")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2980323674163503E70\"}"),
  )
}

///|
fn render_native_case_1866() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.35313037103553e-149")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.35313037103553E-149\"}"),
  )
}

///|
fn render_native_case_1867() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.823299814494566e-231")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4.823299814494566E-231\"}"),
  )
}

///|
fn render_native_case_1868() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("8.788723818995914e+189")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"8.788723818995914E189\"}"),
  )
}

///|
fn render_native_case_1869() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.9809514462227256e+30")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.9809514462227256E30\"}"),
  )
}

///|
fn render_native_case_1870() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-7.702647548439949e-88")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-7.702647548439949E-88\"}"),
  )
}

///|
fn render_native_case_1871() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.626580075402924e+233")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.626580075402924E233\"}"),
  )
}

///|
fn render_native_case_1872() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.2125163526330731e+176")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.2125163526330731E176\"}"),
  )
}

///|
fn render_native_case_1873() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("2.2942364208787006e+26")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"2.2942364208787006E26\"}"),
  )
}

///|
fn render_native_case_1874() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("3.7799951732851264e-45")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"3.7799951732851264E-45\"}"),
  )
}

///|
fn render_native_case_1875() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-5.8286114134563555e+13")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-5.8286114134563555E13\"}"),
  )
}

///|
fn render_native_case_1876() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_1877() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_1878() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_1879() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0\"}"))
}

///|
fn render_native_case_1880() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-324\"}"))
}

///|
fn render_native_case_1881() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-324\"}"))
}

///|
fn render_native_case_1882() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"9.9E-324\"}"))
}

///|
fn render_native_case_1883() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-324")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-9.9E-324\"}"))
}

///|
fn render_native_case_1884() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"9.9E-324\"}"))
}

///|
fn render_native_case_1885() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-9.9E-324\"}"))
}

///|
fn render_native_case_1886() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"9.9E-324\"}"))
}

///|
fn render_native_case_1887() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-9.9E-324\"}"))
}

///|
fn render_native_case_1888() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-323\"}"))
}

///|
fn render_native_case_1889() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-323\"}"))
}

///|
fn render_native_case_1890() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"9.9E-323\"}"))
}

///|
fn render_native_case_1891() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-323")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-9.9E-323\"}"))
}

///|
fn render_native_case_1892() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-309\"}"))
}

///|
fn render_native_case_1893() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-309\"}"))
}

///|
fn render_native_case_1894() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-309\"}"))
}

///|
fn render_native_case_1895() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-309\"}"))
}

///|
fn render_native_case_1896() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-309\"}"))
}

///|
fn render_native_case_1897() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-309\"}"))
}

///|
fn render_native_case_1898() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-308\"}"))
}

///|
fn render_native_case_1899() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-309")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-308\"}"))
}

///|
fn render_native_case_1900() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-308\"}"))
}

///|
fn render_native_case_1901() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-308\"}"))
}

///|
fn render_native_case_1902() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000004E-308\"}"),
  )
}

///|
fn render_native_case_1903() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000004E-308\"}"),
  )
}

///|
fn render_native_case_1904() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-308\"}"))
}

///|
fn render_native_case_1905() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-308\"}"))
}

///|
fn render_native_case_1906() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999997E-308\"}"),
  )
}

///|
fn render_native_case_1907() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999997E-308\"}"),
  )
}

///|
fn render_native_case_1908() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-307\"}"))
}

///|
fn render_native_case_1909() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-307\"}"))
}

///|
fn render_native_case_1910() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000001E-307\"}"),
  )
}

///|
fn render_native_case_1911() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000001E-307\"}"),
  )
}

///|
fn render_native_case_1912() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-307\"}"))
}

///|
fn render_native_case_1913() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-307\"}"))
}

///|
fn render_native_case_1914() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999999E-307\"}"),
  )
}

///|
fn render_native_case_1915() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999999E-307\"}"),
  )
}

///|
fn render_native_case_1916() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-100\"}"))
}

///|
fn render_native_case_1917() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-100\"}"))
}

///|
fn render_native_case_1918() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000001E-100\"}"),
  )
}

///|
fn render_native_case_1919() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000001E-100\"}"),
  )
}

///|
fn render_native_case_1920() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-100\"}"))
}

///|
fn render_native_case_1921() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-100\"}"))
}

///|
fn render_native_case_1922() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E-100\"}"),
  )
}

///|
fn render_native_case_1923() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E-100\"}"),
  )
}

///|
fn render_native_case_1924() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-10\"}"))
}

///|
fn render_native_case_1925() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-10\"}"))
}

///|
fn render_native_case_1926() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E-10\"}"),
  )
}

///|
fn render_native_case_1927() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E-10\"}"),
  )
}

///|
fn render_native_case_1928() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-10\"}"))
}

///|
fn render_native_case_1929() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-10\"}"))
}

///|
fn render_native_case_1930() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999999E-10\"}"),
  )
}

///|
fn render_native_case_1931() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-10")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999999E-10\"}"),
  )
}

///|
fn render_native_case_1932() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E-4\"}"))
}

///|
fn render_native_case_1933() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E-4\"}"))
}

///|
fn render_native_case_1934() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E-4\"}"),
  )
}

///|
fn render_native_case_1935() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E-4\"}"),
  )
}

///|
fn render_native_case_1936() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E-4\"}"))
}

///|
fn render_native_case_1937() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E-4\"}"))
}

///|
fn render_native_case_1938() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E-4\"}"),
  )
}

///|
fn render_native_case_1939() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-4")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E-4\"}"),
  )
}

///|
fn render_native_case_1940() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0.001\"}"))
}

///|
fn render_native_case_1941() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-0.001\"}"))
}

///|
fn render_native_case_1942() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0.0010000000000000002\"}"),
  )
}

///|
fn render_native_case_1943() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.0010000000000000002\"}"),
  )
}

///|
fn render_native_case_1944() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0.0049\"}"))
}

///|
fn render_native_case_1945() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-0.0049\"}"))
}

///|
fn render_native_case_1946() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0.009999999999999998\"}"),
  )
}

///|
fn render_native_case_1947() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-3")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.009999999999999998\"}"),
  )
}

///|
fn render_native_case_1948() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0.01\"}"))
}

///|
fn render_native_case_1949() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-0.01\"}"))
}

///|
fn render_native_case_1950() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0.010000000000000002\"}"),
  )
}

///|
fn render_native_case_1951() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.010000000000000002\"}"),
  )
}

///|
fn render_native_case_1952() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"0.049\"}"))
}

///|
fn render_native_case_1953() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-0.049\"}"))
}

///|
fn render_native_case_1954() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"0.09999999999999998\"}"),
  )
}

///|
fn render_native_case_1955() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e-2")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-0.09999999999999998\"}"),
  )
}

///|
fn render_native_case_1956() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1\"}"))
}

///|
fn render_native_case_1957() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1\"}"))
}

///|
fn render_native_case_1958() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002\"}"),
  )
}

///|
fn render_native_case_1959() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002\"}"),
  )
}

///|
fn render_native_case_1960() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9\"}"))
}

///|
fn render_native_case_1961() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9\"}"))
}

///|
fn render_native_case_1962() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998\"}"),
  )
}

///|
fn render_native_case_1963() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e0")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998\"}"),
  )
}

///|
fn render_native_case_1964() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1000000\"}"))
}

///|
fn render_native_case_1965() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1000000\"}"))
}

///|
fn render_native_case_1966() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1000000.0000000002\"}"),
  )
}

///|
fn render_native_case_1967() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1000000.0000000002\"}"),
  )
}

///|
fn render_native_case_1968() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4900000\"}"))
}

///|
fn render_native_case_1969() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4900000\"}"))
}

///|
fn render_native_case_1970() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9999999.999999998\"}"),
  )
}

///|
fn render_native_case_1971() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e6")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9999999.999999998\"}"),
  )
}

///|
fn render_native_case_1972() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"10000000\"}"))
}

///|
fn render_native_case_1973() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-10000000\"}"))
}

///|
fn render_native_case_1974() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E7\"}"),
  )
}

///|
fn render_native_case_1975() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E7\"}"),
  )
}

///|
fn render_native_case_1976() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"49000000\"}"))
}

///|
fn render_native_case_1977() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-49000000\"}"))
}

///|
fn render_native_case_1978() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999999E7\"}"),
  )
}

///|
fn render_native_case_1979() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e7")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999999E7\"}"),
  )
}

///|
fn render_native_case_1980() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"100000000\"}"))
}

///|
fn render_native_case_1981() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-100000000\"}"))
}

///|
fn render_native_case_1982() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000001E8\"}"),
  )
}

///|
fn render_native_case_1983() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000001E8\"}"),
  )
}

///|
fn render_native_case_1984() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"490000000\"}"))
}

///|
fn render_native_case_1985() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-490000000\"}"))
}

///|
fn render_native_case_1986() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E8\"}"),
  )
}

///|
fn render_native_case_1987() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e8")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E8\"}"),
  )
}

///|
fn render_native_case_1988() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1000000000000000\"}"),
  )
}

///|
fn render_native_case_1989() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1000000000000000\"}"),
  )
}

///|
fn render_native_case_1990() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E15\"}"),
  )
}

///|
fn render_native_case_1991() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E15\"}"),
  )
}

///|
fn render_native_case_1992() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"4900000000000000\"}"),
  )
}

///|
fn render_native_case_1993() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-4900000000000000\"}"),
  )
}

///|
fn render_native_case_1994() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9999999999999998\"}"),
  )
}

///|
fn render_native_case_1995() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e15")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9999999999999998\"}"),
  )
}

///|
fn render_native_case_1996() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"10000000000000000\"}"),
  )
}

///|
fn render_native_case_1997() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-10000000000000000\"}"),
  )
}

///|
fn render_native_case_1998() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"10000000000000002\"}"),
  )
}

///|
fn render_native_case_1999() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-10000000000000002\"}"),
  )
}

///|
fn render_native_case_2000() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"49000000000000000\"}"),
  )
}

///|
fn render_native_case_2001() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-49000000000000000\"}"),
  )
}

///|
fn render_native_case_2002() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"99999999999999984\"}"),
  )
}

///|
fn render_native_case_2003() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e16")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-99999999999999984\"}"),
  )
}

///|
fn render_native_case_2004() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"100000000000000000\"}"),
  )
}

///|
fn render_native_case_2005() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-100000000000000000\"}"),
  )
}

///|
fn render_native_case_2006() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"100000000000000016\"}"),
  )
}

///|
fn render_native_case_2007() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-100000000000000016\"}"),
  )
}

///|
fn render_native_case_2008() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"490000000000000000\"}"),
  )
}

///|
fn render_native_case_2009() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-490000000000000000\"}"),
  )
}

///|
fn render_native_case_2010() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"999999999999999744\"}"),
  )
}

///|
fn render_native_case_2011() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e17")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-999999999999999744\"}"),
  )
}

///|
fn render_native_case_2012() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E20\"}"))
}

///|
fn render_native_case_2013() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E20\"}"))
}

///|
fn render_native_case_2014() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E20\"}"),
  )
}

///|
fn render_native_case_2015() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E20\"}"),
  )
}

///|
fn render_native_case_2016() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E20\"}"))
}

///|
fn render_native_case_2017() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E20\"}"))
}

///|
fn render_native_case_2018() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999997E20\"}"),
  )
}

///|
fn render_native_case_2019() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e20")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999997E20\"}"),
  )
}

///|
fn render_native_case_2020() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E21\"}"))
}

///|
fn render_native_case_2021() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E21\"}"))
}

///|
fn render_native_case_2022() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000003E21\"}"),
  )
}

///|
fn render_native_case_2023() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000003E21\"}"),
  )
}

///|
fn render_native_case_2024() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E21\"}"))
}

///|
fn render_native_case_2025() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E21\"}"))
}

///|
fn render_native_case_2026() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E21\"}"),
  )
}

///|
fn render_native_case_2027() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e21")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E21\"}"),
  )
}

///|
fn render_native_case_2028() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E22\"}"))
}

///|
fn render_native_case_2029() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E22\"}"))
}

///|
fn render_native_case_2030() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E22\"}"),
  )
}

///|
fn render_native_case_2031() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E22\"}"),
  )
}

///|
fn render_native_case_2032() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E22\"}"))
}

///|
fn render_native_case_2033() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E22\"}"))
}

///|
fn render_native_case_2034() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999997E22\"}"),
  )
}

///|
fn render_native_case_2035() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e22")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999997E22\"}"),
  )
}

///|
fn render_native_case_2036() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E23\"}"))
}

///|
fn render_native_case_2037() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E23\"}"))
}

///|
fn render_native_case_2038() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000003E23\"}"),
  )
}

///|
fn render_native_case_2039() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000003E23\"}"),
  )
}

///|
fn render_native_case_2040() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E23\"}"))
}

///|
fn render_native_case_2041() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E23\"}"))
}

///|
fn render_native_case_2042() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E23\"}"),
  )
}

///|
fn render_native_case_2043() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e23")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E23\"}"),
  )
}

///|
fn render_native_case_2044() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E100\"}"))
}

///|
fn render_native_case_2045() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E100\"}"))
}

///|
fn render_native_case_2046() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E100\"}"),
  )
}

///|
fn render_native_case_2047() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E100\"}"),
  )
}

///|
fn render_native_case_2048() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E100\"}"))
}

///|
fn render_native_case_2049() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E100\"}"))
}

///|
fn render_native_case_2050() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E100\"}"),
  )
}

///|
fn render_native_case_2051() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e100")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E100\"}"),
  )
}

///|
fn render_native_case_2052() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E307\"}"))
}

///|
fn render_native_case_2053() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E307\"}"))
}

///|
fn render_native_case_2054() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E307\"}"),
  )
}

///|
fn render_native_case_2055() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E307\"}"),
  )
}

///|
fn render_native_case_2056() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"4.9E307\"}"))
}

///|
fn render_native_case_2057() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-4.9E307\"}"))
}

///|
fn render_native_case_2058() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"9.999999999999998E307\"}"),
  )
}

///|
fn render_native_case_2059() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e307")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-9.999999999999998E307\"}"),
  )
}

///|
fn render_native_case_2060() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"1.0E308\"}"))
}

///|
fn render_native_case_2061() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-1.0E308\"}"))
}

///|
fn render_native_case_2062() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("1.0000000000000002e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"1.0000000000000002E308\"}"),
  )
}

///|
fn render_native_case_2063() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-1.0000000000000002e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse("{\"accepted\":true,\"value\":\"-1.0000000000000002E308\"}"),
  )
}

///|
fn render_native_case_2064() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("4.9e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_2065() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-4.9e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_2066() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("9.999999999999998e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"Infinity\"}"))
}

///|
fn render_native_case_2067() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = value_native_create("-9.999999999999998e308")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(actual, @json.parse("{\"accepted\":true,\"value\":\"-Infinity\"}"))
}

///|
fn render_native_case_2068() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"١\\\":1,\\\"01\\\":0,\\\"2\\\":2,\\\"10\\\":10,\\\"a\\\":3,\\\"aa\\\":4,\\\"b\\\":5}\"}",
    ),
  )
}

///|
fn render_native_case_2069() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"١\\\" : 1,\\n    \\\"01\\\" : 0,\\n    \\\"2\\\" : 2,\\n    \\\"10\\\" : 10,\\n    \\\"a\\\" : 3,\\n    \\\"aa\\\" : 4,\\n    \\\"b\\\" : 5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2070() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\"=1,\\\"01\\\"=0,\\\"2\\\"=2,\\\"10\\\"=10,a=3,aa=4,b=5\"}",
    ),
  )
}

///|
fn render_native_case_2071() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\"=1\\n\\\"01\\\"=0\\n\\\"2\\\"=2\\n\\\"10\\\"=10\\na=3\\naa=4\\nb=5\\n\"}",
    ),
  )
}

///|
fn render_native_case_2072() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"١\\\":1,\\\"01\\\":0,\\\"2\\\":2,\\\"10\\\":10,\\\"a\\\":3,\\\"aa\\\":4,\\\"b\\\":5}\"}",
    ),
  )
}

///|
fn render_native_case_2073() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"١\\\" : 1,\\n    \\\"01\\\" : 0,\\n    \\\"2\\\" : 2,\\n    \\\"10\\\" : 10,\\n    \\\"a\\\" : 3,\\n    \\\"aa\\\" : 4,\\n    \\\"b\\\" : 5\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2074() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\"=1,\\\"01\\\"=0,\\\"2\\\"=2,\\\"10\\\"=10,a=3,aa=4,b=5\"}",
    ),
  )
}

///|
fn render_native_case_2075() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse(
      "{\"10\":10,\"2\":2,\"١\":1,\"01\":0,\"a\":3,\"aa\":4,\"b\":5}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"١\\\"=1\\n\\\"01\\\"=0\\n\\\"2\\\"=2\\n\\\"10\\\"=10\\na=3\\naa=4\\nb=5\\n\"}",
    ),
  )
}

///|
fn render_native_case_2076() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"empty\\\":{},\\\"list\\\":[{\\\"a\\\":[1,2]},[{},[]]]}\"}",
    ),
  )
}

///|
fn render_native_case_2077() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"empty\\\" : {},\\n    \\\"list\\\" : [\\n        {\\n            \\\"a\\\" : [\\n                1,\\n                2\\n            ]\\n        },\\n        [\\n            {},\\n            []\\n        ]\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2078() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"empty{},list=[{a=[1,2]},[{},[]]]\"}",
    ),
  )
}

///|
fn render_native_case_2079() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"empty {}\\nlist=[\\n    {\\n        a=[\\n            1,\\n            2\\n        ]\\n    },\\n    [\\n        {},\\n        []\\n    ]\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_2080() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"empty\\\":{},\\\"list\\\":[{\\\"a\\\":[1,2]},[{},[]]]}\"}",
    ),
  )
}

///|
fn render_native_case_2081() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"empty\\\" : {},\\n    \\\"list\\\" : [\\n        {\\n            \\\"a\\\" : [\\n                1,\\n                2\\n            ]\\n        },\\n        [\\n            {},\\n            []\\n        ]\\n    ]\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2082() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"empty{},list=[{a=[1,2]},[{},[]]]\"}",
    ),
  )
}

///|
fn render_native_case_2083() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{empty={},list=[{a=[1,2]},[{},[]]]}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"empty {}\\nlist=[\\n    {\\n        a=[\\n            1,\\n            2\\n        ]\\n    },\\n    [\\n        {},\\n        []\\n    ]\\n]\\n\"}",
    ),
  )
}

///|
fn render_native_case_2084() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}",
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a.b\\\":{\\\"c.d\\\":${\\\"x.y\\\"}},\\\"x.y\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_2085() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}",
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a.b\\\" : {\\n        \\\"c.d\\\" : ${\\\"x.y\\\"}\\n    },\\n    \\\"x.y\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2086() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}",
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\"{\\\"c.d\\\"=${\\\"x.y\\\"}},\\\"x.y\\\"=2\"}",
    ),
  )
}

///|
fn render_native_case_2087() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}",
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\" {\\n    \\\"c.d\\\"=${\\\"x.y\\\"}\\n}\\n\\\"x.y\\\"=2\\n\"}",
    ),
  )
}

///|
fn render_native_case_2088() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a.b\\\":{\\\"c.d\\\":2},\\\"x.y\\\":2}\"}",
    ),
  )
}

///|
fn render_native_case_2089() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a.b\\\" : {\\n        \\\"c.d\\\" : 2\\n    },\\n    \\\"x.y\\\" : 2\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2090() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\"{\\\"c.d\\\"=2},\\\"x.y\\\"=2\"}",
    ),
  )
}

///|
fn render_native_case_2091() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse("{\"a.b\"={\"c.d\"=${\"x.y\"}},\"x.y\"=2}")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"a.b\\\" {\\n    \\\"c.d\\\"=2\\n}\\n\\\"x.y\\\"=2\\n\"}",
    ),
  )
}

///|
fn render_native_case_2092() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":${x},\\\"b\\\":${missing},\\\"list\\\":[${?ENV[]}],\\\"x\\\":1}\"}",
    ),
  )
}

///|
fn render_native_case_2093() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : ${x},\\n    \\\"b\\\" : ${missing},\\n    \\\"list\\\" : [\\n        ${?ENV[]}\\n    ],\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2094() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=${x},b=${missing},list=[${?ENV[]}],x=1\"}",
    ),
  )
}

///|
fn render_native_case_2095() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=${x}\\nb=${missing}\\nlist=[\\n    ${?ENV[]}\\n]\\nx=1\\n\"}",
    ),
  )
}

///|
fn render_native_case_2096() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"a\\\":1,\\\"b\\\":${missing},\\\"list\\\":[],\\\"x\\\":1}\"}",
    ),
  )
}

///|
fn render_native_case_2097() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"a\\\" : 1,\\n    \\\"b\\\" : ${missing},\\n    \\\"list\\\" : [],\\n    \\\"x\\\" : 1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2098() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=1,b=${missing},list=[],x=1\"}",
    ),
  )
}

///|
fn render_native_case_2099() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"a=1\\nb=${missing}\\nlist=[]\\nx=1\\n\"}",
    ),
  )
}

///|
fn render_native_case_2100() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"a\\\":${x},\\\"b\\\":${missing},\\\"list\\\":[${?ENV[]}],\\\"x\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_2101() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"a\\\" : ${x},\\n        \\\"b\\\" : ${missing},\\n        \\\"list\\\" : [\\n            ${?ENV[]}\\n        ],\\n        \\\"x\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2102() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{a=${x},b=${missing},list=[${?ENV[]}],x=1}\"}",
    ),
  )
}

///|
fn render_native_case_2103() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "include \"part\"",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    a=${x}\\n    b=${missing}\\n    list=[\\n        ${?ENV[]}\\n    ]\\n    x=1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2104() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"a\\\":${outer.x},\\\"b\\\":${outer.missing},\\\"list\\\":[${?outer.ENV[]}],\\\"x\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_2105() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"a\\\" : ${outer.x},\\n        \\\"b\\\" : ${outer.missing},\\n        \\\"list\\\" : [\\n            ${?outer.ENV[]}\\n        ],\\n        \\\"x\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2106() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{a=${outer.x},b=${outer.missing},list=[${?outer.ENV[]}],x=1}\"}",
    ),
  )
}

///|
fn render_native_case_2107() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    a=${outer.x}\\n    b=${outer.missing}\\n    list=[\\n        ${?outer.ENV[]}\\n    ]\\n    x=1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2108() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"a\\\":1,\\\"b\\\":${outer.missing},\\\"list\\\":[],\\\"x\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_2109() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"a\\\" : 1,\\n        \\\"b\\\" : ${outer.missing},\\n        \\\"list\\\" : [],\\n        \\\"x\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2110() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{a=1,b=${outer.missing},list=[],x=1}\"}",
    ),
  )
}

///|
fn render_native_case_2111() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    a=1\\n    b=${outer.missing}\\n    list=[]\\n    x=1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2112() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"outer\\\":{\\\"a\\\":${outer.x},\\\"b\\\":${outer.missing},\\\"list\\\":[${?outer.ENV[]}],\\\"x\\\":1}}}\"}",
    ),
  )
}

///|
fn render_native_case_2113() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"outer\\\" : {\\n            \\\"a\\\" : ${outer.x},\\n            \\\"b\\\" : ${outer.missing},\\n            \\\"list\\\" : [\\n                ${?outer.ENV[]}\\n            ],\\n            \\\"x\\\" : 1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2114() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{outer{a=${outer.x},b=${outer.missing},list=[${?outer.ENV[]}],x=1}}\"}",
    ),
  )
}

///|
fn render_native_case_2115() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    outer {\\n        a=${outer.x}\\n        b=${outer.missing}\\n        list=[\\n            ${?outer.ENV[]}\\n        ]\\n        x=1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2116() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.key\\\":{\\\"a\\\":${\\\"outer.key\\\".x},\\\"b\\\":${\\\"outer.key\\\".missing},\\\"list\\\":[${?\\\"outer.key\\\".ENV[]}],\\\"x\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_2117() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.key\\\" : {\\n        \\\"a\\\" : ${\\\"outer.key\\\".x},\\n        \\\"b\\\" : ${\\\"outer.key\\\".missing},\\n        \\\"list\\\" : [\\n            ${?\\\"outer.key\\\".ENV[]}\\n        ],\\n        \\\"x\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2118() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.key\\\"{a=${\\\"outer.key\\\".x},b=${\\\"outer.key\\\".missing},list=[${?\\\"outer.key\\\".ENV[]}],x=1}\"}",
    ),
  )
}

///|
fn render_native_case_2119() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.key\\\" {\\n    a=${\\\"outer.key\\\".x}\\n    b=${\\\"outer.key\\\".missing}\\n    list=[\\n        ${?\\\"outer.key\\\".ENV[]}\\n    ]\\n    x=1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2120() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer.key\\\":{\\\"a\\\":1,\\\"b\\\":${\\\"outer.key\\\".missing},\\\"list\\\":[],\\\"x\\\":1}}\"}",
    ),
  )
}

///|
fn render_native_case_2121() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer.key\\\" : {\\n        \\\"a\\\" : 1,\\n        \\\"b\\\" : ${\\\"outer.key\\\".missing},\\n        \\\"list\\\" : [],\\n        \\\"x\\\" : 1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2122() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.key\\\"{a=1,b=${\\\"outer.key\\\".missing},list=[],x=1}\"}",
    ),
  )
}

///|
fn render_native_case_2123() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"\\\"outer.key\\\" {\\n    a=1\\n    b=${\\\"outer.key\\\".missing}\\n    list=[]\\n    x=1\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2124() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"outer.key\\\":{\\\"a\\\":${\\\"outer.key\\\".x},\\\"b\\\":${\\\"outer.key\\\".missing},\\\"list\\\":[${?\\\"outer.key\\\".ENV[]}],\\\"x\\\":1}}}\"}",
    ),
  )
}

///|
fn render_native_case_2125() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"outer.key\\\" : {\\n            \\\"a\\\" : ${\\\"outer.key\\\".x},\\n            \\\"b\\\" : ${\\\"outer.key\\\".missing},\\n            \\\"list\\\" : [\\n                ${?\\\"outer.key\\\".ENV[]}\\n            ],\\n            \\\"x\\\" : 1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2126() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{\\\"outer.key\\\"{a=${\\\"outer.key\\\".x},b=${\\\"outer.key\\\".missing},list=[${?\\\"outer.key\\\".ENV[]}],x=1}}\"}",
    ),
  )
}

///|
fn render_native_case_2127() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "\"outer.key\" { include \"part\" }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    \\\"outer.key\\\" {\\n        a=${\\\"outer.key\\\".x}\\n        b=${\\\"outer.key\\\".missing}\\n        list=[\\n            ${?\\\"outer.key\\\".ENV[]}\\n        ]\\n        x=1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2128() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":{\\\"a\\\":${outer.inner.x},\\\"b\\\":${outer.inner.missing},\\\"list\\\":[${?outer.inner.ENV[]}],\\\"x\\\":1}}}\"}",
    ),
  )
}

///|
fn render_native_case_2129() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : {\\n            \\\"a\\\" : ${outer.inner.x},\\n            \\\"b\\\" : ${outer.inner.missing},\\n            \\\"list\\\" : [\\n                ${?outer.inner.ENV[]}\\n            ],\\n            \\\"x\\\" : 1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2130() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{inner{a=${outer.inner.x},b=${outer.inner.missing},list=[${?outer.inner.ENV[]}],x=1}}\"}",
    ),
  )
}

///|
fn render_native_case_2131() -> Unit raise {
  let actual = value_native_attempt(() => {
    let value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner {\\n        a=${outer.inner.x}\\n        b=${outer.inner.missing}\\n        list=[\\n            ${?outer.inner.ENV[]}\\n        ]\\n        x=1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2132() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"outer\\\":{\\\"inner\\\":{\\\"a\\\":1,\\\"b\\\":${outer.inner.missing},\\\"list\\\":[],\\\"x\\\":1}}}\"}",
    ),
  )
}

///|
fn render_native_case_2133() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"outer\\\" : {\\n        \\\"inner\\\" : {\\n            \\\"a\\\" : 1,\\n            \\\"b\\\" : ${outer.inner.missing},\\n            \\\"list\\\" : [],\\n            \\\"x\\\" : 1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2134() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer{inner{a=1,b=${outer.inner.missing},list=[],x=1}}\"}",
    ),
  )
}

///|
fn render_native_case_2135() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.resolve(value, allow_unresolved=true)
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"outer {\\n    inner {\\n        a=1\\n        b=${outer.inner.missing}\\n        list=[]\\n        x=1\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2136() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\\"wrapped\\\":{\\\"outer\\\":{\\\"inner\\\":{\\\"a\\\":${outer.inner.x},\\\"b\\\":${outer.inner.missing},\\\"list\\\":[${?outer.inner.ENV[]}],\\\"x\\\":1}}}}\"}",
    ),
  )
}

///|
fn render_native_case_2137() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=true, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"{\\n    \\\"wrapped\\\" : {\\n        \\\"outer\\\" : {\\n            \\\"inner\\\" : {\\n                \\\"a\\\" : ${outer.inner.x},\\n                \\\"b\\\" : ${outer.inner.missing},\\n                \\\"list\\\" : [\\n                    ${?outer.inner.ENV[]}\\n                ],\\n                \\\"x\\\" : 1\\n            }\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
fn render_native_case_2138() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=false).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped{outer{inner{a=${outer.inner.x},b=${outer.inner.missing},list=[${?outer.inner.ENV[]}],x=1}}}\"}",
    ),
  )
}

///|
fn render_native_case_2139() -> Unit raise {
  let actual = value_native_attempt(() => {
    let mut value = @hocon.parse_unresolved(
      "outer { inner { include \"part\" } }",
      includes=Map([("part", "x=1\na=${x}\nb=${missing}\nlist=[${?ENV[]}]")]),
    )
    value = @hocon.at_key(value, "wrapped")
    @hocon.render_value(value, json=false, formatted=true).to_json()
  })
  assert_eq(
    actual,
    @json.parse(
      "{\"accepted\":true,\"value\":\"wrapped {\\n    outer {\\n        inner {\\n            a=${outer.inner.x}\\n            b=${outer.inner.missing}\\n            list=[\\n                ${?outer.inner.ENV[]}\\n            ]\\n            x=1\\n        }\\n    }\\n}\\n\"}",
    ),
  )
}

///|
test "native rendering batch 0" {
  render_native_case_0()
  render_native_case_1()
  render_native_case_2()
  render_native_case_3()
  render_native_case_4()
  render_native_case_5()
  render_native_case_6()
  render_native_case_7()
  render_native_case_8()
  render_native_case_9()
  render_native_case_10()
  render_native_case_11()
  render_native_case_12()
  render_native_case_13()
  render_native_case_14()
  render_native_case_15()
  render_native_case_16()
  render_native_case_17()
  render_native_case_18()
  render_native_case_19()
  render_native_case_20()
  render_native_case_21()
  render_native_case_22()
  render_native_case_23()
  render_native_case_24()
  render_native_case_25()
  render_native_case_26()
  render_native_case_27()
  render_native_case_28()
  render_native_case_29()
  render_native_case_30()
  render_native_case_31()
  render_native_case_32()
  render_native_case_33()
  render_native_case_34()
  render_native_case_35()
  render_native_case_36()
  render_native_case_37()
  render_native_case_38()
  render_native_case_39()
  render_native_case_40()
  render_native_case_41()
  render_native_case_42()
  render_native_case_43()
  render_native_case_44()
  render_native_case_45()
  render_native_case_46()
  render_native_case_47()
  render_native_case_48()
  render_native_case_49()
  render_native_case_50()
  render_native_case_51()
  render_native_case_52()
  render_native_case_53()
  render_native_case_54()
  render_native_case_55()
  render_native_case_56()
  render_native_case_57()
  render_native_case_58()
  render_native_case_59()
  render_native_case_60()
  render_native_case_61()
  render_native_case_62()
  render_native_case_63()
}

///|
test "native rendering batch 1" {
  render_native_case_64()
  render_native_case_65()
  render_native_case_66()
  render_native_case_67()
  render_native_case_68()
  render_native_case_69()
  render_native_case_70()
  render_native_case_71()
  render_native_case_72()
  render_native_case_73()
  render_native_case_74()
  render_native_case_75()
  render_native_case_76()
  render_native_case_77()
  render_native_case_78()
  render_native_case_79()
  render_native_case_80()
  render_native_case_81()
  render_native_case_82()
  render_native_case_83()
  render_native_case_84()
  render_native_case_85()
  render_native_case_86()
  render_native_case_87()
  render_native_case_88()
  render_native_case_89()
  render_native_case_90()
  render_native_case_91()
  render_native_case_92()
  render_native_case_93()
  render_native_case_94()
  render_native_case_95()
  render_native_case_96()
  render_native_case_97()
  render_native_case_98()
  render_native_case_99()
  render_native_case_100()
  render_native_case_101()
  render_native_case_102()
  render_native_case_103()
  render_native_case_104()
  render_native_case_105()
  render_native_case_106()
  render_native_case_107()
  render_native_case_108()
  render_native_case_109()
  render_native_case_110()
  render_native_case_111()
  render_native_case_112()
  render_native_case_113()
  render_native_case_114()
  render_native_case_115()
  render_native_case_116()
  render_native_case_117()
  render_native_case_118()
  render_native_case_119()
  render_native_case_120()
  render_native_case_121()
  render_native_case_122()
  render_native_case_123()
  render_native_case_124()
  render_native_case_125()
  render_native_case_126()
  render_native_case_127()
}

///|
test "native rendering batch 2" {
  render_native_case_128()
  render_native_case_129()
  render_native_case_130()
  render_native_case_131()
  render_native_case_132()
  render_native_case_133()
  render_native_case_134()
  render_native_case_135()
  render_native_case_136()
  render_native_case_137()
  render_native_case_138()
  render_native_case_139()
  render_native_case_140()
  render_native_case_141()
  render_native_case_142()
  render_native_case_143()
  render_native_case_144()
  render_native_case_145()
  render_native_case_146()
  render_native_case_147()
  render_native_case_148()
  render_native_case_149()
  render_native_case_150()
  render_native_case_151()
  render_native_case_152()
  render_native_case_153()
  render_native_case_154()
  render_native_case_155()
  render_native_case_156()
  render_native_case_157()
  render_native_case_158()
  render_native_case_159()
  render_native_case_160()
  render_native_case_161()
  render_native_case_162()
  render_native_case_163()
  render_native_case_164()
  render_native_case_165()
  render_native_case_166()
  render_native_case_167()
  render_native_case_168()
  render_native_case_169()
  render_native_case_170()
  render_native_case_171()
  render_native_case_172()
  render_native_case_173()
  render_native_case_174()
  render_native_case_175()
  render_native_case_176()
  render_native_case_177()
  render_native_case_178()
  render_native_case_179()
  render_native_case_180()
  render_native_case_181()
  render_native_case_182()
  render_native_case_183()
  render_native_case_184()
  render_native_case_185()
  render_native_case_186()
  render_native_case_187()
  render_native_case_188()
  render_native_case_189()
  render_native_case_190()
  render_native_case_191()
}

///|
test "native rendering batch 3" {
  render_native_case_192()
  render_native_case_193()
  render_native_case_194()
  render_native_case_195()
  render_native_case_196()
  render_native_case_197()
  render_native_case_198()
  render_native_case_199()
  render_native_case_200()
  render_native_case_201()
  render_native_case_202()
  render_native_case_203()
  render_native_case_204()
  render_native_case_205()
  render_native_case_206()
  render_native_case_207()
  render_native_case_208()
  render_native_case_209()
  render_native_case_210()
  render_native_case_211()
  render_native_case_212()
  render_native_case_213()
  render_native_case_214()
  render_native_case_215()
  render_native_case_216()
  render_native_case_217()
  render_native_case_218()
  render_native_case_219()
  render_native_case_220()
  render_native_case_221()
  render_native_case_222()
  render_native_case_223()
  render_native_case_224()
  render_native_case_225()
  render_native_case_226()
  render_native_case_227()
  render_native_case_228()
  render_native_case_229()
  render_native_case_230()
  render_native_case_231()
  render_native_case_232()
  render_native_case_233()
  render_native_case_234()
  render_native_case_235()
  render_native_case_236()
  render_native_case_237()
  render_native_case_238()
  render_native_case_239()
  render_native_case_240()
  render_native_case_241()
  render_native_case_242()
  render_native_case_243()
  render_native_case_244()
  render_native_case_245()
  render_native_case_246()
  render_native_case_247()
  render_native_case_248()
  render_native_case_249()
  render_native_case_250()
  render_native_case_251()
  render_native_case_252()
  render_native_case_253()
  render_native_case_254()
  render_native_case_255()
}

///|
test "native rendering batch 4" {
  render_native_case_256()
  render_native_case_257()
  render_native_case_258()
  render_native_case_259()
  render_native_case_260()
  render_native_case_261()
  render_native_case_262()
  render_native_case_263()
  render_native_case_264()
  render_native_case_265()
  render_native_case_266()
  render_native_case_267()
  render_native_case_268()
  render_native_case_269()
  render_native_case_270()
  render_native_case_271()
  render_native_case_272()
  render_native_case_273()
  render_native_case_274()
  render_native_case_275()
  render_native_case_276()
  render_native_case_277()
  render_native_case_278()
  render_native_case_279()
  render_native_case_280()
  render_native_case_281()
  render_native_case_282()
  render_native_case_283()
  render_native_case_284()
  render_native_case_285()
  render_native_case_286()
  render_native_case_287()
  render_native_case_288()
  render_native_case_289()
  render_native_case_290()
  render_native_case_291()
  render_native_case_292()
  render_native_case_293()
  render_native_case_294()
  render_native_case_295()
  render_native_case_296()
  render_native_case_297()
  render_native_case_298()
  render_native_case_299()
  render_native_case_300()
  render_native_case_301()
  render_native_case_302()
  render_native_case_303()
  render_native_case_304()
  render_native_case_305()
  render_native_case_306()
  render_native_case_307()
  render_native_case_308()
  render_native_case_309()
  render_native_case_310()
  render_native_case_311()
  render_native_case_312()
  render_native_case_313()
  render_native_case_314()
  render_native_case_315()
  render_native_case_316()
  render_native_case_317()
  render_native_case_318()
  render_native_case_319()
}

///|
test "native rendering batch 5" {
  render_native_case_320()
  render_native_case_321()
  render_native_case_322()
  render_native_case_323()
  render_native_case_324()
  render_native_case_325()
  render_native_case_326()
  render_native_case_327()
  render_native_case_328()
  render_native_case_329()
  render_native_case_330()
  render_native_case_331()
  render_native_case_332()
  render_native_case_333()
  render_native_case_334()
  render_native_case_335()
  render_native_case_336()
  render_native_case_337()
  render_native_case_338()
  render_native_case_339()
  render_native_case_340()
  render_native_case_341()
  render_native_case_342()
  render_native_case_343()
  render_native_case_344()
  render_native_case_345()
  render_native_case_346()
  render_native_case_347()
  render_native_case_348()
  render_native_case_349()
  render_native_case_350()
  render_native_case_351()
  render_native_case_352()
  render_native_case_353()
  render_native_case_354()
  render_native_case_355()
  render_native_case_356()
  render_native_case_357()
  render_native_case_358()
  render_native_case_359()
  render_native_case_360()
  render_native_case_361()
  render_native_case_362()
  render_native_case_363()
  render_native_case_364()
  render_native_case_365()
  render_native_case_366()
  render_native_case_367()
  render_native_case_368()
  render_native_case_369()
  render_native_case_370()
  render_native_case_371()
  render_native_case_372()
  render_native_case_373()
  render_native_case_374()
  render_native_case_375()
  render_native_case_376()
  render_native_case_377()
  render_native_case_378()
  render_native_case_379()
  render_native_case_380()
  render_native_case_381()
  render_native_case_382()
  render_native_case_383()
}

///|
test "native rendering batch 6" {
  render_native_case_384()
  render_native_case_385()
  render_native_case_386()
  render_native_case_387()
  render_native_case_388()
  render_native_case_389()
  render_native_case_390()
  render_native_case_391()
  render_native_case_392()
  render_native_case_393()
  render_native_case_394()
  render_native_case_395()
  render_native_case_396()
  render_native_case_397()
  render_native_case_398()
  render_native_case_399()
  render_native_case_400()
  render_native_case_401()
  render_native_case_402()
  render_native_case_403()
  render_native_case_404()
  render_native_case_405()
  render_native_case_406()
  render_native_case_407()
  render_native_case_408()
  render_native_case_409()
  render_native_case_410()
  render_native_case_411()
  render_native_case_412()
  render_native_case_413()
  render_native_case_414()
  render_native_case_415()
  render_native_case_416()
  render_native_case_417()
  render_native_case_418()
  render_native_case_419()
  render_native_case_420()
  render_native_case_421()
  render_native_case_422()
  render_native_case_423()
  render_native_case_424()
  render_native_case_425()
  render_native_case_426()
  render_native_case_427()
  render_native_case_428()
  render_native_case_429()
  render_native_case_430()
  render_native_case_431()
  render_native_case_432()
  render_native_case_433()
  render_native_case_434()
  render_native_case_435()
  render_native_case_436()
  render_native_case_437()
  render_native_case_438()
  render_native_case_439()
  render_native_case_440()
  render_native_case_441()
  render_native_case_442()
  render_native_case_443()
  render_native_case_444()
  render_native_case_445()
  render_native_case_446()
  render_native_case_447()
}

///|
test "native rendering batch 7" {
  render_native_case_448()
  render_native_case_449()
  render_native_case_450()
  render_native_case_451()
  render_native_case_452()
  render_native_case_453()
  render_native_case_454()
  render_native_case_455()
  render_native_case_456()
  render_native_case_457()
  render_native_case_458()
  render_native_case_459()
  render_native_case_460()
  render_native_case_461()
  render_native_case_462()
  render_native_case_463()
  render_native_case_464()
  render_native_case_465()
  render_native_case_466()
  render_native_case_467()
  render_native_case_468()
  render_native_case_469()
  render_native_case_470()
  render_native_case_471()
  render_native_case_472()
  render_native_case_473()
  render_native_case_474()
  render_native_case_475()
  render_native_case_476()
  render_native_case_477()
  render_native_case_478()
  render_native_case_479()
  render_native_case_480()
  render_native_case_481()
  render_native_case_482()
  render_native_case_483()
  render_native_case_484()
  render_native_case_485()
  render_native_case_486()
  render_native_case_487()
  render_native_case_488()
  render_native_case_489()
  render_native_case_490()
  render_native_case_491()
  render_native_case_492()
  render_native_case_493()
  render_native_case_494()
  render_native_case_495()
  render_native_case_496()
  render_native_case_497()
  render_native_case_498()
  render_native_case_499()
  render_native_case_500()
  render_native_case_501()
  render_native_case_502()
  render_native_case_503()
  render_native_case_504()
  render_native_case_505()
  render_native_case_506()
  render_native_case_507()
  render_native_case_508()
  render_native_case_509()
  render_native_case_510()
  render_native_case_511()
}

///|
test "native rendering batch 8" {
  render_native_case_512()
  render_native_case_513()
  render_native_case_514()
  render_native_case_515()
  render_native_case_516()
  render_native_case_517()
  render_native_case_518()
  render_native_case_519()
  render_native_case_520()
  render_native_case_521()
  render_native_case_522()
  render_native_case_523()
  render_native_case_524()
  render_native_case_525()
  render_native_case_526()
  render_native_case_527()
  render_native_case_528()
  render_native_case_529()
  render_native_case_530()
  render_native_case_531()
  render_native_case_532()
  render_native_case_533()
  render_native_case_534()
  render_native_case_535()
  render_native_case_536()
  render_native_case_537()
  render_native_case_538()
  render_native_case_539()
  render_native_case_540()
  render_native_case_541()
  render_native_case_542()
  render_native_case_543()
  render_native_case_544()
  render_native_case_545()
  render_native_case_546()
  render_native_case_547()
  render_native_case_548()
  render_native_case_549()
  render_native_case_550()
  render_native_case_551()
  render_native_case_552()
  render_native_case_553()
  render_native_case_554()
  render_native_case_555()
  render_native_case_556()
  render_native_case_557()
  render_native_case_558()
  render_native_case_559()
  render_native_case_560()
  render_native_case_561()
  render_native_case_562()
  render_native_case_563()
  render_native_case_564()
  render_native_case_565()
  render_native_case_566()
  render_native_case_567()
  render_native_case_568()
  render_native_case_569()
  render_native_case_570()
  render_native_case_571()
  render_native_case_572()
  render_native_case_573()
  render_native_case_574()
  render_native_case_575()
}

///|
test "native rendering batch 9" {
  render_native_case_576()
  render_native_case_577()
  render_native_case_578()
  render_native_case_579()
  render_native_case_580()
  render_native_case_581()
  render_native_case_582()
  render_native_case_583()
  render_native_case_584()
  render_native_case_585()
  render_native_case_586()
  render_native_case_587()
  render_native_case_588()
  render_native_case_589()
  render_native_case_590()
  render_native_case_591()
  render_native_case_592()
  render_native_case_593()
  render_native_case_594()
  render_native_case_595()
  render_native_case_596()
  render_native_case_597()
  render_native_case_598()
  render_native_case_599()
  render_native_case_600()
  render_native_case_601()
  render_native_case_602()
  render_native_case_603()
  render_native_case_604()
  render_native_case_605()
  render_native_case_606()
  render_native_case_607()
  render_native_case_608()
  render_native_case_609()
  render_native_case_610()
  render_native_case_611()
  render_native_case_612()
  render_native_case_613()
  render_native_case_614()
  render_native_case_615()
  render_native_case_616()
  render_native_case_617()
  render_native_case_618()
  render_native_case_619()
  render_native_case_620()
  render_native_case_621()
  render_native_case_622()
  render_native_case_623()
  render_native_case_624()
  render_native_case_625()
  render_native_case_626()
  render_native_case_627()
  render_native_case_628()
  render_native_case_629()
  render_native_case_630()
  render_native_case_631()
  render_native_case_632()
  render_native_case_633()
  render_native_case_634()
  render_native_case_635()
  render_native_case_636()
  render_native_case_637()
  render_native_case_638()
  render_native_case_639()
}

///|
test "native rendering batch 10" {
  render_native_case_640()
  render_native_case_641()
  render_native_case_642()
  render_native_case_643()
  render_native_case_644()
  render_native_case_645()
  render_native_case_646()
  render_native_case_647()
  render_native_case_648()
  render_native_case_649()
  render_native_case_650()
  render_native_case_651()
  render_native_case_652()
  render_native_case_653()
  render_native_case_654()
  render_native_case_655()
  render_native_case_656()
  render_native_case_657()
  render_native_case_658()
  render_native_case_659()
  render_native_case_660()
  render_native_case_661()
  render_native_case_662()
  render_native_case_663()
  render_native_case_664()
  render_native_case_665()
  render_native_case_666()
  render_native_case_667()
  render_native_case_668()
  render_native_case_669()
  render_native_case_670()
  render_native_case_671()
  render_native_case_672()
  render_native_case_673()
  render_native_case_674()
  render_native_case_675()
  render_native_case_676()
  render_native_case_677()
  render_native_case_678()
  render_native_case_679()
  render_native_case_680()
  render_native_case_681()
  render_native_case_682()
  render_native_case_683()
  render_native_case_684()
  render_native_case_685()
  render_native_case_686()
  render_native_case_687()
  render_native_case_688()
  render_native_case_689()
  render_native_case_690()
  render_native_case_691()
  render_native_case_692()
  render_native_case_693()
  render_native_case_694()
  render_native_case_695()
  render_native_case_696()
  render_native_case_697()
  render_native_case_698()
  render_native_case_699()
  render_native_case_700()
  render_native_case_701()
  render_native_case_702()
  render_native_case_703()
}

///|
test "native rendering batch 11" {
  render_native_case_704()
  render_native_case_705()
  render_native_case_706()
  render_native_case_707()
  render_native_case_708()
  render_native_case_709()
  render_native_case_710()
  render_native_case_711()
  render_native_case_712()
  render_native_case_713()
  render_native_case_714()
  render_native_case_715()
  render_native_case_716()
  render_native_case_717()
  render_native_case_718()
  render_native_case_719()
  render_native_case_720()
  render_native_case_721()
  render_native_case_722()
  render_native_case_723()
  render_native_case_724()
  render_native_case_725()
  render_native_case_726()
  render_native_case_727()
  render_native_case_728()
  render_native_case_729()
  render_native_case_730()
  render_native_case_731()
  render_native_case_732()
  render_native_case_733()
  render_native_case_734()
  render_native_case_735()
  render_native_case_736()
  render_native_case_737()
  render_native_case_738()
  render_native_case_739()
  render_native_case_740()
  render_native_case_741()
  render_native_case_742()
  render_native_case_743()
  render_native_case_744()
  render_native_case_745()
  render_native_case_746()
  render_native_case_747()
  render_native_case_748()
  render_native_case_749()
  render_native_case_750()
  render_native_case_751()
  render_native_case_752()
  render_native_case_753()
  render_native_case_754()
  render_native_case_755()
  render_native_case_756()
  render_native_case_757()
  render_native_case_758()
  render_native_case_759()
  render_native_case_760()
  render_native_case_761()
  render_native_case_762()
  render_native_case_763()
  render_native_case_764()
  render_native_case_765()
  render_native_case_766()
  render_native_case_767()
}

///|
test "native rendering batch 12" {
  render_native_case_768()
  render_native_case_769()
  render_native_case_770()
  render_native_case_771()
  render_native_case_772()
  render_native_case_773()
  render_native_case_774()
  render_native_case_775()
  render_native_case_776()
  render_native_case_777()
  render_native_case_778()
  render_native_case_779()
  render_native_case_780()
  render_native_case_781()
  render_native_case_782()
  render_native_case_783()
  render_native_case_784()
  render_native_case_785()
  render_native_case_786()
  render_native_case_787()
  render_native_case_788()
  render_native_case_789()
  render_native_case_790()
  render_native_case_791()
  render_native_case_792()
  render_native_case_793()
  render_native_case_794()
  render_native_case_795()
  render_native_case_796()
  render_native_case_797()
  render_native_case_798()
  render_native_case_799()
  render_native_case_800()
  render_native_case_801()
  render_native_case_802()
  render_native_case_803()
  render_native_case_804()
  render_native_case_805()
  render_native_case_806()
  render_native_case_807()
  render_native_case_808()
  render_native_case_809()
  render_native_case_810()
  render_native_case_811()
  render_native_case_812()
  render_native_case_813()
  render_native_case_814()
  render_native_case_815()
  render_native_case_816()
  render_native_case_817()
  render_native_case_818()
  render_native_case_819()
  render_native_case_820()
  render_native_case_821()
  render_native_case_822()
  render_native_case_823()
  render_native_case_824()
  render_native_case_825()
  render_native_case_826()
  render_native_case_827()
  render_native_case_828()
  render_native_case_829()
  render_native_case_830()
  render_native_case_831()
}

///|
test "native rendering batch 13" {
  render_native_case_832()
  render_native_case_833()
  render_native_case_834()
  render_native_case_835()
  render_native_case_836()
  render_native_case_837()
  render_native_case_838()
  render_native_case_839()
  render_native_case_840()
  render_native_case_841()
  render_native_case_842()
  render_native_case_843()
  render_native_case_844()
  render_native_case_845()
  render_native_case_846()
  render_native_case_847()
  render_native_case_848()
  render_native_case_849()
  render_native_case_850()
  render_native_case_851()
  render_native_case_852()
  render_native_case_853()
  render_native_case_854()
  render_native_case_855()
  render_native_case_856()
  render_native_case_857()
  render_native_case_858()
  render_native_case_859()
  render_native_case_860()
  render_native_case_861()
  render_native_case_862()
  render_native_case_863()
  render_native_case_864()
  render_native_case_865()
  render_native_case_866()
  render_native_case_867()
  render_native_case_868()
  render_native_case_869()
  render_native_case_870()
  render_native_case_871()
  render_native_case_872()
  render_native_case_873()
  render_native_case_874()
  render_native_case_875()
  render_native_case_876()
  render_native_case_877()
  render_native_case_878()
  render_native_case_879()
  render_native_case_880()
  render_native_case_881()
  render_native_case_882()
  render_native_case_883()
  render_native_case_884()
  render_native_case_885()
  render_native_case_886()
  render_native_case_887()
  render_native_case_888()
  render_native_case_889()
  render_native_case_890()
  render_native_case_891()
  render_native_case_892()
  render_native_case_893()
  render_native_case_894()
  render_native_case_895()
}

///|
test "native rendering batch 14" {
  render_native_case_896()
  render_native_case_897()
  render_native_case_898()
  render_native_case_899()
  render_native_case_900()
  render_native_case_901()
  render_native_case_902()
  render_native_case_903()
  render_native_case_904()
  render_native_case_905()
  render_native_case_906()
  render_native_case_907()
  render_native_case_908()
  render_native_case_909()
  render_native_case_910()
  render_native_case_911()
  render_native_case_912()
  render_native_case_913()
  render_native_case_914()
  render_native_case_915()
  render_native_case_916()
  render_native_case_917()
  render_native_case_918()
  render_native_case_919()
  render_native_case_920()
  render_native_case_921()
  render_native_case_922()
  render_native_case_923()
  render_native_case_924()
  render_native_case_925()
  render_native_case_926()
  render_native_case_927()
  render_native_case_928()
  render_native_case_929()
  render_native_case_930()
  render_native_case_931()
  render_native_case_932()
  render_native_case_933()
  render_native_case_934()
  render_native_case_935()
  render_native_case_936()
  render_native_case_937()
  render_native_case_938()
  render_native_case_939()
  render_native_case_940()
  render_native_case_941()
  render_native_case_942()
  render_native_case_943()
  render_native_case_944()
  render_native_case_945()
  render_native_case_946()
  render_native_case_947()
  render_native_case_948()
  render_native_case_949()
  render_native_case_950()
  render_native_case_951()
  render_native_case_952()
  render_native_case_953()
  render_native_case_954()
  render_native_case_955()
  render_native_case_956()
  render_native_case_957()
  render_native_case_958()
  render_native_case_959()
}

///|
test "native rendering batch 15" {
  render_native_case_960()
  render_native_case_961()
  render_native_case_962()
  render_native_case_963()
  render_native_case_964()
  render_native_case_965()
  render_native_case_966()
  render_native_case_967()
  render_native_case_968()
  render_native_case_969()
  render_native_case_970()
  render_native_case_971()
  render_native_case_972()
  render_native_case_973()
  render_native_case_974()
  render_native_case_975()
  render_native_case_976()
  render_native_case_977()
  render_native_case_978()
  render_native_case_979()
  render_native_case_980()
  render_native_case_981()
  render_native_case_982()
  render_native_case_983()
  render_native_case_984()
  render_native_case_985()
  render_native_case_986()
  render_native_case_987()
  render_native_case_988()
  render_native_case_989()
  render_native_case_990()
  render_native_case_991()
  render_native_case_992()
  render_native_case_993()
  render_native_case_994()
  render_native_case_995()
  render_native_case_996()
  render_native_case_997()
  render_native_case_998()
  render_native_case_999()
  render_native_case_1000()
  render_native_case_1001()
  render_native_case_1002()
  render_native_case_1003()
  render_native_case_1004()
  render_native_case_1005()
  render_native_case_1006()
  render_native_case_1007()
  render_native_case_1008()
  render_native_case_1009()
  render_native_case_1010()
  render_native_case_1011()
  render_native_case_1012()
  render_native_case_1013()
  render_native_case_1014()
  render_native_case_1015()
  render_native_case_1016()
  render_native_case_1017()
  render_native_case_1018()
  render_native_case_1019()
  render_native_case_1020()
  render_native_case_1021()
  render_native_case_1022()
  render_native_case_1023()
}

///|
test "native rendering batch 16" {
  render_native_case_1024()
  render_native_case_1025()
  render_native_case_1026()
  render_native_case_1027()
  render_native_case_1028()
  render_native_case_1029()
  render_native_case_1030()
  render_native_case_1031()
  render_native_case_1032()
  render_native_case_1033()
  render_native_case_1034()
  render_native_case_1035()
  render_native_case_1036()
  render_native_case_1037()
  render_native_case_1038()
  render_native_case_1039()
  render_native_case_1040()
  render_native_case_1041()
  render_native_case_1042()
  render_native_case_1043()
  render_native_case_1044()
  render_native_case_1045()
  render_native_case_1046()
  render_native_case_1047()
  render_native_case_1048()
  render_native_case_1049()
  render_native_case_1050()
  render_native_case_1051()
  render_native_case_1052()
  render_native_case_1053()
  render_native_case_1054()
  render_native_case_1055()
  render_native_case_1056()
  render_native_case_1057()
  render_native_case_1058()
  render_native_case_1059()
  render_native_case_1060()
  render_native_case_1061()
  render_native_case_1062()
  render_native_case_1063()
  render_native_case_1064()
  render_native_case_1065()
  render_native_case_1066()
  render_native_case_1067()
  render_native_case_1068()
  render_native_case_1069()
  render_native_case_1070()
  render_native_case_1071()
  render_native_case_1072()
  render_native_case_1073()
  render_native_case_1074()
  render_native_case_1075()
  render_native_case_1076()
  render_native_case_1077()
  render_native_case_1078()
  render_native_case_1079()
  render_native_case_1080()
  render_native_case_1081()
  render_native_case_1082()
  render_native_case_1083()
  render_native_case_1084()
  render_native_case_1085()
  render_native_case_1086()
  render_native_case_1087()
}

///|
test "native rendering batch 17" {
  render_native_case_1088()
  render_native_case_1089()
  render_native_case_1090()
  render_native_case_1091()
  render_native_case_1092()
  render_native_case_1093()
  render_native_case_1094()
  render_native_case_1095()
  render_native_case_1096()
  render_native_case_1097()
  render_native_case_1098()
  render_native_case_1099()
  render_native_case_1100()
  render_native_case_1101()
  render_native_case_1102()
  render_native_case_1103()
  render_native_case_1104()
  render_native_case_1105()
  render_native_case_1106()
  render_native_case_1107()
  render_native_case_1108()
  render_native_case_1109()
  render_native_case_1110()
  render_native_case_1111()
  render_native_case_1112()
  render_native_case_1113()
  render_native_case_1114()
  render_native_case_1115()
  render_native_case_1116()
  render_native_case_1117()
  render_native_case_1118()
  render_native_case_1119()
  render_native_case_1120()
  render_native_case_1121()
  render_native_case_1122()
  render_native_case_1123()
  render_native_case_1124()
  render_native_case_1125()
  render_native_case_1126()
  render_native_case_1127()
  render_native_case_1128()
  render_native_case_1129()
  render_native_case_1130()
  render_native_case_1131()
  render_native_case_1132()
  render_native_case_1133()
  render_native_case_1134()
  render_native_case_1135()
  render_native_case_1136()
  render_native_case_1137()
  render_native_case_1138()
  render_native_case_1139()
  render_native_case_1140()
  render_native_case_1141()
  render_native_case_1142()
  render_native_case_1143()
  render_native_case_1144()
  render_native_case_1145()
  render_native_case_1146()
  render_native_case_1147()
  render_native_case_1148()
  render_native_case_1149()
  render_native_case_1150()
  render_native_case_1151()
}

///|
test "native rendering batch 18" {
  render_native_case_1152()
  render_native_case_1153()
  render_native_case_1154()
  render_native_case_1155()
  render_native_case_1156()
  render_native_case_1157()
  render_native_case_1158()
  render_native_case_1159()
  render_native_case_1160()
  render_native_case_1161()
  render_native_case_1162()
  render_native_case_1163()
  render_native_case_1164()
  render_native_case_1165()
  render_native_case_1166()
  render_native_case_1167()
  render_native_case_1168()
  render_native_case_1169()
  render_native_case_1170()
  render_native_case_1171()
  render_native_case_1172()
  render_native_case_1173()
  render_native_case_1174()
  render_native_case_1175()
  render_native_case_1176()
  render_native_case_1177()
  render_native_case_1178()
  render_native_case_1179()
  render_native_case_1180()
  render_native_case_1181()
  render_native_case_1182()
  render_native_case_1183()
  render_native_case_1184()
  render_native_case_1185()
  render_native_case_1186()
  render_native_case_1187()
  render_native_case_1188()
  render_native_case_1189()
  render_native_case_1190()
  render_native_case_1191()
  render_native_case_1192()
  render_native_case_1193()
  render_native_case_1194()
  render_native_case_1195()
  render_native_case_1196()
  render_native_case_1197()
  render_native_case_1198()
  render_native_case_1199()
  render_native_case_1200()
  render_native_case_1201()
  render_native_case_1202()
  render_native_case_1203()
  render_native_case_1204()
  render_native_case_1205()
  render_native_case_1206()
  render_native_case_1207()
  render_native_case_1208()
  render_native_case_1209()
  render_native_case_1210()
  render_native_case_1211()
  render_native_case_1212()
  render_native_case_1213()
  render_native_case_1214()
  render_native_case_1215()
}

///|
test "native rendering batch 19" {
  render_native_case_1216()
  render_native_case_1217()
  render_native_case_1218()
  render_native_case_1219()
  render_native_case_1220()
  render_native_case_1221()
  render_native_case_1222()
  render_native_case_1223()
  render_native_case_1224()
  render_native_case_1225()
  render_native_case_1226()
  render_native_case_1227()
  render_native_case_1228()
  render_native_case_1229()
  render_native_case_1230()
  render_native_case_1231()
  render_native_case_1232()
  render_native_case_1233()
  render_native_case_1234()
  render_native_case_1235()
  render_native_case_1236()
  render_native_case_1237()
  render_native_case_1238()
  render_native_case_1239()
  render_native_case_1240()
  render_native_case_1241()
  render_native_case_1242()
  render_native_case_1243()
  render_native_case_1244()
  render_native_case_1245()
  render_native_case_1246()
  render_native_case_1247()
  render_native_case_1248()
  render_native_case_1249()
  render_native_case_1250()
  render_native_case_1251()
  render_native_case_1252()
  render_native_case_1253()
  render_native_case_1254()
  render_native_case_1255()
  render_native_case_1256()
  render_native_case_1257()
  render_native_case_1258()
  render_native_case_1259()
  render_native_case_1260()
  render_native_case_1261()
  render_native_case_1262()
  render_native_case_1263()
  render_native_case_1264()
  render_native_case_1265()
  render_native_case_1266()
  render_native_case_1267()
  render_native_case_1268()
  render_native_case_1269()
  render_native_case_1270()
  render_native_case_1271()
  render_native_case_1272()
  render_native_case_1273()
  render_native_case_1274()
  render_native_case_1275()
  render_native_case_1276()
  render_native_case_1277()
  render_native_case_1278()
  render_native_case_1279()
}

///|
test "native rendering batch 20" {
  render_native_case_1280()
  render_native_case_1281()
  render_native_case_1282()
  render_native_case_1283()
  render_native_case_1284()
  render_native_case_1285()
  render_native_case_1286()
  render_native_case_1287()
  render_native_case_1288()
  render_native_case_1289()
  render_native_case_1290()
  render_native_case_1291()
  render_native_case_1292()
  render_native_case_1293()
  render_native_case_1294()
  render_native_case_1295()
  render_native_case_1296()
  render_native_case_1297()
  render_native_case_1298()
  render_native_case_1299()
  render_native_case_1300()
  render_native_case_1301()
  render_native_case_1302()
  render_native_case_1303()
  render_native_case_1304()
  render_native_case_1305()
  render_native_case_1306()
  render_native_case_1307()
  render_native_case_1308()
  render_native_case_1309()
  render_native_case_1310()
  render_native_case_1311()
  render_native_case_1312()
  render_native_case_1313()
  render_native_case_1314()
  render_native_case_1315()
  render_native_case_1316()
  render_native_case_1317()
  render_native_case_1318()
  render_native_case_1319()
  render_native_case_1320()
  render_native_case_1321()
  render_native_case_1322()
  render_native_case_1323()
  render_native_case_1324()
  render_native_case_1325()
  render_native_case_1326()
  render_native_case_1327()
  render_native_case_1328()
  render_native_case_1329()
  render_native_case_1330()
  render_native_case_1331()
  render_native_case_1332()
  render_native_case_1333()
  render_native_case_1334()
  render_native_case_1335()
  render_native_case_1336()
  render_native_case_1337()
  render_native_case_1338()
  render_native_case_1339()
  render_native_case_1340()
  render_native_case_1341()
  render_native_case_1342()
  render_native_case_1343()
}

///|
test "native rendering batch 21" {
  render_native_case_1344()
  render_native_case_1345()
  render_native_case_1346()
  render_native_case_1347()
  render_native_case_1348()
  render_native_case_1349()
  render_native_case_1350()
  render_native_case_1351()
  render_native_case_1352()
  render_native_case_1353()
  render_native_case_1354()
  render_native_case_1355()
  render_native_case_1356()
  render_native_case_1357()
  render_native_case_1358()
  render_native_case_1359()
  render_native_case_1360()
  render_native_case_1361()
  render_native_case_1362()
  render_native_case_1363()
  render_native_case_1364()
  render_native_case_1365()
  render_native_case_1366()
  render_native_case_1367()
  render_native_case_1368()
  render_native_case_1369()
  render_native_case_1370()
  render_native_case_1371()
  render_native_case_1372()
  render_native_case_1373()
  render_native_case_1374()
  render_native_case_1375()
  render_native_case_1376()
  render_native_case_1377()
  render_native_case_1378()
  render_native_case_1379()
  render_native_case_1380()
  render_native_case_1381()
  render_native_case_1382()
  render_native_case_1383()
  render_native_case_1384()
  render_native_case_1385()
  render_native_case_1386()
  render_native_case_1387()
  render_native_case_1388()
  render_native_case_1389()
  render_native_case_1390()
  render_native_case_1391()
  render_native_case_1392()
  render_native_case_1393()
  render_native_case_1394()
  render_native_case_1395()
  render_native_case_1396()
  render_native_case_1397()
  render_native_case_1398()
  render_native_case_1399()
  render_native_case_1400()
  render_native_case_1401()
  render_native_case_1402()
  render_native_case_1403()
  render_native_case_1404()
  render_native_case_1405()
  render_native_case_1406()
  render_native_case_1407()
}

///|
test "native rendering batch 22" {
  render_native_case_1408()
  render_native_case_1409()
  render_native_case_1410()
  render_native_case_1411()
  render_native_case_1412()
  render_native_case_1413()
  render_native_case_1414()
  render_native_case_1415()
  render_native_case_1416()
  render_native_case_1417()
  render_native_case_1418()
  render_native_case_1419()
  render_native_case_1420()
  render_native_case_1421()
  render_native_case_1422()
  render_native_case_1423()
  render_native_case_1424()
  render_native_case_1425()
  render_native_case_1426()
  render_native_case_1427()
  render_native_case_1428()
  render_native_case_1429()
  render_native_case_1430()
  render_native_case_1431()
  render_native_case_1432()
  render_native_case_1433()
  render_native_case_1434()
  render_native_case_1435()
  render_native_case_1436()
  render_native_case_1437()
  render_native_case_1438()
  render_native_case_1439()
  render_native_case_1440()
  render_native_case_1441()
  render_native_case_1442()
  render_native_case_1443()
  render_native_case_1444()
  render_native_case_1445()
  render_native_case_1446()
  render_native_case_1447()
  render_native_case_1448()
  render_native_case_1449()
  render_native_case_1450()
  render_native_case_1451()
  render_native_case_1452()
  render_native_case_1453()
  render_native_case_1454()
  render_native_case_1455()
  render_native_case_1456()
  render_native_case_1457()
  render_native_case_1458()
  render_native_case_1459()
  render_native_case_1460()
  render_native_case_1461()
  render_native_case_1462()
  render_native_case_1463()
  render_native_case_1464()
  render_native_case_1465()
  render_native_case_1466()
  render_native_case_1467()
  render_native_case_1468()
  render_native_case_1469()
  render_native_case_1470()
  render_native_case_1471()
}

///|
test "native rendering batch 23" {
  render_native_case_1472()
  render_native_case_1473()
  render_native_case_1474()
  render_native_case_1475()
  render_native_case_1476()
  render_native_case_1477()
  render_native_case_1478()
  render_native_case_1479()
  render_native_case_1480()
  render_native_case_1481()
  render_native_case_1482()
  render_native_case_1483()
  render_native_case_1484()
  render_native_case_1485()
  render_native_case_1486()
  render_native_case_1487()
  render_native_case_1488()
  render_native_case_1489()
  render_native_case_1490()
  render_native_case_1491()
  render_native_case_1492()
  render_native_case_1493()
  render_native_case_1494()
  render_native_case_1495()
  render_native_case_1496()
  render_native_case_1497()
  render_native_case_1498()
  render_native_case_1499()
  render_native_case_1500()
  render_native_case_1501()
  render_native_case_1502()
  render_native_case_1503()
  render_native_case_1504()
  render_native_case_1505()
  render_native_case_1506()
  render_native_case_1507()
  render_native_case_1508()
  render_native_case_1509()
  render_native_case_1510()
  render_native_case_1511()
  render_native_case_1512()
  render_native_case_1513()
  render_native_case_1514()
  render_native_case_1515()
  render_native_case_1516()
  render_native_case_1517()
  render_native_case_1518()
  render_native_case_1519()
  render_native_case_1520()
  render_native_case_1521()
  render_native_case_1522()
  render_native_case_1523()
  render_native_case_1524()
  render_native_case_1525()
  render_native_case_1526()
  render_native_case_1527()
  render_native_case_1528()
  render_native_case_1529()
  render_native_case_1530()
  render_native_case_1531()
  render_native_case_1532()
  render_native_case_1533()
  render_native_case_1534()
  render_native_case_1535()
}

///|
test "native rendering batch 24" {
  render_native_case_1536()
  render_native_case_1537()
  render_native_case_1538()
  render_native_case_1539()
  render_native_case_1540()
  render_native_case_1541()
  render_native_case_1542()
  render_native_case_1543()
  render_native_case_1544()
  render_native_case_1545()
  render_native_case_1546()
  render_native_case_1547()
  render_native_case_1548()
  render_native_case_1549()
  render_native_case_1550()
  render_native_case_1551()
  render_native_case_1552()
  render_native_case_1553()
  render_native_case_1554()
  render_native_case_1555()
  render_native_case_1556()
  render_native_case_1557()
  render_native_case_1558()
  render_native_case_1559()
  render_native_case_1560()
  render_native_case_1561()
  render_native_case_1562()
  render_native_case_1563()
  render_native_case_1564()
  render_native_case_1565()
  render_native_case_1566()
  render_native_case_1567()
  render_native_case_1568()
  render_native_case_1569()
  render_native_case_1570()
  render_native_case_1571()
  render_native_case_1572()
  render_native_case_1573()
  render_native_case_1574()
  render_native_case_1575()
  render_native_case_1576()
  render_native_case_1577()
  render_native_case_1578()
  render_native_case_1579()
  render_native_case_1580()
  render_native_case_1581()
  render_native_case_1582()
  render_native_case_1583()
  render_native_case_1584()
  render_native_case_1585()
  render_native_case_1586()
  render_native_case_1587()
  render_native_case_1588()
  render_native_case_1589()
  render_native_case_1590()
  render_native_case_1591()
  render_native_case_1592()
  render_native_case_1593()
  render_native_case_1594()
  render_native_case_1595()
  render_native_case_1596()
  render_native_case_1597()
  render_native_case_1598()
  render_native_case_1599()
}

///|
test "native rendering batch 25" {
  render_native_case_1600()
  render_native_case_1601()
  render_native_case_1602()
  render_native_case_1603()
  render_native_case_1604()
  render_native_case_1605()
  render_native_case_1606()
  render_native_case_1607()
  render_native_case_1608()
  render_native_case_1609()
  render_native_case_1610()
  render_native_case_1611()
  render_native_case_1612()
  render_native_case_1613()
  render_native_case_1614()
  render_native_case_1615()
  render_native_case_1616()
  render_native_case_1617()
  render_native_case_1618()
  render_native_case_1619()
  render_native_case_1620()
  render_native_case_1621()
  render_native_case_1622()
  render_native_case_1623()
  render_native_case_1624()
  render_native_case_1625()
  render_native_case_1626()
  render_native_case_1627()
  render_native_case_1628()
  render_native_case_1629()
  render_native_case_1630()
  render_native_case_1631()
  render_native_case_1632()
  render_native_case_1633()
  render_native_case_1634()
  render_native_case_1635()
  render_native_case_1636()
  render_native_case_1637()
  render_native_case_1638()
  render_native_case_1639()
  render_native_case_1640()
  render_native_case_1641()
  render_native_case_1642()
  render_native_case_1643()
  render_native_case_1644()
  render_native_case_1645()
  render_native_case_1646()
  render_native_case_1647()
  render_native_case_1648()
  render_native_case_1649()
  render_native_case_1650()
  render_native_case_1651()
  render_native_case_1652()
  render_native_case_1653()
  render_native_case_1654()
  render_native_case_1655()
  render_native_case_1656()
  render_native_case_1657()
  render_native_case_1658()
  render_native_case_1659()
  render_native_case_1660()
  render_native_case_1661()
  render_native_case_1662()
  render_native_case_1663()
}

///|
test "native rendering batch 26" {
  render_native_case_1664()
  render_native_case_1665()
  render_native_case_1666()
  render_native_case_1667()
  render_native_case_1668()
  render_native_case_1669()
  render_native_case_1670()
  render_native_case_1671()
  render_native_case_1672()
  render_native_case_1673()
  render_native_case_1674()
  render_native_case_1675()
  render_native_case_1676()
  render_native_case_1677()
  render_native_case_1678()
  render_native_case_1679()
  render_native_case_1680()
  render_native_case_1681()
  render_native_case_1682()
  render_native_case_1683()
  render_native_case_1684()
  render_native_case_1685()
  render_native_case_1686()
  render_native_case_1687()
  render_native_case_1688()
  render_native_case_1689()
  render_native_case_1690()
  render_native_case_1691()
  render_native_case_1692()
  render_native_case_1693()
  render_native_case_1694()
  render_native_case_1695()
  render_native_case_1696()
  render_native_case_1697()
  render_native_case_1698()
  render_native_case_1699()
  render_native_case_1700()
  render_native_case_1701()
  render_native_case_1702()
  render_native_case_1703()
  render_native_case_1704()
  render_native_case_1705()
  render_native_case_1706()
  render_native_case_1707()
  render_native_case_1708()
  render_native_case_1709()
  render_native_case_1710()
  render_native_case_1711()
  render_native_case_1712()
  render_native_case_1713()
  render_native_case_1714()
  render_native_case_1715()
  render_native_case_1716()
  render_native_case_1717()
  render_native_case_1718()
  render_native_case_1719()
  render_native_case_1720()
  render_native_case_1721()
  render_native_case_1722()
  render_native_case_1723()
  render_native_case_1724()
  render_native_case_1725()
  render_native_case_1726()
  render_native_case_1727()
}

///|
test "native rendering batch 27" {
  render_native_case_1728()
  render_native_case_1729()
  render_native_case_1730()
  render_native_case_1731()
  render_native_case_1732()
  render_native_case_1733()
  render_native_case_1734()
  render_native_case_1735()
  render_native_case_1736()
  render_native_case_1737()
  render_native_case_1738()
  render_native_case_1739()
  render_native_case_1740()
  render_native_case_1741()
  render_native_case_1742()
  render_native_case_1743()
  render_native_case_1744()
  render_native_case_1745()
  render_native_case_1746()
  render_native_case_1747()
  render_native_case_1748()
  render_native_case_1749()
  render_native_case_1750()
  render_native_case_1751()
  render_native_case_1752()
  render_native_case_1753()
  render_native_case_1754()
  render_native_case_1755()
  render_native_case_1756()
  render_native_case_1757()
  render_native_case_1758()
  render_native_case_1759()
  render_native_case_1760()
  render_native_case_1761()
  render_native_case_1762()
  render_native_case_1763()
  render_native_case_1764()
  render_native_case_1765()
  render_native_case_1766()
  render_native_case_1767()
  render_native_case_1768()
  render_native_case_1769()
  render_native_case_1770()
  render_native_case_1771()
  render_native_case_1772()
  render_native_case_1773()
  render_native_case_1774()
  render_native_case_1775()
  render_native_case_1776()
  render_native_case_1777()
  render_native_case_1778()
  render_native_case_1779()
  render_native_case_1780()
  render_native_case_1781()
  render_native_case_1782()
  render_native_case_1783()
  render_native_case_1784()
  render_native_case_1785()
  render_native_case_1786()
  render_native_case_1787()
  render_native_case_1788()
  render_native_case_1789()
  render_native_case_1790()
  render_native_case_1791()
}

///|
test "native rendering batch 28" {
  render_native_case_1792()
  render_native_case_1793()
  render_native_case_1794()
  render_native_case_1795()
  render_native_case_1796()
  render_native_case_1797()
  render_native_case_1798()
  render_native_case_1799()
  render_native_case_1800()
  render_native_case_1801()
  render_native_case_1802()
  render_native_case_1803()
  render_native_case_1804()
  render_native_case_1805()
  render_native_case_1806()
  render_native_case_1807()
  render_native_case_1808()
  render_native_case_1809()
  render_native_case_1810()
  render_native_case_1811()
  render_native_case_1812()
  render_native_case_1813()
  render_native_case_1814()
  render_native_case_1815()
  render_native_case_1816()
  render_native_case_1817()
  render_native_case_1818()
  render_native_case_1819()
  render_native_case_1820()
  render_native_case_1821()
  render_native_case_1822()
  render_native_case_1823()
  render_native_case_1824()
  render_native_case_1825()
  render_native_case_1826()
  render_native_case_1827()
  render_native_case_1828()
  render_native_case_1829()
  render_native_case_1830()
  render_native_case_1831()
  render_native_case_1832()
  render_native_case_1833()
  render_native_case_1834()
  render_native_case_1835()
  render_native_case_1836()
  render_native_case_1837()
  render_native_case_1838()
  render_native_case_1839()
  render_native_case_1840()
  render_native_case_1841()
  render_native_case_1842()
  render_native_case_1843()
  render_native_case_1844()
  render_native_case_1845()
  render_native_case_1846()
  render_native_case_1847()
  render_native_case_1848()
  render_native_case_1849()
  render_native_case_1850()
  render_native_case_1851()
  render_native_case_1852()
  render_native_case_1853()
  render_native_case_1854()
  render_native_case_1855()
}

///|
test "native rendering batch 29" {
  render_native_case_1856()
  render_native_case_1857()
  render_native_case_1858()
  render_native_case_1859()
  render_native_case_1860()
  render_native_case_1861()
  render_native_case_1862()
  render_native_case_1863()
  render_native_case_1864()
  render_native_case_1865()
  render_native_case_1866()
  render_native_case_1867()
  render_native_case_1868()
  render_native_case_1869()
  render_native_case_1870()
  render_native_case_1871()
  render_native_case_1872()
  render_native_case_1873()
  render_native_case_1874()
  render_native_case_1875()
  render_native_case_1876()
  render_native_case_1877()
  render_native_case_1878()
  render_native_case_1879()
  render_native_case_1880()
  render_native_case_1881()
  render_native_case_1882()
  render_native_case_1883()
  render_native_case_1884()
  render_native_case_1885()
  render_native_case_1886()
  render_native_case_1887()
  render_native_case_1888()
  render_native_case_1889()
  render_native_case_1890()
  render_native_case_1891()
  render_native_case_1892()
  render_native_case_1893()
  render_native_case_1894()
  render_native_case_1895()
  render_native_case_1896()
  render_native_case_1897()
  render_native_case_1898()
  render_native_case_1899()
  render_native_case_1900()
  render_native_case_1901()
  render_native_case_1902()
  render_native_case_1903()
  render_native_case_1904()
  render_native_case_1905()
  render_native_case_1906()
  render_native_case_1907()
  render_native_case_1908()
  render_native_case_1909()
  render_native_case_1910()
  render_native_case_1911()
  render_native_case_1912()
  render_native_case_1913()
  render_native_case_1914()
  render_native_case_1915()
  render_native_case_1916()
  render_native_case_1917()
  render_native_case_1918()
  render_native_case_1919()
}

///|
test "native rendering batch 30" {
  render_native_case_1920()
  render_native_case_1921()
  render_native_case_1922()
  render_native_case_1923()
  render_native_case_1924()
  render_native_case_1925()
  render_native_case_1926()
  render_native_case_1927()
  render_native_case_1928()
  render_native_case_1929()
  render_native_case_1930()
  render_native_case_1931()
  render_native_case_1932()
  render_native_case_1933()
  render_native_case_1934()
  render_native_case_1935()
  render_native_case_1936()
  render_native_case_1937()
  render_native_case_1938()
  render_native_case_1939()
  render_native_case_1940()
  render_native_case_1941()
  render_native_case_1942()
  render_native_case_1943()
  render_native_case_1944()
  render_native_case_1945()
  render_native_case_1946()
  render_native_case_1947()
  render_native_case_1948()
  render_native_case_1949()
  render_native_case_1950()
  render_native_case_1951()
  render_native_case_1952()
  render_native_case_1953()
  render_native_case_1954()
  render_native_case_1955()
  render_native_case_1956()
  render_native_case_1957()
  render_native_case_1958()
  render_native_case_1959()
  render_native_case_1960()
  render_native_case_1961()
  render_native_case_1962()
  render_native_case_1963()
  render_native_case_1964()
  render_native_case_1965()
  render_native_case_1966()
  render_native_case_1967()
  render_native_case_1968()
  render_native_case_1969()
  render_native_case_1970()
  render_native_case_1971()
  render_native_case_1972()
  render_native_case_1973()
  render_native_case_1974()
  render_native_case_1975()
  render_native_case_1976()
  render_native_case_1977()
  render_native_case_1978()
  render_native_case_1979()
  render_native_case_1980()
  render_native_case_1981()
  render_native_case_1982()
  render_native_case_1983()
}

///|
test "native rendering batch 31" {
  render_native_case_1984()
  render_native_case_1985()
  render_native_case_1986()
  render_native_case_1987()
  render_native_case_1988()
  render_native_case_1989()
  render_native_case_1990()
  render_native_case_1991()
  render_native_case_1992()
  render_native_case_1993()
  render_native_case_1994()
  render_native_case_1995()
  render_native_case_1996()
  render_native_case_1997()
  render_native_case_1998()
  render_native_case_1999()
  render_native_case_2000()
  render_native_case_2001()
  render_native_case_2002()
  render_native_case_2003()
  render_native_case_2004()
  render_native_case_2005()
  render_native_case_2006()
  render_native_case_2007()
  render_native_case_2008()
  render_native_case_2009()
  render_native_case_2010()
  render_native_case_2011()
  render_native_case_2012()
  render_native_case_2013()
  render_native_case_2014()
  render_native_case_2015()
  render_native_case_2016()
  render_native_case_2017()
  render_native_case_2018()
  render_native_case_2019()
  render_native_case_2020()
  render_native_case_2021()
  render_native_case_2022()
  render_native_case_2023()
  render_native_case_2024()
  render_native_case_2025()
  render_native_case_2026()
  render_native_case_2027()
  render_native_case_2028()
  render_native_case_2029()
  render_native_case_2030()
  render_native_case_2031()
  render_native_case_2032()
  render_native_case_2033()
  render_native_case_2034()
  render_native_case_2035()
  render_native_case_2036()
  render_native_case_2037()
  render_native_case_2038()
  render_native_case_2039()
  render_native_case_2040()
  render_native_case_2041()
  render_native_case_2042()
  render_native_case_2043()
  render_native_case_2044()
  render_native_case_2045()
  render_native_case_2046()
  render_native_case_2047()
}

///|
test "native rendering batch 32" {
  render_native_case_2048()
  render_native_case_2049()
  render_native_case_2050()
  render_native_case_2051()
  render_native_case_2052()
  render_native_case_2053()
  render_native_case_2054()
  render_native_case_2055()
  render_native_case_2056()
  render_native_case_2057()
  render_native_case_2058()
  render_native_case_2059()
  render_native_case_2060()
  render_native_case_2061()
  render_native_case_2062()
  render_native_case_2063()
  render_native_case_2064()
  render_native_case_2065()
  render_native_case_2066()
  render_native_case_2067()
  render_native_case_2068()
  render_native_case_2069()
  render_native_case_2070()
  render_native_case_2071()
  render_native_case_2072()
  render_native_case_2073()
  render_native_case_2074()
  render_native_case_2075()
  render_native_case_2076()
  render_native_case_2077()
  render_native_case_2078()
  render_native_case_2079()
  render_native_case_2080()
  render_native_case_2081()
  render_native_case_2082()
  render_native_case_2083()
  render_native_case_2084()
  render_native_case_2085()
  render_native_case_2086()
  render_native_case_2087()
  render_native_case_2088()
  render_native_case_2089()
  render_native_case_2090()
  render_native_case_2091()
  render_native_case_2092()
  render_native_case_2093()
  render_native_case_2094()
  render_native_case_2095()
  render_native_case_2096()
  render_native_case_2097()
  render_native_case_2098()
  render_native_case_2099()
  render_native_case_2100()
  render_native_case_2101()
  render_native_case_2102()
  render_native_case_2103()
  render_native_case_2104()
  render_native_case_2105()
  render_native_case_2106()
  render_native_case_2107()
  render_native_case_2108()
  render_native_case_2109()
  render_native_case_2110()
  render_native_case_2111()
}

///|
test "native rendering batch 33" {
  render_native_case_2112()
  render_native_case_2113()
  render_native_case_2114()
  render_native_case_2115()
  render_native_case_2116()
  render_native_case_2117()
  render_native_case_2118()
  render_native_case_2119()
  render_native_case_2120()
  render_native_case_2121()
  render_native_case_2122()
  render_native_case_2123()
  render_native_case_2124()
  render_native_case_2125()
  render_native_case_2126()
  render_native_case_2127()
  render_native_case_2128()
  render_native_case_2129()
  render_native_case_2130()
  render_native_case_2131()
  render_native_case_2132()
  render_native_case_2133()
  render_native_case_2134()
  render_native_case_2135()
  render_native_case_2136()
  render_native_case_2137()
  render_native_case_2138()
  render_native_case_2139()
}
