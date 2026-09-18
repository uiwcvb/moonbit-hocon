# HOCON 配置解析器

MoonBit 本地 0.8.0：类型化配置、历史值自引用、`+=`、include 重定位、显式回退与环境替换、未解析文档/分阶段解析、单位与类型化列表读取、配置树修改与校验、文件/HTTP(S) 加载、可取消异步入口和 CLI。
解析和求值均由 MoonBit 实现；Node 提供文件、HTTP(S)、properties 和命令行宿主。Java 只用于独立参考测试及路径字符数据生成。

## 命令行与文件

```powershell
node tools/cli.mjs --input 'port=8080' --resolved-json
node tools/cli.mjs --url https://config.example/app.conf --http-timeout-ms 5000 --resolved-json
node tools/cli.mjs --file app.conf --fallback defaults.conf --env --resolved-json
node tools/cli.mjs --file app.conf --get service.timeout --type duration
node tools/cli.mjs --file app.conf --classpath ./resources --resolved-json --json
```

`--fallback` 可重复，越早指定优先级越高；主配置优先级最高。各文件的 include 相对来源文件解析。
`--env` 显式启用当前进程环境，默认不读取。classpath 接收目录，首个目录优先。
`--resolved-json` 输出最终 JSON；默认输出值类型调试展示；`--json` 保留 `{ok,output}` 结果信封。
`--get` 接受带引号路径，`--type` 支持 value/string/boolean/int/long/double/duration/bytes/memory/list/has/null。
另支持 string-list/boolean-list/int-list/long-list/double-list/duration-list/bytes-list/memory-list/config/config-list。
long、duration、bytes、memory 及其列表元素的 CLI 结果为精确十进制字符串；duration 单位为纳秒。
错误退出码：配置或读取错误 2，宿主/参数错误 1，成功 0。也支持 UTF-8 stdin。

```javascript
import {load, loadFile} from './tools/config.mjs';
const config = loadFile('app.conf', {
  fallbackFiles: ['defaults.conf'],
  environment: {HOST: 'localhost'},
  classpath: ['./resources'],
});
const bytes = load('limit=2 KiB', {getter: 'bytes', path: 'limit'}); // "2048"
```

宿主支持本地文件、file:/HTTP(S) URL、目录 classpath；普通缺失 include 为空，required 缺失时报错。
不带已知扩展名的 include 搜索 `.properties`、`.json`、`.conf`，依此顺序合并。
`file(...)` 相对 cwd，`classpath(...)` 相对资源根；普通 `include "..."` 相对来源。
properties 支持转义、续行、点路径及冲突时对象优先，所有值保持字符串。JSON 来源的键是字面键，不解释替换。

兼容性细节：Lightbend 1.4.9 的普通启发式 include 在直接指定 `.json`/`.properties` 文件时会继承 HOCON 语法；本宿主复现此行为。
需要按扩展名读取其原格式时，使用不带扩展名的搜索、显式 `file(...)`，或把该文件作为加载入口。
文件语法/优先级的实际参考结果保存在 `evidence/file-reference-vectors.json`，不是只根据扩展名推断。

## HTTP(S) 与异步读取

```javascript
import {loadURL, loadURLAsync} from './tools/config.mjs';
const config = loadURL('https://config.example/app.conf', {
  network: {timeoutMs: 5000, totalTimeoutMs: 30000},
});
const cancellable = await loadURLAsync('https://config.example/app.conf', {
  signal: AbortSignal.timeout(10000),
});
```

现有 `load`/`loadFile` 同步支持 HTTP(S) include；新增 `loadURL` 读取精确 URL。`loadAsync`/`loadFileAsync`/`loadURLAsync` 保持调用方事件循环响应，支持取消运行中或排队中的请求。异步池最多 4 个执行 Worker、128 个排队任务；队列超限会拒绝。空闲 Worker 不阻止进程退出；失败/取消的 Worker 会被替换。

`fallbackURLs` 在 `fallbacks`、`fallbackFiles` 之后作为较低优先级配置；CLI 对应 `--fallback-url`。URL 内的相对 include 以请求 URL 为来源，即使发生重定向也保留原始来源。没有已知扩展名的相对 include 按 conf/json/properties 的顺序请求，再按 conf 最高的优先级合并。

