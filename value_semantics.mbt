///|
fn string_hash(text : String) -> Int {
  let mut h = 0
  for i = 0; i < text.length(); i = i + 1 {
    h = h * 31 + text[i].to_int()
  }
  h
}

///|
fn java_key_compare(a : String, b : String) -> Int {
  let length = if a.length() < b.length() { a.length() } else { b.length() }
  for i = 0; i < length; i = i + 1 {
    let difference = a[i].to_int() - b[i].to_int()
    if difference != 0 {
      return difference
    }
  }
  a.length() - b.length()
}

///|
fn merge_stack(
  value : Value,
  out : Array[Value],
  depth : Int,
  work : Work,
) -> Unit raise ParseError {
  tree_step(value, depth, work)
  match value {
    Bound(_, _, body) => merge_stack(body, out, depth + 1, work)
    DelayedMerge(low, high) => {
      merge_stack(high, out, depth + 1, work)
      merge_stack(low, out, depth + 1, work)
    }
    _ => out.push(value)
  }
}

///|
// Equality excludes parser IDs, binding owners, origins and fallback flags.
// Number spelling is cosmetic; integral values retain all 64 bits.
fn semantic_tree(
  value : Value,
  depth : Int,
  work : Work,
) -> Value raise ParseError {
  tree_step(value, depth, work)
  match value {
    Bound(_, _, body) => semantic_tree(body, depth + 1, work)
    Bare(text) => Text(text)
    Number(_) => {
      let normalized = match get_number(Object({ "v": value }), "v") {
        Integer(n) => "i" + n.to_string()
        Long(n) => "i" + n.to_string()
        Floating(n) => {
          let whole = java_long(n)
          if whole.to_double() == n {
            "i" + whole.to_string()
          } else {
            "d" +
            (if n.is_nan() {
              9221120237041090560L
            } else {
              n.reinterpret_as_int64()
            }).to_string()
          }
        }
      }
      Number(normalized)
    }
    Object(fields) | SealedObject(fields) => {
      let out = Map([])
      for key, child in fields {
        work.spend(key.length())
        out[key] = semantic_tree(child, depth + 1, work)
      }
      Object(out)
    }
    List(items) => List(items.map(v => semantic_tree(v, depth + 1, work)))
    Reference(path) => Substitution([split_path(path)], false, false, 0)
    PathReference(path, optional) =>
      Substitution([path.copy()], optional, false, 0)
    Substitution(paths, optional, expansion, _) =>
      Substitution([paths[0].copy()], optional, expansion, 0)
    Concat(parts) => {
      let out = []
      for (space, child) in parts {
        if !space.is_empty() {
          out.push(("", Text(space)))
        }
        out.push(("", semantic_tree(child, depth + 1, work)))
      }
      Concat(out)
    }
    DelayedMerge(_, _) => {
      let stack = []
      merge_stack(value, stack, depth, work)
      DelayedMerge(
        Boolean(known_object(value)),
        List(stack.map(v => semantic_tree(v, depth + 1, work))),
      )
    }
    _ => value
  }
}

///|
pub fn value_equals(a : Value, b : Value) -> Bool raise ParseError {
  let work = tree_work()
  semantic_equal(semantic_tree(a, 0, work), semantic_tree(b, 0, work))
}

///|
fn semantic_equal(a : Value, b : Value) -> Bool raise ParseError {
  match (a, b) {
    (Text(_) | Boolean(_) | Null, _) => {
      // The reference's default scalar equality asks the right operand for
      // its type first, so unresolved right operands can throw asymmetrically.
      if b
        is (Substitution(_, _, _, _)
        | Concat(_)
        | DelayedMerge(Boolean(false), _)) {
        raise Invalid("unresolved comparison")
      }
      a == b
    }
    (Object(_), DelayedMerge(Boolean(true), _)) =>
      raise Invalid("unresolved object comparison")
    (Object(x), Object(y)) => {
      if x.length() != y.length() {
        return false
      }
      for key in x.keys() {
        if !y.contains(key) {
          return false
        }
      }
      for key, v in x {
        if !semantic_equal(v, y[key]) {
          return false
        }
      }
      true
    }
    (List(x), List(y)) => {
      if x.length() != y.length() {
        return false
      }
      for i, v in x {
        if !semantic_equal(v, y[i]) {
          return false
        }
      }
      true
    }
    (DelayedMerge(a, x), DelayedMerge(b, y)) => a == b && semantic_equal(x, y)
    (Concat(x), Concat(y)) => {
      if x.length() != y.length() {
        return false
      }
      for i, (_, v) in x {
        if !semantic_equal(v, y[i].1) {
          return false
        }
      }
      true
    }
    _ => a == b
  }
}

///|
fn semantic_hash(value : Value) -> Int raise ParseError {
  match value {
    Text(text) => string_hash(text)
    Number(encoded) => {
      let n = @string.parse_int64(encoded[1:].to_owned()) catch {
        _ => raise Invalid("numeric hash invariant")
      }
      (n ^ (n >> 32)).to_int()
    }
    Null => 0
    Boolean(b) => if b { 1231 } else { 1237 }
    List(items) => {
      let mut h = 1
      for v in items {
        h = h * 31 + semantic_hash(v)
      }
      h
    }
    Object(fields) => {
      let keys = fields.keys().collect()
      keys.sort_by(java_key_compare)
      let mut key_hash = 1
      let mut value_hash = 0
      for key in keys {
        key_hash = key_hash * 31 + string_hash(key)
        value_hash += semantic_hash(fields[key])
      }
      41 * (41 + key_hash) + value_hash
    }
    Substitution(paths, optional, expansion, _) => {
      let mut h = 0
      for key in paths[0] {
        h += 41 * (41 + string_hash(key))
      }
      h = 41 * (41 + h)
      h = 41 * (h + (if optional { 1 } else { 0 }))
      41 * (h + (if expansion { 1 } else { 0 }))
    }
    Concat(parts) => {
      let mut h = 1
      for (_, v) in parts {
        h = h * 31 + semantic_hash(v)
      }
      h
    }
    DelayedMerge(_, stack) => semantic_hash(stack)
    _ => raise Invalid("semantic hash invariant")
  }
}

///|
pub fn value_hash(value : Value) -> Int raise ParseError {
  semantic_hash(semantic_tree(value, 0, tree_work()))
}
