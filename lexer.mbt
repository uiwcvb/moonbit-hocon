///|
pub suberror ParseError {
  Invalid(String)
} derive(Debug)

///|
priv struct Token {
  text : String
  quoted : Bool
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
  let mut i = 0
  while i < cs.length() {
    let c = cs[i]
    if c == ' ' || c == '\t' || c == '\r' {
      i += 1
      continue
    }
    if c == '\n' {
      if newlines {
        ts.push({ text: ";", quoted: false, })
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
    if c == '"' || c == '\'' {
      let quote = c
      i += 1
      let mut s = ""
      let mut closed = false
      while i < cs.length() {
        let ch = cs[i]
        i += 1
        if ch == quote {
          closed = true
          break
        }
        if ch == '\\' {
          if i >= cs.length() {
            raise Invalid("truncated escape")
          }
          s += match cs[i] {
            'n' => "\n"
            'r' => "\r"
            't' => "\t"
            '\\' => "\\"
            '"' => "\""
            '\'' => "'"
            _ => raise Invalid("unsupported escape")
          }
          i += 1
        } else {
          s += ch.to_string()
        }
      }
      if !closed {
        raise Invalid("unterminated string")
      }
      ts.push({ text: s, quoted: true, })
      continue
    }
    if word(c) {
      let mut s = ""
      while i < cs.length() && word(cs[i]) {
        s += cs[i].to_string()
        i += 1
      }
      ts.push({ text: s, quoted: false, })
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
    ts.push({ text: s, quoted: false, })
  }
  { tokens: ts, pos: 0, }
}
