# HOCON 配置解析器

MoonBit 本地 0.3.0 版本。配置对象合并、替换、显式提供的 include 数据源，以及保留类型的数组/标量解析。
本仓库独立保存源码、编译后的浏览器引擎、CLI、文档和验证记录。

## 使用

```powershell
node tools/cli.mjs --input 'port=8080' --resolved-json
# {"port":8080}
node tools/cli.mjs --file sample.txt --resolved-json --json
```

`--resolved-json` 输出已解析的 JSON 值；`--json` 是 CLI 结果信封，包含 ok 和 output。
不传 --resolved-json 时保留语法值调试展示。也支持 UTF-8 标准输入和独立网页 `./start-review.ps1`。
所有入口调用真实 MoonBit 引擎；没有远程服务调用。

```moonbit
let config = @hocon.parse(
  "include required(file(\"defaults\"))\nport=9090\ncopy=${port}",
  includes={"defaults": "port=8080\nenabled=true\nitems=[1,2]"},
)
let port = @hocon.get_int(config, "copy") // 9090
let items = @hocon.get_list(config, "items")
let json = config.to_json_string()
```

include 的名字由调用者提供的 Map 显式匹配。`file("name")` 使用相同映射；核心不自动读磁盘、URL、classpath 或环境变量。
普通缺失 include 为空对象；required(...) 缺失时报错。嵌套 include 保留合并顺序、循环和展开限额检查。

## 数据与语义

| 类型 | 表示 |
| --- | --- |
| 字符串 | Text(String) |
| 数字 | Number(String)，保留原始数字拼写 |
| 布尔 / 空值 | Boolean(Bool) / Null |
| 数组 / 对象 | List(Array[Value]) / Object(Map[String, Value]) |

Reference、PathReference、Concat、DelayedMerge 是解析过程中的节点；parse 返回已解析数据。
`get_string`、`get_int`、`get_bool` 和 `get_list` 严格检查类型，不把数字字符串隐式变成数字。
get_int 限 32 位整数；Number 本身保留十进制/指数文本。get_path 的组件数组支持键中包含点。

支持正负 JSON 数字、布尔、null、数组及数组内嵌对象；引号字符串使用 JSON 转义（包括 Unicode）。
对象重复键递归合并，非对象值构成覆盖屏障。`${path}` 保留被替换值的类型；`${?missing}` 缺失时删除字段或数组元素，
同字段已有值时保留旧值。路径可穿过另一个替换得到的对象，引用路径支持带引号的点号组件。
同一行的字符串/标量片段拼接保留间隔；数组与数组拼接，对象与对象合并；混合类型拼接报错。
JSON 输出按对象键排序，并区分字符串、数字、布尔、null 和数组。

0.3 的迁移：数字与布尔不再是 Text；对 Value 穷举匹配的下游需增加新分支。
原来缺失普通 include 报错的行为已修正，要求存在的资源应改用 required(...)。

## 验证

安装 MoonBit 后运行 `./verify.ps1`，或指定 `-MoonPath`。
本轮旧功能 9 项 JS 测试通过；新增与相关类型检查 6 组通过；最后的对象别名路径修复单独验证通过。
独立参考工具测试：

```powershell
$env:HOCON_REFERENCE_JAR='C:/path/to/config-1.4.5.jar'
node tools/test-reference.mjs
```

需要 Java 11+；适配器是原创测试代码，上游 JAR 不在本仓库内分发。
本轮实际使用 Lightbend Config 1.4.5：34 个接受/拒绝和类型化结果案例中，33 个一致。
唯一差异为 `a=[1] text`：上游返回 {"a":[1]}，本库拒绝数组与文本混合。
[规范的字符串拼接规则](https://github.com/lightbend/config/blob/main/HOCON.md#string-value-concatenation)禁止把数组/对象用于字符串拼接，
本库保留报错并记录上游差异。对照脚本仍以非零退出，不掩盖不一致。
完整逐例记录见 evidence/typed-reference-validation.json；没有据此宣称全部兼容。

## 仍需完善

- 自引用历史值及 +=，嵌套 include 的替换路径重定位/根路径回退。
- 完整非引号字符串/路径词法、多行三引号、全部空白字符和带位置的错误。
- 文件系统/URL/classpath include 宿主、扩展名查找及环境/默认配置合并。
- 数值/单位访问器、完整类型转换规则和性能对标。

每个源限 100,000 UTF-16 单元，包含展开累计预算 1,000,000；对象/数组/include 深度限 32，
替换深度 64，并有展开节点与输出长度限额。

按 [HOCON 官方规格](https://github.com/lightbend/config/blob/main/HOCON.md)自行实现，没有复制上游源码或测试集。
原创代码 MIT；查重记录见 DUPLICATION.md，检索不能保证没有同类项目。
全部保留本地，没有上传或发布；localreview 是本地命名空间。旧 ZIP/bundle 为历史快照，本轮未重打包。
