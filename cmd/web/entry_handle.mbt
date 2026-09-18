///|
extern "js" fn native_entry_push(
  array : NativeValue,
  key : String,
  handle : ConfigHandle,
) -> Unit =
  #| (array, key, handle) => { array.push([key, handle]); }

///|
/// Keep ConfigValue handles opaque, including unresolved references and lists.
pub fn config_entries_native(handle : ConfigHandle) -> NativeValue {
  try {
    let entries = @lib.entry_set(handle_value(handle))
    let result = native_array()
    for key, value in entries {
      native_entry_push(result, key, { value: Some(value), error: "", })
    }
    native_success(result)
  } catch {
    error => json_native(bridge_error(error))
  }
}
