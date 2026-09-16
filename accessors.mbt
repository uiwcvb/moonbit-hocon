///|
fn required(config : Value, key : String) -> Value raise ParseError {
  let keys = split_path(key)
  match get_path(config, keys) {
    Some(Null) => raise Invalid("null value: " + key)
    Some(v) => v
    None => raise Invalid("missing key: " + key)
  }
}

///|
pub fn has_path(
  config : Value,
  key : String,
  include_null? : Bool = false,
) -> Bool {
  match get(config, key) {
    None => false
    Some(Null) => include_null
    _ => true
  }
}

///|
pub fn get_is_null(config : Value, key : String) -> Bool raise ParseError {
  match get_path(config, split_path(key)) {
    None => raise Invalid("missing key: " + key)
    Some(Null) => true
    _ => false
  }
}

///|
/// HOCON's recommended conversions, separate from the original strict getters.
pub fn get_as_string(config : Value, key : String) -> String raise ParseError {
  match required(config, key) {
    Text(s) | Number(s) => s
    Boolean(b) => if b { "true" } else { "false" }
    _ => raise Invalid("expected string-compatible scalar")
  }
}

///|
pub fn get_as_bool(config : Value, key : String) -> Bool raise ParseError {
  match required(config, key) {
    Boolean(b) => b
    Text("true" | "yes" | "on") => true
    Text("false" | "no" | "off") => false
    _ => raise Invalid("expected boolean-compatible value")
  }
}

///|
fn number_text(v : Value) -> String raise ParseError {
  match v {
    Text(s) | Number(s) => s
    _ => raise Invalid("expected number-compatible value")
  }
}

///|
fn double_value(text : String) -> Double raise ParseError {
  if text.length() > 10000 {
    raise Invalid("number length limit")
  }
  let cs = text.to_array()
  let mut start = 0
  let mut end = cs.length()
  while start < end && cs[start].to_int() <= 32 {
    start += 1
  }
  while end > start && cs[end - 1].to_int() <= 32 {
    end -= 1
  }
  let negative = start < end && cs[start] == '-'
  if start < end && (cs[start] == '+' || cs[start] == '-') {
    start += 1
  }
  let unsigned = String::from_array(cs[start:end])
  if unsigned == "NaN" || unsigned == "Infinity" {
    return @string.parse_double((if negative { "-" } else { "" }) + unsigned) catch {
      _ => raise Invalid("invalid number")
    }
  }
  if end > start && ['f', 'F', 'd', 'D'].contains(cs[end - 1]) {
    end -= 1
  }
  let unsigned = String::from_array(cs[start:end])
  let value = if unsigned.has_prefix("0x") || unsigned.has_prefix("0X") {
    hex_double(unsigned)
  } else {
    if !numeric_text(unsigned) || unsigned.has_prefix("-") {
      raise Invalid("invalid number: " + text)
    }
    @string.parse_double(unsigned) catch {
      Failure::Failure("value out of range") => 1.0 / 0.0
      _ => raise Invalid("invalid number: " + text)
    }
  }
  if negative {
    -value
  } else {
    value
  }
}

///|
pub fn get_double(config : Value, key : String) -> Double raise ParseError {
  double_value(number_text(required(config, key)))
}

///|
fn java_long(value : Double) -> Int64 {
  if value.is_nan() {
    0L
  } else if value >= 9223372036854775807.0 {
    9223372036854775807L
  } else if value <= -9223372036854775808.0 {
    -9223372036854775808L
  } else {
    value.to_int64()
  }
}

///|
fn long_value(text : String) -> Int64 raise ParseError {
  if integer_spelling(text) {
    @string.parse_int64(text) catch {
      _ => java_long(double_value(text))
    }
  } else {
    java_long(double_value(text))
  }
}

///|
pub fn get_long(config : Value, key : String) -> Int64 raise ParseError {
  long_value(number_text(required(config, key)))
}

