# 把已确认的预览绑定到服务启动

具体值计划会校验本次传入的旧值和目标值。若预览后把配置与计划一起更新，新计划仍可能正常通过；fallback 顺序若在两侧一起改变，原来的差异和读取文件集合甚至可以完全相同，而服务读取的某个未变化字段已不同。可选的预览指纹补上这个跨步骤核对：启动时同时要求当前计划通过，以及输入指纹与先前确认的一致。

## 两个独立步骤

在项目目录先预览，不会启动监听：

```sh
node examples/preview-bound-service.mjs --preview
```

检查返回的变化、输入顺序、文件指纹及 accepted；从已确认的回执复制 previewHash，再单独启动示例：

```sh
node examples/preview-bound-service.mjs --activate COPY_THE_CONFIRMED_PREVIEW_HASH_HERE
```

第二步要求显式提供先前哈希，不会自动生成一个新哈希替代它。成功后完成真实回环HTTP请求，单独打印HTTP正文并关闭自己的监听；审批报告本身不输出实际值或期望值。

## 使用自己的配置文件

两个步骤都可接收现有审查CLI的文件参数。在相同工作目录运行，并在启动时重复同一组参数：

```sh
node examples/preview-bound-service.mjs --preview --before old.conf --after new.conf --transition-policy transitions.json
# 检查上一步回执，再传入已确认的哈希：
node examples/preview-bound-service.mjs --activate COPY_THE_CONFIRMED_PREVIEW_HASH_HERE --before old.conf --after new.conf --transition-policy transitions.json
```

可重复传入 `--before-fallback FILE`、`--after-fallback FILE`、`--before-classpath DIR`、`--after-classpath DIR`，顺序与审查CLI一致。相对路径以调用进程的工作目录为基准；脚本本身可通过绝对路径调用。路径带空格时按所用shell正常引用。带任意自定义参数时，必须完整提供 `--before`、`--after` 和具体值 `--transition-policy`，不会补用内置样本；旧的 `--policy` 权限清单不用于预览指纹。无自定义参数时仍使用原内置样本。

示例按原有 `getInt`/`getString` 转换规则读取 `service.port` 和 `service.message`，端口须在0到65535，可以来自include或fallback。这仍是完成一次回环HTTP请求后退出的示例；迁移计划审查通过不代表这些应用字段必然可用。实际HTTP正文会单独输出，预览报告不输出配置值。

也可先用现有CLI生成回执，再把相同参数及已确认哈希交给上述启动步骤：

```sh
node tools/change-review.mjs --before old.conf --after new.conf --transition-policy transitions.json --preview-receipt
```

退出0表示当前计划接受，2表示拒绝，1表示输入错误。拒绝的有效计划也可得到预览指纹，但这个指纹不能越过策略拒绝。`--preview-receipt` 仅配合具体值计划；不加该选项时，原报告格式与行为保持原样。

示例的预览模式同样用0/2/1表示接受、拒绝和输入错误；启动成功为0，策略拒绝、指纹不一致或应用启动失败为1。不要把拒绝预览的哈希当作批准。

## 批准前检查示例字段

若希望在确认哈希前发现示例字段错误，可用 `--check` 代替第一步的 `--preview`：

```sh
node examples/preview-bound-service.mjs --check --before old.conf --after new.conf --transition-policy transitions.json
# 审阅返回回执并确认其哈希后，再独立启动：
node examples/preview-bound-service.mjs --activate COPY_THE_CONFIRMED_PREVIEW_HASH_HERE --before old.conf --after new.conf --transition-policy transitions.json
```

不附加文件参数时，`--check` 使用原内置样本。它先生成相同的迁移预览；计划通过后，复用启动的目标文件重读、指纹核对、两个getter和端口范围检查，不打开监听。成功报告增加 `serviceConfigChecked:true` 并退出0；策略拒绝时该标志为false、退出2，且不继续执行应用字段的getter检查；文件/类型/端口错误退出1。报告不输出端口或message值。

`accepted` 继续表示原迁移审查结果，普通预览仍可接受不适用于此示例的合法配置。`serviceConfigChecked` 只是这两个示例字段检查已通过的输出元数据，不参与v1哈希；同一输入的检查和普通预览哈希相同。调用者仍须显式批准哈希，启动时仍重新检查当前输入与字段。此模式不预留端口、不执行其他应用的Schema或初始化，也不保证运行条件和部署安全。

## PowerShell 脚本接入

在项目目录使用参数数组传路径，并在解析JSON前保存原生退出码。下面先展示待检查回执；第二次调用的哈希应从已确认回执取得：

