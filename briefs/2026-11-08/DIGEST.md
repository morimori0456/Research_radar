# DIGEST 2026-11-08

採用は 4 本 (P1 0 / P2 1 / P3 2 / wildcard 1)。candidates.json はたった 7 件 (fm_distill_finetune 1 / next_arch 3 / sns_wildcard 3 / planner_ai 0)。うち 5 件は昨日の rejected.md に載っていた論文の再来で、新規は 2 件だけ。上限の 6 本を埋めず、3.5 点未満は採らなかった。評価・ブリーフはすべて abstract のみに基づく。

## 今日読むべきTOP3

1. **[2611.08414 LoRA は SFT と RL で逆向きに動く。原因は「baseline の引き算」](2611.08414.md)** (P2) — LoRA (Low-Rank Adaptation; 重みの更新を小さい行列の積で表して少ない parameter で fine-tuning する手法) の更新を、SFT (Supervised Fine-Tuning; 正解 data を真似させる学習) と RL (Reinforcement Learning; 報酬で学習) で追跡すると、RL は更新が少数の方向に集中し、SFT は多くの方向へ広がる。論文は原因を、RL で使う group-mean baseline subtraction (同じ prompt の複数の応答の平均報酬を引く計算) に特定した。そこで SFT では更新を均して広げ、RL では LoRA の更新が張る空間の外側の成分を均して回転を促す。同じ LoRA 設定を両段階で使い回している人には、そのまま見直す材料になる。評価は数学 reasoning のみ。
2. **[2611.08449 trajectory の座標を 1 回でまとめて出し、25 倍速にする VFlash](2611.08449.md)** (wildcard / P1・P3 に接点) — VLM (Vision-Language Model; 画像と言語を扱う model) が点や trajectory を座標 token 1 つずつ順に生成すると、plan が長いほど遅い。VFlash は座標の構造が既知なことを使い、軽量な drafter (小さい下書き model) が 1 回の forward pass で primitive 全体を出す。3D の点の運動予測で約 25 倍速。ただし「予備的な単一 rollout」の計測で、評価は robot manipulation。運転 trajectory で精度が保たれるかは未検証なので、最小実験で確かめる価値がある。
3. **[2611.08373 推論構造を変えずに、学習時だけ中間層に 3D の知識を入れる SLA](2611.08373.md)** (P3) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) は 2D の事前学習から視覚表現を受け継ぐため、3 次元の空間理解が弱い。SLA は pi05 (公開 VLA) を continual pre-training しながら、中間層の embedding を、凍結した 3D perception model の空間表現に揃える補助 loss を足す。補助部品は学習時のみなので、推論時のコストは増えない。昨日の La-JEPA と同じ「推論で使わない補助を学習に使う」系統。abstract は末尾が切れていて、評価結果は未確認。

## 全ブリーフへのリンク

- [2611.08414](2611.08414.md) — LoRA の spectrum / subspace が SFT と RL で逆に動く。原因は group-mean baseline subtraction で、段階別に更新を flatten する (P2 / fm_distill_finetune / 4.0)
- [2611.08449](2611.08449.md) — VFlash: drafter が visual primitive を 1 回でまとめて出す (wildcard / P1・P3 接点 / 3.5)
- [2611.08373](2611.08373.md) — SLA: pi05 を 3D 表現との alignment 付きで continual pre-training (P3 / next_arch / 3.5)
- [2611.08425](2611.08425.md) — VLA-Tug: VLA の latent に軽量 probe を載せ、失敗を早く検出し、見逃し・誤警報の率に bound を付ける (P3 / next_arch / 3.5)
- [rejected.md](rejected.md) — 不採用 3 件と、持ち越せる次点 2 件

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 今日の主対象は 0 本。planner_ai の候補が 0 件で、next_arch にも運転 planner の論文が無かった。接点があるのは VFlash (VLM が出す trajectory の速度) と VLA-Tug (失敗の早期検出と種類の分類) で、どちらも manipulation の評価。最小実験は、手元の planner の中間層に線形 probe を載せて「n 秒以内に衝突が起きるか」を予測させること。
- **P2 (FM 蒸留 + fine-tuning)**: 候補は LoRA の 1 本だけ (SFT と RL で LoRA の更新が逆向きに動く)。蒸留の論文は今日ゼロ。最小実験は、LoRA 学習中に更新の特異値を数 step ごとに記録して、spectrum の集中度が論文と同じ向きに動くか見ること。昨日の次点 2611.07349 (GEAR; LoRA の rank を増やす手法) は今日の candidates.json に再来しなかった。
- **P3 (次世代アーキテクチャ)**: SLA は学習時だけの補助 loss で中間表現を育て、VLA-Tug は backbone を変えず latent を読む probe を後付けする。どちらも**既存の backbone に後から足す**形で、推論コストが車載の制約に響きにくい。最小実験は、中間層に凍結 depth model の特徴との alignment loss を学習時だけ足して、閉ループ指標と latency を見ること。
- **wildcard**: VFlash 以外の 2 本は採用しなかった (2611.04277 Harness-S は LLM agent の話で 2.0; 2611.08373 SLA は本流に移して採用)。

## 運用メモ

- **candidates.json が 7 件しかない** (昨日は 55 件)。generated_at は 2026-11-07T18:00Z = 土曜夜の fetch。過去の記録 (土日は announce が無く新着が構造的に少ない) と整合し、異常ではなく**週末の正常な薄さ**の可能性が高い。ただし 7 件のうち 5 件は昨日の rejected.md の再来で、published は 11-04〜11-05 の約 2 日分。新規は 2 件のみ。
- **fetch の log はこの環境から確認できなかった** (run_research.sh は log を書かず、既知の場所に log が無い)。そのため、fetch がエラーで 0 件に見えている日ではない、とは言い切れない。月曜 (11-09) の実行で候補が通常の件数 (数十件) に戻るか確認する。
- planner_ai が 0 件で、P1 の枠を埋められなかった。keyword だけで topic を割り当てる fetch 側の限界は続いている。`fetch_candidates.py` / `topics.yaml` は変更していない。
- 昨日の次点が再来したため、既読の除外 (dedup) を入れる場合は「採用済みのみ除外し、不採用の次点は残す」設計にする必要がある。
