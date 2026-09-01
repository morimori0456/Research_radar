# 2026-09-02 不採用の候補

候補 **49 件** / 採用 **6 件** / 不採用 **43 件**。
届いたラベル別内訳: planner_ai **0** / fm_distill_finetune **30** / next_arch 16 / sns_wildcard 3。
**内容による再分類後の採用内訳: planner_ai 2 / next_arch 2 / fm_distill_finetune 2 / sns_wildcard 0** (quota 通り、max_deep_per_day = 6 に一致)。

> **本流の候補は 4 日ぶりに戻った。**08-30〜09-01 の 3 日間は本流 3 トピック合計 0 件だったが、本日は 46 件。
> **08-31 (月) の arXiv 投稿が大量だったため、`lookback_days: 2` の窓でも引っかかった**というだけであり、**設定は 1 行も変わっていない** (`git log -- topics.yaml` の最終変更は初期構築時のまま)。**構造的な問題は解消していない。**

---

## §0. fetch の診断 —— 本日、新しい欠陥が 1 つ確定した

**候補が 46 件届いたおかげで、これまで「候補ゼロ」に隠れて見えなかったことが測れた。**

### 【新規・確定】欠陥#7: planner_ai の keyword が、実在する P1 論文を 1 件も拾えない

**planner_ai の届いた候補は本日も 0 件である。**しかしこれは供給不足ではない。**実測した事実は 2 つ。**

1. **`topics.yaml` の planner_ai の 4 キーワード (`motion planning` / `trajectory prediction` / `planner evaluation` / `closed-loop simulation`) は、本日届いた 49 件の abstract のうち 1 件にも出現しない。**

   ```
   $ python3 -c "...4 keyword を 49 abstract に対して部分一致..."
   total abstracts containing planner_ai keywords: 0 / 49
   ```

2. **`fetch_candidates.py` の topic ループは planner_ai を最初に処理し、`seen` 集合による重複排除も planner_ai が最優先である** (L133–148)。**したがって「他のトピックに先に取られた」possibility は排除される。planner_ai のクエリが本当に何も返していない。**

**そして本日の P1 最重要論文 3 本は、すべて next_arch のラベルで届いている。**

| id | タイトル | 本来の分類 | 届いたラベル | 一致した keyword |
|---|---|---|---|---|
| [2608.31029](2608.31029.md) | Driving on Memory | **planner_ai (ベンチマーク監査)** | next_arch | `end-to-end autonomous driving` |
| [2608.30819](2608.30819.md) | What Emerges and What Breaks in Self-Play Driving | **planner_ai (評価/失敗解析)** | next_arch | `driving policy` |
| 2608.30122 | Aligning Multi-Trajectory Supervision with Policy Optimization for VLA Driving | planner_ai + next_arch | next_arch | `VLA` |

**結論: P1 の論文は毎日ちゃんと投稿されている。planner_ai の keyword が、その論文たちが実際に使う語彙と一致していないだけである。**`planner evaluation` や `closed-loop simulation` は**論文著者が abstract に書く語ではない。**実際に書かれるのは `end-to-end autonomous driving` / `NAVSIM` / `Bench2Drive` / `driving policy` / `planning benchmark` である。

**これは lookback_days の問題とは独立で、lookback を 5 日に伸ばしても planner_ai は 0 件のままである。**

### 【再確認】欠陥#6: `max_results=30` による打ち切りが、本日は実際に発動した

**fm_distill_finetune の候補数はちょうど 30 件 = `max_results` の上限そのものである** (`fetch_candidates.py:47`)。**上限に張り付いているということは、cutoff を通過した論文が他にもあったが取得段階で捨てられた**ということ。next_arch は 16 件で上限に届いていない。

**そして本日 P2 で最重要だった [2608.31046 (OPD)](2608.31046.md) は、cutoff (08-30T18:00Z) を通過している** (公開 08-30T20:00Z) **にもかかわらず本流では届かず、HF buzz 経路から wildcard として入ってきた。**打ち切りで落ちた可能性が高い。**つまり「上限に張り付いたトピックでは、最良の論文が取りこぼされる」ことが、実例として出た。**

### 【4 日連続】欠陥#5: dedup が無く、ブリーフ済み論文が再提示される

wildcard 3 件のうち **2 件が 09-01 にブリーフ済み**である。

