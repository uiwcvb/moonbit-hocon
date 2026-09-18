///|
/// The type is known for a delayed object even when its members are unresolved.
pub fn value_type(value : Value) -> String raise ParseError {
  if known_object(value) {
    return "OBJECT"
  }
  match value {
    Text(_) | Bare(_) => "STRING"
    Number(_) => "NUMBER"
    Boolean(_) => "BOOLEAN"
    Null => "NULL"
    List(_) => "LIST"
    Bound(_, _, body) => value_type(body)
    _ => raise Invalid("value type is unresolved")
  }
}

///|
/// Return detached data, rejecting unresolved children at any depth.
pub fn value_unwrapped(value : Value) -> Value raise ParseError {
  unwrapped_tree(value, 0, tree_work())
}

///|
/// Literal map lookup; None means missing, Some(Null) is a present null value.
pub fn object_get(value : Value, key : String) -> Value? raise ParseError {
  object_fields(value).get(key).map(copy_value)
}

///|
pub fn object_keys(value : Value) -> Array[String] raise ParseError {
  object_iteration_keys(object_fields(value))
}

///|
pub fn list_get(value : Value, index : Int) -> Value raise ParseError {
  guard value is List(items) else { raise Invalid("expected list") }
  if index < 0 || index >= items.length() {
    raise Invalid("list index out of bounds")
  }
  copy_value(items[index])
}

///|
pub fn value_size(value : Value) -> Int raise ParseError {
  match value {
    List(items) => items.length()
    _ => object_fields(value).length()
  }
}