///|
pub fn get_as_int(config : Value, key : String) -> Int raise ParseError {
  let n = get_long(config, key)
  if n < -2147483648L || n > 2147483647L {
    raise Invalid("integer out of 32-bit range")
  }
  n.to_int()
}

///|
pub fn get_as_list(
  config : Value,
  key : String,
) -> Array[Value] raise ParseError {
  match required(config, key) {
    List(xs) => xs.copy()
    Object(m) => {
      let indices : Array[(Int, String)] = []
      for name, _ in m {
        let n = @string.parse_int(name) catch { _ => -1 }
        if n >= 0 {
          indices.push((n, name))
        }
      }
      if indices.is_empty() {
        raise Invalid("object has no numeric list indices")
      }
      indices.sort_by((a, b) => {
        if a.0 == b.0 {
          a.1.compare(b.1)
        } else {
          a.0.compare(b.0)
        }
      })
      indices.map(pair => m[pair.1])
    }
    _ => raise Invalid("expected list-compatible value")
  }
}

///|
fn trim_space(text : String) -> String {
  let cs = text.to_array()
  let mut start = 0
  let mut end = cs.length()
  while start < end && whitespace(cs[start]) {
    start += 1
  }
  while end > start && whitespace(cs[end - 1]) {
    end -= 1
  }
  String::from_array(cs[start:end])
}

///|
fn quantity(text : String) -> (String, String) raise ParseError {
  if text.length() > 10000 {
    raise Invalid("quantity length limit")
  }
  let text = trim_space(text)
  let cs = text.to_array()
  let mut end = cs.length()
  while end > 0 &&
        (
          (cs[end - 1] >= 'a' && cs[end - 1] <= 'z') ||
          (cs[end - 1] >= 'A' && cs[end - 1] <= 'Z') ||
          cs[end - 1].to_int() > 127
        ) {
    end -= 1
  }
  let number = trim_space(String::from_array(cs[:end]))
  let unit = String::from_array(cs[end:])
  if number.is_empty() {
    raise Invalid("quantity requires a number")
  }
  (number, unit)
}

///|
fn integer_spelling(s : String) -> Bool {
  let cs = s.to_array()
  let start = if !cs.is_empty() && (cs[0] == '-' || cs[0] == '+') {
    1
  } else {
    0
  }
  cs.length() > start && cs[start:].iter().all(c => c >= '0' && c <= '9')
}

///|
fn saturate_big(n : @bigint.BigInt) -> Int64 {
  if n.compare_int64(9223372036854775807L) > 0 {
    9223372036854775807L
  } else if n.compare_int64(-9223372036854775808L) < 0 {
    -9223372036854775808L
  } else {
    n.to_int64()
  }
}

///|
/// Duration in nanoseconds; unitless values use milliseconds.
pub fn get_duration(config : Value, key : String) -> Int64 raise ParseError {
  let (n, unit) = quantity(number_text(required(config, key)))
  let multiplier : Int64 = match unit {
    "ns" | "nano" | "nanos" | "nanosecond" | "nanoseconds" => 1L
    "us" | "micro" | "micros" | "microsecond" | "microseconds" => 1000L
    "" | "ms" | "milli" | "millis" | "millisecond" | "milliseconds" => 1000000L
    "s" | "second" | "seconds" => 1000000000L
    "m" | "minute" | "minutes" => 60000000000L
    "h" | "hour" | "hours" => 3600000000000L
    "d" | "day" | "days" => 86400000000000L
    _ => raise Invalid("unknown duration unit: " + unit)
  }
  if integer_spelling(n) {
    let whole = @string.parse_int64(n) catch {
      _ => raise Invalid("duration integer overflow")
    }
    saturate_big(
      @bigint.BigInt::from_int64(whole) * @bigint.BigInt::from_int64(multiplier),
    )
  } else {
    java_long(double_value(n) * multiplier.to_double())
  }
}

