# 绑定旧值与目标值的配置变更审批

路径批准清单回答“这个字段能否变化”；新接口回答“实际旧值与新值是否正好是这次计划的值”。例如，批准 `8080 -> 9080` 后，`8081 -> 9080` 的过期基线和 `8080 -> 9081` 的错误目标都应拒绝。include、替换、fallback 先完成求值，再审查生效树；所有实际变化都必须被计划覆盖，所有计划也必须实际发生。

## MoonBit 核心

```moonbit
let old = @hocon.parse("port=8080\ncopy=${port}")
let next = @hocon.parse("port=9080\ncopy=${port}")
let plan : Array[@hocon.ConfigTransitionRule] = [
  { path: ["port"], before: Some(Number("8080")), after: Some(Number("9080")) },
  { path: ["copy"], before: Some(Number("8080")), after: Some(Number("9080")) },
]
let report = @hocon.review_config_transition(old, next, plan)
// report.accepted 为 true；少批准 copy 或给错目标值都会拒绝。
```

位于可抛错函数内，导入 `"uiwcvb/hocon"` 为 `@hocon`。`ConfigTransitionRule.before/after` 是 `Value?`：`None` 表示该侧缺失，`Some(Null)` 表示存在且为 null。仅有 after 为新增，仅有 before 为删除，两侧都有为修改；两侧皆无、语义相等的无变化计划、重复路径及未解析的期望值均为无效输入。纯 API 返回 `ConfigTransitionReview`，具名字段见[生成接口](pkg.generated.mbti)。

路径是精确字面段，`["a.b"]` 与 `["a","b"]` 不同，空字符串键有效，不接受通配或前缀授权。列表整体比较；对象的增删使用最近对象键，两个现存对象的变化继续按叶路径报告。数字沿用 `value_equals` 的语义，`1` 与 `1.0` 相等，超过2^53的相邻整数保持区分；字符串与数字不互转。旧的 `review_config_changes` / `reviewChanges` 及其允许闲置规则的默认合同不变。

## Node 方法与本地文件 CLI

```javascript
const report = old.reviewTransition(next, [
  {path:['port'], beforeSource:'8080', afterSource:'9080'},
  {path:['copy'], beforeSource:'8080', afterSource:'9080'}
]);
```

`old/next` 是 Config 工厂产生的不可变配置，同步/异步工厂结果都可调用。`beforeSource/afterSource` 必须是单个已解析 HOCON 值文本；字符串值建议显式加引号，如 `'"production"'`。省略字段表示缺失，文本 `'null'` 表示存在的 null，JSON 的 null 不是该参数的合法文本。包装器不提供期望值的环境或来源加载器，未解析替换拒绝。使用文本可保留精确长整数，不经过 JS Number。

```json
[
  {"path":["port"],"beforeSource":"8080","afterSource":"9080"},
  {"path":["copy"],"beforeSource":"8080","afterSource":"9080"}
]
```

```sh
node tools/change-review.mjs --before old.conf --after new.conf --transition-policy transitions.json
moon run examples/transition_review --target wasm-gc
node examples/review-transition-service.mjs
```

`--transition-policy` 与原 `--policy` 互斥；退出0为接受，2为计划不符，1为无效输入。文件入口可继续设置各侧 fallback/classpath，空环境、禁用HTTP、读取指纹复核及非原子快照边界保持原状。库级 `reviewFiles({before,after,transitions})` 使用同一入口；值绑定模式始终要求全部计划被使用。示例从 include 读取新响应、同时批准引用字段，完成真实回环 HTTP 请求后关闭自己的监听；另行打印 HTTP 正文作为消费证据，审批 report 自身只含路径与判定。

## 策略 JSON 语法错误

