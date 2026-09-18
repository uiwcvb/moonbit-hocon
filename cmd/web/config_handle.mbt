///|
// Opaque, realm-local values. The JavaScript wrapper never exposes their fields.
pub struct ConfigHandle {
  value : @lib.Value?
  error : String
}

///|
fn make_handle(action : () -> @lib.Value raise) -> ConfigHandle {
  { value: Some(action()), error: "", } catch {
    e => { value: None, error: bridge_error(e).stringify(), }
  }
}

///|
fn handle_value(handle : ConfigHandle) -> @lib.Value raise {
  handle.value.unwrap_or_else(() => raise BadOperation)
}

///|
fn handle_query(action : () -> Json raise) -> String {
  Json::object({ "accepted": true, "value": action() }).stringify() catch {
    e => bridge_error(e).stringify()
  }
}

///|
pub fn config_create(
  input : String,
  callback : (String) -> String,
) -> ConfigHandle {
  make_handle(() => load_config(@json.parse(input), Some(callback)))
}

///|
pub fn config_status(handle : ConfigHandle) -> String {
  if handle.error.is_empty() {
    "{\"accepted\":true}"
  } else {
    handle.error
  }
}

///|
pub fn config_query(handle : ConfigHandle, input : String) -> String {
  config_read_request(handle, @json.parse(input)) catch {
    e => bridge_error(e).stringify()
  }
}

///|
pub fn config_error(handle : ConfigHandle) -> String {
  handle.error
}

///|
pub fn config_read(
  handle : ConfigHandle,
  getter : String,
  path : String,
  extras : String,
) -> String {
  try {
    let fields : Map[String, Json] = { "path": path.to_json() }
    if !getter.is_empty() {
      fields["getter"] = getter.to_json()
    }
    if !extras.is_empty() {
      guard @json.parse(extras) is Object(options) else { raise BadGetter }
      for key, value in options {
        if key == "enumChoices" || key == "unit" {
          fields[key] = value
        } else {
          raise BadGetter
        }
      }
    }
    config_read_request(handle, Json::object(fields))
  } catch {
    e => bridge_error(e).stringify()
  }
}

///|
fn config_read_request(handle : ConfigHandle, request : Json) -> String raise {
  let config = handle_value(handle)
  if request is { "getter": String("double"), "path": String(path), .. } {
    return "{\"accepted\":true,\"value\":" +
      persistent_double(@lib.get_double(config, path)) +
      "}"
  }
  if request is { "getter": String("double-list"), "path": String(path), .. } {
    return "{\"accepted\":true,\"value\":[" +
      @lib.get_double_list(config, path).map(persistent_double).join(",") +
      "]}"
  }
  let value = if request
    is { "getter": String("has"), "path": String(path), .. } {
    (@lib.has_path_or_null(config, path) && !@lib.get_is_null(config, path)).to_json()
  } else {
    config_getter(config, request)
  }
  Json::object({ "accepted": true, "value": value }).stringify()
}

///|
fn persistent_double(value : Double) -> String {
  if value == 0.0 && value.reinterpret_as_int64() < 0L {
    "-0.0"
  } else if value.is_nan() {
    "\"NaN\""
  } else if value.is_inf() {
    if value > 0.0 {
      "\"Infinity\""
    } else {
      "\"-Infinity\""
    }
  } else {
    value.to_json().stringify()
  }
}

///|
pub fn config_derive(
  handle : ConfigHandle,
  input : String,
  other : ConfigHandle,
) -> ConfigHandle {
  make_handle(() => {
    let config = handle_value(handle)
    let request = @json.parse(input)
    let environment = string_map(request, "environment")
    let allow = match request {
      { "allowUnresolved": True, .. } => true
      { "allowUnresolved": False, .. } => false
      Object(fields) =>
        if fields.contains("allowUnresolved") {
          raise BadOperation
        } else {
          false
        }
      _ => raise BadOperation
    }
    match request {
      { "op": String("resolve"), .. } =>
        @lib.resolve(config, environment~, allow_unresolved=allow)
      { "op": String("resolve-with"), .. } =>
        @lib.resolve_with(
          config,
          handle_value(other),
          environment~,
          allow_unresolved=allow,
        )
      { "op": String("with-fallback"), .. } =>
        @lib.with_fallback(config, handle_value(other))
      { "op": String("get-config"), "path": String(path), .. } =>
        immutable_child(config, path)
      {
        "op": String("with-value-from"),
        "path": String(path),
        "valuePath": String(value_path),
        ..
      } =>
        @lib.with_value(
          config,
          path,
          @lib.get_value(handle_value(other), value_path),
        )
      {
        "op": String("with-value-source"),
        "path": String(path),
        "source": String(source),
        ..
      } => {
        let parsed = @lib.parse_unresolved("value=" + source)
        let value = @lib.get_path(parsed, ["value"]).unwrap_or_else(() => {
          raise MissingValue
        })
        @lib.with_value(config, path, value)
      }
      _ => tree_operation(config, request)
    }
  })
}

///|
pub fn config_child(handle : ConfigHandle, path : String) -> ConfigHandle {
  make_handle(() => immutable_child(handle_value(handle), path))
}

///|
pub fn config_children(
  handle : ConfigHandle,
  path : String,
) -> Array[ConfigHandle] {
  @lib.get_as_list(handle_value(handle), path).map(value => {
    value: Some(immutable_object(value)),
    error: "",
  }) catch {
    e => [{ value: None, error: bridge_error(e).stringify(), }]
  }
}

///|
pub fn config_validate(
  handle : ConfigHandle,
  reference : ConfigHandle,
  input : String,
) -> String {
  handle_query(() => {
    let request = @json.parse(input)
    let paths = string_array(request, "paths")
    let config = handle_value(handle)
    let reference = handle_value(reference)
    if request is { "problems": True, .. } {
      @lib.validation_problems(config, reference, paths~).to_json()
    } else {
      @lib.check_valid(config, reference, paths~)
      Json::null()
    }
  })
}

///|
// ConfigHandle owns its tree and every editing operation returns a detached tree.
// Returning another opaque handle may share a node safely; no mutable value is
// exposed to JavaScript. Core get_config retains its defensive-copy contract.
fn immutable_child(config : @lib.Value, path : String) -> @lib.Value raise {
  match @lib.get(config, path) {
    Some(@lib.Object(_) | @lib.SealedObject(_) as value) => value
    _ => @lib.get_config(config, path)
  }
}

///|
fn immutable_object(value : @lib.Value) -> @lib.Value raise {
  match value {
    @lib.Object(_) | @lib.SealedObject(_) => value
    _ => @lib.get_config(@lib.Object({ "child": value }), "child")
  }
}
