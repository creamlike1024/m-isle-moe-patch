#!/bin/bash

# 变量设置
PATCH_REPO="https://github.com/creamlike1024/m-isle-moe-patch"
REPO_BRANCH="main"
NEKO_PUSH_URL="https://push.meowbot.page"

# 下载 patches.txt
wget -O patch-list.txt $PATCH_REPO/raw/$REPO_BRANCH/patches.txt

# 一行一行读取 patch-list.txt，并下载 patch 进行合并
while read line
do
    # 如果为空行，跳过
    if [ -z "$line" ]; then
        continue
    fi
    wget -O current.patch $PATCH_REPO/raw/$REPO_BRANCH/"$line"
    # git 合并 patch，如果失败则发送错误信息并退出
    git apply --whitespace=fix --unidiff-zero current.patch
    if [ $? -ne 0 ]; then
        echo $line "failed to apply."
        # 静默发送 get 请求，其中 NEKO_PUSH_TOKEN 为外部环境变量
        curl -s -o /dev/null "$NEKO_PUSH_URL?/push?token=$NEKO_PUSH_TOKEN&text=$line" failed to apply."" && echo "notification sent."
    fi
    rm current.patch
done < patch-list.txt

echo "Patch finished."
