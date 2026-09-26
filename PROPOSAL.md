# HOCON 配置迁移差异闸门 · 复审草稿

本项目仓库：https://github.com/uiwcvb/moonbit-hocon
模块 / 本地版本：`uiwcvb/hocon` / `0.24.1`；许可证：MIT。仅本地修订，尚未推送、发布或提交表单。

## 用途与必要性
已有 HOCON 配置的服务要迁入 MoonBit 时，先核对 include、替换、fallback 后的实际值，避免启动成功却使用了不同端口、超时或其他配置。本项目提供可在 CI 里失败退出的迁移差异闸门；没有 HOCON 存量配置的项目无需使用它。

## 可运行交付
MoonBit 实现 HOCON 解析、替换、类型读取和求值；Node 负责受信任文件、显式环境/网络与本地 CLI。新增 `tools/migration-gate.mjs` 以未改动的 Lightbend Config 1.4.9 为参考，比较两侧最终配置，支持显式classpath目录，报告差异路径和实际读取文件指纹，不输出配置值。可指定旧配置作基线，检测迁移后的语义漂移。
先按 README 构建，运行 MIGRATION-GATE.md 的两条命令：相同配置 3 条路径一致退出 0；把旧端口 8080 改为 9080 后，报告 `service.port` 与替换得到的 `service.copy`，退出 2。这些输入是原创合成配置。另以公开Apache OpenWhisk实际controller配置、两个真实include和controller fallback核对36条叶路径、11项类型读取，见OPENWHISK.md；不称为客户迁移或全系统启动。

## 已有工具与增量
Lightbend Config 已解决 JVM 侧 HOCON 语义；本项目没有发明 HOCON，也不以“MoonBit 首个”作为价值依据。增量是 MoonBit 应用接入及可运行的跨实现迁移检查。Java JAR 只在显式检查时作为参考程序，未捆绑进生产库；Node 文件/HTTP I/O 不冒称 MoonBit 原生能力。来源、接口与查重边界见 DUPLICATION.md。

## 验证与限制
旧版已有双后端及独立参考对照，本轮新增迁移入口的相同/差异/失败路径由本地检查记录；历史整套测试不计为本轮重跑。只比较可信本地文件与 JSON 可表达的安全整数范围，HTTP 在本入口禁用，环境变量为空；不是全量 JVM 兼容、生产性能或真实用户证明。
没有确认使用方；团队需先同步对应代码与真实报名表。复审仍由组委会判断。
