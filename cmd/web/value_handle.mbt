///|
pub fn value_kind(handle : ConfigHandle) -> String {
  match handle.value {
    None => "MISSING"
    Some(value) => @lib.value_type(value) catch { _ => "UNRESOLVED" }
  }
}

///|
pub fn value_select(
  handle : ConfigHandle,
  input : String,
  other : ConfigHandle,
) -> ConfigHandle {
  try {
    let value = handle_value(handle)
    let request = @json.parse(input)
    if request is { "op": String("get-key"), "key": String(key), .. } {
      guard value is (@lib.Object(fields) | @lib.SealedObject(fields)) else {
        raise BadOperation
      }
      // This opaque view may share a node; JavaScript cannot mutate the tree.
      return { value: fields.get(key), error: "", }
    }
    make_handle(() => {
      match request {
        { "op": String("get-index"), "index": index, .. } => {
          let index = transfer_int(index)
          guard value is @lib.List(items) else { raise BadOperation }
          items.get(index).unwrap_or_else(() => raise BadOperation)
        }
        { "op": String("get-value"), "key": String(key), .. } =>
          @lib.get_value(value, key)
        { "op": String("get-object"), "key": String(key), .. } =>
          immutable_child(value, key)
        { "op": String("get-list"), "key": String(key), .. } =>
          @lib.List(@lib.get_as_list(value, key))
        { "op": String("with-value"), "key": String(key), .. } =>
          @lib.with_key_value(value, key, handle_value(other))
        { "op": String("with-path-value"), "key": String(key), .. } =>
          @lib.with_value(value, key, handle_value(other))
        { "op": String("only-key"), "key": String(key), .. } =>
          @lib.with_only_key(value, key)
        { "op": String("without-key"), "key": String(key), .. } =>
          @lib.without_key(value, key)
        { "op": String("fallback"), .. } =>
          @lib.value_with_fallback(value, handle_value(other))
        { "op": String("at-key"), "key": String(key), .. } =>
          @lib.at_key(value, key)
        { "op": String("at-path"), "key": String(key), .. } =>
          @lib.at_path(value, key)
        _ => raise BadOperation
      }
    })
  } catch {
    e => { value: None, error: bridge_error(e).stringify(), }
  }
}

///|
pub fn value_read_native(handle : ConfigHandle, op : String) -> NativeValue {
  try {
    let value = handle_value(handle)
    let result = match op {
      "type" => native_string(@lib.value_type(value))
      "unwrap" => native_json(@lib.value_unwrapped(value).to_json_string())
      "size" => native_number(@lib.value_size(value).to_double())
      "hash" => native_number(@lib.value_hash(value).to_double())
      "keys" => json_native(@lib.object_keys(value).to_json())
      _ => raise BadOperation
    }
    native_success(result)
  } catch {
    e => json_native(bridge_error(e))
  }
}

///|
pub fn value_equal_native(a : ConfigHandle, b : ConfigHandle) -> NativeValue {
  native_success(
    native_bool(@lib.value_equals(handle_value(a), handle_value(b))),
  ) catch {
    e => json_native(bridge_error(e))
  }
}
