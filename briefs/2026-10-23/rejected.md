# rejected 2026-10-23

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。評価は topics.yaml の relevance_criteria に沿った 0-5 点。すべて abstract に基づく。

## planner_ai (candidates 1 件、全て採用)

(なし。唯一の候補 2610.29676 DriveMLP を採用。2 本目は RSS 回収分の 2610.29435)

## fm_distill_finetune (candidates 30 件中 29 件不採用。採用は 2610.29378 OnQ)

- 2610.29439: How Far Can Foundation Models Be Distilled for Efficient Jet Tagging? — 6 teacher × 5 student の系統的な蒸留比較で「gain は主に teacher の強さで決まる」「2k parameter で 1000 倍大きい ParT と同等」。capacity gap の知見として有用だが、domain が素粒子物理の jet tagging で recipe の移植が遠い (評価 3.5)。次点
- 2610.30125: PhysiCalWorld: In-Context Physics Calibration for World Models — 探索動作の clip を physics descriptor token にして world model を fine-tuning なしで現場の物理に合わせる。P3 寄りで面白いが manipulation の物理 (質量・摩擦) が対象 (評価 3.0)
- 2610.29915: CausalAlign: Causal Alignment of Video Generation Models for Consistent Ego-Motion — 動画生成の ego-motion のずれを、3D foundation model への表現 alignment で直す。運転 world model の自車運動の一貫性に関係 (評価 3.0)。P3 の次点
- 2610.29618: FogTTA: Online Test-Time Adaptation for Robust Transformer-based Object Detection in Foggy Weather — 霧への online test-time adaptation (teacher-student の pseudo label)。domain adaptation だが perception 側で、既存手法の組み合わせ (評価 2.5)
- 2610.29545: PACE: Periodic and Channel-Aligned Encoding of Four-Bit Recurrent States — linear attention の recurrent state を 4 bit に後付け量子化。推論効率の工夫で蒸留・適合ではない (hf 16、評価 2.5)
- 2610.29638: Cross-Area Transfer Learning for VLC-based Indoor Localization with a Transfer Efficiency Score — 屋内測位の transfer learning。source 選択の指標 TES は発想として参考程度 (評価 2.0)
- 2610.29594: A Transfer Learning-Driven Methodology for Efficient and Sustainable Indoor Localization Using VLC — 同上の姉妹論文 (評価 1.5)
- 2610.29419: When Thoughts Become Memory: Unifying In-Context Learning and Fine-Tuning — データを context に置くか weights に入れるかの判定則。理論寄りで適合 recipe ではない (評価 2.5)
- 2610.29410: ECHO: Emergent Common-Mode Hidden Offsets Drive Vocabulary Collapse in Preference Optimization — preference optimization の崩壊機構。LLM の alignment 寄り (評価 2.0)
- 2610.29352: Don't Stop Long-Context Continual Pre-Training Too Early: An Empirical Scaling Law — LCCP の scaling law。継続事前学習で、適合の判断材料としては遠い (評価 2.0)
- 2610.29355: GaP-MoE: Explicit Expert Specialization in Mixture-of-Experts via Orthogonal Gradient Accumulation and Projection — MoE の expert 特化。構造の話で P2 外 (評価 1.5)
- 2610.29605: Improved Training of Strong Stochastic Flow Maps — SDE の few-step sampling の学習。生成 model の理論寄り (評価 1.5)
- 2610.29854: How Do DiTs Denoise? An Aggregator-Predictor View of Attention and MLPs — DiT の解釈 (評価 1.5)
- 2610.30068: Loopholing All the Way: Language Modeling with pure Self-Conditioning — diffusion LM の self-conditioning (評価 1.0)
- 2610.30118: The role of locality and weight sharing in convolutional neural networks — teacher-student 理論モデルで CNN を解析。keyword の "teacher student" に当たっただけで蒸留ではない (評価 1.0)
- 2610.30104: BatchBench — 生物画像の batch effect の leaderboard。分野外 (評価 1.0)
- 2610.29495: Balancing Foundation Models and Trait-Specific Learning for Forehead-Crease Recognition — 生体認証。分野外 (評価 1.0)
- 2610.29442: Beyond Shortcut Learning: Hierarchical Spatial Prototype Regularization for Face Forgery Detection — deepfake 検出 (評価 1.0)
- 2610.30075: From Classifier Heads to Encoder Prototypes (HDC-FL) — personalized federated learning (評価 1.0)
- 2610.29443: DynaWeave: Learning to Adapt through Dynamic Scenario Synthesis — LLM agent の動的シナリオ合成 (評価 1.0)
- 2610.30006: Building Auditable AI Text Detectors with Sparse Autoencoders — AI 文章検出 (評価 0.5)
- 2610.29996: HiddenLens — 要求仕様の暗黙の前提検出 (評価 0.5)
- 2610.29943: Towards English - Mizo Legal Machine Translation — 機械翻訳コーパス (評価 0.5)
- 2610.29922: Unintended Side Effects of Value Training in LLMs — 価値観の学習の副作用 (評価 0.5)
- 2610.29907: Benchmarking LLMs for Detecting Satirical Code-Mixed Sentences — 分野外 (評価 0.5)
- 2610.29896: Investigating the Impact of Learner Errors on Social Bias in LLMs — 分野外 (評価 0.5)
- 2610.29785: Where Do LLMs Learn to Recommend AI? — 分野外 (評価 0.5)
- 2610.29767: ALIAS: Evaluating Performance and Memorization in LLM-Written TLA+ Specifications — 分野外 (評価 0.5)
- 2610.29651: Spatially Gated Demographic Steering for Debiasing Multi-Person Text-to-Image Generation — 分野外 (評価 0.5)

