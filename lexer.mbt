///|
pub suberror ParseError {
  Invalid(String)
  Located(String, SourcePosition)
} derive(Debug)

///|
pub(all) struct SourcePosition {
  source : String
  offset : Int
  line : Int
  column : Int
} derive(Debug, Eq, ToJson)

///|
priv struct Token {
  text : String
  quoted : Bool
  kind : String
  gap : String
  position : SourcePosition
}

///|
priv struct Cursor {
  tokens : Array[Token]
  mut pos : Int
  end : SourcePosition
}

///|
fn Cursor::done(self : Cursor) -> Bool {
  self.pos >= self.tokens.length()
}

///|
fn Cursor::peek(self : Cursor) -> String {
  if self.done() {
    "<eof>"
  } else if self.tokens[self.pos].quoted {
    "<string>"
  } else {
    self.tokens[self.pos].text
  }
}

///|
fn Cursor::location(self : Cursor) -> SourcePosition {
  if self.done() {
    self.end
  } else {
    self.tokens[self.pos].position
  }
}

///|
fn Cursor::take(self : Cursor) -> Token raise ParseError {
  if self.done() {
    raise Located("unexpected end", self.end)
  }
  let t = self.tokens[self.pos]
  self.pos += 1
  t
}

///|
fn Cursor::eat(self : Cursor, text : String) -> Bool {
  if !self.done() && self.peek() == text {
    self.pos += 1
    true
  } else {
    false
  }
}

///|
fn Cursor::need(self : Cursor, text : String) -> Unit raise ParseError {
  if !self.eat(text) {
    raise Located("expected " + text + ", got " + self.peek(), self.location())
  }
}

///|
fn whitespace(c : Char) -> Bool {
  let n = c.to_int()
  (n >= 9 && n <= 13) ||
  (n >= 28 && n <= 32) ||
  n == 160 ||
  n == 5760 ||
  (n >= 8192 && n <= 8202) ||
  n == 8232 ||
  n == 8233 ||
  n == 8239 ||
  n == 8287 ||
  n == 12288 ||
  n == 65279
}

///|
fn valid_unicode(s : String) -> Bool {
  let units = s.code_units()
  let mut i = 0
  while i < units.length() {
    let n = units[i].to_int()
    if n >= 55296 && n <= 56319 {
      if i + 1 >= units.length() ||
        units[i + 1].to_int() < 56320 ||
        units[i + 1].to_int() > 57343 {
        return false
      }
      i += 2
    } else if n >= 56320 && n <= 57343 {
      return false
    } else {
      i += 1
    }
  }
  true
}

///|
fn lex(source : String, origin : String) -> Cursor raise ParseError {
  if source.length() > 100000 || !valid_unicode(source) {
    raise Invalid("excessive or ill-formed source")
  }
  let cs = source.to_array()
  let ts : Array[Token] = []
  let mut gap = ""
  let mut i = 0
  let mut line = 1
  let mut column = 1
  while i < cs.length() {
    let start = i
    let position : SourcePosition = { source: origin, offset: i, line, column, }
    let c = cs[i]
    if c == '\n' {
      ts.push({ text: "\n", quoted: false, kind: "newline", gap, position, })
      gap = ""
      i += 1
      line += 1
      column = 1
      continue
    }
    if whitespace(c) {
      gap += c.to_string()
      i += 1
      column += 1
      continue
    }
    if c == '#' || (c == '/' && i + 1 < cs.length() && cs[i + 1] == '/') {
      while i < cs.length() && cs[i] != '\n' {
        i += 1
        column += 1
      }
      continue
    }
    let (text, quoted, kind) = if c == '"' {
      let triple = i + 2 < cs.length() && cs[i + 1] == '"' && cs[i + 2] == '"'
      if triple {
        i += 3
        let begin = i
        let mut stop = -1
        while i < cs.length() {
          if cs[i] == '"' {
            let begin_quotes = i
            while i < cs.length() && cs[i] == '"' {
              i += 1
            }
            if i - begin_quotes >= 3 {
              stop = i - 3
              break
            }
          } else {
            i += 1
          }
        }
        if stop < 0 {
          raise Located("unterminated triple-quoted string", position)
        }
        (String::from_array(cs[begin:stop]), true, "string")
      } else {
        i += 1
        let mut escaped = false
        let mut closed = false
        while i < cs.length() {
          let ch = cs[i]
          i += 1
          if escaped {
            escaped = false
          } else if ch == '\\' {
            escaped = true
          } else if ch == '"' {
            closed = true
            break
          }
        }
        if !closed {
          raise Located("unterminated string", position)
        }
        let literal = String::from_array(cs[start:i])
        let decoded = @json.parse(literal) catch {
          _ => raise Located("invalid JSON string", position)
        }
        match decoded {
          String(value) => (value, true, "string")
          _ => raise Located("quoted string required", position)
        }
      }
    } else if ['{', '}', '[', ']', ':', '=', ',', '$', '?', '(', ')'].contains(
        c,
      ) {
      i += 1
      (c.to_string(), false, "symbol")
    } else if c == '+' && i + 1 < cs.length() && cs[i + 1] == '=' {
      i += 2
      ("+=", false, "symbol")
    } else {
      if ['+', '`', '^', '?', '!', '@', '*', '&', '\\'].contains(c) {
        raise Located("forbidden unquoted character", position)
      }
      let remaining = String::from_array(cs[i:(i + 5).min(cs.length())])
      let boolean_prefix = if remaining.has_prefix("true") {
        "true"
      } else if remaining.has_prefix("false") {
        "false"
      } else if remaining.has_prefix("null") {
        "null"
      } else {
        ""
      }
      let mut number_end = i
      if c == '-' || (c >= '0' && c <= '9') {
        while number_end < cs.length() &&
              (
                (cs[number_end] >= '0' && cs[number_end] <= '9') ||
                ['-', '+', '.', 'e', 'E'].contains(cs[number_end])
              ) {
          number_end += 1
        }
      }
      let number = String::from_array(cs[i:number_end])
      if !boolean_prefix.is_empty() {
        i += boolean_prefix.length()
        (
          boolean_prefix,
          false,
          if boolean_prefix == "null" {
            "null"
          } else {
            "boolean"
          },
        )
      } else if !number.is_empty() && numeric_text(number) {
        i = number_end
        (number, false, "number")
      } else {
        i += 1
        while i < cs.length() {
          if whitespace(cs[i]) ||
            [
              '$', '"', '{', '}', '[', ']', ':', '=', ',', '+', '#', '`', '^', '?',
              '!', '@', '*', '&', '\\', '(', ')',
            ].contains(cs[i]) ||
            (cs[i] == '/' && i + 1 < cs.length() && cs[i + 1] == '/') {
            break
          }
          i += 1
        }
        (String::from_array(cs[start:i]), false, "word")
      }
    }
    // Track Unicode scalar positions across multiline strings.
    for n in start..<i {
      if cs[n] == '\n' {
        line += 1
        column = 1
      } else {
        column += 1
      }
    }
    ts.push({ text, quoted, kind, gap, position, })
    gap = ""
  }
  { tokens: ts, pos: 0, end: { source: origin, offset: i, line, column, }, }
}
