///|
test "period retains calendar fields and temporal selects its public variant" {
  let config = @hocon.parse("a=12months\nb=2m\nc=2weeks\nd=2")
  let period = @hocon.get_period(config, "a")
  assert_eq((period.years, period.months, period.days), (0, 12, 0))
  assert_eq(@hocon.get_temporal(config, "a"), @hocon.Period(period))
  assert_eq(@hocon.get_temporal(config, "b"), @hocon.Duration(120000000000L))
  assert_eq(@hocon.get_temporal(config, "d"), @hocon.Duration(2000000L))
  assert_eq(@hocon.get_period(config, "c").days, 14)
  assert_eq(@hocon.get_period(config, "d").days, 2)
}

///|
test "numeric duration lists avoid an intermediate saturated nanosecond value" {
  let config = @hocon.parse(
    "a=[9223372036854775807,\"9223372036854775807\",-9223372036854775808]\nb=\"-1999ns\"",
  )
  assert_eq(@hocon.get_milliseconds_list(config, "a"), [
    9223372036854775807L, 9223372036854L, -9223372036854775808L,
  ])
  assert_eq(@hocon.get_duration_in(config, "b", @hocon.Microseconds), -1L)
}

///|
test "raw known time values read without resolving unrelated references" {
  let raw = @hocon.parse_unresolved("a=2months\nb=[1ms,2ms]\nc=${unknown}")
  assert_eq(@hocon.get_period(raw, "a").months, 2)
  assert_eq(@hocon.get_duration_list_in(raw, "b", @hocon.Microseconds), [
    1000L, 2000L,
  ])
  assert_false(@hocon.is_resolved(raw))
  assert_true(
    try {
      ignore(@hocon.get_temporal(raw, "c"))
      false
    } catch {
      _ => true
    },
  )
}
