# HOCON 配置解析器

MoonBit 本地 0.4.0：类型化配置、历史值自引用、`+=`、include 重定位、显式回退与环境替换、单位读取，以及真实文件加载和 CLI。
解析和求值均由 MoonBit 实现；Node 仅提供文件、properties 和命令行宿主。Java 只用于独立参考测试。

## 命令行与文件

```powershell
node tools/cli.mjs --input 'port=8080' --resolved-json
node tools/cli.mjs --file app.conf --fallback defaults.conf --env --resolved-json
node tools/cli.mjs --file app.conf --get service.timeout --type duration
node tools/cli.mjs --file app.conf --classpath ./resources --resolved-json --json
```

`--fallback` 可重复，越早指定优先级越高；主配置优先级最高。各文件的 include 相对来源文件解析。
`--env` 显式启用当前进程环境，默认不读取。classpath 接收目录，首个目录优先。
`--resolved-json` 输出最终 JSON；默认输出值类型调试展示；`--json` 保留 `{ok,output}` 结果信封。
`--get` 接受带引号路径，`--type` 支持 value/string/boolean/int/long/double/duration/bytes/memory/list/has/null。
long、duration、bytes、memory 的 CLI 结果为精确十进制字符串；duration 单位为纳秒。
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

宿主支持本地文件、file: URL、目录 classpath；普通缺失 include 为空，required 缺失时报错。
不带已知扩展名的 include 搜索 `.properties`、`.json`、`.conf`，依此顺序合并。
`file(...)` 相对 cwd，`classpath(...)` 相对资源根；普通 `include "..."` 相对来源。
properties 支持转义、续行、点路径及冲突时对象优先，所有值保持字符串。JSON 来源的键是字面键，不解释替换。

兼容性细节：Lightbend 1.4.9 的普通启发式 include 在直接指定 `.json`/`.properties` 文件时会继承 HOCON 语法；本宿主复现此行为。
需要按扩展名读取其原格式时，使用不带扩展名的搜索、显式 `file(...)`，或把该文件作为加载入口。
文件语法/优先级的实际参考结果保存在 `evidence/file-reference-vectors.json`，不是只根据扩展名推断。

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
`parse_sources` 接受带 name/content/format 的主源与回退源。format 为 hocon 或 json。
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
| has_path/get_is_null | 区分缺失与 null；has_path 的 include_null 默认 false |

Double API 可返回 NaN/Infinity；JSON 桥接和 CLI 用 "NaN"/"Infinity"/"-Infinity" 表示这些非 JSON 数值。
普通 JSON 数字通过 JS 宿主会受双精度限制；需要精确长整数应使用 long getter，或直接在 MoonBit 读取 Number/Int64。

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

资源上限：每源 100,000 UTF-16 单元；源展开预算 1,000,000；对象/数组/include 深度 32；求值深度 128、工作预算 200,000；输出深度 64、累计输出预算 1,000,000。
Node 宿主另限制单文件 400,000 字节、读取累计 4,000,000 字节及 512 次文件读取，并拒绝无效 UTF-8。
数值转换文本限 10,000 单元，任意精度单位指数限 ±4096。这些限制可能拒绝上游能处理的超大输入。

仍缺 HTTP(S) include、JAR/classloader、JVM application/reference/system-properties 默认加载，完整 typed-list/object/checkValid/编辑/来源注释 API、保留注释的渲染与端到端性能对照。
更多参考版本、平台、大配置和持续负载尚未完成；详细边界见 [FEATURES.md](FEATURES.md)。

依据 [HOCON 官方规格](https://github.com/lightbend/config/blob/main/HOCON.md)独立实现；参考库采用 [Lightbend Config 1.4.9](https://github.com/lightbend/config/releases/tag/v1.4.9)。
原创代码 MIT；Java 适配器与测试用例自行编写，上游 JAR 不在本仓库分发。没有复制上游实现或测试集。
全部留在本地，未上传或发布；旧 ZIP/bundle 为历史快照，本轮未重打包。
