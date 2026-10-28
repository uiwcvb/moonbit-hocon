///|
fn main raise {
  let before = @hocon.parse("port=8080\ncopy=${port}")
  let after = @hocon.parse("port=9080\ncopy=${port}")
  let plan : Array[@hocon.ConfigTransitionRule] = [
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
  if !@hocon.review_config_transition(before, after, plan).accepted {
    abort("approved transition was rejected")
  }
  if @hocon.review_config_transition(
      before,
      @hocon.parse("port=9081\ncopy=${port}"),
      plan,
    ).accepted {
    abort("wrong target was accepted")
  }
  if @hocon.review_config_transition(
      @hocon.parse("port=8081\ncopy=${port}"),
      after,
      plan,
    ).accepted {
    abort("stale baseline was accepted")
  }
  let exact = @hocon.review_config_transition(
    @hocon.parse("id=9007199254740992"),
    @hocon.parse("id=9007199254740993"),
    [
      {
        path: ["id"],
        before: Some(Number("9007199254740992")),
        after: Some(Number("9007199254740993")),
      },
    ],
  )
  if !exact.accepted {
    abort("exact integer transition changed")
  }
  println("transition review: 4 consumer scenarios passed")
}
