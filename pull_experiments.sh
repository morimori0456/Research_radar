#!/usr/bin/env bash
# 会社PC側: 個人GitHubのリサーチをpullし、実験スクリプトの雛形を生成する。
# このスクリプトは会社PCに置いて使う。結果は社内リポジトリに閉じ、個人側へは戻さない。
#
# Usage: ./pull_experiments.sh [YYYY-MM-DD]
#   日付省略時は今日のブリーフを対象にする。
set -euo pipefail

: "${RESEARCH_REPO:?個人リサーチリポジトリのローカルパスを RESEARCH_REPO に設定}"
: "${EXPERIMENT_REPO:?実験スクリプトを置く社内リポジトリのパスを EXPERIMENT_REPO に設定}"

DATE="${1:-$(date +%F)}"

# 1. 個人GitHub のリサーチを pull (read-only に扱う)
echo "[pull] $RESEARCH_REPO を更新"
git -C "$RESEARCH_REPO" pull --ff-only

BRIEFDIR="$RESEARCH_REPO/briefs/$DATE"
if [[ ! -d "$BRIEFDIR" ]]; then
  echo "[pull] $DATE のブリーフがない" >&2
  exit 1
fi

# 2. 会社PCの Claude Code で、ブリーフ → 実験スクリプト雛形を生成
cd "$EXPERIMENT_REPO"
PROMPT=$(cat <<EOF
$BRIEFDIR/DIGEST.md と各ブリーフを読め。これは公開論文のリサーチ結果。

タスク: TOP3 の中から、自社で今週試す価値が最も高い1件を選び、
それを検証する最小実験スクリプトの雛形を experiments/$DATE/ に作成せよ:
- README.md — 何を検証するか、仮説、成功条件
- run.py — 実験の骨組み (データ読み込み・モデル・評価のスタブ)
- 既存の社内コード資産があれば流用し、なければ TODO コメントで明示

重要: 社内データやパスをこのリポジトリの外に出さない。
生成後、experiments/$DATE/ の内容を要約して報告せよ。
EOF
)

claude -p "$PROMPT"

echo "[pull] 実験雛形を生成。thor_pipeline に載せて実装する場合:"
echo "       cd ~/thor_pipeline && ./dispatch.sh $(basename "$EXPERIMENT_REPO") task/exp-$DATE"
