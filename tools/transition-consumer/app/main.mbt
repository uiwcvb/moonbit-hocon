///|
struct Request {
  before_source : String
  after_source : String
  expected_before : String
  expected_after : String
  approve_copy : Bool
} derive(FromJson)

///|
struct Diagnostic {
  message : String
  position : @hocon.SourcePosition?
} derive(ToJson)

///|
struct Activation {
  decision : String
  active_port : Int
  active_exposed_port : Int
  legacy_accepted : Bool?
  review : @hocon.ConfigTransitionReview?
  diagnostic : Diagnostic?
}

///|
fn[T : ToJson] nullable_json(value : T?) -> Json {
  match value {
    Some(value) => ToJson::to_json(value)
    None => Json::null()
  }
}

///|
fn Activation::to_wire(self : Activation) -> Json {
  Json::object({
    "decision": ToJson::to_json(self.decision),
    "active_port": ToJson::to_json(self.active_port),
    "active_exposed_port": ToJson::to_json(self.active_exposed_port),
    "legacy_accepted": nullable_json(self.legacy_accepted),
    "review": nullable_json(self.review),
    "diagnostic": nullable_json(self.diagnostic),
  })
}

///|
fn keep_after_error(
  before : @hocon.Value,
  diagnostic : Diagnostic,
) -> Activation raise @hocon.ParseError {
  {
    decision: "input-error",
    active_port: @hocon.get_int(before, "service.port"),
    active_exposed_port: @hocon.get_int(before, "exposedPort"),
    legacy_accepted: None,
    review: None,
    diagnostic: Some(diagnostic),
  }
}

///|
fn activate(request : Request) -> Activation raise @hocon.ParseError {
  let before = @hocon.parse(
    request.before_source,
    source_name="consumer-before.conf",
  )
  try {
    let candidate = @hocon.parse(
      request.after_source,
      source_name="consumer-after.conf",
    )
    let paths = if request.approve_copy {
      [["service", "port"], ["exposedPort"]]
    } else {
      [["service", "port"]]
    }
    let plan : Array[@hocon.ConfigTransitionRule] = paths.map(path => {
      path,
      before: Some(@hocon.Number(request.expected_before)),
      after: Some(@hocon.Number(request.expected_after)),
    })
    let review = @hocon.review_config_transition(before, candidate, plan)
    let legacy_rules : Array[@hocon.ConfigChangeRule] = paths.map(path => {
      path,
      kind: "changed",
    })
    let legacy = @hocon.review_config_changes(before, candidate, legacy_rules)
    let active = if review.accepted { candidate } else { before }
    {
      decision: if review.accepted {
        "activated"
      } else {
        "kept"
      },
      active_port: @hocon.get_int(active, "service.port"),
      active_exposed_port: @hocon.get_int(active, "exposedPort"),
      legacy_accepted: Some(legacy.accepted),
      review: Some(review),
      diagnostic: None,
    }
  } catch {
    @hocon.Located(message, position) =>
      keep_after_error(before, { message, position: Some(position), })
    @hocon.Invalid(message) =>
      keep_after_error(before, { message, position: None, })
  }
}

///|
fn main raise {
  let args = @env.args()
  if args.is_empty() {
    abort("provide one JSON rollout request")
  }
  let request : Request = @json.from_json(@json.parse(args[args.length() - 1]))
  println(activate(request).to_wire().stringify())
}
