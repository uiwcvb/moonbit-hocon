///|
// Validate the unsigned Java decimal grammar and locate its decimal magnitude.
// Ordinary inputs keep the runtime's fast conversion. Tiny values use a single
// exact rational rounding instead of repeated decimal-array binary shifts.
fn decimal_double(text : String) -> Double raise ParseError {
  let mut i = 0
  let mut digits = 0
  let mut leading = 0
  let mut trailing = 0
  let mut fraction = 0
  let mut dotted = false
  while i < text.length() {
    let c = text[i].to_int()
    if c >= 48 && c <= 57 {
      if c == 48 {
        if leading == digits {
          leading += 1
        }
        trailing += 1
      } else {
        trailing = 0
      }
      digits += 1
      if dotted {
        fraction += 1
      }
    } else if c == 46 && !dotted {
      dotted = true
    } else {
      break
    }
    i += 1
  }
  if digits == 0 {
    raise Invalid("invalid decimal number")
  }
  let mantissa_end = i
  let mut exponent = 0
  if i < text.length() && (text[i] == 69 || text[i] == 101) {
    i += 1
    let negative = i < text.length() && text[i] == 45
    if i < text.length() && (text[i] == 43 || text[i] == 45) {
      i += 1
    }
    let start = i
    while i < text.length() && text[i] >= 48 && text[i] <= 57 {
      exponent = (exponent * 10 + text[i].to_int() - 48).min(1000000)
      i += 1
    }
    if i == start {
      raise Invalid("invalid decimal exponent")
    }
    if negative {
      exponent = -exponent
    }
  }
  if i != text.length() {
    raise Invalid("invalid decimal number")
  }
  if leading == digits {
    return 0.0
  }
  let magnitude = digits - leading + exponent - fraction - 1
  if magnitude < -324 {
    return 0.0
  }
  if magnitude > 308 {
    return 1.0 / 0.0
  }
  let significant_count = digits - leading - trailing
  if magnitude <= -308 && significant_count <= 768 {
    let coefficient = StringBuilder()
    let mut position = 0
    for j = 0; j < mantissa_end; j = j + 1 {
      if text[j] != 46 {
        if position >= leading && position < digits - trailing {
          coefficient.write_char(text[j].to_int().unsafe_to_char())
        }
        position += 1
      }
    }
    return tiny_decimal_ratio(
      @bigint.BigInt::from_string(coefficient.to_string()),
      exponent - fraction + trailing,
    )
  }
  @string.parse_double(text) catch {
    Failure::Failure("value out of range") => 1.0 / 0.0
    _ => raise Invalid("invalid decimal number")
  }
}

///|
// For N * 10^p, p < 0, write the exact value as N / 5^-p * 2^p.
// Locate its binary exponent, divide at the required binary64 spacing, then
// round the exact quotient/remainder once, with midpoint ties to even.
fn tiny_decimal_ratio(numerator : @bigint.BigInt, power : Int) -> Double {
  let denominator = @bigint.BigInt::from_int(5).pow(
    @bigint.BigInt::from_int(-power),
  )
  let mut ratio_exponent = numerator.bit_length() - denominator.bit_length()
  let below = if ratio_exponent >= 0 {
    numerator < denominator << ratio_exponent
  } else {
    numerator << -ratio_exponent < denominator
  }
  if below {
    ratio_exponent -= 1
  }
  let mut exponent = ratio_exponent + power
  if exponent < -1075 {
    return 0.0
  }
  let subnormal = exponent < -1022
  let shift = if subnormal { power + 1074 } else { 52 - ratio_exponent }
  let numerator = if shift >= 0 { numerator << shift } else { numerator }
  let denominator = if shift < 0 { denominator << -shift } else { denominator }
  let quotient = numerator / denominator
  let remainder = numerator - quotient * denominator
  let twice = remainder << 1
  let mut rounded = quotient.to_int64()
  if twice > denominator || (twice == denominator && rounded % 2L == 1L) {
    rounded += 1L
  }
  if subnormal {
    return rounded.reinterpret_as_double()
  }
  if rounded == 9007199254740992L {
    rounded = rounded >> 1
    exponent += 1
  }
  (((exponent + 1023).to_int64() << 52) | (rounded - 4503599627370496L)).reinterpret_as_double()
}
