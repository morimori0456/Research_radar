# 2026-10-08 不採用

候補 61 件 (planner_ai 2 / fm_distill_finetune 29 / next_arch 27 / wildcard 3)。採用 6 件 (P1 2 / P2 2 / P3 2)。採点は abstract のみ。

注: 2610.08123 (E2E planner) は topic が fm_distill_finetune だが内容は P1 なので P1 枠。2610.08627 は planner_ai 由来だが world model が核なので P3 枠で採用した。

2610.08789v1: QF3: Fast Flow RL with Filtered Q-Gradients — flow policy の RL 手法で、蒸留・適合の recipe ではない
2610.08773v1: AdvSim2Real : Training Web Agents Against Adaptive Prompt Injection in a Web World Model — web agent の prompt injection 対策で 3 プロジェクトと距離が遠い
2610.08680v1: A Systematic Study of Small Language Models on Abstract Reasoning Tasks — 小型 LM の抽象推論の調査。蒸留 recipe を含まない
2610.08620v1: LiDAR Resolution Recovery via Foundation-Model-Guided Diffusion — LiDAR beam 補完の fine-tuning 例だが、適合 recipe として一般化しにくい (次点)
2610.08604v1: InterCorrect: Intersection-Aware Correction of Demographic Model Merging for Fair ASR — ASR の model merging。ドメインが遠い
2610.08552v1: AnyBottle: A Recipe to Only Keep the Concepts You Really Need — concept 削除の recipe。P2 の蒸留・適合と目的が違う
2610.08413v1: Knowing When Not to Answer: Cross-Domain and Multi-Turn Generalization of Latent Underspecification Signals — LLM の underspecification 検知。対象外
2610.08400v1: Atom-JEPA: Joint-Embedding Predictive Architecture for 3D Atomistic Systems — 原子系の JEPA。ドメイン外
2610.08315v1: Catastrophic Forgetting in Sequential Thermal Anti-UAV Detection: The Role of Scale-Conditioned Gradient Imbalance — 熱画像 anti-UAV の forgetting。一般化できる知見が弱い
2610.08162v1: The Failure Is in the Readout: Fine-Grained Emotion Recognition Benchmarks Measure Elicitation, Not Perception — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08161v1: Symphony for Text Generation: Benchmarking Clinical Note Generation — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08133v1: VLA-ACL: Action-Consistent Visual Token Pruning for Efficient Vision-Language-Action Models — VLA の token pruning。効率化に有用だが manipulation 中心 (次点)
2610.08118v1: Attenuated in-context identification in time-series foundation models: diagnosis under counterfactual inputs and repair by synthetic forced-system fine-tuning — time-series foundation model の診断。対象外
2610.08112v1: Energy-Aware Path Following: Comparative Analysis of Reinforcement Learning and NMPC for Electric Vehicles — EV の経路追従 RL vs NMPC。P1 の評価として新規性が薄い
2610.08108v1: Enhancing Diffusion Language Models with Autoregressive Post-Training Weights — diffusion LM の post-training。P2 の中心から外れる
2610.08093v1: SAGE: Semantic Anchor-Guided Evolution for Grounded Medical QA Data Synthesis — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08082v1: POLAR: Ontology-Guided Risk Prevention for Tool-Calling LLM Agents — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08063v1: HINTT Submission to the 2nd MLC-SLM Challenge: Comparing Cascaded and Unified Approaches to Diarization and ASR — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08049v1: A Riemannian Geometry for Low-rank Adaptation — LoRA の Riemannian preconditioning。関連するが理論寄りで、MemFLoRA と OPD を優先 (次点)
2610.07940v1: Hybrid Latent Attention for Looped Language Models — looped LM のアーキテクチャ。driving から遠い
2610.07913v1: Multimodal Knowledge Distillation for Gastric Adenocarcinoma Classification from Whole-Slide Images — 病理 WSI の multimodal distillation。ドメイン固有
2610.07885v1: Label-Efficient Deep Learning for ECG Delineation: A Multi-Dataset Benchmark against Widely Used Delineation Tools — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.07853v1: Lost in the bf16 Cast: Exporting Ternary Language Models Can Revert Most Low-Learning-Rate Code Changes — ternary LM の bf16 export 問題。P2 の対象外
2610.07848v1: Dynamic Positional Attention Modulation for Parameter-Efficient Fine-Tuning of Large Language Models — LLM 向け PEFT の attention 変調。MemFLoRA/OPD より優先度低
2610.07819v1: $α$Transfer: Coefficient Transfer for Efficient Model Merging — model merging の coefficient transfer。有用だが次点
2610.07802v1: Towards benchmarking Western Bluebird detection in the wild — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.07778v1: Towards One-for-All Foundation Model for Attributed Graph Clustering — 蒸留・適合の recipe として関連が薄い (ドメイン固有または対象外)
2610.08791v1: World Models' Last Exam in Physics — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08780v1: DepthWorld: 3D World Model for Robot Manipulation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08777v1: CtrlCache: Accelerating Interactive Video World Models with Control-Aware Caching — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08760v1: WorldSonus: Bringing Sound to Worlds — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08726v1: EgoLAP: Learning from Egocentric Human Data through Language-Action Reasoning — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08640v1: RIWANav: Recursive World-Action Models with Self-Improvement for Urban Navigation — 都市ナビの world model + GRPO (次点)
2610.08526v1: WareFly-VLA: A Vision-Language-Action Framework for UAV Navigation and Human Tracking in Smart Warehouses — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08469v1: A Belief-State World Model for Catheter Navigation under Sparse Fluoroscopy: A Planar Proof of Concept — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08464v1: Federated Bayesian Surveillance of Mechanical Thrombectomy Adverse Events: A Population Risk Layer for Surgical Digital Twins — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08444v1: ActTune: Action-Aware Precision and GPU Operating-Point Adaptation for Energy-Efficient Vision-Language-Action Inference — VLA の GPU 動作点調整。省電力の話で設計への示唆が薄い
2610.08425v1: MIM-VLA: Learning Physical Interaction Representations from Gripper Motor Feedback — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08350v1: How Much Planning Is Enough? Reducing Search and Computation in World-Model Planning — world-model planning の budget 削減 (次点。PPWM を優先)
2610.08220v1: VOMMI: Collecting and Leveraging Portable Demonstrations for Mobile Manipulation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.08150v1: ViDAL: A Visual Dynamics-Grounded Action Latent Space for Vision-Language-Action Models — VLA の action latent。有望だが manipulation 中心 (次点)
2610.07949v1: Commit While Futures Agree: Consequence-Aware Adaptive Action Chunking for Robot Manipulation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07946v1: Adapting Vision-Language-Action Models to Unknown Visual Disruptions During Execution — VLA の test-time adaptation。manipulation 中心 (次点)
2610.07756v1: StairVLA: Stage-Aware Hierarchical Action Generation for Vision-Language-Action Models — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07704v1: Independent Multi-Agent Reinforcement Learning with Counterfactual Semantic-Social World Models — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07696v1: ESP: Energy-Score Policy for One-Step Multimodal Action Generation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07652v1: SMART: Zero-Shot Sim-to-Real Articulated Object Manipulation via Large-Scale Synthetic Pretraining — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07599v1: Modeling Latent Disturbances for Robust Decision-Making in World Models — world model の latent 空間での robust 意思決定。有望だが manipulation (次点)
2610.07594v1: BiGym 2.0: Benchmarking Learned and Agent-Developed Policies for Humanoid Household Manipulation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07558v1: Seeing the Invisible: Physics-Guided Visual Prompting for Temperature- and Radiation-Aware VLA Navigation — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.07540v1: Preserving Unstable Modes Through Inverse Dynamics in JEPA World Models — JEPA world model の理論。制御タスクが小規模 (次点)
2610.07355v1: Tracking Is Not Permanence: What Video World Models Keep of a Hidden Object — manipulation/ナビ/特定ドメイン中心で、P3 への示唆が薄い
2610.01780: RealCompanion: Benchmarking Human Understanding from Reasoning over Longitudinal Real-World Conversations — wildcard: 対話 companion の benchmark。3 プロジェクトと無関係
2610.05608: Kandinsky 6.0 Video: Foundation Models for Synchronized Video and Audio Generation — wildcard: 動画+音声生成 foundation model。直接の学びが薄い
2609.38879: Does Learning Protein Folding Generalize to Broader Reasoning? — wildcard: protein folding で推論を改善。面白いが、ブリーフ上限 6 に達した
