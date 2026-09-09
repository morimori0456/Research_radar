# 2026-09-10 不採用の候補と、本日の fetch 診断

候補 **46 件** (planner_ai 2 / fm_distill_finetune 30 / next_arch 11 / sns_wildcard 3) / 採用 **6 件** / 不採用 **40 件**。
**上限 6 に対し 6 —— 09-05 以来 5 日ぶりに枠が全部埋まった** (09-06 は 2 件、09-07/09-08 は 0 件、09-09 は 3 件)。**質を落として埋めたのではなく、本流が 43 件届いたためである。**

**quota 上の割当: planner_ai 2 / fm_distill_finetune 2 / next_arch 2 / sns_wildcard 0** (合計 6 = `max_deep_per_day`)。
**内容による再分類後: P1 3 / P2 2 / P3 1。**

> `git log -1 -- topics.yaml fetch_candidates.py` は **`313a283` (2026-07-03)** のまま = **設定は 1 行も変わっていない。修正 4 行・20 分・未実施 18 日目。**

---

## §0. fetch の診断 —— 本日は「窓が空」ではなく「天井に当たった」

規則どおり、選別より先に arXiv API を直接叩いた。**障害はない。**Labor Day 明けの積み残しが 09-08 に一斉公開されたため、**本流は 43 件届いている** (09-09 の 0 件から一転)。

**しかし本日は、これまでと *別の* 形で候補が切り捨てられていた。**`fm_distill_finetune` が **ちょうど 30 件** —— **`max_results=30` の天井に張り付いている。**返ってきた 30 件の最古は **09-07T19:38Z** で、**cutoff (09-07T18:00Z) より新しい。****つまりこのトピックでは、窓 (`lookback_days`) は一度も効いておらず、件数上限だけで切られていた。**

### 4 条件の実測 (2026-09-10 に API を直接照会)

| topic | **現行** lb=2 / mr=30 | lb=**5** / mr=30 | lb=2 / mr=**100** | lb=**5** / mr=**100** |
|---|---|---|---|---|
| planner_ai | **2** | **7** | 2 | **7** |
| fm_distill_finetune | **30** ← 天井 | **30** ← 天井 | 33 | **98** ← ほぼ天井 |
| next_arch | **10** | **30** ← 天井 | 10 | **45** |
| **合計** | **42** | 67 | 45 | **150** |

*(実際の candidates.json は next_arch 11 件。上表は cutoff を `generated_at` ちょうどで計算しているため、実 cutoff との約 19 秒の差で 1 件ずれる。)*

### 本日いちばん重要な発見: **修正① の 2 つは独立ではない。互いに相手の効果を隠している**

- **`lookback_days: 5` だけ入れても、fm_distill と next_arch は `max_results=30` の天井に当たって伸びない** (30 → 30、30 で頭打ち)。
- **`max_results: 100` だけ入れても、`lookback_days: 2` の窓に切られる** (30 → 33、次点は 10 → 10 で不変)。
- **両方入れて初めて 42 → 150 になる。**

**記憶にある「①は `lookback_days:2→5` と `max_results:30→100` を *同時に* 行う」という順序指定は、本日の実測で数値的に裏付けられた。**片方だけ入れて「効かなかった」と結論しないこと。**片方だけの改善幅は +25 件 / +3 件で、これは「効いていない」ように見える大きさである。**

### 09-06 の観察の再現性について

09-06 に「`max_results:100` でも fm_distill は 3 日窓に張り付く」と記録し、09-09 には再現しなかった。**本日は再現した** —— mr=100 で返る 100 件の最古は **09-04T17:59Z** で、**5 日窓のほぼ端**。つまり **fm_distill は投稿の多い週には mr=100 でも飽和する。**
**記憶にある整理 (「09-06 の観察は投稿の多い週限定」) は正しい。**本日は Labor Day の積み残しで投稿が特に多い週なので、**限定条件のほうに当たった。**実害は quota が 2 なので小さく、**優先度は上げない。**

### 修正③ (planner_ai の keyword 追加) に、本日ついに実物の証拠が出た

