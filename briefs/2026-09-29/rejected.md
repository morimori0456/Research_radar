# 2026-09-29 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **1 件** / 不採用 **2 件**。

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch 0/2 ・ sns_wildcard 1/1。**上限 6 に対し 1。**

3 件とも新規 (既存ブリーフとの重複なし)。どれも本文 (abstract) に本流 keyword を含まないので、本流 quota への移し替えは無し。

---

## 不採用の候補

- 2609.18703: RayOrch: Programming and Executing Lineage-Controlled Multi-Grain Dataflows for Foundation-Model Data Preparation — **分散データ処理の基盤ソフトの論文で、学習手法の話が無い。スコア P2 1.0 / P1 0.5 / P3 0.5 (hf_upvotes 43)。**基盤モデルの学習データ作り (PDF や動画を 1 件から多数の子レコードに展開し、GPU でまとめて処理して、また親ごとに組み戻す) を、親子関係を保ったまま並列実行する仕組み。64 GPU で 15 倍の scaling。P2 で大規模な蒸留データを作る段になれば参考になるが、今の規模 (単機の実験) では持ち帰る手順が無い。wildcard 枠は 1 件なので FuseReg を優先した。
- 2609.31093: Block Sparse Attention with Log-Linear Complexity — **P3 の「学習効率・efficient transformer」に近いが、結果が弱く運転への接点も薄い。スコア P3 2.0 (hf_upvotes 19)。**block sparse attention (長い系列を block に区切り、関係の強い block だけに attention を掛けて計算を減らす方式) で、どの block を残すかの選択自体が系列長の二乗になる問題を、key を粗から細へ pyramid 状に要約して段階的に絞り込む (PISA) ことで O(N log N) にした。Triton kernel (GPU 用の自作演算) も付く。ただし評価は言語モデルだけで、精度は「baseline と同等、retrieval では良い」にとどまる。運転の E2E モデルは系列長が数百〜数千 token で、二乗コストが律速になる場面がまだ少ない。FuseReg (2.5・upvotes 112) に同点でも届かず不採用。

---

## 本日の fetch 診断 —— **406 が 10 回連続。今日は 40 件を取りこぼした (累計 283 件)**

```
[fetch] planner_ai (P1) ...          error: HTTP Error 406: Not Acceptable
[fetch] fm_distill_finetune (P2) ... error: HTTP Error 406: Not Acceptable
[fetch] next_arch (P3) ...           error: HTTP Error 406: Not Acceptable
[buzz] HF daily papers: 28 papers
[buzz] wildcard candidates added: 3
```

(`~/research_loop.log` の 09-29 03:00 実行分。)

09-28 の予告どおり、日曜夜の announce 分がこの実行で初めて届いた。RSS 試作 (`/tmp/rss_0929.py` → `/tmp/rss_0929.json`) を再実行した結果:

| feed | HTTP | new/cross (重複除く) |
|---|---|---|
| cs.RO / cs.AI / cs.LG / cs.CL / cs.CV | 5 本とも 200 | **544** |

| topic | keyword 一致 |
|---|---|
| planner_ai | **3** |
| fm_distill_finetune | **22** |
| next_arch | **15** |

**本流 3 トピックで計 40 件が fetch に届かなかった。累計は 243 → 283 件。**09-27・09-28 は週末で RSS が空または再配信だったため喪失 0 だったが、平日に戻った初日にそのまま 40 件落ちた。修正 (取得元を `rss.arxiv.org/rss/<cat>` に替える) が入らない限り、平日は毎日この規模で落ち続ける。

### 繰り越し —— 今日の RSS で拾ったもののうち、特に関連が強いもの

正規の評価を通していないのでスコアは付けない。abstract だけを読んだ一言メモ。

- **2609.30818: Evaluation Is All You Need for Multi-Modal Autonomous Driving** (next_arch / P1) —— 複数の軌跡候補を出す planner は「最良候補を含む率」(oracle) は高いのに、**その中から最良を選ぶ段で失敗している**、という generation-evaluation asymmetry (生成と評価の非対称) を指摘。安全性スコアと VLM (画像と言語を扱うモデル) による重み調整を組み合わせた評価器 iDriveVLA で、NAVSIM v1 (実走行ログ上で planner を採点する benchmark) の PDMS (その総合スコア) 94.95。**P1 の評価指標に直結する。**→ https://arxiv.org/abs/2609.30818
- **2609.31383: Guiding End-to-End Driving Models with Endpoint-Constrained Trajectory Optimization** (next_arch / P1) —— open-loop (記録データ上で予測だけ採点) で学習した E2E 運転モデルの軌跡は、**終点は信頼できるが途中の waypoint が物理的に追従しにくい**、という観察。終点を固定して途中だけを整形する後処理層 ECO を入れるだけで、学習なし・地図なしで 2 つの closed-loop simulator (車の動きが次の入力に反映されるシミュレーション) で 6 policy すべてが改善。**2D toy で半日で再現できる。**→ https://arxiv.org/abs/2609.31383
- 2609.31374: RECAST: From Log Replay to Closed-Loop Driving Simulation with View-Complete Actors (planner_ai) —— ログ再生型シミュレータで、周囲の車が記録外の角度から見えても破綻しないよう、1 枚の観測から 3D Gaussian Splatting (3D を多数の小さなガウス分布で表す描画手法) の車両を生成する。closed-loop 評価の信頼性の話。→ https://arxiv.org/abs/2609.31374
- 2609.30436: WALT: Learning World-Model-Aligned Latent Trajectories for Autonomous Driving (next_arch) —— 凍結した運転 world model の特徴を、軌跡の latent 空間に移して planner を強くする。JEPA と REPA (Representation Alignment; 生成モデルの中間特徴を事前学習 encoder の特徴に合わせる正則化) の比較付き。**今日の FuseReg (凍結 encoder の特徴の使い方) と併読向き。**→ https://arxiv.org/abs/2609.30436
- 2609.30802: Understanding the Role of Prompt Template in Knowledge Distillation for Safety Alignment (fm_distill_finetune) —— LLM の蒸留で chat template を使うと、student の元の安全性や内部表現が大きく崩れる。「蒸留時の入力書式が student の既存能力を壊す」という P2 の一般的な注意点。→ https://arxiv.org/abs/2609.30802
- 2609.30395: CSCWD: Cross-Scale Channel-wise Knowledge Distillation for Lightweight Tiny Object Detection on Edge Devices (fm_distill_finetune) —— teacher の高解像度層 (P2) を student の 1 段粗い層 (P3) に合わせる cross-scale の feature 蒸留。小物体検出で +2.9 pt。→ https://arxiv.org/abs/2609.30395
- 2609.31313: Towards VLA-Dreamer (next_arch) —— VLA の vision encoder の埋め込み空間で world model を学習する提案。実験の無い concept paper なので優先度は低い。

### 前日からの繰り越し (変化なし)

- **2609.28931: HelloWorld: Towards Practical Applications of Generative Driving World Models** (next_arch) —— **4 日連続で未読。**→ https://arxiv.org/abs/2609.28931
- 2609.28865: Direction-Scale Decomposition in Action Representation (next_arch)
- 2609.30036: Aim Short to Reach Far: Your Frozen World Model Can Plan Better Than You Think (next_arch)
- 2609.29706: Safety-oriented pedestrian trajectory prediction at urban intersections (planner_ai)
- 2609.28998: LoRA の rank を lp 正則化で自動配分する (fm_distill_finetune)