| id | タイトル | hf | 公開 | 経過 | 状態 |
|---|---|---|---|---|---|
| 2608.28281 | LoopArena: Benchmarking Models as Runtime Controllers for Loop Engineering | 98 | 08-27 | 6 日 | **重複** ([09-01 のブリーフ](../2026-09-01/2608.28281.md)) |
| 2608.18524 | DART-SD: Diamond-topology Aware Retrieval and Tuning for Self-Distillation | 88 | 08-18 | **15 日** | **重複** ([09-01 のブリーフ](../2026-09-01/2608.18524.md)) |

**08-29・08-30・08-31・09-01 に続き、これで再提示は 5 日連続である** (09-01 のみ重複ゼロだったが、本日また発生)。**hf_upvotes は 82→98 / 60→88 と伸び続けており、注目度の高い論文ほど長く枠を占有し続ける構造がそのまま出ている。**本日は本流が 46 件あったので実害は「wildcard 枠 1 の空振り」で済んだが、**本流ゼロの日にこれが起きると、その日は何も読めない。**

### 修正の順序 —— 本日、1 行増えた

```
1. topics.yaml:6         lookback_days: 2 → 5        ┐ 必ず同時に
   fetch_candidates.py:47   max_results=30 → 100     ┘ (本日、上限張り付きが実測された)
2. briefs/*/*.md のファイル名を除外集合に追加         (dedup。5 日連続で発生)
3. 【新規】topics.yaml の planner_ai keywords に実語彙を追加:
     "end-to-end autonomous driving" / "driving policy" / "NAVSIM" /
     "Bench2Drive" / "nuPlan" / "planning benchmark"
   ※ 3 は 1 とは独立。1 を直しても planner_ai は 0 件のまま。
4. ↑が動作確認できてから、wildcard に cutoff を適用 (欠陥#3)。
   HF 経路には本流と別の緩い窓 (例: 21 日) を持たせること
   (本日の DART-SD は公開 15 日後の再提示であり、緩い窓でしか届かない論文は実在する)。
```

**1〜3 を合わせて 20 分。**09-01 時点で「9 日間・15 分のまま」と書き、**本日 10 日目である。**

---

## §1. sns_wildcard (候補 3 / 採用 1 / 不採用 2)

| id | タイトル | hf | 公開 | P1 | P2 | P3 | 採否 |
|---|---|---|---|---|---|---|---|
| [2608.31046](2608.31046.md) | Does On-Policy Distillation Really Distill? | 88 | 08-30 | 1.5 | **5.0** | 1.5 | **採用 (fm_distill_finetune に再分類)** |
| 2608.28281 | LoopArena | 98 | 08-27 | 3.5 | 1.0 | 1.5 | 不採用 (**重複**) |
| 2608.18524 | DART-SD | 88 | 08-18 | 2.5 | 4.0 | 2.0 | 不採用 (**重複**) |

**本日、真正の wildcard (分野外だが学びのある論文) は 0 件である。**採用した 1 件は内容が完全に P2 本流であり、探索枠として使ったのではない。**残り 2 件は昨日読んだ論文なので、探索枠は空振りに終わった。**質の問題ではなく dedup の問題である (§0)。

---

## §2. next_arch (候補 16 / 採用 4 / 不採用 12)

うち 2 件 ([2608.31029](2608.31029.md) / [2608.30819](2608.30819.md)) は**内容により planner_ai へ再分類**して採用した。

