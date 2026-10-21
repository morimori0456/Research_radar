# rejected 2026-10-22

candidates.json は 59 件 (planner_ai 0 / fm_distill_finetune 30 / next_arch 26 / wildcard 3)。採用は candidates から 3 件 (2610.28184・2610.28048・2610.28594)、RSS 回収分から 3 件 (2610.27714・2610.25497・2610.28122)。評価点は 0〜5 の概算で、abstract のみに基づく。wildcard は 3 件とも不採用 (下記)。

## candidates.json の不採用 (53 件 + 下の wildcard 3 件)

- 2610.28631: AEON: Unifying Video and 3D World Models — video latent から 4DGS (4D Gaussian Splatting) を出す統合 world model。VPM (2610.28594) と同じ 3D 整合の課題で、今日の P3 枠は VPM を優先 (評価 3.0)
- 2610.28622: MindView: Benchmarking Generative Multi-View Spatial Intelligence — 生成 model の multi-view 空間理解 benchmark。運転との接点が薄い (評価 2.0)
- 2610.28586: Capable Teacher, Myopic Scorer: Reward-Free Teacher Repair for Agentic On-Policy Distillation — agentic OPD の teacher 側を直す R2S。着眼は面白いが、10-21 の SPOD と同じ agent 課題の話で重複感が強い (評価 3.5)。次点
- 2610.28476: CLOSER: Evidence-Aware Active Visual Verification for Embodied Object-Goal Navigation — 屋内 navigation の能動的な確認。分野外寄り (評価 1.5)
- 2610.28474: Answering in the User's Variety: Calibrated Accommodation Pairs for Post-Training — 方言への応答調整。分野外 (評価 1.0)
- 2610.28457: GPT-6-Astra Understands Touch and Outperform Vision--Tactile--Language--Action Models — 触覚 VLA との比較。tactile は運転と遠い (評価 1.5)
- 2610.28411: Brain2Vec: A Self-Supervised 3D Foundation Model for Structural Brain MRI — 脳 MRI の基盤 model。分野外 (評価 1.0)
- 2610.28407: The Instruction Tax on Factual Recall: Base Models Can Beat Their Instruction-Tuned Counterparts — instruction tuning が事実想起を下げる分析。fine-tuning の副作用の観察だが、recipe が無い (評価 2.5)
- 2610.28382: RACE: Learning Multimodal Search through Referential Abstraction and Compositional Evidence — multimodal 検索 agent の RL。分野外 (評価 1.5)
- 2610.28360: Confessions of a Masked MDP — 部分観測 MDP の理論寄り。具体的な転用先が薄い (評価 1.5)
- 2610.28337: Beyond a Single Sentiment Score: Topical and Affective Dimensions of Emoji Meaning on Twitter — 分野外 (評価 0.0)
- 2610.28280: GALA: Geometry-Aware Language Model for Controllable Object Arrangement — 物体配置の LM。分野外 (評価 1.5)
- 2610.28272: How Language Models Learn Taste: Brand Preference in LLMs — 分野外 (評価 0.5)
- 2610.28214: Can Language Models Get "Aphasia" From Neuronal Ablation? — 分野外 (評価 0.5)
- 2610.28200: Parameter-Efficient Adaptation of Time Series Foundation Models for Electrical Load Forecasting — LoRA rank-16 で full FT の大半 (NMAE -7.5%、パラメータ約 1%) を回復する事例。P2 の対象 (基盤 model の別ドメイン適合) だが、新規性の無い比較研究で電力需要に特化 (評価 3.0)
- 2610.28176: Temporal Evidence-Parameter Co-Alignment for LLM Reasoning over Temporal Knowledge Graphs — 時間つき知識グラフ推論。分野外 (評価 1.0)
- 2610.28072: MuPACE: Learning to Pace Muon for LoRA Fine-Tuning — LoRA の学習率を meta-learn する recurrent policy (64 問中 64-78% で固定 schedule に勝つ)。P2 に使える運用寄りの話だが LLM の LoRA 限定で、蒸留とは別軸 (評価 3.0)。次点
- 2610.28051: Assessing Representation Semantics Under Language Pretraining in Fine-Grained Classification — 分野外 (評価 1.0)
- 2610.28007: AdaptMIL: Domain Adaptation for Multiple Instance Learning in Digital Pathology — 病理 slide の domain adaptation。ドメインギャップ克服だが病理 MIL 特化 (評価 2.5)
- 2610.27952: Unsupervised Head Network Personalization for Split Computing via Federated Learning — split computing の個人化。接点が薄い (評価 1.5)
- 2610.27913: ACE-Compression: An Ability-Centric Evaluation of Compressed Large Language Models — 圧縮 LLM の能力別評価 (量子化は pruning より retention が高い、など)。評価の考え方は P2 に使えるが LLM の対話能力が対象 (評価 3.0)
- 2610.27904: Staged Continual Adaptation of Multimodal Foundation Models for Japanese Financial Documents — 金融文書への段階的適合。ドメイン固有 (評価 2.0)
- 2610.27901: CollabSciReM: Aligning Language Models for Scientific Conversations via Science-Aware Reward Decomposition — 分野外 (評価 0.5)
- 2610.27870: Enumeration-Guided Training of Neural Hamilton-Jacobi Safety Certificates — 学習した safety certificate。制御の安全保証で P1 に遠く触れるが、対象の dynamics が低次元 (評価 2.5)
- 2610.27851: LaLa-World: Scaling Latent World Models with Natural Language Actions — JEPA 系 latent world model に言語 action を導入。学習コスト 6 倍減・planning 13.9 倍速と効率の主張は強い (評価 3.5)。次点。P3 の候補として明日以降も有力
- 2610.27847: SAPD: Learning from Agent Experience without Environment Interaction — agent 経験からの蒸留。agent 課題で今日の枠は他を優先 (評価 2.5)
- 2610.27815: ProVe: Proposer-Verifier Decoding — LLM の decoding 手法。分野外寄り (評価 1.5)
- 2610.27782: RoboJudge: Multimodal Language Models as Judges for Embodied Video Generation — 映像生成の VLM 審査。評価 model の話だが manipulation 動画向け (評価 2.5)
- 2610.27698: VLA-Retain: Benchmarking Cross-Dimension Effects of Vision Tuning in VLAs — VLA の視覚 tuning は target への gain が off-target では負 (10 設定中 8 で平均負)。ドメイン適合の副作用として P2/P3 に示唆があるが manipulation (LIBERO-Plus) 前提 (評価 3.5)。次点
- 2610.28626: UniWALM: Unified World Action Language Model for Embodied Robot Control — 世界・行動・言語の統合 model。DirectWAM と近い領域で、今日は latency の課題に直接答える後者を優先 (評価 3.0)
- 2610.28613: Physical Canvas: A Vision Tactile World Model For Robot Policy Evaluation And Learning — 触覚 world model。tactile 特化 (評価 2.0)
- 2610.28589: AgenticRoboRL: Bringing Coding-Agent Post-Training to Agentic Robotics — coding agent 型の robot RL。接点が薄い (評価 2.0)
- 2610.28555: Learning Computational Structure for Sample-Efficient Prediction — 理論寄り (評価 1.5)
- 2610.28554: OverSeer: Multi-Agent World Models Beyond What Agents See — multi-agent の部分観測 world model。他車の見えない状態の推定は運転に関係するが、設定が agent ゲーム寄り (評価 3.0)
- 2610.28495: Model- and Layer-Level Closed-Loop Forecasting with SSM-Based Spiking Neural Networks — SSM + spiking NN の予測。SNN 特化 (評価 2.0)
- 2610.28480: SuperMimic: Scaling Humanoid Whole-Body Control with One Differentiable World Model — humanoid の全身制御。運転と遠い (評価 2.0)
- 2610.28166: Reasoning as a Distribution: Generative Plan Latents for Vision-Language-Action Models — VLA の reasoning 状態を plan の分布で持ち、steering で目標追従率を 0.48 → 0.94 に上げる。複数の妥当な計画がある運転にも通じるが、manipulation (SimplerEnv) 検証 (評価 3.5)。次点
- 2610.28164: From Predictive Geometry to Action: Learning Complementary Predictive Representations for Embodied Manipulation — manipulation の表現学習 (評価 2.5)
- 2610.28109: FIT-MAC: A Closed-Loop Multi-Agent Framework for Robust Vision-Language-Action Models — VLA を multi-agent で包む推論時の枠組み。構造としての新規性が薄い (評価 2.0)
- 2610.28086: MoDDiT: Simple Token Routing in Diffusion Transformers — DiT の token routing による効率化。generative model の効率化だが運転への転用が遠い (評価 2.5)
- 2610.28074: Slot-JEPA: Object-Structured Prediction Interfaces for Latent World Models — JEPA に object slot と optimal transport を導入。物体中心の世界予測は運転と相性が良いが、評価が小規模 (評価 3.0)
- 2610.28019: PACT-VLA: Speculative Action-Chunk Verification with Pre-Commit Observations — VLA の推論高速化 (speculative に action chunk を検証)。P3 の latency に関係するが manipulation (評価 3.0)
- 2610.28011: Knowing When to Stop Thinking: A Dissection of Expected Free Energy as a Test-Time Compute Controller for Latent World-Model Planning — 計画の test-time compute 制御の分析。分析寄り (評価 2.5)
- 2610.27917: EventSync: Event-Driven Memory Updates for History-Dependent Manipulation — manipulation の memory 更新 (評価 2.0)
- 2610.27914: World Models with Configurable Perception — perception を設定可能にする world model。抽象的で具体策が見えない (評価 2.5)
- 2610.27890: EndoWorld-JEPA: Motion-Guided Global-Local Latent World Modeling for Endoscopic Video Representation Learning — 内視鏡映像。分野外 (評価 1.5)
- 2610.27861: RoboCasa-Shift: Stage-Aware Robustness Evaluation of Vision-Language-Action Policies in Long-Horizon Household Manipulation — VLA の頑健性評価 benchmark。家庭内 manipulation (評価 2.5)
- 2610.27657: PLaCA: Learning Patch-Level Future Latent Change for Action Generation — 未来の patch 変化を latent で予測して行動生成。P3 に近いが manipulation (評価 3.0)
- 2610.27417: KPHarness: Co-Evolving Knowledge and Probing for Long-Horizon Gaming Harnesses — ゲーム agent の harness。分野外 (評価 1.0)
- 2610.27387: Training Controllable World Models via Action Influence Maximization — world model が action を無視する問題を、データ収集 (AIM) で解く (500 episode の追加で 300k 相当の controllability)。world model を closed-loop 評価に使う P1 にも効く重要な観点だが、manipulation と navigation の simulation 上の結果 (評価 3.5)。次点
- 2610.27280: VPFlow: Value-Predictive Planning with Imperfect World Models for Offline Goal Reaching — 不完全な world model 下の計画。offline goal reaching で運転との接点が薄い (評価 2.5)
- 2610.27277: What Would Removing This Corruption Change? Failure Attribution for Vision-Language-Action Models — VLA の失敗の帰属分析。方向性は 2610.28184 と近いが、corruption 特化 (評価 3.0)
- 2610.27106: This is SParTA: A modular, efficient and scalable transformer architecture for jet-tagging — 素粒子物理の jet-tagging。分野外 (評価 0.5)

