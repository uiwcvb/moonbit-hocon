///|
/// An exact permitted change: literal path segments and added/removed/changed.
/// Rules do not match descendants and never contain configuration values.
pub(all) struct ConfigChangeRule {
  path : Array[String]
  kind : String
} derive(Debug, Eq, ToJson)

///|
pub extend ConfigChangeRule with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigChangeRule with Eq::{not_equal, equal}

///|
pub extend ConfigChangeRule with ToJson::{to_json}

///|
pub(all) struct ConfigChangeReview {
  accepted : Bool
  changes : Array[ConfigChange]
  unexpected : Array[ConfigChange]
} derive(Debug, Eq, ToJson)

///|
pub extend ConfigChangeReview with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigChangeReview with Eq::{not_equal, equal}

///|
pub extend ConfigChangeReview with ToJson::{to_json}

///|
fn change_rule_key(path : Array[String], kind : String) -> String {
  // JSON segments distinguish a literal dotted key from a nested path.
  kind + ":" + path.to_json().stringify()
}

///|
/// Review resolved configuration changes against an exact allow-list.
/// An empty policy accepts only semantic equality. No prefix or wildcard match
/// is performed, so allowing a leaf edit cannot allow removal of its parent.
/// Unused rules are allowed; this is a permission check, not a required-change
/// assertion. Values and deployment safety remain the caller's responsibility.
pub fn review_config_changes(
  before : Value,
  after : Value,
  rules : Array[ConfigChangeRule],
) -> ConfigChangeReview raise ParseError {
  if rules.length() > 1024 {
    raise Invalid("configuration change policy exceeds 1024 rules")
  }
  let allowed : Map[String, Bool] = Map([])
  let mut characters = 0
  for rule in rules {
    if rule.path.is_empty() || rule.path.length() > 32 {
      raise Invalid(
        "configuration change policy path must have 1 to 32 segments",
      )
    }
    if rule.kind != "added" && rule.kind != "removed" && rule.kind != "changed" {
      raise Invalid("invalid configuration change policy kind")
    }
    for segment in rule.path {
      if segment.length() > 65536 - characters {
        raise Invalid("configuration change policy exceeds character limit")
      }
      characters += segment.length()
    }
    let key = change_rule_key(rule.path, rule.kind)
    if allowed.contains(key) {
      raise Invalid("duplicate configuration change policy rule")
    }
    allowed[key] = true
  }
  let changes = diff_resolved_configs(before, after)
  let unexpected = changes.filter(change => {
    !allowed.contains(change_rule_key(change.path, change.kind))
  })
  { accepted: unexpected.is_empty(), changes, unexpected, }
}
