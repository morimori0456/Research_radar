# 2026-10-09 不採用

候補 64 件 (planner_ai 3 / fm_distill_finetune 32 / next_arch 26 / wildcard 3)。採用 6 件 (P1 2 / P2 2 / P3 2)。採点は abstract のみ。

注: 2610.09763 (ICDP, next_arch 由来) と 2610.09695 (ViRA, next_arch 由来) は内容が planner の学習・評価なので P1 枠で採用。2610.09940 (Juno, next_arch 由来) は蒸留 + LoRA 適合が核なので P2 枠。planner_ai 由来の 3 件はいずれも 3 点以下だった。

2610.10065v1: Distributed Motion Planning for Multi-Robot Systems under Topological Constraints — multi-robot の braid 制約 MPC で、自動運転の planner への転用が遠い
2610.09174v1: Context-aware Attention-based Gaussian Mixture Models for Vehicular Trajectory Prediction — trajectory prediction の GMM 手法だが raster ベースで新規性が小さい。予測モデルの精度比較のみで planner 評価に直結しない (3 点、枠外)
2610.09165v1: geodex: A Library for Motion Planning on Riemannian Manifolds — Riemannian manifold 上の motion planning ライブラリ。ロボット幾何向けで P1 の評価・実装知見は薄い
2610.10524v1: GRACE: Generation-aware latent compression for efficient video generation — 動画生成 DiT の latent 圧縮 + 軽量 fine-tuning。適合 recipe として面白い (3.5 点) が、動画生成で 3 プロジェクトと距離あり
2610.10520v1: Distilling Graph Geometry: Knowledge Gap from GNNs to MLPs — GNN→MLP 蒸留。蒸留 loss の発想は参考になるが graph 限定 (3 点)
2610.10508v1: Your Prompt Should Do More: Effects of Retrieval Instructions in Embedding Models — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10437v1: Q-Learning with Scalar Adjoint Matching — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10429v1: SGF+: Decoupling Gradient Flows for Autoregressive Video Generation — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10426v1: CoTrace: Data Recipes for Training Terminal Agents with Harness-Model Co-Evolution — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10422v1: Which Rollout Taught It That? BehaviorTrace and the Limits of Training-Data Attribution in Online RL — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10407v1: SOTA: Stock Options Trading Agents Guided by Option-Implied Return Distributions — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10388v1: RoboQuest: Generalist Physical Agents that Search, Inspect and Test — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10361v1: ORDERS: An Empirical Study of Norm-Rank Aggregation for Personalized Federated Learning — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10343v1: Real-Time Joint Audio-Video Generation by Parallel Adapter Composition — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10335v1: When to Unpair: Regulating Pairing Dependence in Medical Visual In-Context Learning — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10324v1: Performance at What Cost? A Sustainability-Aware Performance Index for Cell and Nucleus Instance Segmentation — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10322v1: From Digital Human Interactions to Physics-Based Humanoid Skills: Physics-Grounded Post-Training of Interaction Generators — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10318v1: Nobody Truly Agrees on Sentiment: Humans, Bespoke Tools, and LLMs Struggle with Social Media Texts — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10298v1: Physics-Aligned Electronic Ground-State Learning Improves Generalization — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10261v1: Using Small Language Models to Reverse-Engineer Machine Learning Pipelines Structures — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10163v1: Beyond Anonymous Captions: Grounding Character Identity in Video Captioning and Question Answering — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10160v1: BagDINO: Multi-View Baggage Re-Identification with DINOv3 — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10091v1: ExperienceIndex: Artifact-Grounded Memory — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09976v1: EASE: Entropy-Adaptive Distribution Shaping for Evading AI-generated Text Detectors — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09943v1: Many Ways to Succeed: Diversity-Driven RL Fine-Tuning for VLA Generalization — VLA の RL fine-tuning。操作ロボット対象で、運転 P3 への示唆は間接的 (3.5 点、枠外)
2610.09941v1: Purifying Backdoored Large Vision-Language Models by Removing Hijacked Directions — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09821v1: Efficient 3D Gaussian Head Avatars for Edge Devices — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09819v1: Backdooring Acoustic Foundation Models for Physically Realizable Triggers — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09795v1: MIRROR: From Imitation to Internalization in LLM Personalization — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09788v1: Judging in Latent Space: Efficient Generative Reward Modeling via Semantics-Preserving Compression — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09756v1: Shaer: Controlled Arabic Poetry Generation with Meter Subform and Semantic Conditioning — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.09742v1: SoccerNet-FoulRet: Retrieving Semantically Similar Soccer Foul Videos — 蒸留・fine-tuning による別ドメイン適合の recipe ではない (応用タスク個別の話題)
2610.10526v1: Rephrase Before You Act: Characterizing and Mitigating Language Sensitivity in Vision-Language-Action Models — VLA の言語感度。操作ロボット対象 (3 点)
2610.10384v1: OpenViTac: Learning and Benchmarking Visuo-Tactile Policies in a Unified Sim-and-Real Framework — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.10274v1: Sparse Planning in Visual World Models via Cost Gradients — world model の token 選別 planning 高速化。操作 benchmark 中心 (3.5 点、枠外)
2610.10178v1: Do Vision-Language-Action Models Understand Instructions? A Mechanistic Interpretability Study on Language Grounding — VLA の言語 grounding の interpretability 研究。直接の設計知見は小さい (3 点)
2610.09785v1: UltraWorld: Learning Interactive Ultrasound World Models from Untracked Clinical Videos with Acoustic Sampling Map — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09734v1: ΔWAM: Distilling Action Tangent Fields into World Action Models — World Action Model への蒸留で P2/P3 に近い (4 点弱) が、操作ロボット対象で今日の枠は Juno を優先
2610.09718v1: YUBI-STAG: Contact and Semantic-Rich Alignment for VLAs via Automated Video-Language Grounding — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09710v1: SpikingVLA: Asynchronous Spiking Vision-Language-Action Models — Spiking VLA。エッジ向けだが運転との接点が薄い (3 点)
2610.09696v1: RoboPace: Contact-Aware Time-Optimal Retiming for Action-Chunk Policies — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09514v1: STRIKE: Learning Visual State Transitions for Physical World Modeling — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09496v1: Sparse Feature Policy Unlearning Mitigates State Hallucination in Vision-Language-Action Models — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09462v1: TMT: Runtime Backdoor Detection for Vision-Language-Action Policies on Unseen Tasks — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09457v1: DSReg: Provably Recovering Individual World Latents without Reconstruction — world latent の識別可能性の理論。実務適用が遠い (2.5 点)
2610.09451v1: TempoBridge: Language-Guided Tempo Control for Vision-Language-Action Policies — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09438v1: Controllable Crowd Generation through World-Model Planning — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09335v1: SearchWorld: Spatial Value-Grounded Imagination for UAV Object Search via World Models — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09309v1: Predicted Futures Are Not Enough: Learning Executable Goals for Robot Manipulation — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09305v1: Kuration SDK: Addressing the Virtual2Real Gap via Data Curation — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09285v1: LeCuration: A Tiny World Model as a Data Curation Multi-Tool — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09228v1: Co-Evolving Robot Orchestrators and Policies through Deployment — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09194v1: Patient, Place, Prior (P$^3$): What Counts as Personalization in Medical World Models? — VLA / world model / E2E 運転のアーキテクチャ設計への示唆が小さい (ロボット操作・医療などの個別応用)
2610.09170v1: Beyond Reconstruction: What Matters in Action Tokenization for Robot Policies? — action tokenization の比較。操作ロボット対象 (3 点)
2610.09134v1: World Models Dream of Success: Diagnosing and Repairing Failure Insensitivity in Robot World Models — robot world model の failure 鈍感性。評価の観点は良い (3.5 点) が操作対象で枠外
2610.08448: Rethinking Cross-Tokenizer On-Policy Distillation: From Alignment Coverage to Supervision Reliability — 2610.08448 は 10-08 に採用済み (HF 経由の再来)。重複のため除外
2610.05608: Kandinsky 6.0 Video: Foundation Models for Synchronized Video and Audio Generation — Kandinsky 6.0 Video (wildcard): 動画・音声生成の foundation model 報告で、学びの価値はあるが 3 プロジェクトから遠い
2610.06647: LoGRA: Scaling LLM Reinforcement Learning with Low-Rank Gradient Sketches — LoGRA (wildcard): RL post-training のメモリ削減。3 プロジェクトとの接点が間接的で今日は枠が埋まったため見送り (3 点)
