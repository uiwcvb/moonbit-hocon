///|
fn config_getter(config : @lib.Value, request : Json) -> Json raise {
  let path = match request {
    { "path": String(s), .. } => s
    _ => ""
  }
  match request {
    { "getter": String(kind), .. } =>
      config_getter_kind(config, kind, path, request)
    _ => @json.parse(config.to_json_string())
  }
}

///|
fn config_getter_kind(
  config : @lib.Value,
  kind : String,
  path : String,
  request : Json,
) -> Json raise {
  match kind {
    "string" => @lib.get_as_string(config, path).to_json()
    "boolean" => @lib.get_as_bool(config, path).to_json()
    "int" => @lib.get_as_int(config, path).to_json()
    "long" => @lib.get_long(config, path).to_string().to_json()
    "double" => {
      let value = @lib.get_double(config, path)
      if value.is_nan() {
        "NaN".to_json()
      } else if value.is_inf() {
        (if value > 0 { "Infinity" } else { "-Infinity" }).to_json()
      } else {
        value.to_json()
      }
    }
    "number" => @lib.get_number(config, path).to_json()
    "number-list" => @lib.get_number_list(config, path).to_json()
    "object" =>
      @json.parse(@lib.Object(@lib.get_object(config, path)).to_json_string())
    "object-list" =>
      @json.parse(
        @lib.List(
          @lib.get_object_list(config, path).map(fields => @lib.Object(fields)),
        ).to_json_string(),
      )
    "any-ref" => @json.parse(@lib.get_any_ref(config, path).to_json_string())
    "any-ref-list" =>
      @json.parse(
        @lib.List(@lib.get_any_ref_list(config, path)).to_json_string(),
      )
    "enum" => @lib.get_enum(config, path, enum_choices(request)).to_json()
    "enum-list" =>
      @lib.get_enum_list(config, path, enum_choices(request)).to_json()
    "period" => @lib.get_period(config, path).to_json()
    "temporal" => @lib.get_temporal(config, path).to_json()
    "duration-in" =>
      @lib.get_duration_in(config, path, time_unit(request))
      .to_string()
      .to_json()
    "duration-list-in" =>
      @lib.get_duration_list_in(config, path, time_unit(request))
      .map(n => n.to_string())
      .to_json()
    "milliseconds" => @lib.get_milliseconds(config, path).to_string().to_json()
    "nanoseconds" => @lib.get_nanoseconds(config, path).to_string().to_json()
    "milliseconds-list" =>
      @lib.get_milliseconds_list(config, path).map(n => n.to_string()).to_json()
    "nanoseconds-list" =>
      @lib.get_nanoseconds_list(config, path).map(n => n.to_string()).to_json()
    "duration" => @lib.get_duration(config, path).to_string().to_json()
    "bytes" => @lib.get_bytes(config, path).to_string().to_json()
    "memory" => @lib.get_memory_size(config, path).to_json()
    "string-list" => @lib.get_string_list(config, path).to_json()
    "boolean-list" => @lib.get_bool_list(config, path).to_json()
    "int-list" => @lib.get_int_list(config, path).to_json()
    "long-list" =>
      @lib.get_long_list(config, path).map(n => n.to_string()).to_json()
    "double-list" =>
      @lib.get_double_list(config, path)
      .map(n => {
        if n.is_nan() {
          "NaN".to_json()
        } else if n.is_inf() {
          (if n > 0 { "Infinity" } else { "-Infinity" }).to_json()
        } else {
          n.to_json()
        }
      })
      .to_json()
    "duration-list" =>
      @lib.get_duration_list(config, path).map(n => n.to_string()).to_json()
    "bytes-list" =>
      @lib.get_bytes_list(config, path).map(n => n.to_string()).to_json()
    "memory-list" => @lib.get_memory_size_list(config, path).to_json()
    "config" => @json.parse(@lib.get_config(config, path).to_json_string())
    "config-list" =>
      @json.parse(
        @lib.List(@lib.get_config_list(config, path)).to_json_string(),
      )
    "list" =>
      @json.parse(@lib.List(@lib.get_as_list(config, path)).to_json_string())
    "has" => @lib.has_path(config, path).to_json()
    "null" => @lib.get_is_null(config, path).to_json()
    "has-or-null" => @lib.has_path_or_null(config, path).to_json()
    "empty" => @lib.is_empty(config).to_json()
    "json-text" => config.to_json_string().to_json()
    "resolved" => @lib.is_resolved(config).to_json()
    "entries" =>
      @json.parse(@lib.Object(@lib.entry_set(config)).to_json_string())
    "validation" =>
      match request {
        { "referenceSource": String(reference), .. } =>
          @lib.validation_problems(
            config,
            @lib.parse(reference),
            paths=string_array(request, "validationPaths"),
          ).to_json()
        _ => raise BadSource
      }
    "debug" => Repr(config).to_string().to_json()
    "value" =>
      match @lib.get(config, path) {
        Some(v) => @json.parse(v.to_json_string())
        None => raise MissingValue
      }
    _ => raise BadGetter
  }
}
