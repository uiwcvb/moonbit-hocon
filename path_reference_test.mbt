// Independently captured ConfigUtil.splitPath results from the pinned native JAR.

///|
test "native API path 0" {
  let observed = (true, @hocon.split_path("")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1" {
  let observed = (true, @hocon.split_path("a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 2" {
  let observed = (true, @hocon.split_path("a.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 3" {
  let observed = (true, @hocon.split_path("1.2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "2"]))
}

///|
test "native API path 4" {
  let observed = (true, @hocon.split_path("-1.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-1", "0"]))
}

///|
test "native API path 5" {
  let observed = (true, @hocon.split_path("a-b._0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b", "_0"]))
}

///|
test "native API path 6" {
  let observed = (true, @hocon.split_path("null.true.false")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "true", "false"]))
}

///|
test "native API path 7" {
  let observed = (true, @hocon.split_path("a..b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 8" {
  let observed = (true, @hocon.split_path(".a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 9" {
  let observed = (true, @hocon.split_path("a.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 10" {
  let observed = (true, @hocon.split_path("\"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 11" {
  let observed = (true, @hocon.split_path("a.\"\".b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "", "b"]))
}

///|
test "native API path 12" {
  let observed = (true, @hocon.split_path("a.\"b.c\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "b.c"]))
}

///|
test "native API path 13" {
  let observed = (true, @hocon.split_path("a\"b\"c")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["abc"]))
}

///|
test "native API path 14" {
  let observed = (true, @hocon.split_path("\"a\"\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 15" {
  let observed = (true, @hocon.split_path("\"a\\u002Eb\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a.b"]))
}

///|
test "native API path 16" {
  let observed = (true, @hocon.split_path("\"a\\nb\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\nb"]))
}

///|
test "native API path 17" {
  let observed = (true, @hocon.split_path("\"a\\\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\"b"]))
}

///|
test "native API path 18" {
  let observed = (true, @hocon.split_path("\"a\\\\b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\\b"]))
}

///|
test "native API path 19" {
  let observed = (true, @hocon.split_path("a#comment")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 20" {
  let observed = (true, @hocon.split_path("a//comment")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 21" {
  let observed = (true, @hocon.split_path("a/*b*/")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 22" {
  let observed = (true, @hocon.split_path("\"a\".b # tail")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 23" {
  let observed = (true, @hocon.split_path("a\nb")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 24" {
  let observed = (true, @hocon.split_path("a.\nb")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 25" {
  let observed = (true, @hocon.split_path("a . b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a ", " b"]))
}

///|
test "native API path 26" {
  let observed = (true, @hocon.split_path("  a  ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 27" {
  let observed = (true, @hocon.split_path("a\tb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\tb"]))
}

///|
test "native API path 28" {
  let observed = (true, @hocon.split_path("a\r\nb")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 29" {
  let observed = (true, @hocon.split_path("a+=b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 30" {
  let observed = (true, @hocon.split_path("\u0000")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0000"]))
}

///|
test "native API path 31" {
  let observed = (true, @hocon.split_path("a\u0000b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0000b"]))
}

///|
test "native API path 32" {
  let observed = (true, @hocon.split_path("\u0000a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0000a"]))
}

///|
test "native API path 33" {
  let observed = (true, @hocon.split_path("a\u0000")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0000"]))
}

///|
test "native API path 34" {
  let observed = (true, @hocon.split_path("a.\u0000.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0000", "b"]))
}

///|
test "native API path 35" {
  let observed = (true, @hocon.split_path("\"\\u0000\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0000"]))
}

///|
test "native API path 36" {
  let observed = (true, @hocon.split_path("\u0001")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0001"]))
}

///|
test "native API path 37" {
  let observed = (true, @hocon.split_path("a\u0001b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0001b"]))
}

///|
test "native API path 38" {
  let observed = (true, @hocon.split_path("\u0001a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0001a"]))
}

///|
test "native API path 39" {
  let observed = (true, @hocon.split_path("a\u0001")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0001"]))
}

///|
test "native API path 40" {
  let observed = (true, @hocon.split_path("a.\u0001.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0001", "b"]))
}

///|
test "native API path 41" {
  let observed = (true, @hocon.split_path("\"\\u0001\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0001"]))
}

///|
test "native API path 42" {
  let observed = (true, @hocon.split_path("\u0002")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0002"]))
}

///|
test "native API path 43" {
  let observed = (true, @hocon.split_path("a\u0002b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0002b"]))
}

///|
test "native API path 44" {
  let observed = (true, @hocon.split_path("\u0002a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0002a"]))
}

///|
test "native API path 45" {
  let observed = (true, @hocon.split_path("a\u0002")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0002"]))
}

///|
test "native API path 46" {
  let observed = (true, @hocon.split_path("a.\u0002.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0002", "b"]))
}

///|
test "native API path 47" {
  let observed = (true, @hocon.split_path("\"\\u0002\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0002"]))
}

///|
test "native API path 48" {
  let observed = (true, @hocon.split_path("\u0003")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0003"]))
}

///|
test "native API path 49" {
  let observed = (true, @hocon.split_path("a\u0003b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0003b"]))
}

///|
test "native API path 50" {
  let observed = (true, @hocon.split_path("\u0003a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0003a"]))
}

///|
test "native API path 51" {
  let observed = (true, @hocon.split_path("a\u0003")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0003"]))
}

///|
test "native API path 52" {
  let observed = (true, @hocon.split_path("a.\u0003.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0003", "b"]))
}

///|
test "native API path 53" {
  let observed = (true, @hocon.split_path("\"\\u0003\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0003"]))
}

///|
test "native API path 54" {
  let observed = (true, @hocon.split_path("\u0004")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0004"]))
}

///|
test "native API path 55" {
  let observed = (true, @hocon.split_path("a\u0004b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0004b"]))
}

///|
test "native API path 56" {
  let observed = (true, @hocon.split_path("\u0004a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0004a"]))
}

///|
test "native API path 57" {
  let observed = (true, @hocon.split_path("a\u0004")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0004"]))
}

///|
test "native API path 58" {
  let observed = (true, @hocon.split_path("a.\u0004.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0004", "b"]))
}

///|
test "native API path 59" {
  let observed = (true, @hocon.split_path("\"\\u0004\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0004"]))
}

///|
test "native API path 60" {
  let observed = (true, @hocon.split_path("\u0005")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0005"]))
}

///|
test "native API path 61" {
  let observed = (true, @hocon.split_path("a\u0005b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0005b"]))
}

///|
test "native API path 62" {
  let observed = (true, @hocon.split_path("\u0005a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0005a"]))
}

///|
test "native API path 63" {
  let observed = (true, @hocon.split_path("a\u0005")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0005"]))
}

///|
test "native API path 64" {
  let observed = (true, @hocon.split_path("a.\u0005.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0005", "b"]))
}

///|
test "native API path 65" {
  let observed = (true, @hocon.split_path("\"\\u0005\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0005"]))
}

///|
test "native API path 66" {
  let observed = (true, @hocon.split_path("\u0006")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0006"]))
}

///|
test "native API path 67" {
  let observed = (true, @hocon.split_path("a\u0006b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0006b"]))
}

///|
test "native API path 68" {
  let observed = (true, @hocon.split_path("\u0006a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0006a"]))
}

///|
test "native API path 69" {
  let observed = (true, @hocon.split_path("a\u0006")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0006"]))
}

///|
test "native API path 70" {
  let observed = (true, @hocon.split_path("a.\u0006.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0006", "b"]))
}

///|
test "native API path 71" {
  let observed = (true, @hocon.split_path("\"\\u0006\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0006"]))
}

///|
test "native API path 72" {
  let observed = (true, @hocon.split_path("\u0007")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0007"]))
}

///|
test "native API path 73" {
  let observed = (true, @hocon.split_path("a\u0007b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0007b"]))
}

///|
test "native API path 74" {
  let observed = (true, @hocon.split_path("\u0007a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0007a"]))
}

///|
test "native API path 75" {
  let observed = (true, @hocon.split_path("a\u0007")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0007"]))
}

///|
test "native API path 76" {
  let observed = (true, @hocon.split_path("a.\u0007.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0007", "b"]))
}

///|
test "native API path 77" {
  let observed = (true, @hocon.split_path("\"\\u0007\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0007"]))
}

///|
test "native API path 78" {
  let observed = (true, @hocon.split_path("\b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\b"]))
}

///|
test "native API path 79" {
  let observed = (true, @hocon.split_path("a\bb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\bb"]))
}

///|
test "native API path 80" {
  let observed = (true, @hocon.split_path("\ba")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\ba"]))
}

///|
test "native API path 81" {
  let observed = (true, @hocon.split_path("a\b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\b"]))
}

///|
test "native API path 82" {
  let observed = (true, @hocon.split_path("a.\b.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "\b", "b"]))
}

///|
test "native API path 83" {
  let observed = (true, @hocon.split_path("\"\\b\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\b"]))
}

///|
test "native API path 84" {
  let observed = (true, @hocon.split_path("\t")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 85" {
  let observed = (true, @hocon.split_path("\ta")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 86" {
  let observed = (true, @hocon.split_path("a\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 87" {
  let observed = (true, @hocon.split_path("a.\t.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "\t", "b"]))
}

///|
test "native API path 88" {
  let observed = (true, @hocon.split_path("\"\\t\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\t"]))
}

///|
test "native API path 89" {
  let observed = (true, @hocon.split_path("\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 90" {
  let observed = (true, @hocon.split_path("\na")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 91" {
  let observed = (true, @hocon.split_path("a\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 92" {
  let observed = (true, @hocon.split_path("a.\n.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 93" {
  let observed = (true, @hocon.split_path("\"\\n\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\n"]))
}

///|
test "native API path 94" {
  let observed = (true, @hocon.split_path("\u000b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 95" {
  let observed = (true, @hocon.split_path("a\u000bb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u000bb"]))
}

///|
test "native API path 96" {
  let observed = (true, @hocon.split_path("\u000ba")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 97" {
  let observed = (true, @hocon.split_path("a\u000b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 98" {
  let observed = (true, @hocon.split_path("a.\u000b.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u000b", "b"]))
}

///|
test "native API path 99" {
  let observed = (true, @hocon.split_path("\"\\u000b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u000b"]))
}

///|
test "native API path 100" {
  let observed = (true, @hocon.split_path("\f")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 101" {
  let observed = (true, @hocon.split_path("a\fb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\fb"]))
}

///|
test "native API path 102" {
  let observed = (true, @hocon.split_path("\fa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 103" {
  let observed = (true, @hocon.split_path("a\f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 104" {
  let observed = (true, @hocon.split_path("a.\f.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "\f", "b"]))
}

///|
test "native API path 105" {
  let observed = (true, @hocon.split_path("\"\\f\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\f"]))
}

///|
test "native API path 106" {
  let observed = (true, @hocon.split_path("\r")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 107" {
  let observed = (true, @hocon.split_path("a\rb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\rb"]))
}

///|
test "native API path 108" {
  let observed = (true, @hocon.split_path("\ra")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 109" {
  let observed = (true, @hocon.split_path("a\r")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 110" {
  let observed = (true, @hocon.split_path("a.\r.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "\r", "b"]))
}

///|
test "native API path 111" {
  let observed = (true, @hocon.split_path("\"\\r\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\r"]))
}

///|
test "native API path 112" {
  let observed = (true, @hocon.split_path("\u000e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u000e"]))
}

///|
test "native API path 113" {
  let observed = (true, @hocon.split_path("a\u000eb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u000eb"]))
}

///|
test "native API path 114" {
  let observed = (true, @hocon.split_path("\u000ea")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u000ea"]))
}

///|
test "native API path 115" {
  let observed = (true, @hocon.split_path("a\u000e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u000e"]))
}

///|
test "native API path 116" {
  let observed = (true, @hocon.split_path("a.\u000e.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u000e", "b"]))
}

///|
test "native API path 117" {
  let observed = (true, @hocon.split_path("\"\\u000e\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u000e"]))
}

///|
test "native API path 118" {
  let observed = (true, @hocon.split_path("\u000f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u000f"]))
}

///|
test "native API path 119" {
  let observed = (true, @hocon.split_path("a\u000fb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u000fb"]))
}

///|
test "native API path 120" {
  let observed = (true, @hocon.split_path("\u000fa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u000fa"]))
}

///|
test "native API path 121" {
  let observed = (true, @hocon.split_path("a\u000f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u000f"]))
}

///|
test "native API path 122" {
  let observed = (true, @hocon.split_path("a.\u000f.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u000f", "b"]))
}

///|
test "native API path 123" {
  let observed = (true, @hocon.split_path("\"\\u000f\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u000f"]))
}

///|
test "native API path 124" {
  let observed = (true, @hocon.split_path("\u0010")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0010"]))
}

///|
test "native API path 125" {
  let observed = (true, @hocon.split_path("a\u0010b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0010b"]))
}

///|
test "native API path 126" {
  let observed = (true, @hocon.split_path("\u0010a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0010a"]))
}

///|
test "native API path 127" {
  let observed = (true, @hocon.split_path("a\u0010")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0010"]))
}

///|
test "native API path 128" {
  let observed = (true, @hocon.split_path("a.\u0010.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0010", "b"]))
}

///|
test "native API path 129" {
  let observed = (true, @hocon.split_path("\"\\u0010\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0010"]))
}

///|
test "native API path 130" {
  let observed = (true, @hocon.split_path("\u0011")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0011"]))
}

///|
test "native API path 131" {
  let observed = (true, @hocon.split_path("a\u0011b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0011b"]))
}

///|
test "native API path 132" {
  let observed = (true, @hocon.split_path("\u0011a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0011a"]))
}

///|
test "native API path 133" {
  let observed = (true, @hocon.split_path("a\u0011")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0011"]))
}

///|
test "native API path 134" {
  let observed = (true, @hocon.split_path("a.\u0011.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0011", "b"]))
}

///|
test "native API path 135" {
  let observed = (true, @hocon.split_path("\"\\u0011\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0011"]))
}

///|
test "native API path 136" {
  let observed = (true, @hocon.split_path("\u0012")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0012"]))
}

///|
test "native API path 137" {
  let observed = (true, @hocon.split_path("a\u0012b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0012b"]))
}

///|
test "native API path 138" {
  let observed = (true, @hocon.split_path("\u0012a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0012a"]))
}

///|
test "native API path 139" {
  let observed = (true, @hocon.split_path("a\u0012")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0012"]))
}

///|
test "native API path 140" {
  let observed = (true, @hocon.split_path("a.\u0012.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0012", "b"]))
}

///|
test "native API path 141" {
  let observed = (true, @hocon.split_path("\"\\u0012\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0012"]))
}

///|
test "native API path 142" {
  let observed = (true, @hocon.split_path("\u0013")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0013"]))
}

///|
test "native API path 143" {
  let observed = (true, @hocon.split_path("a\u0013b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0013b"]))
}

///|
test "native API path 144" {
  let observed = (true, @hocon.split_path("\u0013a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0013a"]))
}

///|
test "native API path 145" {
  let observed = (true, @hocon.split_path("a\u0013")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0013"]))
}

///|
test "native API path 146" {
  let observed = (true, @hocon.split_path("a.\u0013.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0013", "b"]))
}

///|
test "native API path 147" {
  let observed = (true, @hocon.split_path("\"\\u0013\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0013"]))
}

///|
test "native API path 148" {
  let observed = (true, @hocon.split_path("\u0014")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0014"]))
}

///|
test "native API path 149" {
  let observed = (true, @hocon.split_path("a\u0014b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0014b"]))
}

///|
test "native API path 150" {
  let observed = (true, @hocon.split_path("\u0014a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0014a"]))
}

///|
test "native API path 151" {
  let observed = (true, @hocon.split_path("a\u0014")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0014"]))
}

///|
test "native API path 152" {
  let observed = (true, @hocon.split_path("a.\u0014.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0014", "b"]))
}

///|
test "native API path 153" {
  let observed = (true, @hocon.split_path("\"\\u0014\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0014"]))
}

///|
test "native API path 154" {
  let observed = (true, @hocon.split_path("\u0015")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0015"]))
}

///|
test "native API path 155" {
  let observed = (true, @hocon.split_path("a\u0015b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0015b"]))
}

///|
test "native API path 156" {
  let observed = (true, @hocon.split_path("\u0015a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0015a"]))
}

///|
test "native API path 157" {
  let observed = (true, @hocon.split_path("a\u0015")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0015"]))
}

///|
test "native API path 158" {
  let observed = (true, @hocon.split_path("a.\u0015.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0015", "b"]))
}

///|
test "native API path 159" {
  let observed = (true, @hocon.split_path("\"\\u0015\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0015"]))
}

///|
test "native API path 160" {
  let observed = (true, @hocon.split_path("\u0016")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0016"]))
}

///|
test "native API path 161" {
  let observed = (true, @hocon.split_path("a\u0016b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0016b"]))
}

///|
test "native API path 162" {
  let observed = (true, @hocon.split_path("\u0016a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0016a"]))
}

///|
test "native API path 163" {
  let observed = (true, @hocon.split_path("a\u0016")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0016"]))
}

///|
test "native API path 164" {
  let observed = (true, @hocon.split_path("a.\u0016.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0016", "b"]))
}

///|
test "native API path 165" {
  let observed = (true, @hocon.split_path("\"\\u0016\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0016"]))
}

///|
test "native API path 166" {
  let observed = (true, @hocon.split_path("\u0017")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0017"]))
}

///|
test "native API path 167" {
  let observed = (true, @hocon.split_path("a\u0017b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0017b"]))
}

///|
test "native API path 168" {
  let observed = (true, @hocon.split_path("\u0017a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0017a"]))
}

///|
test "native API path 169" {
  let observed = (true, @hocon.split_path("a\u0017")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0017"]))
}

///|
test "native API path 170" {
  let observed = (true, @hocon.split_path("a.\u0017.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0017", "b"]))
}

///|
test "native API path 171" {
  let observed = (true, @hocon.split_path("\"\\u0017\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0017"]))
}

///|
test "native API path 172" {
  let observed = (true, @hocon.split_path("\u0018")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0018"]))
}

///|
test "native API path 173" {
  let observed = (true, @hocon.split_path("a\u0018b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0018b"]))
}

///|
test "native API path 174" {
  let observed = (true, @hocon.split_path("\u0018a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0018a"]))
}

///|
test "native API path 175" {
  let observed = (true, @hocon.split_path("a\u0018")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0018"]))
}

///|
test "native API path 176" {
  let observed = (true, @hocon.split_path("a.\u0018.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0018", "b"]))
}

///|
test "native API path 177" {
  let observed = (true, @hocon.split_path("\"\\u0018\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0018"]))
}

///|
test "native API path 178" {
  let observed = (true, @hocon.split_path("\u0019")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0019"]))
}

///|
test "native API path 179" {
  let observed = (true, @hocon.split_path("a\u0019b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u0019b"]))
}

///|
test "native API path 180" {
  let observed = (true, @hocon.split_path("\u0019a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u0019a"]))
}

///|
test "native API path 181" {
  let observed = (true, @hocon.split_path("a\u0019")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u0019"]))
}

///|
test "native API path 182" {
  let observed = (true, @hocon.split_path("a.\u0019.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u0019", "b"]))
}

///|
test "native API path 183" {
  let observed = (true, @hocon.split_path("\"\\u0019\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u0019"]))
}

///|
test "native API path 184" {
  let observed = (true, @hocon.split_path("\u001a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u001a"]))
}

///|
test "native API path 185" {
  let observed = (true, @hocon.split_path("a\u001ab")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001ab"]))
}

///|
test "native API path 186" {
  let observed = (true, @hocon.split_path("\u001aa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u001aa"]))
}

///|
test "native API path 187" {
  let observed = (true, @hocon.split_path("a\u001a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u001a"]))
}

///|
test "native API path 188" {
  let observed = (true, @hocon.split_path("a.\u001a.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001a", "b"]))
}

///|
test "native API path 189" {
  let observed = (true, @hocon.split_path("\"\\u001a\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001a"]))
}

///|
test "native API path 190" {
  let observed = (true, @hocon.split_path("\u001b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u001b"]))
}

///|
test "native API path 191" {
  let observed = (true, @hocon.split_path("a\u001bb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001bb"]))
}

///|
test "native API path 192" {
  let observed = (true, @hocon.split_path("\u001ba")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["\u001ba"]))
}

///|
test "native API path 193" {
  let observed = (true, @hocon.split_path("a\u001b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a\u001b"]))
}

///|
test "native API path 194" {
  let observed = (true, @hocon.split_path("a.\u001b.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001b", "b"]))
}

///|
test "native API path 195" {
  let observed = (true, @hocon.split_path("\"\\u001b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001b"]))
}

///|
test "native API path 196" {
  let observed = (true, @hocon.split_path("\u001c")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 197" {
  let observed = (true, @hocon.split_path("a\u001cb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001cb"]))
}

///|
test "native API path 198" {
  let observed = (true, @hocon.split_path("\u001ca")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 199" {
  let observed = (true, @hocon.split_path("a\u001c")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 200" {
  let observed = (true, @hocon.split_path("a.\u001c.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001c", "b"]))
}

///|
test "native API path 201" {
  let observed = (true, @hocon.split_path("\"\\u001c\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001c"]))
}

///|
test "native API path 202" {
  let observed = (true, @hocon.split_path("\u001d")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 203" {
  let observed = (true, @hocon.split_path("a\u001db")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001db"]))
}

///|
test "native API path 204" {
  let observed = (true, @hocon.split_path("\u001da")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 205" {
  let observed = (true, @hocon.split_path("a\u001d")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 206" {
  let observed = (true, @hocon.split_path("a.\u001d.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001d", "b"]))
}

///|
test "native API path 207" {
  let observed = (true, @hocon.split_path("\"\\u001d\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001d"]))
}

///|
test "native API path 208" {
  let observed = (true, @hocon.split_path("\u001e")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 209" {
  let observed = (true, @hocon.split_path("a\u001eb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001eb"]))
}

///|
test "native API path 210" {
  let observed = (true, @hocon.split_path("\u001ea")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 211" {
  let observed = (true, @hocon.split_path("a\u001e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 212" {
  let observed = (true, @hocon.split_path("a.\u001e.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001e", "b"]))
}

///|
test "native API path 213" {
  let observed = (true, @hocon.split_path("\"\\u001e\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001e"]))
}

///|
test "native API path 214" {
  let observed = (true, @hocon.split_path("\u001f")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 215" {
  let observed = (true, @hocon.split_path("a\u001fb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a\u001fb"]))
}

///|
test "native API path 216" {
  let observed = (true, @hocon.split_path("\u001fa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 217" {
  let observed = (true, @hocon.split_path("a\u001f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 218" {
  let observed = (true, @hocon.split_path("a.\u001f.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "\u001f", "b"]))
}

///|
test "native API path 219" {
  let observed = (true, @hocon.split_path("\"\\u001f\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\u001f"]))
}

///|
test "native API path 220" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 221" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 222" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 223" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 224" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 225" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 226" {
  let observed = (true, @hocon.split_path("!")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 227" {
  let observed = (true, @hocon.split_path("a!b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 228" {
  let observed = (true, @hocon.split_path("!a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 229" {
  let observed = (true, @hocon.split_path("a!")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 230" {
  let observed = (true, @hocon.split_path("a.!.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 231" {
  let observed = (true, @hocon.split_path("\"!\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["!"]))
}

///|
test "native API path 232" {
  let observed = (true, @hocon.split_path("\"")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 233" {
  let observed = (true, @hocon.split_path("a\"b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 234" {
  let observed = (true, @hocon.split_path("\"a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 235" {
  let observed = (true, @hocon.split_path("a\"")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 236" {
  let observed = (true, @hocon.split_path("a.\".b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 237" {
  let observed = (true, @hocon.split_path("\"\\\"\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\""]))
}

///|
test "native API path 238" {
  let observed = (true, @hocon.split_path("#")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 239" {
  let observed = (true, @hocon.split_path("a#b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 240" {
  let observed = (true, @hocon.split_path("#a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 241" {
  let observed = (true, @hocon.split_path("a#")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 242" {
  let observed = (true, @hocon.split_path("a.#.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 243" {
  let observed = (true, @hocon.split_path("\"#\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["#"]))
}

///|
test "native API path 244" {
  let observed = (true, @hocon.split_path("$")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 245" {
  let observed = (true, @hocon.split_path("a$b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 246" {
  let observed = (true, @hocon.split_path("$a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 247" {
  let observed = (true, @hocon.split_path("a$")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 248" {
  let observed = (true, @hocon.split_path("a.$.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 249" {
  let observed = (true, @hocon.split_path("\"$\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["$"]))
}

///|
test "native API path 250" {
  let observed = (true, @hocon.split_path("%")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["%"]))
}

///|
test "native API path 251" {
  let observed = (true, @hocon.split_path("a%b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a%b"]))
}

///|
test "native API path 252" {
  let observed = (true, @hocon.split_path("%a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["%a"]))
}

///|
test "native API path 253" {
  let observed = (true, @hocon.split_path("a%")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a%"]))
}

///|
test "native API path 254" {
  let observed = (true, @hocon.split_path("a.%.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "%", "b"]))
}

///|
test "native API path 255" {
  let observed = (true, @hocon.split_path("\"%\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["%"]))
}

///|
test "native API path 256" {
  let observed = (true, @hocon.split_path("&")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 257" {
  let observed = (true, @hocon.split_path("a&b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 258" {
  let observed = (true, @hocon.split_path("&a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 259" {
  let observed = (true, @hocon.split_path("a&")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 260" {
  let observed = (true, @hocon.split_path("a.&.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 261" {
  let observed = (true, @hocon.split_path("\"&\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["&"]))
}

///|
test "native API path 262" {
  let observed = (true, @hocon.split_path("'")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["'"]))
}

///|
test "native API path 263" {
  let observed = (true, @hocon.split_path("a'b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a'b"]))
}

///|
test "native API path 264" {
  let observed = (true, @hocon.split_path("'a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["'a"]))
}

///|
test "native API path 265" {
  let observed = (true, @hocon.split_path("a'")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a'"]))
}

///|
test "native API path 266" {
  let observed = (true, @hocon.split_path("a.'.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "'", "b"]))
}

///|
test "native API path 267" {
  let observed = (true, @hocon.split_path("\"'\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["'"]))
}

///|
test "native API path 268" {
  let observed = (true, @hocon.split_path("(")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["("]))
}

///|
test "native API path 269" {
  let observed = (true, @hocon.split_path("a(b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a(b"]))
}

///|
test "native API path 270" {
  let observed = (true, @hocon.split_path("(a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["(a"]))
}

///|
test "native API path 271" {
  let observed = (true, @hocon.split_path("a(")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a("]))
}

///|
test "native API path 272" {
  let observed = (true, @hocon.split_path("a.(.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "(", "b"]))
}

///|
test "native API path 273" {
  let observed = (true, @hocon.split_path("\"(\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["("]))
}

///|
test "native API path 274" {
  let observed = (true, @hocon.split_path(")")) catch { _ => (false, []) }
  assert_eq(observed, (true, [")"]))
}

///|
test "native API path 275" {
  let observed = (true, @hocon.split_path("a)b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a)b"]))
}

///|
test "native API path 276" {
  let observed = (true, @hocon.split_path(")a")) catch { _ => (false, []) }
  assert_eq(observed, (true, [")a"]))
}

///|
test "native API path 277" {
  let observed = (true, @hocon.split_path("a)")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a)"]))
}

///|
test "native API path 278" {
  let observed = (true, @hocon.split_path("a.).b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", ")", "b"]))
}

///|
test "native API path 279" {
  let observed = (true, @hocon.split_path("\")\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [")"]))
}

///|
test "native API path 280" {
  let observed = (true, @hocon.split_path("*")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 281" {
  let observed = (true, @hocon.split_path("a*b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 282" {
  let observed = (true, @hocon.split_path("*a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 283" {
  let observed = (true, @hocon.split_path("a*")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 284" {
  let observed = (true, @hocon.split_path("a.*.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 285" {
  let observed = (true, @hocon.split_path("\"*\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["*"]))
}

///|
test "native API path 286" {
  let observed = (true, @hocon.split_path("+")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 287" {
  let observed = (true, @hocon.split_path("a+b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 288" {
  let observed = (true, @hocon.split_path("+a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 289" {
  let observed = (true, @hocon.split_path("a+")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 290" {
  let observed = (true, @hocon.split_path("a.+.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 291" {
  let observed = (true, @hocon.split_path("\"+\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["+"]))
}

///|
test "native API path 292" {
  let observed = (true, @hocon.split_path(",")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 293" {
  let observed = (true, @hocon.split_path("a,b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 294" {
  let observed = (true, @hocon.split_path(",a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 295" {
  let observed = (true, @hocon.split_path("a,")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 296" {
  let observed = (true, @hocon.split_path("a.,.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 297" {
  let observed = (true, @hocon.split_path("\",\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [","]))
}

///|
test "native API path 298" {
  let observed = (true, @hocon.split_path("-")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-"]))
}

///|
test "native API path 299" {
  let observed = (true, @hocon.split_path("a-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 300" {
  let observed = (true, @hocon.split_path("-a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-a"]))
}

///|
test "native API path 301" {
  let observed = (true, @hocon.split_path("a-")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-"]))
}

///|
test "native API path 302" {
  let observed = (true, @hocon.split_path("a.-.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-", "b"]))
}

///|
test "native API path 303" {
  let observed = (true, @hocon.split_path("\"-\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-"]))
}

///|
test "native API path 304" {
  let observed = (true, @hocon.split_path(".")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 305" {
  let observed = (true, @hocon.split_path("a...b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 306" {
  let observed = (true, @hocon.split_path("\".\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["."]))
}

///|
test "native API path 307" {
  let observed = (true, @hocon.split_path("/")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["/"]))
}

///|
test "native API path 308" {
  let observed = (true, @hocon.split_path("a/b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a/b"]))
}

///|
test "native API path 309" {
  let observed = (true, @hocon.split_path("/a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["/a"]))
}

///|
test "native API path 310" {
  let observed = (true, @hocon.split_path("a/")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a/"]))
}

///|
test "native API path 311" {
  let observed = (true, @hocon.split_path("a./.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "/", "b"]))
}

///|
test "native API path 312" {
  let observed = (true, @hocon.split_path("\"/\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["/"]))
}

///|
test "native API path 313" {
  let observed = (true, @hocon.split_path("0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 314" {
  let observed = (true, @hocon.split_path("a0b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a0b"]))
}

///|
test "native API path 315" {
  let observed = (true, @hocon.split_path("0a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0a"]))
}

///|
test "native API path 316" {
  let observed = (true, @hocon.split_path("a0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a0"]))
}

///|
test "native API path 317" {
  let observed = (true, @hocon.split_path("a.0.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "0", "b"]))
}

///|
test "native API path 318" {
  let observed = (true, @hocon.split_path("\"0\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 319" {
  let observed = (true, @hocon.split_path("1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 320" {
  let observed = (true, @hocon.split_path("a1b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a1b"]))
}

///|
test "native API path 321" {
  let observed = (true, @hocon.split_path("1a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1a"]))
}

///|
test "native API path 322" {
  let observed = (true, @hocon.split_path("a1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a1"]))
}

///|
test "native API path 323" {
  let observed = (true, @hocon.split_path("a.1.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1", "b"]))
}

///|
test "native API path 324" {
  let observed = (true, @hocon.split_path("\"1\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 325" {
  let observed = (true, @hocon.split_path("2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["2"]))
}

///|
test "native API path 326" {
  let observed = (true, @hocon.split_path("a2b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a2b"]))
}

///|
test "native API path 327" {
  let observed = (true, @hocon.split_path("2a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["2a"]))
}

///|
test "native API path 328" {
  let observed = (true, @hocon.split_path("a2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a2"]))
}

///|
test "native API path 329" {
  let observed = (true, @hocon.split_path("a.2.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "2", "b"]))
}

///|
test "native API path 330" {
  let observed = (true, @hocon.split_path("\"2\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["2"]))
}

///|
test "native API path 331" {
  let observed = (true, @hocon.split_path("3")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["3"]))
}

///|
test "native API path 332" {
  let observed = (true, @hocon.split_path("a3b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a3b"]))
}

///|
test "native API path 333" {
  let observed = (true, @hocon.split_path("3a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["3a"]))
}

///|
test "native API path 334" {
  let observed = (true, @hocon.split_path("a3")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a3"]))
}

///|
test "native API path 335" {
  let observed = (true, @hocon.split_path("a.3.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "3", "b"]))
}

///|
test "native API path 336" {
  let observed = (true, @hocon.split_path("\"3\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["3"]))
}

///|
test "native API path 337" {
  let observed = (true, @hocon.split_path("4")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["4"]))
}

///|
test "native API path 338" {
  let observed = (true, @hocon.split_path("a4b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a4b"]))
}

///|
test "native API path 339" {
  let observed = (true, @hocon.split_path("4a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["4a"]))
}

///|
test "native API path 340" {
  let observed = (true, @hocon.split_path("a4")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a4"]))
}

///|
test "native API path 341" {
  let observed = (true, @hocon.split_path("a.4.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "4", "b"]))
}

///|
test "native API path 342" {
  let observed = (true, @hocon.split_path("\"4\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["4"]))
}

///|
test "native API path 343" {
  let observed = (true, @hocon.split_path("5")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["5"]))
}

///|
test "native API path 344" {
  let observed = (true, @hocon.split_path("a5b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a5b"]))
}

///|
test "native API path 345" {
  let observed = (true, @hocon.split_path("5a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["5a"]))
}

///|
test "native API path 346" {
  let observed = (true, @hocon.split_path("a5")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a5"]))
}

///|
test "native API path 347" {
  let observed = (true, @hocon.split_path("a.5.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "5", "b"]))
}

///|
test "native API path 348" {
  let observed = (true, @hocon.split_path("\"5\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["5"]))
}

///|
test "native API path 349" {
  let observed = (true, @hocon.split_path("6")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["6"]))
}

///|
test "native API path 350" {
  let observed = (true, @hocon.split_path("a6b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a6b"]))
}

///|
test "native API path 351" {
  let observed = (true, @hocon.split_path("6a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["6a"]))
}

///|
test "native API path 352" {
  let observed = (true, @hocon.split_path("a6")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a6"]))
}

///|
test "native API path 353" {
  let observed = (true, @hocon.split_path("a.6.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "6", "b"]))
}

///|
test "native API path 354" {
  let observed = (true, @hocon.split_path("\"6\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["6"]))
}

///|
test "native API path 355" {
  let observed = (true, @hocon.split_path("7")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["7"]))
}

///|
test "native API path 356" {
  let observed = (true, @hocon.split_path("a7b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a7b"]))
}

///|
test "native API path 357" {
  let observed = (true, @hocon.split_path("7a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["7a"]))
}

///|
test "native API path 358" {
  let observed = (true, @hocon.split_path("a7")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a7"]))
}

///|
test "native API path 359" {
  let observed = (true, @hocon.split_path("a.7.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "7", "b"]))
}

///|
test "native API path 360" {
  let observed = (true, @hocon.split_path("\"7\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["7"]))
}

///|
test "native API path 361" {
  let observed = (true, @hocon.split_path("8")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["8"]))
}

///|
test "native API path 362" {
  let observed = (true, @hocon.split_path("a8b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a8b"]))
}

///|
test "native API path 363" {
  let observed = (true, @hocon.split_path("8a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["8a"]))
}

///|
test "native API path 364" {
  let observed = (true, @hocon.split_path("a8")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a8"]))
}

///|
test "native API path 365" {
  let observed = (true, @hocon.split_path("a.8.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "8", "b"]))
}

///|
test "native API path 366" {
  let observed = (true, @hocon.split_path("\"8\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["8"]))
}

///|
test "native API path 367" {
  let observed = (true, @hocon.split_path("9")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9"]))
}

///|
test "native API path 368" {
  let observed = (true, @hocon.split_path("a9b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a9b"]))
}

///|
test "native API path 369" {
  let observed = (true, @hocon.split_path("9a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9a"]))
}

///|
test "native API path 370" {
  let observed = (true, @hocon.split_path("a9")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a9"]))
}

///|
test "native API path 371" {
  let observed = (true, @hocon.split_path("a.9.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "9", "b"]))
}

///|
test "native API path 372" {
  let observed = (true, @hocon.split_path("\"9\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9"]))
}

///|
test "native API path 373" {
  let observed = (true, @hocon.split_path(":")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 374" {
  let observed = (true, @hocon.split_path("a:b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 375" {
  let observed = (true, @hocon.split_path(":a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 376" {
  let observed = (true, @hocon.split_path("a:")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 377" {
  let observed = (true, @hocon.split_path("a.:.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 378" {
  let observed = (true, @hocon.split_path("\":\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [":"]))
}

///|
test "native API path 379" {
  let observed = (true, @hocon.split_path(";")) catch { _ => (false, []) }
  assert_eq(observed, (true, [";"]))
}

///|
test "native API path 380" {
  let observed = (true, @hocon.split_path("a;b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a;b"]))
}

///|
test "native API path 381" {
  let observed = (true, @hocon.split_path(";a")) catch { _ => (false, []) }
  assert_eq(observed, (true, [";a"]))
}

///|
test "native API path 382" {
  let observed = (true, @hocon.split_path("a;")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a;"]))
}

///|
test "native API path 383" {
  let observed = (true, @hocon.split_path("a.;.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", ";", "b"]))
}

///|
test "native API path 384" {
  let observed = (true, @hocon.split_path("\";\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [";"]))
}

///|
test "native API path 385" {
  let observed = (true, @hocon.split_path("<")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["<"]))
}

///|
test "native API path 386" {
  let observed = (true, @hocon.split_path("a<b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a<b"]))
}

///|
test "native API path 387" {
  let observed = (true, @hocon.split_path("<a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["<a"]))
}

///|
test "native API path 388" {
  let observed = (true, @hocon.split_path("a<")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a<"]))
}

///|
test "native API path 389" {
  let observed = (true, @hocon.split_path("a.<.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "<", "b"]))
}

///|
test "native API path 390" {
  let observed = (true, @hocon.split_path("\"<\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["<"]))
}

///|
test "native API path 391" {
  let observed = (true, @hocon.split_path("=")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 392" {
  let observed = (true, @hocon.split_path("a=b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 393" {
  let observed = (true, @hocon.split_path("=a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 394" {
  let observed = (true, @hocon.split_path("a=")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 395" {
  let observed = (true, @hocon.split_path("a.=.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 396" {
  let observed = (true, @hocon.split_path("\"=\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["="]))
}

///|
test "native API path 397" {
  let observed = (true, @hocon.split_path(">")) catch { _ => (false, []) }
  assert_eq(observed, (true, [">"]))
}

///|
test "native API path 398" {
  let observed = (true, @hocon.split_path("a>b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a>b"]))
}

///|
test "native API path 399" {
  let observed = (true, @hocon.split_path(">a")) catch { _ => (false, []) }
  assert_eq(observed, (true, [">a"]))
}

///|
test "native API path 400" {
  let observed = (true, @hocon.split_path("a>")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a>"]))
}

///|
test "native API path 401" {
  let observed = (true, @hocon.split_path("a.>.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", ">", "b"]))
}

///|
test "native API path 402" {
  let observed = (true, @hocon.split_path("\">\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [">"]))
}

///|
test "native API path 403" {
  let observed = (true, @hocon.split_path("?")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 404" {
  let observed = (true, @hocon.split_path("a?b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 405" {
  let observed = (true, @hocon.split_path("?a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 406" {
  let observed = (true, @hocon.split_path("a?")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 407" {
  let observed = (true, @hocon.split_path("a.?.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 408" {
  let observed = (true, @hocon.split_path("\"?\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["?"]))
}

///|
test "native API path 409" {
  let observed = (true, @hocon.split_path("@")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 410" {
  let observed = (true, @hocon.split_path("a@b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 411" {
  let observed = (true, @hocon.split_path("@a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 412" {
  let observed = (true, @hocon.split_path("a@")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 413" {
  let observed = (true, @hocon.split_path("a.@.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 414" {
  let observed = (true, @hocon.split_path("\"@\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["@"]))
}

///|
test "native API path 415" {
  let observed = (true, @hocon.split_path("A")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A"]))
}

///|
test "native API path 416" {
  let observed = (true, @hocon.split_path("aAb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aAb"]))
}

///|
test "native API path 417" {
  let observed = (true, @hocon.split_path("Aa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Aa"]))
}

///|
test "native API path 418" {
  let observed = (true, @hocon.split_path("aA")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aA"]))
}

///|
test "native API path 419" {
  let observed = (true, @hocon.split_path("a.A.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "A", "b"]))
}

///|
test "native API path 420" {
  let observed = (true, @hocon.split_path("\"A\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A"]))
}

///|
test "native API path 421" {
  let observed = (true, @hocon.split_path("B")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["B"]))
}

///|
test "native API path 422" {
  let observed = (true, @hocon.split_path("aBb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aBb"]))
}

///|
test "native API path 423" {
  let observed = (true, @hocon.split_path("Ba")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ba"]))
}

///|
test "native API path 424" {
  let observed = (true, @hocon.split_path("aB")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aB"]))
}

///|
test "native API path 425" {
  let observed = (true, @hocon.split_path("a.B.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "B", "b"]))
}

///|
test "native API path 426" {
  let observed = (true, @hocon.split_path("\"B\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["B"]))
}

///|
test "native API path 427" {
  let observed = (true, @hocon.split_path("C")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["C"]))
}

///|
test "native API path 428" {
  let observed = (true, @hocon.split_path("aCb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aCb"]))
}

///|
test "native API path 429" {
  let observed = (true, @hocon.split_path("Ca")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ca"]))
}

///|
test "native API path 430" {
  let observed = (true, @hocon.split_path("aC")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aC"]))
}

///|
test "native API path 431" {
  let observed = (true, @hocon.split_path("a.C.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "C", "b"]))
}

///|
test "native API path 432" {
  let observed = (true, @hocon.split_path("\"C\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["C"]))
}

///|
test "native API path 433" {
  let observed = (true, @hocon.split_path("D")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["D"]))
}

///|
test "native API path 434" {
  let observed = (true, @hocon.split_path("aDb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aDb"]))
}

///|
test "native API path 435" {
  let observed = (true, @hocon.split_path("Da")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Da"]))
}

///|
test "native API path 436" {
  let observed = (true, @hocon.split_path("aD")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aD"]))
}

///|
test "native API path 437" {
  let observed = (true, @hocon.split_path("a.D.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "D", "b"]))
}

///|
test "native API path 438" {
  let observed = (true, @hocon.split_path("\"D\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["D"]))
}

///|
test "native API path 439" {
  let observed = (true, @hocon.split_path("E")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["E"]))
}

///|
test "native API path 440" {
  let observed = (true, @hocon.split_path("aEb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aEb"]))
}

///|
test "native API path 441" {
  let observed = (true, @hocon.split_path("Ea")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ea"]))
}

///|
test "native API path 442" {
  let observed = (true, @hocon.split_path("aE")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aE"]))
}

///|
test "native API path 443" {
  let observed = (true, @hocon.split_path("a.E.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "E", "b"]))
}

///|
test "native API path 444" {
  let observed = (true, @hocon.split_path("\"E\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["E"]))
}

///|
test "native API path 445" {
  let observed = (true, @hocon.split_path("F")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["F"]))
}

///|
test "native API path 446" {
  let observed = (true, @hocon.split_path("aFb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aFb"]))
}

///|
test "native API path 447" {
  let observed = (true, @hocon.split_path("Fa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Fa"]))
}

///|
test "native API path 448" {
  let observed = (true, @hocon.split_path("aF")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aF"]))
}

///|
test "native API path 449" {
  let observed = (true, @hocon.split_path("a.F.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "F", "b"]))
}

///|
test "native API path 450" {
  let observed = (true, @hocon.split_path("\"F\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["F"]))
}

///|
test "native API path 451" {
  let observed = (true, @hocon.split_path("G")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["G"]))
}

///|
test "native API path 452" {
  let observed = (true, @hocon.split_path("aGb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aGb"]))
}

///|
test "native API path 453" {
  let observed = (true, @hocon.split_path("Ga")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ga"]))
}

///|
test "native API path 454" {
  let observed = (true, @hocon.split_path("aG")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aG"]))
}

///|
test "native API path 455" {
  let observed = (true, @hocon.split_path("a.G.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "G", "b"]))
}

///|
test "native API path 456" {
  let observed = (true, @hocon.split_path("\"G\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["G"]))
}

///|
test "native API path 457" {
  let observed = (true, @hocon.split_path("H")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["H"]))
}

///|
test "native API path 458" {
  let observed = (true, @hocon.split_path("aHb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aHb"]))
}

///|
test "native API path 459" {
  let observed = (true, @hocon.split_path("Ha")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ha"]))
}

///|
test "native API path 460" {
  let observed = (true, @hocon.split_path("aH")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aH"]))
}

///|
test "native API path 461" {
  let observed = (true, @hocon.split_path("a.H.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "H", "b"]))
}

///|
test "native API path 462" {
  let observed = (true, @hocon.split_path("\"H\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["H"]))
}

///|
test "native API path 463" {
  let observed = (true, @hocon.split_path("I")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["I"]))
}

///|
test "native API path 464" {
  let observed = (true, @hocon.split_path("aIb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aIb"]))
}

///|
test "native API path 465" {
  let observed = (true, @hocon.split_path("Ia")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ia"]))
}

///|
test "native API path 466" {
  let observed = (true, @hocon.split_path("aI")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aI"]))
}

///|
test "native API path 467" {
  let observed = (true, @hocon.split_path("a.I.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "I", "b"]))
}

///|
test "native API path 468" {
  let observed = (true, @hocon.split_path("\"I\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["I"]))
}

///|
test "native API path 469" {
  let observed = (true, @hocon.split_path("J")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["J"]))
}

///|
test "native API path 470" {
  let observed = (true, @hocon.split_path("aJb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aJb"]))
}

///|
test "native API path 471" {
  let observed = (true, @hocon.split_path("Ja")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ja"]))
}

///|
test "native API path 472" {
  let observed = (true, @hocon.split_path("aJ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aJ"]))
}

///|
test "native API path 473" {
  let observed = (true, @hocon.split_path("a.J.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "J", "b"]))
}

///|
test "native API path 474" {
  let observed = (true, @hocon.split_path("\"J\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["J"]))
}

///|
test "native API path 475" {
  let observed = (true, @hocon.split_path("K")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["K"]))
}

///|
test "native API path 476" {
  let observed = (true, @hocon.split_path("aKb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aKb"]))
}

///|
test "native API path 477" {
  let observed = (true, @hocon.split_path("Ka")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ka"]))
}

///|
test "native API path 478" {
  let observed = (true, @hocon.split_path("aK")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aK"]))
}

///|
test "native API path 479" {
  let observed = (true, @hocon.split_path("a.K.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "K", "b"]))
}

///|
test "native API path 480" {
  let observed = (true, @hocon.split_path("\"K\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["K"]))
}

///|
test "native API path 481" {
  let observed = (true, @hocon.split_path("L")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["L"]))
}

///|
test "native API path 482" {
  let observed = (true, @hocon.split_path("aLb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aLb"]))
}

///|
test "native API path 483" {
  let observed = (true, @hocon.split_path("La")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["La"]))
}

///|
test "native API path 484" {
  let observed = (true, @hocon.split_path("aL")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aL"]))
}

///|
test "native API path 485" {
  let observed = (true, @hocon.split_path("a.L.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "L", "b"]))
}

///|
test "native API path 486" {
  let observed = (true, @hocon.split_path("\"L\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["L"]))
}

///|
test "native API path 487" {
  let observed = (true, @hocon.split_path("M")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["M"]))
}

///|
test "native API path 488" {
  let observed = (true, @hocon.split_path("aMb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aMb"]))
}

///|
test "native API path 489" {
  let observed = (true, @hocon.split_path("Ma")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ma"]))
}

///|
test "native API path 490" {
  let observed = (true, @hocon.split_path("aM")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aM"]))
}

///|
test "native API path 491" {
  let observed = (true, @hocon.split_path("a.M.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "M", "b"]))
}

///|
test "native API path 492" {
  let observed = (true, @hocon.split_path("\"M\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["M"]))
}

///|
test "native API path 493" {
  let observed = (true, @hocon.split_path("N")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["N"]))
}

///|
test "native API path 494" {
  let observed = (true, @hocon.split_path("aNb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aNb"]))
}

///|
test "native API path 495" {
  let observed = (true, @hocon.split_path("Na")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Na"]))
}

///|
test "native API path 496" {
  let observed = (true, @hocon.split_path("aN")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aN"]))
}

///|
test "native API path 497" {
  let observed = (true, @hocon.split_path("a.N.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "N", "b"]))
}

///|
test "native API path 498" {
  let observed = (true, @hocon.split_path("\"N\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["N"]))
}

///|
test "native API path 499" {
  let observed = (true, @hocon.split_path("O")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["O"]))
}

///|
test "native API path 500" {
  let observed = (true, @hocon.split_path("aOb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aOb"]))
}

///|
test "native API path 501" {
  let observed = (true, @hocon.split_path("Oa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Oa"]))
}

///|
test "native API path 502" {
  let observed = (true, @hocon.split_path("aO")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aO"]))
}

///|
test "native API path 503" {
  let observed = (true, @hocon.split_path("a.O.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "O", "b"]))
}

///|
test "native API path 504" {
  let observed = (true, @hocon.split_path("\"O\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["O"]))
}

///|
test "native API path 505" {
  let observed = (true, @hocon.split_path("P")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["P"]))
}

///|
test "native API path 506" {
  let observed = (true, @hocon.split_path("aPb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aPb"]))
}

///|
test "native API path 507" {
  let observed = (true, @hocon.split_path("Pa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Pa"]))
}

///|
test "native API path 508" {
  let observed = (true, @hocon.split_path("aP")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aP"]))
}

///|
test "native API path 509" {
  let observed = (true, @hocon.split_path("a.P.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "P", "b"]))
}

///|
test "native API path 510" {
  let observed = (true, @hocon.split_path("\"P\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["P"]))
}

///|
test "native API path 511" {
  let observed = (true, @hocon.split_path("Q")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Q"]))
}

///|
test "native API path 512" {
  let observed = (true, @hocon.split_path("aQb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aQb"]))
}

///|
test "native API path 513" {
  let observed = (true, @hocon.split_path("Qa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Qa"]))
}

///|
test "native API path 514" {
  let observed = (true, @hocon.split_path("aQ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aQ"]))
}

///|
test "native API path 515" {
  let observed = (true, @hocon.split_path("a.Q.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "Q", "b"]))
}

///|
test "native API path 516" {
  let observed = (true, @hocon.split_path("\"Q\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Q"]))
}

///|
test "native API path 517" {
  let observed = (true, @hocon.split_path("R")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["R"]))
}

///|
test "native API path 518" {
  let observed = (true, @hocon.split_path("aRb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aRb"]))
}

///|
test "native API path 519" {
  let observed = (true, @hocon.split_path("Ra")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ra"]))
}

///|
test "native API path 520" {
  let observed = (true, @hocon.split_path("aR")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aR"]))
}

///|
test "native API path 521" {
  let observed = (true, @hocon.split_path("a.R.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "R", "b"]))
}

///|
test "native API path 522" {
  let observed = (true, @hocon.split_path("\"R\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["R"]))
}

///|
test "native API path 523" {
  let observed = (true, @hocon.split_path("S")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["S"]))
}

///|
test "native API path 524" {
  let observed = (true, @hocon.split_path("aSb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aSb"]))
}

///|
test "native API path 525" {
  let observed = (true, @hocon.split_path("Sa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Sa"]))
}

///|
test "native API path 526" {
  let observed = (true, @hocon.split_path("aS")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aS"]))
}

///|
test "native API path 527" {
  let observed = (true, @hocon.split_path("a.S.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "S", "b"]))
}

///|
test "native API path 528" {
  let observed = (true, @hocon.split_path("\"S\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["S"]))
}

///|
test "native API path 529" {
  let observed = (true, @hocon.split_path("T")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["T"]))
}

///|
test "native API path 530" {
  let observed = (true, @hocon.split_path("aTb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aTb"]))
}

///|
test "native API path 531" {
  let observed = (true, @hocon.split_path("Ta")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ta"]))
}

///|
test "native API path 532" {
  let observed = (true, @hocon.split_path("aT")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aT"]))
}

///|
test "native API path 533" {
  let observed = (true, @hocon.split_path("a.T.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "T", "b"]))
}

///|
test "native API path 534" {
  let observed = (true, @hocon.split_path("\"T\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["T"]))
}

///|
test "native API path 535" {
  let observed = (true, @hocon.split_path("U")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["U"]))
}

///|
test "native API path 536" {
  let observed = (true, @hocon.split_path("aUb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aUb"]))
}

///|
test "native API path 537" {
  let observed = (true, @hocon.split_path("Ua")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ua"]))
}

///|
test "native API path 538" {
  let observed = (true, @hocon.split_path("aU")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aU"]))
}

///|
test "native API path 539" {
  let observed = (true, @hocon.split_path("a.U.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "U", "b"]))
}

///|
test "native API path 540" {
  let observed = (true, @hocon.split_path("\"U\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["U"]))
}

///|
test "native API path 541" {
  let observed = (true, @hocon.split_path("V")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["V"]))
}

///|
test "native API path 542" {
  let observed = (true, @hocon.split_path("aVb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aVb"]))
}

///|
test "native API path 543" {
  let observed = (true, @hocon.split_path("Va")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Va"]))
}

///|
test "native API path 544" {
  let observed = (true, @hocon.split_path("aV")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aV"]))
}

///|
test "native API path 545" {
  let observed = (true, @hocon.split_path("a.V.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "V", "b"]))
}

///|
test "native API path 546" {
  let observed = (true, @hocon.split_path("\"V\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["V"]))
}

///|
test "native API path 547" {
  let observed = (true, @hocon.split_path("W")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["W"]))
}

///|
test "native API path 548" {
  let observed = (true, @hocon.split_path("aWb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aWb"]))
}

///|
test "native API path 549" {
  let observed = (true, @hocon.split_path("Wa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Wa"]))
}

///|
test "native API path 550" {
  let observed = (true, @hocon.split_path("aW")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aW"]))
}

///|
test "native API path 551" {
  let observed = (true, @hocon.split_path("a.W.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "W", "b"]))
}

///|
test "native API path 552" {
  let observed = (true, @hocon.split_path("\"W\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["W"]))
}

///|
test "native API path 553" {
  let observed = (true, @hocon.split_path("X")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["X"]))
}

///|
test "native API path 554" {
  let observed = (true, @hocon.split_path("aXb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aXb"]))
}

///|
test "native API path 555" {
  let observed = (true, @hocon.split_path("Xa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Xa"]))
}

///|
test "native API path 556" {
  let observed = (true, @hocon.split_path("aX")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aX"]))
}

///|
test "native API path 557" {
  let observed = (true, @hocon.split_path("a.X.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "X", "b"]))
}

///|
test "native API path 558" {
  let observed = (true, @hocon.split_path("\"X\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["X"]))
}

///|
test "native API path 559" {
  let observed = (true, @hocon.split_path("Y")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Y"]))
}

///|
test "native API path 560" {
  let observed = (true, @hocon.split_path("aYb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aYb"]))
}

///|
test "native API path 561" {
  let observed = (true, @hocon.split_path("Ya")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ya"]))
}

///|
test "native API path 562" {
  let observed = (true, @hocon.split_path("aY")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aY"]))
}

///|
test "native API path 563" {
  let observed = (true, @hocon.split_path("a.Y.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "Y", "b"]))
}

///|
test "native API path 564" {
  let observed = (true, @hocon.split_path("\"Y\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Y"]))
}

///|
test "native API path 565" {
  let observed = (true, @hocon.split_path("Z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Z"]))
}

///|
test "native API path 566" {
  let observed = (true, @hocon.split_path("aZb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aZb"]))
}

///|
test "native API path 567" {
  let observed = (true, @hocon.split_path("Za")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Za"]))
}

///|
test "native API path 568" {
  let observed = (true, @hocon.split_path("aZ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aZ"]))
}

///|
test "native API path 569" {
  let observed = (true, @hocon.split_path("a.Z.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "Z", "b"]))
}

///|
test "native API path 570" {
  let observed = (true, @hocon.split_path("\"Z\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Z"]))
}

///|
test "native API path 571" {
  let observed = (true, @hocon.split_path("[")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 572" {
  let observed = (true, @hocon.split_path("a[b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 573" {
  let observed = (true, @hocon.split_path("[a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 574" {
  let observed = (true, @hocon.split_path("a[")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 575" {
  let observed = (true, @hocon.split_path("a.[.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 576" {
  let observed = (true, @hocon.split_path("\"[\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["["]))
}

///|
test "native API path 577" {
  let observed = (true, @hocon.split_path("\\")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 578" {
  let observed = (true, @hocon.split_path("a\\b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 579" {
  let observed = (true, @hocon.split_path("\\a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 580" {
  let observed = (true, @hocon.split_path("a\\")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 581" {
  let observed = (true, @hocon.split_path("a.\\.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 582" {
  let observed = (true, @hocon.split_path("\"\\\\\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["\\"]))
}

///|
test "native API path 583" {
  let observed = (true, @hocon.split_path("]")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 584" {
  let observed = (true, @hocon.split_path("a]b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 585" {
  let observed = (true, @hocon.split_path("]a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 586" {
  let observed = (true, @hocon.split_path("a]")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 587" {
  let observed = (true, @hocon.split_path("a.].b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 588" {
  let observed = (true, @hocon.split_path("\"]\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["]"]))
}

///|
test "native API path 589" {
  let observed = (true, @hocon.split_path("^")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 590" {
  let observed = (true, @hocon.split_path("a^b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 591" {
  let observed = (true, @hocon.split_path("^a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 592" {
  let observed = (true, @hocon.split_path("a^")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 593" {
  let observed = (true, @hocon.split_path("a.^.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 594" {
  let observed = (true, @hocon.split_path("\"^\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["^"]))
}

///|
test "native API path 595" {
  let observed = (true, @hocon.split_path("_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_"]))
}

///|
test "native API path 596" {
  let observed = (true, @hocon.split_path("a_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a_b"]))
}

///|
test "native API path 597" {
  let observed = (true, @hocon.split_path("_a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_a"]))
}

///|
test "native API path 598" {
  let observed = (true, @hocon.split_path("a_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a_"]))
}

///|
test "native API path 599" {
  let observed = (true, @hocon.split_path("a._.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "_", "b"]))
}

///|
test "native API path 600" {
  let observed = (true, @hocon.split_path("\"_\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_"]))
}

///|
test "native API path 601" {
  let observed = (true, @hocon.split_path("`")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 602" {
  let observed = (true, @hocon.split_path("a`b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 603" {
  let observed = (true, @hocon.split_path("`a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 604" {
  let observed = (true, @hocon.split_path("a`")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 605" {
  let observed = (true, @hocon.split_path("a.`.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 606" {
  let observed = (true, @hocon.split_path("\"`\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["`"]))
}

///|
test "native API path 607" {
  let observed = (true, @hocon.split_path("aab")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aab"]))
}

///|
test "native API path 608" {
  let observed = (true, @hocon.split_path("aa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aa"]))
}

///|
test "native API path 609" {
  let observed = (true, @hocon.split_path("a.a.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "a", "b"]))
}

///|
test "native API path 610" {
  let observed = (true, @hocon.split_path("\"a\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 611" {
  let observed = (true, @hocon.split_path("b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["b"]))
}

///|
test "native API path 612" {
  let observed = (true, @hocon.split_path("abb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["abb"]))
}

///|
test "native API path 613" {
  let observed = (true, @hocon.split_path("ba")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ba"]))
}

///|
test "native API path 614" {
  let observed = (true, @hocon.split_path("ab")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 615" {
  let observed = (true, @hocon.split_path("a.b.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b", "b"]))
}

///|
test "native API path 616" {
  let observed = (true, @hocon.split_path("\"b\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["b"]))
}

///|
test "native API path 617" {
  let observed = (true, @hocon.split_path("c")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["c"]))
}

///|
test "native API path 618" {
  let observed = (true, @hocon.split_path("acb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["acb"]))
}

///|
test "native API path 619" {
  let observed = (true, @hocon.split_path("ca")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ca"]))
}

///|
test "native API path 620" {
  let observed = (true, @hocon.split_path("ac")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ac"]))
}

///|
test "native API path 621" {
  let observed = (true, @hocon.split_path("a.c.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "c", "b"]))
}

///|
test "native API path 622" {
  let observed = (true, @hocon.split_path("\"c\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["c"]))
}

///|
test "native API path 623" {
  let observed = (true, @hocon.split_path("d")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["d"]))
}

///|
test "native API path 624" {
  let observed = (true, @hocon.split_path("adb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["adb"]))
}

///|
test "native API path 625" {
  let observed = (true, @hocon.split_path("da")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["da"]))
}

///|
test "native API path 626" {
  let observed = (true, @hocon.split_path("ad")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ad"]))
}

///|
test "native API path 627" {
  let observed = (true, @hocon.split_path("a.d.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "d", "b"]))
}

///|
test "native API path 628" {
  let observed = (true, @hocon.split_path("\"d\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["d"]))
}

///|
test "native API path 629" {
  let observed = (true, @hocon.split_path("e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["e"]))
}

///|
test "native API path 630" {
  let observed = (true, @hocon.split_path("aeb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aeb"]))
}

///|
test "native API path 631" {
  let observed = (true, @hocon.split_path("ea")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ea"]))
}

///|
test "native API path 632" {
  let observed = (true, @hocon.split_path("ae")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ae"]))
}

///|
test "native API path 633" {
  let observed = (true, @hocon.split_path("a.e.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "e", "b"]))
}

///|
test "native API path 634" {
  let observed = (true, @hocon.split_path("\"e\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["e"]))
}

///|
test "native API path 635" {
  let observed = (true, @hocon.split_path("f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["f"]))
}

///|
test "native API path 636" {
  let observed = (true, @hocon.split_path("afb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["afb"]))
}

///|
test "native API path 637" {
  let observed = (true, @hocon.split_path("fa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["fa"]))
}

///|
test "native API path 638" {
  let observed = (true, @hocon.split_path("af")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["af"]))
}

///|
test "native API path 639" {
  let observed = (true, @hocon.split_path("a.f.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "f", "b"]))
}

///|
test "native API path 640" {
  let observed = (true, @hocon.split_path("\"f\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["f"]))
}

///|
test "native API path 641" {
  let observed = (true, @hocon.split_path("g")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["g"]))
}

///|
test "native API path 642" {
  let observed = (true, @hocon.split_path("agb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["agb"]))
}

///|
test "native API path 643" {
  let observed = (true, @hocon.split_path("ga")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ga"]))
}

///|
test "native API path 644" {
  let observed = (true, @hocon.split_path("ag")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ag"]))
}

///|
test "native API path 645" {
  let observed = (true, @hocon.split_path("a.g.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "g", "b"]))
}

///|
test "native API path 646" {
  let observed = (true, @hocon.split_path("\"g\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["g"]))
}

///|
test "native API path 647" {
  let observed = (true, @hocon.split_path("h")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["h"]))
}

///|
test "native API path 648" {
  let observed = (true, @hocon.split_path("ahb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ahb"]))
}

///|
test "native API path 649" {
  let observed = (true, @hocon.split_path("ha")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ha"]))
}

///|
test "native API path 650" {
  let observed = (true, @hocon.split_path("ah")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ah"]))
}

///|
test "native API path 651" {
  let observed = (true, @hocon.split_path("a.h.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "h", "b"]))
}

///|
test "native API path 652" {
  let observed = (true, @hocon.split_path("\"h\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["h"]))
}

///|
test "native API path 653" {
  let observed = (true, @hocon.split_path("i")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["i"]))
}

///|
test "native API path 654" {
  let observed = (true, @hocon.split_path("aib")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aib"]))
}

///|
test "native API path 655" {
  let observed = (true, @hocon.split_path("ia")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ia"]))
}

///|
test "native API path 656" {
  let observed = (true, @hocon.split_path("ai")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ai"]))
}

///|
test "native API path 657" {
  let observed = (true, @hocon.split_path("a.i.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "i", "b"]))
}

///|
test "native API path 658" {
  let observed = (true, @hocon.split_path("\"i\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["i"]))
}

///|
test "native API path 659" {
  let observed = (true, @hocon.split_path("j")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["j"]))
}

///|
test "native API path 660" {
  let observed = (true, @hocon.split_path("ajb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ajb"]))
}

///|
test "native API path 661" {
  let observed = (true, @hocon.split_path("ja")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ja"]))
}

///|
test "native API path 662" {
  let observed = (true, @hocon.split_path("aj")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aj"]))
}

///|
test "native API path 663" {
  let observed = (true, @hocon.split_path("a.j.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "j", "b"]))
}

///|
test "native API path 664" {
  let observed = (true, @hocon.split_path("\"j\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["j"]))
}

///|
test "native API path 665" {
  let observed = (true, @hocon.split_path("k")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["k"]))
}

///|
test "native API path 666" {
  let observed = (true, @hocon.split_path("akb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["akb"]))
}

///|
test "native API path 667" {
  let observed = (true, @hocon.split_path("ka")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ka"]))
}

///|
test "native API path 668" {
  let observed = (true, @hocon.split_path("ak")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ak"]))
}

///|
test "native API path 669" {
  let observed = (true, @hocon.split_path("a.k.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "k", "b"]))
}

///|
test "native API path 670" {
  let observed = (true, @hocon.split_path("\"k\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["k"]))
}

///|
test "native API path 671" {
  let observed = (true, @hocon.split_path("l")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["l"]))
}

///|
test "native API path 672" {
  let observed = (true, @hocon.split_path("alb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["alb"]))
}

///|
test "native API path 673" {
  let observed = (true, @hocon.split_path("la")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["la"]))
}

///|
test "native API path 674" {
  let observed = (true, @hocon.split_path("al")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["al"]))
}

///|
test "native API path 675" {
  let observed = (true, @hocon.split_path("a.l.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "l", "b"]))
}

///|
test "native API path 676" {
  let observed = (true, @hocon.split_path("\"l\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["l"]))
}

///|
test "native API path 677" {
  let observed = (true, @hocon.split_path("m")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["m"]))
}

///|
test "native API path 678" {
  let observed = (true, @hocon.split_path("amb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["amb"]))
}

///|
test "native API path 679" {
  let observed = (true, @hocon.split_path("ma")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ma"]))
}

///|
test "native API path 680" {
  let observed = (true, @hocon.split_path("am")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["am"]))
}

///|
test "native API path 681" {
  let observed = (true, @hocon.split_path("a.m.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "m", "b"]))
}

///|
test "native API path 682" {
  let observed = (true, @hocon.split_path("\"m\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["m"]))
}

///|
test "native API path 683" {
  let observed = (true, @hocon.split_path("n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["n"]))
}

///|
test "native API path 684" {
  let observed = (true, @hocon.split_path("anb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["anb"]))
}

///|
test "native API path 685" {
  let observed = (true, @hocon.split_path("na")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["na"]))
}

///|
test "native API path 686" {
  let observed = (true, @hocon.split_path("an")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["an"]))
}

///|
test "native API path 687" {
  let observed = (true, @hocon.split_path("a.n.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "n", "b"]))
}

///|
test "native API path 688" {
  let observed = (true, @hocon.split_path("\"n\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["n"]))
}

///|
test "native API path 689" {
  let observed = (true, @hocon.split_path("o")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["o"]))
}

///|
test "native API path 690" {
  let observed = (true, @hocon.split_path("aob")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aob"]))
}

///|
test "native API path 691" {
  let observed = (true, @hocon.split_path("oa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["oa"]))
}

///|
test "native API path 692" {
  let observed = (true, @hocon.split_path("ao")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ao"]))
}

///|
test "native API path 693" {
  let observed = (true, @hocon.split_path("a.o.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "o", "b"]))
}

///|
test "native API path 694" {
  let observed = (true, @hocon.split_path("\"o\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["o"]))
}

///|
test "native API path 695" {
  let observed = (true, @hocon.split_path("p")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["p"]))
}

///|
test "native API path 696" {
  let observed = (true, @hocon.split_path("apb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["apb"]))
}

///|
test "native API path 697" {
  let observed = (true, @hocon.split_path("pa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["pa"]))
}

///|
test "native API path 698" {
  let observed = (true, @hocon.split_path("ap")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ap"]))
}

///|
test "native API path 699" {
  let observed = (true, @hocon.split_path("a.p.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "p", "b"]))
}

///|
test "native API path 700" {
  let observed = (true, @hocon.split_path("\"p\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["p"]))
}

///|
test "native API path 701" {
  let observed = (true, @hocon.split_path("q")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["q"]))
}

///|
test "native API path 702" {
  let observed = (true, @hocon.split_path("aqb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aqb"]))
}

///|
test "native API path 703" {
  let observed = (true, @hocon.split_path("qa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["qa"]))
}

///|
test "native API path 704" {
  let observed = (true, @hocon.split_path("aq")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aq"]))
}

///|
test "native API path 705" {
  let observed = (true, @hocon.split_path("a.q.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "q", "b"]))
}

///|
test "native API path 706" {
  let observed = (true, @hocon.split_path("\"q\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["q"]))
}

///|
test "native API path 707" {
  let observed = (true, @hocon.split_path("r")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["r"]))
}

///|
test "native API path 708" {
  let observed = (true, @hocon.split_path("arb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["arb"]))
}

///|
test "native API path 709" {
  let observed = (true, @hocon.split_path("ra")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ra"]))
}

///|
test "native API path 710" {
  let observed = (true, @hocon.split_path("ar")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ar"]))
}

///|
test "native API path 711" {
  let observed = (true, @hocon.split_path("a.r.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "r", "b"]))
}

///|
test "native API path 712" {
  let observed = (true, @hocon.split_path("\"r\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["r"]))
}

///|
test "native API path 713" {
  let observed = (true, @hocon.split_path("s")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["s"]))
}

///|
test "native API path 714" {
  let observed = (true, @hocon.split_path("asb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["asb"]))
}

///|
test "native API path 715" {
  let observed = (true, @hocon.split_path("sa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["sa"]))
}

///|
test "native API path 716" {
  let observed = (true, @hocon.split_path("as")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["as"]))
}

///|
test "native API path 717" {
  let observed = (true, @hocon.split_path("a.s.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "s", "b"]))
}

///|
test "native API path 718" {
  let observed = (true, @hocon.split_path("\"s\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["s"]))
}

///|
test "native API path 719" {
  let observed = (true, @hocon.split_path("t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["t"]))
}

///|
test "native API path 720" {
  let observed = (true, @hocon.split_path("atb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["atb"]))
}

///|
test "native API path 721" {
  let observed = (true, @hocon.split_path("ta")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ta"]))
}

///|
test "native API path 722" {
  let observed = (true, @hocon.split_path("at")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["at"]))
}

///|
test "native API path 723" {
  let observed = (true, @hocon.split_path("a.t.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "t", "b"]))
}

///|
test "native API path 724" {
  let observed = (true, @hocon.split_path("\"t\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["t"]))
}

///|
test "native API path 725" {
  let observed = (true, @hocon.split_path("u")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["u"]))
}

///|
test "native API path 726" {
  let observed = (true, @hocon.split_path("aub")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aub"]))
}

///|
test "native API path 727" {
  let observed = (true, @hocon.split_path("ua")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ua"]))
}

///|
test "native API path 728" {
  let observed = (true, @hocon.split_path("au")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["au"]))
}

///|
test "native API path 729" {
  let observed = (true, @hocon.split_path("a.u.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "u", "b"]))
}

///|
test "native API path 730" {
  let observed = (true, @hocon.split_path("\"u\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["u"]))
}

///|
test "native API path 731" {
  let observed = (true, @hocon.split_path("v")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["v"]))
}

///|
test "native API path 732" {
  let observed = (true, @hocon.split_path("avb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["avb"]))
}

///|
test "native API path 733" {
  let observed = (true, @hocon.split_path("va")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["va"]))
}

///|
test "native API path 734" {
  let observed = (true, @hocon.split_path("av")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["av"]))
}

///|
test "native API path 735" {
  let observed = (true, @hocon.split_path("a.v.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "v", "b"]))
}

///|
test "native API path 736" {
  let observed = (true, @hocon.split_path("\"v\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["v"]))
}

///|
test "native API path 737" {
  let observed = (true, @hocon.split_path("w")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["w"]))
}

///|
test "native API path 738" {
  let observed = (true, @hocon.split_path("awb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["awb"]))
}

///|
test "native API path 739" {
  let observed = (true, @hocon.split_path("wa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["wa"]))
}

///|
test "native API path 740" {
  let observed = (true, @hocon.split_path("aw")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aw"]))
}

///|
test "native API path 741" {
  let observed = (true, @hocon.split_path("a.w.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "w", "b"]))
}

///|
test "native API path 742" {
  let observed = (true, @hocon.split_path("\"w\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["w"]))
}

///|
test "native API path 743" {
  let observed = (true, @hocon.split_path("x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["x"]))
}

///|
test "native API path 744" {
  let observed = (true, @hocon.split_path("axb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["axb"]))
}

///|
test "native API path 745" {
  let observed = (true, @hocon.split_path("xa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["xa"]))
}

///|
test "native API path 746" {
  let observed = (true, @hocon.split_path("ax")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ax"]))
}

///|
test "native API path 747" {
  let observed = (true, @hocon.split_path("a.x.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "x", "b"]))
}

///|
test "native API path 748" {
  let observed = (true, @hocon.split_path("\"x\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["x"]))
}

///|
test "native API path 749" {
  let observed = (true, @hocon.split_path("y")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["y"]))
}

///|
test "native API path 750" {
  let observed = (true, @hocon.split_path("ayb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ayb"]))
}

///|
test "native API path 751" {
  let observed = (true, @hocon.split_path("ya")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ya"]))
}

///|
test "native API path 752" {
  let observed = (true, @hocon.split_path("ay")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ay"]))
}

///|
test "native API path 753" {
  let observed = (true, @hocon.split_path("a.y.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "y", "b"]))
}

///|
test "native API path 754" {
  let observed = (true, @hocon.split_path("\"y\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["y"]))
}

///|
test "native API path 755" {
  let observed = (true, @hocon.split_path("z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["z"]))
}

///|
test "native API path 756" {
  let observed = (true, @hocon.split_path("azb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["azb"]))
}

///|
test "native API path 757" {
  let observed = (true, @hocon.split_path("za")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["za"]))
}

///|
test "native API path 758" {
  let observed = (true, @hocon.split_path("az")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["az"]))
}

///|
test "native API path 759" {
  let observed = (true, @hocon.split_path("a.z.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "z", "b"]))
}

///|
test "native API path 760" {
  let observed = (true, @hocon.split_path("\"z\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["z"]))
}

///|
test "native API path 761" {
  let observed = (true, @hocon.split_path("{")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 762" {
  let observed = (true, @hocon.split_path("a{b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 763" {
  let observed = (true, @hocon.split_path("{a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 764" {
  let observed = (true, @hocon.split_path("a{")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 765" {
  let observed = (true, @hocon.split_path("a.{.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 766" {
  let observed = (true, @hocon.split_path("\"{\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["{"]))
}

///|
test "native API path 767" {
  let observed = (true, @hocon.split_path("|")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["|"]))
}

///|
test "native API path 768" {
  let observed = (true, @hocon.split_path("a|b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a|b"]))
}

///|
test "native API path 769" {
  let observed = (true, @hocon.split_path("|a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["|a"]))
}

///|
test "native API path 770" {
  let observed = (true, @hocon.split_path("a|")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a|"]))
}

///|
test "native API path 771" {
  let observed = (true, @hocon.split_path("a.|.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "|", "b"]))
}

///|
test "native API path 772" {
  let observed = (true, @hocon.split_path("\"|\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["|"]))
}

///|
test "native API path 773" {
  let observed = (true, @hocon.split_path("}")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 774" {
  let observed = (true, @hocon.split_path("a}b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 775" {
  let observed = (true, @hocon.split_path("}a")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 776" {
  let observed = (true, @hocon.split_path("a}")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 777" {
  let observed = (true, @hocon.split_path("a.}.b")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 778" {
  let observed = (true, @hocon.split_path("\"}\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["}"]))
}

///|
test "native API path 779" {
  let observed = (true, @hocon.split_path("~")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["~"]))
}

///|
test "native API path 780" {
  let observed = (true, @hocon.split_path("a~b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a~b"]))
}

///|
test "native API path 781" {
  let observed = (true, @hocon.split_path("~a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["~a"]))
}

///|
test "native API path 782" {
  let observed = (true, @hocon.split_path("a~")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a~"]))
}

///|
test "native API path 783" {
  let observed = (true, @hocon.split_path("a.~.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "~", "b"]))
}

///|
test "native API path 784" {
  let observed = (true, @hocon.split_path("\"~\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["~"]))
}

///|
test "native API path 785" {
  let observed = (true, @hocon.split_path("")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 786" {
  let observed = (true, @hocon.split_path("ab")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 787" {
  let observed = (true, @hocon.split_path("a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 788" {
  let observed = (true, @hocon.split_path("a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 789" {
  let observed = (true, @hocon.split_path("a..b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "", "b"]))
}

///|
test "native API path 790" {
  let observed = (true, @hocon.split_path("\"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 791" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 792" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 793" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 794" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 795" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 796" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 797" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 798" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 799" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 800" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 801" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 802" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 803" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 804" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 805" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 806" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 807" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 808" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 809" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 810" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 811" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 812" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 813" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 814" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 815" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 816" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 817" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 818" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 819" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 820" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 821" {
  let observed = (true, @hocon.split_path("​")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["​"]))
}

///|
test "native API path 822" {
  let observed = (true, @hocon.split_path("a​b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a​b"]))
}

///|
test "native API path 823" {
  let observed = (true, @hocon.split_path("​a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["​a"]))
}

///|
test "native API path 824" {
  let observed = (true, @hocon.split_path("a​")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a​"]))
}

///|
test "native API path 825" {
  let observed = (true, @hocon.split_path("a.​.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "​", "b"]))
}

///|
test "native API path 826" {
  let observed = (true, @hocon.split_path("\"​\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["​"]))
}

///|
test "native API path 827" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 828" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 829" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 830" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 831" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 832" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 833" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 834" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 835" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 836" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 837" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 838" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 839" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 840" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 841" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 842" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 843" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 844" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 845" {
  let observed = (true, @hocon.split_path(" ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 846" {
  let observed = (true, @hocon.split_path("a b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a b"]))
}

///|
test "native API path 847" {
  let observed = (true, @hocon.split_path(" a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 848" {
  let observed = (true, @hocon.split_path("a ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 849" {
  let observed = (true, @hocon.split_path("a. .b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", " ", "b"]))
}

///|
test "native API path 850" {
  let observed = (true, @hocon.split_path("\" \"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [" "]))
}

///|
test "native API path 851" {
  let observed = (true, @hocon.split_path("　")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 852" {
  let observed = (true, @hocon.split_path("a　b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a　b"]))
}

///|
test "native API path 853" {
  let observed = (true, @hocon.split_path("　a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 854" {
  let observed = (true, @hocon.split_path("a　")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 855" {
  let observed = (true, @hocon.split_path("a.　.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "　", "b"]))
}

///|
test "native API path 856" {
  let observed = (true, @hocon.split_path("\"　\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["　"]))
}

///|
test "native API path 857" {
  let observed = (true, @hocon.split_path("﻿")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 858" {
  let observed = (true, @hocon.split_path("a﻿b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a﻿b"]))
}

///|
test "native API path 859" {
  let observed = (true, @hocon.split_path("﻿a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 860" {
  let observed = (true, @hocon.split_path("a﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 861" {
  let observed = (true, @hocon.split_path("a.﻿.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "﻿", "b"]))
}

///|
test "native API path 862" {
  let observed = (true, @hocon.split_path("\"﻿\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["﻿"]))
}

///|
test "native API path 863" {
  let observed = (true, @hocon.split_path("α")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 864" {
  let observed = (true, @hocon.split_path("aαb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aαb"]))
}

///|
test "native API path 865" {
  let observed = (true, @hocon.split_path("αa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["αa"]))
}

///|
test "native API path 866" {
  let observed = (true, @hocon.split_path("aα")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["aα"]))
}

///|
test "native API path 867" {
  let observed = (true, @hocon.split_path("a.α.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "α", "b"]))
}

///|
test "native API path 868" {
  let observed = (true, @hocon.split_path("\"α\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 869" {
  let observed = (true, @hocon.split_path("中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 870" {
  let observed = (true, @hocon.split_path("a中b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a中b"]))
}

///|
test "native API path 871" {
  let observed = (true, @hocon.split_path("中a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中a"]))
}

///|
test "native API path 872" {
  let observed = (true, @hocon.split_path("a中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a中"]))
}

///|
test "native API path 873" {
  let observed = (true, @hocon.split_path("a.中.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "中", "b"]))
}

///|
test "native API path 874" {
  let observed = (true, @hocon.split_path("\"中\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 875" {
  let observed = (true, @hocon.split_path("１")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["１"]))
}

///|
test "native API path 876" {
  let observed = (true, @hocon.split_path("a１b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a１b"]))
}

///|
test "native API path 877" {
  let observed = (true, @hocon.split_path("１a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["１a"]))
}

///|
test "native API path 878" {
  let observed = (true, @hocon.split_path("a１")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a１"]))
}

///|
test "native API path 879" {
  let observed = (true, @hocon.split_path("a.１.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "１", "b"]))
}

///|
test "native API path 880" {
  let observed = (true, @hocon.split_path("\"１\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["１"]))
}

///|
test "native API path 881" {
  let observed = (true, @hocon.split_path("😀")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["😀"]))
}

///|
test "native API path 882" {
  let observed = (true, @hocon.split_path("a😀b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a😀b"]))
}

///|
test "native API path 883" {
  let observed = (true, @hocon.split_path("😀a")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["😀a"]))
}

///|
test "native API path 884" {
  let observed = (true, @hocon.split_path("a😀")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a😀"]))
}

///|
test "native API path 885" {
  let observed = (true, @hocon.split_path("a.😀.b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "😀", "b"]))
}

///|
test "native API path 886" {
  let observed = (true, @hocon.split_path("\"😀\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["😀"]))
}

///|
test "native API path 887" {
  let observed = (true, @hocon.split_path("x.x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["x", "x"]))
}

///|
test "native API path 888" {
  let observed = (true, @hocon.split_path("x.x.x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["x", "x", "x"]))
}

///|
test "native API path 889" {
  let observed = (true, @hocon.split_path("x.x.x.x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["x", "x", "x", "x"]))
}

///|
test "native API path 890" {
  let observed = (true, @hocon.split_path("x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["x", "x", "x", "x", "x"]))
}

///|
test "native API path 891" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["x", "x", "x", "x", "x", "x"]))
}

///|
test "native API path 892" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["x", "x", "x", "x", "x", "x", "x"]))
}

///|
test "native API path 893" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["x", "x", "x", "x", "x", "x", "x", "x"]))
}

///|
test "native API path 894" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["x", "x", "x", "x", "x", "x", "x", "x", "x"]))
}

///|
test "native API path 895" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x"]),
  )
}

///|
test "native API path 896" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x"]),
  )
}

///|
test "native API path 897" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x"]),
  )
}

///|
test "native API path 898" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x"]),
  )
}

///|
test "native API path 899" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x"],
    ),
  )
}

///|
test "native API path 900" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 901" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x",
      ],
    ),
  )
}

///|
test "native API path 902" {
  let observed = (true, @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x",
      ],
    ),
  )
}

///|
test "native API path 903" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 904" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 905" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 906" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 907" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 908" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 909" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 910" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 911" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 912" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 913" {
  let observed = (
    true,
    @hocon.split_path("x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 914" {
  let observed = (
    true,
    @hocon.split_path(
      "x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 915" {
  let observed = (
    true,
    @hocon.split_path(
      "x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
      ],
    ),
  )
}

///|
test "native API path 916" {
  let observed = (
    true,
    @hocon.split_path(
      "x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x",
      ],
    ),
  )
}

///|
test "native API path 917" {
  let observed = (
    true,
    @hocon.split_path(
      "x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x",
        "x", "x",
      ],
    ),
  )
}

///|
test "native API path 918" {
  let observed = (true, @hocon.split_path("1.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "1"]))
}

///|
test "native API path 919" {
  let observed = (true, @hocon.split_path("1.1.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "1", "1"]))
}

///|
test "native API path 920" {
  let observed = (true, @hocon.split_path("1.1.1.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "1", "1", "1"]))
}

///|
test "native API path 921" {
  let observed = (true, @hocon.split_path("1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "1", "1", "1", "1"]))
}

///|
test "native API path 922" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "1", "1", "1", "1", "1"]))
}

///|
test "native API path 923" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "1", "1", "1", "1", "1", "1"]))
}

///|
test "native API path 924" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "1", "1", "1", "1", "1", "1", "1"]))
}

///|
test "native API path 925" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "1", "1", "1", "1", "1", "1", "1", "1"]))
}

///|
test "native API path 926" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]),
  )
}

///|
test "native API path 927" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]),
  )
}

///|
test "native API path 928" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]),
  )
}

///|
test "native API path 929" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]),
  )
}

///|
test "native API path 930" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
    ),
  )
}

///|
test "native API path 931" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 932" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1",
      ],
    ),
  )
}

///|
test "native API path 933" {
  let observed = (true, @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1",
      ],
    ),
  )
}

///|
test "native API path 934" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 935" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 936" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 937" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 938" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 939" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 940" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 941" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 942" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 943" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 944" {
  let observed = (
    true,
    @hocon.split_path("1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 945" {
  let observed = (
    true,
    @hocon.split_path(
      "1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 946" {
  let observed = (
    true,
    @hocon.split_path(
      "1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
      ],
    ),
  )
}

///|
test "native API path 947" {
  let observed = (
    true,
    @hocon.split_path(
      "1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1",
      ],
    ),
  )
}

///|
test "native API path 948" {
  let observed = (
    true,
    @hocon.split_path(
      "1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "1", "1",
      ],
    ),
  )
}

///|
test "native API path 949" {
  let observed = (true, @hocon.split_path("-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-2"]))
}

///|
test "native API path 950" {
  let observed = (true, @hocon.split_path("-2.-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-2", "-2"]))
}

///|
test "native API path 951" {
  let observed = (true, @hocon.split_path("-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2"]))
}

///|
test "native API path 952" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2", "-2"]))
}

///|
test "native API path 953" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2", "-2", "-2"]))
}

///|
test "native API path 954" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2", "-2", "-2", "-2"]))
}

///|
test "native API path 955" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2", "-2", "-2", "-2", "-2"]))
}

///|
test "native API path 956" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2"]))
}

///|
test "native API path 957" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2"]),
  )
}

///|
test "native API path 958" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2"]),
  )
}

///|
test "native API path 959" {
  let observed = (true, @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2"]),
  )
}

///|
test "native API path 960" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2"],
    ),
  )
}

///|
test "native API path 961" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 962" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2",
      ],
    ),
  )
}

///|
test "native API path 963" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 964" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 965" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 966" {
  let observed = (
    true,
    @hocon.split_path("-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 967" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 968" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 969" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 970" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 971" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 972" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 973" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 974" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 975" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2",
      ],
    ),
  )
}

///|
test "native API path 976" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 977" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 978" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 979" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 980" {
  let observed = (
    true,
    @hocon.split_path(
      "-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2.-2",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2", "-2",
        "-2", "-2", "-2", "-2", "-2", "-2",
      ],
    ),
  )
}

///|
test "native API path 981" {
  let observed = (true, @hocon.split_path("_._")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_", "_"]))
}

///|
test "native API path 982" {
  let observed = (true, @hocon.split_path("_._._")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_", "_", "_"]))
}

///|
test "native API path 983" {
  let observed = (true, @hocon.split_path("_._._._")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_", "_", "_", "_"]))
}

///|
test "native API path 984" {
  let observed = (true, @hocon.split_path("_._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_", "_", "_", "_", "_"]))
}

///|
test "native API path 985" {
  let observed = (true, @hocon.split_path("_._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_", "_", "_", "_", "_", "_"]))
}

///|
test "native API path 986" {
  let observed = (true, @hocon.split_path("_._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_", "_", "_", "_", "_", "_", "_"]))
}

///|
test "native API path 987" {
  let observed = (true, @hocon.split_path("_._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_", "_", "_", "_", "_", "_", "_", "_"]))
}

///|
test "native API path 988" {
  let observed = (true, @hocon.split_path("_._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_", "_", "_", "_", "_", "_", "_", "_", "_"]))
}

///|
test "native API path 989" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_"]),
  )
}

///|
test "native API path 990" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"]),
  )
}

///|
test "native API path 991" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"]),
  )
}

///|
test "native API path 992" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"]),
  )
}

///|
test "native API path 993" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
    ),
  )
}

///|
test "native API path 994" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 995" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_",
      ],
    ),
  )
}

///|
test "native API path 996" {
  let observed = (true, @hocon.split_path("_._._._._._._._._._._._._._._._._")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_",
      ],
    ),
  )
}

///|
test "native API path 997" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 998" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 999" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1000" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1001" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1002" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1003" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1004" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1005" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1006" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1007" {
  let observed = (
    true,
    @hocon.split_path("_._._._._._._._._._._._._._._._._._._._._._._._._._._._"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1008" {
  let observed = (
    true,
    @hocon.split_path(
      "_._._._._._._._._._._._._._._._._._._._._._._._._._._._._",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1009" {
  let observed = (
    true,
    @hocon.split_path(
      "_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1010" {
  let observed = (
    true,
    @hocon.split_path(
      "_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_",
      ],
    ),
  )
}

///|
test "native API path 1011" {
  let observed = (
    true,
    @hocon.split_path(
      "_._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._._",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_",
      ],
    ),
  )
}

///|
test "native API path 1012" {
  let observed = (true, @hocon.split_path("a-b.a-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b", "a-b"]))
}

///|
test "native API path 1013" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b", "a-b", "a-b"]))
}

///|
test "native API path 1014" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b", "a-b", "a-b", "a-b"]))
}

///|
test "native API path 1015" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b", "a-b", "a-b", "a-b", "a-b"]))
}

///|
test "native API path 1016" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b", "a-b", "a-b", "a-b", "a-b", "a-b"]))
}

///|
test "native API path 1017" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b"]))
}

///|
test "native API path 1018" {
  let observed = (true, @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b"]),
  )
}

///|
test "native API path 1019" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b"]),
  )
}

///|
test "native API path 1020" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b"],
    ),
  )
}

///|
test "native API path 1021" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1022" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b",
      ],
    ),
  )
}

///|
test "native API path 1023" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1024" {
  let observed = (
    true,
    @hocon.split_path("a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1025" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1026" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1027" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1028" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1029" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1030" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1031" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1032" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1033" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b",
      ],
    ),
  )
}

///|
test "native API path 1034" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1035" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1036" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1037" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1038" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1039" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1040" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1041" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1042" {
  let observed = (
    true,
    @hocon.split_path(
      "a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b.a-b",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
        "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b", "a-b",
      ],
    ),
  )
}

///|
test "native API path 1043" {
  let observed = (true, @hocon.split_path("null")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["null"]))
}

///|
test "native API path 1044" {
  let observed = (true, @hocon.split_path("null.null")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "null"]))
}

///|
test "native API path 1045" {
  let observed = (true, @hocon.split_path("null.null.null")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "null", "null"]))
}

///|
test "native API path 1046" {
  let observed = (true, @hocon.split_path("null.null.null.null")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "null", "null", "null"]))
}

///|
test "native API path 1047" {
  let observed = (true, @hocon.split_path("null.null.null.null.null")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "null", "null", "null", "null"]))
}

///|
test "native API path 1048" {
  let observed = (true, @hocon.split_path("null.null.null.null.null.null")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["null", "null", "null", "null", "null", "null"]))
}

///|
test "native API path 1049" {
  let observed = (true, @hocon.split_path("null.null.null.null.null.null.null")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["null", "null", "null", "null", "null", "null", "null"]),
  )
}

///|
test "native API path 1050" {
  let observed = (
    true,
    @hocon.split_path("null.null.null.null.null.null.null.null"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["null", "null", "null", "null", "null", "null", "null", "null"]),
  )
}

///|
test "native API path 1051" {
  let observed = (
    true,
    @hocon.split_path("null.null.null.null.null.null.null.null.null"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["null", "null", "null", "null", "null", "null", "null", "null", "null"],
    ),
  )
}

///|
test "native API path 1052" {
  let observed = (
    true,
    @hocon.split_path("null.null.null.null.null.null.null.null.null.null"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1053" {
  let observed = (
    true,
    @hocon.split_path("null.null.null.null.null.null.null.null.null.null.null"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null",
      ],
    ),
  )
}

///|
test "native API path 1054" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1055" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1056" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1057" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1058" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1059" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1060" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1061" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1062" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1063" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null",
      ],
    ),
  )
}

///|
test "native API path 1064" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1065" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1066" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1067" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1068" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1069" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1070" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1071" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1072" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1073" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null",
      ],
    ),
  )
}

///|
test "native API path 1074" {
  let observed = (
    true,
    @hocon.split_path(
      "null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null.null",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null", "null", "null", "null", "null", "null", "null", "null", "null",
        "null", "null",
      ],
    ),
  )
}

///|
test "native API path 1075" {
  let observed = (true, @hocon.split_path("true")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["true"]))
}

///|
test "native API path 1076" {
  let observed = (true, @hocon.split_path("true.true")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["true", "true"]))
}

///|
test "native API path 1077" {
  let observed = (true, @hocon.split_path("true.true.true")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["true", "true", "true"]))
}

///|
test "native API path 1078" {
  let observed = (true, @hocon.split_path("true.true.true.true")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["true", "true", "true", "true"]))
}

///|
test "native API path 1079" {
  let observed = (true, @hocon.split_path("true.true.true.true.true")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["true", "true", "true", "true", "true"]))
}

///|
test "native API path 1080" {
  let observed = (true, @hocon.split_path("true.true.true.true.true.true")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["true", "true", "true", "true", "true", "true"]))
}

///|
test "native API path 1081" {
  let observed = (true, @hocon.split_path("true.true.true.true.true.true.true")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["true", "true", "true", "true", "true", "true", "true"]),
  )
}

///|
test "native API path 1082" {
  let observed = (
    true,
    @hocon.split_path("true.true.true.true.true.true.true.true"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["true", "true", "true", "true", "true", "true", "true", "true"]),
  )
}

///|
test "native API path 1083" {
  let observed = (
    true,
    @hocon.split_path("true.true.true.true.true.true.true.true.true"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["true", "true", "true", "true", "true", "true", "true", "true", "true"],
    ),
  )
}

///|
test "native API path 1084" {
  let observed = (
    true,
    @hocon.split_path("true.true.true.true.true.true.true.true.true.true"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1085" {
  let observed = (
    true,
    @hocon.split_path("true.true.true.true.true.true.true.true.true.true.true"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true",
      ],
    ),
  )
}

///|
test "native API path 1086" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1087" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1088" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1089" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1090" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1091" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1092" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1093" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1094" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1095" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true",
      ],
    ),
  )
}

///|
test "native API path 1096" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1097" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1098" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1099" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1100" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1101" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1102" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1103" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1104" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1105" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true",
      ],
    ),
  )
}

///|
test "native API path 1106" {
  let observed = (
    true,
    @hocon.split_path(
      "true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true.true",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true", "true", "true", "true", "true", "true", "true", "true", "true",
        "true", "true",
      ],
    ),
  )
}

///|
test "native API path 1107" {
  let observed = (true, @hocon.split_path("A0_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0_"]))
}

///|
test "native API path 1108" {
  let observed = (true, @hocon.split_path("A0_.A0_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0_", "A0_"]))
}

///|
test "native API path 1109" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0_", "A0_", "A0_"]))
}

///|
test "native API path 1110" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0_", "A0_", "A0_", "A0_"]))
}

///|
test "native API path 1111" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0_", "A0_", "A0_", "A0_", "A0_"]))
}

///|
test "native API path 1112" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0_", "A0_", "A0_", "A0_", "A0_", "A0_"]))
}

///|
test "native API path 1113" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_"]))
}

///|
test "native API path 1114" {
  let observed = (true, @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_")) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_"]),
  )
}

///|
test "native API path 1115" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (true, ["A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_"]),
  )
}

///|
test "native API path 1116" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      ["A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_"],
    ),
  )
}

///|
test "native API path 1117" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1118" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_",
      ],
    ),
  )
}

///|
test "native API path 1119" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1120" {
  let observed = (
    true,
    @hocon.split_path("A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_"),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1121" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1122" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1123" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1124" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1125" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1126" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1127" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1128" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1129" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_",
      ],
    ),
  )
}

///|
test "native API path 1130" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1131" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1132" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1133" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1134" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1135" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1136" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1137" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1138" {
  let observed = (
    true,
    @hocon.split_path(
      "A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_.A0_",
    ),
  ) catch {
    _ => (false, [])
  }
  assert_eq(
    observed,
    (
      true,
      [
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
        "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_", "A0_",
      ],
    ),
  )
}

///|
test "native API path 1139" {
  let observed = (true, @hocon.split_path(" 1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1140" {
  let observed = (true, @hocon.split_path("1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1141" {
  let observed = (true, @hocon.split_path(" 1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1142" {
  let observed = (true, @hocon.split_path("\n1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1143" {
  let observed = (true, @hocon.split_path("1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1144" {
  let observed = (true, @hocon.split_path("\n1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1145" {
  let observed = (true, @hocon.split_path("\r\n1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1146" {
  let observed = (true, @hocon.split_path("1\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1147" {
  let observed = (true, @hocon.split_path("\r\n1\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1148" {
  let observed = (true, @hocon.split_path("\t1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1149" {
  let observed = (true, @hocon.split_path("1\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1150" {
  let observed = (true, @hocon.split_path("\t1\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1151" {
  let observed = (true, @hocon.split_path(" 1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1152" {
  let observed = (true, @hocon.split_path("1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1153" {
  let observed = (true, @hocon.split_path(" 1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1154" {
  let observed = (true, @hocon.split_path("﻿1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1155" {
  let observed = (true, @hocon.split_path("1﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1156" {
  let observed = (true, @hocon.split_path("﻿1﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1"]))
}

///|
test "native API path 1157" {
  let observed = (true, @hocon.split_path("a.1.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1", "z"]))
}

///|
test "native API path 1158" {
  let observed = (true, @hocon.split_path(" 0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1159" {
  let observed = (true, @hocon.split_path("0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1160" {
  let observed = (true, @hocon.split_path(" 0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1161" {
  let observed = (true, @hocon.split_path("\n0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1162" {
  let observed = (true, @hocon.split_path("0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1163" {
  let observed = (true, @hocon.split_path("\n0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1164" {
  let observed = (true, @hocon.split_path("\r\n0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1165" {
  let observed = (true, @hocon.split_path("0\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1166" {
  let observed = (true, @hocon.split_path("\r\n0\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1167" {
  let observed = (true, @hocon.split_path("\t0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1168" {
  let observed = (true, @hocon.split_path("0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1169" {
  let observed = (true, @hocon.split_path("\t0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1170" {
  let observed = (true, @hocon.split_path(" 0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1171" {
  let observed = (true, @hocon.split_path("0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1172" {
  let observed = (true, @hocon.split_path(" 0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1173" {
  let observed = (true, @hocon.split_path("﻿0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1174" {
  let observed = (true, @hocon.split_path("0﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1175" {
  let observed = (true, @hocon.split_path("﻿0﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0"]))
}

///|
test "native API path 1176" {
  let observed = (true, @hocon.split_path("a.0.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "0", "z"]))
}

///|
test "native API path 1177" {
  let observed = (true, @hocon.split_path(" 01")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1178" {
  let observed = (true, @hocon.split_path("01 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1179" {
  let observed = (true, @hocon.split_path(" 01 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1180" {
  let observed = (true, @hocon.split_path("\n01")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1181" {
  let observed = (true, @hocon.split_path("01\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1182" {
  let observed = (true, @hocon.split_path("\n01\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1183" {
  let observed = (true, @hocon.split_path("\r\n01")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1184" {
  let observed = (true, @hocon.split_path("01\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1185" {
  let observed = (true, @hocon.split_path("\r\n01\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1186" {
  let observed = (true, @hocon.split_path("\t01")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1187" {
  let observed = (true, @hocon.split_path("01\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1188" {
  let observed = (true, @hocon.split_path("\t01\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1189" {
  let observed = (true, @hocon.split_path(" 01")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1190" {
  let observed = (true, @hocon.split_path("01 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1191" {
  let observed = (true, @hocon.split_path(" 01 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1192" {
  let observed = (true, @hocon.split_path("﻿01")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1193" {
  let observed = (true, @hocon.split_path("01﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1194" {
  let observed = (true, @hocon.split_path("﻿01﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1195" {
  let observed = (true, @hocon.split_path("01")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01"]))
}

///|
test "native API path 1196" {
  let observed = (true, @hocon.split_path("a.01.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "01", "z"]))
}

///|
test "native API path 1197" {
  let observed = (true, @hocon.split_path(" -0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1198" {
  let observed = (true, @hocon.split_path("-0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1199" {
  let observed = (true, @hocon.split_path(" -0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1200" {
  let observed = (true, @hocon.split_path("\n-0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1201" {
  let observed = (true, @hocon.split_path("-0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1202" {
  let observed = (true, @hocon.split_path("\n-0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1203" {
  let observed = (true, @hocon.split_path("\r\n-0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1204" {
  let observed = (true, @hocon.split_path("-0\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1205" {
  let observed = (true, @hocon.split_path("\r\n-0\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1206" {
  let observed = (true, @hocon.split_path("\t-0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1207" {
  let observed = (true, @hocon.split_path("-0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1208" {
  let observed = (true, @hocon.split_path("\t-0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1209" {
  let observed = (true, @hocon.split_path(" -0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1210" {
  let observed = (true, @hocon.split_path("-0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1211" {
  let observed = (true, @hocon.split_path(" -0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1212" {
  let observed = (true, @hocon.split_path("﻿-0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1213" {
  let observed = (true, @hocon.split_path("-0﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1214" {
  let observed = (true, @hocon.split_path("﻿-0﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1215" {
  let observed = (true, @hocon.split_path("-0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0"]))
}

///|
test "native API path 1216" {
  let observed = (true, @hocon.split_path("a.-0.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-0", "z"]))
}

///|
test "native API path 1217" {
  let observed = (true, @hocon.split_path(" -0.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1218" {
  let observed = (true, @hocon.split_path("-0.0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1219" {
  let observed = (true, @hocon.split_path(" -0.0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1220" {
  let observed = (true, @hocon.split_path("\n-0.0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1221" {
  let observed = (true, @hocon.split_path("-0.0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1222" {
  let observed = (true, @hocon.split_path("\n-0.0\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1223" {
  let observed = (true, @hocon.split_path("\r\n-0.0")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1224" {
  let observed = (true, @hocon.split_path("-0.0\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1225" {
  let observed = (true, @hocon.split_path("\r\n-0.0\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1226" {
  let observed = (true, @hocon.split_path("\t-0.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1227" {
  let observed = (true, @hocon.split_path("-0.0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1228" {
  let observed = (true, @hocon.split_path("\t-0.0\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1229" {
  let observed = (true, @hocon.split_path(" -0.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1230" {
  let observed = (true, @hocon.split_path("-0.0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1231" {
  let observed = (true, @hocon.split_path(" -0.0 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1232" {
  let observed = (true, @hocon.split_path("﻿-0.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1233" {
  let observed = (true, @hocon.split_path("-0.0﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1234" {
  let observed = (true, @hocon.split_path("﻿-0.0﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1235" {
  let observed = (true, @hocon.split_path("-0.0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-0", "0"]))
}

///|
test "native API path 1236" {
  let observed = (true, @hocon.split_path("a.-0.0.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-0", "0", "z"]))
}

///|
test "native API path 1237" {
  let observed = (true, @hocon.split_path(" +1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1238" {
  let observed = (true, @hocon.split_path("+1 ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1239" {
  let observed = (true, @hocon.split_path(" +1 ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1240" {
  let observed = (true, @hocon.split_path("\n+1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1241" {
  let observed = (true, @hocon.split_path("+1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1242" {
  let observed = (true, @hocon.split_path("\n+1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1243" {
  let observed = (true, @hocon.split_path("\r\n+1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1244" {
  let observed = (true, @hocon.split_path("+1\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1245" {
  let observed = (true, @hocon.split_path("\r\n+1\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1246" {
  let observed = (true, @hocon.split_path("\t+1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1247" {
  let observed = (true, @hocon.split_path("+1\t")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1248" {
  let observed = (true, @hocon.split_path("\t+1\t")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1249" {
  let observed = (true, @hocon.split_path(" +1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1250" {
  let observed = (true, @hocon.split_path("+1 ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1251" {
  let observed = (true, @hocon.split_path(" +1 ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1252" {
  let observed = (true, @hocon.split_path("﻿+1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1253" {
  let observed = (true, @hocon.split_path("+1﻿")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1254" {
  let observed = (true, @hocon.split_path("﻿+1﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1255" {
  let observed = (true, @hocon.split_path("+1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1256" {
  let observed = (true, @hocon.split_path("a.+1.z")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1257" {
  let observed = (true, @hocon.split_path(" 1e2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1258" {
  let observed = (true, @hocon.split_path("1e2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1259" {
  let observed = (true, @hocon.split_path(" 1e2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1260" {
  let observed = (true, @hocon.split_path("\n1e2")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1261" {
  let observed = (true, @hocon.split_path("1e2\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1262" {
  let observed = (true, @hocon.split_path("\n1e2\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1263" {
  let observed = (true, @hocon.split_path("\r\n1e2")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1264" {
  let observed = (true, @hocon.split_path("1e2\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1265" {
  let observed = (true, @hocon.split_path("\r\n1e2\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1266" {
  let observed = (true, @hocon.split_path("\t1e2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1267" {
  let observed = (true, @hocon.split_path("1e2\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1268" {
  let observed = (true, @hocon.split_path("\t1e2\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1269" {
  let observed = (true, @hocon.split_path(" 1e2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1270" {
  let observed = (true, @hocon.split_path("1e2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1271" {
  let observed = (true, @hocon.split_path(" 1e2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1272" {
  let observed = (true, @hocon.split_path("﻿1e2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1273" {
  let observed = (true, @hocon.split_path("1e2﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1274" {
  let observed = (true, @hocon.split_path("﻿1e2﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1275" {
  let observed = (true, @hocon.split_path("1e2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e2"]))
}

///|
test "native API path 1276" {
  let observed = (true, @hocon.split_path("a.1e2.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1e2", "z"]))
}

///|
test "native API path 1277" {
  let observed = (true, @hocon.split_path(" 1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1278" {
  let observed = (true, @hocon.split_path("1E+2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1279" {
  let observed = (true, @hocon.split_path(" 1E+2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1280" {
  let observed = (true, @hocon.split_path("\n1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1281" {
  let observed = (true, @hocon.split_path("1E+2\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1282" {
  let observed = (true, @hocon.split_path("\n1E+2\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1283" {
  let observed = (true, @hocon.split_path("\r\n1E+2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1284" {
  let observed = (true, @hocon.split_path("1E+2\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1285" {
  let observed = (true, @hocon.split_path("\r\n1E+2\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1286" {
  let observed = (true, @hocon.split_path("\t1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1287" {
  let observed = (true, @hocon.split_path("1E+2\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1288" {
  let observed = (true, @hocon.split_path("\t1E+2\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1289" {
  let observed = (true, @hocon.split_path(" 1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1290" {
  let observed = (true, @hocon.split_path("1E+2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1291" {
  let observed = (true, @hocon.split_path(" 1E+2 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1292" {
  let observed = (true, @hocon.split_path("﻿1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1293" {
  let observed = (true, @hocon.split_path("1E+2﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1294" {
  let observed = (true, @hocon.split_path("﻿1E+2﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1295" {
  let observed = (true, @hocon.split_path("1E+2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1E+2"]))
}

///|
test "native API path 1296" {
  let observed = (true, @hocon.split_path("a.1E+2.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1297" {
  let observed = (true, @hocon.split_path(" 1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1298" {
  let observed = (true, @hocon.split_path("1e-2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1299" {
  let observed = (true, @hocon.split_path(" 1e-2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1300" {
  let observed = (true, @hocon.split_path("\n1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1301" {
  let observed = (true, @hocon.split_path("1e-2\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1302" {
  let observed = (true, @hocon.split_path("\n1e-2\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1303" {
  let observed = (true, @hocon.split_path("\r\n1e-2")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1304" {
  let observed = (true, @hocon.split_path("1e-2\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1305" {
  let observed = (true, @hocon.split_path("\r\n1e-2\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1306" {
  let observed = (true, @hocon.split_path("\t1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1307" {
  let observed = (true, @hocon.split_path("1e-2\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1308" {
  let observed = (true, @hocon.split_path("\t1e-2\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1309" {
  let observed = (true, @hocon.split_path(" 1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1310" {
  let observed = (true, @hocon.split_path("1e-2 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1311" {
  let observed = (true, @hocon.split_path(" 1e-2 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1312" {
  let observed = (true, @hocon.split_path("﻿1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1313" {
  let observed = (true, @hocon.split_path("1e-2﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1314" {
  let observed = (true, @hocon.split_path("﻿1e-2﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1315" {
  let observed = (true, @hocon.split_path("1e-2")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e-2"]))
}

///|
test "native API path 1316" {
  let observed = (true, @hocon.split_path("a.1e-2.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1e-2", "z"]))
}

///|
test "native API path 1317" {
  let observed = (true, @hocon.split_path(" 1.20")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1318" {
  let observed = (true, @hocon.split_path("1.20 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1319" {
  let observed = (true, @hocon.split_path(" 1.20 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1320" {
  let observed = (true, @hocon.split_path("\n1.20")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1321" {
  let observed = (true, @hocon.split_path("1.20\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1322" {
  let observed = (true, @hocon.split_path("\n1.20\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1323" {
  let observed = (true, @hocon.split_path("\r\n1.20")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1324" {
  let observed = (true, @hocon.split_path("1.20\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1325" {
  let observed = (true, @hocon.split_path("\r\n1.20\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1326" {
  let observed = (true, @hocon.split_path("\t1.20")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1327" {
  let observed = (true, @hocon.split_path("1.20\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1328" {
  let observed = (true, @hocon.split_path("\t1.20\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1329" {
  let observed = (true, @hocon.split_path(" 1.20")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1330" {
  let observed = (true, @hocon.split_path("1.20 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1331" {
  let observed = (true, @hocon.split_path(" 1.20 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1332" {
  let observed = (true, @hocon.split_path("﻿1.20")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1333" {
  let observed = (true, @hocon.split_path("1.20﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1334" {
  let observed = (true, @hocon.split_path("﻿1.20﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1335" {
  let observed = (true, @hocon.split_path("1.20")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1", "20"]))
}

///|
test "native API path 1336" {
  let observed = (true, @hocon.split_path("a.1.20.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1", "20", "z"]))
}

///|
test "native API path 1337" {
  let observed = (true, @hocon.split_path(" 1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1338" {
  let observed = (true, @hocon.split_path("1. ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1339" {
  let observed = (true, @hocon.split_path(" 1. ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1340" {
  let observed = (true, @hocon.split_path("\n1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1341" {
  let observed = (true, @hocon.split_path("1.\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1342" {
  let observed = (true, @hocon.split_path("\n1.\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1343" {
  let observed = (true, @hocon.split_path("\r\n1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1344" {
  let observed = (true, @hocon.split_path("1.\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1345" {
  let observed = (true, @hocon.split_path("\r\n1.\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1346" {
  let observed = (true, @hocon.split_path("\t1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1347" {
  let observed = (true, @hocon.split_path("1.\t")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1348" {
  let observed = (true, @hocon.split_path("\t1.\t")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1349" {
  let observed = (true, @hocon.split_path(" 1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1350" {
  let observed = (true, @hocon.split_path("1. ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1351" {
  let observed = (true, @hocon.split_path(" 1. ")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1352" {
  let observed = (true, @hocon.split_path("﻿1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1353" {
  let observed = (true, @hocon.split_path("1.﻿")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1354" {
  let observed = (true, @hocon.split_path("﻿1.﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1355" {
  let observed = (true, @hocon.split_path("1.")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1356" {
  let observed = (true, @hocon.split_path("a.1..z")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1357" {
  let observed = (true, @hocon.split_path(" 1e309")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1358" {
  let observed = (true, @hocon.split_path("1e309 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1359" {
  let observed = (true, @hocon.split_path(" 1e309 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1360" {
  let observed = (true, @hocon.split_path("\n1e309")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1361" {
  let observed = (true, @hocon.split_path("1e309\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1362" {
  let observed = (true, @hocon.split_path("\n1e309\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1363" {
  let observed = (true, @hocon.split_path("\r\n1e309")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1364" {
  let observed = (true, @hocon.split_path("1e309\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1365" {
  let observed = (true, @hocon.split_path("\r\n1e309\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1366" {
  let observed = (true, @hocon.split_path("\t1e309")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1367" {
  let observed = (true, @hocon.split_path("1e309\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1368" {
  let observed = (true, @hocon.split_path("\t1e309\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1369" {
  let observed = (true, @hocon.split_path(" 1e309")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1370" {
  let observed = (true, @hocon.split_path("1e309 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1371" {
  let observed = (true, @hocon.split_path(" 1e309 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1372" {
  let observed = (true, @hocon.split_path("﻿1e309")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1373" {
  let observed = (true, @hocon.split_path("1e309﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1374" {
  let observed = (true, @hocon.split_path("﻿1e309﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1375" {
  let observed = (true, @hocon.split_path("1e309")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1e309"]))
}

///|
test "native API path 1376" {
  let observed = (true, @hocon.split_path("a.1e309.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1e309", "z"]))
}

///|
test "native API path 1377" {
  let observed = (true, @hocon.split_path(" 9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1378" {
  let observed = (true, @hocon.split_path("9223372036854775808 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1379" {
  let observed = (true, @hocon.split_path(" 9223372036854775808 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1380" {
  let observed = (true, @hocon.split_path("\n9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1381" {
  let observed = (true, @hocon.split_path("9223372036854775808\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1382" {
  let observed = (true, @hocon.split_path("\n9223372036854775808\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1383" {
  let observed = (true, @hocon.split_path("\r\n9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1384" {
  let observed = (true, @hocon.split_path("9223372036854775808\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1385" {
  let observed = (true, @hocon.split_path("\r\n9223372036854775808\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1386" {
  let observed = (true, @hocon.split_path("\t9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1387" {
  let observed = (true, @hocon.split_path("9223372036854775808\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1388" {
  let observed = (true, @hocon.split_path("\t9223372036854775808\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1389" {
  let observed = (true, @hocon.split_path(" 9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1390" {
  let observed = (true, @hocon.split_path("9223372036854775808 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1391" {
  let observed = (true, @hocon.split_path(" 9223372036854775808 ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1392" {
  let observed = (true, @hocon.split_path("﻿9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1393" {
  let observed = (true, @hocon.split_path("9223372036854775808﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1394" {
  let observed = (true, @hocon.split_path("﻿9223372036854775808﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1395" {
  let observed = (true, @hocon.split_path("9223372036854775808")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9223372036854775808"]))
}

///|
test "native API path 1396" {
  let observed = (true, @hocon.split_path("a.9223372036854775808.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "9223372036854775808", "z"]))
}

///|
test "native API path 1397" {
  let observed = (true, @hocon.split_path(" -x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1398" {
  let observed = (true, @hocon.split_path("-x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1399" {
  let observed = (true, @hocon.split_path(" -x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1400" {
  let observed = (true, @hocon.split_path("\n-x")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1401" {
  let observed = (true, @hocon.split_path("-x\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1402" {
  let observed = (true, @hocon.split_path("\n-x\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1403" {
  let observed = (true, @hocon.split_path("\r\n-x")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1404" {
  let observed = (true, @hocon.split_path("-x\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1405" {
  let observed = (true, @hocon.split_path("\r\n-x\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1406" {
  let observed = (true, @hocon.split_path("\t-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1407" {
  let observed = (true, @hocon.split_path("-x\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1408" {
  let observed = (true, @hocon.split_path("\t-x\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1409" {
  let observed = (true, @hocon.split_path(" -x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1410" {
  let observed = (true, @hocon.split_path("-x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1411" {
  let observed = (true, @hocon.split_path(" -x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1412" {
  let observed = (true, @hocon.split_path("﻿-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1413" {
  let observed = (true, @hocon.split_path("-x﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1414" {
  let observed = (true, @hocon.split_path("﻿-x﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1415" {
  let observed = (true, @hocon.split_path("-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-x"]))
}

///|
test "native API path 1416" {
  let observed = (true, @hocon.split_path("a.-x.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x", "z"]))
}

///|
test "native API path 1417" {
  let observed = (true, @hocon.split_path(" a.-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1418" {
  let observed = (true, @hocon.split_path("a.-x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1419" {
  let observed = (true, @hocon.split_path(" a.-x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1420" {
  let observed = (true, @hocon.split_path("\na.-x")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1421" {
  let observed = (true, @hocon.split_path("a.-x\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1422" {
  let observed = (true, @hocon.split_path("\na.-x\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1423" {
  let observed = (true, @hocon.split_path("\r\na.-x")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1424" {
  let observed = (true, @hocon.split_path("a.-x\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1425" {
  let observed = (true, @hocon.split_path("\r\na.-x\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1426" {
  let observed = (true, @hocon.split_path("\ta.-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1427" {
  let observed = (true, @hocon.split_path("a.-x\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1428" {
  let observed = (true, @hocon.split_path("\ta.-x\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1429" {
  let observed = (true, @hocon.split_path(" a.-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1430" {
  let observed = (true, @hocon.split_path("a.-x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1431" {
  let observed = (true, @hocon.split_path(" a.-x ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1432" {
  let observed = (true, @hocon.split_path("﻿a.-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1433" {
  let observed = (true, @hocon.split_path("a.-x﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1434" {
  let observed = (true, @hocon.split_path("﻿a.-x﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1435" {
  let observed = (true, @hocon.split_path("a.-x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-x"]))
}

///|
test "native API path 1436" {
  let observed = (true, @hocon.split_path("a.a.-x.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "a", "-x", "z"]))
}

///|
test "native API path 1437" {
  let observed = (true, @hocon.split_path(" _x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1438" {
  let observed = (true, @hocon.split_path("_x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1439" {
  let observed = (true, @hocon.split_path(" _x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1440" {
  let observed = (true, @hocon.split_path("\n_x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1441" {
  let observed = (true, @hocon.split_path("_x\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1442" {
  let observed = (true, @hocon.split_path("\n_x\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1443" {
  let observed = (true, @hocon.split_path("\r\n_x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1444" {
  let observed = (true, @hocon.split_path("_x\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1445" {
  let observed = (true, @hocon.split_path("\r\n_x\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1446" {
  let observed = (true, @hocon.split_path("\t_x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1447" {
  let observed = (true, @hocon.split_path("_x\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1448" {
  let observed = (true, @hocon.split_path("\t_x\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1449" {
  let observed = (true, @hocon.split_path(" _x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1450" {
  let observed = (true, @hocon.split_path("_x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1451" {
  let observed = (true, @hocon.split_path(" _x ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1452" {
  let observed = (true, @hocon.split_path("﻿_x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1453" {
  let observed = (true, @hocon.split_path("_x﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1454" {
  let observed = (true, @hocon.split_path("﻿_x﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1455" {
  let observed = (true, @hocon.split_path("_x")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_x"]))
}

///|
test "native API path 1456" {
  let observed = (true, @hocon.split_path("a._x.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "_x", "z"]))
}

///|
test "native API path 1457" {
  let observed = (true, @hocon.split_path(" a-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1458" {
  let observed = (true, @hocon.split_path("a-_b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1459" {
  let observed = (true, @hocon.split_path(" a-_b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1460" {
  let observed = (true, @hocon.split_path("\na-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1461" {
  let observed = (true, @hocon.split_path("a-_b\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1462" {
  let observed = (true, @hocon.split_path("\na-_b\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1463" {
  let observed = (true, @hocon.split_path("\r\na-_b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1464" {
  let observed = (true, @hocon.split_path("a-_b\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1465" {
  let observed = (true, @hocon.split_path("\r\na-_b\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1466" {
  let observed = (true, @hocon.split_path("\ta-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1467" {
  let observed = (true, @hocon.split_path("a-_b\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1468" {
  let observed = (true, @hocon.split_path("\ta-_b\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1469" {
  let observed = (true, @hocon.split_path(" a-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1470" {
  let observed = (true, @hocon.split_path("a-_b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1471" {
  let observed = (true, @hocon.split_path(" a-_b ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1472" {
  let observed = (true, @hocon.split_path("﻿a-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1473" {
  let observed = (true, @hocon.split_path("a-_b﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1474" {
  let observed = (true, @hocon.split_path("﻿a-_b﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1475" {
  let observed = (true, @hocon.split_path("a-_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-_b"]))
}

///|
test "native API path 1476" {
  let observed = (true, @hocon.split_path("a.a-_b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "a-_b", "z"]))
}

///|
test "native API path 1477" {
  let observed = (true, @hocon.split_path(" a-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1478" {
  let observed = (true, @hocon.split_path("a-b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1479" {
  let observed = (true, @hocon.split_path(" a-b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1480" {
  let observed = (true, @hocon.split_path("\na-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1481" {
  let observed = (true, @hocon.split_path("a-b\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1482" {
  let observed = (true, @hocon.split_path("\na-b\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1483" {
  let observed = (true, @hocon.split_path("\r\na-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1484" {
  let observed = (true, @hocon.split_path("a-b\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1485" {
  let observed = (true, @hocon.split_path("\r\na-b\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1486" {
  let observed = (true, @hocon.split_path("\ta-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1487" {
  let observed = (true, @hocon.split_path("a-b\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1488" {
  let observed = (true, @hocon.split_path("\ta-b\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1489" {
  let observed = (true, @hocon.split_path(" a-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1490" {
  let observed = (true, @hocon.split_path("a-b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1491" {
  let observed = (true, @hocon.split_path(" a-b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1492" {
  let observed = (true, @hocon.split_path("﻿a-b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1493" {
  let observed = (true, @hocon.split_path("a-b﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1494" {
  let observed = (true, @hocon.split_path("﻿a-b﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a-b"]))
}

///|
test "native API path 1495" {
  let observed = (true, @hocon.split_path("a.a-b.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "a-b", "z"]))
}

///|
test "native API path 1496" {
  let observed = (true, @hocon.split_path(" a.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1497" {
  let observed = (true, @hocon.split_path("a.b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1498" {
  let observed = (true, @hocon.split_path(" a.b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1499" {
  let observed = (true, @hocon.split_path("\na.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1500" {
  let observed = (true, @hocon.split_path("a.b\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1501" {
  let observed = (true, @hocon.split_path("\na.b\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1502" {
  let observed = (true, @hocon.split_path("\r\na.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1503" {
  let observed = (true, @hocon.split_path("a.b\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1504" {
  let observed = (true, @hocon.split_path("\r\na.b\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1505" {
  let observed = (true, @hocon.split_path("\ta.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1506" {
  let observed = (true, @hocon.split_path("a.b\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1507" {
  let observed = (true, @hocon.split_path("\ta.b\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1508" {
  let observed = (true, @hocon.split_path(" a.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1509" {
  let observed = (true, @hocon.split_path("a.b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1510" {
  let observed = (true, @hocon.split_path(" a.b ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1511" {
  let observed = (true, @hocon.split_path("﻿a.b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1512" {
  let observed = (true, @hocon.split_path("a.b﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1513" {
  let observed = (true, @hocon.split_path("﻿a.b﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "b"]))
}

///|
test "native API path 1514" {
  let observed = (true, @hocon.split_path("a.a.b.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "a", "b", "z"]))
}

///|
test "native API path 1515" {
  let observed = (true, @hocon.split_path(" A0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1516" {
  let observed = (true, @hocon.split_path("A0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1517" {
  let observed = (true, @hocon.split_path(" A0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1518" {
  let observed = (true, @hocon.split_path("\nA0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1519" {
  let observed = (true, @hocon.split_path("A0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1520" {
  let observed = (true, @hocon.split_path("\nA0\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1521" {
  let observed = (true, @hocon.split_path("\r\nA0")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1522" {
  let observed = (true, @hocon.split_path("A0\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1523" {
  let observed = (true, @hocon.split_path("\r\nA0\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1524" {
  let observed = (true, @hocon.split_path("\tA0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1525" {
  let observed = (true, @hocon.split_path("A0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1526" {
  let observed = (true, @hocon.split_path("\tA0\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1527" {
  let observed = (true, @hocon.split_path(" A0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1528" {
  let observed = (true, @hocon.split_path("A0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1529" {
  let observed = (true, @hocon.split_path(" A0 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1530" {
  let observed = (true, @hocon.split_path("﻿A0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1531" {
  let observed = (true, @hocon.split_path("A0﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1532" {
  let observed = (true, @hocon.split_path("﻿A0﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1533" {
  let observed = (true, @hocon.split_path("A0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["A0"]))
}

///|
test "native API path 1534" {
  let observed = (true, @hocon.split_path("a.A0.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "A0", "z"]))
}

///|
test "native API path 1535" {
  let observed = (true, @hocon.split_path(" a.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1536" {
  let observed = (true, @hocon.split_path("a.1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1537" {
  let observed = (true, @hocon.split_path(" a.1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1538" {
  let observed = (true, @hocon.split_path("\na.1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1539" {
  let observed = (true, @hocon.split_path("a.1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1540" {
  let observed = (true, @hocon.split_path("\na.1\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1541" {
  let observed = (true, @hocon.split_path("\r\na.1")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1542" {
  let observed = (true, @hocon.split_path("a.1\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1543" {
  let observed = (true, @hocon.split_path("\r\na.1\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1544" {
  let observed = (true, @hocon.split_path("\ta.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1545" {
  let observed = (true, @hocon.split_path("a.1\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1546" {
  let observed = (true, @hocon.split_path("\ta.1\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1547" {
  let observed = (true, @hocon.split_path(" a.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1548" {
  let observed = (true, @hocon.split_path("a.1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1549" {
  let observed = (true, @hocon.split_path(" a.1 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1550" {
  let observed = (true, @hocon.split_path("﻿a.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1551" {
  let observed = (true, @hocon.split_path("a.1﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1552" {
  let observed = (true, @hocon.split_path("﻿a.1﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1553" {
  let observed = (true, @hocon.split_path("a.1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "1"]))
}

///|
test "native API path 1554" {
  let observed = (true, @hocon.split_path("a.a.1.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "a", "1", "z"]))
}

///|
test "native API path 1555" {
  let observed = (true, @hocon.split_path(" \"a\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1556" {
  let observed = (true, @hocon.split_path("\"a\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1557" {
  let observed = (true, @hocon.split_path(" \"a\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1558" {
  let observed = (true, @hocon.split_path("\n\"a\"")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1559" {
  let observed = (true, @hocon.split_path("\"a\"\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1560" {
  let observed = (true, @hocon.split_path("\n\"a\"\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1561" {
  let observed = (true, @hocon.split_path("\r\n\"a\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1562" {
  let observed = (true, @hocon.split_path("\"a\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1563" {
  let observed = (true, @hocon.split_path("\r\n\"a\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1564" {
  let observed = (true, @hocon.split_path("\t\"a\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1565" {
  let observed = (true, @hocon.split_path("\"a\"\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1566" {
  let observed = (true, @hocon.split_path("\t\"a\"\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1567" {
  let observed = (true, @hocon.split_path(" \"a\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1568" {
  let observed = (true, @hocon.split_path("\"a\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1569" {
  let observed = (true, @hocon.split_path(" \"a\" ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1570" {
  let observed = (true, @hocon.split_path("﻿\"a\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1571" {
  let observed = (true, @hocon.split_path("\"a\"﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1572" {
  let observed = (true, @hocon.split_path("﻿\"a\"﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a"]))
}

///|
test "native API path 1573" {
  let observed = (true, @hocon.split_path("a.\"a\".z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "a", "z"]))
}

///|
test "native API path 1574" {
  let observed = (true, @hocon.split_path(" a\"b\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1575" {
  let observed = (true, @hocon.split_path("a\"b\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1576" {
  let observed = (true, @hocon.split_path(" a\"b\" ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1577" {
  let observed = (true, @hocon.split_path("\na\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1578" {
  let observed = (true, @hocon.split_path("a\"b\"\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1579" {
  let observed = (true, @hocon.split_path("\na\"b\"\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1580" {
  let observed = (true, @hocon.split_path("\r\na\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1581" {
  let observed = (true, @hocon.split_path("a\"b\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1582" {
  let observed = (true, @hocon.split_path("\r\na\"b\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1583" {
  let observed = (true, @hocon.split_path("\ta\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1584" {
  let observed = (true, @hocon.split_path("a\"b\"\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1585" {
  let observed = (true, @hocon.split_path("\ta\"b\"\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1586" {
  let observed = (true, @hocon.split_path(" a\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1587" {
  let observed = (true, @hocon.split_path("a\"b\" ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1588" {
  let observed = (true, @hocon.split_path(" a\"b\" ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1589" {
  let observed = (true, @hocon.split_path("﻿a\"b\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1590" {
  let observed = (true, @hocon.split_path("a\"b\"﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1591" {
  let observed = (true, @hocon.split_path("﻿a\"b\"﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1592" {
  let observed = (true, @hocon.split_path("a\"b\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ab"]))
}

///|
test "native API path 1593" {
  let observed = (true, @hocon.split_path("a.a\"b\".z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ab", "z"]))
}

///|
test "native API path 1594" {
  let observed = (true, @hocon.split_path(" \"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1595" {
  let observed = (true, @hocon.split_path("\"\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1596" {
  let observed = (true, @hocon.split_path(" \"\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1597" {
  let observed = (true, @hocon.split_path("\n\"\"")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1598" {
  let observed = (true, @hocon.split_path("\"\"\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1599" {
  let observed = (true, @hocon.split_path("\n\"\"\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1600" {
  let observed = (true, @hocon.split_path("\r\n\"\"")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1601" {
  let observed = (true, @hocon.split_path("\"\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1602" {
  let observed = (true, @hocon.split_path("\r\n\"\"\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1603" {
  let observed = (true, @hocon.split_path("\t\"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1604" {
  let observed = (true, @hocon.split_path("\"\"\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1605" {
  let observed = (true, @hocon.split_path("\t\"\"\t")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1606" {
  let observed = (true, @hocon.split_path(" \"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1607" {
  let observed = (true, @hocon.split_path("\"\" ")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1608" {
  let observed = (true, @hocon.split_path(" \"\" ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1609" {
  let observed = (true, @hocon.split_path("﻿\"\"")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1610" {
  let observed = (true, @hocon.split_path("\"\"﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1611" {
  let observed = (true, @hocon.split_path("﻿\"\"﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, [""]))
}

///|
test "native API path 1612" {
  let observed = (true, @hocon.split_path("a.\"\".z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "", "z"]))
}

///|
test "native API path 1613" {
  let observed = (true, @hocon.split_path(" α")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1614" {
  let observed = (true, @hocon.split_path("α ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1615" {
  let observed = (true, @hocon.split_path(" α ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1616" {
  let observed = (true, @hocon.split_path("\nα")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1617" {
  let observed = (true, @hocon.split_path("α\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1618" {
  let observed = (true, @hocon.split_path("\nα\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1619" {
  let observed = (true, @hocon.split_path("\r\nα")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1620" {
  let observed = (true, @hocon.split_path("α\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1621" {
  let observed = (true, @hocon.split_path("\r\nα\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1622" {
  let observed = (true, @hocon.split_path("\tα")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1623" {
  let observed = (true, @hocon.split_path("α\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1624" {
  let observed = (true, @hocon.split_path("\tα\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1625" {
  let observed = (true, @hocon.split_path(" α")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1626" {
  let observed = (true, @hocon.split_path("α ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1627" {
  let observed = (true, @hocon.split_path(" α ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1628" {
  let observed = (true, @hocon.split_path("﻿α")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1629" {
  let observed = (true, @hocon.split_path("α﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1630" {
  let observed = (true, @hocon.split_path("﻿α﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["α"]))
}

///|
test "native API path 1631" {
  let observed = (true, @hocon.split_path("a.α.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "α", "z"]))
}

///|
test "native API path 1632" {
  let observed = (true, @hocon.split_path(" 中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1633" {
  let observed = (true, @hocon.split_path("中 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1634" {
  let observed = (true, @hocon.split_path(" 中 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1635" {
  let observed = (true, @hocon.split_path("\n中")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1636" {
  let observed = (true, @hocon.split_path("中\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1637" {
  let observed = (true, @hocon.split_path("\n中\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1638" {
  let observed = (true, @hocon.split_path("\r\n中")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1639" {
  let observed = (true, @hocon.split_path("中\r\n")) catch { _ => (false, []) }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1640" {
  let observed = (true, @hocon.split_path("\r\n中\r\n")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (false, []))
}

///|
test "native API path 1641" {
  let observed = (true, @hocon.split_path("\t中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1642" {
  let observed = (true, @hocon.split_path("中\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1643" {
  let observed = (true, @hocon.split_path("\t中\t")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1644" {
  let observed = (true, @hocon.split_path(" 中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1645" {
  let observed = (true, @hocon.split_path("中 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1646" {
  let observed = (true, @hocon.split_path(" 中 ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1647" {
  let observed = (true, @hocon.split_path("﻿中")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1648" {
  let observed = (true, @hocon.split_path("中﻿")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1649" {
  let observed = (true, @hocon.split_path("﻿中﻿")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["中"]))
}

///|
test "native API path 1650" {
  let observed = (true, @hocon.split_path("a.中.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "中", "z"]))
}

///|
test "native API path 1651" {
  let observed = (true, @hocon.split_path("a._.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "_", "z"]))
}

///|
test "native API path 1652" {
  let observed = (true, @hocon.split_path("bX")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bX"]))
}

///|
test "native API path 1653" {
  let observed = (true, @hocon.split_path("-ed")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-ed"]))
}

///|
test "native API path 1654" {
  let observed = (true, @hocon.split_path("a._YcY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_YcY", "z"]))
}

///|
test "native API path 1655" {
  let observed = (true, @hocon.split_path("e0X9_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["e0X9_"]))
}

///|
test "native API path 1656" {
  let observed = (true, @hocon.split_path("dZY1d1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["dZY1d1"]))
}

///|
test "native API path 1657" {
  let observed = (true, @hocon.split_path("a.fZbe-ed.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "fZbe-ed", "z"]))
}

///|
test "native API path 1658" {
  let observed = (true, @hocon.split_path("aYZ01-Z0")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["aYZ01-Z0"]))
}

///|
test "native API path 1659" {
  let observed = (true, @hocon.split_path("Xbab19ZdZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Xbab19ZdZ"]))
}

///|
test "native API path 1660" {
  let observed = (true, @hocon.split_path("a.-cfefZbebc.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-cfefZbebc", "z"]))
}

///|
test "native API path 1661" {
  let observed = (true, @hocon.split_path("dc-ef_0a-1f")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["dc-ef_0a-1f"]))
}

///|
test "native API path 1662" {
  let observed = (true, @hocon.split_path("1Ye-_Y_bZdcY")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1Ye-_Y_bZdcY"]))
}

///|
test "native API path 1663" {
  let observed = (true, @hocon.split_path("a.cYX-a-eY_bZYZ.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "cYX-a-eY_bZYZ", "z"]))
}

///|
test "native API path 1664" {
  let observed = (true, @hocon.split_path("-e9_-X9a-1fafa")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-e9_-X9a-1fafa"]))
}

///|
test "native API path 1665" {
  let observed = (true, @hocon.split_path("0_fe-19Zf_fZY_b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["0_fe-19Zf_fZY_b"]))
}

///|
test "native API path 1666" {
  let observed = (true, @hocon.split_path("a.ZYXfX-Z9ZdadXbe-.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ZYXfX-Z9ZdadXbe-", "z"]))
}

///|
test "native API path 1667" {
  let observed = (true, @hocon.split_path("a9abe0e-e9cYXb_0c")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a9abe0e-e9cYXb_0c"]))
}

///|
test "native API path 1668" {
  let observed = (true, @hocon.split_path("b1YZde0c-_YafXf101")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["b1YZde0c-_YafXf101"]))
}

///|
test "native API path 1669" {
  let observed = (true, @hocon.split_path("a.bZfa0_Yc0a0_-Xd1-10.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "bZfa0_Yc0a0_-Xd1-10", "z"]))
}

///|
test "native API path 1670" {
  let observed = (true, @hocon.split_path("e-e0_YX0c9X-Xd19XdX-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["e-e0_YX0c9X-Xd19XdX-"]))
}

///|
test "native API path 1671" {
  let observed = (true, @hocon.split_path("cfXfXb1-Xdc0ZfXdcbX91")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["cfXfXb1-Xdc0ZfXdcbX91"]))
}

///|
test "native API path 1672" {
  let observed = (true, @hocon.split_path("a.dXfe010ZdXYc9_d191fcd_.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "dXfe010ZdXYc9_d191fcd_", "z"]))
}

///|
test "native API path 1673" {
  let observed = (true, @hocon.split_path("d1YZd1fcd1YXb_-c0_defc9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["d1YZd1fcd1YXb_-c0_defc9"]))
}

///|
test "native API path 1674" {
  let observed = (true, @hocon.split_path("a.0_.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "0_", "z"]))
}

///|
test "native API path 1675" {
  let observed = (true, @hocon.split_path("bZ-")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bZ-"]))
}

///|
test "native API path 1676" {
  let observed = (true, @hocon.split_path("c0aY")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["c0aY"]))
}

///|
test "native API path 1677" {
  let observed = (true, @hocon.split_path("a._f_-c.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_f_-c", "z"]))
}

///|
test "native API path 1678" {
  let observed = (true, @hocon.split_path("0cYe9Z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0cYe9Z"]))
}

///|
test "native API path 1679" {
  let observed = (true, @hocon.split_path("-c0Zdcf")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-c0Zdcf"]))
}

///|
test "native API path 1680" {
  let observed = (true, @hocon.split_path("a.eb_d_f_-.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "eb_d_f_-", "z"]))
}

///|
test "native API path 1681" {
  let observed = (true, @hocon.split_path("ef_YZbaYX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ef_YZbaYX"]))
}

///|
test "native API path 1682" {
  let observed = (true, @hocon.split_path("b19X0_Ye0c")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["b19X0_Ye0c"]))
}

///|
test "native API path 1683" {
  let observed = (true, @hocon.split_path("a.fc-Xb1ba9_b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "fc-Xb1ba9_b", "z"]))
}

///|
test "native API path 1684" {
  let observed = (true, @hocon.split_path("1dcYZYebafZ9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1dcYZYebafZ9"]))
}

///|
test "native API path 1685" {
  let observed = (true, @hocon.split_path("1ba-cbZYebc-X")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1ba-cbZYebc-X"]))
}

///|
test "native API path 1686" {
  let observed = (true, @hocon.split_path("a.Y_bZfcY1Ya-abc.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Y_bZfcY1Ya-abc", "z"]))
}

///|
test "native API path 1687" {
  let observed = (true, @hocon.split_path("beYc-cYcb19Zf_d")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["beYc-cYcb19Zf_d"]))
}

///|
test "native API path 1688" {
  let observed = (true, @hocon.split_path("aYa-cda0afZ-Zb_f")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["aYa-cda0afZ-Zb_f"]))
}

///|
test "native API path 1689" {
  let observed = (true, @hocon.split_path("a.c-Z-Z9eYad_bXba9_.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "c-Z-Z9eYad_bXba9_", "z"]))
}

///|
test "native API path 1690" {
  let observed = (true, @hocon.split_path("bXfab1bcf_0cYeY_YZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["bXfab1bcf_0cYeY_YZ"]))
}

///|
test "native API path 1691" {
  let observed = (true, @hocon.split_path("fcbcf_9af1-1dc-afaf")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["fcbcf_9af1-1dc-afaf"]))
}

///|
test "native API path 1692" {
  let observed = (true, @hocon.split_path("a._fcd_0_YZfZdX9_-c-_-.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_fcd_0_YZfZdX9_-c-_-", "z"]))
}

///|
test "native API path 1693" {
  let observed = (true, @hocon.split_path("Z-adc-e9Zdabc-Z-ZbcdZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z-adc-e9Zdabc-Z-ZbcdZ"]))
}

///|
test "native API path 1694" {
  let observed = (true, @hocon.split_path("9_f1YeYe0_be-X91dZ-afe")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9_f1YeYe0_be-X91dZ-afe"]))
}

///|
test "native API path 1695" {
  let observed = (true, @hocon.split_path("a.f1f1d_feb1YZf_fZfaba01Y.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "f1f1d_feb1YZf_fZfaba01Y", "z"]))
}

///|
test "native API path 1696" {
  let observed = (true, @hocon.split_path("9Z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9Z"]))
}

///|
test "native API path 1697" {
  let observed = (true, @hocon.split_path("a.Y_b.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "Y_b", "z"]))
}

///|
test "native API path 1698" {
  let observed = (true, @hocon.split_path("a-ZY")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a-ZY"]))
}

///|
test "native API path 1699" {
  let observed = (true, @hocon.split_path("1fXbe")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1fXbe"]))
}

///|
test "native API path 1700" {
  let observed = (true, @hocon.split_path("a.0X0cb_.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0X0cb_", "z"]))
}

///|
test "native API path 1701" {
  let observed = (true, @hocon.split_path("bZ-cde0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bZ-cde0"]))
}

///|
test "native API path 1702" {
  let observed = (true, @hocon.split_path("19XfeYcb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["19XfeYcb"]))
}

///|
test "native API path 1703" {
  let observed = (true, @hocon.split_path("a.aYefZb1fZ.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "aYefZb1fZ", "z"]))
}

///|
test "native API path 1704" {
  let observed = (true, @hocon.split_path("YZ0aYeYZ0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["YZ0aYeYZ0_"]))
}

///|
test "native API path 1705" {
  let observed = (true, @hocon.split_path("0_YZb1dZY1d")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["0_YZb1dZY1d"]))
}

///|
test "native API path 1706" {
  let observed = (true, @hocon.split_path("a.adX-1019c9Zd.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "adX-1019c9Zd", "z"]))
}

///|
test "native API path 1707" {
  let observed = (true, @hocon.split_path("10Z91Yc-e-ab1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["10Z91Yc-e-ab1"]))
}

///|
test "native API path 1708" {
  let observed = (true, @hocon.split_path("YcfZdcb_de-e9e")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["YcfZdcb_de-e9e"]))
}

///|
test "native API path 1709" {
  let observed = (true, @hocon.split_path("a.9_bZYX-XYZdXfaY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "9_bZYX-XYZdXfaY", "z"]))
}

///|
test "native API path 1710" {
  let observed = (true, @hocon.split_path("c9Xbe-Xdcda9Zd1f")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c9Xbe-Xdcda9Zd1f"]))
}

///|
test "native API path 1711" {
  let observed = (true, @hocon.split_path("X0cb1fZb_01f1bcfa")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X0cb1fZb_01f1bcfa"]))
}

///|
test "native API path 1712" {
  let observed = (true, @hocon.split_path("a.0_fc91Y_YZ0cbc0cdc.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0_fc91Y_YZ0cbc0cdc", "z"]))
}

///|
test "native API path 1713" {
  let observed = (true, @hocon.split_path("01YZ0Zbe9c-abab_YXd")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["01YZ0Zbe9c-abab_YXd"]))
}

///|
test "native API path 1714" {
  let observed = (true, @hocon.split_path("19_0_de9cbc-_9edeb1Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["19_0_de9cbc-_9edeb1Y"]))
}

///|
test "native API path 1715" {
  let observed = (true, @hocon.split_path("a.a0efa-ZY_d1f_f1fa-1-X.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "a0efa-ZY_d1f_f1fa-1-X", "z"]))
}

///|
test "native API path 1716" {
  let observed = (true, @hocon.split_path("Y_dcfc9191fe-ebabedX0Z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Y_dcfc9191fe-ebabedX0Z"]))
}

///|
test "native API path 1717" {
  let observed = (true, @hocon.split_path("dZb_fa01-X-1dZfZdXY_Y_Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["dZb_fa01-X-1dZfZdXY_Y_Y"]))
}

///|
test "native API path 1718" {
  let observed = (true, @hocon.split_path("a.a.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "a", "z"]))
}

///|
test "native API path 1719" {
  let observed = (true, @hocon.split_path("fc")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["fc"]))
}

///|
test "native API path 1720" {
  let observed = (true, @hocon.split_path("fXY")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["fXY"]))
}

///|
test "native API path 1721" {
  let observed = (true, @hocon.split_path("a.X-e-.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "X-e-", "z"]))
}

///|
test "native API path 1722" {
  let observed = (true, @hocon.split_path("_dafa")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_dafa"]))
}

///|
test "native API path 1723" {
  let observed = (true, @hocon.split_path("dZ-19e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["dZ-19e"]))
}

///|
test "native API path 1724" {
  let observed = (true, @hocon.split_path("a.Y_YeY1d.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Y_YeY1d", "z"]))
}

///|
test "native API path 1725" {
  let observed = (true, @hocon.split_path("a9c0Xd_Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a9c0Xd_Y"]))
}

///|
test "native API path 1726" {
  let observed = (true, @hocon.split_path("_f1f19a9a")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_f1f19a9a"]))
}

///|
test "native API path 1727" {
  let observed = (true, @hocon.split_path("a.YX-Z0ebXYe.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "YX-Z0ebXYe", "z"]))
}

///|
test "native API path 1728" {
  let observed = (true, @hocon.split_path("YX-1dZ0ebX9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["YX-1dZ0ebX9"]))
}

///|
test "native API path 1729" {
  let observed = (true, @hocon.split_path("Zd10_b1dcfe-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Zd10_b1dcfe-"]))
}

///|
test "native API path 1730" {
  let observed = (true, @hocon.split_path("a.c0a-_f_dX91bc.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "c0a-_f_dX91bc", "z"]))
}

///|
test "native API path 1731" {
  let observed = (true, @hocon.split_path("9Z9cYe9_d1YX91")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9Z9cYe9_d1YX91"]))
}

///|
test "native API path 1732" {
  let observed = (true, @hocon.split_path("-cd_f_feYedeY1Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-cd_f_feYedeY1Y"]))
}

///|
test "native API path 1733" {
  let observed = (true, @hocon.split_path("a.a-1bXfX0_9aba-1f.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "a-1bXfX0_9aba-1f", "z"]))
}

///|
test "native API path 1734" {
  let observed = (true, @hocon.split_path("Z0X9ab_9a9ZY1-cbX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z0X9ab_9a9ZY1-cbX"]))
}

///|
test "native API path 1735" {
  let observed = (true, @hocon.split_path("Y1d1-10efXfc-e010Z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Y1d1-10efXfc-e010Z"]))
}

///|
test "native API path 1736" {
  let observed = (true, @hocon.split_path("a.-X-c-a-a0X91Ye0a0eY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-X-c-a-a0X91Ye0a0eY", "z"]))
}

///|
test "native API path 1737" {
  let observed = (true, @hocon.split_path("c-X9a010cYZbe-c01-X0")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c-X9a010cYZbe-c01-X0"]))
}

///|
test "native API path 1738" {
  let observed = (true, @hocon.split_path("cbcYc-Z0X91bab1fafaYZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["cbcYc-Z0X91bab1fafaYZ"]))
}

///|
test "native API path 1739" {
  let observed = (true, @hocon.split_path("a.dcd10X01de0_YeY_f_9X-X.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "dcd10X01de0_YeY_f_9X-X", "z"]))
}

///|
test "native API path 1740" {
  let observed = (true, @hocon.split_path("d1-_Y1-cYZbcbe-19X-c9c-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["d1-_Y1-cYZbcbe-19X-c9c-"]))
}

///|
test "native API path 1741" {
  let observed = (true, @hocon.split_path("a.bZ.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "bZ", "z"]))
}

///|
test "native API path 1742" {
  let observed = (true, @hocon.split_path("fZf")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["fZf"]))
}

///|
test "native API path 1743" {
  let observed = (true, @hocon.split_path("e91f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["e91f"]))
}

///|
test "native API path 1744" {
  let observed = (true, @hocon.split_path("a.ZYa0X.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ZYa0X", "z"]))
}

///|
test "native API path 1745" {
  let observed = (true, @hocon.split_path("9c0XbZ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9c0XbZ"]))
}

///|
test "native API path 1746" {
  let observed = (true, @hocon.split_path("fc9a0a0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["fc9a0a0"]))
}

///|
test "native API path 1747" {
  let observed = (true, @hocon.split_path("a.Z0c-_9Xf.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Z0c-_9Xf", "z"]))
}

///|
test "native API path 1748" {
  let observed = (true, @hocon.split_path("1-aY_dc0c")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1-aY_dc0c"]))
}

///|
test "native API path 1749" {
  let observed = (true, @hocon.split_path("-ed_0Z-1fZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-ed_0Z-1fZ"]))
}

///|
test "native API path 1750" {
  let observed = (true, @hocon.split_path("a.b_dXd19X9_b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "b_dXd19X9_b", "z"]))
}

///|
test "native API path 1751" {
  let observed = (true, @hocon.split_path("cfa9X0Z919a-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["cfa9X0Z919a-"]))
}

///|
test "native API path 1752" {
  let observed = (true, @hocon.split_path("ad_0afZ9c0Xde")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ad_0afZ9c0Xde"]))
}

///|
test "native API path 1753" {
  let observed = (true, @hocon.split_path("a.dc9Zf_-ZY_bafc.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "dc9Zf_-ZY_bafc", "z"]))
}

///|
test "native API path 1754" {
  let observed = (true, @hocon.split_path("-_d_YefX0XY10X-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-_d_YefX0XY10X-"]))
}

///|
test "native API path 1755" {
  let observed = (true, @hocon.split_path("X-_feYabafcY_YZ9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X-_feYabafcY_YZ9"]))
}

///|
test "native API path 1756" {
  let observed = (true, @hocon.split_path("a._fZb1-cY_deba-_9a.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_fZb1-cY_deba-_9a", "z"]))
}

///|
test "native API path 1757" {
  let observed = (true, @hocon.split_path("b1-adZ0ad1-1Y1-X9X")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["b1-adZ0ad1-1Y1-X9X"]))
}

///|
test "native API path 1758" {
  let observed = (true, @hocon.split_path("bXfXb_9Zbed_9abafZf")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["bXfXb_9Zbed_9abafZf"]))
}

///|
test "native API path 1759" {
  let observed = (true, @hocon.split_path("a.Zdcdc-ebcd_d_b1bZ0eY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Zdcdc-ebcd_d_b1bZ0eY", "z"]))
}

///|
test "native API path 1760" {
  let observed = (true, @hocon.split_path("c-_dX0c-_fZ-ebc9_9_9e")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c-_dX0c-_fZ-ebc9_9_9e"]))
}

///|
test "native API path 1761" {
  let observed = (true, @hocon.split_path("Y1bX-adX9_dX-XdX-aYcf_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Y1bX-adX9_dX-XdX-aYcf_"]))
}

///|
test "native API path 1762" {
  let observed = (true, @hocon.split_path("a.feYcb_baba9XYe9ZfZ-Z-Zb.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "feYcb_baba9XYe9ZfZ-Z-Zb", "z"]))
}

///|
test "native API path 1763" {
  let observed = (true, @hocon.split_path("YX")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["YX"]))
}

///|
test "native API path 1764" {
  let observed = (true, @hocon.split_path("a.-e-.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-e-", "z"]))
}

///|
test "native API path 1765" {
  let observed = (true, @hocon.split_path("1de0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["1de0"]))
}

///|
test "native API path 1766" {
  let observed = (true, @hocon.split_path("XfefZ")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["XfefZ"]))
}

///|
test "native API path 1767" {
  let observed = (true, @hocon.split_path("a.9_0ada.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "9_0ada", "z"]))
}

///|
test "native API path 1768" {
  let observed = (true, @hocon.split_path("9ef_01f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9ef_01f"]))
}

///|
test "native API path 1769" {
  let observed = (true, @hocon.split_path("a0e0Xb_b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a0e0Xb_b"]))
}

///|
test "native API path 1770" {
  let observed = (true, @hocon.split_path("a.c-Xb191-c.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "c-Xb191-c", "z"]))
}

///|
test "native API path 1771" {
  let observed = (true, @hocon.split_path("01dada0ada")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["01dada0ada"]))
}

///|
test "native API path 1772" {
  let observed = (true, @hocon.split_path("91f10_d_01d")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["91f10_d_01d"]))
}

///|
test "native API path 1773" {
  let observed = (true, @hocon.split_path("a.X-X9edc9Z-af.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "X-X9edc9Z-af", "z"]))
}

///|
test "native API path 1774" {
  let observed = (true, @hocon.split_path("1Y_9ZYc01dZd1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1Y_9ZYc01dZd1"]))
}

///|
test "native API path 1775" {
  let observed = (true, @hocon.split_path("fcb1d1Y_Ya0ad_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["fcb1d1Y_Ya0ad_"]))
}

///|
test "native API path 1776" {
  let observed = (true, @hocon.split_path("a.9_Y_de0_Ye-_fZd.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "9_Y_de0_Ye-_fZd", "z"]))
}

///|
test "native API path 1777" {
  let observed = (true, @hocon.split_path("_dXdadXfX-adcf1f")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_dXdadXfX-adcf1f"]))
}

///|
test "native API path 1778" {
  let observed = (true, @hocon.split_path("c-Zf_-a9_dZ9a9Z-e")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c-Zf_-a9_dZ9a9Z-e"]))
}

///|
test "native API path 1779" {
  let observed = (true, @hocon.split_path("a.fe9af_f_b1f_d_fXbX.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "fe9af_f_b1f_d_fXbX", "z"]))
}

///|
test "native API path 1780" {
  let observed = (true, @hocon.split_path("Yafc9c9cY19abZ0Xbed")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Yafc9c9cY19abZ0Xbed"]))
}

///|
test "native API path 1781" {
  let observed = (true, @hocon.split_path("Z-adc-ZYcY19_YZ0XYX9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z-adc-ZYcY19_YZ0XYX9"]))
}

///|
test "native API path 1782" {
  let observed = (true, @hocon.split_path("a.1-e9cd1bZb_0X010afa9_.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1-e9cd1bZb_0X010afa9_", "z"]))
}

///|
test "native API path 1783" {
  let observed = (true, @hocon.split_path("-abZfXYXbc0_fedeb101YX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-abZfXYXbc0_fedeb101YX"]))
}

///|
test "native API path 1784" {
  let observed = (true, @hocon.split_path("-X9a-ZfXfabZdcY_YZ-_-cd")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-X9a-ZfXfabZdcY_YZ-_-cd"]))
}

///|
test "native API path 1785" {
  let observed = (true, @hocon.split_path("a.Z.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "Z", "z"]))
}

///|
test "native API path 1786" {
  let observed = (true, @hocon.split_path("f_")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["f_"]))
}

///|
test "native API path 1787" {
  let observed = (true, @hocon.split_path("0_f")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0_f"]))
}

///|
test "native API path 1788" {
  let observed = (true, @hocon.split_path("a.1Y1b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1Y1b", "z"]))
}

///|
test "native API path 1789" {
  let observed = (true, @hocon.split_path("X01fX")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["X01fX"]))
}

///|
test "native API path 1790" {
  let observed = (true, @hocon.split_path("-afZ9c")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-afZ9c"]))
}

///|
test "native API path 1791" {
  let observed = (true, @hocon.split_path("a.0cYZfcY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0cYZfcY", "z"]))
}

///|
test "native API path 1792" {
  let observed = (true, @hocon.split_path("Zbe01b1b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Zbe01b1b"]))
}

///|
test "native API path 1793" {
  let observed = (true, @hocon.split_path("X9X0_bX91")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X9X0_bX91"]))
}

///|
test "native API path 1794" {
  let observed = (true, @hocon.split_path("a.9cdX-eY_Y1.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "9cdX-eY_Y1", "z"]))
}

///|
test "native API path 1795" {
  let observed = (true, @hocon.split_path("ba0ZfZfX0X9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ba0ZfZfX0X9"]))
}

///|
test "native API path 1796" {
  let observed = (true, @hocon.split_path("1be0aY1Yaf_9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1be0aY1Yaf_9"]))
}

///|
test "native API path 1797" {
  let observed = (true, @hocon.split_path("a.X-e-1Ye0Z0_Ye.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "X-e-1Ye0Z0_Ye", "z"]))
}

///|
test "native API path 1798" {
  let observed = (true, @hocon.split_path("01Y_f1-1-1dX9_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["01Y_f1-1-1dX9_"]))
}

///|
test "native API path 1799" {
  let observed = (true, @hocon.split_path("-Z0ef1fX9Xfa91Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-Z0ef1fX9Xfa91Y"]))
}

///|
test "native API path 1800" {
  let observed = (true, @hocon.split_path("a.cYZ0Zf_0abe-c9ad.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "cYZ0Zf_0abe-c9ad", "z"]))
}

///|
test "native API path 1801" {
  let observed = (true, @hocon.split_path("Z-1YX0ZY_baf_9X0a")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z-1YX0ZY_baf_9X0a"]))
}

///|
test "native API path 1802" {
  let observed = (true, @hocon.split_path("dafabZYcf1-c01Ye0_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["dafabZYcf1-c01Ye0_"]))
}

///|
test "native API path 1803" {
  let observed = (true, @hocon.split_path("a.0X-a-ZbeYe9e-Xf_-_9.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0X-a-ZbeYe9e-Xf_-_9", "z"]))
}

///|
test "native API path 1804" {
  let observed = (true, @hocon.split_path("c9a-_-c9e0a9efebX91-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c9a-_-c9e0a9efebX91-"]))
}

///|
test "native API path 1805" {
  let observed = (true, @hocon.split_path("adcYa0X0X-_0afZ91Ya9Z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["adcYa0X0X-_0afZ91Ya9Z"]))
}

///|
test "native API path 1806" {
  let observed = (true, @hocon.split_path("a.dZ0XbX-a-a0e9XbXd_d1-Z.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "dZ0XbX-a-a0e9XbXd_d1-Z", "z"]))
}

///|
test "native API path 1807" {
  let observed = (true, @hocon.split_path("9X-Xd_fa-Zb_9ebc91baY_b")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9X-Xd_fa-Zb_9ebc91baY_b"]))
}

///|
test "native API path 1808" {
  let observed = (true, @hocon.split_path("a.-X.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "-X", "z"]))
}

///|
test "native API path 1809" {
  let observed = (true, @hocon.split_path("bXb")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bXb"]))
}

///|
test "native API path 1810" {
  let observed = (true, @hocon.split_path("Z9a0")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Z9a0"]))
}

///|
test "native API path 1811" {
  let observed = (true, @hocon.split_path("a.1f1-e.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1f1-e", "z"]))
}

///|
test "native API path 1812" {
  let observed = (true, @hocon.split_path("9e9Zbc")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["9e9Zbc"]))
}

///|
test "native API path 1813" {
  let observed = (true, @hocon.split_path("01-cYef")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["01-cYef"]))
}

///|
test "native API path 1814" {
  let observed = (true, @hocon.split_path("a.ebad1-X0.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ebad1-X0", "z"]))
}

///|
test "native API path 1815" {
  let observed = (true, @hocon.split_path("a9ZY_badc")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a9ZY_badc"]))
}

///|
test "native API path 1816" {
  let observed = (true, @hocon.split_path("9Z0_bc010a")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9Z0_bc010a"]))
}

///|
test "native API path 1817" {
  let observed = (true, @hocon.split_path("a.b1d_0_91f_f.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "b1d_0_91f_f", "z"]))
}

///|
test "native API path 1818" {
  let observed = (true, @hocon.split_path("X-ZYc9ZbX-Zb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X-ZYc9ZbX-Zb"]))
}

///|
test "native API path 1819" {
  let observed = (true, @hocon.split_path("_-Xd_de-1fcYa")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_-Xd_de-1fcYa"]))
}

///|
test "native API path 1820" {
  let observed = (true, @hocon.split_path("a.f10af_bXdc0Z-c.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "f10af_bXdc0Z-c", "z"]))
}

///|
test "native API path 1821" {
  let observed = (true, @hocon.split_path("da0Z0a0Z-aYZYZf")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["da0Z0a0Z-aYZYZf"]))
}

///|
test "native API path 1822" {
  let observed = (true, @hocon.split_path("edcfa0Zdc9a9aYeb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["edcfa0Zdc9a9aYeb"]))
}

///|
test "native API path 1823" {
  let observed = (true, @hocon.split_path("a.cYcfcf_babXbcfX01.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "cYcfcf_babXbcfX01", "z"]))
}

///|
test "native API path 1824" {
  let observed = (true, @hocon.split_path("-eYX-1dZ0ZYe0e0e9a")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-eYX-1dZ0ZYe0e0e9a"]))
}

///|
test "native API path 1825" {
  let observed = (true, @hocon.split_path("9cda0Z0e-cd1Yab1da-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9cda0Z0e-cd1Yab1da-"]))
}

///|
test "native API path 1826" {
  let observed = (true, @hocon.split_path("a.e-c-1Yc9cbX9cdc-e9Zb.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "e-c-1Yc9cbX9cdc-e9Zb", "z"]))
}

///|
test "native API path 1827" {
  let observed = (true, @hocon.split_path("Z-Z0efZY1bc0Z9eYZdc9X")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z-Z0efZY1bc0Z9eYZdc9X"]))
}

///|
test "native API path 1828" {
  let observed = (true, @hocon.split_path("-_da-_0a0cb1-1d1beb101")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-_da-_0a0cb1-1d1beb101"]))
}

///|
test "native API path 1829" {
  let observed = (true, @hocon.split_path("a.0X91fab_Y19X-efcY10Zb_0.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0X91fab_Y19X-efcY10Zb_0", "z"]))
}

///|
test "native API path 1830" {
  let observed = (true, @hocon.split_path("dc")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["dc"]))
}

///|
test "native API path 1831" {
  let observed = (true, @hocon.split_path("a.dZ0.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "dZ0", "z"]))
}

///|
test "native API path 1832" {
  let observed = (true, @hocon.split_path("ZbZ9")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["ZbZ9"]))
}

///|
test "native API path 1833" {
  let observed = (true, @hocon.split_path("_9X-1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_9X-1"]))
}

///|
test "native API path 1834" {
  let observed = (true, @hocon.split_path("a.baY1Ya.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "baY1Ya", "z"]))
}

///|
test "native API path 1835" {
  let observed = (true, @hocon.split_path("-eb_d1b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-eb_d1b"]))
}

///|
test "native API path 1836" {
  let observed = (true, @hocon.split_path("_ba-abc9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_ba-abc9"]))
}

///|
test "native API path 1837" {
  let observed = (true, @hocon.split_path("a._fZde91da.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_fZde91da", "z"]))
}

///|
test "native API path 1838" {
  let observed = (true, @hocon.split_path("-edZYab10e")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-edZYab10e"]))
}

///|
test "native API path 1839" {
  let observed = (true, @hocon.split_path("91feYedXbc-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["91feYedXbc-"]))
}

///|
test "native API path 1840" {
  let observed = (true, @hocon.split_path("a.ef_fabZ0X-_b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ef_fabZ0X-_b", "z"]))
}

///|
test "native API path 1841" {
  let observed = (true, @hocon.split_path("Xb10eYXYc-a9X")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Xb10eYXYc-a9X"]))
}

///|
test "native API path 1842" {
  let observed = (true, @hocon.split_path("9_9a9_bcfeYcbX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9_9a9_bcfeYcbX"]))
}

///|
test "native API path 1843" {
  let observed = (true, @hocon.split_path("a.d_9Xf_YZb_9cYZY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "d_9Xf_YZb_9cYZY", "z"]))
}

///|
test "native API path 1844" {
  let observed = (true, @hocon.split_path("c010X-e-cbabcdX9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c010X-e-cbabcdX9"]))
}

///|
test "native API path 1845" {
  let observed = (true, @hocon.split_path("afXf1-_f1bXfa9eYe")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["afXf1-_f1bXfa9eYe"]))
}

///|
test "native API path 1846" {
  let observed = (true, @hocon.split_path("a.-e9Z-ebe0X0X0a-19X.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-e9Z-ebe0X0X0a-19X", "z"]))
}

///|
test "native API path 1847" {
  let observed = (true, @hocon.split_path("-Zfab101010e9edaYXd")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-Zfab101010e9edaYXd"]))
}

///|
test "native API path 1848" {
  let observed = (true, @hocon.split_path("X9a0cY1-c0_beYcYXfad")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X9a0cY1-c0_beYcYXfad"]))
}

///|
test "native API path 1849" {
  let observed = (true, @hocon.split_path("a.XYa-_-1fX-ZbZYX-aYadZ.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "XYa-_-1fX-ZbZYX-aYadZ", "z"]))
}

///|
test "native API path 1850" {
  let observed = (true, @hocon.split_path("YaYe9ed_0_-e0_d1fZbXdX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["YaYe9ed_0_-e0_d1fZbXdX"]))
}

///|
test "native API path 1851" {
  let observed = (true, @hocon.split_path("-a-XbXY_0X-Z9Z9c-ed_fX9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-a-XbXY_0X-Z9Z9c-ed_fX9"]))
}

///|
test "native API path 1852" {
  let observed = (true, @hocon.split_path("-X")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-X"]))
}

///|
test "native API path 1853" {
  let observed = (true, @hocon.split_path("0cf")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["0cf"]))
}

///|
test "native API path 1854" {
  let observed = (true, @hocon.split_path("a._Y_b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "_Y_b", "z"]))
}

///|
test "native API path 1855" {
  let observed = (true, @hocon.split_path("_YZYX")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["_YZYX"]))
}

///|
test "native API path 1856" {
  let observed = (true, @hocon.split_path("bc-Zbc")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bc-Zbc"]))
}

///|
test "native API path 1857" {
  let observed = (true, @hocon.split_path("a.0c0XfX-.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0c0XfX-", "z"]))
}

///|
test "native API path 1858" {
  let observed = (true, @hocon.split_path("1dZf19eb")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["1dZf19eb"]))
}

///|
test "native API path 1859" {
  let observed = (true, @hocon.split_path("a9X0_dZYX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a9X0_dZYX"]))
}

///|
test "native API path 1860" {
  let observed = (true, @hocon.split_path("a.-e9a-Xdef_.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-e9a-Xdef_", "z"]))
}

///|
test "native API path 1861" {
  let observed = (true, @hocon.split_path("Ye9X9XY_9e9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Ye9X9XY_9e9"]))
}

///|
test "native API path 1862" {
  let observed = (true, @hocon.split_path("ZfXdZd_f1d1-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ZfXdZd_f1d1-"]))
}

///|
test "native API path 1863" {
  let observed = (true, @hocon.split_path("a.c0ebebX919adX.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "c0ebebX919adX", "z"]))
}

///|
test "native API path 1864" {
  let observed = (true, @hocon.split_path("Yef1-_0Z9c01Y_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Yef1-_0Z9c01Y_"]))
}

///|
test "native API path 1865" {
  let observed = (true, @hocon.split_path("d1Ycbe0_b_-_fZ9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["d1Ycbe0_b_-_fZ9"]))
}

///|
test "native API path 1866" {
  let observed = (true, @hocon.split_path("a.1f_-Zfa0ZfXfZfX9.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "1f_-Zfa0ZfXfZfX9", "z"]))
}

///|
test "native API path 1867" {
  let observed = (true, @hocon.split_path("a01-_fZYXbe0c9_fa")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a01-_fZYXbe0c9_fa"]))
}

///|
test "native API path 1868" {
  let observed = (true, @hocon.split_path("Y1YXY_9a0ZY_0ab1Y_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Y1YXY_9a0ZY_0ab1Y_"]))
}

///|
test "native API path 1869" {
  let observed = (true, @hocon.split_path("a.01-e0Xd19a-cY_0eYZ9.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "01-e0Xd19a-cY_0eYZ9", "z"]))
}

///|
test "native API path 1870" {
  let observed = (true, @hocon.split_path("c0Z919Z-c9_d_0edeYZ9")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["c0Z919Z-c9_d_0edeYZ9"]))
}

///|
test "native API path 1871" {
  let observed = (true, @hocon.split_path("Z9c-_9Z9X0ef1dX9c0Z-_")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["Z9c-_9Z9X0ef1dX9c0Z-_"]))
}

///|
test "native API path 1872" {
  let observed = (true, @hocon.split_path("a.0_0XbZd1dZfZbX0_0XdeYX.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "0_0XbZd1dZfZbX0_0XdeYX", "z"]))
}

///|
test "native API path 1873" {
  let observed = (true, @hocon.split_path("bX91fX9edXbX-cY_YefXdaf")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["bX91fX9edXbX-cY_YefXdaf"]))
}

///|
test "native API path 1874" {
  let observed = (true, @hocon.split_path("a.0a.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "0a", "z"]))
}

///|
test "native API path 1875" {
  let observed = (true, @hocon.split_path("bed")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["bed"]))
}

///|
test "native API path 1876" {
  let observed = (true, @hocon.split_path("a0ed")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a0ed"]))
}

///|
test "native API path 1877" {
  let observed = (true, @hocon.split_path("a.ZYXY1.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "ZYXY1", "z"]))
}

///|
test "native API path 1878" {
  let observed = (true, @hocon.split_path("-ab1-e")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["-ab1-e"]))
}

///|
test "native API path 1879" {
  let observed = (true, @hocon.split_path("Ye-eY_b")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["Ye-eY_b"]))
}

///|
test "native API path 1880" {
  let observed = (true, @hocon.split_path("a.cYe0a9eY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "cYe0a9eY", "z"]))
}

///|
test "native API path 1881" {
  let observed = (true, @hocon.split_path("aYcdZ9e-1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["aYcdZ9e-1"]))
}

///|
test "native API path 1882" {
  let observed = (true, @hocon.split_path("9Xb_YebcdZ")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9Xb_YebcdZ"]))
}

///|
test "native API path 1883" {
  let observed = (true, @hocon.split_path("a.-Zfebe-1-_f.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "-Zfebe-1-_f", "z"]))
}

///|
test "native API path 1884" {
  let observed = (true, @hocon.split_path("X9X-1f1-Zb_-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["X9X-1f1-Zb_-"]))
}

///|
test "native API path 1885" {
  let observed = (true, @hocon.split_path("ZfadebaYcf10X")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["ZfadebaYcf10X"]))
}

///|
test "native API path 1886" {
  let observed = (true, @hocon.split_path("a.dcdZfZ-c01dZ9c.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "dcdZfZ-c01dZ9c", "z"]))
}

///|
test "native API path 1887" {
  let observed = (true, @hocon.split_path("91d_dcYadcY19Z0")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["91d_dcYadcY19Z0"]))
}

///|
test "native API path 1888" {
  let observed = (true, @hocon.split_path("_fX0ebedc-ebe-_-")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["_fX0ebedc-ebe-_-"]))
}

///|
test "native API path 1889" {
  let observed = (true, @hocon.split_path("a.c0efX01dXdafXdZda.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "c0efX01dXdafXdZda", "z"]))
}

///|
test "native API path 1890" {
  let observed = (true, @hocon.split_path("9_dZ-X-c9ZdafZb_Ye")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9_dZ-X-c9ZdafZb_Ye"]))
}

///|
test "native API path 1891" {
  let observed = (true, @hocon.split_path("-1Y10ab_0_dZY_YeY_Y")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["-1Y10ab_0_dZY_YeY_Y"]))
}

///|
test "native API path 1892" {
  let observed = (true, @hocon.split_path("a.Z-abcfcbcYaba0Xfed1b.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Z-abcfcbcYaba0Xfed1b", "z"]))
}

///|
test "native API path 1893" {
  let observed = (true, @hocon.split_path("af1dc9_-eYa9XdXfcYZbX")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["af1dc9_-eYa9XdXfcYZbX"]))
}

///|
test "native API path 1894" {
  let observed = (true, @hocon.split_path("9edcb1d10XYc-Xbeb_bXb1")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["9edcb1d10XYc-Xbeb_bXb1"]))
}

///|
test "native API path 1895" {
  let observed = (true, @hocon.split_path("a.Yc-ebX0c-1fXY1-cbaYZ9cY.z")) catch {
    _ => (false, [])
  }
  assert_eq(observed, (true, ["a", "Yc-ebX0c-1fXY1-cbaYZ9cY", "z"]))
}

///|
test "native API path 1896" {
  let observed = (true, @hocon.split_path("b1")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["b1"]))
}

///|
test "native API path 1897" {
  let observed = (true, @hocon.split_path("a.de0.z")) catch { _ => (false, []) }
  assert_eq(observed, (true, ["a", "de0", "z"]))
}
