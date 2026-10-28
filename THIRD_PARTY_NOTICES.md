# 第三方许可与来源

本项目原创配置解析、迁移审查核心及宿主工具采用根目录 [LICENSE](LICENSE) 的 MIT 许可。第三方组件和数据保留各自许可；根许可证不替换下述条件。

## 预生成引擎所用标准库

`web/engine.mjs` 是为运行 Node 示例随包保留的 MoonBit JavaScript 引擎，使用 `moonbitlang/core` 标准库。固定工具链对应标准库版本为 `0.10.14+7d59c7ec9`，项目地址为 https://github.com/moonbitlang/core 。

标准库采用 Apache-2.0；随包完整保留 [LICENSE](licenses/MoonBit-core-LICENSE.txt) 和 [NOTICE](licenses/MoonBit-core-NOTICE.txt)。NOTICE 包含其上游作者及所列第三方许可归属，不删减其中声明。本包不分发整个 SDK、编译器或构建/依赖缓存。

## 公开配置样本

`examples/openwhisk` 的 Apache OpenWhisk 配置和 Apache Pekko HTTP 版本资源保留原始来源与哈希，见 [SOURCE.json](examples/openwhisk/SOURCE.json)。对应文件按 Apache-2.0 分发；完整保留各自的 [OpenWhisk LICENSE](examples/openwhisk/OPENWHISK-LICENSE.txt)、[NOTICE](examples/openwhisk/OPENWHISK-NOTICE.txt) 与 [Pekko LICENSE](examples/openwhisk/PEKKO-LICENSE.txt)、[NOTICE](examples/openwhisk/PEKKO-NOTICE.txt)。它们只用于选定配置片段的示例及独立核验，不代表上游采用本库。

## 规范与独立参考

HOCON 语义参考 Lightbend Config，来源与差异范围见 [DUPLICATION.md](DUPLICATION.md)。可选迁移对照由原创适配器调用使用者提供的官方 Java 参考 JAR；源码包不捆绑该 JAR，也不以本项目 MIT 许可替代上游许可。
