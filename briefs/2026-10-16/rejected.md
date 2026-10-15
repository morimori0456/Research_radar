# rejected 2026-10-16

採用 5 件: 2610.19714 / 2610.19601 / 2610.19700 / 2610.20609 / 2610.19825。wildcard は採用なし。

## planner_ai
- 2610.20244: FPTAS for Polygonal Multi-Robot Motion Planning — 計算幾何の理論 (近似アルゴリズム) で、学習ベース planner の実装・評価に直接使えない
- 2610.19527: Dual-arm Cooperation for Tabletop Wiping with Temporal Object Removal — 双腕 manipulation で自動運転と距離がある

## fm_distill_finetune
- 2610.20174: RM-OPD: On-Policy Distillation for Generative Reward Models — OPD の統合 recipe は面白いが reward model 用で P2 への転用が間接的。PA1-OPD を優先 (次点)
- 2610.19911: CARD: Closing the Teacher-Student Loop for Adversarial Robustness Distillation — adversarial robustness 蒸留に限定。P2 の主目的と遠い
- 2610.19685: Beyond Distribution Matching: Selective Margin Preservation for Supervised Fine-Tuning — LLM SFT の logit margin 保存で、他ドメイン適合の観点が弱い (次点)
- 2610.19803: Improving Category-Aware Active Domain Adaptation via Uncertainty-Guided Region Coverage — active DA でアノテーション選択の話。分類中心で新規性は限定的
- 2610.19758: Qwen-MT-Lumen at WMT2026 — 翻訳 shared task の system 報告。OPD は使うが再現可能な recipe 提示が主ではない
- 2610.19578: Bridging the Topological Divide: Dual-Branch Graph Distillation ... — 推薦 (cold-start) 向け graph 蒸留でドメイン外
- 2610.20238: MAEM: Mitigating Recency Bias ... Mixture of Experts for Class-Incremental — continual learning 中心で P2 と直接関係が薄い
- 2610.20584: Player-1: Learning to Play from Synthetic Experience — 注目度 (149 upvotes) は高いが fine-tuning/蒸留の recipe として使える内容か不明、ゲーム領域
- 2610.20607: Hierarchical Residual Policy Learning for Real-World Mobile Manipulation — manipulation の policy 学習で P2 外
- 2610.20474: AdaRSI: On-Demand Recursive Self-Improvement for Embodied Agents — agent の自己改善で蒸留/適合 recipe ではない
- 2610.20462: Power Grid Steady State Analysis with a Tabular Foundation Model — 電力系統・tabular でドメイン外
- 2610.20337: Training Dynamics of Transformers on Unbounded Inputs — 学習ダイナミクスの理論で実務の recipe に直結しない
- 2610.20279: Neural POS Tagging for the Low-Resource Saraiki — 低資源言語の品詞タグ付けでドメイン外
- 2610.20277: TANGO: RNA Topology and Geometry Co-Design — 生物分野でドメイン外
- 2610.20083: VisualWorldBench — MLLM の benchmark。蒸留/適合の手法ではない
- 2610.20027: LintEval: Benchmarking LLMs on Linter-Guided File Refactoring — コード refactoring benchmark で P2 外
- 2610.19996: Gray-Box Hallucination Detection in LLMs with Token Identities — hallucination 検出で P2 外
- 2610.19968: Safe-FCL — federated continual learning の安全性で P2 外
- 2610.19928: MemDuet: Dual-Process Memory for Long-Context Reasoning — 長文脈 memory で P2 外
- 2610.19890: Frustratingly Easy Majority Voting Using Length Conditioning — 推論時 voting で学習 recipe ではない
- 2610.19830: DarKnight — CAPTCHA 突破 agent で目的外 (関係なし)
- 2610.19811: Calibration and Risk-Budgeted Decisions with System One Models — 意思決定の calibration で P2 外
- 2610.19796: Learning Perception to Action Rules through RL for Theory-of-Mind Reasoning — ToM 推論で P2 外
- 2610.19741: Does the Linguistic Register of Thinking Matter? Wenyan ... — 推論言語の研究で P2 外
- 2610.19696: Share the Symbol, Not the Vector: Training-Free Fact Communication — training-free 通信で fine-tuning ではない
- 2610.19686: Interlock: From Local Correctness to Task Completion in Long-Horizon Agents — agent 評価で P2 外
- 2610.19640: Synthetic reaction data ... biodegradation pathway — 化学ドメインで目的外
- 2610.19613: Are We Really Measuring Forgetting? Machine Unlearning for MLLMs — unlearning の評価で P2 外

