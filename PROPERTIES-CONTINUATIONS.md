# properties 空前缀续行

Node 宿主支持 UTF-8 `.properties` 文件、目录 classpath 和 URL。反斜杠续行若没有留下任何键或值内容，下一行仍按新逻辑行识别注释和空行。注释自己的行尾反斜杠不会连接下一条配置。

```properties
\
# optional settings\
port=8080
```

本例结果应是 `{ "port": "8080" }`。修复前会错误生成 `#` 开头的键，并把有效的 `port` 配置吞入该键；续行后遇到空行也可能额外生成空键。2026-10-28 的本地修复只调整空前缀分支，保留非空续行中的 `#` / `!`、转义后的注释符号、显式空键以及固定 JDK 参考的 EOF 边界。

未修改的 Lightbend Config 1.4.9 / JDK 22 为226个有限输入提供独立参考，修复前32处差异、修复后0；其中包括 LF、CRLF、CR、EOF、转义和点路径冲突对照。另有58个既有文件参考用例一致。`node tools/test-properties-host.mjs` 运行26个冻结参考输入和16项实际消费者检查，覆盖文件、Config 工厂、异步 Worker、include、classpath、fallback、CLI、file URL 与真实回环 HTTP；既有宿主回归也通过。脚本已加入本地 CI 定义，尚未推送或运行远端 CI。

MoonBit 核心、生成的浏览器引擎和公共 API 均未改变；没有重复运行历史大型 JS/Wasm-GC/native 测试。本次证据是这些宿主路径的有限回归，不代表完整 Java Properties/JVM 兼容。独立请求、修复前失败、原始参考输出、命令及源码包读回记录保留在 `reports/hocon/deep-repair-07-max-20261028`。第06轮派生配置修复及封存保持不变。
