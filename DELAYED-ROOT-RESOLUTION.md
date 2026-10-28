# 派生延迟对象的部分求值

`getConfig` / `get_config` 可以保留仍有替换的对象，再与其它配置组合。未知合并层可能覆盖更低优先级的键，`allowUnresolved` 不会把这种不确定性当成键不存在。

```javascript
import {Config} from './tools/config.mjs';
const parent = Config.parse('a=${missing}\na={known=1}');
const child = parent.getConfig('a');
const next = child.withFallback(Config.parse('outside=3\nresult=${outside}'));
next.resolve({allowUnresolved:true}); // ConfigError: unresolved object lookup
```

这里 `a` 肯定是对象，但尚未求值的 `${missing}` 仍可能提供或遮蔽 `outside`。不能越过这一层，直接使用 fallback 中的 3。2026-10-28 本地修复使求值访问仍有贡献的低优先级对象，并保留原根的查询屏障；此前会错误地成功返回部分树。解析输入、保留未解析树和原父配置仍可使用；错误发生在这一步尚不能确定查询目标的求值。

正常路径继续保留：追加没有替换的 `outside=3` 可以得到部分树，`known` 仍可读；更高优先级的已知标量可以遮蔽低层并作为替换目标。调用方也可在给父配置补足来源并完成求值后，再提取子配置。`allowUnresolved`、fallback 和公开 API 未新增参数或错误变体。

MoonBit 对应 `with_fallback` / `value_with_fallback` 及 `resolve(..., allow_unresolved=true)`。本例抛现有 `ParseError.Invalid("unresolved object lookup")`；不承诺完整 Java 异常类型、错误全文或所有错误的位置。

依据是固定 [ConfigDelayedMerge v1.4.9](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigDelayedMerge.java) 的原始来源查询规则，以及 [ConfigDelayedMergeObject](https://raw.githubusercontent.com/lightbend/config/v1.4.9/config/src/main/java/com/typesafe/config/impl/ConfigDelayedMergeObject.java) 对隐藏键的拒绝。两者按上游 Apache-2.0 许可提供；本项目源码仍为 MIT，没有复制其实现。

本次相关 JS/Wasm-GC 各45项通过，新增三项最小回归含拒绝和两个可用对照；独立 native 消费模块运行同三场景。2688个同输入持久化程序经未修改的 Config 1.4.9 获取参考，修复前8处差异、修复后为0，原失败程序另经8次异步 Worker 重放通过。真实 HTTP 消费者六组回归通过。这是有限差分和消费者证据，不是全量 HOCON/JVM 认证。

最小回归可运行 `moon test delayed_root_resolution_test.mbt --target js --deny-warn`，或将目标换为 `wasm-gc`。完整本轮原始请求、失败、命令、源身份及 native 消费模块随 `reports/hocon/deep-repair-06-max-20261028` 回执保留。
