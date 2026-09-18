///|
pub(all) enum DurationUnit {
  Nanoseconds
  Microseconds
  Milliseconds
  Seconds
  Minutes
  Hours
  Days
} derive(Eq, Debug)

///|
pub(all) struct ConfigPeriod {
  years : Int
  months : Int
  days : Int
} derive(Eq, Debug, ToJson)

///|
pub(all) enum TemporalAmount {
  Duration(Int64)
  Period(ConfigPeriod)
} derive(Eq, Debug)

///|
pub impl ToJson for TemporalAmount with fn to_json(self) {
  match self {
    Duration(n) =>
      Json::object({ "kind": "duration", "nanoseconds": n.to_string() })
    Period(p) =>
      Json::object({
        "kind": "period",
        "years": p.years.to_json(),
        "months": p.months.to_json(),
        "days": p.days.to_json(),
      })
  }
}

///|
fn duration_unit_nanos(unit : DurationUnit) -> Int64 {
  match unit {
    Nanoseconds => 1L
    Microseconds => 1000L
    Milliseconds => 1000000L
    Seconds => 1000000000L
    Minutes => 60000000000L
    Hours => 3600000000000L
    Days => 86400000000000L
  }
}

///|
fn period_text(text : String) -> ConfigPeriod raise ParseError {
  if text.length() > 10000 {
    raise Invalid("period length limit")
  }
  let text = trim_space(text)
  let mut end = text.length()
  // Every accepted unit is ASCII. Leaving an unsupported non-ASCII suffix in
  // the number still rejects it, while preserving BMP decimal digits.
  while end > 0 &&
        (
          (text[end - 1] >= 65 && text[end - 1] <= 90) ||
          (text[end - 1] >= 97 && text[end - 1] <= 122)
        ) {
    end -= 1
  }
  let spelling = trim_space(text[:end].to_owned())
  let unit = text[end:].to_owned()
  let number = java_integer_value(spelling).unwrap_or_else(() => {
    raise Invalid("invalid period integer")
  })
  if number < -2147483648L || number > 2147483647L {
    raise Invalid("period integer out of range")
  }
  let n = number.to_int()
  match unit {
    "" | "d" | "day" | "days" => { years: 0, months: 0, days: n, }
    "w" | "week" | "weeks" => {
      let days = number * 7L
      if days < -2147483648L || days > 2147483647L {
        raise Invalid("period weeks out of range")
      }
      { years: 0, months: 0, days: days.to_int(), }
    }
    "m" | "mo" | "month" | "months" => { years: 0, months: n, days: 0, }
    "y" | "year" | "years" => { years: n, months: 0, days: 0, }
    _ => raise Invalid("unknown period unit: " + unit)
  }
}

///|
/// Calendar period; unitless values are days and months remain unnormalized.
pub fn get_period(
  config : Value,
  key : String,
) -> ConfigPeriod raise ParseError {
  period_text(get_as_string(config, key))
}

///|
/// Duration takes precedence: unitless values are milliseconds and m is minutes.
pub fn get_temporal(
  config : Value,
  key : String,
) -> TemporalAmount raise ParseError {
  let text = get_as_string(config, key)
  Duration(duration_text(text)) catch {
    _ => Period(period_text(text))
  }
}

///|
pub fn get_duration_in(
  config : Value,
  key : String,
  unit : DurationUnit,
) -> Int64 raise ParseError {
  get_duration(config, key) / duration_unit_nanos(unit)
}

///|
pub fn get_duration_list_in(
  config : Value,
  key : String,
  unit : DurationUnit,
) -> Array[Int64] raise ParseError {
  let scale = duration_unit_nanos(unit)
  get_as_list(config, key).map(value => {
    match value {
      Number(text) => {
        let millis = long_value(text)
        // Numeric list elements convert directly from milliseconds. Converting
        // through saturated nanoseconds first loses large millisecond values.
        if scale >= 1000000L {
          millis / (scale / 1000000L)
        } else {
          scale_time(millis, 1000000L / scale)
        }
      }
      Text(text) | Bare(text) => duration_text(text) / scale
      _ => raise Invalid("expected duration-compatible list element")
    }
  })
}

///|
pub fn get_milliseconds(config : Value, key : String) -> Int64 raise ParseError {
  get_duration_in(config, key, Milliseconds)
}

///|
pub fn get_nanoseconds(config : Value, key : String) -> Int64 raise ParseError {
  get_duration(config, key)
}

///|
pub fn get_milliseconds_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  get_duration_list_in(config, key, Milliseconds)
}

///|
pub fn get_nanoseconds_list(
  config : Value,
  key : String,
) -> Array[Int64] raise ParseError {
  get_duration_list_in(config, key, Nanoseconds)
}
