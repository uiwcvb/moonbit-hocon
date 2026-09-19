///|
fn tree_work() -> Work {
  { remaining: 1000000, next_id: 0, }
}

///|
fn tree_step(value : Value, depth : Int, work : Work) -> Unit raise ParseError {
  if depth > 64 {
    raise Invalid("configuration tree depth limit")
  }
  work.spend(1)
  match value {
    Text(s) | Number(s) | Bare(s) | Reference(s) => work.spend(s.length())
    _ => ()
  }
}

///|
fn clone_tree(
  value : Value,
  depth : Int,
  work : Work,
) -> Value raise ParseError {
  tree_step(value, depth, work)
  match value {
    Object(fields) | SealedObject(fields) => {
      let copied = Map([])
      for key, child in fields {
        work.spend(key.length())
        copied[key] = clone_tree(child, depth + 1, work)
      }
      rebuild_object(value, copied)
    }
    List(items) => List(items.map(v => clone_tree(v, depth + 1, work)))
    PathReference(parts, optional) => PathReference(parts.copy(), optional)
    Substitution(paths, optional, self_ref, id) =>
      Substitution(paths.map(parts => parts.copy()), optional, self_ref, id)
    Bound(parts, id, child) =>
      Bound(parts.copy(), id, clone_tree(child, depth + 1, work))
    Concat(parts) =>
      Concat(parts.map(p => (p.0, clone_tree(p.1, depth + 1, work))))
    DelayedMerge(a, b) =>
      DelayedMerge(
        clone_tree(a, depth + 1, work),
        clone_tree(b, depth + 1, work),
      )
    _ => value
  }
}

///|
fn object_fields(config : Value) -> Map[String, Value] raise ParseError {
  match config {
    Object(fields) | SealedObject(fields) => fields
    _ => raise Invalid("configuration root must be an object")
  }
}

///|
/// Return a detached tree; mutable maps/arrays are not shared with the input.
pub fn copy_value(value : Value) -> Value raise ParseError {
  clone_tree(value, 0, tree_work())
}

///|
fn unquoted_path_part(part : String) -> Bool {
  if part.is_empty() {
    return false
  }
  for i = 0; i < part.length(); i = i + 1 {
    let cp = part[i].to_int()
    if cp < 128 {
      if !((cp >= 48 && cp <= 57) ||
        (cp >= 65 && cp <= 90) ||
        (cp >= 97 && cp <= 122) ||
        cp == 45 ||
        cp == 95) {
        return false
      }
    } else if (cp >= 0xD800 && cp <= 0xDFFF) ||
      !path_character(cp.unsafe_to_char()) {
      return false
    }
  }
  true
}

///|
/// Canonical path expression. A literal key can always be expressed by quoting it.
pub fn join_path(parts : Array[String]) -> String raise ParseError {
  if parts.is_empty() || parts.length() > 32 {
    raise Invalid("path depth limit")
  }
  let result = if parts.length() == 1 && unquoted_path_part(parts[0]) {
    parts[0]
  } else {
    let output = StringBuilder()
    for i, part in parts {
      if i > 0 {
        output.write_string(".")
      }
      output.write_string(
        if unquoted_path_part(part) {
          part
        } else {
          part.to_json().stringify()
        },
      )
    }
    output.to_string()
  }
  if result.length() > 100000 {
    raise Invalid("path length limit")
  }
  result
}

///|
fn wrap_path(value : Value, parts : Array[String]) -> Value {
  let mut result = value
  for i = parts.length() - 1; i >= 0; i = i - 1 {
    result = Object(Map([(parts[i], result)]))
  }
  result
}

///|
pub fn at_path(value : Value, path : String) -> Value raise ParseError {
  let parts = split_path(path)
  clone_tree(wrap_path(value, parts), 0, tree_work())
}

///|
pub fn at_key(value : Value, key : String) -> Value raise ParseError {
  clone_tree(Object(Map([(key, value)])), 0, tree_work())
}

///|
// Mutate only a fresh private copy. Intermediate scalars are replaced by objects.
fn set_parts(
  fields : Map[String, Value],
  parts : Array[String],
  at : Int,
  value : Value,
) -> Unit {
  let key = parts[at]
  if at + 1 == parts.length() {
    fields[key] = value
  } else {
    let child = match fields.get(key) {
      Some(Object(m) | SealedObject(m)) => m
      _ => Map([])
    }
    set_parts(child, parts, at + 1, value)
    fields[key] = rebuild_object(fields.get(key).unwrap_or(Null), child)
  }
}

