# MoonBit HOCON 配置解析与加载库 · 项目申报书

## 一、项目名称

MoonBit HOCON 配置解析与加载库

## 二、项目说明

MoonBit 实现列明的替换、自引用、include、回退、类型化读取及不可变值模型；Node 提供文件、HTTP(S)、properties、异步 Worker 和 CLI。不是完整 JVM Lightbend Config API 替代。

## 三、方向与通用性

基础软件与配置管理。用于服务配置分层、启动校验和配置编辑；价值在 HOCON 特定语义及对照证据，不宣称生态不存在其他替换或回退配置库。

## 四、应用场景

CLI 组合主文件与 fallback；显式 --env 才读取进程环境；get 配合 duration 等类型做启动检查；网络加载可整体禁用，并受响应、次数与期限上限控制。

## 五、功能与验证边界

固定 Lightbend Config 1.4.9 的值/回退/容器等比较记录见各版 evidence，不将不同矩阵总数相加冒充唯一用例数。仍缺注释/来源 API、完整共享身份与渲染、JAR/classloader 等 JVM 行为及生产性能保证。

## 六、原创性与参考材料

原创实现 MIT。Lightbend Config（Apache-2.0，https://github.com/lightbend/config）和固定 JDK 只用于参考行为与数据事实生成；Java 适配器和探针为本项目编写，上游 JAR 不随源码分发。来源及固定版本见 TESTING.md 和 evidence。

## 七、仓库链接

https://github.com/uiwcvb/moonbit-hocon
