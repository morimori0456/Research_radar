# 却下候補 — 2026-07-04

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 47件 → 選定 6件(max_deep_per_day=6 で消化)、却下 41件。
hf_upvotes は副次シグナル(タイブレーク用)であり relevance を上書きしない旨を明記して運用。

---

## P1 — planner_ai
- **2607.01378v1: Neuro-Symbolic Safety Guidance for VLA via Constrained Flow Matching** — score 3/5。flow-matching VLA の denoising 中に制約付き最適化で予測衝突を先回り修正する着想は良質で、プランナ安全層(軌道レベル補正)への転用余地はある。ただし対象は robot manipulation(SafeLIBERO)で AV プランナへの適合は間接的。P1 の強候補が CommonRoad-Game 1件で、限界効用が低いため惜しくも却下(本日の runner-up)。「denoising 中の制約充足で予測衝突回避」という筋は将来の安全プランニング検討でメモ。

## P2 — fm_distill_finetune
本日は蒸留/PEFT 系の良質候補が集中。quota=2 のため強い runner-up を多数落とした。
- **2607.01827v1: C2E — Multi-Teacher Contrastive KD for Ego-Only 3D Detection** — score 4/5。**最有力 runner-up**。Co-Perception→Ego-Perception のマルチ教師対照蒸留で通信コストゼロのまま +8.64% mAP、しかも自動運転(V2X)ドメイン。P2 の蒸留 recipe としても AD 関連としても価値高。quota 超過のみを理由に次点で見送り、翌日以降の最優先再検討候補。
- **2607.01763v1: Denser≠Better — Limits of On-policy Self-Distillation for Continual Post-Training** — score 4/5(hf 4)。on-policy 自己蒸留が継続学習で忘却/崩壊を招くという**負の結果**は蒸留を実務で回す上で重要。汎用 recipe の落とし穴として次点。
- **2607.01906v1: SFKD — Spatial-Frequency Joint-Aware Heterogeneous KD** — score 4/5。CNN↔ViT の異種蒸留で空間情報を wavelet+Fourier で分解する新 loss。capacity/inductive-bias gap 対策として良質だが quota 超過で次点。
- **2607.02037v1: Cross-Platform Control for ASV via Adaptive RL** — score 4/5。teacher-student で latent dynamics を推論し zero-shot で他機種展開(微調整なし)。「他機種適合」テーマに合致するが対象が水上艇で AD からの距離があり次点。
- **2607.01789v1: EPnG — Adaptive Expert Prune-and-Grow for PEFT MoE** — score 3/5。router 重要度で LoRA 容量を再配分、0.55–0.72% 更新で full FT 級。MoE 前提で自社構成との距離があり見送り。
- **2607.02182v1: DALorRA — Bayesian Sparse LoRA for Uncertainty Estimation** — score 3/5。LoRA の rank 次元に確率マスクで校正改善。有用だが本日の distill/finetune 本命に劣後。
- **2607.01908v1: Ultrasound LVLM from Multi-Image Exams (LoRA)** — score 3/5。「複雑アーキより data scale + 臨床整合の LoRA 単純 recipe が勝つ」という適合の教訓は良いが医療ドメイン特化で次点。
- **2607.02220v1: DetailAnywhere — Fashion Detail Gen via Cross-Modal Feature Alignment Distillation** — score 3/5。DINOv3 教師の dual-branch 特徴整合蒸留は技術的に面白いが EC/ファッション特化。
- **2607.02269v1: AnyGroundBench — Domain-Adaptation Benchmark for Video Grounding** — score 3/5(hf 7)。ドメイン適合評価という観点は P2 と合うが、蒸留/適合 recipe そのものでなくベンチ提案で次点。
- **2607.02490v1: VRRL — Visually Grounded Self-Reflection via RL** — score 3/5。OOD 適合の RL 微調整。着想は良いが本命に劣後。
- **2607.02072v1: kNNGuard — Training-Free Configurable Guardrail** — score 3/5。活性空間の kNN で微調整不要ガードレール、ドメイン適合はラベルバンク更新のみ。安全周辺で面白いが本題から外れる。
- **2607.01918v1: Zeus — Tuning-Free Time Series Foundation Model** — score 2/5。tuning-free TSFM は時系列特化で自社適合価値薄い。
- **2607.01927v1: TUDUM — Turkish-Thinking Reasoning Pipeline** — score 2/5。SFT+GRPO のドメイン適合だが言語特化・結果も混合。
- **2607.02464v1: Will Scaling Improve Social Simulation with LLMs?** — score 2/5。scaling law 分析は知的に面白いが社会シミュレーションで P2 の実務適合から外れる。
- **2607.02372v1: SPoILeR — Spectral/Polarimetric Implicit Learned Representation** — score 2/5。マルチモーダル事前学習→RGB のみ微調整の転用は着想良いがセンサ/NVS 特化。
- **2607.01934v1: AIriskEval-edu — K-12 Risk Assessment Dataset** — score 2/5。ローカル SFT で frontier 追随だが教育監査ドメイン特化。
- **2607.02140v1: Probing Chemical Language Models** — score 2/5。微調整が表現に与える影響の分析は方法論として面白いが化学 SMILES 特化。
- **2607.02497v1: PanoSeeker — Active Panoramic Referring Segmentation** — score 2/5。SFT+RL の embodied 探索で分野外。
- **2607.02479v1: EAGLE-360 — Embodied Active Global-to-Local Exploration** — score 2/5。360° 視覚探索の SFT+GRPO、RoPE Rolling は面白いが分野外。
- **2607.01737v1: ReQuest — Question-Aware Frame Selection for Long-Video QA** — score 2/5。蒸留した軽量セレクタを使うが本体は動画 QA で本題外。
- **2607.01962v1: NeoMap — Training-free Novel-View Synthesis** — score 2/5。訓練不要 NVS で蒸留/適合と無関係。
- **2607.01869v1: QWERTY — Training-Free Motion Control via Query-Warped Video DiT** — score 2/5。動画生成の訓練不要制御で本題外。
- **2607.01849v1: Decomposer — Decompile Symbolic Music to Programs** — score 2/5。SFT+RL だが音楽プログラム合成で分野外。
- **2607.02428v1: SA-RDM-DC — Pathology-Preserving Accelerated Knee MRI** — score 1/5。医療画像再構成で対象外。
- **2607.02387v1: Agentic Search for Earth Observation Data** — score 1/5。地球観測データ探索で対象外。
- **2607.02292v1: Proximal Wavefunction Optimization (Neural Quantum States)** — score 1/5。量子多体で対象外(1.5B RWKV 微調整の言及のみ)。
- **2607.02212v1: Additive MLP-GNN for Aqueous Solubility** — score 1/5。創薬・分子物性で対象外。
- **2607.01943v1: Hybrid Quantum-Classical NN for Sentiment Analysis** — score 1/5。量子 NLP で対象外。

