# 循环替换来源诊断

已有 HOCON 配置在 include 或 fallback 中形成替换循环时，解析仍拒绝循环；本次加固让已有 `ParseError.Located` 携带参与循环的实际 `${...}` 位置。

```moonbit
let value = @hocon.parse_unresolved(
  "include \"child.conf\"",
  source_name="main.conf",
  includes={ "child.conf": "# child\na={b=${a}}" },
)
// 位于可抛错函数内。resolve(value) 抛 Located：child.conf，第 2 行第 6 列。
let resolved = @hocon.resolve(value)
```

`source` 是输入具名来源；`offset` 从零开始，以 Unicode 标量计数；`line/column` 从一开始，CRLF 的换行以 LF 计。位置指向 `$`，不是整个循环链的起点。多条替换构成循环时，两种实现可选择不同的参与边；这里不承诺完整错误消息或诊断边与 Java 一致。

直接循环、跨字段循环、引用包围对象和隐藏绑定循环均沿用原有拒绝逻辑与消息。带来源的解析值返回 `Located`；旧 `Reference`、`PathReference`、四参数 `Substitution` 等无来源手工值仍返回 `Invalid`。已有未解析值的复制、包裹、fallback 和异步 Worker 传输继续保留来源。外部捕获代码若只处理 `Invalid`，应按已公开的 `ParseError` 类型同时处理 `Located`。

可选自引用、已有历史值的自引用追加和被后续值覆盖的循环继续按原规则求值。本次没有新增公共类型或函数，也没有改变来源缺失、预算、include 装载失败及其它语义错误的完整覆盖范围。

固定 MoonBit 工具链下可运行：

```sh
moon test cycle_origin_test.mbt cycle_origin_reference_test.mbt --target js --deny-warn
moon test cycle_origin_test.mbt cycle_origin_reference_test.mbt --target wasm-gc --deny-warn
```

本轮对同一批原创合成输入实际运行未修改的 Lightbend Config 1.4.9：7 项循环拒绝、3 项正常求值；Node 四种入口共 40 次观察。参考的共同来源/行字段和成功值被核对；列号与 offset 只按原始文本验证。原始输入、JAR 哈希、观察适配器和日志位于本单报告 `reports/hocon/evidence/cycle`，不把历史大矩阵算作本轮次数。审批规则与真实 HTTP 消费者沿用 [CHANGE-REVIEW.md](CHANGE-REVIEW.md)。

核心 MIT 许可保持；Lightbend Config/规范及既有 OpenWhisk/Pekko 样本遵守各自 Apache-2.0 与 NOTICE，见原有来源文件。本轮未拷入近邻项目代码。
