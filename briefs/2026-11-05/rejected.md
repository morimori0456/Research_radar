# rejected 2026-11-05

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。candidates.json は 64 件 (generated_at 2026-11-04T18:00Z): planner_ai 6 / fm_distill_finetune 30 / next_arch 25 / sns_wildcard 3。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。

## 採用 (6 本)

2611.05072 (RFWorld, P3 4.5) / 2611.05249 (P1 4.5) / 2611.04368 (RAFT, P2 4.5) / 2611.05093 (LoopQ, P1 4.0) / 2611.05003 (AEGIS, P2 4.0) / 2611.04527 (DreamFree, P3 4.0)。

- 2611.05093 (LoopQ) と 2611.04368 (RAFT) は candidates.json では next_arch に分類されていたが、前者は評価設計として P1、後者は少データ適合の recipe として P2 に置いた。
- 2611.05249 は planner_ai の本流候補 6 件のうち運転を扱う唯一の論文。残り 5 件は manipulation・宇宙・レーダー・数理で、P1 の基準に当たらなかった。
- sns_wildcard 3 件は、最大 2.5 (2611.00859 Wave Forcing) で、総数の上限 6 にも入らず全て見送り。

## 不採用 (58 件)

評価の高い順。**次点** は評価 3.5 以上で、quota または上限で外れたもの (持ち越し候補)。

