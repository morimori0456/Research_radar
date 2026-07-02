#!/usr/bin/env bash
# 下流側: リサーチリポジトリを pull し、実験スクリプトの雛形を生成する。
# 別マシン/別リポジトリで使う想定。結果は実験リポジトリに閉じ、リサーチ側へは戻さない。
#
# Usage: ./pull_experiments.sh [YYYY-MM-DD]
#   日付省略時は今日のブリーフを対象にする。
set -euo pipefail

: "${RESEARCH_REPO:?リサーチリポジトリのローカルパスを RESEARCH_REPO に設定}"
: "${EXPERIMENT_REPO:?実験スクリプトを置くリポジトリのパスを EXPERIMENT_REPO に設定}"

DATE="${1:-$(date +%F)}"

# 1. リサーチを pull (read-only に扱う)
echo "[pull] $RESEARCH_REPO を更新"
git -C "$RESEARCH_REPO" pull --ff-only

BRIEFDIR="$RESEARCH_REPO/briefs/$DATE"
if [[ ! -d "$BRIEFDIR" ]]; then
  echo "[pull] $DATE のブリーフがない" >&2
  exit 1
fi

# 2. Claude Code で、ブリーフ → 実験スクリプト雛形を生成
cd "$EXPERIMENT_REPO"
PROMPT=$(cat <<EOF
$BRIEFDIR/DIGEST.md と各ブリーフを読め。これは公開論文のリサーチ結果。

タスク: TOP3 の中から、今週試す価値が最も高い1件を選び、
それを検証する最小実験スクリプトの雛形を experiments/$DATE/ に作成せよ:
- README.md — 何を検証するか、仮説、成功条件
- run.py — 実験の骨組み (データ読み込み・モデル・評価のスタブ)
- 既存のコード資産があれば流用し、なければ TODO コメントで明示

重要: このリポジトリのデータやパスを外部に出さない。
生成後、experiments/$DATE/ の内容を要約して報告せよ。
EOF
)

claude -p "$PROMPT"

echo "[pull] 実験雛形を生成。experiments/$DATE/ を確認せよ。"
