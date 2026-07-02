#!/usr/bin/env bash
# 個人側オーケストレータ: 収集 → 深掘り → 個人GitHubへpush。
# cron か Claude Code の /loop から毎朝実行する。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

echo "===== Research Loop $(date +'%F %T') ====="

# Stage 1: arXiv 収集
python3 fetch_candidates.py

# Stage 2: 個人Claude で選別 + 深掘りブリーフ
./deep_research.sh

# Stage 3: 個人GitHub へ push (公開情報のブリーフのみ)
DATE="$(date +%F)"
if [[ -d briefs/$DATE ]]; then
  git add briefs/
  git commit -m "research: daily briefs $DATE" || echo "[push] 変更なし"
  git push origin main && echo "[push] 個人GitHubへ push 完了" \
    || echo "[push] push 失敗 — リモート設定を確認"
fi

echo "===== 完了。会社PCで pull_experiments.sh を実行して実験化 ====="