| id | タイトル | P1 | P2 | P3 | 落とした理由 |
|---|---|---|---|---|---|
| **2608.30122** | Aligning Multi-Trajectory Supervision with Policy Optimization for VLA Driving | 3.5 | 3.0 | **4.5** | **本日の最有力次点。quota で落とした。**NAVSIM v1/v2 で 91.4 PDMS / 89.1 EPDMS、失敗シーン 658 件中 440 件を回復と数字が強く、**複数軌跡の supervision を Pareto 非劣解だけに絞る**という設計は R1 の mode coverage と 09-01 の [DART-SD](../2026-09-01/2608.18524.md) の両方に直結する。**採用 6 本のうち P1 の 2 本と主題が重なり、かつ「評価」ではなく「学習」の話なので、R1 に絞る 09 月の方針では優先度が一段下がった。GRPO / 複数軌跡の線を再開するときに最初に読むべき 1 本。** |
| 2608.30643 | Temporal Forcing: 4D Representation Alignment for VLA Models | 1.5 | 3.0 | **4.0** | 履歴を潜在に要約し、4D foundation model の幾何特徴と整合させる。**R3 の第 1 軸「時間をどこに持つか」の材料だが、本日は [2608.30692](2608.30692.md) が同じ軸をより根本的な水準 (勾配が届くか) で扱っており、そちらを取った。**R3 は今月着手しない方針でもある。 |
| 2608.30536 | Behavior-Skill: A Fine-Grained Benchmark for Evaluating VLA Policies in Long-Horizon Tasks | 3.0 | 1.5 | **4.0** | **評価の粒度を上げる (タスク全体の成功率ではなく、構成 skill ごとに独立評価する) という主張は R1 と同型で、「失敗が skill ごとに極めて不均一」という結果も本日の [Self-Play Driving](2608.30819.md) と同じ形。**ただし対象が家庭内の mobile manipulation で、運転への翻訳に一段の飛躍がある。**同じ主張をより近い領域で持つ論文を採用したので不採用。** |
| 2608.30378 | PAVE: Predictive Alignment and Value-Guided Evolution for World-Action Policies | 1.5 | 2.5 | **4.0** | JEPA 目的関数 + 残りエピソードの 25/50/75/100% 地点への多 horizon 整合 + 分布型 value critic。**設計は R3 の 3 軸すべてに触れるが、要素の組み合わせが多く、どれが効いたかが abstract から切り分けられない。**R3 が着手期に入ったら再訪。 |
| 2608.30237 | Motus2: A Self-Evolving General World Model for Dexterous Manipulation | 1.5 | 2.0 | **4.0** | **1 つの重みで policy / simulator / evaluator の 3 つの interface を露出させ、閉ループで自己改善する**という構成は R3 の統合アーキテクチャの直球。**ただしスケール・データ・ハード (両腕・多指ハンド・触覚) の総合報告であり、切り出して試せる設計判断が abstract からは取り出せない。**分類マップ作成時の参照として保存。 |
| 2608.30144 | Rethinking Language's Role in Efficient VLA for Autonomous Vehicles | 3.0 | 2.0 | **4.0** | **survey。**推論時に言語をどこで使うかで手法を 4 段 (L1 学習時のみ / L2 潜在推論 / L3 条件付き呼び出し / L4 毎フレーム生成) に分類する **Language Residue** 分類は、**R3 の分類マップにそのまま列として入る。**新規知見ではなく整理なので、ブリーフ 1 枠を使うより**マップ作成時に直接参照するほうが効率が良い。**リポジトリ公開予定。 |
| 2608.30880 | Zeva: In-Context Causal Learning for Generalizable Embodied Manipulation | 1.5 | 3.0 | 3.5 | 方策を凍結したまま、実機での相互作用を因果記憶に貯めて文脈として注入し、勾配更新なしで自己進化させる。**着想は良いが対象が manipulation で、運転への距離が遠い。** |
| 2608.30067 | How do World Models and Policies Compose in LLM Agents? | 1.5 | 3.0 | 3.5 | world model 学習と policy 学習のパラメータ更新が**入力側の部分空間を共有し、出力側はほぼ直交する**という幾何的分析。**R3 の「world model を明示的に持つ利得はどこで分離できるか」に効くが、対象が LLM agent で、本日の [2608.29998](2608.29998.md) が同じ問いをより制御に近い設定で扱っている。** |
| 2608.30289 | CometVLA: Co-Training on an Embodied Data Pyramid towards Physical Understanding | 1.0 | 3.0 | 3.5 | 物理常識の VQA を行動データと同じ embodiment に揃えて co-training。**「VLM の物理理解の向上が本当に行動生成に効くのか」という問いの立て方は良いが、貢献の主体はデータ構築である。** |
| 2608.30530 | WebWorld: The Browser as a World Model for Self-Improving Web Code | 2.0 | 3.0 | 3.0 | **「提案者と審査者が同一モデルだと、視覚的もっともらしさが動作の代理にならない」という問題設定は 09-01 の [LoopArena](../2026-09-01/2608.28281.md) と同一で、ブラウザを騙せない対抗者として使う解法も筋が良い。**ただし対象が web コード生成で、既に同じ論法の論文を昨日読んでいる。 |
| 2608.29967 | Training-Free Action Correction for VLA Model Failures via Language Feedback | 1.5 | 2.0 | 3.0 | **失敗モードの分類を作り、「修正できる部分集合」と「できない部分集合」の境界を明示した点は評価できる** (実行の大きさのずれは直せる / 意味理解の破綻は直せない)。手法自体は行動量の加算補正で軽い。 |
| 2608.30439 | Event-Driven Language Models with Sparse Neural Activity for Neuromorphic Hardware | 1.0 | 2.5 | 2.5 | 量子化した linear attention に活性のスパース性を誘導し、neuromorphic ハードで演算量 1/4。**車載の推論コストという文脈では読めるが、前提とするハードが手元にない。** |

---

