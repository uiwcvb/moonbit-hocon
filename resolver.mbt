///|
priv struct Resolver {
  environment : Map[String, String]
  heads : Map[Int, Value?]
  values : Map[Int, Value?]
  active : Array[Int]
  cycles : Array[Int]
  work : Work
  allow_unresolved : Bool
  blocked_paths : Array[Array[String]]
  delayed_object_root : Bool
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
    Object(fields) | SealedObject(fields) => {
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
      rebuild_object(root, out)
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
    let head = evaluate(r, current, root, path, depth + 1, false, None, true)
    match head {
      Some(Object(fields) | SealedObject(fields)) =>
        match fields.get(part) {
          Some(v) => {
            current = v
            path.push(part)
          }
          None => return None
        }
      Some(value) => {
        if !known_object(value) {
          return None
        }
        match peek_document_child(value, part, depth + 1, r.work) {
          Some(child) => {
            current = child
            path.push(part)
          }
          None => return None
        }
      }
      None => return None
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
  source_node : Bool,
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
      // A binding with no lower value cannot include its enclosing object.
      // With merge history, the enclosing lookup uses the replacement view
      // containing that lower value and is finite (including after atPath).
      if source_node && ancestor(keys, owner) && r.blocked_paths.contains(owner) {
        if optional {
          found = true
          break
        } else {
          raise Invalid("reference to enclosing object creates a cycle")
        }
      }
      if lookup_resolved(r, root, keys, depth + 1) is Some(target) {
        result = evaluate(r, target, root, keys, depth + 1, deep, None, true)
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
    if source_node &&
      paths
      .iter()
      .any(keys => {
        r.blocked_paths.iter().any(p => p == keys || ancestor(p, keys))
      }) {
      raise Invalid("substitution cycle through hidden binding")
    }
    if r.allow_unresolved {
      return Some(Substitution(paths, optional, list_env, id))
    }
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
  source_node : Bool,
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
      let blocked = source_node && lower == None
      if blocked {
        r.blocked_paths.push(path)
      }
      defer (if blocked { ignore(r.blocked_paths.pop()) })
      if source_node && path.is_empty() && r.delayed_object_root {
        match lower {
          Some(replacement) =>
            if !known_object(replacement) {
              raise Invalid(
                "cannot replace delayed object root with non-object resolution source",
              )
            }
          None => raise Invalid("cannot remove delayed object resolution root")
        }
      }
      let view = if source_node {
        replacement(root, path, 0, lower)
      } else {
        root
      }
      let result = evaluate(
        r,
        body,
        view,
        path,
        depth + 1,
        deep,
        None,
        source_node,
      )
      cache[id] = result
      result
    }
    Substitution(paths, optional, list_env, id) =>
      resolve_reference(
        r, paths, optional, list_env, id, root, owner, depth, deep, source_node,
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
        source_node,
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
        source_node,
      )
    Object(fields) | SealedObject(fields) =>
      if !deep {
        Some(v)
      } else {
        let out = Map([])
        let keys = if has_index_aliases(fields) {
          object_iteration_keys(fields)
        } else {
          let keys = fields.keys().collect()
          keys.sort()
          keys
        }
        for key in keys {
          if evaluate(
              r,
              fields[key],
              root,
              append_path(owner, [key]),
              depth + 1,
              true,
              None,
              source_node,
            )
            is Some(value) {
            out[key] = value
          }
        }
        Some(rebuild_object(v, out))
      }
    List(items) =>
      if !deep {
        Some(v)
      } else {
        let out = []
        for item in items {
          if evaluate(r, item, root, owner, depth + 1, true, None, source_node)
            is Some(value) {
            out.push(value)
          }
        }
        Some(List(out))
      }
    DelayedMerge(a, b) => {
      if !source_node {
        raise Invalid(
          "external resolution cannot replace foreign merge history",
        )
      }
      let old = match lower {
        Some(base) => merge(base, a)
        None => a
      }
      let location = owner_of(b, owner)
      let high = evaluate(
        r,
        b,
        root,
        location,
        depth + 1,
        deep,
        Some(old),
        source_node,
      )
      match high {
        Some(SealedObject(_)) => high
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
              source_node,
            ) {
            Some(previous) =>
              Some(
                match previous {
                  DelayedMerge(older, Object(_) | SealedObject(_) as head) =>
                    merge(older, merge(head, Object(fields)))
                  _ => merge(previous, Object(fields))
                },
              )
            None => high
          }
        }
        Some(value) =>
          if !ignores_fallbacks(value) && r.allow_unresolved {
            Some(DelayedMerge(old, value))
          } else {
            high
          }
        None =>
          evaluate(
            r,
            old,
            replacement(root, location, 0, Some(old)),
            owner_of(old, location),
            depth + 1,
            deep,
            None,
            source_node,
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
        if evaluate(r, part, root, owner, depth + 1, deep, None, source_node)
          is Some(value) {
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
      if values.iter().any(uncertain) {
        return Some(Concat(values.map(value => ("", value))))
      }
      let mut out = values[0]
      for i in 1..<values.length() {
        let next = values[i]
        out = match (out, next) {
          (Bare(space), Object(_) | SealedObject(_)) | (Bare(space), List(_)) =>
            if space.iter().all(whitespace) {
              next
            } else {
              raise Invalid("incompatible value concatenation")
            }
          (Object(_) | SealedObject(_), Bare(_)) | (List(_), Bare(_)) => out
          (Object(_) | SealedObject(_), Object(_) | SealedObject(_)) =>
            merge(out, next)
          (List(a), List(b)) => {
            let result = a.copy()
            for x in b {
              result.push(x)
            }
            r.work.spend(result.length())
            List(result)
          }
          (Object(_) | SealedObject(_), _)
          | (List(_), _)
          | (_, Object(_) | SealedObject(_))
          | (_, List(_)) => raise Invalid("incompatible value concatenation")
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
  resolve_against(root, root, environment, false, true)
}

///|
fn resolve_against(
  root : Value,
  source : Value,
  environment : Map[String, String],
  allow_unresolved : Bool,
  source_node : Bool,
) -> Value raise ParseError {
  let r : Resolver = {
    environment,
    heads: Map([]),
    values: Map([]),
    active: [],
    cycles: [],
    work: { remaining: 200000, next_id: 0, },
    allow_unresolved,
    blocked_paths: [],
    delayed_object_root: uncertain(root) && known_object(root),
  }
  normalize_value(
    evaluate(r, root, source, [], 0, true, None, source_node).unwrap_or(
      Object(Map([])),
    ),
  )
}

///|
fn normalize_value(value : Value) -> Value {
  // A resolved unquoted string is still unquoted when rendering HOCON. Keep
  // Bare; data-only unwrapping and semantic string access normalize its value.
  match value {
    List(xs) => List(xs.map(normalize_value))
    Object(m) | SealedObject(m) => {
      let out = Map([])
      for k, v in m {
        out[k] = normalize_value(v)
      }
      rebuild_object(value, out)
    }
    _ => value
  }
}
