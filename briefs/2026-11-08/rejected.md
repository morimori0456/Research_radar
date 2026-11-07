# rejected 2026-11-08

採用 4 本以外の記録。candidates.json は 7 件 (generated_at 2026-11-07T18:00Z; fm_distill_finetune 1 / next_arch 3 / sns_wildcard 3; planner_ai は 0 件)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。

## 採用 (4 本)

2611.08414 (P2 4.0) / 2611.08373 (P3 3.5; wildcard → next_arch に移した) / 2611.08425 (P3 3.5) / 2611.08449 (wildcard 探索枠 3.5)。P1 の主対象は 0 本。

## 補足

- 7 件のうち 5 件 (2611.08414 / 08462 / 08425 / 08413 / 08373) は 2026-11-07 の rejected.md に既に載っていた論文の再来。採用済みの再来ではなく、昨日**採用しなかった**ものなので、dedup では除外せず、次点 (3.5 以上) を持ち越して採用した。
- 新規は 2611.08449 と 2611.04277 の 2 件のみ (どちらも sns_wildcard)。
- 2611.08373 は今日 sns_wildcard に分類されていたが、keyword "VLA" に一致するため本流 next_arch の quota に移した。

## 不採用

- 2611.08462: OopsieRecover: Learning Transferable VLA Corrections from Semantic Interventions — 少数の corrective demonstration から VLA の failure recovery を学び、新しい物体・scene に転用する。「少データでの適合」の観点は P2/P3 に近いが、manipulation 限定で、意味的な abduction (失敗の理由の推論) が運転に移る道筋が abstract から見えない (3.0)
- 2611.08413: T3R: Training-Free Two-Stage Token Refinement Towards Efficient and Robust VLA Models — segmentation で visual token を 85% 削り、attention を saliency で偏らせる training-free 手法。効率化として参考になる (3.3x speedup) が、manipulation の複数カメラ設定が中心で、segmentation model を別に要する (3.0)
- 2611.04277: Harness-S: Learning from Sibling Harnesses for Generalizable Agent Training — LLM agent の harness (実行環境の枠組み) の variant で失敗を救い、RL で単一 policy に取り込む。AppWorld / SWE-Gym / DBBench の LLM agent の話で、P1/P2/P3 のいずれにも接点が薄い (2.0)

## 持ち越せる次点 (評価 3.5 以上)

- 2611.07349: From What Is Used to What Is Missing: Rethinking Dynamic Rank in LoRA — [4.0] 昨日からの持ち越し。今日の candidates.json には再来しなかった。2611.08414 と併せて読む価値あり
- 2611.07939: WAM-Sim0.1 — [4.0] 昨日からの持ち越し。今日の candidates.json には再来しなかった
