///|
/// A value-free description of a change between two resolved configurations.
/// `path` contains literal object keys, so a key containing a period is not
/// confused with a nested path. Lists are compared as one value.
pub(all) struct ConfigChange {
  path : Array[String]
  kind : String
  before_type : String?
  after_type : String?
} derive(Debug, Eq, ToJson)

///|
pub extend ConfigChange with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend ConfigChange with Eq::{not_equal, equal}

///|
pub extend ConfigChange with ToJson::{to_json}

///|
fn push_config_change(
  output : Array[ConfigChange],
  path : Array[String],
  kind : String,
  before_type : String?,
  after_type : String?,
) -> Unit raise ParseError {
  if output.length() >= 4096 {
    raise Invalid("configuration diff exceeds 4096 changes")
  }
  output.push({ path: path.copy(), kind, before_type, after_type, })
}

///|
fn compare_config_trees(
  before : Value,
  after : Value,
  path : Array[String],
  output : Array[ConfigChange],
  depth : Int,
  work : Work,
) -> Unit raise ParseError {
  tree_step(before, depth, work)
  tree_step(after, depth, work)
  match (before, after) {
    (Object(old), Object(new)) => {
      let keys = old.keys().collect()
      for key in new.keys() {
        if !old.contains(key) {
          keys.push(key)
        }
      }
      keys.sort_by(java_key_compare)
      for key in keys {
        work.spend(key.length())
        if path.length() >= 32 {
          raise Invalid("configuration diff path depth limit")
        }
        let child_path = path.copy()
        child_path.push(key)
        match (old.get(key), new.get(key)) {
          (Some(a), Some(b)) =>
            compare_config_trees(a, b, child_path, output, depth + 1, work)
          (Some(a), None) =>
            push_config_change(
              output,
              child_path,
              "removed",
              Some(value_type(a)),
              None,
            )
          (None, Some(b)) =>
            push_config_change(
              output,
              child_path,
              "added",
              None,
              Some(value_type(b)),
            )
          _ => ()
        }
      }
    }
    _ =>
      if !value_equals(before, after) {
        push_config_change(
          output,
          path,
          "changed",
          Some(value_type(before)),
          Some(value_type(after)),
        )
      }
  }
}

///|
/// Compare two already resolved HOCON object roots without disclosing values.
/// Additions and removals are reported at their nearest object key; lists are
/// atomic. The caller decides whether each change is allowed for its migration.
/// Rejects unresolved values and bounds work, nesting, paths and report size.
pub fn diff_resolved_configs(
  before : Value,
  after : Value,
) -> Array[ConfigChange] raise ParseError {
  let old = value_unwrapped(before)
  let new = value_unwrapped(after)
  ignore(object_fields(old))
  ignore(object_fields(new))
  let output = []
  compare_config_trees(old, new, [], output, 0, tree_work())
  output
}
