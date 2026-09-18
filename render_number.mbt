///|
fn render_number(value : Value) -> String raise ParseError {
  match number_value(value) {
    Integer(n) => n.to_string()
    Long(n) => n.to_string()
    Floating(n) => render_double(n)
  }
}

///|
// Reuse the runtime's nearest shortest decimal and normalize the JDK layout.
// A tiny one-digit subnormal needs rounding to a second digit instead:
// e.g. the smallest subnormal is 4.9E-324, not the runtime's 5e-324.
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
  let raw = (if value < 0.0 { -value } else { value }).to_string()
  let digits = StringBuilder()
  let mut point = -1
  let mut shift = 0
  let mut count = 0
  for i = 0; i < raw.length(); i = i + 1 {
    match raw[i] {
      46 => point = count
      69 | 101 => {
        shift = @string.parse_int(raw.view(start_offset=i + 1)) catch {
          _ => raise Invalid("decimal exponent conversion")
        }
        break
      }
      digit => {
        digits.write_char(digit.to_int().unsafe_to_char())
        count += 1
      }
    }
  }
  if point < 0 {
    point = count
  }
  let digits = digits.to_string()
  let mut start = 0
  let mut end = digits.length()
  while start < end - 1 && digits[start] == 48 {
    start += 1
  }
  let exponent = shift + point - start - 1
  while end > start + 1 && digits[end - 1] == 48 {
    end -= 1
  }
  // Above this threshold, half an ulp is smaller than half the spacing of
  // two-digit decimals, including the finer spacing below a decimal power.
  if end - start > 1 || exponent >= -321 {
    return format_double_digits(
      sign,
      digits.view(start_offset=start, end_offset=end).to_owned(),
      exponent,
    )
  }
  render_tiny_double(bits, sign)
}

///|
fn render_tiny_double(bits : Int64, sign : String) -> String raise ParseError {
  let mantissa = bits & 4503599627370495L
  // MIN_VALUE lies strictly between A * 10^-339 and (A + 1) * 10^-339.
  // Propagate this exact interval through integer arithmetic. A boundary
  // overlap falls back to full precision; no floating-point rounding is used.
  // The caller's one-digit exponent <= -322 implies mantissa <= 182.
  // Retain a guard for the multiplication if this helper's domain changes.
  if mantissa > 1000L {
    return render_double_exact(bits, sign)
  }
  let lower = mantissa * 4940656458412465L
  let upper = lower + mantissa
  let length = lower.to_string().length()
  if upper.to_string().length() != length {
    return render_double_exact(bits, sign)
  }
  let mut divisor = 1L
  for _ in 0..<(length - 2) {
    divisor *= 10L
  }
  let remainder = lower % divisor
  if remainder * 2L <= divisor && (remainder + mantissa) * 2L >= divisor {
    return render_double_exact(bits, sign)
  }
  let significant = lower / divisor +
    (if remainder * 2L > divisor { 1L } else { 0L })
  let digits = significant.to_string()
  let exponent = length - 340 + digits.length() - 2
  let mut end = digits.length()
  while end > 1 && digits[end - 1] == 48 {
    end -= 1
  }
  format_double_digits(sign, digits.view(end_offset=end).to_owned(), exponent)
}

///|
fn render_double_exact(bits : Int64, sign : String) -> String raise ParseError {
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
      return format_double_digits(sign, digits, exponent)
    }
  }
  raise Invalid("decimal conversion failed")
}

///|
fn format_double_digits(
  sign : String,
  digits : String,
  exponent : Int,
) -> String {
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
  output.to_string()
}
