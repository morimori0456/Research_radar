# rejected 2026-11-07

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。candidates.json は 55 件 (generated_at 2026-11-06T18:00Z; planner_ai 2 / fm_distill_finetune 29 / next_arch 21 / sns_wildcard 3)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。

## 採用 (6 本)

2611.08111 (P1 4.5) / 2611.07912 (P1 4.0) / 2611.08128 (P3 4.0) / 2611.08156 (P3 4.0) / 2611.07722 (P2 4.5) / 2611.08016 (P2 4.5)。

- 2611.08111 と 2611.07912 は candidates.json では next_arch に分類されていたが、NAVSIM の planner score で評価する planner 側の改善 (学習時の負例 / sampling 時の guidance) なので P1 に置いた。planner_ai の 2 件は運転 planner ではなく (rehabilitation と grasp)、P1 の枠は next_arch から補った。
- 2611.06918 と 2611.06901 は昨日 (2026-11-06) に採用済みの論文が candidates.json に再来した。dedup で除外した。
- sns_wildcard 3 件は昨日までの 3 件 (2611.00859 等) と入れ替わった新規分だが、最高 3.0 で採用なし。

## 持ち越せる次点 (評価 3.5 以上)

- 2611.08414: Spectral and Subspace Dynamics of LoRA in Supervised Fine-Tuning and Reinforcement Learning — [4.0 次点] LoRA の singular spectrum / subspace が SFT と RL で逆向きに動く (RL は集中、SFT は拡大) ことを group-mean baseline subtraction に帰着し、SFT では spectrum を flatten、RL では LoRA 外成分を flatten する更新を提案。P2 の適合に有望だが、評価が数学 reasoning のみ。quota 超過で持ち越し
- 2611.07349: From What Is Used to What Is Missing: Rethinking Dynamic Rank in LoRA — [4.0 次点] LoRA の dynamic rank を、factor gradient で見えない normal space の spectrum から rank を増やす GEAR。LLaMA3-8B で trainable 42.0M→14.4M で commonsense 86.61→88.45。P2 の PEFT に近いが、quota 超過で持ち越し
- 2611.07939: WAM-Sim0.1: World Anchored Memory Meets Online RL for Consistent and Realistic Driving Simulation — [4.0 次点] WAM-Sim0.1: 階層的な persistent memory と online flow-matching RL で long rollout の drift を抑える運転 world model。P1 の closed-loop simulation 側で有望だが、評価が FID/FVD/mAP で planner 評価への接続が弱い。quota 超過で持ち越し
- 2611.08425: Failure Prediction and Classification in Vision-Language-Action Models Via Calibrated Latent Probing — [3.5 次点] VLA-Tug: VLA の latent を読む probe で failure を早期検出し、missed-detection / false-alarm 率に bound を付ける。runtime monitor の設計として参考になるが manipulation 限定
- 2611.08373: SLA: Scaling Spatial-Language-Action Model via Continual Pre-training — [3.5 次点] SLA: pi05 から continual pre-training し、中間 visual embedding を frozen 3D 模型の spatial 表現に揃える (推論構造は不変)。2611.06918 と同じ「中間層」の話だが manipulation 限定
- 2611.07730: Seeing Beyond the Next Step: World-Model-Guided Human-Like Navigation in Multi-Agent Scenes — [3.5 次点] world model を推論時でなく学習時の preference oracle に使い、group-relative preference distillation で fast policy に焼き込む (推論時は world model なし)。群衆内 navigation で運転の接点は間接的だが、amortize の発想は P3 向き
- 2611.08179: Knowing When to Teach: Learning from Teachable Prefixes in Multilingual Reasoning Distillation — [3.5 次点] 多言語 reasoning の On-Policy Self-Distillation で、teacher が有効な feedback を返せる prefix (teachable prefix) を選ぶ。P2 の OPD 系だが多言語 LLM 限定。今日は 2611.07722 / 2611.08016 で OPD 枠が埋まった

## 不採用