响应 Content-Type 中的 application/json、application/hocon、text/x-java-properties 可覆盖扩展名，匹配区分大小写；字符集参数不改变 UTF-8 读取。请求发送对应 Accept。支持同协议 300/301/302/303/307 重定向，默认最多跟随 19 次，与参考库第 20 次重定向报错的行为一致；308 和跨协议重定向读取响应体，305 代理重定向明确拒绝。

可选 include 只将 HTTP 404/410 视为缺失；500 等状态、TLS 错误、超时和配置语法错误仍失败。TLS 始终验证证书；`network.ca` 或可重复 `--ca FILE` 提供 PEM 信任集合，显式 CA 集合取代默认集合。未实现代理、HTTP 认证协商及 JAR 协议。

默认单次请求总超时 5 秒，整次加载的网络期限 30 秒；`network.timeoutMs`/`totalTimeoutMs` 与 CLI `--http-timeout-ms`/`--http-total-timeout-ms` 可调整。`maxRedirects`/`--http-max-redirects` 最大 64；`maxResponseBytes`/`--http-max-bytes` 只能降低 400,000 字节响应上限。累计文件/响应仍限 4,000,000 字节、512 次读取（包括重定向），每源 100,000 UTF-16 单元。失效 Worker 另有最多 2 秒的唤醒看门狗余量。`network:false`/`--no-network` 可禁用 HTTP(S)。无效 UTF-8、截断响应和超限输入明确拒绝，这些是本地约束，不作为上游全范围行为一致的声明。

同步接口会阻塞调用线程；在需要同时服务网络请求的事件循环中使用异步接口。HTTP(S) 是 Node 宿主能力，浏览器演示页没有新增跨域网络控制界面。

## 未解析文档和分阶段解析

```moonbit
let raw = @hocon.parse_unresolved("a=${missing}\noptional=${?gone}")
let partial = @hocon.resolve(raw, allow_unresolved=true)
let filled = @hocon.with_value(partial, "missing", @hocon.Number("7"))
let ready = @hocon.resolve(filled)
let value = @hocon.get_value(ready, "a") // Number("7")
let external = @hocon.resolve_with(raw, @hocon.parse_unresolved("missing=9"))
```

`parse_unresolved` 与 `parse_sources_unresolved` 先解析源、include 和 fallback，保留尚未求值的节点。`resolve` 返回深层隔离的新值；`allow_unresolved=true` 保留缺失的必需引用，仍拒绝循环。可选缺失引用会被移除，之后补值不会恢复它。环境仍须显式传入。

`resolve_with` 仅使用给定 source 查找替换，不把其字段合入目标；同一对象作为 source 时按自身解析。两个独立解析树会重新分配节点标识，避免缓存互相污染。延迟合并与独立外部 source 的若干组合会被拒绝，此行为已与固定参考版本对照。

`get_value` 对缺失、null 或尚不能读取的值报错，并深复制返回值。已知的延迟对象标量字段可以读取；需要合并未解析低优先级对象的嵌套字段仍可能报错。严格类型 getter 和可转换 getter 均支持这些已知字段。旧 `get`/`get_path` 是原始结构访问，旧 `has_path` 保留不抛错的兼容行为，不代表完整的 Java 未解析对象接口。

```javascript
import {loadFileAsync} from './tools/config.mjs';
const states = await loadFileAsync('app.conf', {
  document: true,
  probes: ['service.port'],
  steps: [
    {op: 'resolve', allowUnresolved: true},
    {op: 'with-fallback', source: 'PORT=8080'},
    {op: 'resolve'},
  ],
});
console.log(states.at(-1));
```

所有同步/异步 load 入口支持 `document:true`。返回初始状态及每步状态：`resolved`、解析完成时的 `value`，以及每条 probe 的 `{accepted,value?}`。这是一批操作的状态记录；尚未提供持久化 JavaScript Config 对象。JSON 数值遵循 JavaScript 双精度；精确数值应使用 MoonBit Value 或原有类型化读取。

步骤支持 `resolve`、`resolve-with`、`resolve-with-self`、`with-fallback`，以及现有路径/字面键编辑和包裹操作。`with-value`/`with-key-value` 可接受 JSON `value` 或未解析 HOCON `valueSource`。source 内的 include 使用主输入的文件/URL 来源；实际宿主读取共用整次加载的限额。不能同时指定普通 getters、operations 或 validation。每次最多 64 步、64 条 probe；状态 JSON 累计最多 1,000,000 UTF-16 单元。

