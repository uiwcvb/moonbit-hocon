///|
priv struct Resolver {
  environment : Map[String, String]
  heads : Map[Int, Value?]
  values : Map[Int, Value?]
  active : Array[Int]
  cycles : Array[Int]
  work : Work
}

///|
fn replacement(
  root : Value,
  path : Array[String],
  index : Int,
  value : Value?,
) -> Value {
  if index == path.length() {
    return value.unwrap_or(Object(Map([])))
  }
  match root {
    Object(fields) => {
      let out = fields.copy()
      let key = path[index]
      if index == path.length() - 1 {
        match value {
          Some(v) => out[key] = v
          None => out.remove(key)
        }
      } else if out.get(key) is Some(child) {
        out[key] = replacement(child, path, index + 1, value)
      }
      Object(out)
    }
    _ => root
  }
}

///|
fn owner_of(v : Value, default : Array[String]) -> Array[String] {
  match v {
    Bound(path, _, _) => path
    DelayedMerge(_, b) => owner_of(b, default)
    _ => default
  }
}

///|
fn ancestor(a : Array[String], b : Array[String]) -> Bool {
  if a.length() >= b.length() {
    return false
  }
  for i, p in a {
    if b[i] != p {
      return false
    }
  }
  true
}

///|
fn lookup_resolved(
  r : Resolver,
  root : Value,
  keys : Array[String],
  depth : Int,
) -> Value? raise ParseError {
  let mut current = root
  let path = []
  for part in keys {
    let head = evaluate(r, current, root, path, depth + 1, false, None)
    match head {
      Some(Object(fields)) =>
        match fields.get(part) {
          Some(v) => {
            current = v
            path.push(part)
          }
          None => return None
        }
      _ => return None
    }
  }
  Some(current)
}

///|
fn resolve_reference(
  r : Resolver,
  paths : Array[Array[String]],
  optional : Bool,
  list_env : Bool,
  id : Int,
  root : Value,
  owner : Array[String],
  depth : Int,
  deep : Bool,
) -> Value? raise ParseError {
  let cache = if deep { r.values } else { r.heads }
  if cache.get(id) is Some(result) {
    return result
  }
  if r.active.contains(id) {
    if optional {
      r.cycles.push(id)
      return None
    } else {
      raise Invalid("substitution cycle")
    }
  }
  r.active.push(id)
  defer ignore(r.active.pop())
  let result = {
    let original = paths[paths.length() - 1]
    let name = original.join(".")
    let mut result : Value? = None
    let mut found = false
    for keys in paths {
      if ancestor(keys, owner) {
        if optional {
          found = true
          break
        } else {
          raise Invalid("reference to enclosing object creates a cycle")
        }
      }
      if lookup_resolved(r, root, keys, depth + 1) is Some(target) {
        result = evaluate(r, target, root, keys, depth + 1, deep, None)
        if result != None {
          found = true
          break
        }
      }
    }
    if found {
      result
    } else if list_env {
      let values = []
      let mut i = 0
      while r.environment.get(name + "_" + i.to_string()) is Some(value) {
        r.work.spend(value.length() + 1)
        values.push(Text(value))
        i += 1
      }
      if values.is_empty() {
        None
      } else {
        Some(List(values))
      }
    } else {
      r.environment.get(name).map(s => Text(s))
    }
  }
  let result = if r.cycles.contains(id) { None } else { result }
  if result == None && !optional {
    raise Invalid("unresolved " + paths[paths.length() - 1].join("."))
  }
  cache[id] = result
  result
}

///|
fn scalar_text(v : Value) -> String raise ParseError {
  match v {
    Text(s) | Bare(s) | Number(s) => s
    Boolean(b) => if b { "true" } else { "false" }
    Null => "null"
    _ => raise Invalid("cannot concatenate scalar with object or array")
  }
}

