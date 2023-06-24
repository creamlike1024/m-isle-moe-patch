# m-isle-moe-patch
Misskey patches used in m.isle.moe

这个仓库包含了 [m.isle.moe](https://m.isle.moe) 所应用的 Misskey 补丁，目前有以下修改：
- `0001-remove-Look-for-another-instance-button.patch` 移除访客首页的“探索其它服务器”按钮
- `0001-remove-mention-notification.patch` 移除“提到我的”通知
- `0001-replace-special-thanks-to-site-patch-info.patch` 替换关于 Misskey 页面的 Special thanks 为本站 patch 信息

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

需在 action 仓库中设置 名为 `NEKO_PUSH_TOKEN` 的 secret 用于 patch 失败时通过 [NekoPush](https://github.com/MeowBot233/NekoPush) 发送通知。如果不需要，可修改脚本移除相关内容


如果不使用 github action，直接在仓库目录下执行脚本：
```bash
curl -s -L https://github.com/creamlike1024/m-isle-moe-patch/raw/main/patch.sh | bash
```
可以修改脚本去除 NekoPush 通知