```powershell
node tools/cli.mjs --input 'service.port=${PORT}' --document-steps examples/document-steps.json --probe service.port
```

`--document-steps FILE` 读取最多 400,000 字节 UTF-8 JSON 数组；`--probe PATH` 可重复。也可配合 `--file`、`--url`、stdin、fallback 和 `--env`。失败沿用退出码 1/2；与普通编辑、getter、验证或 `--resolved-json` 不可混用。

0.8 的独立参考检查比较 2,520 个生命周期序列的每步解析状态、已解析根值和必需值 probe，另有公开核心 API 回归及文件/HTTP/异步/CLI 检查。仍未覆盖完整的延迟 ConfigObject 容器接口、派生树共享身份、未解析 render、注释/来源和所有错误类；不据此声称已完整追平。

## MoonBit API

```moonbit
let config = @hocon.parse(
  "items=[1]\nitems+=2\nname=${name}prod\ntimeout=1.25ms",
  fallbacks=["name=base-"],
)
let name = @hocon.get_string(config, "name") // base-prod
let timeout = @hocon.get_duration(config, "timeout") // 1250000L
let json = config.to_json_string()
```

`parse` 接受 `includes : Map[String,String]`、`fallbacks : Array[String]`、`environment` 和 `source_name`。
`parse_sources` 接受带 name/content/format 的主源与回退源。format 为 hocon 或 json。新增 `object_only=true` 可要求所有主源/回退源的根都是对象；默认 false 保留核心数组解析能力。Node/CLI 配置入口总是要求对象根。
JSON 来源处理 BOM/Unicode 空白，拒绝包括转义等价名称在内的重复对象键，字符串内空白保持原值。
两者都可接入同步 `loader : (IncludeRequest) -> Result[Array[IncludeSource],String]`；请求包含 name/kind/from/required。
loader 返回的源按低优先级到高优先级合并，规范化的 name 用于 include 循环检测。核心不自行访问磁盘和网络。

已解析 Value 包括 Text、Number、Boolean、Null、List、Object；Number 保留原数字拼写。
Bare、Bound、Substitution、Reference、PathReference、Concat、DelayedMerge 是内部解析节点，正常 parse 结果不含这些节点。
0.4 新增枚举分支，穷举匹配 Value 的调用方需调整。`get_path` 接收字面组件数组；`split_path` 与 `get` 理解引号、空组件和含点键。

| API | 行为 |
|---|---|
| get_string/get_int/get_bool/get_list | 原有严格类型读取；get_int 为 32 位整数 |
| get_as_string/get_as_bool/get_as_int | 按 HOCON/Lightbend 规则转换 |
| get_long/get_double | Java 兼容数值读取，包括浮点截断、饱和和十六进制浮点字符串 |
| get_as_list | 数组或非负整数索引对象，忽略非数字键并按索引排序 |
| get_duration | 纳秒 Int64；缺省单位毫秒，支持 ns/us/ms/s/m/h/d 及英文别名 |
| get_bytes/get_memory_size | SI/IEC 内存单位；前者要求 Int64，后者返回任意精度十进制字符串 |
| get_string_list/get_bool_list/get_int_list/get_long_list/get_double_list | 逐元素转换；任一元素类型错误、null 或越界则拒绝整个读取 |
| get_duration_list | 数字元素先截断成 Int64 毫秒再转纳秒；字符串按时长解析，保留小数单位 |
| get_bytes_list/get_memory_size_list | 字符串直接作十进制单位解析，不经过单值 getter 的浮点预转换；bytes 要求 Int64 |
| get_config/get_config_list | 读取对象或对象数组；返回 Value，复制顶层 Map，不承诺深层不可变 |
| has_path/get_is_null | 区分缺失与 null；has_path 的 include_null 默认 false |

数字索引对象按数值索引排序，同一索引的多种拼写（例如 1/01/+1）合并为一个元素；普通哈希桶遍历与回退合并顺序已对照参考库。高碰撞树桶与删除后的容量历史尚未复现，Unicode 数字键的完整转换仍缺。

Double API 可返回 NaN/Infinity；JSON 桥接和 CLI 用 "NaN"/"Infinity"/"-Infinity" 表示这些非 JSON 数值。
普通 JSON 数字通过 JS 宿主会受双精度限制；需要精确长整数应使用 long getter，或直接在 MoonBit 读取 Number/Int64。