## §3. fm_distill_finetune (候補 30 / 採用 1 + 再分類 1 / 不採用 29)

**30 件は `max_results` の上限そのもの** (§0 の欠陥#6)。**内訳の大半は医用画像・化学・多言語 NLP など、fine-tuning という語だけが一致した他分野である。**

### 次点 (基準は満たすが枠で落とした)

| id | タイトル | P1 | P2 | P3 | 落とした理由 |
|---|---|---|---|---|---|
| **2608.30899** | Uncertainty-Aware Trajectory Forecasting from Imperfect Tracking | **3.5** | 3.0 | 1.5 | **P1 の次点。**「予測器を綺麗な注釈履歴で学習・評価するが、実運用の入力は不完全な tracker の出力である」という指摘は、**09-01 の [LoopArena](../2026-09-01/2608.28281.md) が持ち込んだ第 5 軸「測った差が本当に planner の差か」を、perception 側から埋める材料。**検出の位置不確かさと対応付けの曖昧さを全分散の法則で 1 つの共分散にまとめ、Gaussian 観測として下流に渡す設計も実用的。**採用 2 本の P1 論文が「指標の抜け穴」で揃っており、主題を 1 日 1 方向に絞るために落とした。** |
| **2608.31058** | Improving Information Extraction with Learned Queries | 1.0 | **3.5** | 1.0 | **問いの設計を変えるだけで、抽出モデルを大きくするより F1 が伸びる (+18.6 点)。**W35 の P2 の結論「支配変数は loss ではなく周辺工程」の、また別分野での実例。**ただし対象が臨床文書の情報抽出で、R2 の系統則に直接は載らない。** |
| 2608.30908 | Fine-Tuning Low-Bit Models with Gradient in Quantized Code Space | 1.0 | **3.5** | 1.0 | 低ビットのまま適合させ、低ビットのまま配布する設定。**車載配備という文脈では価値があるが、R2 が今追っている「教師と生徒の関係」の軸には載らない。** |
| 2608.30858 | GAFT: Geo-Anchored Fine-Tuning for Hazard Identification from Rare Failures | 3.0 | **3.5** | 1.0 | **稀な失敗しかデータが無く、しかもフレームと結果しか紐付いていない (どの視覚手がかりが原因かは不明) という設定は、運転の long-tail と同型。**幾何由来の事前分布で LoRA の注意を誘導する。**F2 が 0.0607 → 0.3757 と改善幅は大きいが絶対値が低く、off-road 特化。** |

### 基準を満たさない (P2 3.0 前後・他分野)

| id | タイトル | 落とした理由 |
|---|---|---|
| 2608.30427 | Ceiling-Clipped Acceptance Histograms / DBloom | **「平均が隠すものをヒストグラムの天井ビンが暴く」という診断の作法は R1 と同型で、そこだけは価値がある。**内容は speculative decoding の block 長拡張で、P2 の軸には載らない。 |
| 2608.30619 | Hidden Threat in Synthetic Data: Covert Targeted Bias Injection | 合成データ経由で生徒にバイアスが伝染する。**「教師の何が生徒に伝わるか」という点で本日の [OPD](2608.31046.md) と裏表だが、主題は安全性。** |
| 2608.30827 | Error-Type-Aware Loss Reweighting for NER with Noisy LLM Labels | **LLM 由来のラベルノイズは種類が不均一なので、一律の頑健 loss では駄目**という主張。OPD 論文と問題意識が重なるが、系列ラベリング特化。 |
| 2608.30720 | Tracing distinguishability through transformer processing with stochastic LayerNorm | 表現に「体積」を与えて距離を統計的識別可能性に変える。蒸留 fine-tuning での配分学習まで含むが、理論寄りで実務 recipe が薄い。 |
| 2608.30609 | Adapting LLMs to Swedish Journalism Through Continued Pre-Training | **continued pre-training は experience replay と組でないと忘却で相殺される、という実務知見は有用。**ただし結論が既知の範囲で、対象言語も遠い。 |
| 2608.30563 | Modality Disentangled Learning / PriMD | モダリティ欠損時に、共有意味で primitive を検索して補う teacher-student。**「欠損への適合」という形は良いが感情認識特化。** |
| 2608.30731 | Calibrating Small Language Models for Claim Check-Worthiness | 推論時の後付け校正だけで小モデルを LLM 水準に。**「再学習せず後段で埋める」という発想は運用上の価値があるが、対象がファクトチェック。** |
| 2608.30462 | Enhancing Low-Resource Language Reasoning via HRL Feature Transfer | sparse autoencoder で抽出した特徴を steering で注入。**「能力が無いのではなく引き出せていない」という切り分けは面白いが多言語 NLP 特化。** |
| 2608.30974 | CoJEPA: Combining Contrastive Learning and JEPA | **contrastive の勾配で JEPA を安定させ、EMA teacher を完全に不要にした**点だけ P3 に薄く関係。対象は音楽表現。 |
| 2608.30456 | Self-Supervised Pretext Tasks for Infant Cry Analysis | **「80 倍大きい HuBERT でも同じ挙動なので、律速はラベルであってモデル容量ではない」という結論の型は R2 に一点だけ関係する** (容量説の棄却)。対象は乳児の泣き声。 |
| 2608.31157 | Sharp Approximation Rates for NN with Affine Latent Parameterizations | hypernetwork / PEFT / 圧縮を包含する枠組みの近似レート理論。**「固定次元の潜在でも誤差は消える」は綺麗だが、実務 recipe に翻訳できない。** |
| 2608.31119 | PaperGym: Rubric-Centered Evolution for Research-Plan Generation (hf 34) | **本ループのメタ運用としてのみ関係する** (論文から rubric を作り、質問と評価基準を別の節から作ることで criterion leakage を 3.7% まで下げる)。P1/P2/P3 のいずれの基準にも当たらない。**wildcard 枠に入れる案もあったが、枠は上限 6 に達している。** |
| 2608.31084 | The First Token Is a Clue: Verbalizing Multi-Token Concepts from the J-lens | LLM の解釈可能性。追っている 3 プロジェクトのいずれにも接点なし。 |
| 2608.30426 | Learning to Reason and Use Tools through Unsupervised Fine-Tuning in TOD | 自己改善ループで軌跡を集めて fine-tuning。**8B が 70B の in-context を上回るのは良いが、09-01 の [DART-SD](../2026-09-01/2608.18524.md) と同領域でより弱い。** |
| 2608.30702 | An Agentic Retrobiosynthesis Framework with Learned Frontier Selection | **反応エンジンを固定して探索方策だけを評価するという設計は [LoopArena](../2026-09-01/2608.28281.md) の Worker 固定と同型で、そこだけ価値がある。**内容は生合成経路探索。 |

### 分野外 (P1/P2/P3 いずれも 2.5 未満)

`fine-tuning` / `transfer learning` / `domain adaptation` という語だけが一致した他分野。**内容による除外であり、質の評価ではない。**

| id | タイトル | 分野 |
|---|---|---|
| 2608.31073 | LISynSeg: Cross-Modality Whole-Heart Segmentation | 医用画像 (CT/MRI 心臓) |
| 2608.31013 | TSPFN: Temporal Tabular Foundation Model for Physiological Time Series | 医用時系列 |
| 2608.31009 | Language-Informed Flow Matching for 3D Molecular Generation | 創薬 |
| 2608.30910 | S3C-LLM: Spectrum-to-Structure Elucidation | 分光化学 |
| 2608.30893 | ECGQuest: Benchmarking and Fine-Tuning LMs for Electrocardiography | 医用 (心電図) |
| 2608.30884 | Evaluating and Mitigating Anti-LGBTQ Biases in German and Multilingual LMs | 公平性 (多言語 NLP) |
| 2608.30844 | Tracer-Aware Interactive Segmentation Pipeline for AutoPET V | 医用画像 (PET/CT) |
| 2608.30709 | RailSyn: Railway Foreign Object Detection | 鉄道検査 (**稀事象の合成補完という点は GAFT と同種**) |
| 2608.30616 | OCR-Based Field Extraction for Archaeological Pottery Metadata | 考古学 OCR |
| 2608.30475 | ImageEval 2026: Culturally Grounded Arabic Multimodal Evaluation | 多言語マルチモーダル評価 |

---

## §4. 本日の選別についての注記

**選別に実質的な余地があったのは、8 月下旬以降で初めてである。**09-01 は「候補 3 件・採用 3 件・不採用 0 件」で、**選んだのではなく全部拾った**状態だった。本日は 49 件から 6 件を選んでおり、**採用率 12%。**

**採用 6 本のうち 4 本 ([Driving on Memory](2608.31029.md) / [Self-Play Driving](2608.30819.md) / [Intervention Gap](2608.29998.md) / [OPD](2608.31046.md)) は、論法が完全に同一である** —— **既存の集約指標が飽和している一方で、実際の性能や性質は劣化していることを実測で示し、既存指標が何を測っていないかを特定する。****これは偶然ではなく、R1 に絞るという 09 月の方針に沿って選んだ結果である。**
