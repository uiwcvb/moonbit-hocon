///|
pub(all) enum Value {
  Text(String)
  Bare(String)
  Number(String)
  Boolean(Bool)
  Null
  List(Array[Value])
  Reference(String)
  PathReference(Array[String], Bool)
  Object(Map[String, Value])
  Concat(Array[(String, Value)])
  DelayedMerge(Value, Value)
  Bound(Array[String], Int, Value)
  Substitution(Array[Array[String]], Bool, Bool, Int)
} derive(Debug, Eq)

///|
pub(all) struct IncludeRequest {
  name : String
  kind : String
  from : String
  required : Bool
} derive(Debug, Eq, ToJson)

///|
pub(all) struct IncludeSource {
  name : String
  content : String
  format : String
} derive(Debug, Eq)

///|
priv struct Work {
  mut remaining : Int
  mut next_id : Int
}

///|
fn Work::spend(self : Work, n : Int) -> Unit raise ParseError {
  self.remaining -= n
  if self.remaining < 0 {
    raise Invalid("configuration expansion limit")
  }
}

///|
fn Work::id(self : Work) -> Int {
  self.next_id += 1
  self.next_id
}

///|
priv struct ParseContext {
  sources : Map[String, String]
  loader : ((IncludeRequest) -> Result[Array[IncludeSource], String])?
  work : Work
}

///|
fn uncertain(v : Value) -> Bool {
  match v {
    Reference(_)
    | PathReference(_, _)
    | Substitution(_, _, _, _)
    | Bound(_, _, _)
    | Concat(_)
    | DelayedMerge(_, _) => true
    _ => false
  }
}

///|
fn merge(a : Value, b : Value) -> Value {
  if !uncertain(b) && !(b is Object(_)) {
    return b
  }
  if uncertain(a) || uncertain(b) {
    return DelayedMerge(a, b)
  }
  match (a, b) {
    (Object(x), Object(y)) => {
      let combined = x.copy()
      for k, v in y {
        combined[k] = match combined.get(k) {
          Some(old) => merge(old, v)
          None => v
        }
      }
      if !has_index_aliases(combined) {
        return Object(combined)
      }
      let keys = Map([])
      for k in object_iteration_keys(y) {
        keys[k] = Null
      }
      for k in object_iteration_keys(x) {
        keys[k] = Null
      }
      let out = Map([])
      for k in object_iteration_keys(keys) {
        out[k] = combined[k]
      }
      Object(out)
    }
    _ => b
  }
}

///|
fn install(
  m : Map[String, Value],
  keys : Array[String],
  index : Int,
  v : Value,
) -> Unit {
  let k = keys[index]
  let patch = if index == keys.length() - 1 {
    v
  } else {
    let child : Map[String, Value] = Map([])
    install(child, keys, index + 1, v)
    Object(child)
  }
  m[k] = match m.get(k) {
    Some(old) => merge(old, patch)
    None => patch
  }
}

///|
fn append_path(a : Array[String], b : Array[String]) -> Array[String] {
  let out = a.copy()
  for s in b {
    out.push(s)
  }
  out
}

///|
fn skip_lines(c : Cursor) -> Unit {
  while c.eat("\n") {

  }
}

///|
fn path(
  c : Cursor,
  substitution? : Bool = false,
) -> Array[String] raise ParseError {
  let parts : Array[String] = []
  let mut current = ""
  let mut present = false
  let mut first = true
  while !c.done() {
    let token = c.tokens[c.pos]
    if !token.quoted &&
      ["\n", "=", ":", "+=", "{", "}", ",", "[", "]", "$", "?"].contains(
        token.text,
      ) {
      break
    }
    c.pos += 1
    if !first {
      current += token.gap
      if !token.gap.is_empty() {
        present = true
      }
    }
    first = false
    if token.quoted {
      current += token.text
      present = true
    } else {
      for ch in token.text {
        if ch == '.' {
          if !present {
            raise Located("empty path component must be quoted", token.position)
          }
          parts.push(current)
          current = ""
          present = false
        } else {
          current += ch.to_string()
          present = true
        }
      }
    }
  }
  if !present {
    raise Located("path component required", c.location())
  }
  parts.push(current)
  if parts.length() > 32 {
    raise Invalid("path depth limit")
  }
  if !substitution && parts[0].is_empty() {
    ()
  }
  parts
}

