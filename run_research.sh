#!/usr/bin/env bash
# オーケストレータ: 収集 → 深掘り → GitHubへpush。
# cron か Claude Code の /loop から毎朝実行する。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

# スマホ (GitHub Mobile) からの編集を取り込む。オフライン/競合でもループは止めない
git pull --rebase --autostash origin main 2>/dev/null || echo "[pull] スキップ (オフラインor競合)"

echo "===== Research Loop $(date +'%F %T') ====="

# Stage 1: arXiv 収集
python3 fetch_candidates.py

# Stage 2: Claude で選別 + 深掘りブリーフ
./deep_research.sh

# Stage 3: GitHub へ push (公開情報のブリーフのみ)
DATE="$(date +%F)"
if [[ -d briefs/$DATE ]]; then
  git add briefs/
  git commit -m "research: daily briefs $DATE" || echo "[push] 変更なし"
  git push origin main && echo "[push] GitHubへ push 完了" \
    || echo "[push] push 失敗 — リモート設定を確認"
fi

echo "===== 完了。下流で pull_experiments.sh を実行して実験化 ====="
