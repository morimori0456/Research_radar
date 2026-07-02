#!/usr/bin/env bash
# Stage 2: Claude で候補を選別し、選ばれたものだけ深掘りブリーフ生成。
# 出力は briefs/YYYY-MM-DD/ 配下。公開情報(arXiv)のみを扱う。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

DATE="$(date +%F)"
OUTDIR="briefs/$DATE"
mkdir -p "$OUTDIR"

if [[ ! -f candidates.json ]]; then
  echo "[deep] candidates.json がない。先に fetch_candidates.py を実行" >&2
  exit 1
fi

N=$(jq '.candidates | length' candidates.json)
echo "[deep] $N 候補をClaudeで処理"

PROMPT=$(cat <<EOF
あなたはリサーチアシスタント。candidates.json に arXiv の新着候補がある。
これは arXiv の公開情報のみ。

タスク:
1. 各候補を relevance_criteria (topics.yaml参照) で0-5点評価し、選別する
2. トピックごとの quota と全体の max_deep_per_day の上限内で、高得点のものだけ選ぶ
3. 選ばれた各論文について、abstract と (必要なら) 公開情報から
   深掘りブリーフを briefs/$DATE/<arxiv-id>.md に1件1ページで作成:
   - 何を解決する論文か (2-3文)
   - 手法の核心 (箇条書き3-5点)
   - 追っているプロジェクト(P1/P2/P3)への適用可能性と、試すべき実験アイデア
   - 元論文URL
4. 選ばれなかった候補は briefs/$DATE/rejected.md に「id: title — 落とした理由」で記録
5. 最後に briefs/$DATE/DIGEST.md を作成:
   - 冒頭に「今日読むべきTOP3」を理由付きで
   - 続いて全ブリーフへのリンク一覧
   - プロジェクト別の要点

topics.yaml と candidates.json を読んで実行せよ。
EOF
)

# Claude をヘッドレス実行
claude -p "$PROMPT" --dangerously-skip-permissions

echo "[deep] 完了: $OUTDIR"
ls -la "$OUTDIR"