///|
/// Parse HOCON path expressions, including quoted periods and empty components.
pub fn split_path(text : String) -> Array[String] raise ParseError {
  let c = lex(text, "<path>")
  let result = path(c, substitution=true)
  if !c.done() {
    raise Located("trailing path input", c.location())
  }
  result
}

///|
fn include_request(c : Cursor) -> IncludeRequest raise ParseError {
  skip_lines(c)
  let required = c.eat("required")
  if required {
    skip_lines(c)
    c.need("(")
    skip_lines(c)
  }
  let kind = if ["file", "url", "classpath"].contains(c.peek()) {
    c.take().text
  } else {
    "heuristic"
  }
  if kind != "heuristic" {
    skip_lines(c)
    c.need("(")
    skip_lines(c)
  }
  let token = c.take()
  if !token.quoted {
    raise Located("include requires one quoted resource name", token.position)
  }
  if kind != "heuristic" {
    skip_lines(c)
    c.need(")")
  }
  if required {
    skip_lines(c)
    c.need(")")
  }
  { name: token.text, kind, from: token.position.source, required, }
}

///|
fn parse_source(
  source : IncludeSource,
  context : ParseContext,
  active : Array[String],
  prefix : Array[String],
  scope : Array[String],
  depth : Int,
) -> Value raise ParseError {
  if source.content.length() > 100000 || !valid_unicode(source.content) {
    raise Invalid("excessive or ill-formed source: " + source.name)
  }
  context.work.spend(source.content.length())
  if source.format == "json" {
    let mut nesting = depth
    let mut quoted = false
    let mut escaped = false
    for c in source.content {
      if quoted {
        if escaped {
          escaped = false
        } else if c == '\\' {
          escaped = true
        } else if c == '"' {
          quoted = false
        }
      } else if c == '"' {
        quoted = true
      } else if c == '[' || c == '{' {
        nesting += 1
        if nesting > 32 {
          raise Invalid("JSON source nesting limit: " + source.name)
        }
      } else if c == ']' || c == '}' {
        nesting -= 1
      }
    }
    return configuration_json(source.content, source.name)
  }
  if source.format != "hocon" {
    raise Invalid("unsupported source format: " + source.format)
  }
  let c = lex(source.content, source.name)
  skip_lines(c)
  let result = if c.peek() == "[" {
    value(c, context, active, prefix, scope, depth)
  } else {
    let brace = c.eat("{")
    object(c, context, active, prefix, scope, depth, brace)
  }
  skip_lines(c)
  if !c.done() {
    raise Located("trailing input", c.location())
  }
  result
}

///|
fn object(
  c : Cursor,
  context : ParseContext,
  active : Array[String],
  prefix : Array[String],
  scope : Array[String],
  depth : Int,
  closing : Bool,
) -> Value raise ParseError {
  if depth > 32 {
    raise Invalid("object/include depth limit")
  }
  let out : Map[String, Value] = Map([])
  skip_lines(c)
  while !c.done() && c.peek() != "}" {
    context.work.spend(1)
    if c.eat("include") {
      let req = include_request(c)
      let sources = match context.loader {
        Some(load) =>
          match load(req) {
            Ok(sources) => sources
            Err(message) => raise Invalid(message)
          }
        None =>
          match context.sources.get(req.name) {
            Some(content) => [{ name: req.name, content, format: "hocon", }]
            None => []
          }
      }
      if sources.is_empty() && req.required {
        raise Invalid("missing required include " + req.name)
      }
      for source in sources {
        if active.contains(source.name) {
          raise Invalid("include cycle: " + source.name)
        }
        let next = active.copy()
        next.push(source.name)
        let inc = parse_source(source, context, next, prefix, prefix, depth + 1)
        match inc {
          Object(fields) =>
            for k, v in fields {
              out[k] = match out.get(k) {
                Some(old) => merge(old, v)
                None => v
              }
            }
          _ => raise Invalid("include must contain an object")
        }
      }
    } else {
      let keys = path(c)
      let owner = append_path(prefix, keys)
      let plus = c.eat("+=")
      if !plus && c.peek() != "{" && !c.eat("=") && !c.eat(":") {
        raise Located("missing assignment", c.location())
      }
      skip_lines(c)
      let raw = value(c, context, active, owner, scope, depth + 1)
      let rhs = if plus {
        Concat([
          ("", Substitution([owner], true, false, context.work.id())),
          ("", List([raw])),
        ])
      } else {
        raw
      }
      let rhs = if uncertain(rhs) {
        Bound(owner, context.work.id(), rhs)
      } else {
        rhs
      }
      install(out, keys, 0, rhs)
    }
    if c.eat(",") {
      skip_lines(c)
    } else if c.eat("\n") {
      skip_lines(c)
    } else if !c.done() && c.peek() != "}" {
      raise Located("entries require newline or comma", c.location())
    }
    if c.peek() == "," {
      raise Located("duplicate comma", c.location())
    }
  }
  if closing {
    c.need("}")
  }
  Object(out)
}

