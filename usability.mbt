///|
/// Required scalar lookup with explicit type validation, no fallback coercion.
pub fn get_string(config : Value, key : String) -> String raise ParseError {
  match get(config, key) {
    Some(Text(s)) => s
    None => raise Invalid("missing key " + key)
    _ => raise Invalid("expected scalar " + key)
  }
}

///|
pub fn get_int(config : Value, key : String) -> Int raise ParseError {
  let value = get_string(config, key)
  @string.parse_int(value) catch {
    _ => raise Invalid("expected integer " + key)
  }
}

///|
pub fn get_bool(config : Value, key : String) -> Bool raise ParseError {
  match get_string(config, key) {
    "true" => true
    "false" => false
    _ => raise Invalid("expected boolean " + key)
  }
}
