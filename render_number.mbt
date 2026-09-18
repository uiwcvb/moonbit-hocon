///|
fn render_number(value : Value) -> String raise ParseError {
  match number_value(value) {
    Integer(n) => n.to_string()
    Long(n) => n.to_string()
    Floating(n) => render_double(n)
  }
}

///|
// Find the nearest shortest decimal that round-trips to the exact binary value.
// Scientific output has at least two significant digits, as in the pinned JDK.
// This uses exact integer arithmetic, not host locale/printf formatting.
fn render_double(value : Double) -> String raise ParseError {
  if value.is_nan() {
    return "NaN"
  }
  if value.is_inf() {
    return if value > 0.0 { "Infinity" } else { "-Infinity" }
  }
  let bits = value.reinterpret_as_int64()
  let sign = if bits < 0L { "-" } else { "" }
  if value == 0.0 {
    return sign + "0.0"
  }
  let exponent = ((bits >> 52) & 2047L).to_int()
  let fraction = bits & 4503599627370495L
  let mantissa = if exponent == 0 {
    fraction
  } else {
    fraction + 4503599627370496L
  }
  let power = if exponent == 0 { -1074 } else { exponent - 1075 }
  let mut integer = @bigint.BigInt::from_int64(mantissa)
  let scale = if power >= 0 { 0 } else { -power }
  if power >= 0 {
    integer = integer << power
  } else {
    integer = integer *
      @bigint.BigInt::from_int(5).pow(@bigint.BigInt::from_int(scale))
  }
  let exact = integer.to_string()
  let original_exponent = exact.length() - scale - 1
  let scientific = original_exponent < -3 || original_exponent >= 7
  for precision = (if scientific { 2 } else { 1 })
      precision <= 17
      precision = precision + 1 {
    let count = precision.min(exact.length())
    let prefix = exact.view(end_offset=count).to_owned()
    let mut significant = @string.parse_int64(prefix) catch {
      _ => raise Invalid("decimal conversion")
    }
    if count < exact.length() {
      let next = exact[count].to_int()
      let mut tail = false
      for i = count + 1; i < exact.length(); i = i + 1 {
        if exact[i] != 48 {
          tail = true
          break
        }
      }
      if next > 53 || (next == 53 && (tail || significant % 2L == 1L)) {
        significant += 1L
      }
    }
    let digits = significant.to_string()
    let exponent = original_exponent + digits.length() - count
    let candidate = digits.view(end_offset=1).to_owned() +
      "." +
      (if digits.length() == 1 {
        "0"
      } else {
        digits.view(start_offset=1).to_owned()
      }) +
      "e" +
      exponent.to_string()
    let rounded = double_value(sign + candidate)
    if rounded.reinterpret_as_int64() == bits {
      let mut end = digits.length()
      while end > 1 && digits[end - 1] == 48 {
        end -= 1
      }
      let digits = digits.view(end_offset=end).to_owned()
      if exponent < -3 || exponent >= 7 {
        return sign +
          digits.view(end_offset=1).to_owned() +
          "." +
          (if digits.length() > 1 {
            digits.view(start_offset=1).to_owned()
          } else {
            "0"
          }) +
          "E" +
          exponent.to_string()
      }
      let output = StringBuilder()
      output.write_string(sign)
      let point = exponent + 1
      if point <= 0 {
        output.write_string("0.")
        for _ in 0..<-point {
          output.write_string("0")
        }
        output.write_string(digits)
      } else if point >= digits.length() {
        output.write_string(digits)
        for _ in digits.length()..<point {
          output.write_string("0")
        }
        output.write_string(".0")
      } else {
        output.write_string(digits.view(end_offset=point).to_owned())
        output.write_string(".")
        output.write_string(digits.view(start_offset=point).to_owned())
      }
      return output.to_string()
    }
  }
  raise Invalid("decimal conversion failed")
}
