# 当前判断

2026-09-23 更新：HOCON 语义本身是既有成果；本地 0.24.0 的增量是 MoonBit 迁移差异闸门，实际双引擎运行与退出码见 MIGRATION-GATE.md。仍无确认迁移用户，也未证明全量兼容。以下保留 9 月 22 日历史检索，不把“未找到同范围包”当成本次价值论据。

> 2026-09-22 三份初审反馈后的当前判断：**保留候选**。尚无确认迁移用户，不能把全套 JVM 行为或性能作为已完成。 本次差异说明：本轮未找到同范围 MoonBit HOCON 库；其他配置库当然存在。价值是兼容这个明确的配置格式，不是首次变量替换或配置读取。 以下保留之前检索的固定提交与来源；此前“补足场景”不能理解为本次已解除价值异议。

# hocon 查重与定位 · 2026-09-22

本轮未找到同范围 MoonBit HOCON 库；其他配置库当然存在。价值是兼容这个明确的配置格式，不是首次变量替换或配置读取。 检索原始响应在总交付包的创新性复核目录保存。



本轮材料采用定位：**HOCON 配置迁移与启动校验**。

MoonBit 与宿主分工：MoonBit 解析和求值，Node 提供文件/HTTP、环境注入与不可变对象宿主；Java 只用于独立对照。

本轮证据：本轮修复改名后命令包仍引用旧模块而无法构建的问题，重新生成 API/JS 引擎；双后端和文件宿主检查通过。 具体输入、脚本、已执行与历史对照分开记录在 [PROPOSAL.md](PROPOSAL.md) 和 evidence/innovation-review-20260922/。

边界：Lightbend 全套行为和所有平台未完全等价；环境变量须显式注入，HTTP(S) 默认可用，离线加载须指定 `--no-network` 或 `network: false`。

检索覆盖 Mooncakes 官方关键词/别名、GitHub 仓库查询、GitLink 公开索引、直接来源文档；没有完整赛事报名表、私有仓库、未公开分支或 GitHub 全代码索引。GitLink 索引也不完整。未找到同范围项目不等于生态空白；已有相关项目不自动等于无独立贡献。完整查询和固定提交快照在总交付目录 innovation-review-20260922/。

初次复核风险为“待补场景”。本次补足差异和可复现工作流，没有自行将重叠归零，也不替评委作创新性认定。最终公开代码与表单附件须使用一致版本。

## 来源直达

[Lightbend Config 1.4.9](https://github.com/lightbend/config/releases/tag/v1.4.9)、[HOCON 规范](https://github.com/lightbend/config/blob/main/HOCON.md)。这些是既有规范/实现的来源；具体固定版本、适配与运行范围见 [完整说明](README-BEFORE-VALUE-REWORK.md) 和仓库验证记录。链接存在不代表本轮重新运行了对方实现，也不构成赛事无重复证明。

2026-09-27定向复查：moonbitstack/moonjson当前JSON系列、moonbitlang/moon_config模块配置、crh12354/moonconfigkit的INI/properties属于相邻能力，未据此发现同域HOCON求值包；此为有限检索结果，不是生态空白证明。Lightbend Config是成熟参考实现，本项目是移植/接入价值，不是新配置语言。公开真实输入补充见OPENWHISK.md，未确认真实用户。

## 2026-10-28 值绑定迁移计划的定位

新接口在两份已求值 HOCON 树之间核对精确的旧值与目标值，要求变化集和计划完整匹配；用于阻止路径批准被复用于错误目标或漂移基线。它沿用[RFC6902 test](https://datatracker.ietf.org/doc/html/rfc6902#section-4.6)已有的值前置条件思想，没有实现JSON Patch或宣称发明审批机制。

本轮查看 [moonschema 0.2.0](https://mooncakes.io/docs/moonbitstack/moonschema@0.2.0) 的Json树验证接口、[MoonCheck](https://github.com/sgy1023-crt/MoonCheck)基于mizchi/jsonschema的CLI定位、[moon_config](https://mooncakes.io/docs/moonbitlang/moon_config@0.4.5)模块配置解析，以及[moonjson 0.4.0](https://mooncakes.io/docs/moonbitstack/moonjson@0.4.0)已打开文档中的解析/Pointer接口。通用Schema方向已有成熟相关工作，因此没有另写验证器；JSON Patch的既有思想则明确归因。本轮没有引入或复制它们的实现，也没有凭有限检索证明生态唯一。增量、可运行消费者和未支持项见[值绑定迁移计划](VALUE-BOUND-TRANSITIONS.md)。

## 2026-10-28 预览指纹的消费增量

本轮沿[Terraform计划命令](https://developer.hashicorp.com/terraform/cli/commands/plan)与[执行命令](https://developer.hashicorp.com/terraform/cli/commands/apply)的既有两阶段工作思路，加入本地HOCON预览指纹核对。它绑定解析后的具体值规则、文件读取指纹及有序输入选项，并在独立服务启动调用中验证先前哈希；不实现基础设施执行计划。基线证明，同步更新目标和规则能合法通过旧合同，而fallback优先级变化甚至可保留完全相同的旧报告。

再次核对[MoonCheck](https://github.com/sgy1023-crt/MoonCheck)及[moonschema](https://mooncakes.io/docs/moonbitstack/moonschema@0.2.0)的Schema/CLI范围后，没有另写验证器或复制其实现。有限生态检索不证明唯一性；本轮没有新增依赖、签名身份系统或部署执行器。具体兼容与验证见[两步启动](PREVIEW-BOUND-ACTIVATION.md)。

第13轮的有限增量是让该示例直接接收用户文件及现有有序输入参数。基线中，通用CLI已能预览自带文件，固定样本的示例却拒绝这些启动参数；通过共享参数读取器补齐这段脚本接入，不另写Schema、计划算法或应用执行器。实现前重新查阅上述MoonCheck、moonschema及Terraform计划文档并冻结使用合同；验证覆盖独立Node进程和Windows PowerShell JSON消费，未声称其它平台的shell或远端部署已验证。

## 2026-10-28 批准前的示例字段检查

第17轮比较提前检查示例字段与跨目录回执两个需求。选择前者：复用应用已有的HOCON getter、端口范围和文件指纹核对，提供 `--check` / `checkReviewedServiceConfig`，无需开启HTTP监听即可在批准前发现示例字段错误；普通迁移预览与v1回执保持兼容。跨目录复用会改变当前绝对路径绑定合同，缺少确认需求，本轮未实现。

提前检查是既有工作方式，例如[Caddy validate](https://caddyserver.com/docs/command-line#caddy-validate)会在启动前检查加载/初始化。本示例只检查自己消费的两个字段，不实现Caddy的模块初始化。[Lightbend checkValid](https://lightbend.github.io/config/latest/api/com/typesafe/config/Config.html)的通用结构检查也不覆盖所有应用约束。当前[MoonCheck](https://github.com/sgy1023-crt/MoonCheck)是mizchi/jsonschema上的批量/CI前端，[moonschema](https://mooncakes.io/docs/moonbitstack/moonschema@0.2.0)提供通用JSON Schema；本增量没有重写Schema引擎或添加依赖，只补齐已有HOCON批准流程中示例应用的检查接入。未确认外部采用，也不以有限检索证明唯一性。