CLI 与服务示例共用 `parseChangePolicy(text)`：合法 JSON 的结果保持原样，语法错误给出不带输入片段的 `Policy must contain valid JSON`。Node 原始 SyntaxError 的消息或未捕获堆栈可能带出 beforeSource/afterSource 中的值，因此这里重新抛出不附带原始 cause 的错误；不是从错误文本中逐词打码。调用者可从 `tools/change-review.mjs` 导入该 JSON 文本解析器，再把结果交给 reviewFiles 或服务入口做规则校验。它本身不代替策略结构/值验证，也不改变调用入口的文件限额。

2026-10-28 修复前，4个畸形输入中 CLI 有3个、示例有4个带出假的测试敏感值。新增 `node tools/test-transition-policy-errors.mjs` 的21项检查覆盖被捕获/未捕获错误、有效预览、0/1/2退出码、旧策略、读取失败和原限额，以及实际 HTTP 启用/拒绝。配置文件解析的其它错误、路径名和调用者主动打印的输入不在这项处理范围内。

## 报告、预算与用途边界

报告含 `accepted`、`changes`、`unexpected`、`mismatches`、`unusedRules`；MoonBit 对应字段为 `unused_rules`。mismatches 只给路径、变更类别及 `before`/`after` 失败侧；未匹配实际变化的计划进入 unusedRules。报告不包含实际配置值或期望值，路径名和来源路径本身仍可包含敏感名称。不要将输入计划对象的 Debug 输出当成该报告。

最多1024条计划、路径1至32段、路径合计65536个UTF-16单元；期望树共享既有1000000工作预算，diff继承4096条变化上限。Node策略文本最多524288个UTF-16单元，CLI策略文件最多524288字节；单值文本继承解析预算。无效输入通过既有 ParseError/ConfigError 拒绝。

本功能只核对调用者提供的具体迁移计划，不评判端口或业务值是否合理，也不是签名审批系统、热重载、事务写入、回滚或部署安全证明。仍无确认外部采用，新增接口及示例尚未发布。

## 相关工作与验证

值前置条件是既有概念，例如[RFC6902 test](https://datatracker.ietf.org/doc/html/rfc6902#section-4.6)。本项目没有实现 JSON Patch；增量是对求值后的 HOCON 树审查完整迁移、保留精确值并输出不带值的报告。通用 Schema 已有 [moonschema](https://mooncakes.io/docs/moonbitstack/moonschema@0.2.0) 与 [MoonCheck](https://github.com/sgy1023-crt/MoonCheck)，这里不重做它们的验证器，也不以有限检索证明生态唯一。

`config_transition_test.mbt` 包含独立的接受/拒绝预期，覆盖旧值、目标值、间接变化、空值/缺失、字面路径、列表、对象边界、大整数、无效策略和预算；`tools/test-transition-host.mjs` 覆盖方法、异步状态、CLI与真实服务启用/拒绝。命令、最初编译错误、实际结果及源/编译身份随 `reports/hocon/deep-repair-09-max-20261028` 保留；这不是完整JVM或全量历史套件认证。

本轮实际完成：全目标 `moon check --deny-warn`、格式化、生成接口与 JS 引擎构建通过；新增11组及相关10组用例在JS/Wasm-GC各21项通过；可运行MoonBit示例在native/Wasm-GC各4场景通过；Node新消费者34项、既有HTTP消费者6组、第07轮42项及第08轮171项回归通过。公共API仅增加声明，未删除或改变旧声明；未重跑未变化的大型历史套件。

第10轮另以未修改 Config1.4.9 的20个参考值核对11个常量拼接迁移用例，全部已正确工作，没有因此修改解析器。核心、生成API和引擎与第09轮逐字节一致，未重跑未变化的后端大套件；新服务示例实际返回200并关闭自己的监听。本轮原输入、旧错误输出及新命令回执保留在 `reports/hocon/deep-repair-10-max-20261028`。

## 可选的预览后启动核对

若希望启动所用输入与先前确认的预览一致，可使用[预览指纹与两步启动](PREVIEW-BOUND-ACTIVATION.md)：它额外绑定实际文件内容、具体规则和有序fallback/classpath，不改变这里的默认规则/报告合同。仅比较公开diff和排序后的文件集合不足以捕获输入优先级变化。
