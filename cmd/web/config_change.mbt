///|
pub fn config_review_changes(
  before : ConfigHandle,
  after : ConfigHandle,
  policy : String,
) -> String {
  handle_query(() => {
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
    @lib.review_config_changes(handle_value(before), handle_value(after), rules).to_json()
  })
}
