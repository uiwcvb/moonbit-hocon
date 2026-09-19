///|
extern "js" fn native_entry_push(
  array : NativeValue,
  key : String,
  handle : ConfigHandle,
) -> Unit =
  #| (array, key, handle) => { array.push([key, handle]); }

///|
suberror EntryError {
  Invalid(String)
} derive(Debug)

///|
priv struct EntryBudget {
  mut remaining : Int
}

///|
fn entry_spend(work : EntryBudget, size : Int) -> Unit raise {
  work.remaining -= size
  if work.remaining < 0 {
    raise Invalid("configuration expansion limit")
  }
}

///|
fn entry_step(
  value : @lib.Value,
  depth : Int,
  work : EntryBudget,
) -> Unit raise {
  if depth > 64 {
    raise Invalid("configuration tree depth limit")
  }
  entry_spend(work, 1)
  match value {
    @lib.Text(s) | @lib.Number(s) | @lib.Bare(s) | @lib.Reference(s) =>
      entry_spend(work, s.length())
    _ => ()
  }
}

///|
// The public core entry_set copies mutable leaves. A private retained handle
// can share them, but must still apply the same depth/expansion validation.
fn validate_entry_leaf(
  value : @lib.Value,
  depth : Int,
  work : EntryBudget,
) -> Unit raise {
  entry_step(value, depth, work)
  match value {
    @lib.Object(fields) | @lib.SealedObject(fields) =>
      for key, value in fields {
        entry_spend(work, key.length())
        validate_entry_leaf(value, depth + 1, work)
      }
    @lib.List(items) =>
      for child in items {
        validate_entry_leaf(child, depth + 1, work)
      }
    @lib.Bound(_, _, body) => validate_entry_leaf(body, depth + 1, work)
    @lib.Concat(parts) =>
      for (_, child) in parts {
        validate_entry_leaf(child, depth + 1, work)
      }
    @lib.DelayedMerge(low, high) => {
      validate_entry_leaf(low, depth + 1, work)
      validate_entry_leaf(high, depth + 1, work)
    }
    _ => ()
  }
}

///|
fn entry_handles(
  value : @lib.Value,
  parts : Array[String],
  result : NativeValue,
  depth : Int,
  work : EntryBudget,
) -> Unit raise {
  entry_step(value, depth, work)
  match value {
    @lib.Object(fields) | @lib.SealedObject(fields) =>
      for key, child in fields {
        parts.push(key)
        entry_handles(child, parts, result, depth + 1, work)
        ignore(parts.pop())
      }
    @lib.Null => ()
    @lib.Bound(_, _, body) =>
      entry_handles(body, parts, result, depth + 1, work)
    _ => {
      let kind = @lib.value_type(value) catch { _ => "UNRESOLVED" }
      if kind == "OBJECT" {
        raise Invalid("cannot enumerate unresolved object")
      }
      let key = @lib.join_path(parts)
      validate_entry_leaf(value, depth, work)
      native_entry_push(result, key, { value: Some(value), error: "", })
    }
  }
}

///|
/// Keep private immutable node handles opaque without a temporary cloned map.
pub fn config_entries_native(handle : ConfigHandle) -> NativeValue {
  try {
    let root = handle_value(handle)
    guard root is (@lib.Object(_) | @lib.SealedObject(_)) else {
      raise Invalid("configuration root must be an object")
    }
    let result = native_array()
    entry_handles(root, [], result, 0, { remaining: 1000000, })
    native_success(result)
  } catch {
    error => json_native(bridge_error(error))
  }
}
