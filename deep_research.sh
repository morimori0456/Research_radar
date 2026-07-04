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
   - hf_upvotes はコミュニティ注目度(SNS話題性の代替)。relevance を上書きしない
     副次シグナルとして扱い、同点時のタイブレークに使う
   - topic=sns_wildcard の候補は「分野外だが注目度が高い」探索枠。
     学びの価値があれば最大1件まで選んでよい (視野を広げるための枠)
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

スタイル規則 (重要):
- 専門用語・手法名は英語のまま書く。無理に日本語訳しない
  (例:「等角予測」ではなく conformal prediction、「世界モデル」ではなく world model)
- 初出の専門用語には括弧か1文で平易な説明を付ける。読者は ML 実務者だが、
  その論文のサブ分野は初見という前提で書く
  (例: "conformal prediction (予測の外れ率を分布仮定なしで保証する統計手法) を...")
- 説明なしで使ってよいのは基礎語だけ (loss, transformer, fine-tuning, encoder 等)
- 略語は初出で必ず展開+一言説明する
  (例: "GRPO (Group Relative Policy Optimization; PPOの簡略版でLLMのRL学習に使う)"、
   "TTC (Time-to-Collision; 衝突までの残り時間)")。2回目以降は略語のみでよい
- DIGEST の TOP3 も同じ規則。専門用語の羅列で理由を書かない

topics.yaml と candidates.json を読んで実行せよ。
EOF
)

# Claude をヘッドレス実行
claude -p "$PROMPT" --dangerously-skip-permissions

echo "[deep] 完了: $OUTDIR"
ls -la "$OUTDIR"
