# rejected 2026-10-24

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。評価は topics.yaml の relevance_criteria に沿った 0-5 点。すべて abstract に基づく。

## planner_ai (candidates 4 件、全て不採用。P1 の 2 本は RSS 回収分)

- 2610.31540: Dispersive Tree Agreements for Multi-Robot Coordination — multi-robot の経路調整。自動運転 planner の実装・評価に移せない (評価 1.0)
- 2610.31518: SCOPE: Scene-graph Construction Optimized by Plan Error-correction for Robot Long-term Planning Datasets — 室内ロボットの長期 task planning 用 dataset (評価 1.0)
- 2610.31020: Demonstration-Based Robotic Feeding Using Dynamic Movement Primitives — 食事支援ロボットの動作生成 (評価 0.5)
- 2610.30607: Continuous-Time Motion Planning and Steering with Global Convergence — 連続時間の制約付き motion planning で大域収束の保証。理論は強いが対象は multi-robot / manipulator で、学習型 planner の補正に使う話は運転評価と遠い (評価 2.0)

## fm_distill_finetune (candidates 30 件中 29 件不採用。採用は 2610.31563 AOPD。30/30 の上限に当たったため RSS を走査)

- 2610.31670: Sensorimotor Alignment: A Platonic Proxy for Embodied Policy Success — 表現が物理運動の構造にそろう度合い S² を、closed-loop 前の安価な offline 指標にする。VLA の backbone 選別に使える可能性があるが、検証は manipulation 中心 (評価 3.0)。P3 の次点
- 2610.31616: OP-Print: Tracing Membership Imprints in On-Policy Self-Distillation — on-policy self-distillation への membership inference 攻撃。蒸留の recipe ではなく privacy の話 (評価 2.0)
- 2610.31640: WorldForge V2: Eliciting Camera-Trajectory Alignment in Video Diffusion Models — training-free のカメラ制御 + Trajectory LoRA。運転の動画生成に近いが生成寄りで、蒸留・適合の recipe としては弱い (評価 2.5)
- 2610.31323: Bridging the Data Gap: Source-Informed Task-Space Transport for Few-Shot Diffusion — 少データの target へ再学習なしで拡散 model を移す (Meta-Diff)。適合の観点では関連するが、対象は Gaussian mixture と CIFAR-100 の分布で運転・FM への移植が遠い (評価 3.0)
- 2610.31415: SyRA-CS: Synthetic-to-Real Adaptation for Code-Switched ASR with Meta-Learning — 合成データで適応しやすい初期化を作り、実データ 1 時間で適合。synthetic→real の recipe としては参考になるが音声 (評価 3.0)
- 2610.31397: Parameter-Efficient Adaptation of Large Language Models to a Low-Resource Agglutinative Language — 低資源言語への PEFT 適合 + corpus。言語固有 (評価 2.0)
- 2610.31646: Low-Bit N-Gram Embeddings for Language Models — embedding table の低 bit 化。圧縮だが蒸留・適合ではない (評価 2.0)
- 2610.31235: Muting Tokens: Exploring Token Sparsification for Efficient Audio Transformers — audio transformer の token 間引き。圧縮の一種だが音声 (評価 2.0)
- 2610.31465: RheOPT: Few-Shot Non-Newtonian Flow Prediction via Newtonian Pretraining of RheOFormer — 物理 simulation の事前学習→少データ適合。ドメイン外 (評価 2.0)
- 2610.31471: Ask About the Right Moment: Training-Free Object Identity Reasoning for Video-Language Models — training-free の推論手法 (評価 1.5)
- 2610.31466: AnyGameRenderer: Entity-Consistent Generative Rendering Across Games and an Entity-Level Benchmark — ゲーム画面の生成 rendering (hf 10、評価 1.5)
- 2610.31635: HiP3R: Hierarchical Pose Graphs for Long-Horizon 3D Reconstruction — 3D 再構成 (評価 1.5)
- 2610.31659: SpectralCanary: Embarrassingly Simple Low-Frequency Traces for T2I Dataset-Use Auditing — 画像生成の学習データ監査 (評価 1.0)
- 2610.31657: Cost-Aware Abstention for LLM-Based IT Ticket Classification — LLM 分類の abstention (評価 1.0)
- 2610.31586: Would an LLM Match into a Residency? Uncertainty, Reasoning and Image Use of Open Language Models on the Spanish ... — 医療試験の LLM 評価 (評価 0.5)
- 2610.31539: PYTHIA, a transferable machine learning framework for simultaneous defect and adsorption site optimization — 材料科学 (評価 0.5)
- 2610.31529: An Empirical Study of Recent Large Language Models for Knowledge Graph to Text Generation on Standard Benchmarks — LLM の benchmark 比較 (評価 1.0)
- 2610.31510: Piano2Pop: Expanding Piano Demos into Pop Productions Without Aligned Supervision — 音楽生成 (評価 0.5)
- 2610.31420: Post-Hoc Feature Selection Layer for Neural Networks Interpretability — 解釈性 (評価 1.0)
- 2610.31356: CrisiLangs: A Multilingual Resource for Crisis Warning Generation — 多言語 corpus (評価 0.5)
- 2610.31304: Data-Driven Vision-Language Models for Remote Sensing: A Survey — 衛星画像の survey (評価 1.0)
- 2610.31288: DISC: Domain-Integrated Similarity Cost for Time-Series Dataset — 時系列の dataset 間距離 (評価 1.5)
- 2610.31256: IndoNutriQA: An Indonesian Clinical Nutrition Question Answering Benchmark — 栄養 QA の benchmark (評価 0.5)
- 2610.31205: A Visual Grounding Benchmark for Retinal OCT with Multimodal Large Language Models — 眼科 OCT の benchmark (評価 0.5)
- 2610.31062: SCOPE: Compiling Natural-Language Policies into Neurosymbolic Predicate Programs — 自然言語の規則を述語 program に変換 (hf 6、評価 1.0)
- 2610.30987: Interpretive Variation and Discourse Structure in Detecting Enthymemes in Controversial Political Discourse — 議論分析 (評価 0.5)
- 2610.30963: ReDence: A Hybrid Agentic and Decision-Model Framework for Rapid, Evidence-Grounded Detection of Modern Social ... — 社会問題の検出 agent (評価 0.5)
- 2610.30913: Watch and Learn: Teaching Visual In-Context Learning by Removing Textual Shortcuts — visual ICL の学習。fine-tuning の一種だが shortcut 除去が主題で適合 recipe ではない (評価 2.0)
- 2610.30888: Building Presentation Intelligence for High-Quality Slide Generation — スライド生成 (評価 0.5)

