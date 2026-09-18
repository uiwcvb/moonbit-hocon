# HOCON 配置解析器

MoonBit 本地 0.18.0：直接数值扫描和长系数区间转换、极小十进制数精确转换优化、浮点文本渲染优化、原始值的 JSON/HOCON 文本与缩进渲染、直接值遍历和不可变包装哈希缓存、不可变 ConfigValue / ConfigObject / ConfigList、持久化不可变 JavaScript Config、类型化配置、历史值自引用、`+=`、include 重定位、显式回退与环境替换、未解析文档/分阶段解析、数字/对象/通用值/枚举及类型化列表读取、日历周期和指定时间单位、配置树修改与校验、文件/HTTP(S) 加载、可取消异步入口和 CLI。
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

## 不可变配置值与容器（0.13）

`Config.root()` 返回 `ConfigObject`，`getValue(path)` 返回 `ConfigValue`；`getObject`、`getList`、`getObjectList` 分别返回对象、列表及对象包装数组。根的 `toConfig()` 返回原 Config，转换保留显式环境。

**0.12 迁移：**原 `getObject` / `getList` / `getObjectList` 的普通 JavaScript 数据行为改名为 `getObjectData` / `getListData` / `getObjectListData`。也可调用包装的 `unwrapped()`。通用 `get(path,{type})`、模块级 `load`、CLI 及类型化数值读取继续返回原有数据格式。

```javascript
import {Config, ConfigValue} from './tools/config.mjs';
const config = Config.parse('service={port=8080,host=${HOST}}', {
  environment: {HOST: 'localhost'},
});
const service = config.getObject('service');
const changed = service.withValue('port', ConfigValue.fromAnyRef(9000));
console.log(changed.toConfig().resolve().toJSON());
const ports = ConfigValue.parse('[8080,9000,8080]');
console.log(ports.lastIndexOf(ConfigValue.fromAnyRef(8080))); // 2
```

值提供 `valueType`、`unwrapped`、`equals`、`hashCode`、`withFallback`、`atKey`、`atPath`。`ConfigValue.parse` 保留 HOCON 原始数值与引用；`fromAnyRef` 接收 JSON 数据。数值比较和哈希保留 Int64 的全部位，并忽略原始数字拼写。普通 `unwrapped` 数字仍受 JavaScript 双精度约束，精确读取使用 Config 的 `getLong` / `getNumber`。

对象的 `get`、`containsKey`、`withValue`、`withOnlyKey`、`withoutKey` 接收字面键。`get` 缺失返回 JS null；存在的配置 null 返回可调用 `valueType()` 的包装。路径读取 `getValue` 拒绝缺失/null。`getValue` 可保留已知类型的延迟对象；该对象的 Map 读取仍报未解析错误，`toConfig` 的路径读取可以访问原版允许的已知成员。

对象/列表提供 `size`、`isEmpty`、`values` 和迭代器；对象另有 `keySet`、`entrySet`、`containsValue`，列表另有 `get`、`contains`、`indexOf`、`lastIndexOf`、`subList`。返回的容器视图数组冻结，`unwrapped` 深复制普通数据，原地修改方法拒绝执行。对象 `values()` 复现固定原版使用 HashSet 去除相等值的行为。原版标量与未解析值的比较有方向性：某些标量 `equals(未解析值)` 抛错，反方向返回 false，本实现也保留这一行为。

对象经过非对象回退后，会保留“忽略之后回退”的状态，即使再嵌入其他对象、编辑、复制、解析或经过 Worker 传递。MoonBit 的新增 `SealedObject` 枚举分支保存此状态；下游穷尽匹配 `Value` 的代码需加入该分支。公共 `value_with_fallback`、`object_get`、`list_get` 与复制/编辑接口保持输入和输出的可变 Map/Array 隔离。

原生 Map/Set 的高碰撞树桶及删除后容量历史、所有容器共享身份、渲染/来源、完整 JVM 工厂与生态仍未追平；集合遍历顺序不作为跨 JDK 保证。当前 `Config.entrySet()` 保持先前的普通叶值数据接口。

