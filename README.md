# HOCON 配置迁移差异闸门

**本项目仓库：[https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)**

模块 `uiwcvb/hocon`，本地版本 **0.24.1**，MIT。当前评审状态：**按新驳回意见整改**。本文件是当前入口，旧轮次说明与详细用法保存在 [历史/完整使用说明](README-BEFORE-VALUE-REWORK.md)。

0.24.1 已加入[公开 OpenWhisk 配置对照](OPENWHISK.md)：未经改写的控制器配置、两个真实 include 和明确 fallback，36条叶路径及11种类型读取与官方Java实现对照。新增 classpath 参数和实际读取文件指纹；不代表OpenWhisk迁移或采用本库。当前本地源码另增加 MoonBit 内的配置差异 API，尚未公开。

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

MoonBit 调用方也可直接比较两棵已解析、已求值的配置对象，不依赖 Java 或 Node 差异算法：

```moonbit
let old = @hocon.parse("service.port=8080\nservice.copy=${service.port}")
let next = @hocon.parse("service.port=9080\nservice.copy=${service.port}")
let changes = @hocon.diff_resolved_configs(old, next)
// 两条变化路径：service.copy 与 service.port；不包含配置值。
```

返回的 `ConfigChange` 含逐段路径、`added/removed/changed` 和新旧类型；列表按整体比较，含点号的字面键不会误作嵌套路径。库只报告事实，是否允许某项变更由调用方决定；未求值配置、非对象根、过深结构和超大报告会拒绝。实现与用例见 [config_diff.mbt](config_diff.mbt) 和 [config_diff_test.mbt](config_diff_test.mbt)。

流程：**分层配置及启动类型读取**。运行器创建新的系统临时目录，保留每一步的 stdout/stderr、产物及 `report.json`，打印实际目录；重复运行不会覆盖之前产物。它只执行仓库内的本地样例，不连接公网或发送消息。`report.json` 的 `expected` 是应观察的结果，实际结果在各步输出中；成功退出不替代内容核对。

此处 run-use-case 输入仍是原创合成配置；OPENWHISK.md 另提供公开实际项目配置。两者均不声明已有 JVM 迁移客户。

应观察：主配置覆盖端口为 9080，替换也为 9080，回退保留 timeout，毫秒读取为 2000。

具体命令和输入路径见 [使用任务](USE-CASE.md) 与 [机器可读流程](examples/use-case.json)。只把这个脚本当复现入口，不把通用运行器计作核心技术贡献。

## 实现与已有项目的关系

MoonBit 解析、求值、类型读取和配置树差异；Node 提供文件/HTTP、环境注入与不可变对象宿主；Java 只用于独立对照。

Lightbend Config 已提供成熟的 HOCON 语义。此仓库的实际增量是 MoonBit 应用内可组合的解析、类型读取与差异 API，以及可失败退出的跨实现迁移检查；没有真实迁移用户，不能把同语义重写本身说成已证明的需求。

同类项目和检索边界见 [DUPLICATION](DUPLICATION.md)。查重用于避免错误的首创表述；关键词零结果不能证明生态空白，Node 宿主能力也不计为 MoonBit 原生 I/O。

库使用从 [公共 API](pkg.generated.mbti) 和根包源码开始；可在本 checkout 的消费包中导入 `"uiwcvb/hocon"`。源码中的网络/文件宿主入口及完整参数仍见 [完整使用说明](README-BEFORE-VALUE-REWORK.md)。是否已发布到 Mooncakes 需另核实，本文不把 `moon add` 的下载成功作为已完成事项。

## 验证与边界

此前的双后端和文件宿主验证保留原日期。0.24.0 新增迁移闸门，同一配置与旧版配置两条实际命令及退出码见 [迁移闸门](MIGRATION-GATE.md)。当前差异 API 的新增用例与完整 MoonBit 测试在 2026-09-29 本地双后端重跑；独立 Java 闸门与 OpenWhisk 专项仍沿用各自注明日期的证据。

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

CI固定的编译器与标准库版本见 [TOOLCHAIN.md](TOOLCHAIN.md)；升级时需同时核对生成产物。

## 本地验收与公开交付（2026-09-28）

核心实现使用 MoonBit；[固定编译器](.moonbit-version)为 `moonc 0.10.14+7d59c7ec9`。先按本文安装宿主依赖、运行 `moon update`，再从仓库根目录执行以下与 [CI](.github/workflows/ci.yml) 对齐的检查；可运行任务和适用边界见本文前面的示例与说明。

```sh
moon check --deny-warn
moon test --target wasm-gc --deny-warn
moon test --target js --deny-warn
moon build --target js --deny-warn
moon package
```

跨平台复核（2026-09-28，本地 Ubuntu-D 26.04 WSL2）：从当时的源码归档全新解包，固定 `moonc 0.10.14+7d59c7ec9` 下通过 `moon update`、`moon fmt --check`、`moon info`、严格检查、JS/Wasm-GC 测试及 JS release 构建；Node 24.21.0 跑通本仓一条宿主入口。2026-09-29 新增差异 API 后，Windows 与 Ubuntu-D 均重跑严格 JS 检查及 JS/Wasm-GC 测试，各后端 16723/16723 项通过；新增代码尚未在 GitHub Actions 上验证。

专项复核：OpenJDK 21 与经散列核验的 Typesafe Config 1.4.9 对照 OpenWhisk 配置，36 个路径和 11 项类型读取一致。

本地核验：JS/Wasm-GC 测试，以及配置、OpenWhisk、树、持久化、访问器、时间值和渲染检查通过。 `moon package` 已完成离线打包预检，它不等于已发布到 Mooncakes。

公开交付（2026-09-28 核对）：当日 [https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon) 可匿名读取 Git HEAD，Mooncakes 在线版本为 `0.23.0`；此处源码版本 `0.24.1` 仍需由申报人同步到公开仓库，检查新提交的 GitHub Actions，再由对应账号发布 Mooncakes 新版。相关远端 CI 与赛事结果仍需以实际记录核对。项目许可见 [LICENSE](LICENSE)；如使用第三方材料，其来源和许可见仓内相应说明。