## next_arch (candidates 20 件中 18 件不採用。採用は 2610.30319 TerraTransfer++ と 2610.30814 DRILL)

- 2610.30735: When One Step Is Enough: An Empirical Study of Euler Integration in Flow-Matching Policies — 6 つの flow matching VLA で 1 step 生成が multi-step と同等、という実測。再学習・蒸留なしで低遅延にできる実務的な知見 (評価 3.5)。P3 の次点。今日の枠は DRILL と TerraTransfer++ を優先
- 2610.31613: Progress Probes P²: Lightweight Runtime Monitoring for Vision-Language-Action Models — VLA の内部 activation への linear probe で失敗を検知 (π0.5)。評価・監視に使える着想だが manipulation (評価 3.0)
- 2610.31569: Echo: Coupled Action and Task Status Signal Denoising for Vision Language Action Models — 停止/失敗の信号を action chunk に足して一緒に denoise。構造としては面白いが manipulation (評価 3.0)
- 2610.31194: Inside-JEPA: From Prediction to Relational Grounding in Latent World Models — JEPA (latent 空間で予測する世界 model) の latent に関係 channel を入れる。Something-Something V2 が主で運転から遠い (評価 3.0)
- 2610.30724: Learning from Next-Frame Prediction: Towards Unified and Scalable Visual Representation Learning — 次フレームを embedding 空間で予測する事前学習 VANE。world model 的な表現学習だが、運転に結びつく結果は読み取れない (評価 3.0)
- 2610.31474: Skeleton-Grounded Latent Action Model for Robot World Models — robot の skeleton で latent action を分解。ロボットアーム中心 (評価 2.5)
- 2610.30781: DeXplicit: Making Physical State Explicit in Dexterous Manipulation World Models — 器用な手の world model (評価 2.0)
- 2610.30988: In-Context Learning World Models for Robot Dual-Arm Manipulation of Soft Garment with Partial Observations — 布の操作 (評価 2.0)
- 2610.31617: DiffDreamer: Coupling World Models with Differentiable Simulation for Agile Quadrotor Control — quadrotor の制御 (評価 2.0)
- 2610.30732: SmolVLA-MoE: Sparse Mixture-of-Experts for Efficient Multi-Task Robotic Manipulation — 軽量 VLA に MoE を足す。構造は参考になるが manipulation の multi-task (評価 2.5)
- 2610.31423: FocusVLA: Future-Intent Guided Dynamic View Routing for Vision-Language-Action Models — 多視点の dynamic routing。手首カメラへの偏りが主題で manipulation (評価 2.5)
- 2610.31668: Reading, Writing, Sharing, and Interacting with the World through Video — video world model の survey (hf 5)。全体像の把握には使えるが新手法ではない (評価 2.5)
- 2610.31135: Mixing Matters: Evidence Position Bias Across Sequence Mixers in Long-Context Question Answering — sequence mixer (attention / SSM) の位置 bias 比較。architecture の知見だが LLM の QA (評価 2.5)
- 2610.31166: Memory before Goal: Role of Pre-History Memory for Humanoid Loco-Manipulation — humanoid の履歴記憶 (評価 2.0)
- 2610.31162: HiSTEVE 1.0: Harnessing Human-Interface VLA Agents for Open-World Games — ゲーム内の VLA agent (評価 1.5)
- 2610.30671: Co^2Gen: Collaboratively Generating Task Plans for Decentralized Multi-Robot and Human Collaboration — task plan 生成 (評価 1.0)
- 2610.30628: Future of Time Series Anomaly Detection: From Historical Review to Unified Outlook — 時系列異常検知の review (評価 1.0)
- 2610.30438: Tactile-Based Robotic Manipulation: From Mechanics-Driven to Data-Driven Perspectives — 触覚 manipulation の review (評価 0.5)

