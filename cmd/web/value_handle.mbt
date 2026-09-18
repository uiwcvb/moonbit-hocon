///|
pub fn value_kind(handle : ConfigHandle) -> String {
  match handle.value {
    None => "MISSING"
    Some(value) => @lib.value_type(value) catch { _ => "UNRESOLVED" }
  }
}

///|
pub fn value_render_native(
  handle : ConfigHandle,
  json : Bool,
  formatted : Bool,
) -> NativeValue {
  native_success(
    native_string(@lib.render_value(handle_value(handle), json~, formatted~)),
  ) catch {
    error => json_native(bridge_error(error))
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
      "unwrap" => native_json(value.to_json_string())
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
pub fn value_lookup(
  handle : ConfigHandle,
  op : String,
  key : String,
  index : Int,
) -> ConfigHandle {
  try {
    let value = handle_value(handle)
    match op {
      "get-key" => {
        guard value is (@lib.Object(fields) | @lib.SealedObject(fields)) else {
          raise BadOperation
        }
        { value: fields.get(key), error: "", }
      }
      _ =>
        make_handle(() => {
          match op {
            "get-index" => {
              guard value is @lib.List(items) else { raise BadOperation }
              items.get(index).unwrap_or_else(() => raise BadOperation)
            }
            "get-value" =>
              match @lib.get(value, key) {
                Some(node) => {
                  if @lib.value_type(node) == "NULL" {
                    raise BadGetter
                  }
                  node
                }
                None => @lib.get_value(value, key)
              }
            "get-object" => immutable_child(value, key)
            "get-list" =>
              match @lib.get(value, key) {
                Some(@lib.List(_) as node) => node
                _ => @lib.List(@lib.get_as_list(value, key))
              }
            _ => raise BadOperation
          }
        })
    }
  } catch {
    e => { value: None, error: bridge_error(e).stringify(), }
  }
}

///|
pub fn value_search_native(
  handle : ConfigHandle,
  needle : ConfigHandle,
  op : String,
) -> NativeValue {
  try {
    let value = handle_value(handle)
    let needle = handle_value(needle)
    native_success(
      match op {
        "contains-value" =>
          native_bool(@lib.object_contains_value(value, needle))
        "index-of" =>
          native_number(@lib.list_index_of(value, needle).to_double())
        "last-index-of" =>
          native_number(
            @lib.list_index_of(value, needle, last=true).to_double(),
          )
        _ => raise BadOperation
      },
    )
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
