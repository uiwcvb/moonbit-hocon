///|
// Config's JSON tokenizer shares its Unicode whitespace rules with HOCON.
// Whitespace inside a quoted string remains part of the value.
fn json_source_space(text : String) -> String {
  if !text
    .iter()
    .any(c => whitespace(c) && c != ' ' && c != '\n' && c != '\r' && c != '\t') {
    return text
  }
  let out = StringBuilder()
  let mut quoted = false
  let mut escaped = false
  for c in text {
    if quoted {
      out.write_char(c)
      if escaped {
        escaped = false
      } else if c == '\\' {
        escaped = true
      } else if c == '"' {
        quoted = false
      }
    } else if c == '"' {
      quoted = true
      out.write_char(c)
    } else {
      out.write_char(if whitespace(c) { ' ' } else { c })
    }
  }
  out.to_string()
}

///|
fn configuration_json(text : String, name : String) -> Json raise ParseError {
  let text = json_source_space(text)
  let value = @json.parse(text) catch {
    _ => raise Invalid("invalid JSON source: " + name)
  }
  // Standard JSON parsing establishes syntax first. Scan only object member
  // spellings so a map conversion cannot silently erase duplicate keys.
  let objects : Array[Map[String, Bool]] = []
  let mut i = 0
  while i < text.length() {
    if text[i] == 123 {
      objects.push(Map([]))
    } else if text[i] == 125 {
      ignore(objects.pop())
    } else if text[i] == 34 {
      let start = i
      let mut escaped = false
      i += 1
      while i < text.length() && text[i] != 34 {
        if text[i] == 92 {
          escaped = true
          i += 1
        }
        i += 1
      }
      let end = i + 1
      let mut next = end
      while next < text.length() &&
            [32, 9, 10, 13].contains(text[next].to_int()) {
        next += 1
      }
      if next < text.length() && text[next] == 58 && !objects.is_empty() {
        let key = if escaped {
          let decoded = @json.parse(text[start:end].to_owned()) catch {
            _ => raise Invalid("invalid JSON key: " + name)
          }
          match decoded {
            String(key) => key
            _ => raise Invalid("invalid JSON key: " + name)
          }
        } else {
          text[start + 1:i].to_owned()
        }
        let keys = objects[objects.length() - 1]
        if keys.contains(key) {
          raise Invalid("duplicate JSON object key: " + key)
        }
        keys[key] = true
      }
    }
    i += 1
  }
  value
}