## next_arch (candidates 23 件中 21 件不採用)

- 2610.30120: ALPS: Visual State Encoders for World Models — 言語・再構成・空間対応を 1 つの ViT-B に統合した world model 用 encoder。V-JEPA 2-L (3.5 倍) と同等の state probe。評価 4.0 で FCP と同点、hf_upvotes (16 vs 99) のタイブレークで落とした。次点 1 位
- 2610.30136: Agentic World Action Models (AW-0) — code / 未来 video / action を 3 つの生成 stream で同時に出す。manipulation の skill 再利用が主眼 (hf 11、評価 3.5)
- 2610.29168: How Representational Priors Shape Generalization in World Action Models — backbone の表現の nuisance orthogonality が WAM の汎化を事前に予測する。backbone 選択の指標として P3 に有用 (評価 3.5)。次点
- 2610.29203: NavBind: Diagnosing Instruction-Action Binding at Route Forks in Navigation VLAs — 指示だけ変えて action が変わるかを測る診断。10-22 の 2610.28184 と同じ「片方だけ変える」評価の系統で P1 評価にも効くが、室内 navigation (評価 3.5)。次点
- 2610.29730: Post-hoc Epistemic Uncertainty for Vision-Language-Action Policies — 単一 policy の embedding から Gaussian process の分散で epistemic uncertainty を後付け推定。運転の OOD 検出にも転用余地 (評価 3.0)
- 2610.29088: Causal world models under physical parameter shifts — 介入から得た依存 mask で OOD 誤差を半分以下に。synthetic + 指の動力学 (評価 3.0)
- 2610.29408: LiveAct: Towards Real-Time Multi-Agent World Models with Heterogeneous Action Interfaces — 複数 agent を独立に制御する video world model。運転の multi-agent sim に発想は近いが game / robot 中心 (評価 3.0)
- 2610.28779: Second Thoughts: Exploring and Planning through Comparative Imagination in World Models — world model 内の想像 rollout の比較で plan 採用を決める (評価 2.5)
- 2610.29061: OccJEPA: Occlusion as Masking for Amodal Video Segmentation — V-JEPA 2.1 の predictor で隠れた部分を補完。33.5 倍速。perception 寄り (評価 2.5)
- 2610.30097: AtomicRL — VLA の RL post-training の credit assignment。manipulation (評価 2.5)
- 2610.29161: SimPT — intervention ベースの VLA post-training の自動化 simulation (評価 2.5)
- 2610.29560: From VLM Planners to Robotic Agents: Self-Evolving Harnesses (SERA) — VLM の harness 自己進化。manipulation (hf 10、評価 2.5)
- 2610.29329: Plan First, Act Later (PAL) — VLA の階層 memory (評価 2.5)
- 2610.29866: GeoMem-VLA — 3D 幾何を temporal memory の token に内在化 (評価 2.5)
- 2610.28827: WorldStream — open-ended 3D world 生成。game 寄り (hf 9、評価 2.0)
- 2610.30044: SP-HLM — humanoid の loco-manipulation (評価 1.5)
- 2610.29692: FlowVLA — 注ぐ量の推定。manipulation 特化 (評価 1.5)
- 2610.28880: Real2Sem2Real — 単一の人間 demo から robot demo を増やす (評価 1.5)
- 2610.29308: LLM-Based Exogenous World Modeling for Dynamic Scheduling — 生産スケジューリング (評価 1.0)
- 2610.28976: SSMCGM-Stream — 血糖予測の state space model。keyword の "state space model" に当たっただけ (評価 0.5)
- 2610.28753: Understanding the Inner Workings of a State-Space Foundation Model for Limit Order Books — 金融。同上 (評価 0.5)

