#!/bin/bash

# 变量设置
PATCH_REPO="https://github.com/creamlike1024/m-isle-moe-patch"
REPO_BRANCH="main"
NEKO_PUSH_URL="https://push.meowbot.page"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 下载 patches.txt
wget -O patch-list.txt $PATCH_REPO/raw/$REPO_BRANCH/patches.txt

# 一行一行读取 patch-list.txt，并下载 patch 进行合并
while read -r line || [[ -n "$line" ]]; do
    # 如果为空行，跳过
    if [ -z "$line" ]; then
        continue
    fi
    wget -O current.patch $PATCH_REPO/raw/$REPO_BRANCH/"$line"
    # git 合并 patch，如果失败则发送通知到 NekoPush
    git apply --whitespace=fix --unidiff-zero current.patch
    # 如果退出码不为 0，说明 git apply 失败
    if [ $? -ne 0 ]; then
        echo -e "${RED}failed to apply:${NC}" "$line"
        # 静默发送 get 请求，其中 NEKO_PUSH_TOKEN 为外部环境变量
        curl -s -o /dev/null -X GET "$NEKO_PUSH_URL/push?token=$NEKO_PUSH_TOKEN&text=$line%20failed%20to%20apply." && echo "notification sent."
    else
        echo -e "${GREEN}applied:${NC}" "$line"
    fi
    rm current.patch
done <patch-list.txt
rm patch-list.txt

echo "Patch finished."