新增独立对照可运行 `node tools/test-value-reference.mjs --golden`；设置 `HOCON_REFERENCE_JAR` 为未修改的 1.4.9 JAR 后，去掉 `--golden` 则实时比较。`tools/generate-value-tests.mjs` 把其中 1,827 个值比较/回退程序生成到 MoonBit 双后端测试（29 个测试分组）；另外 983 个容器程序在 JS 宿主对照，全部 2,810 个程序也经过异步初始加载回放。

## 数字、对象、通用值和枚举读取

0.9 新增 `get_number`/`get_number_list`、`get_object`/`get_object_list`、`get_any_ref`/`get_any_ref_list`、`get_enum`/`get_enum_list`。Node/CLI 的 getter 名为 number、number-list、object、object-list、any-ref、any-ref-list、enum、enum-list。

`ConfigNumber` 区分 `Integer(Int)`、`Long(Int64)`、`Floating(Double)`；例如原始 `1` 为 Integer，字符串 `"1"` 转换为 Long，字符串 `"1.0"` 转换为 Floating。其 JSON 表示带 `kind`：整数的 `value` 是精确十进制字符串；浮点的 `value` 为 JSON 数字或 NaN/Infinity/-Infinity/-0.0 字符串，并附带十进制 `bits` 保存 IEEE-754 位模式。NaN 使用规范位模式。

`get_object` 返回深复制的 `Map[String,Value]`；对象列表也深复制每层。`get_any_ref` 返回深复制的 Value，拒绝内部尚未解析的引用；通用列表允许 null 元素，但顶层缺失/null 仍拒绝。Value 保留数字原文；通用 Node JSON 数值仍受双精度约束，需精确数字类型时使用 number/number-list。

```moonbit
let config = @hocon.parse("mode=FAST\nvalues=[1,\"2\",1.5]")
let selected = @hocon.get_enum(config, "mode", { "FAST": 1, "SAFE": 2 })
let numbers = @hocon.get_number_list(config, "values")
```

枚举 API 接受 `Map[String,T]`，可返回调用方自定义的 MoonBit 枚举；名字区分大小写、不自动去掉空白。Node 使用 `enumChoices` 字符串数组；CLI 重复指定 `--enum-choice`。最多 1,024 个不重复名字、累计 100,000 UTF-16 单元；没有匹配值时报错。

```powershell
node tools/cli.mjs --input 'mode=FAST' --get mode --type enum --enum-choice FAST --enum-choice SAFE
node tools/cli.mjs --input 'values=[1,"2",1.5]' --get values --type number-list
```

数字字符串及数字索引对象支持 JDK 22.0.1 的 37 个 BMP 十进制数字块；补充平面字符按 Java UTF-16 char 整数解析规则拒绝。纯整数字面量超出 Int64 后，HOCON 将其作为文本、JSON 来源拒绝；JSON 数字原始拼写保留到 Value，避免丢失指数/整数类型信息。数据由本地 JDK 生成，其他 JDK Unicode 版本仍需独立验证。

## 日历周期与时间单位

0.10 新增 `get_period`、`get_temporal`、`get_duration_in`、`get_duration_list_in`，以及 `get_milliseconds`/`get_nanoseconds` 和对应列表别名。`DurationUnit` 的七个选项为 Nanoseconds、Microseconds、Milliseconds、Seconds、Minutes、Hours、Days。

`get_period` 返回 `ConfigPeriod { years, months, days }`：默认单位是天，支持 d/day/days、w/week/weeks、m/mo/month/months、y/year/years，区分大小写。只接受 Int32 整数，周乘以 7 后也检查 Int32 范围；12 months 保持 months=12，不自动归一年。周期字段支持固定 JDK 的 BMP 十进制数字。

`get_temporal` 优先解析时长，失败再尝试日历周期；因此 `2m` 是两分钟，`2mo` 是两个月，无单位数字是毫秒。返回 `TemporalAmount::Duration(Int64)` 或 `Period(ConfigPeriod)`；Node/CLI 输出带 `kind` 的对象，时长使用精确 `nanoseconds` 字符串，周期使用 years/months/days 数字字段。

