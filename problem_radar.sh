#!/usr/bin/env bash
# 課題レーダー (週次): 論文でなく「世の中の課題」を収集する。Innovator の入力ループ。
# 技術radar が「解き方」を集めるのに対し、これは「解くべき問題」を集める。
# cron で週1回 (水曜夜) 実行する想定。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

WEEK="$(date +%G-W%V)"
OUTDIR="problems"
mkdir -p "$OUTDIR"

PROMPT=$(cat <<EOF
あなたは事業機会のリサーチャー。対象者は自動運転/ロボティクスのMLエンジニアで、
将来イノベーター (課題を深く理解しプロダクトを出す人) になるために
「世の中の課題」のストックを作っている。LIFE_PLAN.md を読んで文脈を掴め。

ウェブ検索が使えるなら、直近1-2週間の以下を調べよ:
- 自動運転/ロボティクス/モビリティ業界のニュース (事故・リコール・規制・撤退・提携)
- 関連スタートアップの資金調達・ピボット・破綻
- 物流/製造/建設/農業など隣接ドメインの人手不足・自動化ニーズの報道
検索が使えなければ、知識の範囲で書き、その旨を明記せよ。

$OUTDIR/$WEEK.md を作成せよ。構成:

## 今週の業界の動き (5行以内)
事実だけ。ソースがあればURLを添える。

## 課題カード (3枚)
それぞれ以下のフォーマット:
### 課題: <一言で>
- 誰が困っているか / どれくらい深刻か (金額・人数の粗い規模感)
- なぜまだ解決されていないか (技術? コスト? 規制? 商流?)
- 既存プレイヤーとその限界
- 対象者の技術 (planning/蒸留/VLA/評価) との接続可能性
- 検証するなら最初の一歩は何か (1週末でできる粒度)

## ストックへの示唆
過去の課題カード ($OUTDIR/ 配下) と見比べ、繰り返し現れるテーマがあれば指摘。
「深く理解すべき課題ドメイン」の候補が浮かんでいれば1つ推す。

スタイル規則: 専門用語は英語のまま。初出の用語・略語には1行の説明。
全体で2ページ以内。事実と推測を区別せよ。
EOF
)

claude -p "$PROMPT" --dangerously-skip-permissions

if [[ -f "$OUTDIR/$WEEK.md" ]]; then
  git add "$OUTDIR/"
  git commit -m "problems: weekly problem radar $WEEK" || echo "[problem] 変更なし"
  git push origin main && echo "[problem] push 完了" || echo "[problem] push 失敗"
fi

echo "[problem] 完了: $OUTDIR/$WEEK.md"