**`planner_ai` は `max_results` を上げても件数が 1 件も増えない** (mr=30 で既に 08-25 まで遡れている)。**天井ではなくキーワードで絞られている。**5 日窓でも **7 件**しかない。

そして本日、**`PlannerForge` (自動運転の motion planner をシナリオベースでテストする論文) が `fm_distill_finetune` に入った。**拾ったのは abstract 末尾の **"without domain-specific fine-tuning"** の 1 語である。`planner_ai` の keyword (`motion planning` / `trajectory prediction` / `planner evaluation` / `closed-loop simulation`) は**どれも当たらなかった。**

> **これは「planner_ai の keyword が狭い」という推測ではなく、実際に P1 の本流論文が別トピックの quota を食った実例である。**
> **追加すべき語 (本日の実例から): `scenario-based testing` / `motion planner` / `autonomous driving system` / `driving simulation`。**
> **修正③ は ① と独立に、単独で効く。**

### 欠陥#2 (dedup): wildcard 3 枠中 **2 枠が再配信**

| id | hf | 状態 |
|---|---|---|
| 2609.02750 | 141 | **09-09 に採用済み** (`briefs/2026-09-09/2609.02750.md`) |
| 2609.04010 | 129 | **09-09 に採用済み** (`briefs/2026-09-09/2609.04010.md`) |
| 2609.08936 | 150 | 新規 |

**09-09 に読んだばかりの 2 本が、翌日そのまま再配信されている。**`fetch_candidates.py` の dedup は `candidates.json` 内の重複しか見ておらず、**過去のブリーフを参照していない** (`briefs/*/*.md` のファイル名を集合にして除外すれば 3 行で直る)。

**本日は本流が豊作だったので実害はゼロだった** —— 6 枠は本流で埋まり、wildcard は 0 件採用。**しかし 09-05 (3/3 全滅)・09-06 (1/3)・本日 (2/3) と、wildcard 枠は 3 日とも半分以上が空費されている。**

---

## §1. 不採用の候補 (40 件)

### planner_ai (1 件)

- **2609.08618: Target-Independent Micro-Interventions for Predicting Training Response Across Language-Model Families** — **P1 1.0。誤分類。**言語モデルの checkpoint に短い介入を打って「次の学習でどう伸びるか」を予測する論文で、**運転にも planner にも一切関係しない。**`planner_ai` のカテゴリ (cs.AI, cs.LG) と何らかの語で拾われた。**修正③ を入れる際は、拾いすぎ側も同時に見ること。**

### fm_distill_finetune (27 件)

**次点 3 本** (quota 2 に対して惜しかったもの):

- **2609.08183: NeoHorse-1 — Towards Recursive Self-Improvement via Agentic Post-Training with Routing Harness** — **P2 4.0 / hf 308 (本日最高)。**routing の記録を訓練データに変え、routing-guided な on-policy distillation まで繋ぐ。4B の macro 平均が 58.94 → 64.87 で 9B base との差を詰めた。**落とした理由は 3 つ:** ① fm_distill の quota 2 は [RouteOPD](2609.08337.md) 5.0 と [Marigold V2](2609.08084.md) 4.5 が埋めた ② **自社の routing harness の上での post-training 報告**であり、外から再現できる recipe の形になっていない ③ **「4B が 9B に近づいた」は capacity gap の話だが、R2 では容量差原因説は反例 5 本で既に棄却済み**なので、R2 の現在の問い (監督を当てる範囲) には答えていない。**hf_upvotes は同点時のタイブレークにのみ使う規則なので、0.5 点の差を 308 で覆さなかった。**
- **2609.08368: Miles v0.1 — Production-Level Post-Training** — **P2 3.5 / hf 44。**on-policy distillation・LoRA RL・SFT を同じ基盤で回せる OSS (SGLang + Megatron-LM/FSDP)。**実装を回す段になれば有用だが、今月は R1 に絞る方針なので読む時期ではない。**R2 再開時に繰り越す。
- **2609.09054: Training-Free Task Vectors for LLM Behavioral Control** — **P2 3.5。**fine-tuning なしで、forward pass の統計から task vector 相当の rank-one 重み編集を作る。**R2 の「監督を当てる範囲」軸の端点になりうる** (監督を一切当てない側)。繰り越し候補。

