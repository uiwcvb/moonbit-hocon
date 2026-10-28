///|
pub fn config_review_transition(
  before : ConfigHandle,
  after : ConfigHandle,
  policy : String,
) -> String {
  handle_query(() => {
    @lib.review_config_transition(
      handle_value(before),
      handle_value(after),
      parse_transition_rules(policy),
    ).to_json()
  })
}

///|
fn transition_source(source : Json?) -> @lib.Value? raise {
  match source {
    None => None
    Some(String(text)) => {
      // A root list confines the input to exactly one value, including lists or
      // objects, without allowing an extra assignment to overwrite that value.
      let value = try {
        match @lib.parse_unresolved("[" + text + "\n]") {
          List(values) if values.length() == 1 =>
            @lib.value_unwrapped(values[0])
          _ => raise BadOperation
        }
      } catch {
        _ => raise BadOperation
      }
      Some(value)
    }
    _ => raise BadOperation
  }
}

///|
fn parse_transition_rules(
  policy : String,
) -> Array[@lib.ConfigTransitionRule] raise {
  if policy.length() > 524288 {
    raise BadOperation
  }
  guard @json.parse(policy) is Array(items) else { raise BadOperation }
  if items.length() > 1024 {
    raise BadOperation
  }
  let rules : Array[@lib.ConfigTransitionRule] = []
  for item in items {
    guard item is Object(fields) else { raise BadOperation }
    for key in fields.keys() {
      if key != "path" && key != "beforeSource" && key != "afterSource" {
        raise BadOperation
      }
    }
    guard fields.get("path") is Some(Array(segments)) else {
      raise BadOperation
    }
    let path : Array[String] = []
    for segment in segments {
      guard segment is String(text) else { raise BadOperation }
      path.push(text)
    }
    rules.push({
      path,
      before: transition_source(fields.get("beforeSource")),
      after: transition_source(fields.get("afterSource")),
    })
  }
  rules
}
