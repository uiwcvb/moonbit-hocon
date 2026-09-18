///|
fn time_unit(request : Json) -> @lib.DurationUnit raise {
  match request {
    { "unit": String("nanoseconds"), .. } => @lib.Nanoseconds
    { "unit": String("microseconds"), .. } => @lib.Microseconds
    { "unit": String("milliseconds"), .. } => @lib.Milliseconds
    { "unit": String("seconds"), .. } => @lib.Seconds
    { "unit": String("minutes"), .. } => @lib.Minutes
    { "unit": String("hours"), .. } => @lib.Hours
    { "unit": String("days"), .. } => @lib.Days
    _ => raise BadGetter
  }
}
