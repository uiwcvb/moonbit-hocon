///|
// A scalar fallback seals an object against subsequent fallbacks. This state is
// part of the value, so it survives embedding, editing, resolution and copying.
fn rebuild_object(original : Value, fields : Map[String, Value]) -> Value {
  if original is SealedObject(_) {
    SealedObject(fields)
  } else {
    Object(fields)
  }
}

///|
fn completely_resolved(value : Value) -> Bool {
  match value {
    Text(_) | Bare(_) | Number(_) | Boolean(_) | Null => true
    Object(fields) | SealedObject(fields) =>
      fields.values().all(completely_resolved)
    List(items) => items.iter().all(completely_resolved)
    _ => false
  }
}

///|
fn ignores_fallbacks(value : Value) -> Bool {
  match value {
    SealedObject(_) => true
    Object(_) => false
    _ => completely_resolved(value)
  }
}

///|
fn only_path(value : Value, parts : Array[String], at : Int) -> Value {
  if at == parts.length() {
    return value
  }
  match value {
    Object(fields) | SealedObject(fields) => {
      let selected = Map([])
      if fields.get(parts[at]) is Some(child) {
        selected[parts[at]] = only_path(child, parts, at + 1)
      }
      rebuild_object(value, selected)
    }
    _ => value
  }
}

///|
/// Merge arbitrary values, preserving scalar fallback barriers and raw history.
/// Both inputs and the result own independent mutable maps and arrays.
pub fn value_with_fallback(
  value : Value,
  fallback : Value,
) -> Value raise ParseError {
  let work = tree_work()
  let high = clone_tree(value, 0, work)
  let low = clone_tree(fallback, 0, work)
  merge(low, high)
}
