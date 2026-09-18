///|
pub(all) struct ValidationProblem {
  path : String
  kind : String
  expected : String
  actual : String
} derive(Debug, Eq, ToJson)

///|
pub suberror ValidationError {
  ValidationFailed(Array[ValidationProblem])
} derive(Debug)

///|
fn type_name(value : Value) -> String {
  match value {
    Text(_) | Bare(_) => "string"
    Number(_) => "number"
    Boolean(_) => "boolean"
    Object(_) => "object"
    List(_) => "list"
    Null => "null"
    _ => "unresolved"
  }
}

///|
fn validation_compatible(reference : Value, value : Value) -> Bool {
  match (reference, value) {
    (Null | Text("null") | Bare("null"), _)
    | (_, Null | Text("null") | Bare("null")) => true
    (Object(_), Object(_)) => true
    (Object(_), _) => false
    (List(_), List(_) | Object(_)) => true
    (List(_), _) => false
    (Text(_) | Bare(_), _) | (_, Text(_) | Bare(_)) => true
    _ => type_name(reference) == type_name(value)
  }
}

///|
fn validation_problem(
  parts : Array[String],
  kind : String,
  reference : Value,
  actual : String,
) -> ValidationProblem raise ParseError {
  { path: join_path(parts), kind, expected: type_name(reference), actual, }
}

///|
fn validate_pair(
  reference : Value,
  value : Value,
  parts : Array[String],
  problems : Array[ValidationProblem],
  work : Work,
) -> Unit raise ParseError {
  work.spend(1)
  if !validation_compatible(reference, value) {
    problems.push(
      validation_problem(parts, "wrong-type", reference, type_name(value)),
    )
    return
  }
  match (reference, value) {
    (Object(expected), Object(actual)) =>
      for key, child in expected {
        let next = parts.copy()
        next.push(key)
        match actual.get(key) {
          None =>
            problems.push(validation_problem(next, "missing", child, "missing"))
          Some(v) => validate_pair(child, v, next, problems, work)
        }
      }
    (List(expected), List(_) | Object(_)) => {
      let actual = get_as_list(Object({ "value": value }), "value") catch {
        _ => {
          problems.push(
            validation_problem(parts, "wrong-type", reference, type_name(value)),
          )
          return
        }
      }
      if !expected.is_empty() {
        for item in actual {
          work.spend(1)
          if !validation_compatible(expected[0], item) {
            problems.push(
              validation_problem(
                parts,
                "list-element",
                expected[0],
                type_name(item),
              ),
            )
            break
          }
        }
      }
    }
    _ => ()
  }
}

///|
/// Collect all missing/type problems, retaining duplicate restricted paths.
/// Like checkValid, this is a structural check, not application-level validation.
pub fn validation_problems(
  config : Value,
  reference : Value,
  paths? : Array[String] = [],
) -> Array[ValidationProblem] raise ParseError {
  ignore(object_fields(config))
  ignore(object_fields(reference))
  if !is_resolved(reference) {
    raise Invalid("validation reference is unresolved")
  }
  if !is_resolved(config) {
    raise Invalid("configuration to validate is unresolved")
  }
  let result = []
  let work = tree_work()
  if paths.is_empty() {
    validate_pair(reference, config, [], result, work)
  } else {
    for path in paths {
      work.spend(path.length() + 1)
      let parts = split_path(path)
      match get_path(reference, parts) {
        None => ()
        Some(expected) =>
          match get_path(config, parts) {
            None =>
              result.push(
                validation_problem(parts, "missing", expected, "missing"),
              )
            Some(actual) => validate_pair(expected, actual, parts, result, work)
          }
      }
    }
  }
  result
}

///|
pub fn check_valid(
  config : Value,
  reference : Value,
  paths? : Array[String] = [],
) -> Unit raise {
  let problems = validation_problems(config, reference, paths~)
  if !problems.is_empty() {
    raise ValidationFailed(problems)
  }
}
