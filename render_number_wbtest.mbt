///|
test "tiny interval encloses exact smallest binary64" {
  let five = @bigint.BigInt::from_int(5)
  let ten = @bigint.BigInt::from_int(10)
  let exact = five.pow(@bigint.BigInt::from_int(1074))
  let scale = ten.pow(@bigint.BigInt::from_int(735))
  let lower = @bigint.BigInt::from_int64(4940656458412465L) * scale
  let upper = @bigint.BigInt::from_int64(4940656458412466L) * scale
  assert_true(lower < exact)
  assert_true(exact < upper)
}
