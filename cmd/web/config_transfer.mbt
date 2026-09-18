///|
priv struct TransferBudget {
  mut remaining : Int
}

///|
fn transfer_spend(work : TransferBudget, size : Int, depth : Int) -> Unit raise {
  work.remaining -= size
  if work.remaining < 0 || depth > 64 {
    raise BadSource
  }
}

///|
fn pack_value(
  value : @lib.Value,
  work : TransferBudget,
  depth : Int,
) -> Json raise {
  transfer_spend(work, 1, depth)
  match value {
    @lib.Text(s) => {
      transfer_spend(work, s.length(), depth)
      Json::array(["text".to_json(), s.to_json()])
    }
    @lib.Number(s) => {
      transfer_spend(work, s.length(), depth)
      Json::array(["number".to_json(), s.to_json()])
    }
    @lib.Bare(s) => {
      transfer_spend(work, s.length(), depth)
      Json::array(["bare".to_json(), s.to_json()])
    }
    @lib.Reference(s) => {
      transfer_spend(work, s.length(), depth)
      Json::array(["reference".to_json(), s.to_json()])
    }
    @lib.Null => Json::array(["null".to_json()])
    @lib.Boolean(b) => Json::array(["boolean".to_json(), b.to_json()])
    @lib.List(items) =>
      Json::array([
        "list".to_json(),
        items.map(v => pack_value(v, work, depth + 1)).to_json(),
      ])
    @lib.Object(fields) => {
      let entries = []
      for key, child in fields {
        transfer_spend(work, key.length(), depth)
        entries.push(
          Json::array([key.to_json(), pack_value(child, work, depth + 1)]),
        )
      }
      Json::array(["object".to_json(), entries.to_json()])
    }
    @lib.PathReference(path, optional) =>
      Json::array(["path".to_json(), path.to_json(), optional.to_json()])
    @lib.Substitution(paths, optional, list_env, id) =>
      Json::array([
        "substitution".to_json(),
        paths.to_json(),
        optional.to_json(),
        list_env.to_json(),
        id.to_json(),
      ])
    @lib.Bound(path, id, body) =>
      Json::array([
        "bound".to_json(),
        path.to_json(),
        id.to_json(),
        pack_value(body, work, depth + 1),
      ])
    @lib.Concat(parts) =>
      Json::array([
        "concat".to_json(),
        parts
        .map(p => {
          transfer_spend(work, p.0.length(), depth)
          Json::array([p.0.to_json(), pack_value(p.1, work, depth + 1)])
        })
        .to_json(),
      ])
    @lib.DelayedMerge(low, high) =>
      Json::array([
        "merge".to_json(),
        pack_value(low, work, depth + 1),
        pack_value(high, work, depth + 1),
      ])
  }
}

///|
fn transfer_strings(
  input : Json,
  work : TransferBudget,
  depth : Int,
) -> Array[String] raise {
  guard input is Array(values) else { raise BadSource }
  values.map(v => {
    guard v is String(s) else { raise BadSource }
    transfer_spend(work, s.length() + 1, depth)
    s
  })
}

///|
fn transfer_bool(input : Json) -> Bool raise {
  match input {
    True => true
    False => false
    _ => raise BadSource
  }
}

///|
fn transfer_int(input : Json) -> Int raise {
  guard input is Number(n, ..) else { raise BadSource }
  if n < -2147483648.0 ||
    n > 2147483647.0 ||
    n.is_nan() ||
    n.to_int().to_double() != n {
    raise BadSource
  }
  n.to_int()
}

///|
fn unpack_value(
  input : Json,
  work : TransferBudget,
  depth : Int,
) -> @lib.Value raise {
  transfer_spend(work, 1, depth)
  match input {
    Array([String("text"), String(s)]) => {
      transfer_spend(work, s.length(), depth)
      @lib.Text(s)
    }
    Array([String("number"), String(s)]) => {
      transfer_spend(work, s.length(), depth)
      @lib.Number(s)
    }
    Array([String("bare"), String(s)]) => {
      transfer_spend(work, s.length(), depth)
      @lib.Bare(s)
    }
    Array([String("reference"), String(s)]) => {
      transfer_spend(work, s.length(), depth)
      @lib.Reference(s)
    }
    Array([String("null")]) => @lib.Null
    Array([String("boolean"), b]) => @lib.Boolean(transfer_bool(b))
    Array([String("list"), Array(items)]) =>
      @lib.List(items.map(v => unpack_value(v, work, depth + 1)))
    Array([String("object"), Array(entries)]) => {
      let fields : Map[String, @lib.Value] = Map([])
      for entry in entries {
        guard entry is Array([String(key), value]) else { raise BadSource }
        transfer_spend(work, key.length(), depth)
        if fields.contains(key) {
          raise BadSource
        }
        fields[key] = unpack_value(value, work, depth + 1)
      }
      @lib.Object(fields)
    }
    Array([String("path"), path, optional]) =>
      @lib.PathReference(
        transfer_strings(path, work, depth),
        transfer_bool(optional),
      )
    Array([String("substitution"), Array(paths), optional, list_env, id]) =>
      @lib.Substitution(
        paths.map(path => transfer_strings(path, work, depth)),
        transfer_bool(optional),
        transfer_bool(list_env),
        transfer_int(id),
      )
    Array([String("bound"), path, id, body]) =>
      @lib.Bound(
        transfer_strings(path, work, depth),
        transfer_int(id),
        unpack_value(body, work, depth + 1),
      )
    Array([String("concat"), Array(parts)]) =>
      @lib.Concat(
        parts.map(p => {
          guard p is Array([String(space), value]) else { raise BadSource }
          transfer_spend(work, space.length(), depth)
          (space, unpack_value(value, work, depth + 1))
        }),
      )
    Array([String("merge"), low, high]) =>
      @lib.DelayedMerge(
        unpack_value(low, work, depth + 1),
        unpack_value(high, work, depth + 1),
      )
    _ => raise BadSource
  }
}

///|
pub fn config_pack(handle : ConfigHandle) -> String {
  handle_query(() => {
    let encoded = pack_value(handle_value(handle), { remaining: 4000000, }, 0)
    let wire = Json::object({ "version": 1, "root": encoded })
    if wire.stringify().length() > 4000000 {
      raise BadSource
    }
    wire
  })
}

///|
pub fn config_unpack(input : String) -> ConfigHandle {
  make_handle(() => {
    if input.length() > 4000000 {
      raise BadSource
    }
    guard @json.parse(input) is { "version": Number(1.0, ..), "root": root, .. } else {
      raise BadSource
    }
    let value = unpack_value(root, { remaining: 4000000, }, 0)
    guard transferable_config(value) else { raise BadSource }
    value
  })
}

///|
fn transferable_config(value : @lib.Value) -> Bool {
  match value {
    @lib.Object(_) => true
    @lib.Bound(_, _, body) => transferable_config(body)
    @lib.DelayedMerge(_, high) => transferable_config(high)
    _ => false
  }
}
