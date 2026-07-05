#!/usr/bin/env bash
# 四半期レビュー: LIFE_PLAN と現在地を突き合わせ、軌道修正する最上位ループ。
# 日次=入力、週次=定着、月次=方向修正、四半期=人生計画との整合。
# cron で 1/4/7/10月の1日に実行する想定 (monthly の後)。
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

# スマホ (GitHub Mobile) からの編集を取り込む
git pull --rebase --autostash origin main 2>/dev/null || echo "[pull] スキップ (オフラインor競合)"
# RUNWAY.md (private repo: life-state) も最新化
git -C /home/jetson/w/life-state pull --rebase --autostash origin main 2>/dev/null \
  || echo "[pull] life-state スキップ"

Q="$(date +%Y)-Q$(( ($(date +%-m)-1)/3 + 1 ))"
OUTDIR="quarterly"
mkdir -p "$OUTDIR"

MONTHLIES=$(find monthly -name '*.md' -newermt '100 days ago' 2>/dev/null | sort)
PROBLEMS=$(find problems -name '*.md' -newermt '100 days ago' 2>/dev/null | sort | tail -6)

PROMPT=$(cat <<EOF
あなたはキャリア戦略のアドバイザー。感情的な励ましは不要、事実と論理で書け。

入力資料:
- 人生計画: LIFE_PLAN.md (北極星・Phase定義・決断ポイント)
- 直近の月次レビュー: $MONTHLIES
- スキルマップ: SKILL_MAP.md
- 論文パイプライン: RESEARCH_PIPELINE.md
- 課題カードの蓄積: $PROBLEMS
- 意思決定の記録: decisions/ 配下 (_template.md 以外)
- やらないことリスト: LIFE_PLAN.md 内
- 資金の現在地: RUNWAY.md (ローカル専用。数値はこのレビュー出力に転記せず、
  runway月数と目標との差の傾向だけを言葉で書く)

$OUTDIR/$Q.md を作成し、LIFE_PLAN.md の「現在地」セクションを更新せよ。構成:

## 1. 現フェーズの進捗判定 (事実)
LIFE_PLAN の Phase 1 各目標に対し「前進した事実」を列挙。
事実がなければ「進捗なし」と書く。ごまかさない。

## 2. 決断ポイントの判断材料
「31歳の決断ポイント (今の会社で量産まで持てるか)」に対して、
この四半期に得られた材料 (会社の動き・自分の裁量の変化・市場の様子) を整理。
まだ判断の時期でなくても、材料は毎四半期積む。

## 3. 論文パイプラインの絞り込み
RESEARCH_PIPELINE.md のアイデア在庫と締切カレンダーを見て、
次の四半期に追うべきターゲット (会議×アイデア) を1つ推薦。理由と逆算スケジュール付き。

## 4. 課題ドメインの収束チェック
課題カードの蓄積から「深く理解すべき課題ドメイン」が収束しつつあるか評価。
Phase 3 の前提条件「世界で最も深く理解している課題を1つ持つ」への距離を書く。

## 5. 来四半期の OKR (最大3つ)
測定可能な形で。全ループ (weekly/monthly) はこの OKR に従って推薦を行う。

## 6. LIFE_PLAN 自体への提言
計画と現実が乖離していれば、計画側を直す提案をする。
ただし LIFE_PLAN.md の「現在地」以外の書き換えは提案に留め、本人の承認を待て。

## 7. やらないことリストの監査
LIFE_PLAN.md の「やらないことリスト」各項目について、この四半期に
違反した形跡 (週次・月次レビューから読み取れるもの) を事実ベースで指摘。
違反が3回以上の項目は「リストが現実と合っていない」可能性も併記し、
リスト改定か行動改善かの判断を本人に委ねる。

## 8. 資金セーフティネットの進捗
RUNWAY.md を読み、runway月数の推移と目標 (33歳までに30ヶ月分) への軌道を評価。
**具体的な金額はこの出力に書かない** (このリポジトリは公開されうるため)。
「順調/遅れ/未記録」+ 傾向 + 次の一手 (LIFE_PLAN の4レバーのどれを動かすか) だけ書く。
「一度だけやるTODO」に未完了があれば指摘する。
記録が2四半期空いていたら「資金の計器が死んでいる」と警告する。

## 9. Decision Journal の答え合わせ (calibration)
decisions/ 配下で「見直し日」を過ぎたエントリを列挙し、本人に答え合わせを促す。
既に「答え合わせ」欄が記入済みのものは、予測と実際のズレを集計し、
確信度の傾向 (過信気味か、過小評価気味か) を報告する。
エントリが1件もない四半期は「重要な決定が記録されていない」と指摘する。

スタイル規則: 専門用語は英語のまま。初出の用語には1行の説明。
全体で3ページ以内。
EOF
)

claude -p "$PROMPT" --dangerously-skip-permissions

if [[ -f "$OUTDIR/$Q.md" ]]; then
  git add "$OUTDIR/" LIFE_PLAN.md
  git commit -m "quarterly: review $Q" || echo "[quarterly] 変更なし"
  git push origin main && echo "[quarterly] push 完了" || echo "[quarterly] push 失敗"
fi

echo "[quarterly] 完了: $OUTDIR/$Q.md"
