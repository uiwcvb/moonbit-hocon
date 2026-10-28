# HOCON 规范覆盖与实际公共合同

基准：[Lightbend Config v1.4.9 HOCON.md](https://raw.githubusercontent.com/lightbend/config/v1.4.9/HOCON.md)。这是实现参考版本，HOCON本身没有1.4.9语言版本号。固定正文SHA-256：`beef3f0b72703d1bbd30c60b194beccd42464a428bb1aa5946e7f57c37df002f`。

本表分母是该文档 **43 个技术标题**：全部三级/四级标题，以及MIME Type和末尾两个Note；背景/定义及纯分组标题不另作功能。每行覆盖一个章节，不是该节所有规范断言或合法输入的分母，不能据行数计算兼容率。

“已实现”表示有对应实现；“有限已验证”仅指可定位的既有案例；“待验证”包括未穷尽的正常、边界与错误组合；“未实现/非目标”明确保留。该矩阵不是新增产品功能或新跑出的测试成绩。

|ID|官方章节（原文行）|实现状态|验证状态|源码 / 既有证据|范围与待确认项|
|---|---|---|---|---|---|
|H01|Unchanged from JSON (L115)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H02|Comments (L123)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H03|Omit root braces (L128)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H04|Key-value separator (L141)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H05|Commas (L149)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H06|Whitespace (L165)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H07|Duplicate keys and object merging (L186)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H08|Unquoted strings (L240)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H09|Multi-line strings (L288)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H10|Value concatenation (L304)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H11|String value concatenation (L321)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H12|Array and object concatenation (L382)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H13|Note: Concatenation with whitespace and substitutions (L435)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [document.mbt](document.mbt), [configuration_test.mbt](configuration_test.mbt), [cycle_origin_reference_test.mbt](cycle_origin_reference_test.mbt), [unresolved_origin_reference_test.mbt](unresolved_origin_reference_test.mbt)|必需/可选、历史值、覆盖、include重定位；无来源旧值Invalid；完整角落待验证|
|H14|Note: Arrays without commas or newlines (L444)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|不据有限案例宣称条款全覆盖|
|H15|Path expressions (L472)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [tree_operations.mbt](tree_operations.mbt), [path_reference_test.mbt](path_reference_test.mbt), [core_test.mbt](core_test.mbt)|字面点键/空组件与嵌套路径区分，原路径预算保留|
|H16|Paths as keys (L521)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [tree_operations.mbt](tree_operations.mbt), [path_reference_test.mbt](path_reference_test.mbt), [core_test.mbt](core_test.mbt)|字面点键/空组件与嵌套路径区分，原路径预算保留|
|H17|Substitutions (L574)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [document.mbt](document.mbt), [configuration_test.mbt](configuration_test.mbt), [cycle_origin_reference_test.mbt](cycle_origin_reference_test.mbt), [unresolved_origin_reference_test.mbt](unresolved_origin_reference_test.mbt)|必需/可选、历史值、覆盖、include重定位；无来源旧值Invalid；完整角落待验证|
|H18|Self-Referential Substitutions (L653)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [document.mbt](document.mbt), [configuration_test.mbt](configuration_test.mbt), [cycle_origin_reference_test.mbt](cycle_origin_reference_test.mbt), [unresolved_origin_reference_test.mbt](unresolved_origin_reference_test.mbt)|必需/可选、历史值、覆盖、include重定位；无来源旧值Invalid；完整角落待验证|
|H19|The `+=` field separator (L719)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [document.mbt](document.mbt), [configuration_test.mbt](configuration_test.mbt), [cycle_origin_reference_test.mbt](cycle_origin_reference_test.mbt), [unresolved_origin_reference_test.mbt](unresolved_origin_reference_test.mbt)|必需/可选、历史值、覆盖、include重定位；无来源旧值Invalid；完整角落待验证|
|H20|Examples of Self-Referential Substitutions (L738)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [document.mbt](document.mbt), [configuration_test.mbt](configuration_test.mbt), [cycle_origin_reference_test.mbt](cycle_origin_reference_test.mbt), [unresolved_origin_reference_test.mbt](unresolved_origin_reference_test.mbt)|必需/可选、历史值、覆盖、include重定位；无来源旧值Invalid；完整角落待验证|
|H21|List values from environment variables (L893)|已实现（显式注入）；OS集成有边界|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json), [configuration_test.mbt](configuration_test.mbt)|核心Map区分大小写；不默认读进程环境；Windows进程环境同名大小写碰撞不能凭核心Map消除|
|H22|Includes (L919)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H23|Include syntax (L921)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H24|Include semantics: merging (L982)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H25|Include semantics: substitution (L1008)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H26|Include semantics: missing files and required files (L1051)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H27|Include semantics: file formats and extensions (L1074)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H28|Include semantics: locating resources (L1109)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json), [OPENWHISK.md](OPENWHISK.md)|同步include回调；Node文件/目录classpath/URL；JAR、自定义classloader非目标|
|H29|Conversion of numerically-indexed objects to arrays (L1184)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H30|MIME Type (L1221)|部分实现（Node HTTP宿主）|有限已验证；本节完整输入/错误矩阵待验证|[tools/http-client.mjs](tools/http-client.mjs), [tools/config-host.mjs](tools/config-host.mjs), [evidence/http-reference-vectors.json](evidence/http-reference-vectors.json)|Content-Type选择/已支持HTTP协议；代理认证/JAR等边界见FEATURES|
|H31|Automatic type conversions (L1230)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H32|Units format (L1264)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H33|Duration format (L1295)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H34|Period Format (L1315)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H35|Size in bytes format (L1335)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[extended_accessors_test.mbt](extended_accessors_test.mbt), [accessors.mbt](accessors.mbt), [temporal.mbt](temporal.mbt), [temporal_reference_test.mbt](temporal_reference_test.mbt), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json)|保留精确数字及溢出/类型拒绝；所有JDK版本/全部角落待验证|
|H36|Config object merging and file merging (L1399)|已实现|有限已验证；本节完整输入/错误矩阵待验证|[config.mbt](config.mbt), [tree_operations.mbt](tree_operations.mbt), [tools/config-host.mjs](tools/config-host.mjs), [configuration_test.mbt](configuration_test.mbt), [persistent_core_test.mbt](persistent_core_test.mbt)|对象深合并/非对象屏障/显式fallback；不是默认JVM加载约定|
|H37|Java properties mapping (L1441)|部分实现（Node宿主）|有限已验证；本节完整输入/错误矩阵待验证|[tools/config-host.mjs](tools/config-host.mjs), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json)|properties转义/续行/点路径；Java系统属性注入与全部JVM工厂非目标|
|H38|Conventional configuration files for JVM apps (L1498)|未实现（JVM默认约定）；已有显式替代|明确未实现，不计为兼容通过|[tools/config-host.mjs](tools/config-host.mjs), [FEATURES.md](FEATURES.md)|不自动执行JVM application/reference发现或-D系统属性覆盖；调用者显式传fallback/classpath/environment|
|H39|Conventional override by system properties (L1528)|未实现（JVM默认约定）；已有显式替代|明确未实现，不计为兼容通过|[tools/config-host.mjs](tools/config-host.mjs), [FEATURES.md](FEATURES.md)|不自动执行JVM application/reference发现或-D系统属性覆盖；调用者显式传fallback/classpath/environment|
|H40|Substitution fallback to environment variables (L1534)|已实现（显式注入）；OS集成有边界|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json), [configuration_test.mbt](configuration_test.mbt)|核心Map区分大小写；不默认读进程环境；Windows进程环境同名大小写碰撞不能凭核心Map消除|
|H41|hyphen-separated vs. camelCase (L1567)|已实现|实现按字面键处理；命名风格建议不设通过比例|[lexer.mbt](lexer.mbt), [config.mbt](config.mbt), [core_test.mbt](core_test.mbt)|不自动重命名两种风格，不把建议当语言强制要求|
|H42|Note on Java properties similarity (L1572)|部分实现（Node宿主）|有限已验证；本节完整输入/错误矩阵待验证|[tools/config-host.mjs](tools/config-host.mjs), [evidence/file-reference-vectors.json](evidence/file-reference-vectors.json)|properties转义/续行/点路径；Java系统属性注入与全部JVM工厂非目标|
|H43|Note on Windows and case sensitivity of environment variables (L1598)|已实现（显式注入）；OS集成有边界|有限已验证；本节完整输入/错误矩阵待验证|[resolver.mbt](resolver.mbt), [tools/config-host.mjs](tools/config-host.mjs), [evidence/config-reference-vectors.json](evidence/config-reference-vectors.json), [configuration_test.mbt](configuration_test.mbt)|核心Map区分大小写；不默认读进程环境；Windows进程环境同名大小写碰撞不能凭核心Map消除|