指定单位的时长结果向零截断。标量和字符串列表元素先解析为有饱和上限的 Int64 纳秒，再转目标单位；数字列表元素直接从整毫秒转目标单位。例如数字列表元素 9223372036854775807 读取毫秒可保留原值，同内容的字符串元素则先受纳秒上限约束。这与标量/列表的参考语义一致。

```moonbit
let config = @hocon.parse("calendar=12months\ntimeout=1.5s")
let calendar = @hocon.get_period(config, "calendar") // months=12
let millis = @hocon.get_duration_in(config, "timeout", @hocon.Milliseconds) // 1500L
```

```powershell
node tools/cli.mjs --input 'calendar=12months' --get calendar --type period
node tools/cli.mjs --input 'timeout=1.5s' --get timeout --type duration-in --time-unit milliseconds
```

Node getter 名为 period、temporal、duration-in、duration-list-in、milliseconds、nanoseconds、milliseconds-list、nanoseconds-list。指定单位的两个 getter 必须提供 `unit`，名称为上述七个枚举名字的全小写形式；CLI 使用 `--time-unit`。新接口共用既有数量字符串 10,000 单元上限，不提供日历运算、日期时区或完整 Java 时间对象。

## 持久化 JavaScript Config

0.11 的 `Config` 保存实际 MoonBit 配置树；构造后可反复读取、派生和解析，不重新读取源文件。`parse` 保留未解析节点，`load` 立即解析；`parseFile`/`loadFile`、`parseURL`/`loadURL` 及六个对应 `Async` 工厂返回相同的不可变接口。工厂沿用显式环境、include、fallback 和文件／网络预算。

```javascript
import {Config} from './tools/config.mjs';
const raw = Config.parse('service.port=${PORT}');
const ready = raw.withFallback(Config.parse('PORT=8080')).resolve();
const service = ready.getConfig('service');
console.log(service.getInt('port')); // 8080
console.log(raw.isResolved()); // false，原配置保持不变
const remote = await Config.loadURLAsync('https://config.example/app.conf', {
  signal: AbortSignal.timeout(10000),
});
```

支持现有标量／列表类型读取、`getConfig`/`getConfigList`、`getEnum(path, choices)`、`getDuration(path, unit?)`、`hasPath`/`hasPathOrNull`、`getIsNull`、`entrySet`、`isEmpty` 和 `isResolved`。`get(path, {type, unit?, enumChoices?})` 提供通用入口；指定时间单位使用全小写名称。Long、时长、内存量通过十进制字符串保持精确，`getNumber` 保留类型及位模式；`getDouble`/`getDoubleList` 保留 JavaScript 负零，非有限值使用字符串。普通 JSON 数字仍有双精度限制。

`resolve`/`resolveWith`、`withFallback`、`withValue`、`withoutPath`/`withOnlyPath`、`atPath`/`atKey` 和字面键筛选返回新对象。`withValue` 接受 JSON 值，`withValueSource` 接受精确 HOCON 值文本，`withValueFrom(path, other, valuePath)` 从另一配置转移值。`checkValid(reference, ...paths)` 成功返回自身；`validationProblems` 返回问题数组。环境在工厂或显式 resolve 时取快照，不会隐式读取进程环境。

实例冻结，返回的普通对象／数组可独立修改；子配置只能经不可变接口访问，内部可安全共享只读节点。核心 MoonBit `get_config` 返回防御性深复制，避免暴露可变 Map/Array。没有必须手工释放的全局句柄表，废弃实例由垃圾回收器管理。

异步工厂通过内部带标签的树编码跨 Worker，重建未解析替换、绑定、延迟合并和数字拼写；传输限 4,000,000 单元／编码字符及 64 层。该编码是版本化内部协议，不承诺跨版本存档兼容。Config 派生链不受旧批处理的 64 步上限限制，仍受解析、树深度、求值和输出预算约束。

