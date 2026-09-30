# 2026-10-01 不採用: candidates.json の 9 件すべてと、RSS で回収した本流の不採用 192 件

## §0 fetch 診断 (選別の前に実施)

- **本流 2 トピックが今日も 0 件。どちらも fetch のエラーによるもの** (`~/research_loop.log` 03:00 の実行):
  - fm_distill_finetune: `[fetch]   error: The read operation timed out`
  - next_arch: `[fetch]   error: HTTP Error 429: Unknown Error`
  - planner_ai だけ 6 件が返った。
  - 09-30 に止まった 406 に代わって、**429 (リクエストが多すぎる) と timeout** が出た。エラーの種類は変わったが、「本流の 0 件は API のエラー」という構図は 09-23 以来同じ。`fetch_candidates.py` の最新 commit は `313a283` のままで、backoff (失敗したら待って再試行) は今も入っていない。
- **選別中に `https://export.arxiv.org` へ max_results=200 で再クエリしたが、2 トピックとも再び 429 だった。**
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ) は 5 本とも 200 で返った。**new/cross の 2,080 件を topics.yaml の keyword で照合すると、planner_ai 6 件 (candidates.json と同じ 6 件)、fm_distill 139 件、next_arch 94 件。`briefs/` 全体の既読 id (1,679 件) を除くと、**未読は fm 120 件・next 83 件**。
- **判断: 今日は RSS で回収した本流も採点対象に含めた。**過去 3 回 (09-25・09-29・09-30) は、RSS 分を「candidates.json に無いので採点対象外」として繰り越しに回した。その結果、09-29 の TOP3 の 2 本は今日まで 3 日間ブリーフが無い。今日の candidates.json は、planner_ai の 6 件 (運転ではなく manipulation) と wildcard 3 件だけで、そのまま選ぶと P2・P3 は 0 本になる。そのため、fetch が正常なら入っていたはずの論文を candidates.json と同じ基準で採点した。**採用 6 本はすべて RSS から回収した分**で、各ブリーフの冒頭にそのことを書いてある。
- 回収できたのは RSS に載っている分、つまり最新の announce 1 回分だけ。API の窓 (09-28T18:01Z〜) のうち、この announce に含まれない部分は確認できていない。
- wildcard の `2609.29233` (ATD) は **09-30 の rejected.md で採点済み**の再配信。wildcard の fetch には既読 id の除外がない (欠陥#2 dedup)。

## §1 判断の分岐点

1. **P1 枠 2 本は、next_arch のクエリ (keyword `world model`) に当たった World4Scorer (`2609.36438`) と DRPE (`2609.32322`) を planner_ai に再分類して使った。**candidates.json の planner_ai 6 件は最高でも 3.0 (Executor-aware) だった。「P1 基準で 4.0 以上の他トピック候補に限り P1 枠を使う」という 09-12 の運用を適用した。
2. **探索枠 (sns_wildcard) は空けた。**本流の 3 トピックで 4.0 以上が各 2 本ずつ埋まり、全体の上限 6 に達した。wildcard の最高は ICL for Robots のサーベイの 3.0 で、4.0 の本流 (ATLAS・Bilinear WM・KL 不要 OPD など) を外してまで入れる理由がない。
3. **P2 の 2 本目は OTT3R を選び、同点 4.0〜4.5 の LLM の OPD 論文 3 本 (KL 不要 / TeacherGRPO / Train4Merge) は次点に回した。**09-30 に OPD (on-policy distillation) の論文を 11 本数え、そのうち 3 本はブリーフにした。そこで今日は、視覚基盤モデルの蒸留と、それに続くドメイン特化の recipe を優先した。

採用: P1 2/2 ・ P2 2/2 ・ P3 2/2 ・ wildcard 0/1 = **6/6**。

## §2 candidates.json の不採用 9 件

### planner_ai (6 件すべて manipulation・多脚ロボ。運転の論文は 0 件 = 欠陥#7 の keyword のずれ)

- 2609.36597: Executor-aware Candidate Selection via a Feasibility Certificate — P1 3.0 — **candidates.json 内の最高点。**planner の候補を「下流の制御器が実際に実行できるか」の証明 (certificate) で事前にふるう。geometry 上は有効な 5,085 候補のうち 795 は実行可能な指令が存在しなかった。「候補の選択段で何を弾くか」は World4Scorer・`2609.30818` と同じ主題だが、対象はマニピュレータで、証明は保守的 (実行可能なものの 7% も通さない)。追従側の失敗 (09-29 の繰り越し ECO) と並べる材料として記録
- 2609.36530: Trajectory-Level Mode Guidance for Controllable Diffusion-Based Multi-Robot Motion Planning — P1 2.5 — 拡散モデルで軌跡を生成するとき、大まかな事前軌跡を「ノイズが大きい段では強く、小さい段では弱く」効かせて、multimodality (複数の異なる解を出せる性質) を保つ。運転の diffusion planner に移せる発想だが、評価はロボットの toy 環境だけ
- 2609.36640: Foundation-Model-Guided Topology-Aware Semantic Risk Fields for Manipulation — P1 2.0 — 基盤モデルが物体ペアごとに出す「危険の方向と減衰」を 3D の cost field にして、motion planning に入れる。家庭内の manipulation 用
- 2609.37348: DROM: A Language-Guided Diffusion Framework for Multi-Skill Robotic Manipulation — P1 1.5 — DMP (Dynamic Movement Primitives; 軌跡を少数のパラメータで表す古典的な表現) で実演データを水増しして、言語条件付きの diffusion policy を学ぶ。manipulation 専用
- 2609.36561: Riemannian Splat Regression Models for Learning Time Fields on Arbitrary Riemannian Manifolds — P1 1.5 — 多様体上で到達時間の場 (NTFields 型) を学ぶ関数近似。理論寄りで、運転の planner の実装・評価には繋がらない
- 2609.37734: Recompositional Robotics: Cross-Domain, Open-set, and Lifelong Modularity Beyond Morphology — P1 0.5 — モジュール型ロボットの position paper (問題提起の論文)。`motion planning` に一致したのは導入部の一語だけ

### sns_wildcard (3 件)

- 2609.36012: In-Context Learning for Robots: Methods and Applications (hf 247) — EXPLORE / P3 3.0 — ロボットの ICL (in-context learning; パラメータを固定したまま、実演や対話から新しいタスクを推論する) のサーベイ。4 系統の 1 つが world-model-based control で P3 に近い。**探索枠の最有力だったが、全体の上限 6 を本流の 4.0 以上で使い切ったので不採用。**上限に余裕のある日に読む価値はある
- 2609.33439: Raven: The Harness of Harnesses for Composable Agentic Intelligence (hf 428) — EXPLORE 2.5 — LLM agent の harness (モデルを包む実行の枠組み。ツール・記憶・手順) を自動で作って組み合わせる multi-agent 系。注目度は最大だが、P1〜P3 のどれにも学びが繋がらない
- 2609.29233: Post-Training Leaves Behavioral Shadows on Unrelated Decisions (hf 258) — **09-30 の rejected.md で採点済み (P2 3.5)。**wildcard の fetch が既読 id を除外していないため再配信された (欠陥#2)。評価は変わらない

## §3 RSS で回収した本流のうち、次点 (4.0 前後。quota で落としたもので、質が低いわけではない)

### P1 / P3 (next_arch クエリ由来)

- 2609.32512: What Do Latent Predictive Vehicle Representations Retain? Measuring State, Geometry, and Local Response — P3 4.0 / P1 3.5 — **車両**のダイナミクスを JEPA 型の latent predictor で学び (IPG CarMaker; 車両運動のシミュレータ)、「状態を保持しているか」と「指令を少し変えたとき予測が応答するか」を分けて測る評価プロトコル。**小さな指令のパルスへの応答が、潜在空間の段階で simulator からずれる**。09-30 の上限落ち `2609.34684` と同じ主張の車両版で、DRPE と並ぶ評価論文。枠が 2 本なので DRPE (より一般的で toy に落としやすい) を優先した
- 2609.36333: ATLAS: Aligned Transport of Latent Structure for Reliable World Model Planning — P3 4.0 — encoder の表現にある状態間の相対関係を planning 用の潜在に移す loss と、1 次元の Wasserstein-2 輸送 (分布どうしを最小コストで重ねる計算) で潜在の周辺分布を較正する WEMReg。LeWM の改良で、AnisoWM と同じ系統。1 系統から 1 本という理由で AnisoWM (差し替えが正則化項 1 つで最小) を選んだ
- 2609.36305: Bilinear World Models: Learning Representations with Structured Dynamics for Efficient Control — P3 4.0 — 潜在ダイナミクスを bilinear (状態と行動の積の項だけを持つ形) に制限して、planning 時間をほぼ 3 桁縮める。長い horizon とリアルタイム制御でも成功した。**車載の計算予算では最も効きそうな論文**で、明日以降の最優先の繰り越し
- 2609.36645: Where Predictive Supervision Goes Shapes What VLA Policies Learn — P3 4.0 — VLA (Vision-Language-Action; 画像と言語から行動を出すモデル) に未来予測の補助 loss を足すとき、予測の精度ではなく「監督がどの表現に届くか」が分布シフトへの頑健性を決める、という統制比較
- 2609.37771: Faster and Better? Benchmark Bugs and Design Limitations Distort the Evaluation of Vision-Language-Action Acceleration — P1 3.5 — 学習なしの VLA 高速化手法が元の policy より高い成功率を出す異常から、7 ベンチマークで 22 個のバグと 4 つの設計上の限界を特定した。**修正すると手法の順位が逆転する (baseline が最下位から 1 位に)。**「異常に良い結果から評価器のバグを探す」手順は P1 の評価パイプラインの監査にそのまま使える。対象が manipulation なので DRPE の次
- 2609.33030: What Must a World Model Distinguish for Planning? — P3 3.5 — world model が保持すべき情報は、planning の問い・候補集合・planner で決まる、という十分性の階層 (mechanism / response / decision)。DRPE の理論版に近い
- 2609.37098: V2X-WAM: A Cooperative World Action Model for End-to-End Autonomous Driving — P3 3.5 — 路側インフラの観測を量子化して送り、E2E planner の候補軌跡ごとに未来の occupancy を予測して計画を直す。V2X (Vehicle-to-Everything; 車と路側設備などの通信) が前提で、単車の P3 には距離がある
- 2609.34599: The Low-Rank Structure of VLA Reinforcement Learning — P3 3.5 / P2 3.0 — flow 型 VLA の RL による更新は低ランクで、action expert の timestep module に集中する。「RL で何を学習させれば足りるか」の PEFT (Parameter-Efficient Fine-Tuning; 一部のパラメータだけを学習する適合) 的な示唆
- 2609.32921: Adaptive Latent Capacity for World Models (ALeWM) — P3 3.5 — 予測に効く情報を潜在の先頭の次元に集め、planning の容量を可変にする。LeWM の改良 (今日 4 本目)
- 2609.34375: LRC-JEPA: Disentangling Dynamics and Residual Context for Efficient World Models — P3 3.5 — 動く部分 (planning に使う) と見た目の文脈 (再構成にだけ使う) を分けた 5.5M の encoder で、DINO-WM・V-JEPA2 の encoder を上回る
- 2609.38163: Rethinking Representations for World-Action Modeling (ReWAM) — P3 3.5 — DINO 特徴の上に bottleneck を置き、action loss の勾配だけで表現を形づくる world-action model
- 2609.36227: One-Step Next-Latent Prediction Is Not a World Model — P3 3.0 — 1 ステップの潜在予測は条件付き平均を学ぶだけで、ロールアウトできる遷移にはならない、という短い理論ノート。isotropy 正則化は遷移の重みに勾配を与えない、という指摘は AnisoWM の議論の補助線になる
- 2609.33335: Does Learning to Predict the World Help Agents Act? — P3 3.0 — LLM agent の world-model 型 post-training で、予測の正解をずらしても、報酬をランダムにしても性能が伸びる。「world model を学んだから良くなった」の検証には対照実験が要る、という警告
- 2609.37398: DEWO / 2609.38164: Rho / 2609.36471: Staircase Policy / 2609.37772: Urgency-Aware Denoising / 2609.36967: VLA token pruning — P3 3.0 — いずれも manipulation の VLA の後学習・推論効率の改良。運転の構造への移植は間接的

### P2 (fm_distill クエリ由来)

- 2609.33791: Do We Really Need KL Divergence for On-Policy Distillation of Large Language Models? — P2 4.0 — OPD で KL loss は必須ではなく、teacher の確率の方が高い token に +1、低い token に −1 の報酬を与えるだけで、reverse KL の OPD とほぼ同じ学習になる。効くのは teacher と student の意見が大きく割れる一部の token の向きだけ。09-30 の `2609.35259` (KL の向きが性能を決める) と組で読む。LLM の OPD は 09-30 に 3 本ブリーフ済みなので次点
- 2609.33426: TeacherGRPO: Closing the Capacity Gap in Reasoning Distillation via Teacher Alignment — P2 4.0 — capacity gap に対して、teacher の側を student の分布に寄せる。普通の KD でやると teacher の推論能力が崩れるので、GRPO (Group Relative Policy Optimization; PPO の簡略版で LLM の RL 学習に使う) で teacher を適合させる。採用した `2609.31900` の「teacher を適合させる」効果の手法版
- 2609.32303: Train4Merge: A Controlled Single-Teacher Study of RL vs. SFT Teachers for OPD-Based Model Merging — P2 4.0 — 同程度に強い teacher でも、RL で作った teacher は初期値の近くに留まるので、SFT で作った teacher より student が追いやすい (Agentic で teacher の伸びの 115% 対 44% を回収)。`2609.31900` の compatibility の議論と同じ結論を別の角度から出している
- 2609.38154: LongLive-Plug: Once-for-All Distillation for Video Generation — P2 3.5 / P3 3.0 — 動画 diffusion の蒸留 (少ステップ化・CFG の 1 回化) を base model 上の LoRA として 1 回だけ学び、54 の下流モデルに再学習なしで差し込む。「蒸留を下流モデルごとに繰り返さない」という発想は P2 の運用コストに効く
- 2609.36407: What Makes High-Magnification Knowledge Transferable? — P2 3.5 — 病理画像の解像度間の蒸留で、「teacher の特徴を上手く再構成できること」と「下流で効くこと」がずれる。再構成誤差を蒸留の評価指標にしてはいけない、という教訓で、DRPE の P2 版にあたる
- 2609.37243: Codebook-Guided Cross-Modal Knowledge Distillation for Structurally Heterogeneous Features — P2 3.0 — 構造の違う特徴 (2D の画像の格子と 1D の音声の系列) の間の蒸留を、ベクトル量子化した codebook を経由して行う
- 2609.37602: When to Adapt: Multi-Signal Domain Shift Detection — P2 3.0 — 学習なしの適合を「いつ発動するか」をドメインシフトの検出で決める (open-vocabulary segmentation)
- 2609.32124: Guarded Freezing / 2609.34478: Input-Conditioned Plasticity / 2609.32493: SoFT — P2 3.0 — fine-tuning でどこを凍結・どこを動かすかの改良。忘却対策として P2 の端
- 2609.33727: A Statistical Perspective on Knowledge Distillation (review) — P2 2.5 — KD の Bayesian 統一解釈のサーベイ。recipe ではない
- 2609.31785: Cross-Modal Knowledge Distillation for Acoustic Pedestrian Detection — P2 2.5 — 視覚 → 音響の歩行者検出の蒸留。応用が特殊
- 2609.32749: Retrospective Distillation Attribution (SCOUT) — P2 2.0 — 蒸留元の teacher を出力の構文パターンから特定する監査手法

## §4 RSS で回収した本流の残り (タイトルと abstract の冒頭で 3.0 未満と判定)

fm_distill のクエリは keyword `fine-tuning` が広すぎて、蒸留・適合と無関係な論文 (LLM の応用、医療、分子、GUI agent など) が大半を占める。next_arch の残りは、manipulation の VLA、ドメイン外の world model (サイバー防御・GUI・気象・音声など)、時系列の SSM (state space model; 状態空間モデル。系列を線形の再帰で処理する構造)。各行の理由は、そのグループの見出しにまとめて書いた。

### fm_distill_finetune (P2 < 3.0 — keyword (主に `fine-tuning`) には一致するが、蒸留・他ドメイン適合の recipe ではない)

- 2609.36416: FineART: Fine-grained Annotated Robotic Trajectory Dataset and Vision-Language-Action Model for Bimanual Manipulation — kw: fine-tuning
- 2609.37476: Learning Social Navigation from Internet Videos in the Policy State Space — kw: fine-tuning
- 2609.38172: Counterfactual Video Generation Enables Scalable Humanoid Loco-Manipulation — kw: fine-tuning
- 2609.37670: MeanFlowAdvantage: Stable Reward Fine-Tuning for Few-Step Average-Velocity Generators — kw: fine-tuning
- 2609.36368: AdaKerNet: Neural Kernel Decoding for Task-Adaptive Prediction with Multimodal Large Models — kw: fine-tuning
- 2609.36475: Similar Choices, Different Attention: Cross-Modal Associations in Humans and Vision-Language Models — kw: fine-tuning
- 2609.36557: How Medical VLMs Underutilize Their Vision Encoders: A Dermatology Perspective — kw: fine-tuning
- 2609.36651: FocusVTC: Efficient and High-Performance Visual Text Compression with Adaptive Resolution — kw: fine-tuning
- 2609.37264: UniAfford: Token-Routed Multitask Learning for Generalizable 2D-3D Affordance Perception — kw: fine-tuning
- 2609.37378: Do-JEPA: From Masking to Intervention in Latent World Models — kw: fine-tuning
- 2609.37775: HiRAE: Hierarchical Representation Autoencoding with Residual Budgets — kw: fine-tuning
- 2609.31639: When Does Domain Adaptation Help on Physical Vibration Sensors? A Held-Out-Bearing Study of Neural-Operator and Convolutional Models — kw: domain adaptation
- 2609.31659: Cross-Material Support Transfer for Core-Loss Prediction Under Waveform Covariate Shift — kw: fine-tuning,transfer learning
- 2609.31882: DOHF: Online Diffusion Fine-tuning with Doob's $h$-transform Guidance — kw: fine-tuning
- 2609.31947: On-Policy Attention Linearization — kw: fine-tuning
- 2609.31960: Model-Agnostic Online Certificate-Driven Calibration for Time Series Forecasting Under Distribution Shift — kw: domain adaptation
- 2609.32143: Spectral Reversal: Counteracting Singular Value Bias for Graph Prompting — kw: fine-tuning
- 2609.32271: Certification Frontiers for Gaussian LoRA: Independent Priors, Posterior Risk, and Prediction-Preserving Balancing — kw: fine-tuning
- 2609.32470: On the Pitfalls of Verbalized Confidence Priors for Calibrating Large Reasoning Models — kw: fine-tuning
- 2609.32530: Activation Flow: Manufacturing Activations for Steering — kw: fine-tuning
- 2609.32619: Intuition vectors — kw: fine-tuning
- 2609.32661: Equivariant Neural Primal-Dual Assignment for Maximum Common Edge Subgraphs — kw: fine-tuning
- 2609.32665: Timestep Weighting: A Hidden Key to Effective ELBO-Based Flow-Matching RL — kw: fine-tuning
- 2609.32676: SIFT: Enhancing Time Series Foundation Models via Semantic Invariance and Structural Fidelity Fine-Tuning — kw: fine-tuning
- 2609.32756: Reuse or Relearn? A Spectral View of Earth Observation Foundation Models — kw: fine-tuning
- 2609.32771: Continual Learning via Self-Probe Gradients — kw: fine-tuning
- 2609.32792: Understanding and Exploiting Anisotropy in Post-Training — kw: fine-tuning
- 2609.32849: Transfer Learning for Edge Classification on Dynamic Text-Attributed Graphs — kw: transfer learning
- 2609.33106: CARVE: Breaking Data Barriers in Chip Placement by Harnessing Reusable Expertise — kw: fine-tuning
- 2609.33127: Policy Plasticity Matters in Offline-to-Online Reinforcement Learning: Refitting Offline Policies for Online Adaptation — kw: fine-tuning
- 2609.33147: CFLoRA: Federated Fine-tuning of LLMs with Complementary Factors for Error-free Aggregation — kw: fine-tuning
- 2609.33194: Orthogonal Witness Control for Muon Optimization via Sigmoid Spectral Reshaping — kw: fine-tuning
- 2609.33254: BERT4DTI : BERT-based Model for Predicting Drug-Protein Interactions — kw: fine-tuning
- 2609.33424: A Light Bilevel Refinement Aligns Self-Supervised Representations for Stronger Task-Specific Learning — kw: fine-tuning
- 2609.33437: SMAT: Simple and Efficient Merge-Aware Training — kw: fine-tuning
- 2609.33548: TerMeZO: Ternary Sparse Zeroth-Order Optimization for Fine-tuning BitNet Models at the Edge — kw: fine-tuning
- 2609.33780: Selecting Diverse SFT Traces Improves Post-RL Generalization — kw: fine-tuning
- 2609.33927: Optimizing the Phi-2 Small Language Model for Real-time Chatbot Applications Using Parameter-Efficient Fine-Tuning (PEFT) with QLoRA Quantization — kw: fine-tuning
- 2609.34077: MaskCoFT: Masked Co-Adaptive Fine-Tuning for Memory-Efficient MoE Inference — kw: fine-tuning
- 2609.34156: Transfer Calibrated Prediction Powered Inference — kw: fine-tuning
- 2609.34185: EntroPack: Fast and Accurate Entropy-Coded Weight Compression at Arbitrary Bitrates — kw: fine-tuning
- 2609.34301: One Sequence, Many Decodings: CAGenMol-2 Recasts Drug Design as Masked Molecular Inference — kw: fine-tuning
- 2609.34467: Alignment-Guided Flow Transformer for Efficient Vision-Language-Action Policy Learning — kw: fine-tuning
- 2609.34561: Brain-Conditioned Action Policies for Neural Motor Decoding — kw: fine-tuning
- 2609.34642: Tilted Schr\"odinger Bridge Matching — kw: fine-tuning
- 2609.34866: From Attention Sensitivity to Layer Role: Revisiting Mixed-Precision Quantization of Transformers — kw: fine-tuning
- 2609.34970: See it, Say it, Sorted: Mechanistic Diagnosis and Parameter-Space Mitigation of Emergent Misalignment in LLMs — kw: domain adaptation
- 2609.35044: BA-DPO: Bias-Adjusted Direct Preference Optimization for Language Model Alignment — kw: fine-tuning
- 2609.31629: ChestPheNoT: Deployable, Auditable Label-Status-Evidence Extraction from Radiology Reports — kw: fine-tuning
- 2609.31657: Enhancing Foundation Models for Imbalanced SAR Ship Classification via Targeted Oversampling — kw: fine-tuning
- 2609.31787: Optimal transport meets speech: a tutorial review — kw: domain adaptation,transfer learning
- 2609.31957: CaptchaArena: A Large-Scale, Fine-Grained Dataset for Training Computer-Use Agents on Interactive CAPTCHAs — kw: fine-tuning
- 2609.32293: TRAP: Understanding and Mitigating Privacy Memorization in Language Models — kw: fine-tuning
- 2609.32517: LocalProp: Neuro-Localized Memory-Efficient Backpropagation — kw: fine-tuning
- 2609.32730: Domain Adaptation with Target Information via Doubly-Anchored Distributionally Robust Optimization — kw: domain adaptation
- 2609.32870: Counterfactual Self-Evolving Agents for Evidence-Grounded Reasoning — kw: fine-tuning
- 2609.33183: Identifying Temporal Features within Transcoders for Time Sensitive Factual Recall — kw: fine-tuning
- 2609.33407: Let CSP Be Your ANCHOR: Adaptive Crystal Search over Frozen Structure Priors — kw: fine-tuning
- 2609.33490: Domain-Adapted Diffusion Models for Conditional Independence Testing — kw: domain adaptation
- 2609.33796: RAISE: Reinforcing Access Control Policy Synthesis in LLMs via Symbolic Evaluation — kw: fine-tuning
- 2609.33878: Curating Merchant-Matching Training Data with Two Confidence-Gated Local LLM Judges — kw: fine-tuning
- 2609.33985: The Privacy Fallacy of Crowdsourced Fine-Tuning: Extracting Proprietary Data via Topic-Based Poisoning — kw: fine-tuning
- 2609.33989: RewardExplainer: Learning Reward Model Explanations from Counterfactual Preference Feedback — kw: fine-tuning
- 2609.34385: Just-In-Time Agent Memory with Runtime Agentic Research — kw: fine-tuning
- 2609.34460: When Does Structured Knowledge Help Neural Theorem Proving? — kw: fine-tuning
- 2609.34667: Two-Timescale Fine-tuning Provably Learns New Features for Two-Layer ReLU Networks — kw: fine-tuning
- 2609.34756: Statistical Benefits of Fine-Tuning from Pretrained Initialization in Diagonal Linear Networks — kw: fine-tuning
- 2609.34771: When Do Model Internals Help? Exploring the Role of Representation Engineering in LLM Safety — kw: fine-tuning
- 2609.34994: From One-Shot Generation to Incremental Music Composition: Adapting a General-Purpose Instruction LLM for Persistent Symbolic Editing — kw: fine-tuning
- 2609.31688: Don't Repeat Yourself: Self-Supervised Fine-Tuning for Coverage — kw: fine-tuning
- 2609.32042: Quantization Thresholds Replicate, Failure Modes Do Not: A Three-Model Study of Agentic Tool Use in Polish from 8-bit to 2-bit — kw: model compression
- 2609.32496: Locally Sound, Globally Insufficient: The Local-Global Gap in Multi-Hop Reasoning — kw: fine-tuning
- 2609.32684: Focusing Condition: Inference-Time Self-Contrastive Steering Elicits Better Conditional Text Embeddings in LLMs — kw: fine-tuning
- 2609.32717: LLM Alignment--Utility Asymmetry under Semantic-Preserving Transformations — kw: fine-tuning
- 2609.33155: Where Do Test-Time Scaling and Training Fall Short in Individual Stance Prediction? — kw: fine-tuning
- 2609.33296: BaatCheet: A Multilingual Corpus for Dialogue Translation in Indian Languages — kw: fine-tuning
- 2609.33441: MIC: Explaining Image-Claim Inconsistencies in AI-Generated Multimodal Misinformation — kw: fine-tuning
- 2609.33463: Rethinking Token Reweighting for SFT: Suppress, Reverse, and Extrapolate Learned Features — kw: fine-tuning
- 2609.33634: Safety Reconstructed: Generative Modeling via Masked Diffusion Builds Strong Safety Guardrails — kw: fine-tuning
- 2609.33670: Closing the Cross-Dialect Gap: Query Plans as a Portable Interface in Text-to-SQL — kw: fine-tuning
- 2609.33720: From Granular Revision Operations to Meaningful Revision Units: Evaluating LLMs for Revision Boundary Detection — kw: fine-tuning
- 2609.33886: LLMs learn different forms of metacognition when trained to predict their own accuracy — kw: fine-tuning
- 2609.33987: Opera: A Verbal Critic Framework for Long-horizon Coding Agents — kw: fine-tuning
- 2609.34033: Faithful Activation Verbalization: Reducing Hallucinations in LLM Representation Interpretation — kw: fine-tuning
- 2609.34125: Understanding Clinical Cognitive Dialogues Using Large Language Models — kw: fine-tuning
- 2609.34798: InfiMed2: A Generalist Medical Multimodal Foundation Model from Contextual Evidence and Stability-Aware Supervision — kw: fine-tuning
- 2609.31871: IndustryLLM: Failure-Driven LLM Training for Industrial Procurement — kw: fine-tuning
- 2609.31892: NVAlign: Direct-Gradient Optimization for Non-Verbal Control in Continuous Autoregressive Flow Matching Text-to-Speech — kw: fine-tuning
- 2609.31908: Improving Medical Calculation of LLMs with Embedded Coding — kw: fine-tuning
- 2609.34217: Explainable and Generalisable LLM-based Cognitive Decline Detection with Spontaneous Speech — kw: fine-tuning
- 2609.34327: Knowing When Thinking Is Not Enough: Teaching Small Reasoning Models to Reason Beyond Their Parametric Knowledge — kw: fine-tuning
- 2609.36172: Exploring Learning Models for Topological Relationship Recognition from Image Data — kw: transfer learning
- 2609.36219: LeRF: Learning Reference Coordinate Frames for Perspective Taking Reasoning — kw: fine-tuning
- 2609.36616: CrossTimeEdit: A Decade-Spanning Cross-View Dataset and Reward-Guided Editing for Historical Street-View Generation — kw: fine-tuning
- 2609.36644: OCA: ODE-Driven Cross-Attention for Image-to-Point-Cloud Registration — kw: fine-tuning
- 2609.36798: Seeing What Should Be Heard: Diagnosing and Repairing Cross-Modal Shortcuts in Omni-Modal LLMs — kw: fine-tuning
- 2609.36826: Learning via Self-Consistency for Diffusion-based Video Reasoning — kw: fine-tuning
- 2609.37016: Back2Struct: Making Structured Images Editable Again — kw: fine-tuning
- 2609.37096: Why MLLMs Struggle to Count: Overcoming Individuation and Aggregation Bottlenecks with ConvStack — kw: fine-tuning
- 2609.37485: PoE-Fuse: Precision-Weighted Expert Fusion for Bi-Temporal Change Understanding — kw: fine-tuning
- 2609.37496: GeoSET: Generalist Foundation Model for SAR-to-EO Image Translation — kw: fine-tuning
- 2609.37655: Exemplar2VQA: A Scalable Exemplar-Driven Visual Question Answering Generation Framework via Multi-Agent Coding — kw: fine-tuning
- 2609.37918: SYNCR: Diagnosing and Learning Cross-Video Reasoning from Simulation — kw: fine-tuning
- 2609.36001: Making Cross-Continental Federated Learning Repeatable with FLIP: a Multi-Application Study — kw: fine-tuning
- 2609.36965: Chinese-Jev: Bringing System One Model to Chinese-Language Tasks — kw: fine-tuning
- 2609.37759: Selective Channel Restoration for Backdoored Vision-Language Models — kw: fine-tuning

### next_arch (P3 < 3.0 — manipulation 固有の VLA の改良か、運転・planning と無関係なドメインの world model / SSM)

- 2609.36413: One from Infinity: Actualizing Futures from Pretrained World Models into Robot Actions — kw: VLA,world model
- 2609.36518: LIBERO-MAX: Do Robot Policies Adapt When the World Changes? — kw: VLA
- 2609.36540: Reactive Real-Time Flow Policies via Asynchronous Distribution Alignment — kw: VLA
- 2609.36582: Inferring Soil Friction Angle from Robot Foot-Ground Force Histories: A Bayesian Inverse Approach to Proprioceptive Soil Sensing — kw: world model
- 2609.36588: Cooperative Multi-Agent Vision-Language-Action Models via Reinforced Fine Tuning — kw: VLA
- 2609.36774: LexiconVLA: Learning Reusable Atomic Action Codebooks for Unseen Tasks — kw: VLA
- 2609.36915: AeroManip-VLA: Scalable Vision-Language-Action Learning for Aerial Manipulation with RL-Generated Demonstrations — kw: VLA
- 2609.36928: ComManip: Overfitting Manipulation Policies to Comfortable Regions — kw: VLA
- 2609.37150: CoRe-VLA: Preserving Cross-View Coordination in VLAs under Camera Shifts — kw: VLA
- 2609.37165: Disentangling Spurious Correlations in Vision-Language-Action Models via Predicting Domain-Invariant Latent Lookahead — kw: VLA
- 2609.37181: EgoHumanoid-V2: Human-to-Humanoid Transfer of Coordinated Whole-Body Skills for Loco-Manipulation — kw: VLA
- 2609.37307: Remember What You Did: Action-History Memory with Dual-Expert Denoising for Long-Horizon Vision-Language-Action Policies — kw: VLA
- 2609.37334: Taming VLAs under Robot Execution Errors: Self-Compensation and Stress Testing — kw: VLA
- 2609.37530: RawVLA: Embodied Neural Image Signal Processor For Robotic Manipulation — kw: VLA
- 2609.37922: WayFinder: Hierarchical Visual-Language-Action for Zero-Shot Waypoint Generation and Low-Level Kinematic Control — kw: VLA
- 2609.38078: MotorMind: Scaffolding General Vision Language Models for Zero-Shot Robot Manipulation — kw: VLA
- 2609.36352: StructRL: Online Structured Reinforcement Learning for Long-Horizon Vision-Language-Action Tasks — kw: VLA
- 2609.38140: Breaking the Uniformity Trap: Scaling Video Diffusion Model via SplitMoE — kw: world model
- 2609.31648: Energy Vision--Language--Action: A Controlled Multimodal Benchmark for Intent-Conditioned Residential Energy Management — kw: VLA
- 2609.31893: CyberWorld: World Models for Sample-Efficient Autonomous Cyber Defense — kw: world model
- 2609.31938: Cache-Aware Conv3D Lowering Across Embedded World-Model Decoders — kw: world model
- 2609.32108: SAMBAR: Selective Anchoring via Method of Multipliers for Balanced Knowledge Acquisition and Retention in Vision-Language-Action Models — kw: VLA
- 2609.32447: Length-Independent State Tracking Under a Parallel Scan — kw: state space model
- 2609.32486: Elastic Selective Spectral Hybrids for Train-Once, Export-Many Budgeted Inference — kw: state space model
- 2609.32679: The GUI Is Not the State: Diagnosing State Aliasing in GUI World Models — kw: world model
- 2609.32966: Self-Confirming Superposition Traps in Reinforcement Learning — kw: world model
- 2609.33336: Beyond Conservatism: Recoverability-Conditioned Exploration for Model-Based Imitation Learning — kw: world model
- 2609.33347: MultiEcho: An Experimental Science of Learned Worlds — kw: world model
- 2609.33563: MA-JEPA: Joint-Embedding World Models for Multi-Agent Reinforcement Learning — kw: world model
- 2609.33728: ALDER: Discovering the Laws of a World by Acting in It — kw: world model
- 2609.33940: Behavioral Monitoring of JEPA World Models with Jacobian Centroids — kw: world model
- 2609.34058: Do World Models Learn Global Understanding? — kw: world model
- 2609.34159: WorldGraph: Graph-Native World Modeling — kw: world model
- 2609.34409: MASCIT: A Mask-Aware State Space Classifier for Naturally Irregular Time Series — kw: state space model
- 2609.34604: Shaping Persistent Representations from Independent Interactions — kw: world model
- 2609.34677: Learning What to Recall: Adaptive Multi-Cue Episodic Memory for World Models — kw: world model
- 2609.31904: GT-VLA: Target-Conditioned Trace Guidance for Generalizable Robotic Manipulation — kw: VLA
- 2609.32550: Are Vision-Language-Action Models Robust to One-Step Observation Perturbations? — kw: VLA
- 2609.32591: Think Fast, Plan Selectively: Adaptive Deliberation for Efficient Data-Driven MPC — kw: world model
- 2609.32708: One-Step Generative Modeling via Unbalanced Optimal Transport — kw: VLA
- 2609.32779: Copper-Policy: Focus on the Representation for Robust Robot Manipulation — kw: VLA
- 2609.33378: Recursive Harness Distillation across Agents for Robot Manipulation — kw: VLA
- 2609.33595: Beyond One-Step Accuracy: State-Affine Latent Transition for Reliable Visual Planning — kw: world model
- 2609.33832: Achieve What You Imagined: Learning to Align Actions with Visual Plans — kw: world model
- 2609.33844: ViBR-WM: Visual Bayesian Regression for World Modeling — kw: world model
- 2609.34035: 3D Point Tracking with State Space Models — kw: state space model
- 2609.34261: RoboICL: Embodied In-Context Learning with GPT-6 Astra — kw: VLA
- 2609.34286: Dexterous Tactile World Model — kw: world model
- 2609.36531: Foresight at the Event Boundary: Evaluating Physical Prediction in Video World Models — kw: world model
- 2609.36677: ReWorld-Track: A Recursive Event World Model for Language-Guided Multi-Camera Tracking — kw: world model
- 2609.36810: MeteoVerse: Unified Weather-Controllable Video World Model — kw: world model
- 2609.37004: World2Motion: Turning Video World Models into 3D Human Motion Generators — kw: world model
- 2609.37107: Waypoint-1.5: A Real-Time Video World Model for Consumer Hardware — kw: world model
- 2609.37690: Honeycomb: Constant-Size Scene Memory Representation for Video World Models — kw: world model
- 2609.38123: HelixWorld: A Real-time Interactive Audio-Visual World Model — kw: world model
