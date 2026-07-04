#!/usr/bin/env bash
# 月次レビュー: 「入力」以外の3要素 (練習・出力・外部フィードバック) を管理する。
# 日次=入力、週次=定着、月次=方向修正。cron で毎月1日に実行する想定。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

MONTH="$(date +%Y-%m)"
OUTDIR="monthly"
mkdir -p "$OUTDIR"

# 直近5週分の週次レビューを対象にする
WEEKLIES=$(find weekly -name '*.md' -newermt '35 days ago' 2>/dev/null | sort)

PROMPT=$(cat <<EOF
あなたはMLエンジニアの成長を管理するコーチ。対象者は
自動運転AIの研究開発者で、最前線のMLエンジニアを目指している。

入力資料:
- 直近の週次レビュー: $WEEKLIES
- スキルマップ: SKILL_MAP.md (なければ今回作成する)
- 知識リポジトリ: ~/w/ML_report (公開ポートフォリオ。構成はREADMEを見よ)

$OUTDIR/$MONTH.md を作成せよ。構成:

## 1. 今月の実績 (事実ベース)
週次レビューから: 精読した論文数 / 実験化された数 / 知識リポジトリへの
追加数。推薦されたのに未実行だったものも率直に数える。

## 2. スキルマップ更新
SKILL_MAP.md を更新 (なければ作成) する。軸は:
- 基礎: 数学/最適化, 分散学習/インフラ, GPU/性能工学, 古典的手法
- 専門: 自動運転 (planning/E2E/VLA/world model), 蒸留/圧縮, 評価
- 工学: 実装力, 実験設計, MLOps, エージェント活用
各項目を 1-5 で自己評価し、先月からの変化と根拠 (何をやったか) を書く。
根拠なしの評価上昇は禁止。

## 3. 来月の基礎テーマ (1つだけ)
最新論文の radar は「基礎体力」を鍛えない。スキルマップの弱点から
来月徹底する基礎テーマを1つ選び、学習プラン (教材/古典論文/実装課題) を提案。
例: mixed precision の内部動作, NCCL/集合通信, CUDA カーネル入門,
最適化理論, 古典的な計画アルゴリズム。

## 4. ポートフォリオ監査
~/w/ML_report を採用担当者/投資家の目で見る:
- 最も印象的な成果物はどれか
- 何が欠けているか (英語記事? スター獲得可能なツール? デモ?)
- 今月公開すべき1本 (既存レポートのブログ化/英語化を含む) を提案

## 5. 外部フィードバック機会
自己参照を破る機会を1つ提案: コンペ (Kaggle等), 公開ベンチマーク投稿
(NAVSIM leaderboard等), OSS へのPR, 勉強会/カンファ登壇。
ウェブ検索が使えるなら直近の締切があるものを優先。

## 6. ループ自体の監査
日次/週次/月次のループが形骸化していないか。読まれていない出力、
形式的になったセクションがあれば削減を提案。ループは増やすほど
維持コストがかかる — 価値が薄いものは止める勇気を持つ。

スタイル規則: 専門用語・手法名は英語のまま (無理な和訳禁止)。
初出の専門用語には1行の平易な説明を付ける。

全体で3ページ以内。事実と提案を区別して書く。
EOF
)

claude -p "$PROMPT" --dangerously-skip-permissions

if [[ -f "$OUTDIR/$MONTH.md" ]]; then
  git add "$OUTDIR/" SKILL_MAP.md 2>/dev/null || git add "$OUTDIR/"
  git commit -m "research: monthly review $MONTH" || echo "[monthly] 変更なし"
  git push origin main && echo "[monthly] push 完了" || echo "[monthly] push 失敗"
fi

echo "[monthly] 完了: $OUTDIR/$MONTH.md"