**その他 (24 件):**

- 2609.09135: ERPO / probe-driven TTRL for code — P2 2.5。test-time RL の報酬設計。probe consensus は code 実行に依存し転用不可。
- 2609.09076: ActReview — P2 2.0。査読生成。rubric reward の設計は読み物だが P2 の recipe ではない。
- 2609.09062: MTL for Sparsely-Labeled Time Series (ぶどうの耐寒性) — P2 2.0。少データ転移の実例だが RNN・農業で recipe が持ち出せない。
- 2609.08943: REAL / Fact-Ablated Evaluation — P2 3.0。**証拠を削って予測が変わるかを見る**評価設計は [CALIPER](2609.08250.md) の swap 検査と同型だが、**同じ論点を CALIPER のほうが強く出している** (下端としてランダム初期化まで置いている)。重複で落とす。
- 2609.08788: AAA / AXON (EEG の異方性 attention) — P2 2.5。軸構造のある信号への inductive bias。運転データに同種の軸構造がない。
- 2609.08730: CVT-GS (3D Gaussian Splatting の後処理圧縮) — P2 2.0。モデル圧縮ではなくシーン表現の圧縮。
- 2609.08609: Sinhala の通時的意味変化 — P2 1.5。
- 2609.08607: GOLF (DINOv3 + LoRA、HANDS@ECCV 優勝解) — P2 2.5。challenge 報告。LoRA + trainable LayerNorm という組み合わせの実務メモ以上ではない。
- 2609.08576: 養育者フィードバックと文法学習の RL 研究 — P2 2.0。
- 2609.08543: STSG-VQA (外科の時空間シーングラフ) — P2 2.0。
- 2609.08515: C-Voices / value vector steering — P2 2.5。fine-tuning 不要の steering という点で 2609.09054 と重複し、後者が上。
- 2609.08463: 電子-原子核断面積の domain adaptation — P2 2.5。**「ドメインギャップの大きさと、必要な fine-tuning の深さ」の系統的な層別分析**は P2 の関心に近いが、対象が物理データで recipe が転用できない。
- 2609.08404: FEE / Environments as Scaffold — P2 3.0 / hf 21。環境側を作り替えて RL の報酬疎性を緩和。着想は良いが agent 学習の話で P2 の適合とは別問題。
- 2609.08354: Stiefel 多様体上の Bayesian PEFT (SVGD) — P2 3.0。PEFT の calibration。conformal prediction と縁はあるが、R1 の今の範囲 (指標の定義) の外。
- 2609.08330: EMBLEM (多書体の表検出) — P2 2.0。masking で書体非依存にする発想は綺麗だが文書解析限定。
- 2609.08305: FPicker (Cryo-EM の繊維追跡) — P2 2.0。
- 2609.08221: SoftRerank (long-tailed micro-action) — P2 2.0。challenge 報告。
- 2609.08148: MR-RS-SDFR (心臓 MRI の左室再構成) — P2 1.5。
- 2609.08067: PopAnchor / Popular Knowledge Propagates More Errors — P2 3.0。**fine-tuning による知識破壊が「構造的に人気のある事実」に集中するという診断**は、R2 の破綻カタログに近い形をしている。ただし対象が事実知識の更新で、蒸留ではない。**R2 再開時の繰り越し候補。**
- 2609.08059: MI-PEFT (タンパク質言語モデル + MoE) — P2 2.0。
- 2609.08034: Two-Scale Localized PCA-Net (PDE operator learning) — P2 2.0。
- 2609.07986: LLM 埋め込みによる胸部 CT プロトコル選択 — P2 1.5。
- 2609.07971: MeRoTune (RoPE-safe な model merging) — P2 3.0。「補正行列が RoPE と可換でなければ打ち消しが成り立たない」という指摘は正確で気持ちがよいが、**merging は R2 の軸に乗らない。**
- 2609.07922: Prevalence calibration as shortcut mitigation — P2 3.0。**shortcut 学習を calibration の問題として読み替える**という発想は R1 の抜け穴監査と近い匂いがするが、対象は医療画像分類で、R1 が問題にしている「評価の分母」とは別の層の話。

