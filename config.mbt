///|
pub(all) enum Value {
  Text(String)
  Reference(String)
  Object(Map[String, Value])
} derive(Debug, Eq)

///|
fn merge(a : Value, b : Value) -> Value {
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
  path : Array[String],
  index : Int,
  value : Value,
) -> Unit {
  let k = path[index]
  if index == path.length() - 1 {
    m[k] = match m.get(k) {
      Some(old) => merge(old, value)
      None => value
    }
  } else {
    let child = match m.get(k) {
      Some(Object(v)) => v.copy()
      _ => Map([])
    }
    install(child, path, index + 1, value)
    m[k] = Object(child)
  }
}

///|
fn path(c : Cursor) -> Array[String] raise ParseError {
  let t = c.take()
  if !t.quoted && (t.text == "<eof>" || t.text == "}" || t.text == ";") {
    raise Invalid("key required")
  }
  let out = [t.text]
  if !t.quoted {
    while c.eat(".") {
      out.push(c.take().text)
      if out.length() > 32 {
        raise Invalid("path depth limit")
      }
    }
  }
  out
}

///|
fn object(
  c : Cursor,
  sources : Map[String, String],
  active : Array[String],
  depth : Int,
  closing : Bool,
) -> Value raise ParseError {
  if depth > 32 {
    raise Invalid("nesting/include limit")
  }
  let out : Map[String, Value] = Map([])
  while c.peek() != "<eof>" && c.peek() != "}" {
    if c.eat(";") || c.eat(",") {
      continue
    }
    if c.peek() == "include" && !c.tokens[c.pos].quoted {
      c.pos += 1
      let file = c.take()
      if !file.quoted {
        raise Invalid("include requires quoted in-memory name")
      }
      if active.contains(file.text) {
        raise Invalid("include cycle")
      }
      let source = match sources.get(file.text) {
        Some(s) => s
        None => raise Invalid("missing include " + file.text)
      }
      let nested = lex(source, true)
      let next = active.copy()
      next.push(file.text)
      let brace = nested.eat("{")
      let inc = object(nested, sources, next, depth + 1, brace)
      while nested.eat(";") {

      }
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
        _ => ()
      }
    } else {
      let keys = path(c)
      if c.peek() != "{" && !c.eat("=") && !c.eat(":") {
        raise Invalid("missing assignment")
      }
      let v = if c.eat("{") {
        object(c, sources, active, depth + 1, true)
      } else if c.eat("$") {
        c.need("{")
        let p = path(c)
        c.need("}")
        Reference(p.join("."))
      } else {
        let t = c.take()
        if !t.quoted && (t.text == ";" || t.text == "}" || t.text == "[") {
          raise Invalid("scalar required; arrays unsupported")
        }
        let mut text = t.text
        if !t.quoted && c.eat(".") {
          text += "." + c.take().text
        }
        Text(text)
      }
      install(out, keys, 0, v)
    }
    if c.peek() != "}" &&
      c.peek() != "<eof>" &&
      c.peek() != ";" &&
      c.peek() != "," {
      raise Invalid("entries require newline or comma")
    }
  }
  if closing {
    c.need("}")
  }
  Object(out)
}

///|
fn lookup(root : Value, key : String) -> Value? {
  let mut v = root
  for part in key.split(".") {
    match v {
      Object(m) =>
        match m.get(part.to_owned()) {
          Some(x) => v = x
          None => return None
        }
      _ => return None
    }
  }
  Some(v)
}

///|
fn resolve(
  v : Value,
  root : Value,
  chain : Array[String],
  depth : Int,
) -> Value raise ParseError {
  if depth > 64 {
    raise Invalid("resolution limit")
  }
  match v {
    Text(_) => v
    Reference(key) => {
      if chain.contains(key) {
        raise Invalid("substitution cycle")
      }
      let next = chain.copy()
      next.push(key)
      match lookup(root, key) {
        Some(x) => resolve(x, root, next, depth + 1)
        None => raise Invalid("unresolved " + key)
      }
    }
    Object(m) => {
      let out = Map([])
      for k, x in m {
        out[k] = resolve(x, root, chain, depth + 1)
      }
      Object(out)
    }
  }
}

///|
pub fn parse(
  source : String,
  includes? : Map[String, String] = Map([]),
) -> Value raise ParseError {
  let c = lex(source, true)
  let braced = c.eat("{")
  let root = object(c, includes, [], 0, braced)
  while c.eat(";") {

  }
  if c.peek() != "<eof>" {
    raise Invalid("trailing input")
  }
  resolve(root, root, [], 0)
}

///|
pub fn get(config : Value, key : String) -> Value? {
  lookup(config, key)
}
