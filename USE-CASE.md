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

## 为什么保留这个实现

需要保留 HOCON include/替换/回退的输入语义时选择；从零开始的简单配置不一定需要 HOCON。

本轮未找到同范围 MoonBit HOCON 库；其他配置库当然存在。价值是兼容这个明确的配置格式，不是首次变量替换或配置读取。

## 不能由样例推出的结论

Lightbend 全套行为和所有平台未完全等价；HTTP、环境变量须显式启用，README 列出具体差异。

该样例是可修改的使用入口，不能证明存在真实用户、全部兼容或性能领先。继续投入的依据应是明确的输入或接入需求；若对接任务用既有成熟库即可完成，应优先复用而不是为保留参赛数量扩张本项目。
