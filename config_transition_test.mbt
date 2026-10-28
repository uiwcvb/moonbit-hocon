///|
fn transition_fixture(source : String) -> @hocon.Value raise {
  match @hocon.get_path(@hocon.parse("value=" + source), ["value"]) {
    Some(value) => value
    None => fail("missing test value")
  }
}

///|
test "transition approval binds old and intended values including substitutions" {
  let rules : Array[@hocon.ConfigTransitionRule] = [
    {
      path: ["port"],
      before: Some(Number("8080")),
      after: Some(Number("9080")),
    },
    {
      path: ["copy"],
      before: Some(Number("8080")),
      after: Some(Number("9080")),
    },
  ]
  let before = @hocon.parse("port=8080\ncopy=${port}")
  let intended = @hocon.parse("port=9080\ncopy=${port}")
  assert_true(@hocon.review_config_transition(before, intended, rules).accepted)
  let wrong_target = @hocon.review_config_transition(
    before,
    @hocon.parse("port=9081\ncopy=${port}"),
    rules,
  )
  assert_false(wrong_target.accepted)
  assert_eq(wrong_target.mismatches.map(m => m.side), ["after", "after"])
  let stale = @hocon.review_config_transition(
    @hocon.parse("port=8081\ncopy=${port}"),
    intended,
    rules,
  )
  assert_false(stale.accepted)
  assert_eq(stale.mismatches.map(m => m.side), ["before", "before"])
}

///|
test "transition approval rejects unplanned side effects and unused plans" {
  let rules : Array[@hocon.ConfigTransitionRule] = [
    { path: ["port"], before: Some(Number("1")), after: Some(Number("2")), },
  ]
  let before = @hocon.parse("port=1\ncopy=${port}")
  let after = @hocon.parse("port=2\ncopy=${port}")
  let report = @hocon.review_config_transition(before, after, rules)
  assert_false(report.accepted)
  assert_eq(report.unexpected.map(c => c.path), [["copy"]])
  let unused = @hocon.review_config_transition(before, before, rules)
  assert_false(unused.accepted)
  assert_eq(unused.unused_rules.map(r => r.path), [["port"]])
  assert_true(@hocon.review_config_transition(before, before, []).accepted)
}

///|
test "transition presence distinguishes absent from null" {
  let rules : Array[@hocon.ConfigTransitionRule] = [
    { path: ["added"], before: None, after: Some(Null), },
    { path: ["removed"], before: Some(Null), after: None, },
    { path: ["changed"], before: Some(Null), after: Some(Boolean(true)), },
  ]
  let before = @hocon.parse("removed=null\nchanged=null")
  let after = @hocon.parse("added=null\nchanged=true")
  let report = @hocon.review_config_transition(before, after, rules)
  assert_true(report.accepted)
  assert_eq(report.changes.map(c => c.kind), ["added", "changed", "removed"])
  let wrong = @hocon.review_config_transition(before, after, [
    { path: ["added"], before: Some(Null), after: Some(Boolean(true)), },
  ])
  assert_false(wrong.accepted)
  assert_eq(wrong.unused_rules[0].kind, "changed")
}

///|
test "transition paths preserve literal dots unicode and empty keys" {
  let before = @hocon.parse("\"a.b\"=1\na.b=3\n\"\"=false\n\"中文😀\"=old")
  let after = @hocon.parse("\"a.b\"=2\na.b=3\n\"\"=true\n\"中文😀\"=new")
  let report = @hocon.review_config_transition(before, after, [
    { path: ["a.b"], before: Some(Number("1")), after: Some(Number("2")), },
    { path: [""], before: Some(Boolean(false)), after: Some(Boolean(true)), },
    {
      path: ["中文😀"],
      before: Some(Text("old")),
      after: Some(Text("new")),
    },
  ])
  assert_true(report.accepted)
  assert_eq(@hocon.get_int(before, "a.b"), 3)
}

///|
test "transition lists are atomic and numbers use semantic equality" {
  let rules : Array[@hocon.ConfigTransitionRule] = [
    {
      path: ["items"],
      before: Some(transition_fixture("[1.0,2]")),
      after: Some(transition_fixture("[1,3.0]")),
    },
  ]
  assert_true(
    @hocon.review_config_transition(
      @hocon.parse("items=[1,2]"),
      @hocon.parse("items=[1.0,3]"),
      rules,
    ).accepted,
  )
  let report = @hocon.review_config_transition(
    @hocon.parse("items=[1,2]"),
    @hocon.parse("items=[1,3,4]"),
    rules,
  )
  assert_false(report.accepted)
  assert_eq(report.mismatches[0].side, "after")
}