`toJSON` 和 `render` 仅输出已解析值／JSON 文本。0.13 已加入值和容器包装；未解析渲染、注释／来源 API 和原生 Java 的全部共享身份语义仍未提供。原有 `load` 和 `document:true` 批处理入口继续可用。

## 直接读取与 API 路径规则

0.12 的 Config 类型读取直接传递普通 JavaScript 值，减少返回值的 JSON 编解码；错误继续通过同一个 ConfigError 暴露位置或校验信息。转换不依赖编译器生成的联合类型布局，普通对象具有独立、可写的自有数据属性，含 `__proto__` 等键也保持为数据。精确整数字符串、Number 标签／位模式、Double 负零和非有限值约定保持一致。

普通 ASCII 点路径可直接拆分，带引号、空段、Unicode 等继续走完整解析；每次返回独立数组，32 层和 100,000 单元上限仍有效。API 路径中的未加引号注释会拒绝，例如 getInt('a#comment')；读取字面键需加引号。配置文件中的注释仍有效。固定原版的特殊行为也保留：首尾换行仅在简单的非数字路径语法中可接受，带引号／数字／Unicode 路径不会因此统一去掉换行。

独立 ConfigUtil.splitPath 对照覆盖 1,898 个路径，包括每个 ASCII 字符、Unicode 空白、引号／拼接／空段、注释、数字拼写及 1–32 层。它同时进入 JS/Wasm-GC 的公开 API 回归。这些检查不代表所有诊断文本、超预算输入或完整 ConfigObject/ConfigValue 功能已追平。

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

所有同步/异步 load 入口支持 `document:true`。返回初始状态及每步状态：`resolved`、解析完成时的 `value`，以及每条 probe 的 `{accepted,value?}`。这是一批操作的状态记录；需要持续读取和派生时使用上面的 Config 接口。JSON 数值遵循 JavaScript 双精度；精确数值应使用 MoonBit Value 或原有类型化读取。

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

0.14 优化值读取、比较、哈希与列表/对象查找：普通容器由 MoonBit 直接遍历，查找一次跨宿主调用完成，读取不再为同一不可变值复制整棵树。JavaScript 包装缓存成功的哈希；公开 MoonBit 可变 Value 每次重新计算，调用方修改不会读到旧缓存。保留比较方向、未解析值拒绝、短路顺序和资源限制。新增 906 个独立原版遍历程序（936 次矩阵执行）、8 项宿主检查及可变值/循环数据回归。最终验证与性能记录见 evidence/value-walk-upgrade.json、evidence/value-walk-performance.json。

0.15 当前验证：JS/Wasm-GC 各 16,228 项通过；2,140 个独立原版渲染程序逐字一致，进入 34 个双后端分组，全部异步回放一致；3 个公开核心回归、17 项新宿主检查和全部既有强制验证通过。14 组实时对照共 30,550 次，包含既有重复覆盖，不能全计为新独立案例。172 文件再生一致。五进程计时中六项渲染负载当前/原版耗时比为 1.740–44.265；十六项旧负载相对 0.14 为 0.972–1.096。最大进程中位数波动比 2.246，不稳定标记 true。完整性能仍未追平。 当前报告为 evidence/render-upgrade.json 与 evidence/render-performance.json。

0.14 历史验证：JS/Wasm-GC 各 16,191 项通过；906 个新增独立遍历程序共执行 936/936 次原版矩阵对照，进入 15 个双后端分组；空/单元素列表的位置矩阵含 30 次重复请求，不重复计作独立案例。2 个可变值/循环数据回归和 8 项新增宿主检查通过。13 组实时原版对照共 28,410 次全部通过，其中 7,063 直接读取复核含 7,033 既有请求重叠；异步仍回放既有 2,810 值程序与 842 持久化程序，不计为新案例。159 文件再生一致，全部强制验证通过。五进程最终测量中，值读取、首次哈希、对象比较、列表查找相对 0.13 中位耗时分别减少 45.2%、66.2%、52.1%、87.7%，当前/原版耗时比分别为 4.775、3.249、9.027、16.933；缓存后重复哈希当前/原版为 0.010，不代表首次哈希。十项旧负载相对 0.13 为 0.919–1.073；最大进程中位数波动比 1.795，不稳定标记为 false。完整性能仍未追平。 该版报告为 evidence/value-walk-performance.json 与 evidence/value-walk-upgrade.json。

