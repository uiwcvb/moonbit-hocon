# 可执行 API 示例

增加必需字段的 String/Int/Bool 类型读取和类型错误。这些例子调用公开 API，并随 `moon test` 执行。

```mbt check
///|
test "typed configuration access reports missing and invalid values" {
  let v = @hocon.parse("port=8080\nenabled=true\nhost=localhost")
  assert_eq(@hocon.get_int(v, "port"), 8080)
  assert_true(@hocon.get_bool(v, "enabled"))
  assert_eq(@hocon.get_string(v, "host"), "localhost")
  assert_true(
    try {
      ignore(@hocon.get_int(v, "host"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(@hocon.get_bool(v, "missing"))
      false
    } catch {
      _ => true
    },
  )
}
```

限制：不是 Lightbend Config 全兼容；标量内部仍为文本表示，完整类型保真待做。
