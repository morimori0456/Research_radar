# 2026-10-06 不採用 (candidates.json 3 件 + RSS 回収分)

## §0 fetch 診断 (選別の前に実施)

- **fetch のエラーは無かった** (5 日連続)。`~/research_loop.log` の 10-06 03:00 の実行は、3 トピックとも `0 new`。予告どおり、月曜 UTC の fetch で、木〜金の投稿分がエラー無しで窓外になった。
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ) は 5 本とも 200。new/cross は重複除去後 656 件、本流 keyword 一致は 60 件** (planner_ai 1 / fm_distill_finetune 32 / next_arch 27; `/tmp/rss_1006.json`、取得は 10-06 JST 朝)。**API では 0 件なので、この 60 件が今日の fetch の喪失分に相当する。** 採用 4 本は全部この RSS 回収分。
- **RSS 一致は keyword の部分文字列一致のみ。** 例えば fm の `fine-tuning` は 32 件中の多くが「ただ fine-tuning を使った」論文で、採点は abstract で行った。
- **wildcard 3 件のうち 2 件は既出。** `2609.38078` MotorMind は 10-01、`2609.38839` FrameMorrow は 10-02 に rejected 済み。HF daily papers 経由の再来で、欠陥② (dedup) が wildcard にも要る実例の 2 回目。新規の `2609.38879` を探索枠で採用した。

## §1 判断の分岐点

1. **FastOPD (VLA の on-policy distillation) は fm (P2) の枠で採用した。** keyword は `VLA` で next_arch に一致するが、主題は蒸留の recipe。P3 側の枠は world model の 2 本に回した。
2. **world model は 2610.02860 (診断) と 2610.03587 (対策) の組で採用。** DeltaWorld (2610.02691; P3 3.5) は次点。
3. **planner_ai は 0/2。** 一致した 1 件はマニピュレータの関節寿命で、運転に移せない。
4. **GRAFT (P2 3.5) は枠の都合で次点。** 明日以降、教師を足していく蒸留が必要になった時に再浮上する。

採用: P1 0/2 ・ P2 2/2 ・ P3 2/2 ・ wildcard 1/1 = **5/6**。

## §2 不採用

### wildcard (candidates.json)

- 2609.38078: MotorMind: Scaffolding General Vision Language Models for Zero-Shot Robot Manipulation — 既読 (10-01 に rejected 済み)。VLM に直接ロボットを操作させる harness で、操作のみ
- 2609.38839: FrameMorrow: Future-guided Frame Selection with Prospective Tokens for Long-Horizon Video Generation — 既読 (10-02 に rejected 済み、P3 2.0)

### planner_ai (RSS 回収分)

- 2610.02469: RUL-Aware RRT*: Degradation-Balanced Motion Planning for Robotic Manipulators — P1 1.0 — keyword は motion planning だが対象はマニピュレータの関節寿命 (RUL) で、運転のプランナー評価に移せない

### fm_distill_finetune (RSS 回収分)

- 2610.02974: From Language Priors to Field Adaptation: Preference Learning for Traversability Estimation — P2 3.0 — 少数ラベルでの domain adaptation (traversability) は主題に合うが、同日の FUSEye の方が recipe として一般性が高い
- 2610.03017: Personalized Automatic Speech Recognition for a Dysarthric and Tracheostomic Speaker using Artificial Conversations — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02292: Diffusion-Based Synthetic Data Pretraining for Enhancing Activity Recognition — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02437: Learning Style, Forgetting Semantics: A Case Study of SFT and RFT on Classification Tasks — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02444: Counterexample Generation via Per-Theorem Symbolic Verifiers: When Imitation Hurts and Reinforcement Repairs — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02486: From Retrieval to Typed Decisions: Calibrated System One Models from Biomedical Sentence Encoders — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02665: Large Language Continuous Diffusion Models — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03099: Beyond Single Videos: Benchmarking and Active Evidence Seeking for E-Commerce Cross-Video Reasoning — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03163: Predicting Steering Vectors and Adapter Weights for Few-Shot Author-Style Transfer — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03190: Not Until the Evidence Says So: Teaching LLM Investigators When to Close a Case — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03265: SPEAR: A Spectral-Disentangled MoE Neural Operator with Knowledge-Guided Expert Aggregation for Large-Scale PDE Pretraining — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03361: Follow the Winners: Conservative Policy Improvement with the Cross-Entropy Method for Critic-Free RFT — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02559: Neuron merging via inverse-activation regression for post-training compression of sigmoid neural networks — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02738: Inner Momentum for Differentially Private Muon — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02795: Efficient Memory Crystallization for Graph Learning under Non-Stationary Distribution Shifts — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03085: Light Entropic Optimal Transport on Riemannian Manifolds — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03419: Deep Bayesian REFoCUS — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03503: Getting Your Guidance Weights Right in diffusion and flow-matching posterior sampling — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03641: IDRF: Inverse-Distilled Reward Fine-tuning of Masked Discrete Diffusion Models — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02269: Confidence-Gated Cloud-Edge Cascade Triage via Variational Risk Minimization for Medical Imaging — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02578: High-Dimensional Asymptotics and Dataset Selection for Private Transfer Learning — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02819: Text-Centric Post-Training for Omni-Modal Reasoning — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02856: Adaptive Mutual Distillation for Balanced Multi-Task Post-Training of Large Language Models — P2 3.0 — 2 モデルの mutual distillation による LLM の multi-task post-training。蒸留の一種だが、対象が LLM のタスク間バランスで P2 の主題 (基盤モデルの縮小・他機種適合) から遠い
- 2610.03063: HARPO: Hallucination-Aware Reinforcement Learning for Faithful and Creative Language Generation — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03077: Unmasking Propaganda: A Comparative Analysis of Masked and Causal Language Models — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03073: SecJev: Bringing Security Expertise to System One Decision Models — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02343: SCOPE-4D: Endoscopic 4D Geometry Foundation Models — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02388: Octrees as an Explicit 3D Language — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.02597: GRAFT: Growing Agglomerative Foundation Models via Continual Teacher Distillation — P2 3.5 — 次点。continual な multi-teacher distillation で教師を足す recipe は使えるが、対象が vision foundation model 同士の統合で、枠 2 は FastOPD と FUSEye を優先
- 2610.03370: LAS-CLIP: A Lightweight Adapter Steering Approach for CLIP's Visual Encoder — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない
- 2610.03617: DEPICT: Scoring Text-to-Image Alignment by Answer Agreement — P2 ≤2.0 — fine-tuning の語が出るだけで、蒸留・他ドメイン適合の recipe ではない