0.13 历史验证：JS/Wasm-GC 各 16,174 项；新增原版值/容器程序 2,810/2,810，其中 1,827 个相等/哈希/回退程序进入 29 个双后端分组，全部程序异步初始加载回放一致，22 项新宿主检查通过。既有 17,601 次原版对照及另 7,063 次直接读取复核通过；后者复用 7,033 旧请求并增加 30 根数字请求，不计作全新独立用例。150 文件再生一致，全部必需验证通过。五进程计时中，五项新增值/容器负载当前/原版中位耗时比为 3.499–69.916，列表查找约 69.9 倍、对象相等比较约 17.5 倍，是明确的后续优化缺口；十项既有负载相对 0.12 为 0.941–1.052。进程中位数最大/最小比最高 1.564，不稳定标记为 false。完整性能仍未追平。该版报告为 evidence/value-performance.json 与 evidence/value-upgrade.json。

0.12 历史验证：JS/Wasm-GC 各 16,143 项；十组既有/路径原版对照 17,601/17,601，另 7,063 次直接读取通道复核（其中 7,033 请求与既有套件重叠，另有 30 个根数字案例）。24 项新传输检查及既有门禁通过，135 文件再生一致。最终五进程测量中，普通整数和子配置读取相对 0.11 中位耗时分别减少 69.3%、68.6%；八项持久化负载当前/原版耗时比为 0.596–3.595，批量修改相对 0.11 为 0.682。两个旧解析负载相对 0.11 为 0.899、0.953；进程中位数最大/最小比最高 1.336，未触发两倍波动标记。完整性能仍未追平，详见 evidence/native-read-performance.json 和 evidence/native-read-upgrade.json。

0.11 历史验证：JS/Wasm-GC 各 14,244 项；九组官方实时对照 15,703/15,703（含 842 组持久化程序）；842 组异步回放、54 项新宿主检查及既有门禁通过，123 文件再生一致。受控 GC 检查回收 2399/2,400 个废弃实例，保留实例仍可读取，最大回收后堆增长约 0.73 MiB；不代表峰值或长期内存追平。五进程计时中六项新负载当前/官方耗时比为 1.003–8.576，两个旧负载相对 0.10 为 0.986、0.978。进程中位数最大/最小比最高 1.415，未触发两倍波动标记；完整性能仍未追平。最终结果及清单见 `evidence/persistent-performance.json` 和 `evidence/persistent-upgrade.json`。

0.10 历史验证：JS/Wasm-GC 各 14,001 项；八组官方实时对照 14,861/14,861（新增 2,171 个时间接口案例）；57 项新文件/HTTP/异步/CLI 检查及既有门禁通过，104 文件再生一致。最终五进程计时中新负载当前/官方中位耗时比为 0.271–1.267，两个旧负载相对 0.9 为 1.007 与 1.021。大整数毫秒列表仍比官方慢约 26.7%；进程中位数最大/最小比最高 1.783，本轮未触发两倍波动标记。初测保存在 `evidence/temporal-performance-initial.json`，最终结果及完整清单见 `evidence/temporal-performance.json` 和 `evidence/temporal-upgrade.json`；完整性能仍未追平。

0.9 历史验证：JS/Wasm-GC 各 11,827 项，七组官方实时对照 12,690/12,690（新增 3,562 扩展读取案例），55 项新文件/HTTP/异步/CLI 检查及既有门禁通过；94 文件再生一致。最终固定五进程计时中，六项新负载当前/官方中位耗时比为 0.372–0.907，两个旧负载相对 0.8 为 1.057 与 1.048（约慢 5.7% 和 4.8%）。进程中位数最大/最小比最高 2.636，报告标记测量不稳定；不据此建立完整性能追平。开发阶段的三份计时结果也保留，最终代码使用 `evidence/accessor-performance.json`，完整清单见 `evidence/accessor-upgrade.json`。

