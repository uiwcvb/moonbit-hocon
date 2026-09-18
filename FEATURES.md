# 功能与兼容性边界

0.4.0 已实现历史值自引用/+=、完整替换路径与 include 重定位、三引号和 Unicode 词法、来源位置、回退与显式环境、数值/单位转换和真实文件宿主。
CLI 支持 fallback、environment、classpath 目录及带类型的单路径读取；核心 MoonBit 可注入自己的同步 include loader。

当前值模型保留字符串/数字/布尔/null/数组/对象类型。混合拼接、自引用环、缺失引用、对象覆盖屏障、可选替换和文件优先级均有独立参考对照。
Lightbend 特定的裸文本接数组、启发式已知扩展名继承 HOCON、Java 数值转换也有固定用例。参考版本是 1.4.9；旧 0.3 的 33/34 报告只作历史记录。

0.5.0 新增八种类型化列表及 config/config-list，共十个公开接口，并接通 CLI/Node 读取。数字时长列表按整毫秒转换，内存字符串列表直接精确解析；数字索引别名去重及普通桶/回退顺序已对照 1.4.9。1,300 个新增官方向量在 JS/Wasm-GC 和宿主桥接复验。

0.6.0 新增 HTTP(S) include/URL 入口、Content-Type/Accept、相对来源、重定向、可信 TLS、网络期限和大小限制；同步与异步 Node API、CLI 均可使用。异步池支持并发、排队取消和错误隔离。配置入口拒绝非对象根，JSON 处理 BOM/Unicode 空白并拒绝重复键。

0.7.0 新增路径/字面键增删筛选、回退/包裹、深复制、路径枚举和多问题结构校验，并接通同步/异步 Node 与 CLI。4,380 个官方独立案例涵盖操作序列、类型矩阵、重复限制及 JDK 路径字符边界；校验比较路径/类别，尚不比较诊断全文/来源/顺序。

0.8.0 补充 `parse_unresolved`/`parse_sources_unresolved`、`resolve`/`resolve_with` 和深复制的 `get_value`。支持缺失引用延后处理、分阶段编辑/回退后继续解析、外部查找源及自解析；同步/异步文件与 HTTP、CLI 操作序列共用该实现。2,520 个独立原生序列比较每一步的状态、可读取值和已解析根值。完整目标仍未完成。

0.9.0 补充 number/object/any-ref/enum 的标量和列表共八个读取函数，保留 Number 的 Int/Long/Double 子类型与浮点位模式，枚举可返回调用方自定义类型；Node/CLI 与同步/异步文件/HTTP 接通。补齐固定 JDK 的 BMP 数字字符串/索引转换，修正越界整数字面量及 JSON 数字原始拼写。3,562 个独立案例对照值、子类型和精确位模式。

尚未追平：

- HTTP 代理与 305 代理重定向、认证协商、更多运行平台/协议栈；本轮已覆盖普通 HTTP(S) 及 file: URL。
- JAR/自定义 JVM classloader、默认 application/reference 配置与 Java system properties；目录 classpath、显式 fallback/environment 已实现。
- Period/TemporalAmount/指定时间单位读取接口、完整未解析 ConfigObject 容器操作/共享身份、未解析 render 与注释/来源保真；已实现有界分阶段解析和 resolveWith，尚未提供持久化 JavaScript Config 对象。
- 全部错误的精确位置、错误种类与多错误诊断；词法/语法有位置，部分语义错误只有消息。
- 数字索引对象的高碰撞树桶、删除后容量历史、其他 JDK Unicode 版本、所有拼接转换角落、格式/值的完整上游边界与多版本覆盖。固定 JDK 的 BMP 数字键已有逐块独立对照。
- 独立大配置性能、内存/吞吐、多平台及持续负载。0.5 已增加七项同机五进程端到端请求对照；时长列表仍约慢 9.4%，不能外推大配置或生产负载。

每源/深度/求值/输出及宿主文件限额详见 README。Number 保留文本，但普通 JS JSON 对象里的数值受双精度限制；long/bytes/memory 使用字符串传输。
编译后的引擎、CLI、API 与证据在本地提交；CI 文件已配置但没有远端运行，独立增量 ZIP/bundle 绑定相应提交；旧 20 项目合集保持历史版本。
