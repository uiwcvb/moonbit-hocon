///|
fn enum_choices(request : Json) -> Map[String, String] raise {
  guard request is { "enumChoices": Array(items), .. } else { raise BadGetter }
  if items.length() > 1024 {
    raise BadGetter
  }
  let result : Map[String, String] = Map([])
  let mut size = 0
  for item in items {
    guard item is String(name) else { raise BadGetter }
    size += name.length()
    if size > 100000 || result.contains(name) {
      raise BadGetter
    }
    result[name] = name
  }
  result
}
