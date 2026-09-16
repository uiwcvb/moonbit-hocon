///|
fn numeric_text(s : String) -> Bool {
  let cs = s.to_array()
  let mut i = 0
  if !cs.is_empty() && cs[0] == '-' {
    i += 1
  }
  let start = i
  while i < cs.length() && cs[i] >= '0' && cs[i] <= '9' {
    i += 1
  }
  let before = i - start
  if i < cs.length() && cs[i] == '.' {
    i += 1
    let start = i
    while i < cs.length() && cs[i] >= '0' && cs[i] <= '9' {
      i += 1
    }
    if i == start && before == 0 {
      return false
    }
  } else if before == 0 {
    return false
  }
  if i < cs.length() && (cs[i] == 'e' || cs[i] == 'E') {
    i += 1
    if i < cs.length() && (cs[i] == '+' || cs[i] == '-') {
      i += 1
    }
    let start = i
    while i < cs.length() && cs[i] >= '0' && cs[i] <= '9' {
      i += 1
    }
    if i == start {
      return false
    }
  }
  i == cs.length()
}

///|
// Exact significand rounding also handles hexadecimal subnormal boundary values.
fn hex_double(text : String) -> Double raise ParseError {
  let cs = text.to_array()
  let mut i = 2
  let mut dotted = false
  let mut fraction = 0
  let mut count = 0
  let mut significand = @bigint.BigInt::from_int(0)
  while i < cs.length() {
    let c = cs[i]
    if c == '.' && !dotted {
      dotted = true
      i += 1
      continue
    }
    let n = if c >= '0' && c <= '9' {
      c.to_int() - 48
    } else if c >= 'a' && c <= 'f' {
      c.to_int() - 87
    } else if c >= 'A' && c <= 'F' {
      c.to_int() - 55
    } else {
      break
    }
    significand = (significand << 4) + @bigint.BigInt::from_int(n)
    count += 1
    if dotted {
      fraction += 1
    }
    i += 1
  }
  if count == 0 || i >= cs.length() || !(cs[i] == 'p' || cs[i] == 'P') {
    raise Invalid("invalid hexadecimal number")
  }
  i += 1
  let negative = i < cs.length() && cs[i] == '-'
  if i < cs.length() && (cs[i] == '+' || cs[i] == '-') {
    i += 1
  }
  let begin = i
  let mut power = 0
  while i < cs.length() && cs[i] >= '0' && cs[i] <= '9' {
    power = (power * 10 + cs[i].to_int() - 48).min(1000000)
    i += 1
  }
  if i != cs.length() || i == begin {
    raise Invalid("invalid hexadecimal exponent")
  }
  let exponent = (if negative { -power } else { power }) - fraction * 4
  let bits = significand.bit_length()
  if bits == 0 {
    return 0.0
  }
  let high = bits - 1 + exponent
  if high > 1023 {
    return 1.0 / 0.0
  }
  if high < -1075 {
    return 0.0
  }
  let shift = (bits - 53).max(-1074 - exponent).max(0)
  let mut rounded = significand >> shift
  if shift > 0 {
    let lost = significand - (rounded << shift)
    let half = @bigint.BigInt::from_int(1) << (shift - 1)
    if lost > half || (lost == half && rounded.to_int64() % 2L == 1L) {
      rounded = rounded + @bigint.BigInt::from_int(1)
    }
  }
  @math.scalbn(rounded.to_int64().to_double(), exponent + shift)
}
