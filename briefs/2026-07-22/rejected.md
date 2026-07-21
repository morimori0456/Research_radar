# 落選候補 — 2026-07-22

採用 6 / 候補 48。以下 42 件は「id: title — 落とした理由」。
基本方針: relevance_criteria で採点し、topic quota(各2)+ max_deep_per_day=6 の上限内で高得点のみ採用。

## planner_ai (P1) — 4 件落選(採用: 18060 のみ)
- 2607.17898: Manifold-Guided Motion Planning for Tight Assemblies (CMG-RRT) — 剛体組立の sampling-based planner。手法は綺麗(critical manifold へ sampling を bias)だが対象が精密嵌合で、自動運転 planner/評価への転用余地が薄い。
- 2607.17818: Task-Space Constrained Stochastic Trajectory Optimization for Forestry Crane — 林業クレーンの油圧制約下 time-optimal 計画。ドメイン特化が強く、AD への持ち帰りが乏しい。
- 2607.17542: Finite-Time Curvature-Constrained Vector Field for Nonholonomic Robots — Ackermann 車両で curvature 制約付き計画という点は関連するが、learning ではなく古典的 vector-field 制御。ML planner プロジェクトへの学びが限定的で 18060 に劣後。
- 2607.17476: Disturbance-Aware Flight for Aerial Robots in Narrow Space — quadrotor の空力外乱対応。ドメイン外。

## fm_distill_finetune (P2) — 28 件落選(採用: 18236, 17467)
### 惜しくも quota 落ち(スコアは高い / 追跡候補)
- 2607.17952: What Transfers Under Source Shift? — cross-source 適合の実証研究。「source shift 下では LoRA/retrieval が優位を失い、simpler is safer」「definition 転移が最も安定」は P2 に効く教訓。quota 上限で見送りだが**次点**。P2 の適合戦略設計時に本文参照推奨。
- 2607.18199: PPL-Factory — task/budget-aware な perplexity ベースのデータ選別。1% データで SOTA 選別を超える再現可能 recipe。強いが 18236/17467 に僅差で劣後。
- 2607.18164: Continual Validation Digital Twin (LoRA + drift 検知 + Mann-Whitney 検定) — 「fine-tune が本当に改善したかを統計的に certify する」angle が P2×P1 に良いが、対象が digital twin surrogate で汎用性は中。
- 2607.18014: SAMRI-3D (SAM2 の 3D MRI 適合) — encoder 凍結 + decoder 適合、推論時に破棄する TSDF 補助 objective(Global Volume Tokens)の trick は転用価値ありだが医療特化で quota 落ち。
- 2607.17511: Lightweight Wrappers for TSFM — バックボーン非公開・非 fine-tune で推論時アンサンブル適合。black-box 適合の着想は良いが対象が時系列気候予測。
### relevance 中〜低(ドメイン特化・システム寄り・タスク限定)
- 2607.18237: The Many Senses of Visual Similarity (TPIPS) — VLM を perceptual similarity 指標に fine-tune。データセット貢献は良いが我々の適合/蒸留テーマから距離。
- 2607.18227: FlowMimic — 動画編集データ生成 + modality mimic loss。生成/編集寄りで P2 の蒸留 recipe とは軸が違う。
- 2607.18209: ATLAS (multi-environment factor model の invariant/transferable 因子) — 理論寄りの transfer learning。実務 recipe というより統計的識別可能性の議論。
- 2607.18142: O-VAD — 工業動画異常検知の training-free agentic 枠組み。適合/蒸留ではなく推論時 reasoning。
- 2607.18101: Empowering On-Device Model Adaptation (Hailo-8L) — edge accelerator での凍結バックボーン特徴抽出 + head 適合。ハード実装寄り。
- 2607.18091: SciForma — 科学図の structure-faithful 生成 (M-DPO)。生成タスク特化。
- 2607.18081: SelectInfer — on-device LLM の neuron 選択的ロード/計算。推論最適化(システム)寄り。
- 2607.18046: SEE — long-horizon GUI agent の trajectory 合成。データ合成は良いが GUI ドメイン特化。
- 2607.18006: MADA-RL — compact model の debate-aware RL + LoRA。counterfactual critic advantage は面白いが reasoning benchmark 特化で quota 落ち。
- 2607.17913: AE-PSL — split learning の通信圧縮(AutoEncoder)。分散学習システム寄り。
- 2607.17902: Benchmarking small LLMs for biomedical ontology — 小 LLM fine-tune 評価。ドメイン特化の benchmark 論文。
- 2607.17782: BrainNext — 脳 MRI の自己教師 foundation model。医療画像特化。
- 2607.17766: EGTA — 同時音声翻訳の terminology 適合。NLP タスク特化。
- 2607.17738: LLMs for Citation Function Classification — 引用機能分類の fine-tune 比較。タスク特化。
- 2607.17693: MSSA — 医療画像 segmentation の training-free TTA。手法は良いが医療特化。
- 2607.17668: SNIP — Unsupervised Graph Domain Adaptation の source node pruning。グラフ特化。
- 2607.17653: LFM — Source-Free Universal DA に FM 活用。関連はするが CLIP+LLM 擬似ラベルの組合せで新規性中。
- 2607.17599: ConsiSpace — video spatial reasoning の geometry consistency(post-SFT)。空間推論タスク特化。
- 2607.17593: Miles — PTM ベース Class-Incremental Learning の subspace 拡張。CIL 特化で本日の適合テーマから距離。
- 2607.17568: CoCurve — training-free structured LLM pruning の cross-module curvature。圧縮手法として筋は良いが quota 落ち(次点群の下)。
- 2607.17441: MSCA-FFT — deepfake 検知の spatial-frequency fusion。検知タスク特化。
- 2607.17399: PanAf-SBR — 野生類人猿の social behaviour 認識データセット。保全ドメイン特化。
- 2607.17382: Team DACTYL @ PAN 2026 — AI テキスト検知の data mixing。shared-task 特化。