0.8 历史验证：JS/Wasm-GC 各 8,258 项，六组官方实时对照 9,128/9,128（新增 2,520 生命周期序列）；45 项新文件/HTTP/异步/CLI 检查和既有验证全部通过，81 文件再生一致。固定五进程计时中，五项新负载当前/官方耗时比为 0.435–0.556，两个旧负载相对 0.7 为 0.999 与 0.997；未发现进程中位数超过两倍的波动。完整性能、内存及长期负载仍未追平。详见 `evidence/document-upgrade.json` 和 `evidence/document-performance.json`。

0.7 历史验证：JS/Wasm-GC 各 5,730 项，官方实时对照 6,608/6,608（含 4,380 新树操作/校验案例），39 新宿主/异步/CLI 检查通过；71 个生成/源码文件再生一致。最终五进程对照中，五项新负载当前/官方耗时比为 0.416–0.722，两个旧负载相对 0.6 为 1.027 和 1.052，即约慢 2.7% 和 5.2%；未发现进程中位数超过两倍的波动。此七项有界测量不能证明生产性能或内存/持续负载追平。

0.6 历史验证：JS/Wasm-GC 各 1,347 项通过；官方库实时对照 2,228/2,228（714 配置、58 文件、1,300 集合、156 HTTP），72 项集合宿主/CLI 与 58 项 HTTP/异步/CLI 检查通过。22 个独立 JSON 来源案例同时进入双后端回归。

五进程性能结果保存在 `evidence/http-performance.json`。四项网络负载的当前/官方耗时比为 0.852–1.180，两个旧本地负载相对 0.5 为 0.995 与 1.149；若干当前网络负载的进程中位数最大/最小比超过 2，已标为不稳定测量。异步预热后的两个负载中位数为 2.106 和 5.632 毫秒。这些本机回环结果没有建立性能追平，也不用于宣称稳定加速。

资源上限：每源 100,000 UTF-16 单元；源展开预算 1,000,000；对象/数组/include 深度 32；求值深度 128、工作预算 200,000；输出深度 64、累计输出预算 1,000,000。
Node 宿主另限制单文件/响应 400,000 字节、读取累计 4,000,000 字节及 512 次文件/网络读取（含重定向），并拒绝无效 UTF-8。
数值转换文本限 10,000 单元，任意精度单位指数限 ±4096。这些限制可能拒绝上游能处理的超大输入。

仍缺 HTTP 代理/305/认证集成、JAR/classloader、JVM application/reference/system-properties 默认加载、完整未解析对象/共享身份、来源注释 API、保留注释的渲染与完整性能对照。
更多参考版本、平台、大配置和持续负载尚未完成；详细边界见 [FEATURES.md](FEATURES.md)。

