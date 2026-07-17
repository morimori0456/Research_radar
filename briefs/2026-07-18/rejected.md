# Rejected — 2026-07-18

選別基準: 各トピックの relevance_criteria に対する適合度で 0-5 点評価し、quota (P1/P2/P3 各2) と max_deep_per_day=6 の上限内で高得点のみ採用。hf_upvotes は同点タイブレークの副次シグナルとしてのみ使用。本日の選別枠割当は P1×1・P2×2・P3×2・wildcard×1 = 6 (P1 は AD プランナーに直結する候補が DRIFT のみ強く、余剰枠を注目度・学びの価値が突出した wildcard に振った)。

## planner_ai (P1)

- 2607.15129: Catch, Throw, Repeat: Human-Robot Partner Juggling — 人-ロボット協調ジャグリングの実時間制御。自動運転プランナー/評価に転用しにくく relevance 低 (~1)
- 2607.14997: AeroAct: World-Action Models for Quadrotor Flight — 航空 VLA/world-action model として面白いが、対象は quadrotor でAD プランナー知見への距離が遠い (~2.5)
- 2607.14725: BridgeFlow: SE(2)-Equivariant Motion Planning with Flow Matching — canonicalization で安価に等変性を得る発想は良いが、汎用ロボット motion planning でAD 固有性が薄い。DRIFT に僅差で次点 (~3.5)
- 2607.14455: Model-Based Diffusion Motion Planning via Constraint Optimization — 単一ロボットの非凸制約下 trajectory optimization。汎用的でAD 評価指標への直結性が弱い (~2.5)
- 2607.14245: Information-Theoretic Adaptive Cooling for Deterministic MPPI — MPPI の冷却スケジュールを entropy feedback で自動化。制御寄りで niche、プランナー評価への波及が限定的 (~2.5)

## fm_distill_finetune (P2)

- 2607.14895: Instruction Tuning and Merging for Reasoning Model Adaptation — fine-tuning/model merging の適合レシピとして次点級 (~3.5)。SEED / Answer-Conditioned に僅差で落選
- 2607.14506: Non-vacuous Generalization Bounds for RLVR — PEFT + on-policy distillation + TinyLoRA を含み関連するが、理論 (PAC-Bayes bound) 寄りで実務レシピ性が薄い (~3.5)
- 2607.14703: Multi-Teacher Distillation for Pathology MIL Pretraining — multi-teacher 蒸留は関心事だが病理 WSI ドメインに特化 (~3)
- 2607.14367: Dysco: Mitigating LoRA Interference in Federated Learning — LoRA subspace 割当は PEFT 的に興味深いが federated 設定が主眼で汎用蒸留から外れる (~3)
- 2607.15047: PEFT Prompt Tuning of DINOv2 for MCI Screening — frozen DINOv2 + prompt token の PEFT レシピだが医療スクリーニング特化 (~3)
- 2607.14682: Stop Thinking, Start Looking (Perception-RFT, GRPO) — reasoning-free な GRPO 後訓練。文書 QA 特化で蒸留一般への波及が限定 (~3)
- 2607.14522: Continuous-Time RL Framework for Fine-Tuning Discrete Diffusion — 連続時間 PPO/GRPO の理論。応用が discrete diffusion 微調整に限られ実務距離が遠い (~2.5)
- 2607.14486: Full-data accuracy with fewer labels for MLFF fine-tuning — active learning で少ラベル適合。分子力場ドメインに特化 (~2.5)
- 2607.14371: SFT vs ICL Equilibrium Analysis under Congestion — 経済学的均衡分析で示唆はあるが実装レシピでない (~2)
- 2607.14595: MagicPrompt: Ultra-Lightweight Prompt Tuning for Video Generation — 動画拡散の PEFT だが生成タスク特化 (~2.5)
- 2607.15231: CRISP: Robust Medical Image Segmentation under Domain Shift — source-only domain adaptation だが医療セグメンテーション特化 (~2.5)
- 2607.15209: Expanding Lexicon of Ge'ez Languages (VEXMLM) — 語彙拡張による低資源言語適合。tokenizer 特化で汎用性低 (~2)
- 2607.14735: CoTu at EXACT 2026 Neuro-Symbolic QA — 小型モデルの Program-of-Thought。コンペシステム報告で新規性限定 (~2)
- 2607.14605: First-language bias in LLM Essay Scoring (LoRA Gemma) — LoRA 適合の評価研究だが AES ドメイン監査寄り (~2)
- 2607.14524: WrAFT Automated Writing Evaluation — SFT 比較を含むが作文採点システム報告 (~2)
- 2607.14349: HABIB_TAZ SemEval-2026 formal logic — 合成データ+多目的最適化の競技システム (~2)
- 2607.14536: Muse: Representation Geometry of Muon Optimizer — optimizer 幾何の理論。蒸留/適合の主題外 (~2)
- 2607.15095: Digital Pantheon: LLM Agent Coalition Formation (SFT+DPO+RAG) — 手法は適合寄りだが政治科学シミュレーション用途 (~2)
- 2607.14548: HyMobileAgent GUI Agent — data-environment co-scaling は面白いがモバイル GUI エージェント特化 (~2.5)
- 2607.14727: WorkDrive: Roadwork Chain of Causation for AD — AD 関連だが VLM の causal reasoning 注入で本トピック (蒸留/適合) の核から外れる (~2.5)
- 2607.14711: VideoSEMA: Mamba-like Attention for Video — 効率的 attention だが動画分類特化で蒸留/適合でない (~2)
- 2607.14639: Image-to-Point Cloud Registration via Rectified Flow — self-supervised 事前学習+微調整だがマルチモーダル位置合わせ特化 (~2.5)
- 2607.14561: MARS: KGQA with SPARQL Generation — fine-tuning 不要を売りにする KGQA。本トピックの適合レシピと逆方向 (~1.5)
- 2607.14398: Rollout-Based Training for Constrained Diffusion — 制約付き生成の微調整枠組みだが蒸留/ドメイン適合の主題外 (~2)
- 2607.14807: TAMF-VTON Virtual Try-On — 仮想試着の拡散生成。トピック外 (~1)
- 2607.14580: Negative Prompt Optimization for Image Generation — Stable Diffusion 生成品質改善。トピック外 (~1)
- 2607.14509: Multi-Scale ViT for PlantCLEF 2026 — DINOv2 微調整のコンペ解法だが植物同定特化 (~2)
- 2607.14749: WanSong v1.0 (音楽生成) — up=8。長尺楽曲生成の基盤モデル報告。蒸留/適合トピック外 (~1.5)

