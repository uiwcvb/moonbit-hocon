///|
/// A required transition at an exact literal path. None means absent, while
/// Some(Null) means present null. Values must already be resolved.
pub(all) struct ConfigTransitionRule {
  path : Array[String]
  before : Value?
  after : Value?
} derive(Debug)

///|
pub extend ConfigTransitionRule with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// A failed value assertion without the expected or actual value.
pub(all) struct ConfigTransitionMismatch {
  path : Array[String]
  kind : String
  side : String
} derive(Debug, Eq, ToJson)

///|
pub extend ConfigTransitionMismatch with @moonbitlang/core/debug.Debug::{
  to_repr,
}

///|
pub extend ConfigTransitionMismatch with Eq::{not_equal, equal}

///|
pub extend ConfigTransitionMismatch with ToJson::{to_json}

///|
/// A value-free review of a complete, required transition plan.
pub(all) struct ConfigTransitionReview {
  accepted : Bool
  changes : Array[ConfigChange]
  unexpected : Array[ConfigChange]
  mismatches : Array[ConfigTransitionMismatch]
  unused_rules : Array[ConfigChangeRule]
} derive(Debug, Eq, ToJson)

///|
pub extend ConfigTransitionReview with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigTransitionReview with Eq::{not_equal, equal}

///|
pub extend ConfigTransitionReview with ToJson::{to_json}

///|
fn transition_kind(before : Value?, after : Value?) -> String raise ParseError {
  match (before, after) {
    (None, Some(_)) => "added"
    (Some(_), None) => "removed"
    (Some(_), Some(_)) => "changed"
    (None, None) =>
      raise Invalid("transition must specify a before or after value")
  }
}

///|
fn transition_value(value : Value?, work : Work) -> Value? raise ParseError {
  match value {
    Some(value) => Some(unwrapped_tree(value, 0, work))
    None => None
  }
}

///|
fn transition_value_matches(
  expected : Value?,
  actual : Value?,
) -> Bool raise ParseError {
  match (expected, actual) {
    (None, None) => true
    (Some(a), Some(b)) => value_equals(a, b)
    _ => false
  }
}

///|
/// Approve only the specified resolved before/after values and complete change
/// set. Every rule must match an actual change; no unused permissions, prefixes
/// or wildcards are accepted. Lists are atomic and objects use diff granularity.
/// The returned report contains paths, kinds and mismatch sides, never values.
pub fn review_config_transition(
  before : Value,
  after : Value,
  rules : Array[ConfigTransitionRule],
) -> ConfigTransitionReview raise ParseError {
  if rules.length() > 1024 {
    raise Invalid("configuration transition exceeds 1024 rules")
  }
  let expected : Array[(Value?, Value?)] = []
  let permissions : Array[ConfigChangeRule] = []
  for rule in rules {
    permissions.push({
      path: rule.path,
      kind: transition_kind(rule.before, rule.after),
    })
  }
  let old = value_unwrapped(before)
  let next = value_unwrapped(after)
  // Validate existing path/rule budgets before serializing any policy paths.
  let review = review_config_changes(old, next, permissions)
  let paths : Map[String, Bool] = Map([])
  let work = tree_work()
  for rule in rules {
    let key = rule.path.to_json().stringify()
    if paths.contains(key) {
      raise Invalid("duplicate configuration transition path")
    }
    paths[key] = true
    let old = transition_value(rule.before, work)
    let next = transition_value(rule.after, work)
    if transition_value_matches(old, next) {
      raise Invalid("configuration transition must change a value")
    }
    expected.push((old, next))
  }
  let changes : Map[String, Bool] = Map([])
  for change in review.changes {
    changes[change_rule_key(change.path, change.kind)] = true
  }
  let mismatches : Array[ConfigTransitionMismatch] = []
  let unused_rules : Array[ConfigChangeRule] = []
  for i = 0; i < permissions.length(); i = i + 1 {
    let rule = permissions[i]
    if !changes.contains(change_rule_key(rule.path, rule.kind)) {
      unused_rules.push({ path: rule.path.copy(), kind: rule.kind, })
      continue
    }
    let (expected_before, expected_after) = expected[i]
    if !transition_value_matches(expected_before, get_path(old, rule.path)) {
      mismatches.push({
        path: rule.path.copy(),
        kind: rule.kind,
        side: "before",
      })
    }
    if !transition_value_matches(expected_after, get_path(next, rule.path)) {
      mismatches.push({
        path: rule.path.copy(),
        kind: rule.kind,
        side: "after",
      })
    }
  }
  {
    accepted: review.accepted &&
    mismatches.is_empty() &&
    unused_rules.is_empty(),
    changes: review.changes,
    unexpected: review.unexpected,
    mismatches,
    unused_rules,
  }
}