依据 [HOCON 官方规格](https://github.com/lightbend/config/blob/main/HOCON.md)独立实现；参考库采用 [Lightbend Config 1.4.9](https://github.com/lightbend/config/releases/tag/v1.4.9)。
原创代码 MIT；Java 适配器与测试用例自行编写，上游 JAR 不在本仓库分发。没有复制上游实现或测试集。
0.5 历史增量验证：JS/Wasm-GC 各 1,323 项；1,300 新集合对照与既有 772 配置/文件对照、72 新宿主/CLI 检查。固定五进程计时中四项既有负载相对 0.4 的耗时比为 0.977–1.019；七项 JSON 请求到结果的负载相对官方库为 0.520–1.094，时长列表仍约慢 9.4%。这不代表全部性能已追平。

全部留在本地，未上传或发布；旧 20 项目合集仍为历史快照，独立增量 ZIP/bundle 绑定各自的本地提交。


## 原始值与格式化渲染（0.15）

```javascript
const config = Config.parse('host=${HOST}\nport=8080');
config.root().render(); // concise JSON-style text, preserving ${HOST}
config.root().render({json: false, formatted: true});
config.render({json: false, formatted: true}); // same explicit rendering options
```

核心 `render_value(value, json=true, formatted=false)` 与 JavaScript `ConfigValue.render(options)` 可输出标量、对象、列表、替换、拼接及延迟回退；按固定原版的数字键排序、浮点文本、四空格缩进和根对象规则输出。它不解析缺失替换，也不修改输入。部分解析现在合并未知回退之上的相邻已知对象。

新值接口默认精简、无注释；原版的无参数默认包含格式与来源注释，尚未对齐。已有 `Config.render()` 无参数行为仍为保留数值拼写的已解析 JSON；显式传选项才使用新值渲染。`comments:false`、`originComments:false`、`showEnvVariableValues:true` 可显式指定；启用注释/来源或隐藏环境来源值会明确拒绝，因为模型尚未保留所需元数据。来源和用户注释存储、默认渲染及环境遮罩仍属完整追平缺口。

JSON 模式的未解析替换、重复字段和非有限数字仍可能不是合法 JSON，与参考库一致；完整解析且只有有限数字的结果可交给 JSON 解析器。输出及遍历使用有界预算，拒绝循环调用方数据。新渲染不会替代既有 `to_json_string()` 的数值原始拼写行为。

0.15 核心表示迁移：`parse`/`resolve` 后的裸字符串保留 `Bare`，不会再一律转为 `Text`，以保留正确 HOCON 渲染。直接匹配 `Value` 的代码需同时处理二者；`get_string`、类型化读取、语义相等/哈希和 `value_unwrapped` 的普通字符串结果保持一致。

## 0.16 浮点渲染验证

JS/Wasm-GC 各 16,419 项通过，包含 24,254 个独立 JDK 位模式（190 个分组）及一项精确区间证明；2,140 个既有 Config 渲染程序重新实时对照并通过异步回放。完整兼容与性能目标仍未完成。

五进程计时中，普通浮点渲染相对 0.15 耗时减少 82.5%，当前/原版耗时比 7.057；次正规数与十进制幂相对 0.15 为 0.478、0.597，当前/原版为 945.942、13.106。十六项非渲染旧负载相对 0.15 为 0.918–1.042。最大进程中位数波动比 2.094，不稳定标记 true。完整性能仍未追平。

本轮证据见 [double-render-upgrade.json](evidence/double-render-upgrade.json)，完整边界见 [FEATURES.md](FEATURES.md)。

## 0.17 极小十进制数解析验证

JS/Wasm-GC 各 16,634 项通过，新增 27,505 个 JDK 解析输入（215 个分组）按位或拒绝对照；3,562 个公开数值接口及 2,140 个渲染程序重新实时对照一致。完整兼容与性能目标仍未完成。

五进程计时中，极小数渲染和极小数列表读取相对 0.16 耗时减少 97.8%、97.4%，当前/原版耗时比为 21.277、4.455；普通浮点列表读取相对 0.16 为 1.066（本次回退 6.6%），当前/原版为 25.332。长系数渲染当前/原版仍为 607.937。最大进程中位数波动比 2.217，不稳定标记 true。完整性能仍未追平。

本轮证据见 [double-parse-upgrade.json](evidence/double-parse-upgrade.json)，完整边界见 [FEATURES.md](FEATURES.md)。

## 0.18 直接数字扫描与长系数验证

JS/Wasm-GC 各 16,637 项通过，27,851 个 JDK 解析输入（218 个分组，新增 346 个输入）按位或拒绝对照；3,562 个公开数值接口及 2,140 个渲染程序重新实时对照一致。完整兼容与性能目标仍未完成。

五进程计时中，普通浮点列表读取、长极小数渲染相对 0.17 耗时减少 21.3%、96.2%，当前/原版耗时比为 20.350、18.625；长中点渲染与长引号数字读取当前/原版仍为 501.845、7.978。旧 parse-64 相对 0.17 为 1.026。最大进程中位数波动比 2.466，不稳定标记 true。完整性能仍未追平。

本轮证据见 [numeric-scan-upgrade.json](evidence/numeric-scan-upgrade.json)，完整边界见 [FEATURES.md](FEATURES.md)。
