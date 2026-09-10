///|
pub(all) enum Value {
  Text(String)
  Number(String)
  Boolean(Bool)
  Null
  List(Array[Value])
  Reference(String)
  PathReference(Array[String], Bool)
  Object(Map[String, Value])
  Concat(Array[(String, Value)])
  DelayedMerge(Value, Value)
} derive(Debug, Eq)

///|
priv struct Work {
  mut remaining : Int
}

///|
fn Work::spend(self : Work, amount : Int) -> Unit raise ParseError {
  self.remaining -= amount
  if self.remaining < 0 {
    raise Invalid("configuration expansion limit")
  }
}

///|
fn uncertain(v : Value) -> Bool {
  match v {
    Reference(_) | PathReference(_, _) | Concat(_) | DelayedMerge(_, _) => true
    _ => false
  }
}

///|
fn merge(a : Value, b : Value) -> Value {
  if uncertain(a) || uncertain(b) {
    return DelayedMerge(a, b)
  }
  match (a, b) {
    (Object(x), Object(y)) => {
      let z = x.copy()
      for k, v in y {
        z[k] = match z.get(k) {
          Some(old) => merge(old, v)
          None => v
        }
      }
      Object(z)
    }
    _ => b
  }
}

///|
fn install(
  m : Map[String, Value],
  keys : Array[String],
  index : Int,
  value : Value,
) -> Unit {
  let k = keys[index]
  if index == keys.length() - 1 {
    m[k] = match m.get(k) {
      Some(old) => merge(old, value)
      None => value
    }
  } else {
    let child = match m.get(k) {
      Some(Object(v)) => v.copy()
      _ => Map([])
    }
    install(child, keys, index + 1, value)
    m[k] = Object(child)
  }
}

///|
fn path(c : Cursor) -> Array[String] raise ParseError {
  let out = []
  while true {
    let t = c.take()
    if !t.quoted &&
      (t.text.is_empty() || t.text.iter().any(ch => !word(ch) && ch != '-')) {
      raise Invalid("path component required")
    }
    let mut part = t.text
    while c.peek() == "-" && c.tokens[c.pos].gap.is_empty() {
      part += c.take().text
      if c.peek() != "." &&
        c.peek() != "=" &&
        c.peek() != ":" &&
        c.peek() != "}" &&
        c.peek() != "{" {
        part += c.take().text
      }
    }
    out.push(part)
    if out.length() > 32 {
      raise Invalid("path depth limit")
    }
    if !c.eat(".") {
      break
    }
  }
  out
}

///|
fn include_name(c : Cursor) -> (String, Bool) raise ParseError {
  let required = c.eat("required")
  if required {
    c.need("(")
  }
  let file = c.eat("file")
  if file {
    c.need("(")
  }
  let token = c.take()
  if !token.quoted {
    raise Invalid("include requires quoted name or file(name)")
  }
  if file {
    c.need(")")
  }
  if required {
    c.need(")")
  }
  (token.text, required)
}

///|
fn skip_lines(c : Cursor) -> Unit {
  while c.eat(";") {

  }
}

///|
fn object(
  c : Cursor,
  sources : Map[String, String],
  active : Array[String],
  depth : Int,
  closing : Bool,
  work : Work,
) -> Value raise ParseError {
  if depth > 32 {
    raise Invalid("nesting/include limit")
  }
  let out : Map[String, Value] = Map([])
  skip_lines(c)
  while c.peek() != "<eof>" && c.peek() != "}" {
    work.spend(1)
    if c.eat("include") {
      let (name, required) = include_name(c)
      if active.contains(name) {
        raise Invalid("include cycle")
      }
      match sources.get(name) {
        None =>
          if required {
            raise Invalid("missing required include " + name)
          }
        Some(source) => {
          work.spend(source.length())
          let next = active.copy()
          next.push(name)
          let nested = lex(source, true)
          skip_lines(nested)
          let brace = nested.eat("{")
          let inc = object(nested, sources, next, depth + 1, brace, work)
          skip_lines(nested)
          if nested.peek() != "<eof>" {
            raise Invalid("include trailing input")
          }
          match inc {
            Object(m) =>
              for k, v in m {
                out[k] = match out.get(k) {
                  Some(old) => merge(old, v)
                  None => v
                }
              }
            _ => raise Invalid("include must be an object")
          }
        }
      }
    } else {
      let keys = path(c)
      if c.peek() != "{" && !c.eat("=") && !c.eat(":") {
        raise Invalid("missing assignment")
      }
      let v = value(c, sources, active, depth + 1, work)
      install(out, keys, 0, v)
    }
    if c.eat(",") {
      skip_lines(c)
    } else if c.eat(";") {
      skip_lines(c)
    } else if c.peek() != "}" && c.peek() != "<eof>" {
      raise Invalid("entries require newline or comma")
    }
    if c.peek() == "," {
      raise Invalid("duplicate comma")
    }
  }
  if closing {
    c.need("}")
  }
  Object(out)
}

