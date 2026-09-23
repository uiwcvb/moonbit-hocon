# 分层配置及启动类型读取

保留既有 HOCON 的 include、替换、回退及类型读取语义，将配置迁入 MoonBit 应用，并在启动前报告缺失/类型错误。

## 输入、操作、输出

原创合成配置；不声明已有 JVM 迁移客户。

最简运行：先按 README 构建，然后 `node examples/run-use-case.mjs`。它自动创建输出目录并执行下面命令。下列 `{out}` 是运行器替换的实际目录，不是直接输入 shell 的变量；stdin 文件由运行器传递，以避免 Windows 与 POSIX 重定向差异。

```text
node tools/cli.mjs --file examples/use-case/application.conf --fallback examples/use-case/defaults.conf --no-network --resolved-json
node tools/cli.mjs --file examples/use-case/application.conf --fallback examples/use-case/defaults.conf --no-network --get service.timeout --type milliseconds
```

观察：主配置覆盖端口为 9080，替换也为 9080，回退保留 timeout，毫秒读取为 2000。

每一步输出见实际目录下 `step-N.stdout.txt` / `step-N.stderr.txt`；本轮已保存回执见 `evidence/value-rework-20260922/use-case.json`。

## 迁移差异检查

有官方 Lightbend Config 1.4.9 JAR 时，按 [迁移闸门](MIGRATION-GATE.md) 运行 `tools/migration-gate.mjs`。同一份配置解析后 3 个路径一致，退出 0；用旧版 `application-before.conf` 作为参考时，端口与依赖端口的替换路径不同，退出 2。输出只列路径，不列配置值。该步骤是本地合成迁移检查，JAR 需使用者提供。

## 为什么保留这个实现

需要保留 HOCON include/替换/回退的输入语义时选择；从零开始的简单配置不一定需要 HOCON。

现有 Lightbend Config 已实现 HOCON 语义。新增价值仅限 MoonBit 读取同类配置及迁入前的可检查差异；没有真实迁移使用方，不以重新实现语义本身证明价值。

## 不能由样例推出的结论

Lightbend 全套行为和所有平台未完全等价；环境变量须显式注入，HTTP(S) 默认可用。本例程显式使用 `--no-network`（API 对应 `network: false`）保证离线加载。

该样例是可修改的使用入口，不能证明存在真实用户、全部兼容或性能领先。继续投入的依据应是明确的输入或接入需求；若对接任务用既有成熟库即可完成，应优先复用而不是为保留参赛数量扩张本项目。