```powershell
$reviewArgs = @('--before', 'C:\配置 样本\old.conf',
                '--after', 'C:\配置 样本\new.conf',
                '--transition-policy', 'C:\配置 样本\transitions.json')
$raw = & node examples/preview-bound-service.mjs --preview @reviewArgs
$previewCode = $LASTEXITCODE
if ($previewCode -ne 0) { throw "Preview exit $previewCode" }
$preview = ($raw -join "`n") | ConvertFrom-Json
$preview | ConvertTo-Json -Depth 12
# 检查 accepted、变化和输入后，从已确认回执复制哈希：
$confirmedHash = 'COPY_THE_CONFIRMED_PREVIEW_HASH_HERE'
& node examples/preview-bound-service.mjs --activate $confirmedHash @reviewArgs
if ($LASTEXITCODE -ne 0) { throw 'Activation failed' }
```

若Windows PowerShell捕获非ASCII HTTP正文时使用了其它编码，可在调用的子脚本内临时将 `[Console]::OutputEncoding` 设为 `[System.Text.UTF8Encoding]::new($false)`，并在finally恢复原值；无需更改全局设置或执行策略。

## Node 接口

```javascript
import {previewTransitionFiles} from './tools/change-review.mjs';
import {startReviewedService} from './examples/reviewed-service.mjs';
const preview = previewTransitionFiles({before, after, transitions});
// 将 preview 提交给调用者自己的检查/批准流程，保留已确认的哈希。
const active = await startReviewedService({
  before, after, transitions, expectedPreviewHash: confirmedPreviewHash
});
```

这里 before/after 是现有 `{file, fallbackFiles?, classpath?}` 描述符，transitions 沿用[值绑定计划](VALUE-BOUND-TRANSITIONS.md)。`previewTransitionFiles` 只支持该模式。新回执增加 `previewVersion`、`engineSHA256`、64位小写十六进制 `previewHash` 和只含路径的 `previewInputs`；输入描述符复制为绝对路径及有序列表，调用方之后修改自己的数组不会改变已返回的快照。服务的最终指纹复核读取使用该次捕获的 after 描述符。

`readReviewOptions(args)` 从 `tools/change-review.mjs` 导出，接收CLI的字符串参数数组，返回现有 `{before, after, rules或transitions, ...}` 选项。它读取并解析策略文件，保留原有524288字节的普通文件限制及安全JSON诊断，配置路径仍交由后续加载器处理。审查CLI和两步示例共享此读取器，避免各自维护不同的参数规则；它本身不审查配置或生成回执。

expectedPreviewHash 接受大小写十六进制SHA256。当前规则不通过仍抛 PolicyRejected；规则通过但预览指纹不匹配抛 PreviewChanged，其 report.accepted 为false、previewMatches 为false，且在创建监听前拒绝。非法哈希为输入错误。不传该选项的服务入口继续使用原合同。

同一示例模块还导出 `checkReviewedServiceConfig(options)`，接收与 `previewTransitionFiles` 相同的具体值迁移选项，返回增加上述标志的预览报告。策略拒绝返回报告，配置或应用字段错误仍抛原错误；它不会调用listen或返回实际字段值。例如：

```javascript
import {checkReviewedServiceConfig} from './examples/reviewed-service.mjs';
const checked = checkReviewedServiceConfig({before, after, transitions});
// 审阅 checked.accepted、checked.serviceConfigChecked 和变化，再批准其哈希。
```

## 指纹具体绑定什么

版本为 `hocon-transition-preview-v1`，使用SHA256核对：

- 解析后的完整迁移计划，包括精确路径和 beforeSource/afterSource 文本。
- 两侧的主文件绝对路径、有序 fallbackFiles 和 classpath。
- 实际读取的两侧资源路径、字节数及内容SHA256。
- 当前打包引擎文件的SHA256，以及有意义的变化/拒绝结果。

外层JSON空白、策略对象的键顺序和纯mtime变化不影响指纹。规则数组顺序及值源码文本属于计划；即使语义相同，修改它们仍需重新预览。配置文件注释、路径或字节变化也会改变指纹。路径按当前本地输入归一化，跨目录/机器移动材料应重新预览。指纹不是只对公开diff或排序后的文件集合做哈希；fallback/classpath优先级也被捕获。

完整计划只在内存中参与摘要，输出保留路径、顺序和资源/程序文件哈希等输入元数据。预期哈希应由调用者从已审查回执取得；审批人身份、签名、业务值合理性和部署权限仍由调用方负责。文件复核仍不是原子快照，程序及本地输入须可信，回执也不读取运行中旧服务的状态。

## 相关工作与本地验证

借鉴既有[先生成计划再执行](https://developer.hashicorp.com/terraform/cli/commands/plan)的两阶段工作方式；本项目只保存可核对的本地预览指纹，服务仍按当前文件读取并复核。通用JSON Schema方向已有[MoonCheck](https://github.com/sgy1023-crt/MoonCheck)和[moonschema](https://mooncakes.io/docs/moonbitstack/moonschema@0.2.0)，本轮增量是HOCON具体迁移的输入漂移核对，没有复制其实现、添加依赖或证明生态唯一。

第13轮把原先固定内置样本的两步消费者接上自带文件；这是脚本使用范围的补齐，未改变计划或指纹算法。`node tools/test-preview-script.mjs` 覆盖跨进程回执互通、中文/空格路径、相对路径、有序输入、实际HTTP和错误路径；直接相关的 `test-preview-binding.mjs`、`test-transition-policy-errors.mjs` 继续验证原模式及安全诊断。独立PowerShell消费者还核对JSON管道、早先回执、Unicode正文和0/2退出码，具体版本与结果随 `reports/hocon/deep-repair-13-max-20261028` 保存。

第17轮只补齐示例字段在批准前的检查入口。`node tools/test-service-config-check.mjs` 的14项检查覆盖不监听的检查、字段/端口错误、原getter转换、策略拒绝优先、CLI退出码和检查回执到实际HTTP的消费；直接受改动影响的33项预览绑定、15项脚本和6项旧服务消费者回归也通过。实现前保存的回执另经独立进程的新检查及HTTP启动验证。研究只比较了提前检查与跨目录回执两个候选，后者保持原有本地身份合同、未实现；研究及验收合同见 `reports/hocon/deep-repair-17-max-20261028`。

MoonBit核心及其公共API与生成引擎未变；本轮新增Node示例导出并复用既有启动检查。沿用先前编译产物并重新核对字节身份，不将其记为本轮后端重测。新增便携消费者检查已加入CI定义，入口尚未发布，也未进行远端CI或生产部署验证。
