///|
test "optimized paths retain budgets, independent arrays and source comments" {
  let parts = @hocon.split_path("a.b")
  parts.clear()
  assert_eq(@hocon.split_path("a.b"), ["a", "b"])
  let maximum = Array::make(32, "a").join(".")
  assert_eq(@hocon.split_path(maximum).length(), 32)
  let excessive_depth = try {
    ignore(@hocon.split_path(maximum + ".a"))
    false
  } catch {
    _ => true
  }
  assert_true(excessive_depth)
  let large = "a".repeat(100000)
  assert_eq(@hocon.split_path(large), [large])
  let excessive_text = try {
    ignore(@hocon.split_path(large + "a"))
    false
  } catch {
    _ => true
  }
  assert_true(excessive_text)
  assert_eq(@hocon.get_as_int(@hocon.parse("a=1 # source comment"), "a"), 1)
}
