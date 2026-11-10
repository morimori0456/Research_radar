# rejected 2026-11-11

採用 5 本 (上限 6 本)。candidates.json は 64 件 (planner_ai 4 / fm_distill_finetune 30 / next_arch 27 / sns_wildcard 3)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。採用の閾値は直近の運用と同じ 3.5 点で、水増しはしていない。

## 採用 (5 本)

- 2611.12382 (P1 4.0) AutoVLA-D
- 2611.12251 (P2 4.0) RAIL
- 2611.12676 (P2 4.0) VLA Adaptation with Real and Simulated Data
- 2611.12286 (P3 4.5) VLA-MOPD
- 2611.11856 (P3 4.5) DeltaForge

P1 (planner_ai) は 4 件中、閾値を超えたのは AutoVLA-D のみ。残り 3 件 (ROS 2 framework 2 件と multi-robot MPC) は運転 planner の実装・評価に直結しない。

## 不採用

3.5 点以上で quota 超過により落とした次点は LO-World (2611.11912, 4.0)、Distilling Instructions into Weights (2611.11894, 3.5)、2611.11887 (3.5)、2611.11780 (3.5)。

- 2611.12306: ExoStack: A Modular and Reconfigurable Software Framework for Wearable Robotics Using ROS 2 — ExoStack: ウェアラブル robotics の ROS 2 framework。自動運転 planner と無関係 (1.0)
- 2611.11830: ROS2MR: Connecting ROS 2 Motion Planning to Mixed-Reality Trajectory Visualization — ROS2MR: ROS 2 の motion planning を mixed reality で可視化。自動運転 planner の評価でなく可視化ツール (1.5)
- 2611.11755: Graph-Sparse Distributed Predictive Control for Multi-Robot Motion Planning vianEdge-Consensus ADMM — multi-robot の分散 predictive control。planner の実装手法だが、運転 planner の評価や設計に直結しない (2.0)
- 2611.12864: Is Persona Generalization Predictable? — persona generalization の予測可能性。LLM の fine-tuning 汎化の研究で、domain 適合の recipe ではない (2.0)
- 2611.12825: MaxIM: Maximally Informative Incremental Summarization via Reinforcement Learning — MaxIM: 要約の RL。トピック外 (1.0)
- 2611.12791: Large Language Models as a Universal Searcher for Open-World Automated Machine Learning — LLM を AutoML の探索に使う。トピック外 (1.0)
- 2611.12628: Adapting Small Language Models to Romanized Nepali: Tokenizer Fertility, Reference Likelihood, and Generation Metrics — ネパール語ローマ字への小型 LM 適合。言語適合で、tokenizer の知見は運転・VLA に移らない (2.0)
- 2611.12587: AgentOPSD: Turn-Level Credit Assignment via Recursive Belief Revision — AgentOPSD: 自己蒸留の turn 単位 credit assignment。対象は ALFWorld の LLM agent で、P2 の蒸留 recipe として移植性は未確認 (3.0)
- 2611.12544: Learning inexact alternating minimization for convex problems with quadratic coupling — convex 最適化の inexact alternating minimization。トピック外 (1.0)
- 2611.12524: EditJudge-Bench: Auditing VLM Image-Edit Judges with Synthetic Ground Truth — EditJudge-Bench: 画像編集 judge の benchmark。トピック外 (1.0)
- 2611.12411: PhysOPSD: Code as Privilege for Physically Plausible Video Generation — PhysOPSD: 実行可能 code を privileged context にした on-policy self-distillation (video 生成)。発想は面白いが video 生成の物理 post-training で P2/P3 から遠い (3.0)
- 2611.12311: MNN-Pocket-0.3B Technical Report — on-device LLM の技術報告。multi-teacher on-policy distillation を post-training の 1 段に使うが主題は小型 LLM の co-design で、蒸留 recipe の新規性は abstract から読めない (2.5)
- 2611.12285: Learning Evidence-Grounded Reasoning for Context-Aware Time Series Forecasting — 時系列予測の evidence-grounded reasoning。keyword 一致のみ (1.5)
- 2611.12225: A Cost That Practice Accuracy Hides: Worked Solutions in Self-Generated Training Data and the Compositional Use of New Rules — self-generated training data の worked solution が compositional な再利用に与える影響。2B model・invented rules の小規模研究 (2.5)
- 2611.12068: MIRIX-2.0: Multi-Agent Memory System — MIRIX-2.0: multi-agent memory system。トピック外 (1.0)
- 2611.12044: Leveraging High-Activity Post-Therapeutic I-131 Scans for Deep Learning Reconstruction of Extremely Sparse Planar Images in Differentiated Thyroid Cancer — I-131 scan の画像復元。医用 (1.0)
- 2611.12038: DPGS-SLAM: Diffusion-Prior and Provenance-Aware Monocular Gaussian Splatting SLAM for Dynamic Visual Sensing — DPGS-SLAM: 動的環境の monocular Gaussian splatting SLAM。keyword は "diffusion prior" 経由の一致で、トピック外 (2.0)
- 2611.11979: FireGate: Bounding Behaviour Change Before Training in Continual RL Fine-Tuning — FireGate: LoRA 更新を gate で包み、振る舞いの変化を学習前に PAC 保証付きで bound する。continual fine-tuning の forgetting 対策として面白いが LLM の安全寄りで、PEFT recipe としての接点は薄い (3.0)
- 2611.11964: 3R-Adapter: Retrieval, Rewiring, and Refinement for Efficient Adaptation of 3D Reconstruction Model — 3R-Adapter: 3D reconstruction model の PEFT。relational structure を直す発想は適合の参考になるが、対象が 3D 再構成 (3.0)
- 2611.11960: Operation-aware Multimodal Clinical Decision Support System for ICU Discharge Risk Assessment — ICU の退室リスク評価の multimodal 支援。医用 (1.0)
- 2611.11906: RBA: A Read-out Basis Adapter for Parameter-Efficient Interactive OCTA Vessel Segmentation with SEEM — RBA: SEEM (汎用 segmentation model) を OCTA 血管 segmentation に PEFT で適合。少データ適合だが医用画像に限定 (2.5)
- 2611.11875: Beyond Head Importance: Collective Computation in Video Transformers — video transformer の head の集合的計算の解析。適合 recipe ではない (2.0)
- 2611.11838: Improving Confidence Estimation in Language Models with Linear Representations of Ambiguity — 言語 model の confidence 推定。主題が違う (2.0)
- 2611.11836: MDA framework: multi-architecture domain adaptation for unsupervised person re-identification — MDA: unsupervised person re-ID の multi-architecture domain adaptation。re-ID に限定 (2.5)
- 2611.11821: Direct Trajectory Optimization for Inference-Time Alignment of Text-to-Image Diffusion Models — text-to-image diffusion の inference-time alignment。トピック外 (2.0)
- 2611.11812: CaseLaw: A Policy-Decoupled Framework for Training-Free Content Moderation — CaseLaw: training-free の content moderation。トピック外 (1.0)
- 2611.11792: APO2CS: Advantage-Aware Preference Optimization for Two-Level Constructive Search in Combinatorial Optimization — APO2CS: 組合せ最適化の preference optimization。トピック外 (1.0)
- 2611.11761: BridgeKV: Large-Model Prefill and Small-Model Decoding for LLM Inference via KV Cache Translation — BridgeKV: 大 model prefill + 小 model decode の KV cache 変換。蒸留ではなく推論の分業 (3.0)
- 2611.11752: Spectral Rank and Step-Direction Dynamics in Language-Model Post-Training — post-training の重み更新の spectral 解析。分析中心で、そのまま回せる recipe がない (3.0)
- 2611.11718: Accelerated Reinforcement Learning for Soft Robotics: Hours Instead of Years — soft robotics の RL 高速化。運転と遠い (1.5)
- 2611.11697: SurgTAP-3D: A Large-Scale Cross-Surgery Video Dataset with Contact-Aware 3D Motion Tracking — SurgTAP-3D: 手術 video の 3D tracking dataset。医用 (1.0)
- 2611.12806: Learning Heterogeneous Tactile Representation for General Dexterous Manipulation — tactile 表現学習 (hf_upvotes 92)。注目度は高いが触覚 manipulation でトピック外。hf_upvotes は relevance を上書きしない (1.5)
- 2611.12732: $Σ$-LeWM: Learning World Models via S-Information for Robot Control — LeWorldModel に backward dynamics と inverse dynamics の loss を足した小改良。manipulation 対象で運転への根拠が薄い (3.0)
- 2611.12678: Library of Hands: Fix the Hands, Not the World Model — 凍結 world model で command → action の対応 (hand) だけを補正する training-free 手法。controller/camera 変更への適合として面白いが manipulation の simulation 限定 (3.0)
- 2611.12557: WanderBench: Can World Models Explore Dynamic Worlds from Video? — video-conditioned world model の benchmark (WanderBench)。生成 video の faithfulness 評価で、運転 planner の評価とは別 (2.5)
- 2611.12353: QCC-WM: Linking Macro-State Dynamics and Visual Generation via Quotient Causal Construction — visual world model の macro-state 構成。理論色が強く、実験規模・運転への接続が abstract から読めない (2.5)
- 2611.12324: How Many Exposures Does a World Model Need? Learning Unseen Game Mechanics at Test Time — ARC-AGI-3 の game mechanics を test-time に学ぶ world model。運転・robot への接続が遠い (2.5)
- 2611.12319: Mitigating SM-Level Load Imbalance in 3D Gaussian Splatting on GPUs — 3D Gaussian Splatting の GPU load balance。world model ではなく systems 最適化 (1.5)
- 2611.12295: Be My Eye: Learning to See Beyond a Robot's Own Perspective — robot 自身の視点外を見る学習 (Be My Eye)。manipulation/perception 寄りで具体的な接点が弱い (2.5)
- 2611.12136: LHNav: Long-Horizon Humanoid Navigation via Multirate Coordination and Physics-Grounded Action Data — LHNav: humanoid の long-horizon navigation。運転 policy への接続が弱い (2.5)
- 2611.12113: Motion Belief Action: From a Visual Scene Map to Physical Decisions — Motion Belief Action: 人の環境で物理的な判断を行う decision layer。運転と遠い (2.0)
- 2611.12026: MambaPD: Bidirectional Selective State Space Model for Parkinson's Disease Detection from Resting-State EEG — MambaPD: パーキンソン病の EEG 検出に state space model。適用先が医療 (1.0)
- 2611.12014: Benchmarking language models and agents for scientific reasoning in evolving materials laboratories — 材料実験室の言語 agent の benchmark。トピック外 (1.0)
- 2611.11981: Thermo-VLA: A Thermal-Aware Vision-Language-Action Model with Gated Residual Modulation for Robotic Manipulation — Thermo-VLA: 熱画像を使う manipulation VLA。センサ追加の発想はあるが運転への接続が薄い (2.5)
- 2611.11921: An Evaluation of Tabular Foundation Models as Training-Free World Models — tabular foundation model を training-free の world model として評価。表形式 data 向けで運転と遠い (2.0)
- 2611.11912: LO-World: Unified BEV Latent Modeling for Joint 4D Occupancy and LiDAR Forecasting — 運転の 4D occupancy + LiDAR forecasting の world model (4.0)。ただし P3 の quota 2 を DeltaForge と VLA-MOPD が先に埋めた。次点
- 2611.11897: ShopMind: A Mental World Model for Personalized and Realistic E-commerce User Simulation — ShopMind: e-commerce の user simulation。名前だけ world model (1.0)
- 2611.11894: Distilling Instructions into Weights: Closed-Form Edits Fix a Robot Policy's Misreading — 凍結重みへの closed-form edit で VLA の誤読を直す。gradient なしの適合は面白いが、1 課題 (π0.5 / RoboLab) の修理で recipe として一般化しにくい。P2 の quota 内で RAIL と VLA 適合 case study を優先 (3.5、次点)
- 2611.11887: How Many Candidates Does a One-Step World Model Need? A Random-Codebook Account of Nearest-of-m Training on Frozen DINO Tokens — one-step world model の nearest-of-m (m=16) が 50-step flow matching より被覆が良く latency 1/30。着想は良いが frozen DINO token と enumerable な benchmark の理論寄りで、運転への接続が遠い (3.5、quota 超過)
- 2611.11869: Action Representation for Spatial Generalization in Robot World Models — robot world model の action 表現 (皮むき課題)。座標系の選択の知見は一般的だが課題が特殊 (2.5)
- 2611.11854: Decoupled Asynchronous System for Humanoids (DASH): Latency-Agnostic Scaling of Vision-Language-Action Models for Humanoid Manipulation — DASH: VLM と action head の非同期分離。humanoid manipulation 対象で、運転 latency への接続は未確認 (3.0)
- 2611.11815: Generalizable Output Feedback Optimal Control via Transformers Without Explicit State Estimation — transformer による output feedback 制御。planner 評価でなく制御理論寄り (2.5)
- 2611.11798: PAIR: Proprioception-Aligned Image-Ray Representations for Viewpoint-Robust Manipulation — PAIR: manipulation の視点ロバストな表現。運転への接続が薄い (2.5)
- 2611.11780: Planners Exploit Deterministic Error: Dithered Low-Bit World Models — 低 bit 量子化した world model で planner が崩れる原因 (誤差が iteration をまたいで持続すること) と dither による対策。MPPI/CEM 系 planner を載せる運用なら参考になるが、P3 の優先度では次点 (3.5)
- 2611.11688: Streaming Failure Forecasting: VLA Failure Monitors That Keep Learning After Deployment — VLA の failure monitor を、episode ごとの成否で最後の線形層だけ再学習する。評価・安全 monitor として P1 に近いが、manipulation の実機対象 (3.0)
- 2611.11605: ScanDreamer: A Map-Grounded World Model for Quadrotor Navigation — ScanDreamer: quadrotor 向け map-grounded world model。ドローンで運転と遠い (2.5)
- 2611.06043: Confucius4-R2T2: A Stable-Prefix Streaming ASR Model for Real Real-Time Transcription — wildcard: Confucius4-R2T2 (streaming ASR; hf_upvotes 86)。音声認識でトピック外 (1.0)
- 2611.08264: SplatAnything: Gaussian Spacing Normalization for Feed-forward 3DGS across Arbitrary Scenes — wildcard: SplatAnything (hf_upvotes 67)。**2026-11-10 に既に rejected 済みの再来** (dedup)。feed-forward 3DGS で P1/P2/P3 への接点が薄い (1.5)
- 2611.10771: WorldFoundry: Towards Unified Infrastructure for World Intelligence — wildcard: WorldFoundry (hf_upvotes 51)。world model の定義と評価基盤。keyword "world model" には一致するが、infrastructure 紹介で具体的な学習・評価手法の新規性が abstract から薄い (3.0)
