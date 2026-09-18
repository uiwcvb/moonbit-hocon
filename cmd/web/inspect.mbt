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
    let source = match request {
      { "source": String(s), .. } => s
      _ => ""
    }
    let includes = string_map(request, "includes")
    let environment = string_map(request, "environment")
    let document = request is { "document": True, .. }
    let fallbacks : Array[String] = match request {
      { "fallbacks": Array(items), .. } =>
        items.map(x => {
          match x {
            String(s) => s
            _ => ""
          }
        })
      _ => []
    }
    let mut config = match callback {
      None =>
        if document {
          @lib.parse_sources_unresolved(
            { name: "<string>", content: source, format: "hocon", },
            includes~,
            object_only=true,
            fallbacks=fallbacks.mapi((i, content) => {
              name: "<fallback " + i.to_string() + ">",
              content,
              format: "hocon",
            }),
          )
        } else {
          @lib.parse_sources(
            { name: "<string>", content: source, format: "hocon", },
            includes~,
            environment~,
            object_only=true,
            fallbacks=fallbacks.mapi((i, content) => {
              name: "<fallback " + i.to_string() + ">",
              content,
              format: "hocon",
            }),
          )
        }
      Some(host) => {
        let loader = fn(
          req : @lib.IncludeRequest,
        ) -> Result[Array[@lib.IncludeSource], String] {
          try {
            let response = @json.parse(host(req.to_json().stringify()))
            match response {
              { "error": String(message), .. } => Err(message)
              Array(sources) => Ok(sources.map(source_json))
              _ => Err("invalid include host response")
            }
          } catch {
            e => Err(Repr(e).to_string())
          }
        }
        let primary = match request {
          { "primary": s, .. } => source_json(s)
          _ =>
            @lib.IncludeSource::{
              name: "<string>",
              content: source,
              format: "hocon",
            }
        }
        let sources = match request {
          { "fallbackSources": Array(sources), .. } => sources.map(source_json)
          _ => []
        }
        if document {
          @lib.parse_sources_unresolved(
            primary,
            loader=Some(loader),
            includes~,
            fallbacks=sources,
            object_only=true,
          )
        } else {
          @lib.parse_sources(
            primary,
            loader=Some(loader),
            includes~,
            environment~,
            fallbacks=sources,
            object_only=true,
          )
        }
      }
    }
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
    let path = match request {
      { "path": String(s), .. } => s
      _ => ""
    }
    let value = match request {
      { "getter": String(kind), .. } =>
        match kind {
          "string" => @lib.get_as_string(config, path).to_json()
          "boolean" => @lib.get_as_bool(config, path).to_json()
          "int" => @lib.get_as_int(config, path).to_json()
          "long" => @lib.get_long(config, path).to_string().to_json()
          "double" => {
            let value = @lib.get_double(config, path)
            if value.is_nan() {
              "NaN".to_json()
            } else if value.is_inf() {
              (if value > 0 { "Infinity" } else { "-Infinity" }).to_json()
            } else {
              value.to_json()
            }
          }
          "duration" => @lib.get_duration(config, path).to_string().to_json()
          "bytes" => @lib.get_bytes(config, path).to_string().to_json()
          "memory" => @lib.get_memory_size(config, path).to_json()
          "string-list" => @lib.get_string_list(config, path).to_json()
          "boolean-list" => @lib.get_bool_list(config, path).to_json()
          "int-list" => @lib.get_int_list(config, path).to_json()
          "long-list" =>
            @lib.get_long_list(config, path).map(n => n.to_string()).to_json()
          "double-list" =>
            @lib.get_double_list(config, path)
            .map(n => {
              if n.is_nan() {
                "NaN".to_json()
              } else if n.is_inf() {
                (if n > 0 { "Infinity" } else { "-Infinity" }).to_json()
              } else {
                n.to_json()
              }
            })
            .to_json()
          "duration-list" =>
            @lib.get_duration_list(config, path)
            .map(n => n.to_string())
            .to_json()
          "bytes-list" =>
            @lib.get_bytes_list(config, path).map(n => n.to_string()).to_json()
          "memory-list" => @lib.get_memory_size_list(config, path).to_json()
          "config" =>
            @json.parse(@lib.get_config(config, path).to_json_string())
          "config-list" =>
            @json.parse(
              @lib.List(@lib.get_config_list(config, path)).to_json_string(),
            )
          "list" =>
            @json.parse(
              @lib.List(@lib.get_as_list(config, path)).to_json_string(),
            )
          "has" => @lib.has_path(config, path).to_json()
          "null" => @lib.get_is_null(config, path).to_json()
          "has-or-null" => @lib.has_path_or_null(config, path).to_json()
          "empty" => @lib.is_empty(config).to_json()
          "json-text" => config.to_json_string().to_json()
          "resolved" => @lib.is_resolved(config).to_json()
          "entries" =>
            @json.parse(@lib.Object(@lib.entry_set(config)).to_json_string())
          "validation" =>
            match request {
              { "referenceSource": String(reference), .. } =>
                @lib.validation_problems(
                  config,
                  @lib.parse(reference),
                  paths=string_array(request, "validationPaths"),
                ).to_json()
              _ => raise BadSource
            }
          "debug" => Repr(config).to_string().to_json()
          "value" =>
            match @lib.get(config, path) {
              Some(v) => @json.parse(v.to_json_string())
              None => raise MissingValue
            }
          _ => raise BadGetter
        }
      _ => @json.parse(config.to_json_string())
    }
    Json::object({ "accepted": true, "value": value }).stringify()
  } catch {
    @lib.ValidationFailed(problems) =>
      Json::object({
        "accepted": false,
        "error": "configuration validation failed",
        "problems": problems.to_json(),
      }).stringify()
    @lib.Located(message, position) =>
      Json::object({
        "accepted": false,
        "error": message,
        "position": position.to_json(),
      }).stringify()
    e =>
      Json::object({ "accepted": false, "error": Repr(e).to_string() }).stringify()
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
