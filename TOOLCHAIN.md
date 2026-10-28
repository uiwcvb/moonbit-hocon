# 可复现的 MoonBit 工具链

CI读取根目录 `.moonbit-version`，通过官方安装器取得 `0.10.14+7d59c7ec9` 的编译器和标准库；不再随 latest 漂移。这个发行版的 `moonc` 为 v0.10.14+7d59c7ec9，`moon/moonrun` 为 0.1.20260920（914d7da）。`moon`/`moonrun` 与 `moonc` 的版本号不同是该发行版的正常组成。

Linux/macOS安装：

```sh
curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash -s -- "$(cat .moonbit-version)"
moon version --all
moon update
```

Windows安装器支持 `MOONBIT_INSTALL_VERSION`；也可以继续使用已验证的本地工具链。版本安装方式见 [MoonBit官方说明](https://www.moonbitlang.com/updates/page/5)。本地Windows工具链已通过 `moon version --all` 核对；本地验证不等于GitHub runner已经执行。

CI先执行 `moon update` 初始化注册表及解析依赖，再进行fmt/info/check；不能依赖开发机已有的registry或.mooncakes缓存。

升级时先修改版本文件，在独立目录执行fmt/info/check和受影响测试，更新生成API与编译引擎，再一起提交。不要通过删除确定性检查掩盖版本引起的差异。Node/Python、操作系统和外部服务仍有各自环境范围；固定MoonBit不意味着所有依赖完全冻结。

GitHub Actions 使用 Ubuntu 24.04、Node 24.11.0 和固定提交的官方 Action；安装器先校验 SHA-256，再按 `.moonbit-version` 安装到 runner 临时目录。Java 21 的实际版本、MoonBit/Node 版本、提交 SHA 和本次构建的浏览器引擎哈希会写入 `quality-evidence`。所有消费者检查使用本次编译的 `web/engine.mjs`。当前 CI 结论以相同提交的运行记录为准；本次不发布 Mooncakes。