## wildcard (3 件、全て不採用)

- 2610.20951: LEV: Thinking Fast and Deep with Looped Decision Models — 10-21 に見送り済み。再来 (hf 602、評価 2.0)
- 2610.21046: PremiseCheck: Efficient Fact-Checking of Human and AI Peer Reviews — 査読の fact-check。分野外 (評価 0.5)
- 2610.20424: BizBench: Unveiling Hidden Challenges in Deploying Long-Horizon Agents for Real-World Business — 10-21 に見送り済み。再来 (評価 1.0)

## RSS 回収分の次点 (ブリーフ化せず)

RSS 5 本 (cs.LG / CL / CV / RO / AI; lastBuildDate 2026-10-21 04:00Z) のうち、candidates に無く keyword に当たった 581 件から、10-20 と 10-21 の記録にある id を除いた 537 件を走査した。announce の new / cross 分に絞って題名を見て、上位を abstract まで読んだ。replace (版の更新) は除外。

- 2610.25376: TILDE: Teacher-in-the-Loop Distillation from Embodied Foundation Models — 事前学習済みの embodied foundation model から、action pretraining 無しの policy へ on-policy distillation + teacher 介入の復帰軌跡で能力を移す (behavior cloning 比で最大 4.1 倍)。AutoDAgger で復帰軌跡の収集を 2 倍以上高速化。P2/P3 の両方に近く、評価 3.8。**明日以降の最優先候補**
- 2610.26950: Beyond Policy Discrepancy: Capability-Aware Multi-Teacher On-Policy Distillation — 10-21 の Nash-MOPD と同じ multi-teacher の domain 配分を、verifier で測った capability gap で決める CA-MOPD (評価 3.5)。重複感が強く見送り
- 2610.27467: Projected Distillation: On Learning to Solve Hard Problems from Close, Correct Targets — 全 attempt が失敗する難問で、student の失敗を最小限に直した「近い正解」に near-on-policy で学ぶ (評価 3.5)
- 2610.28194: Adaptive Pullback: Reweighting Supervision at Penalty Jumps in On-Policy Distillation — OPD の penalty jump で supervision を再重み付け (評価 3.0)
- 2610.27450: Ask to Distill: Learning to Synthesize Data for On-Policy Distillation — OPD 用のデータ合成を学習 (評価 3.0)
- 2610.27555: Can Native Safety Travel? Reusing Safety Pretraining Across Models via On-Policy Distillation — safety を別 model に OPD で移植。LLM safety 特化 (評価 2.5)
- 2610.28255: Convergent Performance, Divergent Mechanisms in LoRA-Adapted Vision Foundation Models for Brain MRI — 4 つの vision FM (DINOv3、SigLIP2 ほか) を LoRA で適合すると、同じ性能でも内部の変化が違い、cross-task transfer が逆向きになる。脳 MRI 特化だが backbone 選択の観点は P2 に使える (評価 3.0)
- 2610.25048: PACT: NVFP4 Data-Flow LoRA Fine-Tuning on Consumer GPUs — consumer GPU 上の NVFP4 での LoRA。実装寄り (評価 3.0)
- 2610.28431: Plausible Future, Wrong Choice: Steering World-Action Models toward Intended Future — WAM が作業段階を取り違える Stage Confusion を TaskWAM で steering (評価 3.0)
- 2610.26979: Latent Projection for Latent Planning — latent world model の planning で、latent の noise 成分を SIGReg の構造から落として cost を測る (評価 3.0)
- 2610.28483: Exploring Temporal Context-Aware Physical Grounding in Latent World Models — G-JEPA (評価 2.5)
- 2610.25634: Clean Forcing: Drift-Resistant Autoregressive Video Diffusion with a Frozen Base — 自己回帰の映像生成の drift を 5.9M の LoRA corrector で抑える。10-21 の Fréchet Forcing と同系 (評価 3.0)
- 2610.27617: Provisioning Robust and Efficient LiDAR Perception for Autonomous Driving — 悪天候の点群 corruption に頑健で latency / memory 制約を満たす LiDAR detector。運転だが perception (評価 2.5)
- 2610.28120: PointForward V2: Point-Aligned Interaction for Feedforward Driving Reconstruction — 運転シーンの feedforward 再構成。再構成であり planner / E2E ではない (評価 2.5)
- 2610.25497 以外の self-distillation 系 (2610.27495 Self-Evolving Agents through Privileged Retrospective Distillation など) — agent 課題で P2 の主題から遠い (評価 2.5)