- 2611.04081: RAPID: Increasing Efficiency of Internal Distillation via Randomized Methods — 評価 4.0。**次点 (quota 超過)。** RAPID。内部表現の蒸留で、teacher と student の次元差を Johnson-Lindenstrauss lemma (高次元の点の距離を、ランダム射影でほぼ保ったまま次元を下げられるという定理) に基づく射影で解消し、学習を最大 21.1% 効率化する。蒸留 recipe として P2 に直接当たるが、実験は reasoning の post-training で、P2 の quota 2 (RAFT・AEGIS) を超えた。持ち越し候補
- 2611.04958: Shuffled OPSD: When Semantic Consistency Hurts On-Policy Self-Distillation? — 評価 3.5。**次点。** Shuffled OPSD。on-policy self-distillation で共有の問題文の語順を shuffle すると精度が上がる (Qwen3-1.7B で +3.52 pp)。蒸留 recipe として興味深いが、数学推論に限定され、運転・VLA への接点が薄い
- 2611.04931: Modulating Merging Strengths via Joint Loss Estimation for LoRA-based Continual Learning — 評価 3.5。**次点。** M2LE。LoRA を使う continual learning で、merge の強さを要素ごとの解析解で決める。PEFT 適合の話だが、continual learning が主題で P2 の「少データ適合」とは軸が違う
- 2611.05155: Asynchronous Robot Policies — 評価 3.5。**次点。** Asynchronous Robot Policies。VLM を低頻度、action expert を高頻度で非同期に回す。遅延と staleness (古い意味 memory) に対する学習が要点で、車載の計算予算に近い発想だが manipulation に限定
- 2611.04870: PrimeSim: A Generalist World Model Simulator from Large-Scale Cross-Embodiment Demonstrations — 評価 3.5。**次点。** PrimeSim。30,110 時間・22 platform の action-conditioned な multiview world model simulator。新 platform に 100〜200 gradient step で転移できる点は P2 にも関係するが、規模が大きく再現しにくい
- 2611.04166: Say the Same, Act Differently: Diagnosing and Steering Text-Action Divergence in Reasoning VLAs — 評価 3.5。**次点。** TNAS (Say the Same, Act Differently)。reasoning VLA で rationale (出力する説明文) が同一のまま視覚摂動により行動だけを変えられる。Alpamayo (運転) で 154 scene のうち 52.6% が衝突。監視は行動を直接見る必要があるという評価の観点が P1 に効くが、攻撃手法の論文で評価指標の提案ではない
- 2611.04028: Compression Forcing: Hierarchical History Tokenization Enables Flexible World Models — 評価 3.5。**次点。** Compression Forcing。history を dynamics の顕著さ順に tokenize する world model。予測目的に合わせた history 圧縮は P3 の着想になるが、abstract に数値が無く比較が難しい
- 2611.05286: Anchored Rank-Adversarial Fine-Tuning Pretrained Visual Place Recognition Models — 評価 3.0。ARAFT。visual place recognition の foundation model に対する anchor 付き adversarial fine-tuning。clean 精度を保つ anchor の考え方は参考になるが、攻撃耐性が主題で P2 の適合とは軸が違う
- 2611.05192: From Natural Images to Medical Scans: Transferability of Diffusion Models for Medical Image Generation — 評価 3.0。自然画像から医用画像生成への diffusion の転移性。transfer の知見だが、医用画像に閉じており recipe として抽出しにくい
- 2611.05062: FloMo: 3D Scene Flow as a World Action Model Intermediate for Learning from Human Video — 評価 3.0。FloMo。3D scene flow を world action model の中間表現にして人間の動画から学ぶ。DreamFree (採用) のほうが「動画の予測知識を行動に使う」点で近く、こちらは manipulation に特化
- 2611.05029: DRAP: Dynamics-Risk Adaptive Plasticity for Continual Learning in Physical AI — 評価 3.0。DRAP。physical AI の continual learning で dynamics と risk に応じて plasticity (新しく学ぶ余地) を調整する。忘却対策の発想は近いが、abstract の情報が少ない
- 2611.04632: Self-Privileged Fine-Tuning — 評価 3.0。Self-Privileged Fine-Tuning。ground truth を条件に与えた凍結 model を prior にして SFT の token 重みを決める。SFT の recipe だが数学推論が対象で、AEGIS (採用) のほうが適合時の劣化という P2 の問題に近い
- 2611.04491: SPA-Q: Structure-Preserving Adaptive Post-Training Quantization for Monocular Depth Estimation — 評価 3.0。SPA-Q。Depth Anything の 4 bit PTQ (AbsRel 25.9% 減)。基盤モデルの圧縮として実用的だが、PTQ の一手法で、LoopQ (採用) が示す「単純な baseline に勝てるか」を満たすかが abstract から不明
- 2611.04972: Caging Vision-Language Navigation for Legged Robots via Barrier-Certified Safety Architecture — 評価 3.0。barrier 認証付きの安全 architecture で legged robot の vision-language navigation を囲う。安全層の設計だが運転でなく、学習 architecture への知見は薄い
- 2611.04873: Trusting Imagined Futures: Auditing Imagined Rewards for VLA Post-Training — 評価 3.0。Trusting Imagined Futures。world model の想像した reward を、実行結果で監査してから VLA の post-training に使う。LIBERO で +3.00 pp。world model の過信対策は有益だが、manipulation で効果幅が小さい
- 2611.04522: Action Intent as a Bridge: Transferring Manipulation Knowledge from Human-Centric Videos to Robots — 評価 3.0。Action Intent。人間中心の動画から robot へ操作知識を移す。cross-embodiment の観点はあるが、DreamFree (採用) と近く新規性の差が abstract から見えない
- 2611.04492: Hybrid Particle-Voxel Dynamics for Multimodal 3D World Simulation — 評価 3.0。Hybrid Particle-Voxel Dynamics。マルチモーダルな 3D world simulation。物理的な表現だが、運転への接続が薄い
- 2611.04392: Aero-VPA: Few-Step Flow-Matching Control over Non-Reconstructive JEPA Latents for Agile Flight on Edge Hardware — 評価 3.0。Aero-VPA。JEPA の latent 上で few-step flow-matching 制御を行い、edge で動かす。軽量化は参考になるが、ドローン
- 2611.04096: Online Hamilton-Jacobi Reachability Onboard the Robot Control Loop: A Real-Time GPU Solver for Safety-Critical Autonomy — 評価 3.0。Online Hamilton-Jacobi Reachability の GPU solver。制御ループ内の安全性検証で、planner 評価への接続は間接的
- 2611.03815: AIRoA-0: Long-Horizon, Precise, Cross-Embodiment Manipulation from Handheld Data — 評価 3.0。AIRoA-0。handheld data による cross-embodiment 長期 manipulation。データ収集の工夫は参考になるが manipulation
- 2611.05358: Suppressing Misaligned Behaviors in Language Models, Durably — 評価 2.5。PEARL。言語 model の misalignment 行動を durable に抑える GRPO 変種。安全性の話で、ドメイン適合の recipe ではない
- 2611.05304: LoopVQ: Sub 1-bit KV Cache Quantization for Looped Transformers — 評価 2.5。LoopVQ。looped transformer の KV cache を 0.5 bit に量子化。LLM 推論の圧縮で、運転・VLA への接点が薄い
- 2611.05106: Label-Preserving Fourier Domain Adaptation with Generative-AI and Real Style Donors for 3D Mitral Valve Segmentation — 評価 2.5。3D 僧帽弁画像の Fourier domain adaptation。domain gap の克服だが医用 3D 向けの限定的な手法
- 2611.05080: CRONOS: Benchmarking Non-Episodic Reinforcement Learning for Robotic Manipulation — 評価 2.5。CRONOS。非 episodic RL の manipulation benchmark。評価設計の参考にはなるが運転と遠い
- 2611.04654: BhopalMLS: A LiDAR Dataset for Semantic Scene Understanding in Heterogeneous Urban Environments — 評価 2.5。BhopalMLS。LiDAR の semantic scene 理解 dataset (インドの都市)。domain gap の素材にはなるが、手法の知見ではない
- 2611.04611: CAPSkip: Cancellation-Aware Prefix Skipping for Selective Backpropagation — 評価 2.5。CAPSkip。selective backpropagation の高速化。fine-tuning の効率化だが、適合の recipe ではない
- 2611.04583: Multi-Path Mamba Diffusion for 3D Point Cloud Semantic Scene Completion — 評価 2.5。Multi-Path Mamba Diffusion。3D point cloud の semantic scene completion。state space model の応用だが点群の補完に限定
- 2611.04016: Physical Experience Builds Continual Spatial World Models — 評価 2.5。Physical Experience Builds Continual Spatial World Models。空間 world model の continual 化。抽象的で手法の核心が abstract から見えない
- 2611.04010: Decision Transformer with Task-Aware Representations for Offline Meta-Reinforcement Learning — 評価 2.5。Decision Transformer の task-aware 表現による offline meta-RL。architecture 寄りだが運転・VLA と遠い
- 2611.03937: FlowBench: Counterfactual Imagination Training for Spatial Intelligence — 評価 2.5。FlowBench。反実仮想を学習に使う空間知能。方向性は近いが、abstract からは手法が読み取れない
- 2611.03850: RoboScope Kit: Unified Interfaces for Fast and Scalable Embodied-AI Evaluation — 評価 2.5。RoboScope Kit。embodied AI 評価の統合 interface。評価基盤だがツール寄りで、手法の知見がない
- 2611.00859: Wave Forcing: Towards Speed-of-Light Streaming Video Generation — 評価 2.5。Wave Forcing (wildcard; hf 121)。multi-step denoising のまま 1 chunk/round の streaming 動画生成。長期 rollout の drift 対策は world model に隣接するが、生成速度の system 設計が主題
- 2611.04325: Computing Invariant Reachable Sets through Sum-of-Squares Programming — 評価 2.0。Sum-of-Squares による invariant reachable set (制御しても出られない到達可能集合) の計算。安全性検証の数理だが、手元の planner への接続が遠い
- 2611.03944: h-NESDF: An Infinitely Differentiable Signed Distance Between Two Sets with Robotic Applications — 評価 2.0。微分可能な 2 集合間の signed distance (h-NESDF)。衝突回避の cost に使える可能性はあるが、運転での検証が無い
- 2611.03584: TAMPAgent: Agentic Belief-Space Planning for Mobile Manipulation — 評価 2.0。TAMPAgent。mobile manipulation の task and motion planning を LVLM agent に載せる話で、運転の planner 評価に使えない
- 2611.05207: Multi-Objective Generative Optimization via Expected Hypervolume Fine-Tuning — 評価 2.0。多目的 generative optimization の hypervolume fine-tuning。生成 model の最適化で P2 の基準から外れる
- 2611.05035: Federated Transfer Learning for Medical Image Classification under Mixed Skew — 評価 2.0。医用画像の federated transfer learning。分布の偏りへの対策だが、実務の適合 recipe としては遠い
- 2611.04987: ZEMA: confidence-calibrated signed descent with only one state — 評価 2.0。ZEMA。state 1 つの signed descent optimizer。学習効率の話で適合の recipe ではない
- 2611.04811: NightIQA: A Comprehensive Dataset and Benchmark for MLLM-Based Nighttime Image Quality Assessment — 評価 2.0。NightIQA。夜間画像の品質評価 benchmark。評価 benchmark だが画質に限定
- 2611.04709: Learning from Unlabeled Photographs for General Oral Image Analysis — 評価 2.0。口腔画像の unlabeled 写真からの学習。医用の自己教師あり事前学習で、運転・蒸留に遠い
- 2611.04663: Best-of-Depth: Learning Exploratory Dynamics in Looped Transformers — 評価 2.0。Best-of-Depth。looped transformer の探索的 dynamics。事前学習寄りで適合・蒸留の接点が薄い
- 2611.04482: TEMPO: Time Series Understanding via Discrete Tokenization — 評価 2.0。TEMPO。時系列の discrete tokenization。ドメイン外
- 2611.05372: PolicyIK: High-Precision Inverse Kinematics for Robot Arms with Reinforcement Learning — 評価 2.0。PolicyIK。robot arm の逆運動学を RL で解く。manipulation の精度の話で、VLA・world model の設計と遠い
- 2611.04226: DiMuRe: Diagnosis-Guided Multilevel Recovery for Robotic Task Execution — 評価 2.0。DiMuRe。robot の task 実行の失敗診断と回復。manipulation 向けの agent 的な枠組み
- 2611.04073: Computer-Use Agents Gain Little Benefit from a World Model When Conditioned on Tutorials — 評価 2.0。Computer-use agent は tutorial 条件下では world model の恩恵が小さい。GUI agent の話で運転と遠い
- 2611.03626: Isekai3D SDG: A Platform for Diverse Synthetic Gameplay Visual Data — 評価 2.0。Isekai3D SDG。ゲーム的な合成 3D data の生成基盤。運転 simulation との接続は薄い
- 2611.05287: Knowingly Wrong: Training LLMs Against Their Own Beliefs can Induce Misalignment — 評価 1.5。LLM に自分の belief と逆の訓練をすると misalignment が出る分析。適合の recipe ではない
- 2611.05280: YANAMI: A Large-Scale Multimodal Dataset and Benchmark for Multiturn Stateful Interaction — 評価 1.5。YANAMI。multiturn 対話の dataset と benchmark。蒸留・適合の接点なし (hf_upvotes 26 は副次シグナルのため評価は上書きしない)
- 2611.05223: PLANTEUR: A Crop-Type Segmentation Benchmark for Tropical Regions — 評価 1.5。PLANTEUR。熱帯の作物 segmentation benchmark。domain gap の評価はあるが運転と遠い
- 2611.04949: HERIT: Enabling Global Access to Hanja-to-English Historical Translation by Mitigating Temporal Bias — 評価 1.5。HERIT。漢文・Hanja から英語への翻訳。ドメイン外
- 2611.04834: Feeling of Knowing in Large Language Models — 評価 1.5。Feeling of Knowing。LLM の自己認識の分析
- 2611.04755: iMED: A Multi-Endoscope Dataset for Surgical 3D Perception — 評価 1.5。iMED。内視鏡の 3D 知覚 dataset
- 2611.03126: CUA-Master: Scaling Computer-use Agents through Open-World Recursive Improvements — 評価 1.5。CUA-Master (wildcard; hf 97)。computer-use agent の recursive improvement。GUI agent の話で運転と遠い
- 2611.04871: Physics-Based Plausibility Assessment of AI-Predicted Vehicle Parameters for Automotive Radar in Pre-Crash Scenarios — 評価 1.0。レーダー simulation 用の車両 parameter の物理的妥当性検査。planner 実装・評価に直接使えない
- 2611.04734: TEXMET: A Deep Learning Benchmark for Archaeological Textile Reconstruction — 評価 1.0。TEXMET。考古学の織物復元 benchmark
- 2611.04687: CardioVascBench:Prioritized Diagnosis Generation from Real-World Chinese Cardiovascular Records — 評価 1.0。CardioVascBench。循環器の診断生成 benchmark
- 2611.01860: Advances in Agentic Computer Graphics — 評価 1.0。Advances in Agentic Computer Graphics (wildcard; hf_upvotes 128)。CG の agentic 手法の taxonomy。分野外で学びの価値はあるが、追う 3 プロジェクトへの接点なし
- 2611.04176: Grasping and Stabilizing Tumbling Objects with Rotating-Base Multi-Arm Space Manipulators — 評価 0.5。宇宙 manipulator の tumbling 物体の把持。運転と無関係
