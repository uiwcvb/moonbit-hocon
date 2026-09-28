# HOCON 配置迁移核对：MoonBit 差异 API 与跨实现闸门

项目仓库：https://github.com/uiwcvb/moonbit-hocon；模块 `uiwcvb/hocon`，本地版本 0.24.1，MIT。以下内容仅对应本地源码，尚未推送、发布新版或重新提交报名表。

## 要解决的实际问题

存量 HOCON 配置迁入 MoonBit 服务时，`include`、变量替换和 fallback 可能使程序启动成功，却悄悄改变端口、超时或其他运行参数。项目让调用方在迁移前明确看到“哪些最终配置路径变了”，并在跨实现不一致时让 CI 失败。没有 HOCON 存量配置的程序无需引入这个库。

## MoonBit 交付及使用方式

MoonBit 核心实现解析、求值、类型读取和 `diff_resolved_configs`：输入两棵已求值配置树，确定性输出字面键路径、增删改类别与前后类型，不输出可能含密钥的值；带点号键不会混同于嵌套路径。调用方可据此审查一次配置变更，或自行制定允许变更清单。对象根、未求值输入、深度、工作量及报告数量均有明确边界；JS/Wasm-GC 共用同一核心。

仓库另提供 `tools/migration-gate.mjs`：将 MoonBit 求值结果与使用者提供的 Lightbend Config 1.4.9 JAR 对照，差异时退出 2。Node 只承担可信文件、显式 classpath 和 CLI；Java JAR 是独立参考，不被包装为 MoonBit 实现。两个接口解决不同层次的问题：库内检查前后版本，闸门检查迁移到 MoonBit 后是否仍与既有 JVM 行为一致。

## 可复现证据与已有项目关系

README 的合成迁移案例中，旧端口 8080 改为 9080，直接差异 API 和跨实现闸门都定位 `service.port` 与经替换得到的 `service.copy`。未改写的 Apache OpenWhisk controller 配置、两个真实 include 和 fallback 另经 Lightbend 对照 36 条叶路径及 11 项类型读取；步骤见 `OPENWHISK.md`。2026-09-29 本地新增差异 API 的专门用例通过，MoonBit 完整测试在 JS/Wasm-GC 各 16723/16723 项通过。

Lightbend Config 已成熟解决 JVM 的 HOCON 语义；本项目不主张协议、解析算法或“生态首个”原创。面向 MoonBit 的增量是可在应用内部组合的求值/差异接口，以及迁移阶段可复查的跨实现门槛。关键词查重不是不存在同类库的证明；既有实现、许可和具体功能关系见 `DUPLICATION.md`。

## 范围与提交状态

当前没有确认的真实迁移使用方。闸门仅接收可信本地文件、显式 classpath、空环境与 JSON 安全整数范围；HTTP 在该入口禁用，不声明全量 JVM 兼容。配置差异 API 不作策略决定，也不保证部署安全。2026-09-29 新增代码已在 Windows 与 Ubuntu-D 严格双后端测试；旧 OpenWhisk 回执仍只证明独立参考场景，远端 CI 尚未验证。申报人需使公开仓库、GitHub Actions、Mooncakes 版本和表单正文对应同一提交；复审结论由组委会决定。

复现入口：[README](README.md) · [迁移闸门](MIGRATION-GATE.md) · [公共 API](pkg.generated.mbti) · [CI](.github/workflows/ci.yml)。