///|
test "transition object additions use exact diff boundary" {
  let before = @hocon.parse("removed={x=1}")
  let after = @hocon.parse("added={x=2}")
  assert_true(
    @hocon.review_config_transition(before, after, [
      {
        path: ["removed"],
        before: Some(transition_fixture("{x=1}")),
        after: None,
      },
      {
        path: ["added"],
        before: None,
        after: Some(transition_fixture("{x=2}")),
      },
    ]).accepted,
  )
  let wrong = @hocon.review_config_transition(before, after, [
    { path: ["removed", "x"], before: Some(Number("1")), after: None, },
    { path: ["added", "x"], before: None, after: Some(Number("2")), },
  ])
  assert_false(wrong.accepted)
  assert_eq(wrong.unexpected.length(), 2)
  assert_eq(wrong.unused_rules.length(), 2)
}

///|
test "transition approval retains adjacent int64 values" {
  let before = @hocon.parse("id=9007199254740992")
  let after = @hocon.parse("id=9007199254740993")
  assert_true(
    @hocon.review_config_transition(before, after, [
      {
        path: ["id"],
        before: Some(Number("9007199254740992")),
        after: Some(Number("9007199254740993")),
      },
    ]).accepted,
  )
  let wrong = @hocon.review_config_transition(before, after, [
    {
      path: ["id"],
      before: Some(Number("9007199254740992")),
      after: Some(Number("9007199254740994")),
    },
  ])
  assert_false(wrong.accepted)
  assert_eq(wrong.mismatches[0].side, "after")
}

///|
test "transition policy rejects invalid duplicate and oversized rules" {
  let value = @hocon.parse("a=1")
  let valid : @hocon.ConfigTransitionRule = {
    path: ["a"],
    before: Some(Number("1")),
    after: Some(Number("2")),
  }
  let invalid : Array[Array[@hocon.ConfigTransitionRule]] = [
    [{ path: ["a"], before: None, after: None, }],
    [{ path: ["a"], before: Some(Number("1")), after: Some(Number("1.0")), }],
    [valid, valid],
    [{ path: [], before: valid.before, after: valid.after, }],
    [{ path: Array::make(33, "a"), before: valid.before, after: valid.after, }],
    [{ path: ["a".repeat(65537)], before: valid.before, after: valid.after, }],
    Array::make(1025, valid),
  ]
  for rules in invalid {
    assert_true(
      try {
        ignore(@hocon.review_config_transition(value, value, rules))
        false
      } catch {
        _ => true
      },
    )
  }
}

///|
test "transition expected trees must be resolved and share a work budget" {
  let value = @hocon.parse("a=1")
  let rules : Array[@hocon.ConfigTransitionRule] = [
    {
      path: ["a"],
      before: Some(Number("1")),
      after: Some(Reference("secret")),
    },
  ]
  assert_true(
    try {
      ignore(@hocon.review_config_transition(value, value, rules))
      false
    } catch {
      _ => true
    },
  )
  let large : @hocon.Value = Text("x".repeat(600000))
  assert_true(
    try {
      ignore(
        @hocon.review_config_transition(value, value, [
          { path: ["a"], before: Some(large), after: Some(Number("2")), },
          { path: ["b"], before: Some(large), after: Some(Number("3")), },
        ]),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "transition reports contain no expected or actual secret values" {
  let report = @hocon.review_config_transition(
    @hocon.parse("token=old-secret"),
    @hocon.parse("token=actual-secret"),
    [
      {
        path: ["token"],
        before: Some(Text("old-secret")),
        after: Some(Text("approved-secret")),
      },
    ],
  )
  assert_false(report.accepted)
  let json = report.to_json().stringify()
  assert_false(json.contains("old-secret"))
  assert_false(json.contains("actual-secret"))
  assert_false(json.contains("approved-secret"))
  assert_eq(report.mismatches.map(m => m.path), [["token"]])
}

///|
test "transition review does not mutate configurations or rule values" {
  let before = @hocon.parse("items=[{n=1}]")
  let after = @hocon.parse("items=[{n=2}]")
  let expected_before = transition_fixture("[{n=1}]")
  let expected_after = transition_fixture("[{n=2}]")
  let report = @hocon.review_config_transition(before, after, [
    {
      path: ["items"],
      before: Some(expected_before),
      after: Some(expected_after),
    },
  ])
  assert_true(report.accepted)
  assert_true(@hocon.value_equals(before, @hocon.parse("items=[{n=1}]")))
  assert_true(@hocon.value_equals(after, @hocon.parse("items=[{n=2}]")))
  assert_true(
    @hocon.value_equals(expected_after, transition_fixture("[{n=2}]")),
  )
}
