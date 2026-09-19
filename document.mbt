///|
// Fresh IDs across independently parsed or copied trees prevent cache collisions.
fn reindex_document(
  value : Value,
  owner : Array[String],
  work : Work,
  depth : Int,
) -> Value raise ParseError {
  tree_step(value, depth, work)
  match value {
    Object(fields) | SealedObject(fields) => {
      let result = Map([])
      for key, child in fields {
        work.spend(key.length())
        result[key] = reindex_document(
          child,
          append_path(owner, [key]),
          work,
          depth + 1,
        )
      }
      rebuild_object(value, result)
    }
    List(items) =>
      List(items.map(v => reindex_document(v, owner, work, depth + 1)))
    Bound(_, _, value) =>
      Bound(
        owner.copy(),
        work.id(),
        reindex_document(value, owner, work, depth + 1),
      )
    Substitution(paths, optional, list_env, _) =>
      Substitution(paths.map(p => p.copy()), optional, list_env, work.id())
    Reference(path) => Substitution([split_path(path)], false, false, work.id())
    PathReference(parts, optional) =>
      Substitution([parts.copy()], optional, false, work.id())
    Concat(parts) =>
      Concat(
        parts.map(p => (p.0, reindex_document(p.1, owner, work, depth + 1))),
      )
    DelayedMerge(a, b) =>
      DelayedMerge(
        reindex_document(a, owner, work, depth + 1),
        reindex_document(b, owner, work, depth + 1),
      )
    _ => value
  }
}

///|
/// Resolve a detached document; missing mandatory references may remain deferred.
pub fn resolve(
  config : Value,
  environment? : Map[String, String] = Map([]),
  allow_unresolved? : Bool = false,
) -> Value raise ParseError {
  let root = reindex_document(config, [], tree_work(), 0)
  resolve_against(root, root, environment, allow_unresolved, true)
}

///|
/// Only the supplied source is searched for substitutions; source fields are not merged.
pub fn resolve_with(
  config : Value,
  source : Value,
  environment? : Map[String, String] = Map([]),
  allow_unresolved? : Bool = false,
) -> Value raise ParseError {
  ignore(object_fields(source))
  let same = physical_equal(config, source) ||
    (match (config, source) {
      (Object(a) | SealedObject(a), Object(b) | SealedObject(b)) =>
        physical_equal(a, b)
      _ => false
    })
  if same {
    return resolve(config, environment~, allow_unresolved~)
  }
  let work = tree_work()
  let root = reindex_document(config, [], work, 0)
  let source = reindex_document(source, [], work, 0)
  resolve_against(root, source, environment, allow_unresolved, false)
}

///|
fn known_object(value : Value) -> Bool {
  match value {
    Object(_) | SealedObject(_) => true
    Bound(_, _, body) => known_object(body)
    DelayedMerge(_, high) => known_object(high)
    _ => false
  }
}

///|
fn peek_document_child(
  value : Value,
  key : String,
  depth : Int,
  work : Work,
) -> Value? raise ParseError {
  tree_step(value, depth, work)
  match value {
    Object(fields) | SealedObject(fields) => fields.get(key)
    Bound(_, _, body) => peek_document_child(body, key, depth + 1, work)
    DelayedMerge(low, high) => {
      if !known_object(high) {
        raise Invalid("unresolved object lookup")
      }
      match peek_document_child(high, key, depth + 1, work) {
        Some(value) => {
          if !known_object(value) &&
            !uncertain(value) &&
            resolved_tree(value, depth + 1, work) {
            return Some(value)
          }
          let previous = peek_document_child(low, key, depth + 1, work)
          match previous {
            Some(previous) => Some(merge(previous, value))
            None => Some(value)
          }
        }
        None => peek_document_child(low, key, depth + 1, work)
      }
    }
    _ =>
      if uncertain(value) {
        raise Invalid("unresolved object lookup")
      } else {
        None
      }
  }
}

///|
/// Required lookup with null/unresolved rejection and known leaves of delayed objects.
fn peek_document_path(config : Value, path : String) -> Value? raise ParseError {
  let parts = split_path(path)
  let mut current = config
  for part in parts {
    let child = match current {
      Object(fields) | SealedObject(fields) => fields.get(part)
      _ => peek_document_child(current, part, 0, tree_work())
    }
    match child {
      None => return None
      Some(value) => current = value
    }
  }
  Some(current)
}

///|
fn required_document_value(
  config : Value,
  path : String,
) -> Value raise ParseError {
  let current = peek_document_path(config, path).unwrap_or_else(() => {
    raise Invalid("missing path: " + path)
  })
  required_leaf(current, path)
}

///|
fn required_leaf(current : Value, path : String) -> Value raise ParseError {
  if current is Null {
    raise Invalid("null path: " + path)
  }
  if uncertain(current) {
    raise Invalid("unresolved path: " + path)
  }
  current
}

///|
pub fn get_value(config : Value, path : String) -> Value raise ParseError {
  let value = peek_document_path(config, path).unwrap_or_else(() => {
    raise Invalid("missing path: " + path)
  })
  if value is Null {
    raise Invalid("null path: " + path)
  }
  ignore(value_type(value))
  copy_value(value)
}

///|
fn check_edit_descent(
  config : Value,
  parts : Array[String],
) -> Unit raise ParseError {
  let mut current = config
  for i = 0; i + 1 < parts.length(); i = i + 1 {
    match current {
      Object(fields) | SealedObject(fields) =>
        current = fields.get(parts[i]).unwrap_or(Null)
      _ => return
    }
    if !(current is (Object(_) | SealedObject(_))) && known_object(current) {
      raise Invalid("cannot edit inside an unresolved merged object")
    }
  }
}
