///|
fn[T] typed_list(
  config : Value,
  key : String,
  convert : (Value, String) -> T raise ParseError,
) -> Array[T] raise ParseError {
  let result = []
  for value in get_as_list(config, key) {
    result.push(convert(Object({ "value": value }), "value"))
  }
  result
}

///|
pub fn get_string_list(
  config : Value,
  key : String,
) -> Array[String] raise ParseError {
  typed_list(config, key, get_as_string)
}

///|
pub fn get_bool_list(
  config : Value,
  key : String,
) -> Array[Bool] raise ParseError {
  typed_list(config, key, get_as_bool)
}

///|
pub fn get_int_list(
  config : Value,
  key : String,
) -> Array[Int] raise ParseError {
  typed_list(config, key, get_as_int)
}

///|
pub fn get_long_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  typed_list(config, key, get_long)
}

///|
pub fn get_double_list(
  config : Value,
  key : String,
) -> Array[Double] raise ParseError {
  typed_list(config, key, get_double)
}

///|
pub fn get_duration_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  typed_list(config, key, (item, path) => {
    match required(item, path) {
      Number(text) => scale_time(long_value(text), 1000000L)
      _ => get_duration(item, path)
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
  typed_list(config, key, (item, path) => {
    let bytes = collection_memory(required(item, path))
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
  typed_list(config, key, (item, path) => {
    collection_memory(required(item, path)).to_string()
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
  typed_list(config, key, get_config)
}
