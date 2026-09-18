///|
#external
pub type NativeValue

///|
pub fn split_path_json(path : String) -> String {
  handle_query(() => @lib.split_path(path).to_json())
}

///|
extern "js" fn native_null() -> NativeValue =
  #| () => null

///|
extern "js" fn native_bool(value : Bool) -> NativeValue =
  #| value => value

///|
extern "js" fn native_number(value : Double) -> NativeValue =
  #| value => value

///|
extern "js" fn native_string(value : String) -> NativeValue =
  #| value => value

///|
extern "js" fn native_array() -> NativeValue =
  #| () => []

///|
extern "js" fn native_push(array : NativeValue, value : NativeValue) -> Unit =
  #| (array, value) => { array.push(value); }

///|
extern "js" fn native_object() -> NativeValue =
  #| () => ({})

///|
extern "js" fn native_field(
  object : NativeValue,
  key : String,
  value : NativeValue,
) -> Unit =
  #| (object, key, value) => {
  #|   Object.defineProperty(object, key, {value, writable:true, enumerable:true, configurable:true});
  #| }

///|
extern "js" fn native_success(value : NativeValue) -> NativeValue =
  #| value => ({accepted:true, value})

///|
extern "js" fn native_json(
  text : String,
  // A negative JSON number (including underflow) requires a '-' in its text.
  // Skip the per-property reviver when no negative zero can occur; '-' inside
  // a quoted key/value only takes the conservative normalization path.
) -> NativeValue =
  #| text => JSON.parse(text, text.includes('-') ? (_key, value) => value === 0 ? 0 : value : undefined)

///|
// Copy JSON values into ordinary JS data without depending on generated union
// layouts, JSON text, or mutable aliases into the retained configuration tree.
// Data properties preserve JSON.parse semantics even for __proto__ and setters.
fn json_native(value : Json, normalize_zero? : Bool = false) -> NativeValue {
  match value {
    Null => native_null()
    True => native_bool(true)
    False => native_bool(false)
    Number(value, ..) =>
      native_number(if normalize_zero && value == 0.0 { 0.0 } else { value })
    String(value) => native_string(value)
    Array(values) => {
      let result = native_array()
      for value in values {
        native_push(result, json_native(value, normalize_zero~))
      }
      result
    }
    Object(fields) => {
      let result = native_object()
      for key, value in fields {
        native_field(result, key, json_native(value, normalize_zero~))
      }
      result
    }
  }
}

///|
pub fn config_read_native(
  handle : ConfigHandle,
  getter : String,
  path : String,
  extras : String,
) -> NativeValue {
  try {
    let options = if extras.is_empty() {
      Json::null()
    } else {
      let parsed = @json.parse(extras)
      guard parsed is Object(fields) else { raise BadGetter }
      for key in fields.keys() {
        if key != "enumChoices" && key != "unit" {
          raise BadGetter
        }
      }
      parsed
    }
    let config = handle_value(handle)
    if getter.is_empty() {
      return native_success(native_json(config.to_json_string()))
    }
    let value = if getter == "has" {
      (@lib.has_path_or_null(config, path) && !@lib.get_is_null(config, path)).to_json()
    } else {
      config_getter_kind(config, getter, path, options)
    }
    // Unwrapped source numbers use the native parser's compact numeric zero.
    // Explicit double conversions (including string "-0.0") retain the sign.
    native_success(
      json_native(
        value,
        normalize_zero=getter != "double" && getter != "double-list",
      ),
    )
  } catch {
    error => json_native(bridge_error(error))
  }
}