///|
fn value_end(c : Cursor) -> Bool {
  c.done() || ["\n", ",", "}", "]"].contains(c.peek())
}

///|
fn atom(
  c : Cursor,
  context : ParseContext,
  active : Array[String],
  prefix : Array[String],
  scope : Array[String],
  depth : Int,
) -> Value raise ParseError {
  if depth > 32 {
    raise Invalid("value nesting limit")
  }
  context.work.spend(1)
  if c.eat("{") {
    return object(c, context, active, prefix, scope, depth + 1, true)
  }
  if c.eat("[") {
    let items = []
    skip_lines(c)
    while !c.eat("]") {
      items.push(value(c, context, active, prefix, scope, depth + 1))
      if c.eat(",") {
        skip_lines(c)
      } else if c.eat("\n") {
        skip_lines(c)
      } else if c.peek() != "]" {
        raise Located("array elements require newline or comma", c.location())
      }
    }
    return List(items)
  }
  if c.eat("$") {
    if c.done() || !c.tokens[c.pos].gap.is_empty() {
      raise Located("substitution requires adjacent ${", c.location())
    }
    c.need("{")
    let optional = if c.peek() == "?" {
      if !c.tokens[c.pos].gap.is_empty() {
        raise Located("optional marker must be adjacent", c.location())
      }
      c.pos += 1
      true
    } else {
      false
    }
    let keys = path(c, substitution=true)
    let list_env = c.eat("[")
    if list_env {
      c.need("]")
    }
    c.need("}")
    let paths = if scope.is_empty() {
      [keys]
    } else {
      [append_path(scope, keys), keys]
    }
    return Substitution(paths, optional, list_env, context.work.id())
  }
  let token = c.take()
  if token.quoted {
    return Text(token.text)
  }
  if ["=", ":", "+=", "[", "]", "{", "}", "\n", ",", "?"].contains(token.text) {
    raise Located("value required", token.position)
  }
  if token.kind == "number" {
    return Number(token.text)
  }
  if token.kind == "boolean" {
    return Boolean(token.text == "true")
  }
  if token.kind == "null" {
    return Null
  }
  let mut text = token.text
  while !c.done() &&
        !value_end(c) &&
        c.tokens[c.pos].gap.is_empty() &&
        !c.tokens[c.pos].quoted &&
        !["number", "boolean", "null"].contains(c.tokens[c.pos].kind) &&
        !["$", "[", "{", "=", ":", "+=", "?"].contains(c.peek()) {
    text += c.take().text
  }
  Bare(text)
}

///|
fn value(
  c : Cursor,
  context : ParseContext,
  active : Array[String],
  prefix : Array[String],
  scope : Array[String],
  depth : Int,
) -> Value raise ParseError {
  let parts = [("", atom(c, context, active, prefix, scope, depth))]
  while !value_end(c) {
    let gap = c.tokens[c.pos].gap
    parts.push((gap, atom(c, context, active, prefix, scope, depth)))
  }
  simplify_concat(parts, context.work)
}

///|
fn from_json(j : Json, numbers : JsonNumbers) -> Value raise ParseError {
  match j {
    String(s) => Text(s)
    Number(_, ..) => {
      let text = numbers.values
        .get(numbers.offset)
        .unwrap_or_else(() => raise Invalid("JSON number spelling mismatch"))
      numbers.offset += 1
      Number(text)
    }
    True => Boolean(true)
    False => Boolean(false)
    Null => Null
    Array(xs) => List(xs.map(value => from_json(value, numbers)))
    Object(m) => {
      let out = Map([])
      for k, v in m {
        out[k] = from_json(v, numbers)
      }
      Object(out)
    }
  }
}

///|
fn lookup_parts(root : Value, keys : Array[String]) -> Value? {
  let mut current = root
  for key in keys {
    match current {
      Object(m) =>
        match m.get(key) {
          Some(v) => current = v
          None => return None
        }
      _ => return None
    }
  }
  Some(current)
}

///|
pub fn get(config : Value, key : String) -> Value? {
  let keys = split_path(key) catch { _ => return None }
  lookup_parts(config, keys)
}

