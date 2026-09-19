///|
fn[T] typed_list(
  config : Value,
  key : String,
  convert : (Value) -> T raise ParseError,
) -> Array[T] raise ParseError {
  let result = []
  for value in collection_values(required(config, key)) {
    result.push(convert(value))
  }
  result
}

///|
// Preserve the former singleton getter's null/unresolved diagnostics and Bare
// conversion, without allocating an object or reparsing its constant path.
fn required_list_value(value : Value) -> Value raise ParseError {
  match required_leaf(value, "value") {
    Bare(text) => Text(text)
    value => value
  }
}

///|
pub fn get_string_list(
  config : Value,
  key : String,
) -> Array[String] raise ParseError {
  typed_list(config, key, value => string_value(required_list_value(value)))
}

///|
pub fn get_bool_list(
  config : Value,
  key : String,
) -> Array[Bool] raise ParseError {
  typed_list(config, key, value => bool_value(required_list_value(value)))
}

///|
pub fn get_int_list(
  config : Value,
  key : String,
) -> Array[Int] raise ParseError {
  typed_list(config, key, value => {
    let n = long_value(number_text(required_list_value(value)))
    if n < -2147483648L || n > 2147483647L {
      raise Invalid("integer out of 32-bit range")
    }
    n.to_int()
  })
}

///|
pub fn get_long_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  typed_list(config, key, value => {
    long_value(number_text(required_list_value(value)))
  })
}

///|
pub fn get_double_list(
  config : Value,
  key : String,
) -> Array[Double] raise ParseError {
  typed_list(config, key, value => number_double(required_list_value(value)))
}

///|
pub fn get_duration_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  typed_list(config, key, value => {
    match required_list_value(value) {
      Number(text) => scale_time(long_value(text), 1000000L)
      value => duration_text(number_text(value))
    }
  })
}

///|
// Collection strings use decimal quantity parsing directly. Unlike scalar
// memory getters, they do not first undergo Java floating-point coercion.
fn collection_memory(value : Value) -> @bigint.BigInt raise ParseError {
  let bytes = match value {
    Number(text) => @bigint.BigInt::from_int64(long_value(text))
    Text(text) => {
      let (number, unit) = quantity(text)
      decimal_scaled(number, byte_multiplier(unit))
    }
    _ => raise Invalid("expected size-compatible list element")
  }
  if bytes.compare_int(0) < 0 {
    raise Invalid("memory size cannot be negative")
  }
  bytes
}

///|
pub fn get_bytes_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  typed_list(config, key, value => {
    let bytes = collection_memory(required_list_value(value))
    if bytes.compare_int64(9223372036854775807L) > 0 {
      raise Invalid("byte count out of int64 range")
    }
    bytes.to_int64()
  })
}

///|
pub fn get_memory_size_list(
  config : Value,
  key : String,
) -> Array[String] raise ParseError {
  typed_list(config, key, value => {
    collection_memory(required_list_value(value)).to_string()
  })
}

///|
pub fn get_config(config : Value, key : String) -> Value raise ParseError {
  let value = peek_document_path(config, key).unwrap_or_else(() => {
    raise Invalid("missing path: " + key)
  })
  if !known_object(value) {
    raise Invalid("expected object-compatible value")
  }
  copy_value(value)
}

///|
pub fn get_config_list(
  config : Value,
  key : String,
) -> Array[Value] raise ParseError {
  typed_list(config, key, value => {
    if !known_object(value) {
      raise Invalid("expected object-compatible value")
    }
    copy_value(value)
  })
}
