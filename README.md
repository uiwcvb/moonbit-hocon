# HOCON 配置迁移与启动校验

**本项目仓库：[https://github.com/uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)**

模块 `uiwcvb/hocon`，本地版本 **0.23.0**，MIT。当前评审状态：**保留候选**。本文件是当前入口，旧轮次说明与详细用法保存在 [历史/完整使用说明](README-BEFORE-VALUE-REWORK.md)。

## 解决什么任务

保留既有 HOCON 的 include、替换、回退及类型读取语义，将配置迁入 MoonBit 应用，并在启动前报告缺失/类型错误。

需要保留 HOCON include/替换/回退的输入语义时选择；从零开始的简单配置不一定需要 HOCON。

## 直接复现

安装 MoonBit 和 Node.js 24，在本仓库根目录运行：

```sh
moon build --target js
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node examples/run-use-case.mjs
```

流程：**分层配置及启动类型读取**。运行器创建新的系统临时目录，保留每一步的 stdout/stderr、产物及 `report.json`，打印实际目录；重复运行不会覆盖之前产物。它只执行仓库内的本地样例，不连接公网或发送消息。`report.json` 的 `expected` 是应观察的结果，实际结果在各步输出中；成功退出不替代内容核对。

输入性质：原创合成配置；不声明已有 JVM 迁移客户。

应观察：主配置覆盖端口为 9080，替换也为 9080，回退保留 timeout，毫秒读取为 2000。

具体命令和输入路径见 [使用任务](USE-CASE.md) 与 [机器可读流程](examples/use-case.json)。只把这个脚本当复现入口，不把通用运行器计作核心技术贡献。

## 实现与已有项目的关系

MoonBit 解析和求值，Node 提供文件/HTTP、环境注入与不可变对象宿主；Java 只用于独立对照。

本轮未找到同范围 MoonBit HOCON 库；其他配置库当然存在。价值是兼容这个明确的配置格式，不是首次变量替换或配置读取。

同类项目和检索边界见 [DUPLICATION](DUPLICATION.md)。查重用于避免错误的首创表述；关键词零结果不能证明生态空白，Node 宿主能力也不计为 MoonBit 原生 I/O。

库使用从 [公共 API](pkg.generated.mbti) 和根包源码开始；可在本 checkout 的消费包中导入 `"uiwcvb/hocon"`。源码中的网络/文件宿主入口及完整参数仍见 [完整使用说明](README-BEFORE-VALUE-REWORK.md)。是否已发布到 Mooncakes 需另核实，本文不把 `moon add` 的下载成功作为已完成事项。

## 验证与边界

前一轮工程验证修复改名后命令包仍引用旧模块而无法构建的问题，重新生成 API/JS 引擎；双后端和文件宿主检查通过。

[上一轮工程验证](evidence/innovation-review-20260922/results.json) 与 [本轮最小任务回执](evidence/value-rework-20260922/use-case.json) 分开。历史参考版本、golden 重放、本机 peer、真实第三方服务端和本次样例是不同证据，不能合并成“全部生产验证”。

常规核心检查可运行 `moon check --target js`、`moon test --target js`、`moon test --target wasm-gc`。专项命令：

```sh
node tools/cli.mjs --input port=8080 --resolved-json
node tools/test-host.mjs
```

专项所需的参考环境和历史版本见原使用说明及 TESTING 文档；本轮回执只记录实际执行项，不声称上面所有参考服务在任意环境即装即跑。

Lightbend 全套行为和所有平台未完全等价；HTTP、环境变量须显式启用，README 列出具体差异。

## 复审材料状态

尚无确认迁移用户，不能把全套 JVM 行为或性能作为已完成。

2026-09-22 匿名新克隆成功；默认分支 `main`，核验公开提交 `4ff504db3894362ff5ae7046d4e66c816de1045a`。本轮源码修订仅在本地，尚未推送；此记录不证明当时报名表中的地址正确，也不证明新修订已上线。

[申报草稿](PROPOSAL.md) 已压缩为 30 行以内，并单独标明本项目仓库；[复核说明](REVIEW-RESPONSE.md) 区分材料错误、功能变化及尚未解决的问题。没有编造用户、设备接入、生产部署或评审认可。
