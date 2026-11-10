# DIGEST 2026-11-11

今日の新規ブリーフは **5 本** (P1 1 / P2 2 / P3 2)。上限 6 本には届かず、水増しはしていない。candidates.json は 64 件 (planner_ai 4 / fm_distill_finetune 30 / next_arch 27 / sns_wildcard 3) で、通常の件数に戻った。昨日の RSS 回収は不要だった。評価はすべて abstract のみに基づく。

## 今日読むべきTOP3

1. **[2611.11856 DeltaForge: 別々に fine-tune した運転 VLA を 1 つにまとめる](2611.11856.md)** (P3 / P2) — 運転 VLA (Vision-Language-Action; 画像と言語から運転出力を出す model) を、都市・高速・off-road など domain ごとに fine-tune すると expert が増え、後から統合するのが難しい。DeltaForge は、同じ base から fine-tune した model の重みの変化量が構造を共有する点に注目し、SVD (Singular Value Decomposition; 行列を主要な方向に分解する) で「全 domain 共通の部分」と「domain 固有の小さな部分」に分ける。routing (どの expert を使うか選ぶ処理) は小さい固有部分だけで済むので、ほぼ単一 model のコストで 6 domain を扱える。新 domain の追加も再学習なしでできる。最小の実験は、手元の fine-tune 済み model 同士の重み差を SVD して、共通構造がどれだけあるか測ることで、これが小さければ手法は効かない。
2. **[2611.12286 VLA-MOPD: 課題別 specialist を on-policy distillation で統合する](2611.12286.md)** (P3 / P2) — 課題別に post-training した VLA の specialist を 1 つにまとめる protocol。on-policy distillation (student 自身が出した行動・状態に teacher が supervision を与える蒸留) を、課題ごとの凍結 teacher に拡張した multi-teacher 版で、student が実際に訪れた観測と action 生成の途中状態の両方で teacher に問い合わせる。reference 項 (元の policy との差を抑える項) を入れると他課題の低下が 13.2 点から 3.0 点に減る。昨日の P^2-MOPD と同系統の recipe が VLA で使えるかを見る材料で、DeltaForge (重み空間で統合) と対にして読むと、統合を重みで行うか data で行うかの比較になる。
3. **[2611.12676 VLA fine-tuning の case study: checkpoint の選び方と sim data](2611.12676.md)** (P2) — SO-101 arm でチェスの駒を動かす課題で π0.5 を fine-tune し、data 量・update 数・checkpoint 選択・sim data の効果を調べた実務報告。learning rate を最後に短く下げる cool-down だけで成功率が最大 31 点上がり、**validation loss と action error は checkpoint 選択の指標として信頼できない**。自分の fine-tuning でも loss で checkpoint を選んでいるなら、下流の成功率と順位が一致するかを確認する理由になる。実機結果は著者自身が partial と書いており、1 課題・1 robot の報告である点に注意。

## 全ブリーフへのリンク

- [2611.12382](2611.12382.md) — AutoVLA-D: Learn a Trajectory-Geometric Condition from Reasoning for Autonomous Driving VLA (P1 / 4.0)
- [2611.12251](2611.12251.md) — RAIL: Representation-Aligned Imitation Learning for Student-Compatible Teacher Policies (P2 / 4.0)
- [2611.12676](2611.12676.md) — VLA Adaptation with Real and Simulated Data: A Case Study on Robotic Chess (P2 / 4.0)
- [2611.12286](2611.12286.md) — VLA-MOPD: On-Policy Distillation for Multi-Task VLA Policy Consolidation (P3 / 4.5)
- [2611.11856](2611.11856.md) — DeltaForge: A Post-hoc Mixture-of-Experts VLA for Multi-Domain Autonomous Driving (P3 / 4.5)
- [rejected.md](rejected.md) — 不採用の記録 (64 件中 59 件)
- 昨日の DIGEST: [briefs/2026-11-10/DIGEST.md](../2026-11-10/DIGEST.md)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 閾値を超えたのは AutoVLA-D (2611.12382) の 1 本のみ。VLA の出力を「離散の粗い trajectory → 連続の精密な trajectory」の 2 段にし、離散側を最終出力でなく条件として使うと連続出力が良くなる。NAVSIM / nuScenes に加えて NeuroNCAP (危険場面を再現する closed-loop 評価) でも確かめている。最小の実験は、手元の planner に粗い action 列の補助 head を足して連続 head の入力にすること。planner 評価の新手法は今日は無い。
- **P2 (FM 蒸留 + fine-tuning)**: RAIL (2611.12251) は、privileged teacher (本番では得られない情報を見られる teacher) から student への蒸留で、真似できない teacher という capacity gap を「teacher の訓練中に」防ぐ。teacher と student の観測を contrastive learning (近いものを近く、違うものを遠くに置く表現学習) で共有の潜在空間に載せ、teacher をその空間で訓練する。VLA fine-tuning の case study (2611.12676) は loss の新案でなく、評価と checkpoint 選択の落とし穴が価値。DeltaForge と VLA-MOPD も P2 の「適合した model の統合」として読める。RAIL は RL の control 環境のみの評価で、LLM や大規模 vision model への移植は未検証。
- **P3 (次世代アーキテクチャ)**: 今日の主題は **specialist を 1 つに統合する**こと。DeltaForge は重みの差分を SVD で分けて統合し、VLA-MOPD は on-policy distillation で統合する。同じ expert 群で両方を比べる実験が、統合方式の選択に役立つ。次点は LO-World (2611.11912; BEV の共有潜在空間で 4D occupancy と LiDAR を同時に forecast する world model; 4.0) で、quota 超過で落とした。
- **wildcard**: 採用 0 件。WorldFoundry (2611.10771; world model の評価基盤; hf_upvotes 51) は新規性が abstract から薄く 3.0。SplatAnything (2611.08264) は昨日 rejected 済みの再来で、wildcard 経路に dedup が無いことの 2 例目 (09-30 の 2609.35259 に続く)。Confucius4-R2T2 (streaming ASR) は無関係。注目度は relevance を上書きしない。

## 運用メモ

- fetch は通常の件数に戻った (64 件。fetch の log はこの環境から未確認)。昨日 (月曜分) の 0 件は、10-06 の予告型 (月曜 announce 分が窓外) だった可能性が高い。`fetch_candidates.py` / `topics.yaml` は変更していない。
- candidates.json の id は `v1` 付き。既読との照合は version 部分を落として行い、重複は上の 1 件のみだった。
