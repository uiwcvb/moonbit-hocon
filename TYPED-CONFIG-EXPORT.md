# 类型化配置文件交接

应用只接收 JSON 文件时，可以把原始配置和声明式字段清单交给一个入口。它只加载/求值一次本地配置栈，复用公开 Config.loadFile/get 完成全部类型读取，然后写出完整接收文件。公开 parser、getter、整树输出和旧 CLI 均已存在；新增的是带文件交付与失败合同的工作流，没有新增配置格式。

原始文件 mounted-settings 没有标准扩展名：

~~~properties
service.port=08080
service.enabled=true
service.label=你好
service.id=9007199254740993
service.secret=not-selected
~~~

将以下内容存为 app-fields.json：

~~~json
{
  "version": 1,
  "fields": [
    {"name": "listenPort", "path": "service.port", "type": "int"},
    {"name": "enabled", "path": "service.enabled", "type": "boolean"},
    {"name": "banner", "path": "service.label", "type": "string"},
    {"name": "deploymentId", "path": "service.id", "type": "long"}
  ]
}
~~~

~~~sh
node tools/typed-config-export.mjs --file mounted-settings --format properties --queries app-fields.json --output app-settings.json
~~~

app-settings.json 是一个 UTF-8 JSON 对象及换行：

~~~json
{"listenPort":8080,"enabled":true,"banner":"你好","deploymentId":"9007199254740993"}
~~~

输出只含声明的字面名称；名称中的点不会构造嵌套对象。long 使用既有 getter 的精确十进制字符串，不能经 JS Number 中转。其他三种类型沿用现有 string/boolean/int 读取语义，包括原有转换及拒绝条件。Long 的既有饱和转换也保留：某些超界数值字符串会得到 Long 边界值，本工具不会额外变成拒绝。

公开 Node 接口：

~~~javascript
import {exportTypedConfigFile, ConfigExportError} from './tools/typed-config-export.mjs';
const receipt = exportTypedConfigFile({
  file: 'mounted-settings', format: 'properties',
  queries: 'app-fields.json', output: 'app-settings.json',
  fallbackFiles: ['defaults.conf'],
});
// receipt: absolute output path, field count and written byte count
~~~

version 必须为 1；fields 为 1..64 项，每项只含 name/path/type，name 是唯一非空字符串，path 使用已有 HOCON 路径语法，type 为 string/boolean/int/long。查询文件最大 400000 字节，必须是有效 UTF-8 JSON。没有可选字段、默认值、表达式、通配符、集合或嵌套输出构造；根对象也只接收 version/fields。

format 可为 hocon/json/properties；省略时沿用原扩展名推断。重复 --fallback 添加低优先级本地文件，fallback 使用自己的语法。现有本地 include 和来源/读取预算保留；此入口关闭 HTTP(S) 读取且不隐式导入进程环境，未增加 URL 输入。旧通用 tools/cli.mjs 的参数、默认输出与退出码保持不变。

## 交付和失败

所有声明验证、源求值和类型读取完成后才写目标。源解析/求值、字段缺失/错误类型、查询声明失败时，已有目标保持字节不变，未存在的目标不创建。写出前保护主源、查询、显式 fallback 和实际读取的 include，检查路径、已解析父目录以及已有文件身份，拒绝相同路径、符号链接父目录和硬链接别名。

退出 0 表示写出完整文件；成功 stdout 为只含结果路径、字段数和字节数的 JSON 回执。退出 2 表示配置解析/解码/求值/类型失败；退出 1 表示声明/参数或宿主 IO 失败，stderr 为 JSON 诊断。公开 API 抛 ConfigExportError，其 exitCode 使用相同类别；可用来源位置沿用原单位。

目标父目录必须已存在。最后一次安全检查之后使用普通文件写入：磁盘满、设备或其他写入故障可能留下部分文件；并发路径/文件变动也不受锁保护。这里不提供崩溃原子性、断电持久性、跨进程事务、签名或通用脱敏保证。接收方只能在导出进程退出 0 后启动。

## 真实文件接收方

examples/config-file-receiver.mjs 是独立的自编应用，只接受一个 JSON 文件路径，导入标准 Node 模块；它不导入 HOCON，不读取源配置或字段清单。它验证 listenPort/enabled/banner/deploymentId 四个字段和端口范围，用配置端口监听回环 HTTP，并在响应里使用这些配置值：

~~~sh
node examples/config-file-receiver.mjs app-settings.json
~~~

启动成功后输出 ready 和实际 URL。运行端口为 0 的固定样例时，操作系统分配回环端口；响应里的 configuredPort 仍为 0，Long 标识保持字符串。这是文件工作流示例，不代表外部采用或部署；它不提供迁移批准或业务值有效性的一般保证。

## 有限验收

~~~sh
node tools/test-typed-config-export.mjs
~~~

独立手写原始文件和预期位于 tools/typed-config-export/cases.json。脚本通过公开 API 和独立 CLI 进程覆盖三个既有格式、默认推断、include/fallback、字面输出名、字段/字节边界、合法值与错误交付、输入路径别名保护，再把真实产物复制到没有源文件或查询的目录，启动只接收产物路径的进程并核对实际 HTTP 响应。失败导出不会启动接收方。原始 stdout/stderr、输入、产物和回执写入 output/typed-config-export，或 --evidence-dir 指定的新目录；该生成目录不进入源码分发包。

compatibility.json 保留一次明确的预期纠正：初始新手写样例误把超界 Long 当成拒绝，封存的未修改 Config 1.4.9 独立参考已规定其饱和结果。原始输入/错误预期保留，同一输入在验收中按该独立参考作为合法控制，未改 getter、旧参考或合法输入。原开发失败证据随本阶段报告保留。验收脚本加入必要 CI；这些有限案例不声称穷尽全部格式或证明第三方采用。
