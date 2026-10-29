# 目录 classpath 的格式分层

应用通过既有 Config.loadFile/loadFile、异步工厂或 CLI 的 classpath 参数读取模块配置时，同一不带扩展名的资源可能来自多个目录和格式。优先级先按格式分层：全部 .conf 高于全部 .json，再高于全部 .properties；同一完整资源名内部，前面的目录优先。

这与 Lightbend Config 的 parseResourcesAnySyntax 文档一致。目录顺序不能跨格式推翻上述层次。[官方 ConfigFactory 合同](https://lightbend.github.io/config/latest/api/com/typesafe/config/ConfigFactory.html)

例如 app/main.conf：

~~~hocon
include classpath("service")
service.port=0
~~~

cp-first/service.properties：

~~~properties
service.port=9090
service.label=properties
propertiesOnly=P
~~~

cp-last/service.conf：

~~~hocon
service { port=8080, label=hocon }
confOnly=C
~~~

应用主文件仍可显式覆盖 include 的端口；模块标签来自更高格式层的 .conf，而两个模块的未冲突字段都会保留：

~~~javascript
import {Config} from './tools/config.mjs';
const config = Config.loadFile('app/main.conf', {
  classpath: ['cp-first', 'cp-last'], network: false, environment: {},
});
// service.port == 0, service.label == "hocon"
~~~

此前宿主先按目录、再按格式合并，使前目录的 properties/JSON 盖过后目录的 HOCON。合法输入会得到错误端口/标签，甚至以低格式值掩盖应生效的必需替换错误。修复只调整资源枚举的两层顺序；同格式目录优先级、显式扩展名资源、主文件覆盖、相对 include、读取限额和来源位置单位保留。

## 独立参考与真实启动

7 个完整手写输入/预期位于 tools/classpath-priority/cases.json，已由未修改 Config 1.4.9、固定 SHA256 的 JAR 和已有原版 HoconOracle 核实；reference.json 保存原始参考结果的对应值。修复前有 4 处差异：三种跨格式赢家错误，以及一个未找到必需替换被低格式值遮蔽。其余三个控制已一致。没有改旧合法输入、旧期望或解析格式。

~~~sh
node tools/test-classpath-priority.mjs
node examples/classpath-service.mjs --file app/main.conf --classpath cp-first --classpath cp-last
~~~

自编示例只通过公开 Config API 读取这些实际文件，在配置端口的回环地址提供 HTTP。固定端口 0 样例的完整响应为：

~~~json
{"configuredPort":0,"label":"hocon","propertiesOnly":"P","confOnly":"C"}
~~~

验收比较公开同步 API、Config 工厂、异步 Worker、真实 CLI 的完整值或拒绝结果，再启动独立进程核对真实 HTTP200 全响应。更高格式层的必需替换失败时，接收程序不得发布 ready 或开始服务；诊断必须保留实际 .conf 文件及原位置。服务关闭的实际 code/signal 也被记录，不假定跨平台退出码相同。

原始文件、stdout/stderr、HTTP 响应、读取清单和进程结果写到 output/classpath-priority 或 --evidence-dir 指定目录，生成目录不进入分发包。必要 CI 执行这个门；固定原参考只作重放，不重新生成旧向量。

这是一处已有目录资源加载合同的修复，不是新的默认 application/reference 加载器、JAR/JVM classloader、system properties、配置格式或环境覆盖功能。公开 parse/load/merge/get 原语和 MoonBit 的通用 JSON 能力均已存在；没有生态唯一性或第三方采用声明。[MoonBit core/json](https://mooncakes.io/docs/moonbitlang/core/json)
