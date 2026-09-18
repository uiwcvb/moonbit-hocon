# 功能与兼容性边界

0.4.0 已实现历史值自引用/+=、完整替换路径与 include 重定位、三引号和 Unicode 词法、来源位置、回退与显式环境、数值/单位转换和真实文件宿主。
CLI 支持 fallback、environment、classpath 目录及带类型的单路径读取；核心 MoonBit 可注入自己的同步 include loader。

当前值模型保留字符串/数字/布尔/null/数组/对象类型。混合拼接、自引用环、缺失引用、对象覆盖屏障、可选替换和文件优先级均有独立参考对照。
Lightbend 特定的裸文本接数组、启发式已知扩展名继承 HOCON、Java 数值转换也有固定用例。参考版本是 1.4.9；旧 0.3 的 33/34 报告只作历史记录。

0.5.0 新增八种类型化列表及 config/config-list，共十个公开接口，并接通 CLI/Node 读取。数字时长列表按整毫秒转换，内存字符串列表直接精确解析；数字索引别名去重及普通桶/回退顺序已对照 1.4.9。1,300 个新增官方向量在 JS/Wasm-GC 和宿主桥接复验。

0.6.0 新增 HTTP(S) include/URL 入口、Content-Type/Accept、相对来源、重定向、可信 TLS、网络期限和大小限制；同步与异步 Node API、CLI 均可使用。异步池支持并发、排队取消和错误隔离。配置入口拒绝非对象根，JSON 处理 BOM/Unicode 空白并拒绝重复键。

尚未追平：

- HTTP 代理与 305 代理重定向、认证协商、更多运行平台/协议栈；本轮已覆盖普通 HTTP(S) 及 file: URL。
- JAR/自定义 JVM classloader、默认 application/reference 配置与 Java system properties；目录 classpath、显式 fallback/environment 已实现。
- number/object/enum 相关集合接口、checkValid、resolveWith、局部树修改和注释/来源保真；当前返回已解析值。
- 全部错误的精确位置、错误种类与多错误诊断；词法/语法有位置，部分语义错误只有消息。
- 数字索引对象的高碰撞树桶、删除后容量历史、Unicode 数字键及数组的所有拼接转换角落、格式/值的完整上游边界与多版本覆盖。
- 独立大配置性能、内存/吞吐、多平台及持续负载。0.5 已增加七项同机五进程端到端请求对照；时长列表仍约慢 9.4%，不能外推大配置或生产负载。

每源/深度/求值/输出及宿主文件限额详见 README。Number 保留文本，但普通 JS JSON 对象里的数值受双精度限制；long/bytes/memory 使用字符串传输。
编译后的引擎、CLI、API 与证据在本地提交；CI 文件已配置但没有远端运行，独立 0.6 ZIP/bundle 绑定新提交；旧 20 项目合集保持历史版本。
