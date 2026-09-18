///|
fn string_map(j : Json, key : String) -> Map[String, String] {
  let out = Map([])
  if j is Object(fields) && fields.get(key) is Some(Object(m)) {
    for k, v in m {
      if v is String(s) {
        out[k] = s
      }
    }
  }
  out
}

///|
pub fn inspect_json(input : String) -> String {
  inspect_request(input, None)
}

///|
pub fn load_json(input : String, callback : (String) -> String) -> String {
  inspect_request(input, Some(callback))
}

///|
suberror BridgeError {
  BadSource
  BadGetter
  MissingValue
  BadOperation
}

///|
fn source_json(input : Json) -> @lib.IncludeSource raise BridgeError {
  match input {
    {
      "name": String(name),
      "content": String(content),
      "format": String(format),
      ..
    } => { name, content, format, }
    _ => raise BadSource
  }
}

///|
fn inspect_request(input : String, callback : ((String) -> String)?) -> String {
  try {
    let request = @json.parse(input)
    let document = request is { "document": True, .. }
    let environment = string_map(request, "environment")
    let mut config = load_config(request, callback)
    if document {
      return Json::object({
        "accepted": true,
        "value": document_pipeline(config, request, environment, callback).to_json(),
      }).stringify()
    }
    if request is { "operations": Array(operations), .. } {
      if operations.length() > 256 {
        raise BadOperation
      }
      for operation in operations {
        config = tree_operation(config, operation)
      }
    } else if request is Object(fields) && fields.contains("operations") {
      raise BadOperation
    }
    if request
      is { "checkValid": { "source": String(reference), .. } as check, .. } {
      @lib.check_valid(
        config,
        @lib.parse(reference),
        paths=string_array(check, "paths"),
      )
    } else if request is Object(fields) && fields.contains("checkValid") {
      raise BadOperation
    }
    let value = config_getter(config, request)
    Json::object({ "accepted": true, "value": value }).stringify()
  } catch {
    e => bridge_error(e).stringify()
  }
}

///|
fn string_array(input : Json, key : String) -> Array[String] raise BridgeError {
  match input {
    Object(fields) =>
      match fields.get(key) {
        None => []
        Some(Array(items)) =>
          items.map(item => {
            match item {
              String(s) => s
              _ => raise BadOperation
            }
          })
        _ => raise BadOperation
      }
    _ => raise BadOperation
  }
}

///|
fn tree_operation(config : @lib.Value, operation : Json) -> @lib.Value raise {
  match operation {
    { "op": String("with-fallback"), "source": String(source), .. } =>
      @lib.with_fallback(config, @lib.parse(source))
    { "op": String(op), "path": String(path), .. } =>
      match op {
        "without-path" => @lib.without_path(config, path)
        "with-only-path" => @lib.with_only_path(config, path)
        "at-path" => @lib.at_path(config, path)
        "at-key" => @lib.at_key(config, path)
        "without-key" => @lib.without_key(config, path)
        "with-only-key" => @lib.with_only_key(config, path)
        "with-value" | "with-key-value" => {
          let value = match operation {
            { "valueSource": String(source), .. } =>
              @lib.get_path(@lib.parse("value=" + source), ["value"])
            { "value": value, .. } =>
              @lib.get_path(@lib.parse("value=" + value.stringify()), ["value"])
            _ => raise BadOperation
          }
          match value {
            Some(value) =>
              if op == "with-value" {
                @lib.with_value(config, path, value)
              } else {
                @lib.with_key_value(config, path, value)
              }
            None => raise BadOperation
          }
        }
        _ => raise BadOperation
      }
    _ => raise BadOperation
  }
}
