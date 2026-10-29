# HOCON 配置迁移与变更审查

项目仓库：[https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)。模块 `uiwcvb/hocon`，本地 **0.25.0**，MIT。

预生成引擎所用标准库及公开配置样本的许可、出处见[第三方许可说明](THIRD_PARTY_NOTICES.md)。

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

未找到必需替换时，解析得到的树抛出 `ParseError.Located(message, SourcePosition)`，位置指向实际 `${...}` 的 `$`，包括 include 子来源和 fallback；复制、部分解析及 JS 异步持久化传输后仍保留。`offset` 是从零开始的 Unicode 标量索引，`line/column` 从一开始。未解析树已有 `Value.LocatedSubstitution`，旧四参数 `Substitution` 构造器及无来源手工值的 `Invalid` 行为保留；外部穷举匹配须处理带来源变体，原始结构相等会比较来源，语义比较请用 `value_equals/value_hash`。成功求值、语义比较和渲染保持原合同。[缺失替换的历史独立参考与双后端证据](evidence/unresolved-origin-20261027/RESULTS.md) 明列可比字段和 API 代价。

2026-10-28 本地加固将同一来源诊断扩展到循环替换：包括 include 子来源、fallback 和包围对象循环，沿用已有公共 API 与拒绝语义。[循环诊断用法与验证范围](CYCLE-DIAGNOSTICS.md) 说明哪些字段对照官方 1.4.9、哪些只按文本验证；未声称覆盖全部求值异常。

## 只批准具体的旧值与目标值

新增 `review_config_transition` / `Config.reviewTransition` 可以只批准 `8080 -> 9080`，同时拒绝同一路径上的错误目标值和过期基线。所有实际变化都须被计划覆盖，每条计划也必须发生；经替换产生的间接变化仍须单独批准，数字比较保留精度，报告不含实际值或期望值。原路径/类别批准清单继续可用。

```sh
node tools/change-review.mjs --before old.conf --after new.conf --transition-policy transitions.json
moon run examples/transition_review --target wasm-gc
node examples/review-transition-service.mjs
```

[值绑定计划的 API、策略格式及边界](VALUE-BOUND-TRANSITIONS.md) 包含可运行的 MoonBit 示例和实际 HTTP 消费者；新增功能包含在本仓库源码中，不替代业务值合理性校验。

## 从已确认预览到服务启动

可选 `previewTransitionFiles` / `--preview-receipt` 将具体计划、文件指纹及有序fallback/classpath绑定成预览哈希；服务传入 `expectedPreviewHash` 后，配置与计划同步变化或输入次序漂移也会在监听前被拒绝。原入口默认行为不变。

示例新增可选 `--check`：先审查迁移，再复用启动时的getter和端口范围检查，返回同一预览哈希及 `serviceConfigChecked`，全程不监听。普通 `--preview` 继续只检查迁移和输入；检查成功仍需调用者审阅并确认哈希。

```sh
node examples/preview-bound-service.mjs --check
# 检查回执后，在另一次调用中传入已确认的哈希：
node examples/preview-bound-service.mjs --activate COPY_THE_CONFIRMED_PREVIEW_HASH_HERE
```

各模式均可附加 `--before FILE --after FILE --transition-policy FILE`，以及可重复的fallback/classpath参数，使用自己的文件；目标配置需提供示例消费的 `service.port` 和 `service.message`。[两步用法、字段检查、PowerShell接入与指纹边界](PREVIEW-BOUND-ACTIVATION.md)给出真实HTTP示例。预期哈希由调用者的可信审批流程提供；文件复核仍非原子快照。

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

公开网页另有[真实 Chromium 消费者回归](tools/browser/README.md)：通过页面输入与运行/重置按钮核对明确的值和类型、大整数、替换覆盖、错误诊断及 Unicode 标量位置，并检查错误后的恢复。预期手工编写；工作流先构建引擎，再核对浏览器实际收到的引擎哈希，保存截图和失败追踪。此项覆盖限定于 Chromium 和已声明场景。

[独立 MoonBit 应用消费验收](tools/transition-consumer/README.md) 另在新的双模块工作区导入公开包，核对类型化计划、报告序列化及接受/拒绝后的实际配置选择。JS 与 Wasm-GC 各从空的产品构建目录执行六个手工预期场景；依赖使用当前源码，不通过 Node 桥接，也不宣称验证了新版本的 Mooncakes 发布。

[真实本地分发包验收](tools/package-consumer/README.md) 使用 `moon package` 的实际归档，逐项读回源码与许可身份、排除验证缓存和生成报告，拒绝缺 NOTICE、改字节及不安全成员等损坏样本，再从解压出的包运行独立应用。`.moonignore` 已补齐浏览器开发依赖和新生成目录的排除；原源码、样本、宿主工具与许可仍保留。这项证明针对本地产物，不代表发布或下载验证了新版 Mooncakes。

