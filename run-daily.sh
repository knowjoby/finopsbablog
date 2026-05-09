#!/usr/bin/env bash
# FinOps Blog — Daily Push Helper
# Usage: GITHUB_TOKEN=your_token_here bash run-daily.sh
# Or:    export GITHUB_TOKEN=ghp_xxxx; bash run-daily.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌  GITHUB_TOKEN is not set."
  echo "    Run: export GITHUB_TOKEN=ghp_your_token_here"
  exit 1
fi

# Set authenticated remote URL
git remote set-url origin "https://knowjoby:${GITHUB_TOKEN}@github.com/knowjoby/finopsbablog.git"

git add _posts/ state/ 2>/dev/null || true
git add -A 2>/dev/null || true

DATE=$(date +%Y-%m-%d)
git commit -m "Daily drop: ${DATE} — 5 posts" || echo "Nothing new to commit"
git push origin main

# Reset remote URL to non-token version (don't store token in git log)
git remote set-url origin "https://github.com/knowjoby/finopsbablog.git"

echo "✅ Pushed to GitHub. Site rebuilds in ~60 seconds at https://knowjoby.github.io/finopsbablog"
