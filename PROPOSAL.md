# HOCON 配置迁移与变更审查：让最终生效配置可核对

项目仓库：https://github.com/uiwcvb/moonbit-hocon；模块 `uiwcvb/hocon`，本地 0.25.0，MIT；个人项目。

## 问题与适用场景

既有 HOCON 配置迁入 MoonBit 应用时，include、变量替换和 fallback 会共同决定最终值。一次看似只改端口的提交，可能连带改变引用它的字段；主文件未变也可能受到 include 变化影响。项目面向需要保留既有 HOCON 行为、并审查配置变化的程序，而非要求所有应用采用 HOCON。

## 实现与贡献

MoonBit 核心完成解析、求值、类型读取和配置树差异；新增 `review_config_changes` 将前后两棵已求值树与精确允许清单比较。规则区分字面键、嵌套路径及增删改类别，不把允许叶子修改扩大为允许父对象删除；报告只有路径与类型，不携带配置值。未求值输入、非法规则与超过预算的结果拒绝，JS/Wasm-GC 共用同一判断。

不可变 JS Config 对象保留 MoonBit 树，新 `reviewChanges` 不通过 JS Number 重建数据，因此大于 2^53 的相邻整数仍能区分。文件入口读取两侧显式 include/fallback/classpath，记录并重验输入指纹，未允许的变化返回非零。另一迁移闸门用独立 Lightbend Config 1.4.9 核对跨实现解析结果；Java 只是验证参考。

## 可复现证据

仓库保留 Apache OpenWhisk 固定提交的未经改写配置、两个 include、fallback、哈希和许可。既有读取对照涵盖 36 条叶路径及 11 项类型读取；新增用例在副本上覆盖端口修改、include 中日志级别漂移、主文件哈希不变、非法清单和大整数精度。端口与 include 变更两侧完整树另经 Java 实现核对，只有显式允许的变化被接受。

2026-09-29 本地 JS/Wasm-GC 各 16727 项测试通过，新增 6 组变更审查检查与既有 54 项宿主回归通过。`CHANGE-REVIEW.md` 提供公共 API、CLI、退出码、预算及复现步骤，CI 已加入该场景。公开配置不是客户采用证明，也没有运行完整 OpenWhisk。

## 与已有工作的关系及边界

承认 Lightbend Config 的成熟实现，不主张 HOCON 语义或解析算法首创。面向 MoonBit 的交付是可组合的配置对象、精确变更合同和跨实现迁移核验。即使配置由 AI 生成，间接变化、数值精度、确定性失败和独立参考仍可由这些接口检查。

没有已确认迁移用户。变更允许清单不证明新值正确或部署安全；可信文件入口使用空环境、禁用 HTTP，重验读取不是原子快照，调用方仍需业务验证。0.24.1 已公开；本地 0.25.0 尚未推送、发布或同步报名表，旧公开 CI 不证明新代码。复现见 README、CHANGE-REVIEW 与 evidence/openwhisk-change-review.json。