## wildcard (3 件、全て不採用)

全体上限 6 を本流の quota (2+2+2) で使い切ったため、wildcard を入れるには本流を 1 本落とす必要があった。そこまでの価値のあるものは無し。

- 2610.28402: StreamEval: Evaluating Interactive Streaming Video Generation Models — streaming video 生成の benchmark (37 model)。「画質と状態の一貫性は一致しない」は world model 評価にも通じるが、avatar / 編集中心 (hf 279、評価 2.5)
- 2610.26802: Scaling Parameter-Efficient Fine-Tuning for Brain Encoding — 10-21 に見送り済みの再来 (hf 244、評価 2.0)
- 2610.26625: EgoXperience: Learning World-Grounded Egocentric Representations from Human Experience — egocentric の 3D 再構成データと benchmark (hf 187、評価 2.0)

## RSS 回収分の次点 (ブリーフ化せず)

RSS 5 本 (cs.LG / CL / CV / RO / AI; lastBuildDate 2026-10-22 04:00Z = 10-22 実行時とは別 build) から、candidates に無く keyword に当たった 266 件のうち、10-22 の走査済み・過去ブリーフ記録済みの id を除いた 248 件を題名で走査し、上位を abstract まで読んだ。

- 2603.11417: Zero-Shot Cross-City Generalization in End-to-End Autonomous Driving: Self-Supervised versus Supervised Representations — 都市を跨ぐ zero-shot 転移を E2E 運転の stress test にする (nuScenes open-loop + NAVSIM closed-loop)。P1 の評価として 2 本目の候補だったが、replace (3 月の論文の改訂版) なので新着の 2610.29435 を優先 (評価 4.0)。P1 次点 1 位
- 2610.28914: D-Skill: Distilling Teacher Knowledge through Agent Skills — 重みを触らず、teacher と student の rollout の差から自然言語の skill 文書を作って gap の 75-95% を埋める。LLM agent 限定 (評価 3.5)。P2 次点
- 2610.29965: CORD: Conflict-Aware Optimization for Joint RL and Distillation in Agents — RL と self-distillation の勾配の衝突を射影で除く (ALFWorld +1.5〜15.9pt)。蒸留と RL を同時に回す場合の recipe (評価 3.5)
- 2610.28892: Combating Catastrophic Forgetting in Continual Domain Adaptation via Knowledge Recasting (SST) — 新ドメインの例を既存 skill の型に書き直して忘却を減らす (MATH の max-drop 42.41→7.10)。LLM 限定 (評価 3.5)
- 2610.29969: FaultGene — CARLA / Scenic のシナリオに HIL (Hardware-in-the-Loop; 実機の計算機を simulation に繋ぐ試験) 用の故障を注入するテストを LLM で生成。P1 の評価インフラ寄り (評価 3.0)
- 2610.28829: HorizonComposer — 運転 video の天候等の編集で交通 semantics を壊さない。stress test 用データ生成 (評価 3.0)
- 2610.29075: Value-Rectified Distillation for Flow-based Offline RL — flow matching の policy 蒸留で mode 平均化を防ぐ。multi-modal な軌道の蒸留に関係 (評価 3.0)
- 2610.29646: From Association to Decision Value: Testing Paired Instruction Dependence for VLA Corpus Selection — データ選択の診断が「予測的だが判断価値は小さい」という負の結果 (評価 2.5)
- 2610.18826: WorldOracle: Benchmarking Action-Conditioned World Models against Real-World Executions — replace。world model を実機実行と対で評価。manipulation (評価 3.0)