///|
fn value_end(c : Cursor) -> Bool {
  [";", ",", "}", "]", "<eof>"].contains(c.peek())
}

///|
fn atom(
  c : Cursor,
  sources : Map[String, String],
  active : Array[String],
  depth : Int,
  work : Work,
) -> Value raise ParseError {
  if depth > 32 {
    raise Invalid("value nesting limit")
  }
  work.spend(1)
  if c.eat("{") {
    return object(c, sources, active, depth + 1, true, work)
  }
  if c.eat("[") {
    let items = []
    skip_lines(c)
    while !c.eat("]") {
      items.push(value(c, sources, active, depth + 1, work))
      if c.eat(",") {
        skip_lines(c)
      } else if c.eat(";") {
        skip_lines(c)
      } else if c.peek() != "]" {
        raise Invalid("array elements require comma or newline")
      }
    }
    return List(items)
  }
  if c.eat("$") {
    c.need("{")
    let optional = c.eat("?")
    let keys = path(c)
    c.need("}")
    return PathReference(keys, optional)
  }
  let token = c.take()
  if token.quoted {
    return Text(token.text)
  }
  let mut text = token.text
  let forbidden = [
    "=", ":", "[", "]", "{", "}", ";", ",", "?", "!", "@", "*", "&", "|", "^", "`",
    "\\", "(", ")",
  ]
  if forbidden.contains(text) || text == "<eof>" {
    raise Invalid("value required or forbidden token")
  }
  while c.pos < c.tokens.length() &&
        c.tokens[c.pos].gap.is_empty() &&
        !c.tokens[c.pos].quoted &&
        !value_end(c) &&
        c.peek() != "$" &&
        c.peek() != "[" &&
        c.peek() != "{" {
    if forbidden.contains(c.peek()) {
      break
    }
    text += c.take().text
  }
  if text == "true" {
    return Boolean(true)
  }
  if text == "false" {
    return Boolean(false)
  }
  if text == "null" {
    return Null
  }
  let decoded = Some(@json.parse(text)) catch { _ => None }
  match decoded {
    Some(Number(_)) => Number(text)
    _ => Text(text)
  }
}

///|
fn value(
  c : Cursor,
  sources : Map[String, String],
  active : Array[String],
  depth : Int,
  work : Work,
) -> Value raise ParseError {
  let parts = [("", atom(c, sources, active, depth, work))]
  while !value_end(c) {
    let gap = c.tokens[c.pos].gap
    parts.push((gap, atom(c, sources, active, depth, work)))
  }
  if parts.length() == 1 {
    parts[0].1
  } else {
    Concat(parts)
  }
}

///|
fn lookup_parts(root : Value, keys : Array[String]) -> Value? {
  let mut current = root
  for part in keys {
    match current {
      Object(m) =>
        match m.get(part) {
          Some(v) => current = v
          None => return None
        }
      _ => return None
    }
  }
  Some(current)
}

///|
fn reference(
  keys : Array[String],
  optional : Bool,
  root : Value,
  chain : Array[Array[String]],
  depth : Int,
  work : Work,
) -> Value? raise ParseError {
  if chain.contains(keys) {
    raise Invalid("substitution cycle")
  }
  let next = chain.copy()
  next.push(keys)
  let mut current = root
  for part in keys {
    let parent = match current {
      Object(_) => Some(current)
      _ => resolve(current, root, next, depth + 1, work)
    }
    match parent {
      Some(Object(m)) =>
        match m.get(part) {
          Some(value) => current = value
          None =>
            if optional {
              return None
            } else {
              raise Invalid("unresolved " + keys.join("."))
            }
        }
      _ =>
        if optional {
          return None
        } else {
          raise Invalid("unresolved " + keys.join("."))
        }
    }
  }
  resolve(current, root, next, depth + 1, work)
}

