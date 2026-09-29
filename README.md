# HOCON 配置迁移与变更审查

项目仓库：[https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)。模块 `uiwcvb/hocon`，本地 **0.25.0**，MIT。

已有 HOCON 配置迁入 MoonBit 时，include、变量替换和 fallback 会共同决定最终配置。只审查文本差异可能漏掉间接改动。本项目让应用读取既有配置，并在启动或发布前回答两件事：与原 JVM 解析结果是否一致；相对于上一份配置，哪些最终路径发生了未经允许的变化。

## 可复用的核心

MoonBit 实现解析、求值、类型读取、`diff_resolved_configs` 和新增 `review_config_changes`。变更规则精确指定字面路径与增删改类别；输出路径和类型，不输出配置值。允许修改端口不自动允许经替换变化的其他字段，也不允许删除整个父对象。JS 与 Wasm-GC 使用同一核心。

```moonbit
let old = @hocon.parse("service.port=8080\nservice.copy=${service.port}")
let next = @hocon.parse("service.port=9080\nservice.copy=${service.port}")
let review = @hocon.review_config_changes(old, next, [
  { path: ["service", "port"], kind: "changed" },
])
// review.accepted == false；service.copy 也变化，尚未被允许。
```

此例位于可抛错函数内，消费包导入 `"uiwcvb/hocon"` 为 `@hocon`。完整接口见 [生成 API](pkg.generated.mbti)。JS 的不可变 Config 对象保留 MoonBit 树，新增 `reviewChanges` 不经过丢失大整数精度的 JS 数值转换。接口、预算和失败行为见 [配置变更审查](CHANGE-REVIEW.md)。

## 安装与运行

使用 [固定 MoonBit 工具链](TOOLCHAIN.md)（moonc 0.10.14）与 Node 24。从源码目录运行：

```sh
moon update
moon build --target js --deny-warn
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node examples/run-use-case.mjs
node examples/read-openwhisk.mjs
```

自备前后两份可信配置及 JSON 规则文件即可运行变更审查，无需 Java：

```sh
node tools/change-review.mjs --before old.conf --after new.conf --policy permissions.json
```

退出 0 为全部变化获允许，2 为存在未允许变化，1 为输入错误。可分别指定两侧 fallback/classpath，报告保留实际读取文件指纹。独立的 [迁移闸门](MIGRATION-GATE.md) 使用官方 Lightbend Config 1.4.9 JAR 检查跨实现一致性；它与前后版本的变更审查互补。

## 公开配置与验证

[Apache OpenWhisk 样本](OPENWHISK.md) 保留原始 controller 配置、两个 include、fallback、固定提交、哈希及许可。既有对照覆盖 36 条叶路径和 11 项类型读取。新增 [变更用例](CHANGE-REVIEW.md) 在副本上改端口和 include 日志级别：即使主文件哈希未变，也检出 include 中的非预期变化；完整解析结果另经官方 Java 实现核对。没有声称运行整个 OpenWhisk 或获得其采用。

```sh
moon test --target js --deny-warn
moon test --target wasm-gc --deny-warn
# 设置 HOCON_REFERENCE_JAR 后：
node tools/test-change-review.mjs
node tools/test-persistent-host.mjs
```

2026-09-29 本地 JS/Wasm-GC 各 16727 项通过；新增公开配置审查的 6 组检查和既有 54 项对象/文件/异步所有权检查通过，见 [回执](evidence/openwhisk-change-review.json)。[CI](.github/workflows/ci.yml) 已纳入新增检查；本地验证不等于新提交的 GitHub Actions 成功。

## 已有工作、用途与边界

Lightbend Config 已成熟定义并实现 HOCON。项目不以语法移植或“生态空白”为创新依据；贡献在于 MoonBit 内可组合的配置树与变更合同，以及可复查的跨实现迁移流程。[查重与许可](DUPLICATION.md) 记录已有工作。AI 可以帮助生成配置，但最终生效路径、间接变化、输入预算和拒绝结果仍需确定性执行与独立参考核验。

只适合确有 HOCON 兼容需求的应用；新建简单配置不必使用它。没有确认的迁移用户。策略是精确允许清单，不校验业务值、部署安全或完整 JVM 兼容；文件入口使用空环境、禁用 HTTP，文件重验不是原子快照。历史用法见 [完整说明](README-BEFORE-VALUE-REWORK.md)。

## 交付状态

2026-09-29 已核对 [Mooncakes 0.24.1](https://mooncakes.io/docs/uiwcvb/hocon@0.24.1) 与 [旧公开 CI](https://github.com/uiwcvb/moonbit-hocon/actions/runs/36435988171)。0.25.0 的策略 API、宿主入口和检查仅在本地，尚未推送或发布；旧 CI 不能为新增代码背书。报名表与审核结果仍须另核。申报正文见 [PROPOSAL](PROPOSAL.md)。
