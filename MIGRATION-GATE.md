# 配置迁移差异闸门

针对已有受信任的本地 HOCON 配置，应用迁入 MoonBit 前可将同一配置交给本库和未改动的 Lightbend Config 1.4.9 解析；结果不同则以非零退出码拦截部署。可选 `--reference-file` 把旧配置作为基线，对比新配置的最终语义。输入、fallback 和 JAR 均由调用者明确指定，不访问生产服务或自动读取进程环境。

```sh
moon build --target js
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node tools/migration-gate.mjs --file examples/use-case/application.conf --fallback examples/use-case/defaults.conf --jar /path/to/config-1.4.9.jar
node tools/migration-gate.mjs --file examples/use-case/application.conf --reference-file examples/use-case/application-before.conf --fallback examples/use-case/defaults.conf --jar /path/to/config-1.4.9.jar
```

第一条应输出 `equivalent:true`、`pathsCompared:3`，退出 0。第二条应输出 `equivalent:false`，指出 `service.port` 和 `service.copy` 两条差异路径，退出 2。解析或参考程序失败退出 1。JSON 报告仅包含差异路径、类别、源文件/JAR SHA256，不写出配置值。详见 `examples/use-case/`；这是原创合成任务，没有真实迁移客户。

能力边界：只比较可信的本地文件及指定 fallback，Node 加载明确禁用 HTTP，环境变量设为空。参考侧按明确的本地文件运行；配置文件的 include 也须由调用者保证可信。脚本只比较 JSON 可表达的已解析值；超出 JS 安全整数范围的整数会拒绝，需另作类型化核对。它不证明 Lightbend 全量兼容，也不替代应用级回归、性能或运行环境验证。JAR 必须由使用者自行从官方来源获取，仓库不捆绑。

参考来源：[Lightbend Config 1.4.9](https://github.com/lightbend/config/releases/tag/v1.4.9)。`tools/HoconOracle.java` 是现有测试用的原创 JSON-lines 适配器；新入口复用它读取未改动的官方库。本库仍由 MoonBit 负责解析和求值，Node 负责文件和进程调用。
