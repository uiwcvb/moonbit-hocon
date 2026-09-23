# HOCON 配置迁移差异闸门

**本项目仓库：[https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)**

模块 `uiwcvb/hocon`，本地版本 **0.24.0**，MIT。当前评审状态：**按新驳回意见整改**。本文件是当前入口，旧轮次说明与详细用法保存在 [历史/完整使用说明](README-BEFORE-VALUE-REWORK.md)。

## 解决什么任务

保留既有 HOCON 的 include、替换、回退及类型读取语义，将配置迁入 MoonBit 应用。新增本地迁移差异闸门，在启动前对照 Lightbend 的最终配置，发现语义漂移时以非零状态退出。输入和边界见 [迁移闸门](MIGRATION-GATE.md)。

已有 HOCON 配置、需要迁入 MoonBit 应用并保持解析后语义时使用；从零开始的简单配置不需要 HOCON。

## 直接复现

安装 MoonBit 和 Node.js 24，在本仓库根目录运行：

```sh
moon build --target js
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node examples/run-use-case.mjs
```

迁移差异闸门还需使用者自备未改动的 Lightbend Config 1.4.9 JAR：

```sh
node tools/migration-gate.mjs --file examples/use-case/application.conf --fallback examples/use-case/defaults.conf --jar /path/to/config-1.4.9.jar
node tools/migration-gate.mjs --file examples/use-case/application.conf --reference-file examples/use-case/application-before.conf --fallback examples/use-case/defaults.conf --jar /path/to/config-1.4.9.jar
```

第一条应退出 0，第二条应报告两条差异路径并退出 2；详见 [迁移闸门](MIGRATION-GATE.md)。

流程：**分层配置及启动类型读取**。运行器创建新的系统临时目录，保留每一步的 stdout/stderr、产物及 `report.json`，打印实际目录；重复运行不会覆盖之前产物。它只执行仓库内的本地样例，不连接公网或发送消息。`report.json` 的 `expected` 是应观察的结果，实际结果在各步输出中；成功退出不替代内容核对。

输入性质：原创合成配置；不声明已有 JVM 迁移客户。

应观察：主配置覆盖端口为 9080，替换也为 9080，回退保留 timeout，毫秒读取为 2000。

具体命令和输入路径见 [使用任务](USE-CASE.md) 与 [机器可读流程](examples/use-case.json)。只把这个脚本当复现入口，不把通用运行器计作核心技术贡献。

## 实现与已有项目的关系

MoonBit 解析和求值，Node 提供文件/HTTP、环境注入与不可变对象宿主；Java 只用于独立对照。

Lightbend Config 已提供成熟的 HOCON 语义。此仓库的实际增量是 MoonBit 应用的解析/类型读取接口与可失败退出的迁移语义检查；没有真实迁移用户，不能把同语义重写本身说成已证明的需求。

同类项目和检索边界见 [DUPLICATION](DUPLICATION.md)。查重用于避免错误的首创表述；关键词零结果不能证明生态空白，Node 宿主能力也不计为 MoonBit 原生 I/O。

库使用从 [公共 API](pkg.generated.mbti) 和根包源码开始；可在本 checkout 的消费包中导入 `"uiwcvb/hocon"`。源码中的网络/文件宿主入口及完整参数仍见 [完整使用说明](README-BEFORE-VALUE-REWORK.md)。是否已发布到 Mooncakes 需另核实，本文不把 `moon add` 的下载成功作为已完成事项。

## 验证与边界

此前的双后端和文件宿主验证保留原日期。0.24.0 新增迁移闸门，同一配置与旧版配置两条实际命令及退出码见 [迁移闸门](MIGRATION-GATE.md)；旧测试不计为本次重跑。

[上一轮工程验证](evidence/innovation-review-20260922/results.json) 与 [本轮最小任务回执](evidence/value-rework-20260922/use-case.json) 分开。历史参考版本、golden 重放、本机 peer、真实第三方服务端和本次样例是不同证据，不能合并成“全部生产验证”。

常规核心检查可运行 `moon check --target js`、`moon test --target js`、`moon test --target wasm-gc`。专项命令：

```sh
node tools/cli.mjs --input port=8080 --resolved-json
node tools/test-host.mjs
```

专项所需的参考环境和历史版本见原使用说明及 TESTING 文档；本轮回执只记录实际执行项，不声称上面所有参考服务在任意环境即装即跑。

Lightbend 全套行为和所有平台未完全等价；进程环境变量须通过 `--env` 或 `options.environment` 显式注入。HTTP(S) 默认可用；离线加载须指定 `--no-network` 或 `network: false`。

## 复审材料状态

尚无确认迁移用户；新闸门只覆盖受信任本地配置、空环境、有限 JSON 值与指定参考 JAR，不能把全套 JVM 行为或性能作为已完成。

2026-09-22 匿名新克隆成功；默认分支 `main`，核验公开提交 `4ff504db3894362ff5ae7046d4e66c816de1045a`。本轮源码修订仅在本地，尚未推送；此记录不证明当时报名表中的地址正确，也不证明新修订已上线。

[申报草稿](PROPOSAL.md) 已压缩为 30 行以内，并单独标明本项目仓库；[复核说明](REVIEW-RESPONSE.md) 区分材料错误、功能变化及尚未解决的问题。没有编造用户、设备接入、生产部署或评审认可。
