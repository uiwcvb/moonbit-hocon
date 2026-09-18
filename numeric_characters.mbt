// Generated JDK 22.0.1 radix-10 digit blocks. Java integer parsing uses UTF-16 chars.
// Regenerate with node tools/generate-numeric-characters.mjs [--live].

///|
let numeric_digit_starts : Array[Int] = [
  48, 1632, 1776, 1984, 2406, 2534, 2662, 2790, 2918, 3046, 3174, 3302, 3430, 3558,
  3664, 3792, 3872, 4160, 4240, 6112, 6160, 6470, 6608, 6784, 6800, 6992, 7088, 7232,
  7248, 42528, 43216, 43264, 43472, 43504, 43600, 44016, 65296,
]

///|
fn numeric_digit(cp : Int) -> Int {
  if cp >= 48 && cp <= 57 {
    return cp - 48
  }
  if cp < 128 || cp > 65535 {
    return -1
  }
  let mut low = 0
  let mut high = numeric_digit_starts.length()
  while low < high {
    let middle = low + (high - low) / 2
    let start = numeric_digit_starts[middle]
    if cp < start {
      high = middle
    } else if cp > start + 9 {
      low = middle + 1
    } else {
      return cp - start
    }
  }
  -1
}
