# MoonBit HOCON：配置解析与迁移审查库

- 申报账号：**uiwcvb**
- 实际模块：**uiwcvb/hocon**
- 项目仓库：[uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)
源码版本：**0.25.0**｜核心许可证：**MIT**

## 项目用途

项目面向保留既有 HOCON 配置的 MoonBit 应用开发者和配置维护者，提供从读取配置、求值得到生效树，到审查变更并交给应用的完整工具链。include、替换引用和多层 fallback 可以共同决定最终值；本项目按生效配置审查变化，能发现只读文本差异容易遗漏的引用联动和子文件改动。

应用可以直接使用解析与类型读取，也可以在启动前限定允许变化的路径、类别和具体旧值/目标值。它适用于需要 HOCON 兼容和配置迁移审查的场景。

## 已实现的功能

| 能力 | 项目提供的行为 |
| --- | --- |
| 配置解析与来源加载 | MoonBit 核心解析字符串、数字、布尔、null、列表、对象、注释、拼接和替换。Node 宿主读取 HOCON、JSON、properties 文件及 HTTP(S)/file URL，支持显式格式、include、目录 classpath、fallback 与显式环境。 |
| 未求值树与不可变编辑 | 可以先解析并保留引用，再依次增删、筛选、包裹、追加 fallback 和 resolve。Config/Value/Object/List 提供派生对象，配置条目集合可独立修改，不改变原配置树。 |
| 类型与精确数字 | 提供标量、列表、子配置、固定时长、日历时间和容量读取。数字比较保留精度，区分超过 2^53 的相邻整数；Long 在 Node 类型化接口中使用十进制字符串，固定时长与年/月分开处理。 |
| 验证、渲染与诊断 | 参考配置验证可汇总缺失/类型问题并限制路径。值可输出 HOCON/JSON；解析错误及带来源的缺失/循环替换提供位置，步骤片段保留引入步骤的逻辑来源，实际子文件保留自己的来源。 |
| TypeScript 源码接入 | Node ESM 公共入口带相邻声明，覆盖现有对象、工厂、选项、审查报告和错误。精确整数/时长保留字符串，动态结果使用 unknown；固定严格 NodeNext 消费者编译后实际执行同步/Worker 文件成功与错误路径。 |
| 生效差异与变更许可 | diff_resolved_configs 和 review_config_changes 比较最终树，规则按字面路径和增删改类别匹配；列表整体比较，缺失与 null 不同，报告不输出实际配置值。 |
| 具体值绑定的迁移计划 | review_config_transition 同时核对旧值、目标值和完整变化集，拒绝过期基线、错误目标、遗漏变化及未发生的计划。引用产生的间接变化也须获准。 |
| 预览与应用接入 | 文件审查可生成绑定规则、实际读取文件和有序输入的预览指纹。示例支持不监听地检查字段，再使用调用方确认的哈希启动本地服务。 |
| 类型化文件交接 | 读取原配置及字段清单，将 string/boolean/int/long 所选字段交付为 JSON 文件；声明或配置读取失败保留旧产物，并保护输入路径别名。独立示例应用只接收产物文件。 |

文档步骤入口返回初始状态及每一步完整的 resolved/value/probes，支持同步、Worker 异步和 CLI。其 JSON 数值沿用 JavaScript 双精度；需要精确值时使用 MoonBit Value 或类型化 getter。目录资源按 conf 高于 json 高于 properties 合并，同名资源内保留目录优先级。

## 实现与使用

词法、解析、替换求值、不可变树、类型读取、精确比较和迁移审查由 MoonBit 实现，JS 与 Wasm-GC 共用核心。Node 负责文件/网络、CLI、异步宿主、指纹和应用示例。Java 用于固定参考实现的独立对照，Node 应用运行不要求 JVM。

MoonBit 消费包导入模块 uiwcvb/hocon；公共签名见 [生成接口](pkg.generated.mbti)。Node 从仓库源码导入 tools/config.mjs；TypeScript 使用同一路径及相邻声明，接入与固定编译验收见 [TypeScript 消费者](tools/typescript-consumer/README.md)。固定构建环境和命令见 [TOOLCHAIN](TOOLCHAIN.md) 与 [README](README.md)；包仓库的可安装版本以其公开发布页为准。

在源码根目录使用 Node 24，以下 PowerShell 示例读取必需字段，并保留大整数和时长的精确字符串：

~~~powershell
@'
import {Config} from './tools/config.mjs';
const settings = Config.load('service {port=8080, enabled=yes, id=9007199254740993, timeout=1.25ms}');
console.log(JSON.stringify({
  port: settings.getInt('service.port'),
  enabled: settings.getBoolean('service.enabled'),
  id: settings.getLong('service.id'),
  timeoutNs: settings.getDuration('service.timeout')
}));
'@ | node --input-type=module
~~~

完整输出：

~~~json
{"port":8080,"enabled":true,"id":"9007199254740993","timeoutNs":"1250000"}
~~~

迁移维护者可以使用 [路径许可审查](CHANGE-REVIEW.md)、[值绑定计划](VALUE-BOUND-TRANSITIONS.md) 和 [预览后启用](PREVIEW-BOUND-ACTIVATION.md)；只接收设置文件的应用可使用 [类型化文件交接](TYPED-CONFIG-EXPORT.md)。[文档步骤入口](DOCUMENT-STEPS-INPUT.md) 和 [步骤来源合同](DOCUMENT-STEP-ORIGINS.md) 说明状态流程及坐标含义。

## 验证与适用范围

项目使用 JS/Wasm-GC 测试、固定 Lightbend Config 1.4.9 独立参考、公开 Apache OpenWhisk 配置片段、浏览器和独立 MoonBit 消费包，以及实际文件/HTTP/CLI 接入验证。分发验证读取实际本地包成员并运行解包后的消费者。当前提交的必要门与产物边界见 [CI 计划](CI-PLAN.md)，执行结论以 [相同提交的 GitHub Actions](https://github.com/uiwcvb/moonbit-hocon/actions/workflows/ci.yml) 为准。

Lightbend Config 是成熟的 HOCON 参考。本项目的贡献是 MoonBit 内可组合的配置树与迁移合同，以及带输入身份和实际消费者证据的配置审查流程；不主张语法首创、生态唯一或外部项目采用。

项目有明确的输入、树和策略预算。Node 配置入口要求对象根；渲染不保留原始注释和布局。它不提供完整 JVM 默认配置发现、系统属性注入、JAR/自定义 classloader、热重载、原文无损编辑、全部异常位置或部署安全保证。文件复核不是原子快照，普通产物写入不提供崩溃事务；业务值合理性由应用判断。公开样本和自编消费者不代表运行整个 OpenWhisk 或第三方采用。

## 许可与来源

核心源码采用 MIT。预生成引擎依赖的 MoonBit 标准库及 OpenWhisk/Pekko 公开配置样本保留 Apache-2.0 和各自 NOTICE；Lightbend Config 的参考用途与样本出处按 [第三方许可说明](THIRD_PARTY_NOTICES.md) 和 [OpenWhisk 来源](OPENWHISK.md) 标明。原作者、版权和上游归属保持，参考 JAR 不随源码包捆绑。
