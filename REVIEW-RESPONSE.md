# HOCON 初审意见回复草稿 · 2026-09-29

针对“主要是既有 HOCON 语义兼容重写，面向 MoonBit 的新增价值和用户场景不明确”，本项目不再把语义重写或关键词检索未命中作为充分的创新性理由。既有 [Lightbend Config](https://github.com/lightbend/config/releases/tag/v1.4.9) 已提供成熟语义。

本地 0.24.0 增加了明确的迁移任务：已有 HOCON 文件接入 MoonBit 应用前，用 `tools/migration-gate.mjs` 对照未修改的 Lightbend 1.4.9。它解析配置及指定 fallback，比较最终值；一致退出 0，配置语义漂移退出 2，并只报告差异路径和文件指纹。原创合成示例中，9080 对旧 8080 会同时指出 `service.port` 和 `service.copy`。步骤见 [MIGRATION-GATE.md](MIGRATION-GATE.md)。

MoonBit 实现配置语义，Node 承担本地文件、进程与网络；JAR 仅作显式参考，不随库发布。此工具使迁移检查可自动失败退出，但还没有确认的真实迁移使用方；不宣称全量 JVM 兼容、生产性能或已通过初审。未有存量 HOCON 配置的应用没有使用本项目的必要性。

本地源码与材料已更新，尚未推送或改表单。申报人同步后应核对公开地址和真实需求，再决定是否复申。9月22日的旧仓库/测试记录保留原日期，新入口验证单列。

## 2026-09-27 实证补充

公开Apache OpenWhisk controller配置片段已经实际运行，主文件、logging include、Pekko生成版本include、controller fallback共4个文件；36叶路径、11类型读取对照Java成功，详见OPENWHISK.md和新回执。该例把应用消费接口和存量语义核验具体化，但没有宣称OpenWhisk迁移、采用或整套运行时兼容。classpath与读取指纹是宿主交付改进，MoonBit贡献仍以既有配置解析/求值/类型核心为准，不堆新概念。

## 2026-09-29 MoonBit 内部能力补充

新增 `diff_resolved_configs` 公共 API，将已求值的旧新配置在 MoonBit 内比较，按字面键路径报告增删改及前后类型，不泄漏配置值。它与 Java 参考闸门用途不同：调用方无需起 JVM 就可审查同一应用的配置版本变化；跨实现迁移时再使用闸门。带点号键、替换后的连带变化、数组变化、类型变化和未求值拒绝均有专门检查；Windows 与 Ubuntu-D 双后端完整测试各 16723 项通过。尚无真实迁移使用者；旧 OpenWhisk 回执只证明独立参考场景，不能外推为新增 API 的外部采用。
