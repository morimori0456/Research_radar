# rejected 2026-10-21

candidates.json は 61 件 (planner_ai 2 / fm_distill_finetune 30 / next_arch 26 / wildcard 3)。採用は candidates から 3 件、RSS 回収分から 2 件。wildcard は 3 件とも不採用 (1 件は 10-20 に採用済みの重複、1 件は 10-20 に見送り済み)。評価点は 0〜5 の概算で、abstract のみに基づく。

## candidates.json の不採用 (58 件)

- 2610.26633: CAOS-SLAM: Class-Agnostic Object-Aware Real-Time vSLAM for Dynamic Environments — SLAM の動的物体対応。planner の実装・評価ではなく localization 側で、転用先が薄い (評価 2.0)
- 2610.25600: Vector-Quantized World Model: Latent Feedback Motion Planning for Robot Manipulation — discrete latent world model + 連続 controller の manipulation 研究。長期 planning の発想は P1/P3 に近いが、評価は Tower of Hanoi と manipulation で運転に移しにくい (評価 2.5)。P1 枠は Cartender (RSS 回収) を優先
- 2610.26847: WeAct: Dynamic Weight Switching as Agent Actions — long-horizon agent の catastrophic forgetting 対策 (weight switching)。agent 軌跡が対象で適合の recipe として弱い (評価 2.5)
- 2610.26802: Scaling Parameter-Efficient Fine-Tuning for Brain Encoding — PEFT を脳活動 encoding に適用。少データ適合の話だが対象が neural data で、recipe の転用先が薄い (評価 3.0)。hf 211 は注目度だけ
- 2610.26790: Training with ML-labeled Data via Stochastic First- and Zeroth-Order Optimization — ML 生成ラベルでの学習の最適化理論。蒸留との接点が薄い (評価 2.0)
- 2610.26781: Game of Phones: Harnessing Game Theory and LLMs in 'Bot Wars' to Counteract Phone Scams — phone scam 対策の game theory + LLM。分野外 (評価 0.5)
- 2610.26776: Monsoon: Scalable Spontaneous Speech Collection for Low-Resource ASR in 50 Languages — 低資源 ASR の音声データ収集。分野外 (評価 1.0)
- 2610.26754: TokenGate: Adapting LLMs for Fast and Memory-Efficient Prefill with Learned Token Pruning — LLM の prefill 用 learned token pruning。推論効率だが長文 LLM 向けで、運転側に移す具体案がない (評価 2.5)
- 2610.26729: PlanarCityLoc: Breaking Silhouette Ambiguity in LoD Aerial Localization via 3D Planes — LoD 都市 model での aerial localization。分野外 (評価 1.0)
- 2610.26655: The Development of Sycophancy in Language Models: Tracing Vulnerabilities from Pretraining to Post-Training — sycophancy の発生過程の分析。分野外 (評価 1.0)
- 2610.26651: The Effectiveness and Durability of Pretraining Data Filtering in Protein Language Models — protein LM の pretraining data filtering。分野外 (評価 0.5)
- 2610.26491: PDNet: Exploring Pruning and Distillation for Real-Time Worker Activity Recognition in Industrial Assembly — pruning + knowledge distillation (3D-CNN、工場の作業認識)。P2 の対象だが手法が標準的で capacity gap への新規性が薄い (評価 3.0)
- 2610.26474: AfriGuard: Safety and Robust Refusal For African Languages — アフリカ言語の safety 評価。分野外 (評価 0.5)
- 2610.26444: WenSight-Decision-1 for Direct Decisions under E-commerce Rules — e-commerce rule 判定の fine-tuning 事例。ドメイン固有 (評価 1.5)
- 2610.26443: Rethinking LLM Fine-Tuning via Weight Space Reparameterization: Preserving Safety during Downstream Adaptation — fine-tuning で safety が落ちる問題への weight space reparameterization。適合手法として面白いが safety 特化 (評価 3.0)。次点
- 2610.26431: Long-form Video-to-Text Summarization using Recursive Language Models — 長尺動画の要約 (Recursive LM)。分野外 (評価 1.0)
- 2610.26425: SNO-PI: Label-Scarce SNOMED CT Entity Linking with Pre-trained Encoders and Curated Terminology Knowledge — SNOMED CT entity linking。分野外 (評価 0.5)
- 2610.26406: Expert L2 English Speech Evaluation on a Gaming PC: Accuracy, Fluency, and Prosody with XLS-R, XEUS, and PhoneticXeus — L2 英語発音評価。分野外 (評価 0.5)
- 2610.26370: An Empirical Study of Parameter-Efficient Fine-Tuning for Mixture-of-Experts LLMs — MoE LLM への PEFT の系統的 study (expert のみ適合 / LoRA・DoRA が強い / load-balancing 係数は 0 が無難)。P2 の recipe として価値は高い (評価 3.5) が、LLM の MoE 前提で今日の P2 枠 (SPOD・Nash-MOPD) に届かず。次点
- 2610.26325: Typed Decision Models under Prevalence Shift: Decision Training, Calibration, and Implicit Priors — typed decision model の prevalence shift 下での calibration。分野外寄り (評価 1.0)
- 2610.26275: From Cause to Effect: Generating Intermediate Event Chains in Videos — 動画の causal chain 生成 task。評価 task の提案だが運転との接点が薄い (評価 2.0)
- 2610.26252: SEAM: Spectral Embedding Alignment and Merging for Low-Resource TTS — 低資源 TTS の語彙拡張。分野外 (評価 1.0)
- 2610.26203: Focused Omni-Modal GUI Agents — omni-modal GUI agent。分野外 (評価 1.0)
- 2610.26199: TaQFormer: A Treatment-as-Query Transformer with Data-Fusion for Multidimensional Treatment Modeling in Coupon Allocation — クーポン配分の Transformer。分野外 (評価 0.5)
- 2610.26173: Conditional information Retrieval for Longitudinal Survey Harmonisation — 調査項目の harmonisation retrieval。分野外 (評価 0.5)
- 2610.26114: From Retrieval to Recognition:Knowledge-Enhanced Post-training of Time Series Foundation Models for Classification — 時系列 foundation model の post-training。適合の話だが時系列分類で転用先が薄い (評価 2.5)
- 2610.26025: TamedFlow: Trajectory-Aware Distillation\\for Teacher-Assisted Diffusion Sampling — diffusion transformer の trajectory-aware distillation。蒸留だが画像・動画生成の高速化で、P2 の優先度より下 (評価 3.0)
- 2610.25985: NIOCIS: Typed-Decision Next-Hop Routing with Node-Conditioned Option Spaces for Tool-Use Agents — tool-use agent の routing。分野外寄り (評価 1.0)
- 2610.25942: Speech LLMs That Breathe: Modeling Non-Verbal Vocalizations in Dialogue — speech LLM の非言語音声。分野外 (評価 0.5)
- 2610.25934: MITRA-lexicon: Lexica of attested translations from Sanskrit into English, Tibetan and Chinese — サンスクリット lexicon。分野外 (評価 0.0)
- 2610.25881: Learn the Interface, Not the Implementation: Output Representation Dominates Training Regime in LLM-Based RTL Generation — RTL 生成で output representation が training regime より効く、という実証。fine-tuning の話だが hardware 設計に特化 (評価 2.0)
- 2610.26855: Ropedia W0: Scaling Loco-Manipulation World Models across Embodiments with Human Experience — locomotion + manipulation の world foundation model (人の egocentric 動画を活用)。P3 の world model 候補で評価 3.5。運転でなく humanoid 向けで、quota 2 に対し Frechet Forcing に劣後
- 2610.26828: Agent World Model in the Wild: Computer-Use Agent Environment Synthesis — computer-use agent 用の環境合成 (world model と呼ぶが GUI 環境)。運転と無関係 (評価 1.5)
- 2610.26811: State World Models: Execute the Rules, Generate the Pixels — 状態を明示的に持つ world model (rule を実行して pixel を生成)。persistent state の発想は面白いが、ゲーム・探索系で運転への転用が遠い (評価 3.0)
- 2610.26765: HandsOn: A Large-Scale Simulation Benchmark for Generalizable Dexterous Manipulation — dexterous manipulation の simulation benchmark。運転と無関係 (評価 1.5)
- 2610.26757: Simulation Priors for Rapid Adaptation in Model-Based RL for Autonomous Racing — autonomous racing の model-based RL と simulation prior による adaptation。sim-to-real の適合として近いが racing 特化 (評価 3.0)。次点
- 2610.26717: Robot Learning with Vision-Language-Action Models for Agricultural Manipulation — 農業 manipulation への VLA 適用。VLA を別ドメインへ適合する事例だが manipulation (評価 2.5)
- 2610.26714: HoloCosm: Beyond Single-Metric Benchmark Compression Across Multiple Metrics — multi metric の benchmark compression。評価コスト削減の手法で、運転 closed-loop 評価の効率化に使える可能性はあるが間接的 (評価 2.5)
- 2610.26711: PVBench: Quantifying Physical Plausibility in Video Generation with Object-Level Physical Measurements — 動画生成の physical plausibility の測定 benchmark。世界 model の評価に近いが生成動画向け (評価 2.5)
- 2610.26584: HAF-VLA: Hierarchical Action Flow Framework for Humanoid Vision-Language-Action Control — humanoid 用の hierarchical VLA。構造は参考になるが humanoid 特化 (評価 3.0)
- 2610.26564: PrismWAM: Decoupling State Representations in World Action Models — World Action Model の state を semantics と physics に分離 (depth 空間で rollout)。P3 に近く評価 3.5 だが manipulation 専用で、quota 2 に対し劣後。次点
- 2610.26487: SPAR: Structural Pruning and Action Recovery for Vision-Language-Action Models — VLA の pruning + RL による回復 (π0.5 を 3.37B → 1.12B、LIBERO 84.55% → 93.45%、1.98 倍高速化)。評価 4.5 で今日の落選の中では最上位。P2 の compression と P3 の VLA の両方に当たるが、両 quota が埋まった (P2: SPOD・Nash-MOPD、P3: LECDrive・Frechet Forcing)。明日以降に最優先で読む候補
- 2610.26455: ALIGN: Aligning Condition Estimation and Expression in Advantage-Conditioned Behavior Cloning — advantage-conditioned behavior cloning の条件付け改善。混合品質データの活用は有用だが manipulation (評価 3.0)
- 2610.26287: Robotic Photography System based on Vision-Language-Action Model — 撮影 robot の VLA。分野外寄り (評価 1.5)
- 2610.26179: Learning Goal-Conditioned Subgoals through Frozen Hierarchical World Models — frozen hierarchical world model で subgoal を学習。search を network に置き換える発想は P1/P3 に通じる (評価 3.0)。manipulation / 小規模 task で転用先が遠い
- 2610.25981: FR-VLA: Implicit Force Reasoning VLA for Contact-Rich Manipulation — 力覚を使う VLA。接触操作特化 (評価 2.0)
- 2610.25961: PaceVLA: Adaptive Temporal Action Quantization in Vision-Language-Action Models — VLA の temporal action quantization による高速化。manipulation の実行速度が対象 (評価 2.5)
- 2610.25927: CondenseVLA: Learnable History Condensation for Efficient Multi-Frame VLA — multi-frame VLA の history 圧縮。履歴を効率的に扱う点は運転にも通じる (評価 3.0)。manipulation の短期 cue が前提
- 2610.25904: Multi-scale Fusion of Fast Vision Mamba and Foundation Model Features for Patch-Level Gleason Grading in Computational Pathology — Gleason grading の Vision Mamba。分野外 (評価 1.0)
- 2610.25874: Vision-Language-Delta-Action: Learning Compact Deltas as Actionable Transition Interfaces for Robotic Manipulation — VLA が delta (状態変化) を出す構成。manipulation 向け (評価 2.5)
- 2610.25861: ActionRoPE: action as coordinates for spatially consistent control in planar-camera game world models — game world model の action conditioning (coordinate 化)。ゲーム向け (評価 2.0)
- 2610.25781: See the Future, Classify the Present: Stochastic Latent World Modeling for Hyperspectral Images — hyperspectral 分類。分野外 (評価 0.5)
- 2610.25621: Weighted State Souping for Efficient Long-Context Retrieval — state space model の state souping。長文 retrieval 向けで運転と無関係 (評価 1.5)
- 2610.25534: AQUAACT: A Joystick-Level Underwater Teleoperation Dataset and Closed-Loop Benchmark — 水中 teleoperation の dataset と closed-loop benchmark。運転と無関係 (評価 1.5)
- 2610.25459: BiDex-100: A Comprehensive Benchmark for Bimanual Dexterous Manipulation Across 100+ Simulation Tasks — bimanual dexterous manipulation の benchmark。運転と無関係 (評価 1.0)
- 2610.22471: Has GPT-6-Astra Achieved Embodied Intelligence? — **重複**: 2026-10-20 に採用・ブリーフ済み
- 2610.20424: BizBench: Unveiling Hidden Challenges in Deploying Long-Horizon Agents for Real-World Business — **重複**: 2026-10-20 の rejected.md で見送り済み (業務 agent の benchmark)
- 2610.20951: LEV: Thinking Fast and Deep with Looped Decision Models — looped decision model で層を繰り返し、質問ごとに深さを変える。adaptive compute の発想は面白い (評価 3.0)。ただし本流 quota が埋まっており、評価も同系列の JevBench のみで単一出典。wildcard 枠は見送り

