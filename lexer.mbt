///|
pub suberror ParseError {
  Invalid(String)
} derive(Debug)

///|
priv struct Token {
  text : String
  quoted : Bool
  gap : String
}

///|
priv struct Cursor {
  tokens : Array[Token]
  mut pos : Int
}

///|
fn Cursor::peek(self : Cursor) -> String {
  if self.pos < self.tokens.length() {
    if self.tokens[self.pos].quoted {
      "<string>"
    } else {
      self.tokens[self.pos].text
    }
  } else {
    "<eof>"
  }
}

///|
fn Cursor::take(self : Cursor) -> Token raise ParseError {
  if self.pos >= self.tokens.length() {
    raise Invalid("unexpected end")
  }
  let t = self.tokens[self.pos]
  self.pos += 1
  t
}

///|
fn Cursor::eat(self : Cursor, text : String) -> Bool {
  if self.peek() == text {
    self.pos += 1
    true
  } else {
    false
  }
}

///|
fn Cursor::need(self : Cursor, text : String) -> Unit raise ParseError {
  if !self.eat(text) {
    raise Invalid("expected " + text + ", got " + self.peek())
  }
}

///|
fn word(c : Char) -> Bool {
  (c >= 'a' && c <= 'z') ||
  (c >= 'A' && c <= 'Z') ||
  c == '_' ||
  (c >= '0' && c <= '9') ||
  c.to_int() > 127
}

///|
fn lex(source : String, newlines : Bool) -> Cursor raise ParseError {
  if source.length() > 100000 {
    raise Invalid("source limit")
  }
  let cs = source.to_array()
  let ts : Array[Token] = []
  let mut gap = ""
  let mut i = 0
  while i < cs.length() {
    let c = cs[i]
    if c == ' ' || c == '\t' || c == '\r' {
      gap += c.to_string()
      i += 1
      continue
    }
    if c == '\n' {
      if newlines {
        ts.push({ text: ";", quoted: false, gap, })
        gap = ""
      }
      i += 1
      continue
    }
    if c == '#' || (c == '/' && i + 1 < cs.length() && cs[i + 1] == '/') {
      while i < cs.length() && cs[i] != '\n' {
        i += 1
      }
      continue
    }
    if c == '"' {
      let start = i
      i += 1
      let mut escaped = false
      let mut closed = false
      while i < cs.length() {
        let ch = cs[i]
        i += 1
        if escaped {
          escaped = false
          continue
        }
        if ch == '\\' {
          escaped = true
          continue
        }
        if ch == '"' {
          closed = true
          break
        }
      }
      if !closed {
        raise Invalid("unterminated string")
      }
      let literal = String::from_array(cs[start:i])
      let decoded = @json.parse(literal) catch {
        _ => raise Invalid("invalid JSON string")
      }
      let text = match decoded {
        String(text) => text
        _ => raise Invalid("quoted string required")
      }
      ts.push({ text, quoted: true, gap, })
      gap = ""
      continue
    }
    if word(c) {
      let mut s = ""
      while i < cs.length() && word(cs[i]) {
        s += cs[i].to_string()
        i += 1
      }
      ts.push({ text: s, quoted: false, gap, })
      gap = ""
      continue
    }
    let mut s = c.to_string()
    i += 1
    if i < cs.length() {
      let pair = s + cs[i].to_string()
      if pair == "==" ||
        pair == "!=" ||
        pair == ">=" ||
        pair == "<=" ||
        pair == "=~" ||
        pair == "!~" ||
        pair == "+=" ||
        pair == "&&" ||
        pair == "||" {
        s = pair
        i += 1
      }
    }
    ts.push({ text: s, quoted: false, gap, })
    gap = ""
  }
  { tokens: ts, pos: 0, }
}
