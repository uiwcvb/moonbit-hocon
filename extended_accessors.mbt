///|
/// Preserve the Number subtype returned by the pinned reference implementation.
pub(all) enum ConfigNumber {
  Integer(Int)
  Long(Int64)
  Floating(Double)
} derive(Debug, Eq)

///|
pub impl ToJson for ConfigNumber with fn to_json(self) {
  match self {
    Integer(n) => Json::object({ "kind": "int", "value": n.to_string() })
    Long(n) => Json::object({ "kind": "long", "value": n.to_string() })
    Floating(n) => {
      let value = if n.is_nan() {
        "NaN".to_json()
      } else if n.is_inf() {
        (if n > 0.0 { "Infinity" } else { "-Infinity" }).to_json()
      } else if n == 0.0 && n.reinterpret_as_int64() < 0L {
        "-0.0".to_json()
      } else {
        n.to_json()
      }
      let bits = if n.is_nan() {
        9221120237041090560L
      } else {
        n.reinterpret_as_int64()
      }
      Json::object({
        "kind": "double",
        "value": value,
        "bits": bits.to_string(),
      })
    }
  }
}

///|
fn java_integer_value(text : String) -> Int64? {
  if text.is_empty() || text.length() > 10000 {
    return None
  }
  if integer_spelling(text) {
    return Some(@string.parse_int64(text)) catch { _ => None }
  }
  let out = StringBuilder()
  let mut first = true
  let mut digits = 0
  for c in text.iter() {
    if first && (c == '+' || c == '-') {
      out.write_char(c)
    } else {
      let digit = numeric_digit(c.to_int())
      if digit < 0 {
        return None
      }
      out.write_char((48 + digit).unsafe_to_char())
      digits += 1
    }
    first = false
  }
  if digits == 0 {
    return None
  }
  Some(@string.parse_int64(out.to_string())) catch {
    _ => None
  }
}

///|
fn numeric_index(text : String) -> Int {
  if !text.is_empty() && text[0] < 128 {
    let fast = Some(@string.parse_int(text)) catch { _ => None }
    if fast is Some(index) {
      return if index >= 0 { index } else { -1 }
    }
  }
  match java_integer_value(text) {
    Some(n) => if n >= 0L && n <= 2147483647L { n.to_int() } else { -1 }
    None => -1
  }
}

///|
fn compact_number(n : Int64) -> ConfigNumber {
  if n >= -2147483648L && n <= 2147483647L {
    Integer(n.to_int())
  } else {
    Long(n)
  }
}

///|
pub fn get_number(
  config : Value,
  key : String,
) -> ConfigNumber raise ParseError {
  match required(config, key) {
    Number(text) =>
      match java_integer_value(text) {
        Some(n) => compact_number(n)
        None => {
          let n = double_value(text)
          let integer = java_long(n)
          if !integer_spelling(text) && integer.to_double() == n {
            compact_number(integer)
          } else {
            Floating(n)
          }
        }
      }
    Text(text) =>
      match java_integer_value(text) {
        Some(n) => Long(n)
        None => Floating(double_value(text))
      }
    _ => raise Invalid("expected number-compatible value")
  }
}

///|
pub fn get_number_list(
  config : Value,
  key : String,
) -> Array[ConfigNumber] raise ParseError {
  typed_list(config, key, get_number)
}

///|
pub fn get_object(
  config : Value,
  key : String,
) -> Map[String, Value] raise ParseError {
  match copy_value(required(config, key)) {
    Object(fields) => fields
    _ => raise Invalid("expected object-compatible value")
  }
}

///|
pub fn get_object_list(
  config : Value,
  key : String,
) -> Array[Map[String, Value]] raise ParseError {
  typed_list(config, key, get_object)
}

///|
fn unwrapped_tree(
  value : Value,
  depth : Int,
  work : Work,
) -> Value raise ParseError {
  tree_step(value, depth, work)
  match value {
    Bare(text) => Text(text)
    Text(_) | Number(_) | Boolean(_) | Null => value
    Object(fields) => {
      let out = Map([])
      for key, child in fields {
        work.spend(key.length())
        out[key] = unwrapped_tree(child, depth + 1, work)
      }
      Object(out)
    }
    List(items) =>
      List(items.map(value => unwrapped_tree(value, depth + 1, work)))
    _ => raise Invalid("cannot unwrap unresolved value")
  }
}

///|
pub fn get_any_ref(config : Value, key : String) -> Value raise ParseError {
  unwrapped_tree(required(config, key), 0, tree_work())
}

///|
pub fn get_any_ref_list(
  config : Value,
  key : String,
) -> Array[Value] raise ParseError {
  match unwrapped_tree(List(get_as_list(config, key)), 0, tree_work()) {
    List(items) => items
    _ => abort("list copy invariant")
  }
}

///|
/// Match exact case-sensitive enum names; values may be a caller-defined enum.
pub fn[T] get_enum(
  config : Value,
  key : String,
  choices : Map[String, T],
) -> T raise ParseError {
  let name = get_as_string(config, key)
  choices
  .get(name)
  .unwrap_or_else(() => raise Invalid("unknown enum constant: " + name))
}

///|
pub fn[T] get_enum_list(
  config : Value,
  key : String,
  choices : Map[String, T],
) -> Array[T] raise ParseError {
  get_as_list(config, key).map(value => {
    let name = string_value(value)
    choices
    .get(name)
    .unwrap_or_else(() => raise Invalid("unknown enum constant: " + name))
  })
}
