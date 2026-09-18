///|
priv struct ValueWriter {
  output : StringBuilder
  work : Work
  json : Bool
  formatted : Bool
}

///|
fn ValueWriter::emit(
  self : ValueWriter,
  text : String,
) -> Unit raise ParseError {
  self.work.spend(text.length())
  self.output.write_string(text)
}

///|
fn ValueWriter::indent(
  self : ValueWriter,
  level : Int,
) -> Unit raise ParseError {
  if self.formatted {
    for _ in 0..<level {
      self.emit("    ")
    }
  }
}

///|
fn render_string(text : String, json : Bool) -> String {
  if !json &&
    !text.is_empty() &&
    text[0] != 45 &&
    numeric_digit(text[0].to_int()) < 0 &&
    !["include", "true", "false", "null"]
    .iter()
    .any(prefix => text.has_prefix(prefix)) &&
    text.iter().all(c => c != '_' && path_character(c)) {
    text
  } else {
    text.to_json().stringify()
  }
}

///|
// Decimal indices precede ordinary keys. Equal numeric spellings keep native
// ordinary hash-bucket order; their lexicographic spelling is not a tie-breaker.
fn render_numeric_key(text : String) -> String? {
  if text.is_empty() {
    return None
  }
  let out = StringBuilder()
  let mut nonzero = false
  for c in text {
    let digit = numeric_digit(c.to_int())
    if digit < 0 {
      return None
    }
    if digit != 0 || nonzero {
      nonzero = true
      out.write_char((48 + digit).unsafe_to_char())
    }
  }
  Some(if nonzero { out.to_string() } else { "0" })
}

///|
fn render_key_compare(a : String, b : String) -> Int {
  match (render_numeric_key(a), render_numeric_key(b)) {
    (Some(x), Some(y)) =>
      if x.length() == y.length() {
        java_key_compare(x, y)
      } else {
        x.length() - y.length()
      }
    (Some(_), None) => -1
    (None, Some(_)) => 1
    _ => java_key_compare(a, b)
  }
}

///|
fn rendered_keys(
  fields : Map[String, Value],
  work : Work,
) -> Array[String] raise ParseError {
  work.spend(fields.length())
  for key in fields.keys() {
    work.spend(key.length())
  }
  let ordered = object_iteration_keys(fields).mapi((i, key) => (key, i))
  ordered.sort_by((a, b) => {
    let comparison = render_key_compare(a.0, b.0)
    if comparison == 0 {
      a.1 - b.1
    } else {
      comparison
    }
  })
  ordered.map(item => item.0)
}

///|
fn render_reference(
  parts : Array[String],
  optional : Bool,
  expansion : Bool,
) -> String raise ParseError {
  let out = StringBuilder()
  out.write_string("${")
  if optional {
    out.write_string("?")
  }
  out.write_string(join_path(parts))
  if expansion {
    out.write_string("[]")
  }
  out.write_string("}")
  out.to_string()
}

///|
fn write_value(
  writer : ValueWriter,
  value : Value,
  depth : Int,
  level : Int,
  root : Bool,
  key : String?,
) -> Unit raise ParseError {
  tree_step(value, depth, writer.work)
  if value is Bound(_, _, body) {
    write_value(writer, body, depth + 1, level, root, key)
    return
  }
  if value is DelayedMerge(_, _) {
    let stack = []
    merge_stack(value, stack, depth, writer.work)
    for i = stack.length() - 1; i >= 0; i = i - 1 {
      writer.indent(level)
      if key is Some(name) {
        writer.emit(render_string(name, true))
        writer.emit(if writer.formatted { " : " } else { ":" })
      }
      write_value(writer, stack[i], depth + 1, level, root, None)
      if i > 0 {
        writer.emit(",")
      }
      if writer.formatted {
        writer.emit("\n")
      }
    }
    return
  }
  if key is Some(name) {
    writer.emit(render_string(name, writer.json))
    writer.emit(
      if writer.json {
        if writer.formatted {
          " : "
        } else {
          ":"
        }
      } else if value is (Object(_) | SealedObject(_)) {
        if writer.formatted {
          " "
        } else {
          ""
        }
      } else {
        "="
      },
    )
  }
  match value {
    Text(text) => writer.emit(render_string(text, writer.json))
    Bare(text) =>
      writer.emit(if writer.json { render_string(text, true) } else { text })
    Number(_) => writer.emit(render_number(value))
    Null => writer.emit("null")
    Boolean(value) => writer.emit(if value { "true" } else { "false" })
    Reference(path) =>
      writer.emit(render_reference(split_path(path), false, false))
    PathReference(parts, optional) =>
      writer.emit(render_reference(parts, optional, false))
    Substitution(paths, optional, expansion, _) => {
      guard paths.get(0) is Some(parts) else {
        raise Invalid("empty substitution paths")
      }
      writer.emit(render_reference(parts, optional, expansion))
    }
    Concat(parts) =>
      for (gap, child) in parts {
        if !gap.is_empty() {
          write_value(writer, Bare(gap), depth + 1, level, root, None)
        }
        write_value(writer, child, depth + 1, level, root, None)
      }
    List(items) => {
      writer.emit("[")
      if !items.is_empty() {
        if writer.formatted {
          writer.emit("\n")
        }
        for i, child in items {
          if i > 0 {
            writer.emit(if writer.formatted { ",\n" } else { "," })
          }
          writer.indent(level + 1)
          write_value(writer, child, depth + 1, level + 1, false, None)
        }
        if writer.formatted {
          writer.emit("\n")
          writer.indent(level)
        }
      }
      writer.emit("]")
    }
    Object(fields) | SealedObject(fields) => {
      if fields.is_empty() {
        writer.emit("{}")
      } else {
        let braces = writer.json || !root
        let inner = if braces { level + 1 } else { level }
        if braces {
          writer.emit(if writer.formatted { "{\n" } else { "{" })
        }
        for i, name in rendered_keys(fields, writer.work) {
          if i > 0 {
            writer.emit(
              if !writer.formatted {
                ","
              } else if writer.json {
                ",\n"
              } else {
                "\n"
              },
            )
          }
          writer.indent(inner)
          write_value(writer, fields[name], depth + 1, inner, false, Some(name))
        }
        if braces {
          if writer.formatted {
            writer.emit("\n")
            writer.indent(level)
          }
          writer.emit("}")
        }
      }
      if root && writer.formatted {
        writer.emit("\n")
      }
    }
    Bound(_, _, _) | DelayedMerge(_, _) => ()
  }
}

///|
/// Render resolved or unresolved values with comments and origin annotations
/// omitted. JSON mode can contain substitutions or repeated unresolved fields;
/// it is valid JSON only for resolved finite values.
pub fn render_value(
  value : Value,
  json? : Bool = true,
  formatted? : Bool = false,
) -> String raise ParseError {
  let writer = { output: StringBuilder(), work: tree_work(), json, formatted, }
  write_value(writer, value, 0, 0, true, None)
  writer.output.to_string()
}
