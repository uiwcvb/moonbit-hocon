///|
fn document_state(config : @lib.Value, probes : Array[String]) -> Json raise {
  let fields : Map[String, Json] = Map([])
  let resolved = @lib.is_resolved(config)
  fields["resolved"] = resolved.to_json()
  if resolved {
    fields["value"] = @json.parse(config.to_json_string())
  }
  let result : Map[String, Json] = Map([])
  for path in probes {
    result[path] = try {
      let value = @lib.get_value(config, path)
      Json::object({
        "accepted": true,
        "value": @json.parse(value.to_json_string()),
      })
    } catch {
      _ => Json::object({ "accepted": false })
    }
  }
  fields["probes"] = Json::object(result)
  Json::object(fields)
}

///|
fn document_parse(
  source : String,
  request : Json,
  callback : ((String) -> String)?,
) -> @lib.Value raise {
  let loader = callback.map(host => {
    fn(req : @lib.IncludeRequest) -> Result[Array[@lib.IncludeSource], String] {
      try {
        match @json.parse(host(req.to_json().stringify())) {
          { "error": String(message), .. } => Err(message)
          Array(sources) => Ok(sources.map(source_json))
          _ => Err("invalid include host response")
        }
      } catch {
        e => Err(Repr(e).to_string())
      }
    }
  })
  let name = match request {
    { "primary": { "name": String(name), .. }, .. } => name
    _ => "<string>"
  }
  @lib.parse_sources_unresolved(
    { name, content: source, format: "hocon", },
    includes=string_map(request, "includes"),
    loader~,
    object_only=true,
  )
}

///|
fn document_pipeline(
  initial : @lib.Value,
  request : Json,
  environment : Map[String, String],
  callback : ((String) -> String)?,
) -> Array[Json] raise {
  let probes = string_array(request, "probes")
  if probes.length() > 64 {
    raise BadOperation
  }
  let steps = match request {
    { "steps": Array(steps), .. } => steps
    Object(fields) =>
      if fields.contains("steps") {
        raise BadOperation
      } else {
        []
      }
    _ => raise BadOperation
  }
  if steps.length() > 64 {
    raise BadOperation
  }
  let mut config = initial
  let first = document_state(config, probes)
  let states = [first]
  let mut bytes = first.stringify().length()
  if bytes > 1000000 {
    raise BadOperation
  }
  for step in steps {
    let allow = match step {
      { "allowUnresolved": True, .. } => true
      { "allowUnresolved": False, .. } => false
      Object(fields) =>
        if fields.contains("allowUnresolved") {
          raise BadOperation
        } else {
          false
        }
      _ => raise BadOperation
    }
    config = match step {
      { "op": String("resolve"), .. } =>
        @lib.resolve(config, environment~, allow_unresolved=allow)
      { "op": String("resolve-with-self"), .. } =>
        @lib.resolve_with(config, config, environment~, allow_unresolved=allow)
      { "op": String("resolve-with"), "source": String(source), .. } =>
        @lib.resolve_with(
          config,
          document_parse(source, request, callback),
          environment~,
          allow_unresolved=allow,
        )
      { "op": String("with-fallback"), "source": String(source), .. } =>
        @lib.with_fallback(config, document_parse(source, request, callback))
      {
        "op": String("with-value" | "with-key-value") as op,
        "path": String(path),
        "valueSource": String(source),
        ..
      } => {
        let value = @lib.get_path(
          document_parse("value=" + source, request, callback),
          ["value"],
        )
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
      _ => tree_operation(config, step)
    }
    let state = document_state(config, probes)
    bytes += state.stringify().length()
    if bytes > 1000000 {
      raise BadOperation
    }
    states.push(state)
  }
  states
}
