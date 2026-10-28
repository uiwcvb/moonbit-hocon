# 未解析替换的来源位置增量

本地 0.25.0 恢复源上的一项功能增量；不是完整 HOCON 或 JVM 异常兼容完成声明，未提交、推送、发布或修改其它项目/总状态/历史交付。

实现保存解析器实际 `$` token 的 `SourcePosition`。必需替换最终找不到时抛 `Located`；include 内替换保留子文件名，include 重定位不改其源码位置。copy、重编号、fallback、allow-unresolved、resolve-with 与 JS worker 的 raw tree 传输都保存该元数据。成功值仍走原解析/求值逻辑。循环、include 装载失败、预算和其它语义异常维持原行为，本批没有覆盖它们的全部位置。

`offset` 沿用 lexer 的零起始 Unicode 标量索引，`line/column` 为一起始。中文、补充平面字符和 CRLF 用例按原文本检查；没有把它们说成 Lightbend 列号/偏移量一致性。

## API 与兼容代价

没有可承载来源的既有 Value wrapper。全局 ID 表无法跨复制/重新编号/独立树和 worker 安全保留来源；另造一套详细 document/resolve API 会扩大范围。因此新增公开 `Value.LocatedSubstitution(paths, optional, list_env, id, position)`，保留原四参数 `Substitution`、`Reference`、`PathReference`。旧手工无来源值仍抛原 `Invalid("unresolved ...")`。

这是实际 API 变化：外部穷举匹配需要新分支，`parse_unresolved` 等返回的原始 Value 表示改变，derive(Eq) 的结构比较包含来源并区别旧/新变体。`value_equals/value_hash` 会忽略位置和解析 ID，旧新语义等价树的比较/哈希/渲染由新增测试覆盖。已求值结果不新增该变体。生成 API 的唯一差异保存在 `api.diff`。

宿主的 opaque raw-tree 传输新增内部 `located-substitution` tag，仍接受旧 tag；SourcePosition 在 unpack 中检查非负 offset、正 line/column。没有改变已有 `ParseError` 构造器或对外错误 JSON 的 position 字段。

## 实际验证

- 恢复前基线：490 个文件逐字哈希与既有恢复收据一致；版本 0.25.0，归档 SHA `0c7505375d0ed3058e9b4ef90ab6a2f17dd2eb436f2f58dbb004eff4218e915d`，声明提交 `8b53d9292f8a5d31be0c81a2fd580495cbfbcd87`。`BASELINE.json` 和 `sources-before.zip` 保留输入。
- 固定工具：本地 acceptance-20260928 Moon，moonc `0.10.14+7d59c7ec9`；`check --target all --deny-warn` 通过，fmt 与 info 完成。旧工具无 moon-ide 子程序，符号以项目实际源码和生成接口核验。
- 新语义回归 JS **17/17/0**、Wasm-GC **17/17/0**。其中 13 个同输入独立参考案例：9 个缺失替换（直接、中文/CRLF、拼接、数组、带引号路径、include、嵌套 include、include 链、fallback），4 个成功结果；另 4 项覆盖来源生命周期、旧构造器/Invalid、语义比较/哈希/渲染和配置变更合同。
- 相关核心/解析/文档/树/容器/渲染/配置差异与规则回归 JS **40/40/0**、Wasm-GC **40/40/0**。仅选相关 9 个测试文件，未重跑全库历史向量。
- 新 JS engine 实际构建并逐字复制读回，旧 engine gzip 保留；构建与测试绑定同一批 76 个 `.mbt` 输入，前后哈希稳定。
- 真实 Node 宿主 **30/30/0**：13 个参考输入分别经过 sync/async，另 4 个 retained Config parse/parseAsync 后再 resolve，验证 worker raw-tree 传输。`HOST-REFERENCE-RESULTS.json` 保存完整实际消息/位置及原版结果。

## 独立参考的真实范围

使用已有未修改 Lightbend Config **1.4.9** JAR，SHA `47d13e3196c84f2a8ccd014ae563738c3da5b7406b38e03505ec0601a2f4fc37`，固定本地 JDK22。`OriginReference.java` 只是 JSONL 输入/输出观察适配器；解析、替换求值和异常由 JAR 执行。内存 include 回调只提交同一组具名源字节及 origin description，无预填预期或伪造异常。

`requests.jsonl` 保存同输入；`reference.stdout.jsonl` 保存实际完整错误消息、真实异常 class、origin description、line、filename 和成功值；stderr 原字节独存。实际 9 个异常均为 `ConfigException$UnresolvedSubstitution`。Moon 侧仍使用现有 `Located`，按真实缺失替换消息分类对应，未声称添加 JVM 异常类型。来源/行号及 4 个成功值实际相符；完整错误消息保留而未要求逐字相等。

ConfigOrigin 本次输出没有 column/offset；二者**不计独立参考通过字段**。它们只按各原始输入中 `$` 的 Unicode 标量位置检查。参考 filename 因命名 parseString 为 null，比较使用真实 origin description，未冒称验证物理文件 canonical path、HTTP 来源或 classloader。

`REFERENCE-RECEIPT.json` 绑定 JAR/JDK/适配器/请求/原始输出哈希；`GENERATED-TESTS.json` 记录生成阶段测试哈希，格式化后的最终测试哈希另列 `CHECKS.json`。本目录阶段日志与 receipt 保留实际命令/退出码/输入哈希；`CHECKS.json` 和 `implementation.diff` 是本次收口索引。
