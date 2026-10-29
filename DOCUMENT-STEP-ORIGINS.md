# 文档步骤 HOCON 的来源归属

document-steps 接受调用方 JSON 文件中的 source/valueSource HOCON 片段。以前这些独立片段一律使用主配置文件名作为来源：即使主文件没有错误引号或缺失替换，错误也可能引导维护者去修改主文件。

现在四种片段操作共用明确的逻辑来源：

| 操作 | position.source |
| --- | --- |
| resolve-with / with-fallback 的 source | <document-step[0].source> |
| with-value / with-key-value 的 valueSource | <document-step[0].valueSource> |

索引从零开始，对应引入片段的步骤；step 0 引入的表达式在 step 1 resolve 时失败，仍指向 step 0。这是逻辑 HOCON 单元名，不是磁盘文件名，也不是 steps.json 的 JSON 字节位置。

source 的坐标对应片段原文。valueSource 对应完整生成解析单元 value= 加片段：例如缺失替换直接作为 valueSource 时，美元符号在 offset 6、line 1、column 7。offset 是从零开始的 Unicode 标量，行列从一开始；前缀和非 BMP 字符都不能当成 UTF-8 字节或 UTF-16 单元计算。

## include 与原有合同

诊断名与 include 查找基准分别传递。片段顶层的相对 include 继续使用主输入的真实文件/URL来源；真实 include 子文件保留自己的来源和相对查找上下文，包括目录 classpath 的嵌套资源。不会因逻辑来源名转而读取 cwd 下的同名诱饵文件。

主配置、真实子文件的错误位置不变。有效输入、顺序操作、全部状态和 probes、JSON 双精度政策、既有精确数值 getter、资源预算、原 public 类型及 CLI 0/1/2 通道保持。只对片段原先误归主文件的来源标签和对应错误文本作有意改变。

这项修复不提供原文无损编辑、所有异常位置保证、新格式/getter/loader、通用脱敏、部分状态流或并发原子保证。R06 的步骤文件 JSON 语法摘录保护仍由原独立门检查。

## 有限真实接入回归

~~~sh
node tools/test-document-step-origins.mjs
~~~

固定输入与手写预期在 tools/document-step-origins/cases.json。未改产品首先执行了 11 组完整输入：22 次公开同步/Worker调用中，六组片段错误共 12 次冠以主文件名；标量偏移与行列符合独立预期。13 次真实 CLI 和一个自有 HTTP fixture 进程的原流、退出/信号及正确值对照保留在本轮报告，没有重生成旧生命周期参考。

新门核对四种片段语法错误、step 0 到后续 resolve 的来源、Unicode 标量位置、主文件/真实子文件原来源；文件与回环 URL 都读取实际 include，区分 extra=4 的正确资源与 extra=99 的错误基准。文件恢复保留坏步骤原文与日志，纠正同一路径后接收完整四状态及全部 probes。classpath 用真实嵌套子资源对照，保持原元数据查找。

所有实际 CLI 和 fixture 子进程记录 PID、参数、cwd、真实退出/信号及完整 stdout/stderr；调用方保存收到的原 stdout 日志和完整状态文件。公开 API 调用作为同一消费进程内的调用记录，不伪装成各自的独立进程。生成证据写入 output/document-step-origins 或 --evidence-dir，下游 CI 上传该目录并从分发包排除。

必要 gate 是 Check document-step fragment origins。它使用实际 fresh compiled engine；源、编译、运行输入和结果分别记录身份。自编回环 fixture 是受影响链路的执行证据，不代表第三方采用、发布或远程 artifact 二进制下载核验。
