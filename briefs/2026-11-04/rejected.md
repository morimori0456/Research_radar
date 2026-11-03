# rejected 2026-11-04

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。candidates.json は 56 件 (generated_at 2026-11-03T18:00Z): planner_ai 1 / fm_distill_finetune 30 / next_arch 22 / sns_wildcard 3。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。

## 採用 (6 本)

2611.03067 (P1 4.5) / 2611.02853 (P3 4.5) / 2611.02526 (P3 4.5) / 2611.03528 (P2 4.0) / 2611.03125 (P2 4.0) / 2611.02101 (P1 3.5)。

- 2611.03067 (PlanContext) は candidates.json では next_arch に分類されていたが、内容は planner の評価 benchmark なので P1 の枠に置いた。2611.02101 も同様 (運転でなく manipulation だが、評価設計の観点で P1)。
- planner_ai の本流候補は 2611.03584 (TAMPAgent、manipulation の計画) の 1 件だけだった。運転の planner 評価に当たる論文は、keyword 一致せず next_arch / fm_distill_finetune 側に分類されている。
- sns_wildcard 3 件は、最大 3.0 (2611.00859 Wave Forcing) で、総数の上限 6 に入らず全て見送り。

## 不採用 (50 件)

- 2611.03584: TAMPAgent: Agentic Belief-Space Planning for Mobile Manipulation — 評価 2.0。mobile manipulation の task and motion planning (TAMP) を LVLM agent に組み込む話で、運転の planner 実装・評価に直接使える知見が薄い (planner_ai で今日唯一の本流候補)
- 2611.03646: EgoActionBench: Benchmarking Dense Action Captioning for Egocentric Human Videos — 評価 1.0。egocentric 動画の dense captioning benchmark。蒸留・適合の接点なし
- 2611.03633: Pretraining Data Scale Reverses the Muon-AdamW Fine-Tuning Gap — 評価 3.5。**次点。** pretraining の token 量が増えると fine-tuning 後は AdamW が Muon を上回る逆転 (margin-to-spread ratio で説明)。fine-tuning の optimizer 選びに効くが、LLM の事前学習規模が前提で運転への接点が薄い
- 2611.03588: 3D-BBDA: Backpropagation-Free Black-Box Domain Adaptation for Robust 3D Point Cloud Recognition — 評価 2.5。black-box の domain adaptation (pseudo-label + prototype 整合) だが、対象が point cloud の分類で、CAT-CKD (採用) のほうが P2 の基準に近い
- 2611.03577: Sonar-MoE: In-Backward Expert Updates for Memory-Efficient Mixture-of-Experts Training — 評価 3.0。MoE の学習中に expert の gradient を即時更新してメモリを 19〜22% 減らす。fine-tuning の効率化だが、適合の recipe ではない
- 2611.03557: PlantVLM-Edge: Quantized Vision-Language Models for On-Device Crop Health Diagnosis — 評価 2.0。農業向けの量子化 VLM。量子化の一般論以外に新しい知見が無い
- 2611.03465: HIVE-Diff: High Frame Rate HDR Video Reconstruction from a Single LDR Frame and Events — 評価 1.0。event camera による HDR 動画復元。3 トピックに接点なし
- 2611.03449: Intent2CAD: How Semantic-Parametric Supervision Shapes Text-to-CAD Generation — 評価 1.0。text-to-CAD 生成の supervision。接点なし
- 2611.03439: Playing Dumb: How a Chess Transformer Simulates Users Across Skill Levels — 評価 1.5。chess transformer が skill level を模擬する仕組みの分析。接点なし
- 2611.03371: EO-Jev: Decision Model for Earth Observation — 評価 2.0。Earth Observation の decision model。リモートセンシング専用
- 2611.03293: ENGINE: Endogenous Variational MultiScale Optimization for Zeroth-Order LLM Fine-Tuning — 評価 3.0。zeroth-order (勾配を使わない) LLM fine-tuning の variance 対策。メモリ効率の話だが、LLM 向けで domain 適合の観点が無い
- 2611.03283: ReVA-HPE: Relative 6DoF Head Pose Estimation with Synthetic Pose Supervision and Personalized Virtual Anchors — 評価 1.5。head pose 推定。接点なし
- 2611.03280: Specificity Bias and the Wikipedia Paradox: An xAI Analysis of AI Text Detectors under Domain Shift — 評価 1.0。AI 生成文の検出器の domain shift 分析。接点なし
- 2611.03271: A Human-Verified AI Workflow for Annotating Environmental Sound Data — 評価 0.5。環境音データの注釈 workflow。接点なし
- 2611.03229: CL3DOD: Understanding the Stability-Plasticity Dilemma in Outdoor Class-Incremental 3D Object Detection — 評価 3.5。**次点。** 屋外 3D 物体検出の class-incremental 学習 (query-wise の distillation + EMA 正則化) と、stability-plasticity の分析。運転データで distillation を使うが、検出が対象で planner / E2E ではなく、abstract に数値が無い
- 2611.03165: LaBraM at Scale: Scaling Data and Models for EEG Pretraining — 評価 1.5。EEG の事前学習のスケール。接点なし
- 2611.03143: Visual-to-Executable Procedural Reconstruction of Buildings — 評価 0.5。建物の procedural な再構成。接点なし
- 2611.03140: When Optimization Meets Human Intent: Human-Centered Diffusion Model Optimization — 評価 1.0。diffusion model を人の意図に沿って最適化。接点なし
- 2611.03120: KAUSTics-Net: Diffusion-Based Through-Water UAV Restoration with a Semi-Synthetic Dataset — 評価 1.0。水中越しの UAV 画像の復元。接点なし
- 2611.03113: Preprocessing Choices in Fine-Tuning Data Matter: Utility and Demographic Sensitivity in LLM-Based Recommendation — 評価 1.5。LLM 推薦の fine-tuning データの前処理の影響。推薦系で接点なし
- 2611.03027: VLM-as-a-Judge for Person Re-Identification — 評価 1.5。人物 re-identification での VLM-as-a-Judge。接点なし
- 2611.03015: Comparative study of global pooling for pre-departure ship fuel consumption prediction: Advantages over per-ship and adaptation-based approaches — 評価 1.5。船の燃料消費予測で global pooling と個別 model / adaptation を比較。表形式データで接点が薄い
- 2611.02985: Distilling Literary Sentiment from LLM Annotations into an Ordinal BERT Model — 評価 2.5。LLM (Gemma 4 31B) の注釈から BERT へ蒸留する文学の感情分析。teacher の注釈を教師にする small-scale の例だが、domain が文学で新しい recipe は無い
- 2611.02952: Balancing Representations by Identifying and Generating Under-represented Data — 評価 2.0。長尾分布の自己教師あり学習で、少ない領域のデータを diffusion で補う。表現学習の話で、蒸留・適合の recipe ではない
- 2611.02908: User Attributes and Political Ideology Shape LLM Receptiveness in Online Political Debates — 評価 0.5。政治討論での LLM の受容性。接点なし
- 2611.02900: Control Foundation Models across Changing Block Diagrams: Generalizing Time-Series Prediction to Dynamic Graphs — 評価 2.0。制御実験データ向けの time-series foundation model。制御・システム同定が対象で運転への接点が薄い
- 2611.02897: PhotoGuider: Composition-Aware Cropping and 360$^{\circ}$ View Framing with Explainable Photographic Assessments — 評価 1.0 (hf 26)。写真の構図 cropping。hf の注目度は高いが relevance は上書きしない
- 2611.02862: Performance evaluation of super-resolution techniques for characterization and phenotyping of commodity crops using multispectral imagery — 評価 0.5。作物の multispectral 画像の super-resolution の比較。接点なし
- 2611.02806: CARE: Contrastive Representation Learning with Environment-Invariance Regularization for Behavioural Intention Prediction — 評価 3.0。歩行者などの意図予測で、環境ごとの特徴の偏りを IRM 型の penalty で抑える表現学習。軌道予測の domain shift に近いが、著者自身が「不変性の証拠ではない」と述べ、新規性が限定的
- 2611.03626: Isekai3D SDG: A Platform for Diverse Synthetic Gameplay Visual Data — 評価 2.0。Unreal Engine の合成ゲームプレイ動画を作る platform。world model 研究のデータ源だが、運転ではない
- 2611.03428: Toward Uncertainty-Aware, Physics-Grounded Human World Models — 評価 2.0。人の 3D 姿勢の不確実性と物理 dynamics を結合する提案。新しい実験結果が無い
- 2611.03168: Rollout then Recycle: 3,718 Labelled Real-Robot Episodes from Benchmarking 7 Policies on 12 Tasks — 評価 2.5。SO-101 arm の 3,718 episode のデータ公開 (失敗 73%)。manipulation のデータで、運転への接点が薄い
- 2611.03103: VLALagBench: Understanding When and Why VLA Inference Latency Matters — 評価 3.5。**次点。** VLA の推論遅延 (100 ms でも移動対象で成功率が約半分) の benchmark と、非同期実行の効果。P1 の遅延評価としては採用した 2611.02101 と同系統で、そちらを優先
- 2611.03101: Diagonal Equivalence in State Space Models: Characterization, Retrieval Rank, and Selective Extensions — 評価 3.0。Mamba 1〜3 を含む線形 SSM の同値性の分類と fused kernel。言語 model の loss では Mamba 3 に届かず、運転への接点が薄い
- 2611.02922: An intelligent satellite must do nothing well — 評価 0.5。衛星の知能化の position paper。接点なし
- 2611.02807: Creating Hybrid Interactive Narrative Systems with LLM: From Formal Description to Evaluation — 評価 0.5。LLM による対話型物語システム。接点なし
- 2611.02782: History Forcing: Distilling History-Dependent Continuations for Long-Horizon Video World Models — 評価 4.0。**次点 (quota 超過)。** few-step の自己回帰 video 生成で、履歴ありと無しの teacher 予測の差 (residual) を足した target に蒸留する on-policy distillation。世界 model の長期整合性に効く (60 秒生成で VBench-Long 79.82)。ただし汎用の動画生成 (1.3B) で運転への接点が間接的。P3 の枠が 4.5 点 2 本で埋まった
- 2611.02777: Beyond Policy Patches: Distilling RL Specialists into Vision-Language-Action Policies — 評価 4.0。**次点 (quota 超過)。** REPAIR: RL specialist の action 候補を critic で重み付けし、flow-matching VLA に on-policy で蒸留する。6 つの実機 task で 100% 成功、jerk も減る。蒸留 recipe として P2 の基準に合うが、manipulation 限定。P2 の枠が 4.0 点 2 本で埋まった
- 2611.02699: Right Ranking, Wrong Scale: Reproducing the Robotic World Model's Dynamics Model and Testing the Uncertainty of Its Follow-up — 評価 3.5。Robotic World Model の再実装と、ensemble disagreement が誤差の順位は当てるが scale を過小評価する (1-sigma coverage 4.6%) という検証。world model の不確実性を closed-loop 評価に使う際の警告になるが、1 台のロボット・1 つの歩容のみ
- 2611.02690: Human-Oriented World Model — 評価 1.5。人の状態を扱う概念的な world model の枠組み。実験が無く、運転への接点が薄い
- 2611.02660: HeLM: Hierarchical Explicit Language Memory for Non-Markovian Manipulation — 評価 3.0。VLA に言語 memory を持たせ、非 Markov な manipulation に対応する。運転への接点が薄い
- 2611.02497: RoboColosseum: Evaluating Physical Intelligence at Scale In-The-Wild — 評価 3.5。**次点。** 分散した実機評価の枠組みで、VLA の fine-tune track (20 task、各 100 demo) で順位が embodiment ごとに食い違う (Kendall W = 0.24)。他機種適合の評価としては重要だが、manipulation のロボットが対象で、P2 の運転・蒸留の recipe には直接つながらない
- 2611.02405: MirrorComm: A Communication-Efficient Cooperative Perception Framework via Mirrored World Models — 評価 3.0。mirrored world model で協調知覚の通信量を最大約 66 分の 1 に削減。通信帯域の話で、planner / E2E の設計には間接的
- 2611.02341: AgiWorld: An Agentic Video World Model for Building Persistent Worlds — 評価 2.0。agent が計画し、video world model が chunk ごとに persistent な世界を作る生成系。運転への接点なし
- 2611.02284: SVD-Prune: Spectral Vision Token Pruning under Extreme Compression — 評価 3.5。**次点。** SVD で visual token を 99.3% 削減する training-free の pruning (16 token で 4.18 倍高速)。VLM / VLA の入力側の効率化で P3 に関連するが、2610.40935 (GATS、昨日採用) と同系統で運転での検証が無い
- 2611.02218: Beyond Ensemble Disagreement: Predictive STL Monitoring of RL Locomotion under Distribution Shift — 評価 2.5。locomotion の RL policy を world model の予測で STL (信号時相論理) 監視する。ensemble disagreement が信頼できないという点は 2611.02699 と同系統だが、Ant / HalfCheetah の simulation のみ
- 2611.02174: Beyond Unit-Circle Eigenvalues: Invariant Bases for Stable State Space Dynamics — 評価 3.0。diagonal SSM に保存則を構造として組み込む。物理 simulation 向けで、運転への接点は間接的
- 2611.00859: Wave Forcing: Towards Speed-of-Light Streaming Video Generation — 評価 3.0 (sns_wildcard, hf 100)。Wave Forcing: streaming 動画生成を pipeline 並列で実時間にする co-design。学びの価値はあるが、総数の上限 6 に入らず見送り。World model の実時間化の参考として次点
- 2611.03126: CUA-Master: Scaling Computer-use Agents through Open-World Recursive Improvements — 評価 1.5 (sns_wildcard, hf 90)。CUA-Master: computer-use agent の data flywheel。3 プロジェクトに接点なし
- 2611.03178: CoworkOS:Scaling Agent Coworkers for Real-world Automation — 評価 1.5 (sns_wildcard, hf 85)。CoworkOS: 長期作業向けの agent harness。3 プロジェクトに接点なし

## 次の空き日に繰り越せる次点 (評価 3.5 以上)

2611.02782 (4.0, History Forcing) / 2611.02777 (4.0, REPAIR) / 2611.03633 (3.5, Muon-AdamW) / 2611.03229 (3.5, CL3DOD) / 2611.03103 (3.5, VLALagBench) / 2611.02699 (3.5, RWM の不確実性) / 2611.02497 (3.5, RoboColosseum) / 2611.02284 (3.5, SVD-Prune)。4.0 の 2 本は quota 超過で外れた。
