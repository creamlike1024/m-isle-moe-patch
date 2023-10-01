# m-isle-moe-patch
Misskey patches used in m.isle.moe

这个仓库包含了 [m.isle.moe](https://m.isle.moe) 所应用的 Misskey 补丁，目前有以下修改：
- `0001-remove-Look-for-another-instance-button.patch` 移除访客首页的“探索其它服务器”按钮
- `0001-replace-special-thanks-to-site-patch-info.patch` 替换关于 Misskey 页面的 Special thanks 为本站 patch 信息
- `0001-auto-extend-note-content.patch` 自动展开帖子详情页的回复内容，适用于 Misskey 2023.9.1 之后的版本
- ~~`0001-remove-mention-notification.patch` 移除“提到我的”通知~~ 不再需要
- ~~`0001-fix-timeout-when-querying-mentions.patch` 修复“提到我的”通知加载失败问题~~ 不再需要，13.14.2 在下一个 Release 发布前应用[修复](https://github.com/misskey-dev/misskey/pull/11799)的临时补丁

## 应用补丁

在 github action  中添加一步：
```yaml
-
  name: Apply Patch
  env:
    NEKO_PUSH_TOKEN: ${{ secrets.NEKO_PUSH_TOKEN }}
  run: |
    curl -s -L https://github.com/creamlike1024/m-isle-moe-patch/raw/main/patch.sh | bash
```

脚本使用了 [NekoPush](https://github.com/MeowBot233/NekoPush) 用于在补丁应用失败时发送 Telegram 通知，需在 action 仓库中设置 名为 `NEKO_PUSH_TOKEN` 的 secret。如果不需要，可修改脚本移除相关内容


如果不使用 github action，直接在仓库目录下执行脚本：
```bash
curl -s -L https://github.com/creamlike1024/m-isle-moe-patch/raw/main/patch.sh | bash
```
可以修改脚本去除 NekoPush 通知
