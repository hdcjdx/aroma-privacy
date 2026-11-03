#!/bin/bash
# 部署 outputs/gh-pages/ 到 GitHub Pages（免费托管：升级站 + 隐私政策）
# 用法:  ./deploy.sh <GitHub用户名> <仓库名>
# 前置: 已安装 git；并已登录 GitHub：
#       方式A（推荐）: 终端先跑 `gh auth login`
#       方式B        : git 已配置 Personal Access Token（有 repo 权限）
#
# 部署后产出两个链接：
#   - 隐私政策 URL（填支付宝开放平台 → 智能香氛 → 隐私政策 URL）：
#       https://<用户名>.github.io/<仓库名>/privacy_policy.html
#   - 升级站首页：
#       https://<用户名>.github.io/<仓库名>/
set -e
USER="$1"
REPO="$2"
if [ -z "$USER" ] || [ -z "$REPO" ]; then
  echo "用法: ./deploy.sh <GitHub用户名> <仓库名>"
  exit 1
fi

cd "$(dirname "$0")"

# 初始化并提交（已初始化则跳过）
if [ ! -d .git ]; then
  git init -q
  git branch -M main
fi
git add -A
if git diff --cached --quiet; then
  echo "（无新改动，跳过提交）"
else
  git commit -q -m "智能香氛 升级站 + 隐私政策 (GitHub Pages)"
fi

# 设置远端并推送
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$USER/$REPO.git"
git push -u origin main

echo ""
echo "✅ 已推送到 https://github.com/$USER/$REPO"
echo "⏭  下一步（只需做一次）:"
echo "   1) 打开 https://github.com/$USER/$REPO → Settings → Pages"
echo "   2) Source 选 [main] 分支 / [/(root)] 目录 → Save"
echo "   3) 约 1-2 分钟后生效"
echo ""
echo "📎 拿到的链接："
echo "   隐私政策(填支付宝): https://$USER.github.io/$REPO/privacy_policy.html"
echo "   升级站首页        : https://$USER.github.io/$REPO/"
echo ""
echo "👉 把『隐私政策』那个链接填进 支付宝开放平台 → 小程序「智能香氛」→ 隐私政策 URL"