### next_arch (9 件)

**次点 2 本:**

- **2609.08230: ActionSplice — In-Flight Action Editing for Interactive World Models** — **P3 3.5。**chunk 単位で生成する video world model に、**生成の途中で行動を差し替える**推論法 (Counterfactual State Transport)。rollback を再実行せずに済む。**閉ループで world model を使うときの反応遅延に直接効く**が、**R3 は今月着手しない方針。**繰り越し。
- **2609.09119: DeCAL — 接触を意識した dexterous VLA** — **P3 3.5。**Mixture-of-Transformers で理解・想像・行動の専門家を分け、視触覚の潜在共同想像を持つ。**R3 の分類マップの軸②③に素直に乗る好例**だが、同上の理由で繰り越し。

**その他 (7 件):**

- 2609.08855: Earth System World Model — P3 3.0。**観測された状態変化をラベル無しの行動監督として使う (transition-action pretraining)** という発想は転用の余地があるが、対象が地球生態系。
- 2609.08692: Global Divergence, Local Convergence (SSM と transformer の表現幾何) — P3 3.0。**「幾何は大きく違うのに実効容量と概念の符号化次元はほぼ一致する」**は面白い否定的結果だが、**設計判断に直結しない。**
- 2609.08209: RoboReel (観察からの学習のベンチマーク) — P3 3.0。ベンチマーク設計として [CALIPER](2609.08250.md) と目的が重複し、**「並べる力があるか」を検査するところまで踏み込んでいる後者が上。**
- 2609.08224: 3DWay (多視点から 3D waypoint を三角測量で出す) — P3 3.0。中間表現の設計としては素直だが、運転の planner とは粒度が違う。
- 2609.07838: ComVLA (6G での VLA split inference) — P3 2.5。512 → 32 token で計算 74% 減・成功率 -1.5pp。**token 削減の効き方は面白いが、通信路の制約が前提。**
- 2609.08342: VeriScene (法的証拠からの犯行現場再構成) — P3 2.0。world model の応用としては目を引くが、この loop の 3 プロジェクトに接続しない。
- 2609.08276: 署名検証の APS + T-Mamba — P3 1.5。

### sns_wildcard (3 件 — 採用 0)

- **2609.02750: Bilevel Coordinated Reflection** — **重複。09-09 に採用済み** ([briefs/2026-09-09/2609.02750.md](../2026-09-09/2609.02750.md))。**欠陥#2。**
- **2609.04010: Unlocking Lossless Speedups in LLMs via Discrete Diffusion (Uno)** — **重複。09-09 に採用済み** ([briefs/2026-09-09/2609.04010.md](../2026-09-09/2609.04010.md))。**欠陥#2。**
- **2609.08936: AuK — 音声生成・編集の基盤モデル** — **EXPLORE 3.0 / hf 150。本日唯一の新規 wildcard。****consistency initialization と task-routed Decoupled DMD で 4 ステップ推論に蒸留し 4.5 倍高速化**という部分は P2 に縁があるが、**多ステップ → 少ステップの蒸留は本日採用した [Marigold V2](2609.08084.md) が同じ操作をより近いドメイン (dense regression) で示している。**
  **そして本日は上限 6 が本流で埋まった。**探索枠は「分野外だが学びの価値があるとき最大 1 件」であり、**本流に 4.5 点が 3 本ある日に 3.0 点の分野外を入れる理由はない。**

---

## §2. 繰り越し (次に手が空いたときに読む順)

1. **2609.08230 ActionSplice** — R3 再開時。閉ループ world model の反応遅延。
2. **2609.08183 NeoHorse-1** / **2609.08368 Miles v0.1** — R2 の実装段。
3. **2609.09054 TFTV** / **2609.08067 PopAnchor** — R2 の「監督を当てる範囲」軸の紙作業に足す候補。
4. **2609.08936 AuK** — 手が空いたときのみ。**hf 経路 (HF Daily Papers) に乗っているので、再配信される可能性がある。**上の 3 つは arXiv 経路のみなので、**拾うなら今日メモした ID から手動で。**
