# SKILL MAP

> monthly レビューが更新する。**根拠 (何をやったか) の無い評価は書かない。**
> 初版: 2026-09-01 (2026-08 の実績で採点)。前月比は次回 (2026-10) から入る。

## 採点の定義

| 点 | 意味 |
|---|---|
| 1 | 用語と全体像が分かる。人の説明を追える |
| 2 | 既存の解説・コードを読み、動かし、他人に説明できる (**公開物がある**) |
| 3 | ゼロから実装でき、設計判断の理由を自分の言葉で説明できる |
| 4 | **自分で測った数字**を根拠に新しい設計判断ができ、他人の主張を審査できる |
| 5 | 分野の最前線で新しい方法を作り、**外部の評価** (査読・leaderboard・被引用) がある |

**3 と 4 の間に「自分で測ったか」の線がある。2026-08 時点で、この線を越えた項目は無い。**

---

## 基礎

| 項目 | 点 | 根拠 (2026-08) | 前月比 |
|---|---|---|---|
| 数学/最適化 | **2** | conformal prediction・scaling law・(1-r)^N 検出力の議論を weekly で自力で展開している (W34/W35)。一方 ML_report に最適化理論の公開物はゼロで、ROADMAP §B が optimizer/scheduler/normalization を空白と明記。**読めるが書いていない** | — (初版) |
| 分散学習/インフラ | **2** | `infrastructure/ml_training_infrastructure.md` (Slurm srun/sbatch, GRES, NCCL/IB, parallel storage, container, K8s) + sbatch テンプレ4種。**ただし multi-node を自分で回した痕跡は無い** — 書ける知識であって動かした経験ではない | — |
| GPU/性能工学 | **2** | TensorRT INT8 量子化 + version 互換性の2本 (script 付き)、Kaggle T4 で QLoRA / Alpamayo2 の GPU smoke を実走。**Jetson Thor 実機ベンチは ROADMAP で「Thor で計測して埋める」のまま未計測**、CUDA kernel / Nsight プロファイリングは空白 | — |
| 古典的手法 | **2** | NAVSIM PDMS レポートで LQR + bicycle model の ego rollout をゼロから実装。**しかし lattice/motion primitive, homotopy class, reachability (HJ) は未整理** — W35 が要求した mode coverage を書くのに直接足りない。ROADMAP §G も MPC/制御を空白と明記。**§3 の今月テーマはここ** | — |

## 専門

| 項目 | 点 | 根拠 (2026-08) | 前月比 |
|---|---|---|---|
| 自動運転 (planning/E2E/VLA/world model) | **3** | 8月に briefs 96本、surveys 3本 (planner-evaluation 71KB / vla-world-model 70KB / fm-distillation 76KB)。ML_report の AD レポート11本 (VAD, DriveTransformer, nuPlan, NAVSIM, Alpamayo2 = NVIDIA 公式モジュールの移植)。**読解は4相当。だが perception〜prediction が丸ごと空白 (ROADMAP §A) で、自分で測った数字がゼロなので 3 で止める** | — |
| 蒸留/圧縮 | **3** | ML_report distillation 7本 (response/feature/relation/multi-teacher/self/FM) すべて実行済み notebook 付き。8月は P2 として capacity gap の前提が崩れる証拠 (容量比1.0でも効く例5本) を追えている。**圧縮の他の柱 (quantization/pruning) は TensorRT INT8 の1本のみで、蒸留に比べ薄い** | — |
| 評価 | **3** | 最も厚い軸。NAVSIM PDMS をゼロから再実装、planner-evaluation survey 71KB、8月だけで検出力 (1-r)^N・仕様の書き漏らし・抜け穴・judge バイアス・solvability を体系として整理。**「何を測れないか」を言語化できる状態にある。自分の測定結果が1つも無い点だけが 4 を阻んでいる** | — |

## 工学

| 項目 | 点 | 根拠 (2026-08) | 前月比 |
|---|---|---|---|
| 実装力 | **3** | 実行済み notebook 27本。Kaggle T4 実走で実バグを踏んで直した記録あり、NVIDIA Alpamayo の公式モジュールを weight 無しで動く形に移植。**「動いて読める」水準の再現実装は確実にできる** | — |
| 実験設計 | **2** | 設計「言語」は上位: 検出力を走らせる前に計算する、ノイズ床を測る対照実験、相乗り指標、gate の事前宣言 — いずれも weekly で自力で書けている。**しかし 2026-08 の実行は 0/94。`experiments/` は存在しない。書ける・実行していない = 2 が上限。全項目で最も低く、最も費用対効果が高い** | — |
| MLOps | **3** | research_loop 本体 (cron + git + 4つのレビュー script)、ML_report の Quarto + GitHub Actions 自動デプロイ、experiment_tracking レポート (TensorBoard/W&B/tbparse)。**自分用の自動化パイプラインを設計・運用できている** | — |
| エージェント活用 | **4** | 唯一 4。research_loop 自体が harness として9週間稼働し、**その harness の欠陥を実測で6件特定して原因を切り分けている** (cutoff と投稿の山の時刻差を分単位で測る等) — これは「使った」ではなく「測って直せる」水準。加えて agentic_engineering 3本 (loop 設計 / Claude Code registry 抽出 / harness & graph engineering) を公開済み。**ただし特定した修正2行が7日以上未実施** — 診断力に対して施術が遅い | — |

---

## 今月の一点集中 (2026-09)

**「古典的手法」2 → 3。** 手段は §3 の学習プランと、`solvability / mode coverage` notebook 1本。
**同じ notebook が「実験設計」2 → 3 と「評価」3 → 4 の唯一の経路でもある** (自分で測った数字が1つ出るため)。
**4項目を別々に上げようとしないこと。** 9週間の結果は「選ぶものが足りない」ではなく「選んだものが着手されない」だった。