## 配置树修改与结构校验

0.7 新增 `with_value`/`without_path`/`with_only_path`、`at_path`/`at_key`、`with_key_value`/`without_key`/`with_only_key`、`with_fallback`、`copy_value`、`join_path`、`entry_set`、`is_empty`/`is_resolved`/`has_path_or_null`、`validation_problems`/`check_valid`。

路径接口理解引号及点分隔；key 接口始终把字符串作为一个字面键。设置子路径时会用对象替换中间的标量；删除保留空父对象；筛选不存在的路径返回空对象。修改、复制与 entry_set 返回值深层脱离输入的 Map/Array，调用方手动修改结果不会改变原值。Value 本身仍是可变数据结构，不能宣称 Java Config 的类型级不可变性。

`entry_set` 展开非空对象，略去 null/空对象，列表整体作为叶子；`is_empty` 则检查根对象是否有键，含 null 的对象不为空。`join_path` 按固定 JDK 22.0.1 的 BMP 字母/数字分类规范化路径；补充平面字符加引号。旧 `has_path` 保留把非法路径当作不存在的行为；新增 `has_path_or_null` 对非法路径报错。

`validation_problems(actual, reference, paths=[...])` 返回全部结构问题，含 path、kind、expected、actual；kind 为 missing、wrong-type 或 list-element。`check_valid` 在有问题时抛出携带完整数组的 ValidationFailed。两端必须已解析；限制路径在参考中不存在时忽略，重复限制保留重复问题。null/字符串 "null" 与任意类型兼容，其他字符串按官方的宽松规则处理；列表只依据参考首元素类型，不递归校验对象列表成员的字段。此校验不替代应用业务规则。

```javascript
import {loadAsync} from './tools/config.mjs';
const config = await loadAsync('service { port=80, debug=true }', {
  operations: [
    {op:'with-value', path:'service.port', value:8080},
    {op:'without-path', path:'service.debug'},
  ],
  checkValid: {source:'service.port=1', paths:['service']},
});
```

同步/异步及文件/URL 入口共用 operations 顺序列表，最多 256 步；操作名与上述 API 对应但使用连字符。with-value/with-key-value 接受 JSON `value` 或优先使用 HOCON `valueSource`；后者适合精确长整数。with-fallback 接受独立已解析的 `source`。所有操作在配置加载/解析后、checkValid 和 getter 前执行，新增的值不会重新绑定原配置替换引用。`checkValid` 的 source 在无网络的内存解析器中独立解析。`getter:'validation'` 配合 referenceSource/validationPaths 返回问题数组；`getter:'entries'` 返回路径字典，`getter:'json-text'` 返回保留数值拼写的 JSON 字符串。校验失败时 Node ConfigError.problems 在同步/异步入口均可读取。

```powershell
node tools/cli.mjs --file app.conf --set service.port 8080 --unset service.debug --validate reference.conf
node tools/cli.mjs --file app.conf --only service --at-key module --entries
```

CLI 的 --set PATH HOCON_VALUE、--unset、--only、--at-path、--at-key 按出现顺序执行；--validate FILE 通过真实文件宿主解析参考及 include，--validate-path 可重复。编辑及验证默认输出 JSON，--entries 与 --get/--type 互斥。不会写回原配置文件。树遍历上限为深度 64、每次操作 1,000,000 工作单位；路径仍限 32 组件，超限或循环的调用方数据明确拒绝。

## 解析与合并

支持布尔/null/数组/对象、JSON 转义、三引号多行文本、HOCON 空白与非引号片段、引号路径、注释。
`${path}` 保留类型；`${?missing}` 删除缺失字段或数组元素。历史值自引用和 `+=` 在合并后求值。
对象递归合并，标量/数组/null 构成覆盖屏障；三层及以上回退仍保留这些屏障。
include 中的引用优先查包含位置，再回退根路径。环境替换显式提供；null 阻止环境回退。
`${NAME[]}` 在配置缺失时读取 NAME_0、NAME_1 等环境键，遇到第一个缺失索引停止。

