///|
pub extend ConfigNumber with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigNumber with Eq::{not_equal, equal}

///|
pub extend ConfigNumber with ToJson::{to_json}

///|
pub extend ConfigPeriod with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigPeriod with Eq::{not_equal, equal}

///|
pub extend ConfigPeriod with ToJson::{to_json}

///|
pub extend DurationUnit with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend DurationUnit with Eq::{not_equal, equal}

///|
pub extend IncludeRequest with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend IncludeRequest with Eq::{not_equal, equal}

///|
pub extend IncludeRequest with ToJson::{to_json}

///|
pub extend IncludeSource with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend IncludeSource with Eq::{not_equal, equal}

///|
pub extend ParseError with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend SourcePosition with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend SourcePosition with Eq::{not_equal, equal}

///|
pub extend SourcePosition with ToJson::{to_json}

///|
pub extend TemporalAmount with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend TemporalAmount with Eq::{not_equal, equal}

///|
pub extend TemporalAmount with ToJson::{to_json}

///|
pub extend ValidationError with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ValidationProblem with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ValidationProblem with Eq::{not_equal, equal}

///|
pub extend ValidationProblem with ToJson::{to_json}

///|
pub extend Value with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Value with Eq::{not_equal, equal}