## next_arch (P3) — 8 件落選(採用: 17521, 17977)
### 惜しくも quota 落ち(次点)
- 2607.17786: Reasoning as a Double-Edged Sword (VLA robustness) — 「reasoning を足すと VLA は頑健になるか」を正面検証し、latent-iterative reasoning が最も脆く monitor も adaptive attack で破れる、と示す。設計上の重要な教訓 + 評価 angle。quota 上限で次点。P3 の reasoning 導入を検討するなら本文必読。
- 2607.18016: POT-VLA (Persistent 3D Object Tokens) — 3D object token を跨-移動で永続化し、行動生成と幾何述語チェックの両方を同じ record で行う closed-loop VLA。verifiable execution の設計が良い。17521/17977 に僅差で劣後。
- 2607.18231: FM-VLA — 接触リッチ操作向けの force-based memory(VAE で force history を token 化)。非 Markov な操作の memory modality として新規。manipulation 寄りで quota 落ち。
### relevance 中〜低
- 2607.18171: FlashRT — real-time multimodal app を coding agent で最適デプロイ化(hf=3)。アーキ設計というより serving/deployment 最適化。
- 2607.18043: Adaptive Mamba Neural Operators — PDE を解く SSM neural operator。SSM だが対象が科学計算で我々のアーキ目標と距離。
- 2607.17710: Planning with Transformers (Chain of Computation + Structured Context Window) — looped transformer で planning を学習、Turing-tape 的 context。着想は面白い(P1/P3 の loop 構造)が toy planning domain(BlocksWorld/Hanoi)中心で実タスク検証が薄い。
- 2607.17669: Attention from Above — drone 物体位置特定 (YOLO-World 改)。検知タスク特化。
- 2607.17523: Thinking in Video — video generator の因果推論を審査する CGDJ。world model 評価の angle は良い(perception-prediction gap の指摘)が、生成モデル評価寄りで P3 のアーキ設計への直接 recipe は薄い。次点の下。

## sns_wildcard (EXPLORE) — 2 件落選(採用: 17423)
- 2606.29538: RESOURCE2SKILL (hf=128) — multimodal 資源から executable agent skill を蒸留。「蒸留」概念は P2 に触れるが、agent skill library の話で我々の projects への橋渡しが 17423(reward 設計 → trajectory 予測)より弱い。ワイルドカードは最大1件のため見送り。
- 2607.11683: RAGU (hf=128) — **既に 2026-07-21 にブリーフ済みの再提示(重複)**。dedup 欠如の症状が今日も顕在化した一例。既読につき却下。→ [[fetch-duplicate-candidates]]
