///|
fn load_config(
  request : Json,
  callback : ((String) -> String)?,
) -> @lib.Value raise {
  let source = match request {
    { "source": String(s), .. } => s
    _ => ""
  }
  let includes = string_map(request, "includes")
  let environment = string_map(request, "environment")
  let document = request is { "document": True, .. }
  let format = match request {
    { "format": String(format), .. } => format
    _ => "hocon"
  }
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
  match callback {
    None =>
      if document {
        @lib.parse_sources_unresolved(
          { name: "<string>", content: source, format, },
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
          { name: "<string>", content: source, format, },
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
}