///|
fn byte_multiplier(unit : String) -> @bigint.BigInt raise ParseError {
  if ["", "b", "B", "byte", "bytes"].contains(unit) {
    return @bigint.BigInt::from_int(1)
  }
  let names = [
    ("k", "kilo", "kibi"),
    ("M", "mega", "mebi"),
    ("G", "giga", "gibi"),
    ("T", "tera", "tebi"),
    ("P", "peta", "pebi"),
    ("E", "exa", "exbi"),
    ("Z", "zetta", "zebi"),
    ("Y", "yotta", "yobi"),
  ]
  for i, (letter, decimal, binary) in names {
    let decimal_units = [letter + "B", decimal + "byte", decimal + "bytes"]
    let upper = letter.to_upper()
    let binary_units = [
      upper,
      upper.to_lower(),
      upper + "i",
      upper + "iB",
      binary + "byte",
      binary + "bytes",
    ]
    let base = if decimal_units.contains(unit) {
      1000
    } else if binary_units.contains(unit) {
      1024
    } else {
      continue
    }
    return @bigint.BigInt::from_int(base).pow(@bigint.BigInt::from_int(i + 1))
  }
  raise Invalid("unknown byte-size unit: " + unit)
}

///|
fn decimal_scaled(
  text : String,
  multiplier : @bigint.BigInt,
) -> @bigint.BigInt raise ParseError {
  let source = trim_space(text)
  let negative = source.has_prefix("-")
  let source = if source.has_prefix("+") || negative {
    source[1:].to_owned()
  } else {
    source
  }
  let cs = source.to_array()
  let digits = StringBuilder()
  let mut i = 0
  let mut fraction = 0
  let mut dotted = false
  let mut count = 0
  while i < cs.length() {
    let c = cs[i]
    if c >= '0' && c <= '9' {
      digits.write_char(c)
      count += 1
      if dotted {
        fraction += 1
      }
    } else if c == '.' && !dotted {
      dotted = true
    } else {
      break
    }
    i += 1
  }
  if count == 0 {
    raise Invalid("invalid byte-size number")
  }
  let exponent = if i < cs.length() && (cs[i] == 'e' || cs[i] == 'E') {
    i += 1
    let exp = String::from_array(cs[i:])
    i = cs.length()
    @string.parse_int(exp) catch {
      _ => raise Invalid("invalid byte-size exponent")
    }
  } else {
    0
  }
  if i != cs.length() || exponent > 4096 || exponent < -4096 {
    raise Invalid("invalid or excessive byte-size exponent")
  }
  let mut value = @bigint.BigInt::from_string(digits.to_string()) * multiplier
  let shift = exponent - fraction
  if shift > 0 {
    value = value *
      @bigint.BigInt::from_int(10).pow(@bigint.BigInt::from_int(shift))
  } else if shift < 0 {
    value = value /
      @bigint.BigInt::from_int(10).pow(@bigint.BigInt::from_int(-shift))
  }
  if negative {
    -value
  } else {
    value
  }
}

///|
fn memory_size(v : Value) -> @bigint.BigInt raise ParseError {
  let value = match v {
    Number(text) => @bigint.BigInt::from_int64(long_value(text))
    Text(text) => {
      let number = Some(long_value(text)) catch { _ => None }
      match number {
        Some(n) => @bigint.BigInt::from_int64(n)
        None => {
          let (n, unit) = quantity(text)
          decimal_scaled(n, byte_multiplier(unit))
        }
      }
    }
    _ => raise Invalid("expected size-compatible value")
  }
  if value.compare_int(0) < 0 {
    raise Invalid("memory size cannot be negative")
  }
  value
}

///|
/// Exact nonnegative byte count, including units larger than int64.
pub fn get_memory_size(config : Value, key : String) -> String raise ParseError {
  memory_size(required(config, key)).to_string()
}

///|
pub fn get_bytes(config : Value, key : String) -> Int64 raise ParseError {
  let value = memory_size(required(config, key))
  if value.compare_int64(9223372036854775807L) > 0 {
    raise Invalid("byte count out of int64 range")
  }
  value.to_int64()
}
