# 文档步骤文件的语法诊断

已有 CLI 可以从原始配置文件和 JSON 步骤文件执行 parse/edit/resolve，并输出完整文档状态。本次只修正步骤文件的 JSON 语法失败通道：Node 的原始 SyntaxError 消息可能带出输入片段，CLI 先前会把片段放进 stderr 的 error 字段，调用方原样存日志时就带出了步骤文件中的值。

现在仅这一类错误使用固定诊断，不附原始 cause 或输入片段：

~~~json
{"ok":false,"error":"Document steps must contain valid JSON"}
~~~

错误仍退出 1，stdout 为空。普通模式与 --json 模式一致。JSON.parse 仍是原来的解析器，没有增加格式或重写 JSON 语义；标准规定非法 JSON 抛 SyntaxError，并不要求应用转发引擎消息中的输入摘录。[ECMAScript JSON.parse](https://tc39.es/ecma262/multipage/structured-data.html#sec-json.parse)

## 原始文件与完整有效输出

main.conf：

~~~hocon
include "base.conf"
~~~

base.conf：

~~~hocon
service { port=8080, label=old }
~~~

steps.json：

~~~json
[{"op":"with-value","path":"service.label","valueSource":"\"R06_VALID_VALUE\""},{"op":"resolve"}]
~~~

~~~sh
node tools/cli.mjs --file main.conf --document-steps steps.json
~~~

完整输出仍为：

~~~json
[
  {"resolved":true,"value":{"service":{"port":8080,"label":"old"}},"probes":{}},
  {"resolved":true,"value":{"service":{"port":8080,"label":"R06_VALID_VALUE"}},"probes":{}},
  {"resolved":true,"value":{"service":{"port":8080,"label":"R06_VALID_VALUE"}},"probes":{}}
]
~~~

合法输出按请求包含实际配置值，不做打码或删字段。--json 仍使用原有 ok/output 信封；input/file/stdin 入口、步骤操作、HOCON 解析与来源位置均不变。合法 JSON 但非数组仍使用原数组错误；步骤语义或配置求值错误仍走退出 2；UTF-8 解码、400000 字节上限和 IO 失败继续走原宿主错误路径。

这不是通用脱敏承诺：配置解析/步骤语义的其它消息、路径名、命令参数、用户主动打印的原文及任意外部日志不属于这一处处理。原 Node JSON 语法消息及其中可能含有的位置描述不再直接转发；HOCON SourcePosition 的单位和字段不变。

## 实际文件接收与日志验收

~~~sh
node tools/test-document-steps-input.mjs
~~~

固定原始文本与手写预期在 tools/document-steps-input/cases.json。修复前保留了五次真实 CLI 进程的完整输入/流/数字退出码：四个畸形文件有两个将测试 canary 放入 stderr，而合法文件的完整输出已一致。

新门让真实公开 CLI 子进程读取这些配置/include 和步骤文件，调用方直接把原 stderr 字节写入 diagnostic.log，核对日志确为接收到的原流；它还保存真实状态输出，并在同一原配置/步骤路径上模拟纠正 JSON 后重试。四种语法失败、两种输出模式、完整有效状态、数组/语义/编码/IO/字节边界均有独立控制。它不把一份自造 manifest 当作执行或日志证据。

生成证据写入 output/document-steps-input 或 --evidence-dir 指定目录，上传为必要 CI 证据且不进入源码包。旧 policy JSON 的独立保护实现及所有封存不改。没有新 HTTP 接收框架、第三方采用或泛化安全认证声明；MoonBit 通用 JSON 能力本来就已存在。[MoonBit core/json](https://mooncakes.io/docs/moonbitlang/core/json)