拼接保留标量间空白，合并对象和数组。已对齐旧版差异 `a=[1] text` 的上游宽松行为：结果为数组；引号文本仍报类型错误。
词法与语法错误提供 source、offset、line、column；offset 为从零开始的 Unicode 标量偏移，行列从一开始。
语义/解析预算错误目前只有消息，不保证全部携带源位置。

## 验证与限制

执行 `./verify.ps1 -MoonPath /absolute/path/to/moon`，检查 JS/Wasm-GC、公开 API、文件/CLI、参考向量回放和有界异常输入。
实时参考运行与证据范围见 [TESTING.md](TESTING.md)。源代码、API、编译引擎与报告 SHA256 一起保存。
这些用例证明覆盖范围内的结果一致，不代表全部 Lightbend Config API 或生产性能已经追平。

0.8 当前验证：JS/Wasm-GC 各 8,258 项，六组官方实时对照 9,128/9,128（新增 2,520 生命周期序列）；45 项新文件/HTTP/异步/CLI 检查和既有验证全部通过，81 文件再生一致。固定五进程计时中，五项新负载当前/官方耗时比为 0.435–0.556，两个旧负载相对 0.7 为 0.999 与 0.997；未发现进程中位数超过两倍的波动。完整性能、内存及长期负载仍未追平。详见 `evidence/document-upgrade.json` 和 `evidence/document-performance.json`。

0.7 历史验证：JS/Wasm-GC 各 5,730 项，官方实时对照 6,608/6,608（含 4,380 新树操作/校验案例），39 新宿主/异步/CLI 检查通过；71 个生成/源码文件再生一致。最终五进程对照中，五项新负载当前/官方耗时比为 0.416–0.722，两个旧负载相对 0.6 为 1.027 和 1.052，即约慢 2.7% 和 5.2%；未发现进程中位数超过两倍的波动。此七项有界测量不能证明生产性能或内存/持续负载追平。

0.6 历史验证：JS/Wasm-GC 各 1,347 项通过；官方库实时对照 2,228/2,228（714 配置、58 文件、1,300 集合、156 HTTP），72 项集合宿主/CLI 与 58 项 HTTP/异步/CLI 检查通过。22 个独立 JSON 来源案例同时进入双后端回归。

五进程性能结果保存在 `evidence/http-performance.json`。四项网络负载的当前/官方耗时比为 0.852–1.180，两个旧本地负载相对 0.5 为 0.995 与 1.149；若干当前网络负载的进程中位数最大/最小比超过 2，已标为不稳定测量。异步预热后的两个负载中位数为 2.106 和 5.632 毫秒。这些本机回环结果没有建立性能追平，也不用于宣称稳定加速。

资源上限：每源 100,000 UTF-16 单元；源展开预算 1,000,000；对象/数组/include 深度 32；求值深度 128、工作预算 200,000；输出深度 64、累计输出预算 1,000,000。
Node 宿主另限制单文件/响应 400,000 字节、读取累计 4,000,000 字节及 512 次文件/网络读取（含重定向），并拒绝无效 UTF-8。
数值转换文本限 10,000 单元，任意精度单位指数限 ±4096。这些限制可能拒绝上游能处理的超大输入。

仍缺 HTTP 代理/305/认证集成、JAR/classloader、JVM application/reference/system-properties 默认加载，剩余 number/object/enum 集合、完整未解析对象/共享身份、来源注释 API、保留注释的渲染与完整性能对照。
更多参考版本、平台、大配置和持续负载尚未完成；详细边界见 [FEATURES.md](FEATURES.md)。

依据 [HOCON 官方规格](https://github.com/lightbend/config/blob/main/HOCON.md)独立实现；参考库采用 [Lightbend Config 1.4.9](https://github.com/lightbend/config/releases/tag/v1.4.9)。
原创代码 MIT；Java 适配器与测试用例自行编写，上游 JAR 不在本仓库分发。没有复制上游实现或测试集。
0.5 历史增量验证：JS/Wasm-GC 各 1,323 项；1,300 新集合对照与既有 772 配置/文件对照、72 新宿主/CLI 检查。固定五进程计时中四项既有负载相对 0.4 的耗时比为 0.977–1.019；七项 JSON 请求到结果的负载相对官方库为 0.520–1.094，时长列表仍约慢 9.4%。这不代表全部性能已追平。

全部留在本地，未上传或发布；旧 20 项目合集仍为历史快照，独立增量 ZIP/bundle 绑定各自的本地提交。
