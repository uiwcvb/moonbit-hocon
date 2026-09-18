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
    let config = match callback {
      None => @lib.parse(source, includes~, environment~, fallbacks~)
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