## sns_wildcard (3 件、全て不採用)

- 2610.27999: Matrix-Game 4.0: Harnessing Video Models for Real-Time Playable Game Worlds — game engine と動画生成 model を分けた playable world (hf 194)。world model の設計としては面白いが、game engine が状態を持つ構成は運転の world model に直接移せない (評価 2.5)。今日は P3 の枠が埋まり、wildcard も採用なし
- 2610.28402: StreamEval: Evaluating Interactive Streaming Video Generation Models — 10-23 に見送り済みの再来 (hf 424)。avatar / 編集中心 (評価 2.5)
- 2610.31329: WeVisOne-VL: Unified Visual Perception from Objects to Pixels — VLM の細粒度知覚 (hf 220)。検出・segmentation を VLM に統合する技術報告で、運転の planner / world model との接点は薄い (評価 2.0)

## RSS 回収分で採用しなかった次点 (candidates.json に無く、RSS 5 本から keyword 一致で拾った 138 件中)

- 2610.30231: Edit, Don't Imitate: Minimal-Edit On-Policy Distillation for Multimodal Reasoning — 特権情報 (図の説明 + 正解) を持つ teacher が、間違った student rollout のうち teacher が不利と見る token だけを罰する on-policy distillation。MCPD・AOPD と同じ系統で今日は 2 本採用済みのため次点 (評価 4.0)
- 2610.30691: LoRA Superposition across Pretrained Models — 別々の backbone で学習した LoRA を足し合わせて全 backbone に適用できる (CLIP 7 種 × 8 task)。適合の知見として面白いが画像分類 (評価 3.5)
- 2610.30844: Reverse-KL Policy Distillation: Statistical Guarantees and Limits — reverse KL 蒸留の sample complexity。online は teacher の全分布が要る等の理論で、recipe には直結しない (評価 3.0)
- 2610.30320: Self-Distilling Future Video Representations for World Action Models — 1 step の denoise で未来の video 表現を自己蒸留 (FRED)。P3 寄りだが manipulation と人間動画→ロボット (評価 3.0)
- 2610.30340: Foundation4D: Towards a unified perception and reconstruction model for autonomous vehicles — multi-camera 運転動画から幾何・検出・occupancy・Gaussian 再構成を 1 model で。perception 寄りで planner / world model の評価基準からは外れる (評価 3.0)
- 2610.30685: Learning Domain Trajectories with Flow Matching for Gradual Domain Adaptation — 段階的に変わる中間 domain を flow matching で連続的に輸送。domain adaptation だが画像 classification の設定 (評価 3.0)
- 2610.31066: Dual Exam: Controlled Evaluation of Multimodal Agents and World Models — agent と world model を別々に評価する benchmark。運転ではない (評価 2.5)
- 2610.30528: Decision Making and Ride Comfort Evaluation Based on Lane-Change Prediction for Autonomous Vehicles — 車線変更の予測を判断に使い乗り心地を評価。CARLA の少数の記録での評価で、一般性は不明 (評価 2.5)
- 2610.30979: LAST-V2X: Language-Driven Adaptive Scenario Synthesis and Testing for Communication-Induced Failures in V2X Safety Applications — LLM で自然言語から V2X の故障 scenario を生成して試験。通信の故障が対象 (評価 2.5)
