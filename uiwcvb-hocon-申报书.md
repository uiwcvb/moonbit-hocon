# MoonBit HOCON：配置解析与迁移审查库

申报账号：uiwcvb｜模块：`uiwcvb/hocon`｜仓库：[uiwcvb/moonbit-hocon](https://github.com/uiwcvb/moonbit-hocon)

面向保留既有HOCON配置的MoonBit应用开发者和配置维护者，提供“读取配置→求值得到生效树→核对迁移→交给应用”的可复用核心。适合include、变量替换和多层fallback共同决定配置的启动审查；已有公开项目样本，尚无确认的外部迁移客户。

**已完成的核心功能**

- **解析与加载：**解析字符串、精确数字、布尔、null、列表、对象及注释；Node文件入口支持HOCON、JSON和properties，可显式选择格式，配置入口要求对象根。
- **合并与编辑：**展开include、替换和有序fallback，保留非对象覆盖屏障；可先保留未求值树，再进行路径增删、筛选、包裹和求值，Config/Value/Object/List提供不可变派生。
- **类型与单位：**读取标量、列表、子配置及内存容量；固定时长与日历年/月分开读取。数字审查不先转JS Number，区分超过2^53的相邻整数；1与1.0语义等值，缺失与null不同。
- **结构与诊断：**以参考配置汇总缺失及类型问题，可限制模块路径；对带来源的缺失、循环替换返回源码名与行列。值可渲染为HOCON/JSON，省略注释与来源元数据，不承诺原文无损编辑。
- **生效差异：**先解析两侧实际配置再报告直接及引用联动变化；规则按字面键与增删改类别精确匹配，列表整体比较，报告不输出配置值；只改include也不会被主文件未变掩盖。
- **值绑定迁移：**同时核对具体旧值、目标值和完整变化集，拒绝过期基线、错误目标、遗漏变化及未发生的计划；原路径批准清单保持可用。
- **预览与应用接入：**绑定规则、实际文件及有序输入的预览指纹；可不监听地检查示例字段，再以已确认哈希启用本地HTTP消费者。输入复核不是原子快照，不代替业务校验。

词法、解析、替换求值、不可变树、精确比较与迁移审查由MoonBit实现，JS/Wasm-GC共用核心；Node负责文件/URL、CLI、指纹及示例服务，Java只用于可选独立参考对照。

最短使用例：在源码根用Node 24执行 `node examples/preview-bound-service.mjs --check`，读取随包样例，输出accepted=true、serviceConfigChecked=true和预览哈希，不开启监听。重建方法见README与TOOLCHAIN.md。

Lightbend Config是成熟HOCON参考；本项目的独立贡献是MoonBit内可组合的求值树与迁移合同，以及具体值和跨步骤输入一致性核对，不重做通用Schema/JSON Patch，也不主张生态唯一。

相关核心用例已有JS/Wasm-GC验证、原版Lightbend Config固定版本对照、公开OpenWhisk配置片段核验和本地HTTP启用/拒绝证据。GitHub源码包含本次增量，CI状态以相同提交的运行记录为准；本次未重新发布Mooncakes。验证范围可复查，运行整个OpenWhisk、全部兼容和外部采用尚未验证。

不支持完整JVM默认配置发现、系统属性、JAR/自定义classloader、全部来源诊断、热重载、事务写入或部署安全保证。实际输入/树/策略均有预算，预览哈希还绑定本地绝对路径。

核心源码采用MIT；预生成引擎所用MoonBit标准库及OpenWhisk/Pekko样本保留Apache-2.0和各自NOTICE，许可与出处随包提供。Java参考JAR不捆绑。