///|
fn evaluate(
  r : Resolver,
  v : Value,
  root : Value,
  owner : Array[String],
  depth : Int,
  deep : Bool,
  lower : Value?,
) -> Value? raise ParseError {
  if depth > 128 {
    raise Invalid("resolution depth limit")
  }
  r.work.spend(1)
  match v {
    Text(_) | Bare(_) | Number(_) | Boolean(_) | Null => Some(v)
    Bound(path, id, body) => {
      let cache = if deep { r.values } else { r.heads }
      if cache.get(id) is Some(value) {
        return value
      }
      if r.active.contains(id) {
        raise Invalid("binding cycle")
      }
      r.active.push(id)
      defer ignore(r.active.pop())
      let view = replacement(root, path, 0, lower)
      let result = evaluate(r, body, view, path, depth + 1, deep, None)
      cache[id] = result
      result
    }
    Substitution(paths, optional, list_env, id) =>
      resolve_reference(
        r, paths, optional, list_env, id, root, owner, depth, deep,
      )
    Reference(s) =>
      resolve_reference(
        r,
        [split_path(s)],
        false,
        false,
        -1,
        root,
        owner,
        depth,
        deep,
      )
    PathReference(keys, optional) =>
      resolve_reference(
        r,
        [keys],
        optional,
        false,
        -1,
        root,
        owner,
        depth,
        deep,
      )
    Object(fields) =>
      if !deep {
        Some(v)
      } else {
        let out = Map([])
        let keys = fields.keys().collect()
        keys.sort()
        for key in keys {
          if evaluate(
              r,
              fields[key],
              root,
              append_path(owner, [key]),
              depth + 1,
              true,
              None,
            )
            is Some(value) {
            out[key] = value
          }
        }
        Some(Object(out))
      }
    List(items) =>
      if !deep {
        Some(v)
      } else {
        let out = []
        for item in items {
          if evaluate(r, item, root, owner, depth + 1, true, None)
            is Some(value) {
            out.push(value)
          }
        }
        Some(List(out))
      }
    DelayedMerge(a, b) => {
      let old = match lower {
        Some(base) => merge(base, a)
        None => a
      }
      let location = owner_of(b, owner)
      let high = evaluate(r, b, root, location, depth + 1, deep, Some(old))
      match high {
        Some(Object(fields)) => {
          let view = replacement(root, location, 0, Some(old))
          match
            evaluate(
              r,
              old,
              view,
              owner_of(old, location),
              depth + 1,
              deep,
              None,
            ) {
            Some(previous) => Some(merge(previous, Object(fields)))
            None => high
          }
        }
        Some(_) => high
        None =>
          evaluate(
            r,
            old,
            replacement(root, location, 0, Some(old)),
            owner_of(old, location),
            depth + 1,
            deep,
            None,
          )
      }
    }
    Concat(parts) => {
      let values = []
      let mut present = false
      for (gap, part) in parts {
        if !gap.is_empty() {
          values.push(Bare(gap))
        }
        if evaluate(r, part, root, owner, depth + 1, deep, None) is Some(value) {
          values.push(value)
          present = true
        }
      }
      if !present {
        return None
      }
      if values.is_empty() {
        return None
      }
      let mut out = values[0]
      for i in 1..<values.length() {
        let next = values[i]
        out = match (out, next) {
          (Bare(space), Object(_)) | (Bare(space), List(_)) =>
            if space.iter().all(whitespace) {
              next
            } else {
              raise Invalid("incompatible value concatenation")
            }
          (Object(_), Bare(_)) | (List(_), Bare(_)) => out
          (Object(_), Object(_)) => merge(out, next)
          (List(a), List(b)) => {
            let result = a.copy()
            for x in b {
              result.push(x)
            }
            r.work.spend(result.length())
            List(result)
          }
          (Object(_), _) | (List(_), _) | (_, Object(_)) | (_, List(_)) =>
            raise Invalid("incompatible value concatenation")
          _ => {
            let text = scalar_text(out) + scalar_text(next)
            r.work.spend(text.length())
            Text(text)
          }
        }
      }
      Some(out)
    }
  }
}

///|
fn resolve_document(
  root : Value,
  environment : Map[String, String],
) -> Value raise ParseError {
  let r : Resolver = {
    environment,
    heads: Map([]),
    values: Map([]),
    active: [],
    cycles: [],
    work: { remaining: 200000, next_id: 0, },
  }
  normalize_value(
    evaluate(r, root, root, [], 0, true, None).unwrap_or(Object(Map([]))),
  )
}

///|
fn normalize_value(value : Value) -> Value {
  match value {
    Bare(s) => Text(s)
    List(xs) => List(xs.map(normalize_value))
    Object(m) => {
      let out = Map([])
      for k, v in m {
        out[k] = normalize_value(v)
      }
      Object(out)
    }
    _ => value
  }
}