## next_arch (P3)

- 2607.15038: Video = World + Event Stream (Wan-Streamer) — up=13。world+event stream の再定義は魅力的だが、制御可能な world model というより生成的 streaming 動画モデル寄りで planning への直結性が弱い。RoboTTT/DriftWorld に次点 (~4)
- 2607.14695: Reflex: Real-Time VLA Control through Streaming Inference — flow-matching VLA の KV-cache 化で O(1) 推論。実用性高く次点級だが「推論効率のみ」で構造/scaling の新規性は限定 (~4)
- 2607.14739: FoMoVLA: Visual Foresight + Motion Guidance for VLA — future feature 予測と point tracking の相補性。VLA+world model 的で良いが操作タスク寄り (~3.5)
- 2607.15278: Hierarchical Denoising for Multi-Step Visual Reasoning — up=1。tree 構造 latent で coarse-to-fine 推論。動画推論寄りで AD/VLA への距離 (~3)
- 2607.15142: Concept-Guided Spatial Regularization for World Models (Atari Pong) — world model を単体診断する視点は良いが Atari 限定で射程が狭い (~3)
- 2607.15004: CosFly-VLA for UAV Tracking — occlusion 下の VLA 追跡。UAV ドメイン特化 (~3)
- 2607.14852: LifelongVLA for Robotic Manipulation — plasticity-stability を扱う lifelong VLA。操作特化だが着想はあり (~3)
- 2607.14635: Action QFormer: Representation Shaping in VLA — action supervision の表現整形。構造洞察はあるが増分的 (~3)
- 2607.14280: DiMaS: Distribution Matching Steering for VLA — VLA の表現 steering。解釈可能性寄りで構造/scaling でない (~3)
- 2607.14609: Representation-Aligned Tactile Grounding for VLA — 触覚予測をどの表現に当てるか。contact-rich 操作特化 (~2.5)
- 2607.14236: Never Too Late for Force (LIFT) — 力覚を後付け注入する VLA 後訓練。操作の contact 特化 (~2.5)
- 2607.14698: Lights, Camera, Malfunction (FLARE) — VLA への物理スポットライト攻撃と data-aug の落とし穴。頑健性研究で構造/scaling でない (~2.5)
- 2607.14305: DCVC-MB: Neural B-Frame Video Compression with SSM — state space model 利用だが動画コーデック用途でアーキ着想の射程外 (~2)

## sns_wildcard (EXPLORE)

- 2607.13125: Boogu-Image-0.1 (Unified Multimodal Understanding/Generation) — up=122。注目度は高いが、本日 wildcard は agentic harness 保守に直結する Harness Handbook を優先。統合マルチモーダル生成は学びの新規性が相対的に低いと判断 (探索枠 1 件上限のため見送り)
- 2607.14935: VideoChat3 (Fully Open Video MLLM) — up=106。fully-open な動画 MLLM で有用だが、同上の理由で wildcard 枠は 1 件に限定し見送り
