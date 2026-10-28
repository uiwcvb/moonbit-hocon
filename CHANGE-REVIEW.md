# 已求值配置的变更审查

本接口供拥有既有 HOCON 配置的 MoonBit 应用或配置发布流程使用。先展开 include、替换和 fallback，再对照允许变化的路径。例如只允许修改端口时，经变量替换连带变化的另一条配置仍须单独允许；修改 include 也不会因为主文件未变而被忽略。

## MoonBit 内部调用

```moonbit
let before = @hocon.parse("service.port=8080\nservice.copy=${service.port}")
let after = @hocon.parse("service.port=9080\nservice.copy=${service.port}")
let review = @hocon.review_config_changes(before, after, [
  { path: ["service", "port"], kind: "changed" },
])
// accepted 为 false；unexpected 包含 service.copy。
```

调用位于可抛错函数内。`ConfigChangeRule` 的路径由字面键组成，`["a.b"]` 与 `["a","b"]` 不同；类别只有 `added`、`removed`、`changed`。规则精确匹配，不自动允许父级删除或任意后代变化。空清单只允许语义相等；原接口保持允许未使用规则。新增 `unused_config_change_rules(before, after, rules)` 返回未匹配变化的有效规则，Node 对应 `Config.unusedChangeRules(next, rules)`；路径和 kind 均须精确相等。列表整体比较，新增或删除对象在最近对象键报告。

JS 宿主的 `Config.loadFile(...).reviewChanges(next, rules)` 直接比较 MoonBit 保留的树。它不会先把值转成 JS Number，所以大于 2^53 的相邻整数仍可区分。返回值只有路径、类别和前后类型，不返回配置值；路径本身仍可能包含敏感名称。

## 文件入口

按 README 构建并刷新 engine，然后准备 `permissions.json`：

```json
[{"path":["service","port"],"kind":"changed"}]
```

```sh
node tools/change-review.mjs --before old.conf --after new.conf --policy permissions.json
# 严格审批：任何未使用规则也退出 2
node tools/change-review.mjs --before old.conf --after new.conf --policy permissions.json --require-all-rules-used
```

需要时重复传 `--before-fallback FILE`、`--after-fallback FILE`、`--before-classpath DIR`、`--after-classpath DIR`。Node 负责读取可信本地文件、输入指纹和退出码；策略匹配与配置差异在 MoonBit 核心完成。HTTP 禁用，环境显式设为空。报告增加 `unusedRules`；`reviewFiles` 可选 `requireAllRulesUsed: true`。退出 0 表示政策接受；2 表示存在未允许变化或严格模式存在闲置规则；1 表示输入或策略无效。成功报告含两侧实际读取文件的 SHA-256，输出前重新核验读取内容；这不是原子文件快照。

`examples/reviewed-service.mjs` 是实际消费配置的本地 HTTP 应用入口：先审查、复核读取指纹、读取带类型的端口/响应配置，只有接受后才开启监听。`tools/check-review-consumer.mjs NEW_EVIDENCE_DIRECTORY` 验证获允许的 include 变化确实改变 HTTP 响应，未允许的变化或闲置批准在创建监听前抛 `PolicyRejected`，报告不含配置值。这是本项目编写的消费者，未冒称外部采用、OpenWhisk 实际部署或完整部署安全。

策略上限 1024 条、路径深度 32 段、合计 65536 个 UTF-16 单元；配置差异继承树预算与 4096 条报告上限。重复规则、未知类别、未求值树、非对象根均拒绝。不得把允许变化解释为新值正确、服务可启动或部署安全；调用方仍须进行类型与业务验证。

## 真实项目配置复现

`examples/openwhisk` 保留 Apache OpenWhisk 固定提交的原始文件、SHA-256、Apache-2.0 许可与 NOTICE，来源见 [OPENWHISK](OPENWHISK.md)。测试复制这些文件后施加明确改动，不改写基线，也不声称 OpenWhisk 使用了本库：

1. 两份未改动配置得到空报告。
2. 将 controller HTTP 端口覆写为 10002；Lightbend Config 1.4.9 与 MoonBit 对两侧完整树一致，只有精确允许端口时才接受。
3. 保持端口规则，另改 include 中的日志级别，准确拒绝 `pekko.loglevel`。
4. 把主文件恢复到原始 SHA-256，仍检出 include 的变化。
5. 无效规则退出 1；数值精度、未求值树和错误 JSON 形状另有拒绝检查。

```sh
# HOCON_REFERENCE_JAR 指向未改动的官方 Config 1.4.9 jar
node tools/test-change-review.mjs
```

本地结果见 [回执](evidence/openwhisk-change-review.json)。这是公开配置片段的变更审查与独立解释器对照，没有运行整个 OpenWhisk 控制器。新增代码发布前须让公开源码、CI 和 Mooncakes 同步到 0.25.0。