///|
pub fn with_value(
  config : Value,
  path : String,
  value : Value,
) -> Value raise ParseError {
  let parts = split_path(path)
  check_edit_descent(config, parts)
  let work = tree_work()
  let fields = object_fields(clone_tree(config, 0, work))
  let value = clone_tree(value, parts.length(), work)
  set_parts(fields, parts, 0, value)
  rebuild_object(config, fields)
}

///|
pub fn with_only_path(config : Value, path : String) -> Value raise ParseError {
  ignore(object_fields(config))
  let parts = split_path(path)
  check_edit_descent(config, parts)
  match get_path(config, parts) {
    Some(_) => copy_value(only_path(config, parts, 0))
    None => rebuild_object(config, Map([]))
  }
}

///|
pub fn without_path(config : Value, path : String) -> Value raise ParseError {
  let parts = split_path(path)
  check_edit_descent(config, parts)
  let result = copy_value(config)
  let mut fields = object_fields(result)
  for i = 0; i + 1 < parts.length(); i = i + 1 {
    match fields.get(parts[i]) {
      Some(Object(child) | SealedObject(child)) => fields = child
      _ => return result
    }
  }
  fields.remove(parts[parts.length() - 1])
  result
}

///|
pub fn with_only_key(config : Value, key : String) -> Value raise ParseError {
  match object_fields(config).get(key) {
    Some(value) => copy_value(rebuild_object(config, Map([(key, value)])))
    None => rebuild_object(config, Map([]))
  }
}

///|
pub fn without_key(config : Value, key : String) -> Value raise ParseError {
  let result = copy_value(config)
  object_fields(result).remove(key)
  result
}

///|
pub fn with_key_value(
  config : Value,
  key : String,
  value : Value,
) -> Value raise ParseError {
  let work = tree_work()
  let result = clone_tree(config, 0, work)
  let fields = object_fields(result)
  work.spend(key.length())
  fields[key] = clone_tree(value, 1, work)
  result
}

///|
pub fn with_fallback(
  config : Value,
  fallback : Value,
) -> Value raise ParseError {
  if !known_object(config) {
    raise Invalid("configuration root must be an object")
  }
  // Copy before merging so retained input branches cannot be mutated by callers.
  let work = tree_work()
  let high = clone_tree(config, 0, work)
  let low = clone_tree(fallback, 0, work)
  merge(low, high)
}

///|
pub fn is_empty(config : Value) -> Bool raise ParseError {
  object_fields(config).is_empty()
}

///|
pub fn has_path_or_null(config : Value, path : String) -> Bool raise ParseError {
  peek_document_path(config, path) is Some(_)
}

///|
fn resolved_tree(
  value : Value,
  depth : Int,
  work : Work,
) -> Bool raise ParseError {
  tree_step(value, depth, work)
  match value {
    Object(fields) | SealedObject(fields) => {
      for _, child in fields {
        if !resolved_tree(child, depth + 1, work) {
          return false
        }
      }
      true
    }
    List(items) => {
      for child in items {
        if !resolved_tree(child, depth + 1, work) {
          return false
        }
      }
      true
    }
    Text(_) | Bare(_) | Number(_) | Boolean(_) | Null => true
    _ => false
  }
}

///|
pub fn is_resolved(config : Value) -> Bool raise ParseError {
  resolved_tree(config, 0, tree_work())
}

///|
fn collect_entries(
  value : Value,
  parts : Array[String],
  result : Map[String, Value],
  depth : Int,
  work : Work,
) -> Unit raise ParseError {
  tree_step(value, depth, work)
  match value {
    Object(fields) | SealedObject(fields) =>
      for key, child in fields {
        let next = parts.copy()
        next.push(key)
        collect_entries(child, next, result, depth + 1, work)
      }
    Null => ()
    Bound(_, _, body) => collect_entries(body, parts, result, depth + 1, work)
    _ => {
      if known_object(value) {
        raise Invalid("cannot enumerate unresolved object")
      }
      result[join_path(parts)] = clone_tree(value, depth, work)
    }
  }
}

///|
/// Flatten non-object, non-null leaves. Lists remain leaf values.
pub fn entry_set(config : Value) -> Map[String, Value] raise ParseError {
  ignore(object_fields(config))
  let result = Map([])
  collect_entries(config, [], result, 0, tree_work())
  result
}
