# 文件入口的显式语法

已有 `format` 选项可在文件和 `file:` URL 主入口指定 `hocon`、`json` 或 `properties`，覆盖主文件扩展名；省略时仍按扩展名选择。独立 fallback 文件继续按自己的扩展名读取，普通 include 的既有启发式语法规则保留。HTTP URL 仍允许已识别的 Content-Type 覆盖显式格式，并发送对应 Accept。

```javascript
import {Config, loadFile, loadURLAsync} from './tools/config.mjs';
const config = Config.loadFile('service.json', {format:'hocon'});
const strict = loadFile('service.conf', {format:'json'}); // HOCON 专用语法会被拒绝
const properties = await loadURLAsync('file:///C:/settings/data.txt', {format:'properties'});
```

properties 的数字保持字符串、`${...}` 保持字面文本。`Config.parseFile` / `parseURL`、`loadFile` / `loadURL` 及各自异步工厂使用相同规则；原文件来源和读取预算保留。不是新增格式或完整 JVM 加载约定。

2026-10-28 修复前，文件和 file URL 分支丢弃该选项，导致显式 JSON 仍接受 HOCON，或显式 HOCON 被错误的 `.json` 扩展名拒绝。依据固定 [Parseable v1.4.9](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/Parseable.java) 中显式语法优先于扩展名、file URL 转交同一文件解析器的规则。

未修改 Config 1.4.9/JDK 22 提供192个文件/URL观察和9个HTTP参考控制。前者差异从72降为0；`node tools/test-file-syntax-host.mjs` 的12个固定输入经12种同步/异步工厂检查共144项，另9项集成、18项真实回环HTTP检查通过。58个既有文件参考用例、第07轮42项续行回归及既有宿主检查通过。核心、公共API与引擎未改，未重复运行历史大型后端套件。

本地 CI 定义已加入该脚本，尚无新远端 CI 或发布。全部原输入、初始参考输出编码错误、修正后的权威基线、命令、身份及源码包读回记录保留在 `reports/hocon/deep-repair-08-max-20261028`。这是有限宿主回归，不是完整 JVM 认证。