## 本期循环来源与错误合同

已有公开错误为`ParseError { Invalid(String); Located(String, SourcePosition) }`。位置字段是`source/offset/line/column`，不是file/col或带命名参数的另一套错误。解析产生的带来源循环替换使用Located，旧手工无来源值仍Invalid；不承诺所有语义/类型错误都有位置。

`offset`是零起始Unicode标量索引，`line/column`一起始，位置指向实际参与循环的`$`。多边循环报告参与边之一，不承诺Java同一边，也不增加“首边”排序保证。预算内长单行继续保留行列；不采用静默丢行列/改成字节偏移的退路。每源100000个UTF-16单元等既有预算继续显式拒绝超限输入，预算错误不假装都有完整来源。详见[CYCLE-DIAGNOSTICS](CYCLE-DIAGNOSTICS.md)。

官方ConfigOrigin的共同可比字段是来源/行，未提供列/offset；后二者按原始文本检查。规范有求值顺序未规定的互相历史引用案例（a:1、b:2、a:${b}、b:${a}分行）：允许两值同为1、同为2或报错，不能强制唯一跨实现结果。实现可复现与全规范唯一输出不同。

## 实际API与审批合同

消费包导入`"uiwcvb/hocon"`，在可抛错函数中调用：

```moonbit
let old = @hocon.parse("service.port=8080\nservice.copy=${service.port}")
let next = @hocon.parse("service.port=9080\nservice.copy=${service.port}")
let rules : Array[@hocon.ConfigChangeRule] = [
  { path: ["service", "port"], kind: "changed" },
]
let report = @hocon.review_config_changes(old, next, rules)
// report.accepted 为 false：service.copy 尚未批准。
let unused = @hocon.unused_config_change_rules(old, next, rules)
```

