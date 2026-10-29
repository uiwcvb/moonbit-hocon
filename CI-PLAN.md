# 必要 CI 与证据计划

权威定义是 .github/workflows/ci.yml：push/pull_request 执行 MoonBit quality checks，必要产品 job 为 test。验收必须绑定最终提交的真实 run/head/job/step；本地通过、上传成功、辅助 run 或云端元数据都不能替代实际产品门，也不证明下载后二进制相等。

沿用固定 .moonbit-version、已固定 SHA 的安装器、Node 24.11.0、原 Config 1.4.9 JAR SHA；不改变全局 SDK、依赖或身份。原有 fmt/info/diff/check、JS/Wasm-GC、数值生成一致性、浏览器、公开宿主/异步/文件/HTTP、独立参考、稳健性/性能以及实际归档消费门均保留。

| 必要接入门 | 实际执行与证据 |
| --- | --- |
| Cold MoonBit transition consumer | 独立模块和公开包，保留原边界。 |
| Typed file export and HTTP receiver | 原文件到类型化产物，再到独立文件接收方；原 gate 不拆分计数。 |
| Classpath priority and startup receiver | 固定原版参考、公开文件/Worker/CLI 路径、实际 HTTP 启动和拒绝。 |
| Document-step input diagnostics | 原配置/include 加真实步骤文件，由 CLI 实际接收；保留完整 stdout/stderr、数字 exit/status/signal、原字节日志及恢复后的完整状态。 |
| Document-step fragment origins | Fresh compiled engine，公开同步/Worker/CLI，完整文件/URL 状态、来源及 classpath 子资源，保留原始输入/流/真实退出。 |
| Actual local package and archived consumers | 实际分发归档成员/归属/输入字节与解包后消费，不以 ZIP 可打开替代成功。 |

已有 Check document-step input diagnostics 继续运行 node tools/test-document-steps-input.mjs，保持 R06 的 JSON 语法摘录与 0/1/2、UTF-8/预算控制。本轮新增 Check document-step fragment origins，运行 node tools/test-document-step-origins.mjs：四种 HOCON 片段来源、生成前缀/Unicode 坐标、延后 resolve、原 primary/child 来源及文件/URL/classpath 相对 include，包含真实 CLI 原流/完整状态/恢复。两门处理不同原因；不重生成旧科学或生命周期参考。

quality-evidence 继续在 always 条件上传。output/document-steps-input、output/document-step-origins 与已有接入证据目录都显式上传，且由 Git/package 忽略规则排除生成内容。测试不回写固定输入或旧参考，失败原流须保留。

本地只做一次与实际变化相关的干净验证：固定工具链源副本编译、实际 CLI 文件与日志/状态接收，以及身份核对。通过后正常提交推送，等最终 head 的全部必要实际 CI 成功，再冻结 README/PROPOSAL、逐成员读回的最终源码 ZIP、Git/原工作/实际测试副本/编译/输出字节身份和 RESULT。有效轮次只由主控独立 ACCEPT 增加。
