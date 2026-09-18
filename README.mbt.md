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

0.6 已增加 Node HTTP(S)/异步读取、对象根约束与 JSON 严格成员检查；八种类型化列表和 config/config-list 保持可用。历史自引用、来源加载、回退/环境和单位访问器保持可用。尚未完整兼容 Lightbend Config，差距见 FEATURES.md。