## 已有工作、用途与边界

Lightbend Config 已成熟定义并实现 HOCON。项目不以语法移植或“生态空白”为创新依据；贡献在于 MoonBit 内可组合的配置树与变更合同，以及可复查的跨实现迁移流程。[查重与许可](DUPLICATION.md) 记录已有工作。AI 可以帮助生成配置，但最终生效路径、间接变化、输入预算和拒绝结果仍需确定性执行与独立参考核验。

只适合确有 HOCON 兼容需求的应用；新建简单配置不必使用它。没有确认的迁移用户。原策略是精确允许清单，新增值绑定计划核对具体旧/新值，但不评判业务合理性、部署安全或完整 JVM 兼容；文件入口使用空环境、禁用 HTTP，文件重验不是原子快照。历史用法见 [完整说明](README-BEFORE-VALUE-REWORK.md)。

## 交付状态

**源码与发布边界**：本分支包含值绑定迁移、预览指纹、延迟合并、`.properties` 续行和显式文件格式修复。当前提交的验证状态见 [GitHub Actions](https://github.com/uiwcvb/moonbit-hocon/actions/workflows/ci.yml)，请核对运行记录的提交 SHA。`moon.mod` 仍保留 0.25.0，本次只集成 GitHub 源码，未重新发布 Mooncakes；新增功能请从此仓库构建。表单一致性、换题和赛事审核结果仍未核实。

[申报书](uiwcvb-hocon-%E7%94%B3%E6%8A%A5%E4%B9%A6.md)

## 规范覆盖与公共合同

[HOCON-COVERAGE.md](HOCON-COVERAGE.md) 按固定 Lightbend Config v1.4.9 文档的全部技术标题列出实现、有限证据、待验证与未实现范围，并校准实际 API、Unicode 标量位置及默认/严格 unused-rules 行为。本期仅补文档；既有70/40/HTTP成绩保留原范围，不重复开发或宣称完整兼容。

## 派生配置的部分求值修复

2026-10-28 本地代码修复：从延迟合并对象提取子配置并追加 fallback 时，部分求值会保留未知合并层的查询屏障，避免跳过低层替换后错误接受尚不可确定的键查询；不含替换的 fallback 与更高已知标量继续可用。公共 API 不变。[复现、正常对照与验证范围](DELAYED-ROOT-RESOLUTION.md) 记录相关双后端各45项、2688个状态程序及消费者检查；上面的“仅补文档”指 implementation-03 历史阶段。

## properties 宿主续行修复

2026-10-28 本地修复 `.properties` 空前缀续行把注释/空行当成键、并可能吞掉下一条有效配置的问题。226个独立参考输入由32处差异降为0，58个既有文件参考、26个固定回归与16项实际消费者检查及既有宿主回归通过；MoonBit 核心和公共 API 不变。[触发输入、正常对照与验证范围](PROPERTIES-CONTINUATIONS.md) 记录本轮边界。

## 文件格式的显式选择

文件和 `file:` URL 的 `format:'hocon'|'json'|'properties'` 现正确覆盖主文件扩展名，适用于没有标准扩展名的配置或需要强制严格 JSON 的消费入口；同步/异步 Config 工厂一致，HTTP 仍保持 Content-Type 优先。192个独立观察的差异由72降为0，另171项定向消费者检查及相关回归通过，见[用法与有限验证](EXPLICIT-FILE-SYNTAX.md)。该修复包含在本仓库源码中，本次未重新发布 Mooncakes。

## 策略输入的错误诊断

CLI 和值绑定服务示例的策略 JSON 语法错误现使用不带输入片段的诊断，避免 Node 原始 SyntaxError 自动把期望值写入错误日志；合法输入、0/1/2退出码与原限额保持。21项针对性消费者检查及真实 HTTP 示例通过，见[策略输入说明](VALUE-BOUND-TRANSITIONS.md)。这项宿主修复未改变 MoonBit 核心、API或生成引擎。

## 类型化配置文件交接

当应用只接受一个 JSON 设置文件时，新的 [文件交接工作流](TYPED-CONFIG-EXPORT.md) 接受原始本地配置和调用方字段清单，复用现有公开文件加载/类型读取，生成仅含所选字面名称的完整产物。支持既有 hocon/json/properties 格式；int/boolean/string 沿用原读取语义，long 保持精确十进制字符串。

```sh
node tools/typed-config-export.mjs --file mounted-settings --format properties --queries app-fields.json --output app-settings.json
```

声明或配置读取失败不替换旧产物，并保护源/查询/fallback/include 路径别名。独立的 `examples/config-file-receiver.mjs` 只从产物文件读取设置并提供回环 HTTP；必要 CI 用真实进程、文件与 HTTP 验证完整交接。普通文件写入故障可能留下部分文件，不提供并发锁或崩溃事务。旧 CLI 和 MoonBit 核心不变；自编接收方不代表第三方采用。