### next_arch (RSS 回収分)

- 2610.02323: World-Calibrated Proposal-to-Action Flow for Vision-Language-Action Models — P3 3.0 — flow-based VLA の source 分布の設計。操作タスクのみ
- 2610.02360: SocialVLA: A Social Perception Gateway for Human-Reaction-Based Failure Detection and Recovery in VLA Manipulation — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02691: DeltaWorld: Physically Consistent Interactive World Simulators via Action-Conditioned Latent Increment Learning — P3 3.5 — 次点。world model が差分 (latent increment) を予測する設計は面白いが、操作タスク中心。同日は評価・診断の 2610.02860 を優先
- 2610.02784: SimpleTouch: Can Vision-Language-Action Models Master Contact-Rich Manipulation Without Tactile Policy Pretraining? — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02802: ManiPhysicsBench: Physics-Based Assessment of Object Preservation in VLA Manipulation — P1 2.0 — 評価ベンチマークだが、操作の物体保存で運転の評価に移せない
- 2610.02804: SARI: Phase-Split Sim-Real Co-Training for Contact-Rich Manipulation — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02840: PointWAM: 3D World Action Modeling for Dexterous Robotic Manipulation — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02898: MixVLA: Adaptive Mixing of Non-Invariant Information for Generalizable Vision-Language-Action Models — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.03498: Detect and Suppress: A Mechanistic Defense against Adversarial Patches in VLA Models — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.01939: Fewer Tokens, Better Action: GPT-6 Astra Robot Agents with 14% Higher Success Rate but 65% Fewer Tokens — 既読 — 10-05 以前の briefs/ に id あり (dedup)
- 2610.02515: IGNITE Tokamak World Model Architecture — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02659: Distributed Learning with Selective State Space Models: Architecture-Aware Convergence Analysis — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.03713: What Should World Models Forget? Stratified Retention for Continual Adaptation — P3 2.5 — world model の continual adaptation。abstract の範囲では運転との接点が薄い
- 2610.02248: State-Space Unlearning for Non-Stationary Bias in Land Surface Forecasting — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02957: Understanding Trajectory Heterogeneity in Federated World Model Learning — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.03154: Does Physics Live in the Activations? Localizing Physical Quantities in Video Diffusion Models — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02744: EpiWorld: Grounding LLM Policy Agents in Epidemiological World Models — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.03632: World Embedding Benchmark — P3 2.5 — world model の benchmark 提案。内容が埋め込みの評価中心で、運転の用途が不明
- 2610.02521: Spatial Memory Intelligence: Endowing World Models with Understanding-Driven Long-Term Memory — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02626: Imagine the Future, Internalize the Gist: Efficient VLA Reasoning via Internalized Spatiotemporal Imagination — P3 3.0 — VLA の将来想像を 1 token に内部化する推論高速化。FastOPD と目的が重なり、操作のみ
- 2610.02660: SpectralCache: Accelerating Diffusion-Based World Models via Spectral Feature Caching — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
- 2610.02666: CHASE-VLA: Post-Training Quantization Framework for Vision-Language-Action Models with Chunk-Aware Scale Estimation — P2 2.5 — VLA の post-training quantization。圧縮の手法だが蒸留ではなく、操作のみ
- 2610.02726: SymRegFlow: Symmetry-Regularized Flow Matching for Video World Models — P3 3.0 — nuScenes の運転動画生成だが、生成品質 (FVD) が主題で、planner への寄与は無い
- 2610.03374: EVEWorld: Physical Evolution Supervision for Embodied World Models — P3 ≤2.5 — VLA/world model の語に一致するが、操作・物理・他分野の応用で運転に移せる点が薄い
