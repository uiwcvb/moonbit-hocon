///|
fn has_index_aliases(fields : Map[String, Value]) -> Bool {
  let indices : Map[Int, Bool] = Map([])
  for key, _ in fields {
    if key.is_empty() ||
      !((key[0] >= 48 && key[0] <= 57) || key[0] == 43 || key[0] == 45) {
      continue
    }
    let index = @string.parse_int(key) catch { _ => -1 }
    if index >= 0 {
      if indices.contains(index) {
        return true
      }
      indices[index] = true
    }
  }
  false
}

///|
// Numeric aliases in object-to-list conversion overwrite in the reference
// object's hash-bucket traversal order. Keep insertion order inside a bucket.
fn object_iteration_keys(fields : Map[String, Value]) -> Array[String] {
  let mut capacity = 16
  while fields.length() > capacity * 3 / 4 {
    capacity *= 2
  }
  let keyed : Array[(Int, Int, String)] = []
  for position, key in fields.keys().collect() {
    let mut hash = 0U
    for i = 0; i < key.length(); i = i + 1 {
      hash = hash * 31U + key[i].to_int().reinterpret_as_uint()
    }
    let bucket = (hash ^ (hash >> 16)).reinterpret_as_int() & (capacity - 1)
    keyed.push((bucket, position, key))
  }
  keyed.sort_by((a, b) => {
    if a.0 == b.0 {
      a.1.compare(b.1)
    } else {
      a.0.compare(b.0)
    }
  })
  keyed.map(item => item.2)
}
