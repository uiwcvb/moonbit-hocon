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
  let mut coefficient = 0.0
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
      if digits - leading <= 16 {
        coefficient = coefficient * 10.0 + (c - 48).to_double()
      }
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
  let power = exponent - fraction
  // Each accumulated integer up to 2^53-1 and each 10^k, 0 <= k <= 22,
  // is exactly representable. A single multiply/divide therefore gives the
  // correctly rounded decimal value. The strict bound excludes integers
  // above 2^53 that the accumulation itself might already have rounded.
  if digits - leading <= 16 &&
    coefficient < 9007199254740992.0 &&
    power >= -22 &&
    power <= 22 {
    return if power < 0 {
      coefficient / decimal_exact_powers[-power]
    } else {
      coefficient * decimal_exact_powers[power]
    }
  }
  let significant_count = digits - leading - trailing
  if magnitude <= -308 {
    let power = exponent - fraction + trailing
    // A discarded suffix lies between consecutive prefix integers. Equal
    // rounded endpoints prove the full input has that same binary64 result.
    // If 32 digits straddle a boundary, 768 suffice for an exact decision:
    // prefix_power = magnitude - 767 <= -1075. Every binary64 midpoint is
    // an integer multiple of 2^-1075, hence of this decimal grid spacing.
    // No midpoint is strictly inside the discarded suffix's open interval.
    // A nonzero suffix therefore only changes an exact lower-endpoint tie.
    for keep in [32, 768] {
      let count = keep.min(significant_count)
      let prefix = decimal_coefficient(text, mantissa_end, leading, count)
      let prefix_power = power + significant_count - count
      if keep == 768 {
        // significant_count excludes trailing zeros, so a truncated suffix
        // is strictly positive. Exact inputs retain round-to-nearest-even.
        return tiny_decimal_text(
          prefix,
          prefix_power,
          sticky=count < significant_count,
        )
      }
      let lower = tiny_decimal_text(prefix, prefix_power)
      if count == significant_count {
        return lower
      }
      let upper = tiny_decimal_ratio(
        @bigint.BigInt::from_string(prefix) + @bigint.BigInt::from_int(1),
        prefix_power,
      )
      if lower == upper {
        return lower
      }
    }
  }
  @string.parse_double(text) catch {
    Failure::Failure("value out of range") => 1.0 / 0.0
    _ => raise Invalid("invalid decimal number")
  }
}

///|
let decimal_exact_powers : ReadOnlyArray[Double] = [
  1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0, 100000000.0,
  1000000000.0, 10000000000.0, 100000000000.0, 1000000000000.0, 10000000000000.0,
  100000000000000.0, 1000000000000000.0, 10000000000000000.0, 100000000000000000.0,
  1000000000000000000.0, 10000000000000000000.0, 100000000000000000000.0, 1000000000000000000000.0,
  10000000000000000000000.0,
]

///|
fn decimal_coefficient(
  text : String,
  mantissa_end : Int,
  leading : Int,
  count : Int,
) -> String {
  let coefficient = StringBuilder()
  let mut position = 0
  for j = 0; j < mantissa_end && position < leading + count; j = j + 1 {
    if text[j] != 46 {
      if position >= leading {
        coefficient.write_char(text[j].to_int().unsafe_to_char())
      }
      position += 1
    }
  }
  coefficient.to_string()
}

///|
fn tiny_decimal_text(
  coefficient : String,
  power : Int,
  sticky? : Bool = false,
) -> Double {
  let mut end = coefficient.length()
  while end > 1 && coefficient[end - 1] == 48 {
    end -= 1
  }
  tiny_decimal_ratio(
    @bigint.BigInt::from_string(coefficient.view(end_offset=end).to_owned()),
    power + coefficient.length() - end,
    sticky~,
  )
}

///|
// For N * 10^p, p < 0, write the exact value as N / 5^-p * 2^p.
// Locate its binary exponent, divide at the required binary64 spacing, then
// round the exact quotient/remainder once, with midpoint ties to even.
// sticky is permitted only when the caller proves that a strictly positive
// discarded suffix cannot cross another midpoint; it moves a tie upward.
fn tiny_decimal_ratio(
  numerator : @bigint.BigInt,
  power : Int,
  sticky? : Bool = false,
) -> Double {
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
  if twice > denominator ||
    (twice == denominator && (sticky || rounded % 2L == 1L)) {
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