## next_arch
- 2610.20504: Graph-Reweighted Behavior Cloning with Human Interventions — manipulation の BC 改善で構造面の着想が薄い
- 2610.20442: Towards Agentic Robots — survey。VLA/world model の整理はあるが具体的な手法・実験がなく、今日の優先度は低い (背景知識としては有用)
- 2610.20429: When Do Discrete Actions Make Good Continuous Controllers? — 行動離散化の分析で面白いが VLA 設計への直接度は中 (次点)
- 2610.20384: Look Before You Restore: Agentic Image Restoration — 画像復元でドメイン外
- 2610.20351: Human Demonstrations as Post-Training Data for Any Robot Body — 人間動画の利用だが manipulation の retargeting が中心
- 2610.20331: Are We Overthinking One-Step Generation? — 画像生成の話で P3 と間接的
- 2610.20240: PAWA: Panoramic Action-conditioned World Modeling for Multiple Agents — Minecraft の multi-agent world model dataset。運転への転用が遠い
- 2610.20223: ObjDream — object-centric VLA は面白いが manipulation 特化。評価 3.0 (次点)
- 2610.20220: Glance Forcing: Making Bidirectional Diffusion Autoregressive — 動画生成の効率化で P3 と間接的
- 2610.20160: OneLA: Learning Many Worlds from Latent Actions — latent action の共有空間は面白いが運転での検証が不明 (次点)
- 2610.20134: Tactile-Guided Robot Learning — 触覚で P3 外
- 2610.20064: FoveaVLA — wrist camera 代替で manipulation 特化
- 2610.20019: MorphAct — embodiment 適応で manipulation 中心
- 2610.19795: StateCraft: Augmenting Video World Models with Abstract-State Reasoning — 動画 world model だが運転への示唆が薄い (次点)
- 2610.19753: Coordi-pi — 双手 dexterous で P3 外
- 2610.19746: One-shot Human Video-Guided Adaptation for VLA — 少データ適合の観点は良いが manipulation 特化 (次点)
- 2610.19708: SceneAE — 3D シーン生成で P3 と間接的
- 2610.19683: Enhancing Latent World Models with Associative Memory — JEPA 系 world model だが PushT 等の toy 環境のみ
- 2610.19677: ACRO: Actor-Critic Rollout Orchestration — RL rollout の system 最適化で構造面の着想が薄い
- 2610.19656: Accelerating VLA Inference with Perturbation Informed Execution (PICES) — training-free の推論高速化。有用だが今日の枠では次点
- 2610.19651: SPECTRA-VLA — hyperspectral 入力で P3 外
- 2610.19642: Model What Matters: Decision-Guided Selective World Modeling for Language Agents — language agent 向けで運転と遠い
- 2610.19604: ForceBench — force 統合 benchmark で P3 外
- 2610.19600: Cracking Mobile Manipulation — 失敗診断と agent system で P3 外
- 2610.19579: Back on Track: Deployment-time Policy Improvement via World Model Planning — deployment 時の world model 介入は面白いが manipulation (LIBERO) のみ (次点)
- 2610.19517: VLRLA: Deployment-Time Adaptation of VLAs through In-Context RL — manipulation 限定、評価は simulation 中心

## sns_wildcard
- 2610.20571: Any Time, Any Space (ATAS) — 動画生成 agent の memory 設計で、分野外としての学びは小さい
- 2609.39601: GroundingPI — 10-14 に採用済みの再配信 (briefs/2026-10-14/2609.39601.md)
- 2610.18773: Jeva: System One Models from First Principles — 意思決定 architecture の主張が中心で、P1-P3 への接続が弱い