///|
fn scalar_text(v : Value) -> String raise ParseError {
  match v {
    Text(s) | Number(s) => s
    Boolean(b) => if b { "true" } else { "false" }
    Null => "null"
    _ => raise Invalid("cannot concatenate scalar with object or array")
  }
}

///|
fn resolve(
  v : Value,
  root : Value,
  chain : Array[Array[String]],
  depth : Int,
  work : Work,
) -> Value? raise ParseError {
  if depth > 64 {
    raise Invalid("resolution limit")
  }
  work.spend(1)
  match v {
    Text(_) | Number(_) | Boolean(_) | Null => Some(v)
    Reference(key) =>
      reference(
        key.split(".").map(s => s.to_owned()).collect(),
        false,
        root,
        chain,
        depth,
        work,
      )
    PathReference(keys, optional) =>
      reference(keys, optional, root, chain, depth, work)
    Object(m) => {
      let out = Map([])
      for k, x in m {
        if resolve(x, root, chain, depth + 1, work) is Some(value) {
          out[k] = value
        }
      }
      Some(Object(out))
    }
    List(items) => {
      let out = []
      for item in items {
        if resolve(item, root, chain, depth + 1, work) is Some(value) {
          out.push(value)
        }
      }
      Some(List(out))
    }
    DelayedMerge(a, b) =>
      match resolve(b, root, chain, depth + 1, work) {
        None => resolve(a, root, chain, depth + 1, work)
        Some(Object(m)) =>
          match resolve(a, root, chain, depth + 1, work) {
            Some(old) => Some(merge(old, Object(m)))
            None => Some(Object(m))
          }
        Some(other) => Some(other)
      }
    Concat(parts) => {
      let resolved = []
      for (gap, part) in parts {
        if resolve(part, root, chain, depth + 1, work) is Some(value) {
          resolved.push((gap, value))
        }
      }
      if resolved.is_empty() {
        return None
      }
      let first = resolved[0].1
      match first {
        Object(_) => {
          let mut out = first
          for i in 1..<resolved.length() {
            match resolved[i].1 {
              Object(_) => out = merge(out, resolved[i].1)
              _ => raise Invalid("object concatenation type mismatch")
            }
          }
          Some(out)
        }
        List(items) => {
          let out = items.copy()
          for i in 1..<resolved.length() {
            match resolved[i].1 {
              List(xs) =>
                for x in xs {
                  out.push(x)
                }
              _ => raise Invalid("array concatenation type mismatch")
            }
          }
          work.spend(out.length())
          Some(List(out))
        }
        _ => {
          let mut out = ""
          for (gap, value) in resolved {
            out += gap + scalar_text(value)
            if out.length() > 1000000 {
              raise Invalid("concatenation limit")
            }
          }
          work.spend(out.length())
          Some(Text(out))
        }
      }
    }
  }
}

///|
pub fn parse(
  source : String,
  includes? : Map[String, String] = Map([]),
) -> Value raise ParseError {
  let work = Work::{ remaining: 1000000, }
  work.spend(source.length())
  let c = lex(source, true)
  skip_lines(c)
  let root = if c.peek() == "[" {
    value(c, includes, [], 0, work)
  } else {
    let braced = c.eat("{")
    object(c, includes, [], 0, braced, work)
  }
  skip_lines(c)
  if c.peek() != "<eof>" {
    raise Invalid("trailing input")
  }
  resolve(root, root, [], 0, Work::{ remaining: 200000, }).unwrap()
}

///|
pub fn get(config : Value, key : String) -> Value? {
  lookup_parts(config, key.split(".").map(s => s.to_owned()).collect())
}

///|
/// Explicit components preserve quoted periods: get_path(config, ["a.b", "c"]).
pub fn get_path(config : Value, keys : Array[String]) -> Value? {
  lookup_parts(config, keys)
}