## RSS 回収分の不採用 (fm_distill_finetune が 30 件の天井に当たったため確認)

arXiv RSS (cs.LG / cs.CL / cs.CV / cs.RO / cs.AI) のうち、candidates.json に無く、topics.yaml の keyword に当たった 631 件の題名を走査し、上位を abstract まで読んだ。残りは題名で分野外と判断した。採用は 2610.25034 (SPOD) と 2610.26390 (Cartender) の 2 件。以下は読んだ上での次点。

- 2610.25679: LOOP: Recovery-Aligned Iterative Layer Pruning via On-Policy Distillation — 評価 4.5。1 層ずつ削って短い on-policy distillation で回復する、を繰り返す layer pruning。P2 の compression と distillation を同時に扱う recipe で、SPAR (2610.26487) と合わせて明日以降の最優先候補。今日は P2 の quota が SPOD・Nash-MOPD で埋まった
- 2610.26525: A Fisher-Geometric View of Multi-Teacher On-Policy Distillation — 評価 4.0。multi-teacher OPD が二次近似で Fisher merging と同じ目的になると示し、merge を閉形式の第一段にする RGBM を提案。Nash-MOPD (2610.26124) と併読向き。quota 超過
- 2610.25651: OPDArena: Understanding Learning and Forgetting in On-Policy Distillation — 評価 3.5。SFT・RLVR・OPD の forgetting を比較する分析。teacher を RLVR 学習済みにすると retention が良い、という知見は実務的。recipe ではなく分析で、順位が下
- 2610.25013: Latent World Models Should Plan with Distances Along the Latent Manifold — 評価 4.0。latent world model の planning cost を L2 でなく latent manifold 上の最短路距離 (Neighborhood Graph Cost) に替える。retraining 不要で terminal cost だけ変える、という軽さが魅力。P3 の quota 超過。操作・小規模環境が対象
- 2610.26844: AnyGoal: On World Model Generalization Beyond Expert Rollouts — 評価 3.5。専門家 rollout の外での world model の compositional generalization を測る benchmark。world model を評価する観点として P1 にも関係。quota 超過
- 2610.24534: Structured Latent Dynamics for Long-Horizon Embodied World Models — 評価 3.0。latent を Hamiltonian dynamics で伝播させ、長期 rollout の安定性を狙う。Frechet Forcing と問題が同じなので、そちらを優先
- 2610.26528: A Semantic Knowledge Graph Construction Pipeline for Vehicle Intention Prediction in nuScenes — 評価 2.5。nuScenes の ego-centric intention を OWL の knowledge graph に変換する pipeline。dataset 整備で、planner の実装・評価には距離がある
- 2610.25973 / 2610.25880 / 2610.25359 / 2610.26397: self-distillation / on-policy distillation の LLM 推論向け改良 — 評価 3.0〜3.5。SPOD・Nash-MOPD と同じ系統で、重複する知見が多く、今日は見送り