///|
pub fn get_path(config : Value, keys : Array[String]) -> Value? {
  lookup_parts(config, keys)
}

///|
pub fn parse(
  source : String,
  includes? : Map[String, String] = Map([]),
  loader? : ((IncludeRequest) -> Result[Array[IncludeSource], String])? = None,
  source_name? : String = "<string>",
  fallbacks? : Array[String] = [],
  environment? : Map[String, String] = Map([]),
) -> Value raise ParseError {
  parse_sources(
    { name: source_name, content: source, format: "hocon", },
    includes~,
    loader~,
    fallbacks=fallbacks.mapi((i, content) => {
      name: "<fallback " + i.to_string() + ">",
      content,
      format: "hocon",
    }),
    environment~,
  )
}

///|
/// Load ordered sources with explicit origins and a synchronous include host.
pub fn parse_sources(
  source : IncludeSource,
  includes? : Map[String, String] = Map([]),
  loader? : ((IncludeRequest) -> Result[Array[IncludeSource], String])? = None,
  fallbacks? : Array[IncludeSource] = [],
  environment? : Map[String, String] = Map([]),
  object_only? : Bool = false,
) -> Value raise ParseError {
  resolve_document(
    parse_sources_unresolved(
      source,
      includes~,
      loader~,
      fallbacks~,
      object_only~,
    ),
    environment,
  )
}

///|
/// Parse and merge sources without resolving substitutions.
pub fn parse_sources_unresolved(
  source : IncludeSource,
  includes? : Map[String, String] = Map([]),
  loader? : ((IncludeRequest) -> Result[Array[IncludeSource], String])? = None,
  fallbacks? : Array[IncludeSource] = [],
  object_only? : Bool = false,
) -> Value raise ParseError {
  let context : ParseContext = {
    sources: includes,
    loader,
    work: { remaining: 1000000, next_id: 0, },
  }
  let layers = [parse_source(source, context, [source.name], [], [], 0)]
  for source in fallbacks {
    layers.push(parse_source(source, context, [source.name], [], [], 0))
  }
  if object_only {
    for layer in layers {
      if !(layer is Object(_)) {
        raise Invalid("configuration source root must be an object")
      }
    }
  }
  let mut root = layers[layers.length() - 1]
  for i = layers.length() - 2; i >= 0; i = i - 1 {
    root = merge(root, layers[i])
  }
  root
}

///|
pub fn parse_unresolved(
  source : String,
  includes? : Map[String, String] = Map([]),
  loader? : ((IncludeRequest) -> Result[Array[IncludeSource], String])? = None,
  source_name? : String = "<string>",
  fallbacks? : Array[String] = [],
) -> Value raise ParseError {
  parse_sources_unresolved(
    { name: source_name, content: source, format: "hocon", },
    includes~,
    loader~,
    fallbacks=fallbacks.mapi((i, content) => {
      name: "<fallback " + i.to_string() + ">",
      content,
      format: "hocon",
    }),
  )
}

///|
fn simplify_concat(
  parts : Array[(String, Value)],
  work : Work,
) -> Value raise ParseError {
  let result : Array[Value] = []
  let add = fn(v : Value) -> Unit raise ParseError {
    if !result.is_empty() &&
      !uncertain(result[result.length() - 1]) &&
      !uncertain(v) {
      let a = result[result.length() - 1]
      result[result.length() - 1] = match (a, v) {
        (Bare(space), Object(_)) | (Bare(space), List(_)) =>
          if space.iter().all(whitespace) {
            v
          } else {
            raise Invalid("incompatible value concatenation")
          }
        (Object(_), Bare(_)) | (List(_), Bare(_)) => a
        (Object(_), Object(_)) => merge(a, v)
        (List(xs), List(ys)) => {
          let out = xs.copy()
          for y in ys {
            out.push(y)
          }
          work.spend(out.length())
          List(out)
        }
        (Object(_), _) | (List(_), _) | (_, Object(_)) | (_, List(_)) =>
          raise Invalid("incompatible value concatenation")
        _ => {
          let text = scalar_text(a) + scalar_text(v)
          work.spend(text.length())
          Text(text)
        }
      }
    } else {
      result.push(v)
    }
  }
  for (gap, v) in parts {
    if !gap.is_empty() {
      add(Bare(gap))
    }
    add(v)
  }
  if result.length() == 1 {
    result[0]
  } else {
    Concat(result.map(v => ("", v)))
  }
}