接口摘要（完整签名见[pkg.generated.mbti](pkg.generated.mbti)）：`parse(String, source_name? : String, ...) -> Value raise ParseError`；`diff_resolved_configs(Value, Value) -> Array[ConfigChange] raise ParseError`；`review_config_changes(Value, Value, Array[ConfigChangeRule]) -> ConfigChangeReview raise ParseError`。不存在本期规划示意的Hocon类、Result[Config]或核心require_all_rules_used参数。

核心返回accepted/changes/unexpected；未批准变化本身不抛PolicyRejected。规则精确匹配字面路径片段和added/removed/changed，不放宽后代或父级删除；列表整体比较，报告不含配置值。核心默认允许闲置规则，unused接口另报。Node `reviewFiles({requireAllRulesUsed:true,...})`及CLI `--require-all-rules-used`收紧；示例服务在拒绝时抛PolicyRejected并阻止创建监听。详见[CHANGE-REVIEW](CHANGE-REVIEW.md)。

审批是允许变化合同，不校验业务值正确或部署安全。文件入口为空环境、禁HTTP；输入文件指纹重验不是原子快照。

## 证据、来源许可与后续范围

2026-10-28此前本地加固：相关13个文件的JS/Wasm-GC各70项通过；原版Lightbend Config 1.4.9运行10输入，Node sync/async/retained/retainedAsync共40观察（7循环×4入口的缺位置28→0）；真实HTTP消费者另6组。40不是40独立样本，也不是40个HTTP工况。本期只改文档，不重跑这些有效套件。实测工具为moonc0.10.14、Node24.11.0；未宣称Node20及所有版本逐一验证。

OpenWhisk只使用固定提交的4文件controller配置片段；历史36叶路径参考与加固后11类型读取分开保留，不代表控制器启动、完整运行时classpath或外部采用。来源/哈希/Apache-2.0许可及NOTICE见[OPENWHISK](OPENWHISK.md)和[样本来源](examples/openwhisk/SOURCE.json)。核心MIT不改变第三方许可。

未实现/未确认项继续见[FEATURES](FEATURES.md)：JVM默认加载及system properties、JAR/自定义classloader、全部错误位置/容器身份/来源注释/性能与多平台全量兼容。Java反射绑定、动态类扫描和JMX为非目标；全部HOCON角落的完整验证仍待后续，不用本期矩阵冒充完成。

可选Warning73仍因usability.mbt:44旧标注失败，标准--deny-warn此前通过。本期按范围约定仅登记，不修改无关实现。近邻已有配置diff/来源/审批能力，本项目不主张首创、生态空白或生产级完整兼容；贡献是MoonBit内可复用的HOCON求值与审批组合。
