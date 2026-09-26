# 实际项目配置的有限迁移核验

Apache OpenWhisk 固定commit `a67aba60ce68e0583962cb51cf6726c2a5f3795e` 的 controller/application.conf、logging.conf、controller/reference.conf 原样保留。`pekko-http-version.conf` 从官方 Pekko HTTP core 1.1.0 JAR 原样提取，确为编译生成资源，不是为让测试通过而填的空文件。来源、哈希及Apache许可/NOTICE保存在 examples/openwhisk。资源版本由OpenWhisk固定构建声明核对。

```sh
moon build --target js
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node examples/read-openwhisk.mjs
node tools/migration-gate.mjs --file examples/openwhisk/controller/application.conf --fallback examples/openwhisk/controller/reference.conf --classpath examples/openwhisk/resources --jar /path/to/config-1.4.9.jar
```

结果：36条叶路径一致；实际读取4个文件。独立类型读取核对11项：端口10001，65/70秒转换为纳秒字符串，50m读取为52428800字节（HOCON此处m按二进制倍数读取），两个off读取为false，include版本1.1.0、日志等级DEBUG、fallback协议http等。例子只输出这些公开配置字段，不打印密码字段。

参考测试：设置 `HOCON_REFERENCE_JAR` 为官方 Config JAR，运行 `node tools/test-openwhisk.mjs`。保存的双版本证据见 evidence/openwhisk-20260927：1.4.3是Pekko actor1.1.5依赖的版本，1.4.9是本项目当前独立参考版本。JAR未捆绑；从Maven Central获取，回执记录实际字节哈希。

此处只验证明确选择的controller配置片段与controller fallback，不执行 ConfigFactory.load 的全运行时资源合并，不声称重现OpenWhisk完整有效配置，也未启动controller。common/invoker/scheduler和全部第三方defaults、生产环境变量/系统属性均不在本任务范围。不能把部分核验写成整个系统迁移成功。

一个重要失败边界：HOCON可选include缺失时，两实现可能同时省略同一字段并仍比较一致。因此示例还必须以类型getter要求 `pekko.http.version` 存在；缺资源测试确认它会失败。等价闸门不是应用需求验证的替代。另核验include变动但主文件哈希不变、旧基线端口变更、必需include缺失、classpath类型错误。

这提供了真实公开输入和可消费MoonBit求值/类型读取证据，没有已知迁移客户或上游认可。无需存量HOCON兼容的简单配置场景，可以直接使用已有JSON/TOML等库。