## P3 — next_arch
VLA / world model 系が本日最も豊作。quota=2 のため多数の良質候補を次点で見送り。
- **2607.02466v1: Learning to Move Before Learning to Do (TAP)** — score 4/5(hf 4)。**最有力 runner-up**。Decomposition Hypothesis(運動能力=無ラベル安価データ / 意味整合=言語必要)で task-agnostic 事前学習、少ラベルで 1M デモ級に到達・カメラ摂動に頑健。VLA 学習の本質に触れる好論文で翌日再検討の最優先。
- **2607.02517v1: WorldDirector — Controllable World Simulators with Persistent Dynamic Memory** — score 4/5(hf 16)。意味的運動制御と視覚生成を分離し永続的な動的物体記憶を実現する video world model。P3 world model に有力だが quota 超過で次点(Orca と関心が重複)。
- **2607.01586v1 は選定済み(VLAFlow)。DriveTeach-VLA も選定済み。**
- **2607.02195v1: Bridge-WA — Predicting Where/How the World Changes for Action** — score 3/5。凍結 future-change 教師を 3 つの compact prior に蒸留する world-action、OOD 視覚シフトに強い。P2/P3 両にまたがるが次点。
- **2607.02092v1: Guided Action Flow — Q-Guided Inference for Flow-Matching VLA** — score 3/5。凍結 SmolVLA に action-chunk critic で推論時ガイド。着想良いが利得が限定的で次点。
- **2607.01804v1: VLA-Corrector — Detect-and-Correct for Adaptive Action Horizon** — score 3/5。潜在視覚モニタで逸脱検知し適応的に replanning。closed-loop 反応性の話で面白いが本命に劣後。
- **2607.02322v1: The Moving Eye — VLA Spatial Generalization via Hybrid Dynamic Data** — score 3/5。shortcut learning 回避のデータ戦略。データ中心の知見は有用だが次点。
- **2607.02431v1: WorldSample — Closed-loop Real-robot RL with World Modelling** — score 3/5。real-synthetic ループの world model データ拡張。robot RL 寄りで次点。
- **2607.02403v1: ACID — Action Consistency via Inverse Dynamics for Planning** — score 3/5。world model 計画に cycle action consistency を導入。計画コスト設計の着想は P1 とも接点あるが次点。
- **2607.02045v1: PWM-ArtGen — Part World Model for Articulated Object Generation** — score 2/5。関節物体生成の world model で対象からやや外れる。
- **2607.01938v1: PhysMani — Physics-principled 3D World Model for Manipulation** — score 2/5。物理 3D Gaussian world model は魅力だが操作特化。
- **2607.02087v1: SUNTA — Hierarchical Video Prediction with Surprise-based Chunking** — score 2/5。HSSM の surprise ベース分割。長期予測は面白いが本命に劣後。
- **2607.01736v1: Predicting Closed-Loop Performance of Latent World Models** — score 2/5。world model の checkpoint 選択診断。closed-loop 評価という点で P1 とも接点あるが LunarLander 限定で次点。
- **2607.02501v1: Embodied.cpp — Portable Inference Runtime for Embodied Models** — score 2/5。VLA/WAM のエッジ推論ランタイム。展開工学として実用的だが新規アーキ/学習の知見ではない。
- **2607.02417v1: LIME — Learning Intent-aware Camera Motion** — score 2/5。言語条件付きカメラ運動生成。active perception で分野外寄り。
- **2607.02222v1: CoFL-S — Sector Flow Fields for Language-Conditioned Navigation** — score 2/5。VLN の低レベル行動表現。navigation 特化で次点。
- **2607.02299v1: DSINet — Dual-Selective Network for Domain-Incremental Change Detection** — score 2/5。Mamba(SSM)+ 蒸留のリモセン変化検出。SSM 要素はあるがドメイン特化。
- **2607.02237v1: When Token Compression Breaks (ViT Seg)** — score 2/5。ViT 効率化のトークン圧縮 vs 構造プルーニング比較。効率化知見だが分割特化。
- **2607.01502v1: Evaluating Mamba for ASR in South African Languages** — score 2/5。SSM(Mamba)評価だが ASR 特化で自社転用薄い。
- **2607.01986v1: Liquid Latent State Dynamics for Turbofan Degradation** — score 1/5。liquid NN の予知保全 world model。対象外。
- **2607.01595v1: Safe and Adaptive Cloud Healing with Neural-Symbolic World Model** — score 1/5。クラウド自己修復で対象外。
- **2607.01537v1: Certified World Models as Sensing Clocks** — score 2/5。world model の validity horizon で再センシング判断。active perception の理論寄りで次点。
- **2607.01531v1: OPINE-World — Programmatic World Modeling** — score 2/5。LLM によるプログラム合成 world model(ARC-AGI-3)。着想は面白いが記号世界特化。
- **2607.02390v1: DecompRL — Modular Code Generation via RL** — score 1/5。コード生成の RL で分野外(next_arch にタグされているが該当薄)。
- **2607.02283v1: Dendritic In-Context Learning in Single-Layer SNN** — score 2/5。SNN の ICL。理論的に興味深いが自社アーキ転用の距離が大きい。

## wildcard(sns_wildcard)— EXPLORE 枠は最大1件、Orca を選定
- **2606.28436: Dockerless — Environment-Free Program Verifier for Coding Agents** — score 3/5(hf 101)。環境不要のパッチ検証で SFT/RL の post-training を軽量化する良質論文だが、coding agent 領域で自社 P1/P2/P3 からの距離が大きい。探索枠は Orca(world model = P3 と直結)を優先し見送り。
- **2606.30626: DOPD — Dual On-policy Distillation** — score 4/5(hf 91)。privilege illusion を回避する advantage-aware な二重蒸留で P2 と強く接続する好論文。探索枠 1件制約により Orca に譲るが、**P2 の翌日最優先再検討候補**(wildcard でなく P2 本枠として扱う価値あり)。
