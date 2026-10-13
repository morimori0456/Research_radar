# DIGEST 2026-10-14

候補 3 件 (fetch 火曜夜分)。全て sns_wildcard で本流トピックの候補は 0 件。abstract のみで評価。採用 1 件 (wildcard 枠の上限)。2 件は 10-13 に既に不採用とした論文の再配信 (dedup 未実装のため)。fetch のエラー記録は残っていないが、rss.arxiv.org の 5 カテゴリ (cs.RO/AI/LG/CV/CL) を手動で確認したところ全て 0 件 (lastBuildDate 10-13 04:00Z) で、回収できる取りこぼしは無し。

## 今日読むべきTOP3

候補が 1 件のため、読むべきものは 1 件のみ。

1. **[2609.39601 GroundingPI](2609.39601.md)** — 「画像のどこに何があるか」を点や box で答える grounding 専用の 4B モデル。VLA (Vision-Language-Action; 画像と言語から行動を直接出すモデル) 系のロボット・運転モデルは、物体の位置を見る部分を汎用の vision-language backbone から借りており、散らかった場面や小物体で失敗する、というのが出発点。論文は、この部分だけを専用モデルに差し替えると下流の操作・運転の成績が上がると報告している (nuScenes では backbone として使い、軌道の誤差 L2 が平均 0.296 m)。P3 の E2E 運転で「視覚 encoder を何から作るか」の判断材料になる。ただし abstract は途中で切れていて、公開有無・推論速度・学習 recipe は未確認。まず本文でそこを見る。

## ブリーフ一覧

- [2609.39601](2609.39601.md) — GroundingPI: 4B の grounding foundation model (P3 / P2 寄り、wildcard から採用)

落とした候補: [rejected.md](rejected.md) (S-Space、DiffusionART。どちらも 10-13 に続き 2 回目)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 今日は該当なし。GroundingPI が nuScenes で報告する open-loop L2 は planner 評価としては弱い指標なので、数字をそのまま信用しない。
- **P2 (蒸留 + 適合)**: GroundingPI の「demonstration 50% で baseline の 75% 相当」は少データ適合の主張。4B を closed-loop に載せられる小型モデルへ蒸留できるかは未検証で、実験の候補。
- **P3 (次世代アーキテクチャ)**: 本日の本体。VLA の弱点を perception と見て、座標を語彙 token として出す grounding 専用 backbone に差し替えるという設計判断が論点。S-Space (MLLM 内部の空間表現の解析) は引き続き次点。
