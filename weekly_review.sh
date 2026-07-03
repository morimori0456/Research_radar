#!/usr/bin/env bash
# 週次レビュー: 今週のブリーフを統合し、「読む」を「成長」に変換する。
# 日次の DIGEST が入口、この WEEKLY が定着と実行のチェックポイント。
# cron で週1回 (日曜夜) 実行する想定。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

WEEK="$(date +%G-W%V)"
OUTDIR="weekly"
mkdir -p "$OUTDIR"

# 直近7日分のブリーフディレクトリを列挙
DIRS=$(find briefs -maxdepth 1 -type d -name '20*' -newermt '7 days ago' | sort)
if [[ -z "$DIRS" ]]; then
  echo "[weekly] 直近7日のブリーフがない" >&2
  exit 0
fi

PROMPT=$(cat <<EOF
あなたは学習コーチ兼リサーチアシスタント。
以下のディレクトリに今週の日次ブリーフ (DIGEST.md と各論文ブリーフ) がある:

$DIRS

これらを全て読み、$OUTDIR/$WEEK.md を作成せよ。目的は「読んだ」を「身についた・
動いた」に変換すること。構成:

## 1. 今週のテーマ統合 (5行以内)
日次では見えない週単位の潮流。複数ブリーフを貫くテーマを接続する。

## 2. 今週の精読1本
ブリーフでなく原論文を自分で読むべき1本を選び、理由と「読むときの問い」を
3つ添える。選定基準: 手法の理解が今後数ヶ月効くもの > 話題性。

## 3. 実験アイデアの棚卸し
各日次ブリーフの「試すべき実験アイデア」を全て列挙し、
実験化された形跡がないものを「未着手」として明示。
その中から今週着手すべき1件を推薦。

## 4. 記憶チェック (5問)
今週のブリーフから、1週間後に思い出せるべき要点をQ&A形式で5問。
(例: Q: DIST が KL でなく Pearson 相関を使う理由は? A: ...)

## 5. topics.yaml への提案
今週の選別を振り返り、キーワード追加/削除や relevance_criteria の
調整案があれば提案。なければ「変更不要」と書く。

## 6. 出力キュー (入力→公開物への変換)
今週読んだものの中から「知識リポジトリ (md+実行可能notebook) にまとめる価値が
最も高い1テーマ」を選び、レポートのアウトライン (セクション構成と
notebookで実証すべきポイント3つ) を書く。
選定基準: 数ヶ月後も価値が残る内容 > 今週だけの新しさ。
読むだけで終わった週が続いていたら、その旨を率直に指摘する。

トーンは簡潔に。全体で2ページ以内。
EOF
)

claude -p "$PROMPT" --dangerously-skip-permissions

if [[ -f "$OUTDIR/$WEEK.md" ]]; then
  git add "$OUTDIR/"
  git commit -m "research: weekly review $WEEK" || echo "[weekly] 変更なし"
  git push origin main && echo "[weekly] push 完了" || echo "[weekly] push 失敗"
fi

echo "[weekly] 完了: $OUTDIR/$WEEK.md"
