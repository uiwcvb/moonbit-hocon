///|
test "partial delayed root cannot look below an unresolved layer for fallback reference" {
  let original = @hocon.parse_unresolved("a=${missing}\na={known=1}")
  let child = @hocon.get_config(original, "a")
  let fallback = @hocon.parse_unresolved("outside=3\nresult=${outside}")
  for
    merged in [
      @hocon.with_fallback(child, fallback),
      @hocon.value_with_fallback(child, fallback),
    ] {
    assert_true(
      try {
        ignore(@hocon.resolve(merged, allow_unresolved=true))
        false
      } catch {
        _ => true
      },
    )
  }
  // A rejected detached branch must not mutate its original parse tree.
  assert_eq(@hocon.get_int(original, "a.known"), 1)
}

///|
test "partial delayed root retains unrelated fallback without forced resolution" {
  let child = @hocon.get_config(
    @hocon.parse_unresolved("a=${missing}\na={known=1}"),
    "a",
  )
  let merged = @hocon.with_fallback(child, @hocon.parse("outside=3"))
  let partial = @hocon.resolve(merged, allow_unresolved=true)
  assert_false(@hocon.is_resolved(partial))
  assert_eq(@hocon.get_int(partial, "known"), 1)
}

///|
test "higher known leaf permits fallback reference through delayed root" {
  let child = @hocon.get_config(
    @hocon.parse_unresolved("a=${missing}\na={outside=9}"),
    "a",
  )
  let merged = @hocon.with_fallback(
    child,
    @hocon.parse_unresolved("outside=3\nresult=${outside}"),
  )
  let partial = @hocon.resolve(merged, allow_unresolved=true)
  assert_false(@hocon.is_resolved(partial))
  // The scalar above the unresolved layer is visible and ignores fallbacks.
  assert_eq(@hocon.get_int(partial, "outside"), 9)
}
