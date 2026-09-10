///|
/// Required typed lookup. Text values remain text; numeric-looking strings are not coerced.
pub fn get_string(config : Value, key : String) -> String raise ParseError {
  match get(config, key) {
    Some(Text(s)) => s
    None => raise Invalid("missing key " + key)
    _ => raise Invalid("expected string " + key)
  }
}

///|
pub fn get_int(config : Value, key : String) -> Int raise ParseError {
  match get(config, key) {
    Some(Number(s)) =>
      @string.parse_int(s) catch {
        _ => raise Invalid("expected 32-bit integer " + key)
      }
    None => raise Invalid("missing key " + key)
    _ => raise Invalid("expected number " + key)
  }
}

///|
pub fn get_bool(config : Value, key : String) -> Bool raise ParseError {
  match get(config, key) {
    Some(Boolean(b)) => b
    None => raise Invalid("missing key " + key)
    _ => raise Invalid("expected boolean " + key)
  }
}

///|
pub fn get_list(config : Value, key : String) -> Array[Value] raise ParseError {
  match get(config, key) {
    Some(List(items)) => items.copy()
    None => raise Invalid("missing key " + key)
    _ => raise Invalid("expected list " + key)
  }
}

///|
/// Stable JSON rendering of a resolved value; number spelling is retained.
pub fn Value::to_json_string(self : Value) -> String raise ParseError {
  render(self, 0, Work::{ remaining: 1000000, })
}

///|
fn render(v : Value, depth : Int, work : Work) -> String raise ParseError {
  if depth > 64 {
    raise Invalid("JSON nesting limit")
  }
  let result = match v {
    Text(s) => s.to_json().stringify()
    Number(s) => {
      let checked = @json.parse(s) catch {
        _ => raise Invalid("invalid numeric value")
      }
      match checked {
        Number(_) => s
        _ => raise Invalid("invalid numeric value")
      }
    }
    Boolean(b) => if b { "true" } else { "false" }
    Null => "null"
    List(items) =>
      "[" + items.map(x => render(x, depth + 1, work)).join(",") + "]"
    Object(m) => {
      let keys = m.keys().collect()
      keys.sort()
      "{" +
      keys
      .map(k => k.to_json().stringify() + ":" + render(m[k], depth + 1, work))
      .join(",") +
      "}"
    }
    _ => raise Invalid("unresolved value cannot be rendered")
  }
  work.spend(result.length())
  result
}
