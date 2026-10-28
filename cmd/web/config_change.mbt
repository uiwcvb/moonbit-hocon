///|
pub fn config_review_changes(
  before : ConfigHandle,
  after : ConfigHandle,
  policy : String,
) -> String {
  handle_query(() => {
    @lib.review_config_changes(
      handle_value(before),
      handle_value(after),
      parse_change_rules(policy),
    ).to_json()
  })
}

///|
pub fn config_unused_change_rules(
  before : ConfigHandle,
  after : ConfigHandle,
  policy : String,
) -> String {
  handle_query(() => {
    @lib.unused_config_change_rules(
      handle_value(before),
      handle_value(after),
      parse_change_rules(policy),
    ).to_json()
  })
}

///|
fn parse_change_rules(policy : String) -> Array[@lib.ConfigChangeRule] raise {
  if policy.length() > 524288 {
    raise BadOperation
  }
  guard @json.parse(policy) is Array(items) else { raise BadOperation }
  if items.length() > 1024 {
    raise BadOperation
  }
  let rules : Array[@lib.ConfigChangeRule] = []
  for item in items {
    guard item is Object(fields) && fields.length() == 2 else {
      raise BadOperation
    }
    guard item is { "path": Array(segments), "kind": String(kind), .. } else {
      raise BadOperation
    }
    let path : Array[String] = []
    for segment in segments {
      guard segment is String(text) else { raise BadOperation }
      path.push(text)
    }
    rules.push({ path, kind, })
  }
  rules
}