- 2611.08295: Transformer-Based Trajectory Prescription for sEMG-Optimizing Robot-Mediated Rehabilitation — planner_ai に分類されたが、sEMG から rehabilitation robot の接触力 trajectory を出す transformer。運転 planner と無関係 (1.0)
- 2611.07651: GraspBench: Execution-Aware Cross-Robot Evaluation of 6-DoF Grasp Generation in MuJoCo — GraspBench: 6-DoF grasp の cross-robot 評価 protocol (IK filtering → motion planning → 実行まで通す)。「提案の質でなく実行可能性で測る」評価の考え方は参考だが、manipulation で運転 planner に使えない (2.5)
- 2611.08294: ManimCode: Learning Visual Self-Correction for Educational Animation — Manim の教育アニメーションを視覚 feedback で自己修正する。P2 の適合と無関係 (1.0)
- 2611.08231: From Twisted Facts to Rogue Agents: Can LLMs Reliably Detect Multi-Dimensional Hallucinations? — HaluCheck: 多次元 hallucination 検出の bilingual benchmark。評価系だが LLM 出力の検出が対象 (1.5)
- 2611.08219: Agent-R$^2$: Scaling Agents for Realistic Productivity Work via Real-Source Data Synthesis — Agent-R2: 生産性業務の agent を実データ合成でスケールする。LLM agent の話で P2 と無関係 (1.5)
- 2611.08199: Do sEMG Foundation Models Improve Cross-Subject Generalisation? — sEMG foundation model の cross-subject 汎化の評価。「pretraining だけで被験者間 overfitting を防げるか」は domain gap の話だが、sEMG 限定の評価研究 (2.5)
- 2611.08081: TerraMesh-Masks: Open-Vocabulary Segmentation for Earth Observation — TerraMesh-Masks: 地球観測向け open-vocabulary segmentation。natural image から EO への domain 適合だが、データセット中心で recipe が薄い (2.5)
- 2611.08054: NutriVisRAG: Multimodal Exemplar Grounding for Nutrient Estimation with Vision-Language Models — NutriVisRAG: 食事画像の栄養推定を視覚的に近い exemplar で grounding。ドメインが遠い (1.0)
- 2611.07988: Compression Through a Context Lens: Evaluating Adaptation, Quantization, and Distillation in Arabic Legal LLMs — アラビア語法務 LLM で adaptation / quantization / distillation の影響を比較。圧縮手法の比較だが、with-context / no-context の評価差が主で単一ドメイン (3.0)
- 2611.07953: A Behavioural Framework for Predicting and Understanding Loss of Control in Frontier Artificial Intelligence Systems — frontier AI の loss of control を予測する behavioural framework。安全性の枠組みで P2 と無関係 (0.5)
- 2611.07940: CardioLM: A multilingual suite of small language models for the cardiology domain — CardioLM: 心臓病学の多言語 small LM 群。ドメイン適合の事例だが臨床 NLP 限定で recipe は一般化しにくい (2.0)
- 2611.07922: StitchEdit: Stitching Depth Priors into Image Editors via Per-Layer Gradient Probing — StitchEdit: 画像編集 diffusion に depth prior を層ごとの gradient probing で差し込む。適合の発想は面白いが画像編集 (2.5)
- 2611.07854: Towards Foundation Decision Models: Drex — Drex: 1 forward pass で選択肢を選ぶ decision model を基盤化する (hf 15)。蒸留・適合の recipe ではない (2.0)
- 2611.07850: Learning Robotic World Models with Semantic and Visual Feedback — ロボット world model に semantic / visual feedback を加える。P3 向きだが manipulation の world model で、構造の新規性は abstract から小さい (3.0)
- 2611.07825: Generate-then-Rank: Learning Symbolic Goal Interpretation for Embodied Agents — Generate-then-Rank: 自然言語 instruction を symbolic goal に変換する embodied agent の goal interpretation (2.0)
- 2611.07797: Dataset Collection and Fine-Tuning of NLLB for German--English Translation — NLLB の German–English 翻訳 fine-tuning と data 整備。標準的な fine-tuning の報告 (1.5)
- 2611.07755: Automated Video-to-QA Pipeline: End-to-End Question Generation and Verification Using Large Language Models — 動画から QA を生成・検証する pipeline (1.0)
- 2611.07736: Extending Reasoning in Typed Decision Models via Looping — typed decision model を layer looping で test-time compute 拡張する。構造の話だが decision model 限定 (2.5)
- 2611.07735: Evaluating Token Probabilities as Confidence Estimators in Human Behavior Simulations: A Case Study in Luxembourgish Next Like Prediction — LLM の token probability を人間行動 simulation の confidence として評価。calibration の話だが domain が社会科学 (1.5)
- 2611.07711: Fast and Accurate Hand Estimation in Pixels, Interaction and World Space — FAH: 単眼 hand mesh 推定 (SAM 3D 系)。手の推定で範囲外 (1.0)
- 2611.07705: FlyingDrones: A Dataset and Benchmark for Optical Flow Estimation from UAV motion — FlyingDrones: UAV の optical flow benchmark。データセット中心で範囲外 (1.5)
- 2611.07639: Measuring the Marginal Value of Verifier-Based RL Beyond Supervised Fine-Tuning — RLVR が SFT を超えて追加で寄与する分を制御設定で測る。fine-tuning の理解には参考だが LLM reasoning 限定で recipe ではない (3.0)
- 2611.07610: Embedding-Space Fingerprinting of LoRA Fine-Tunes: Recovering the Training-Data Domain from the Model Artifact Alone — LoRA fine-tune の weight delta から学習 data の domain を分類で復元できるか。privacy 側の話で適合 recipe ではない (2.5)
- 2611.07587: Fine-Tuning a Transducer for Impaired Speech: Where the Gains Appear and What They Mean for Evaluation — 障害のある話者向け ASR の transducer fine-tuning の challenge 参加報告。domain 適合の事例だが speech 限定 (2.5)
- 2611.07543: OptIMerge: Optimization-Based Merging of Diffusion Models — OptIMerge: diffusion model の merge を最適化で行う。merge は P2 に近いが対象が diffusion で、昨日の 2611.06486 ほどの接点はない (3.0)
- 2611.07323: Rethinking Data Selection: The Importance of Coverage over Difficulty in LLM Fine-Tuning — fine-tuning 用 data 選択では difficulty でなく coverage が重要。P2 の少データ適合に近いが LLM instruction tuning 中心 (3.0)
- 2611.08462: OopsieRecover: Learning Transferable VLA Corrections from Semantic Interventions — OopsieRecover: 意味的な介入から VLA の recovery 動作を転移可能に学習。manipulation の failure recovery で、P3 への接点は間接的 (3.0)
- 2611.08413: T3R: Training-Free Two-Stage Token Refinement Towards Efficient and Robust VLA Models — T3R: VLA の visual token を training-free で 2 段階に絞る。効率化として参考になるが manipulation 限定の token pruning (3.0)
- 2611.08338: GPWM: Modeling the World as 3D Particle Motion — GPWM: 3D 粒子の運動を生成する world model。rigid/deformable/cloth を統一する構造は面白いが、運転シーンへの接点が見えない (3.0)
- 2611.08160: Patch Attention Wisely: Understanding Patch Length in Attention-Based Forecasting — attention 型 時系列 forecasting の patch length の理論。運転・VLA と直接関係しない (2.0)
- 2611.08113: Identifying Neural Dynamics Using Nonlinear Interventional State Space Models — nonlinear interventional state space model で神経 dynamics を同定。state space model だが神経科学向け (1.5)
- 2611.07873: PVDepth: Panoramic Video Depth Estimation via Geometry-Aware Spatiotemporal Adaptation — PVDepth: パノラマ動画の depth 推定。world model への言及は応用先のみ (2.0)
- 2611.07867: PlayGen2: Learning Real-Time Playable Worlds with Explicit 3D State — PlayGen2: explicit 3D state で playable world を real-time 生成。ゲーム向け world model で、運転との接点が小さい (2.5)
- 2611.07712: AffectiveVLA: Safe and Intent-Aware VLA Control for Human-Humanoid Social Interaction — AffectiveVLA: humanoid の social touch 用の intent-gated VLA (1.5)
- 2611.07513: Concertina: Embodying Manipulation and Cognition in One Diffusion Vision-Language Model — Concertina: 拡散型 VLM 1 つで manipulation と cognition を統合する VLA。構造は新しいが manipulation 限定で、運転への接点は 06918 / La-JEPA に劣る (3.0)
- 2611.07411: Kinematic Hypothesis Context: Embodiment-Conditioned Learned Video Coding for Bandwidth-Limited Robot Policy Uplinks — Kinematic Hypothesis Context: 関節情報から作る zero-rate 条件で robot 向け video 符号化の bit を節約。VLA の通信の話で、model 構造とは別 (2.5)
- 2611.07245: MAC-v2: Long-horizon model-based value expansion from pixels — MAC-v2: pixel 入力の offline RL で long-horizon model-based value expansion。world model 系だが小規模 RL benchmark (3.0)
- 2611.06918: From Pixels to Actions - Towards Native Vision-Language-Action Policies — 重複: 2026-11-06 に採用済み (NEO-VLA)。dedup で除外
- 2611.06901: Motion-guided Contrastive Regularization For Latent World Models — 重複: 2026-11-06 に採用済み (Motion-guided Contrastive Regularization)。dedup で除外
- 2610.00854: Are Frontier VLM Agents Ready to Be Robot Generalists? An Empirical Study with the Embodied Agent Arena — [wildcard / hf 104] Embodied Agent Arena: frontier VLM 10 個を robot generalist として 5 軸で評価。VLA の周辺評価で面白いが、手法でなく評価報告で今日の枠の学びは薄い (3.0)
- 2611.06728: Turns Matter: Advancing Streaming Video RL via Turn-Level Credit — [wildcard / hf 86] Turns Matter: streaming video RL の GRPO に turn 単位の credit assignment を入れる。video 理解で追う分野外 (2.5)
- 2611.05275: Route Anything: A Study of Model and Policy Routing for General-Purpose AI Systems — [wildcard / hf 85] Route Anything: 複数 model / tool を orchestrate する routing の study。分野外で運転・蒸留と接続しない (2.0)
