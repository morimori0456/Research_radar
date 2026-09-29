# 2026-09-30 不採用 60 件 + fetch 診断 + 上限で落ちた本流 104 件からの繰り越し

## §0 fetch 診断 (選別の前に実施)

- **arXiv API の HTTP 406 は 10 回連続で止まった。**今日の fetch は 3 トピックとも正常に返った (log に `[fetch]   error` なし)。`fetch_candidates.py` / `topics.yaml` の最新 commit は `313a283` のままで、**直ったのは server 側。こちらの修正ではない。**09-23〜09-29 の喪失累計 283 件は回収されていない。
- **代わりに欠陥#6 (`max_results=30`) が最大の律速として表に出た。**fm_distill の 30 件は 09-28 13:02〜17:59Z の **5 時間分**、next_arch の 30 件は 11:13〜17:59Z の **7 時間分**しかない。
- **同じ窓 (cutoff 09-27T18:00Z) で `max_results=200` にして同じクエリを 09-30 に再実行:** fm_distill **96 件**・next_arch **70 件**・planner_ai 3 件 (変化なし)。**上限 30 で窓内の 104 件が落ちた** (fm 66 / next 38)。窓の下端の最古は 09-27T18:43Z / 18:32Z で、今日は lookback ではなく件数上限だけで切られている。
- **落ちた 104 件には、今日の採用 6 件より関連度の高い論文が含まれていた** (§4)。「406 が止まった = 入力が戻った」と読んではいけない。平日は毎日この規模で上限に切られる。
- planner_ai の 3 件は 3 件とも運転と無関係 (欠陥#7)。運転の論文は今日も next_arch 側に来た。
- wildcard 3 件は既読 id (`briefs/` 全体の 1,601 id) と重複なし。

## §1 判断の分岐点

1. **RefineDrive (`2609.35078`) を next_arch → planner_ai に再分類して P1 枠で採用。**planner_ai の 3 件の最高が 2.5 で、09-12 の運用 (P1 基準で 4.0 以上の他トピック候補に限り P1 枠を使う) を適用した。P1 の 2 枠目は空けた (基準 4.0 に届く候補が他にない)。
2. **探索枠 (sns_wildcard 1/1) に DN-MOPD (`2609.35347`) を採った。**中身は P2 そのもので、fm_distill の keyword に当たらず wildcard 経路で届いた。真に分野外の候補は YuE2 (`2609.33757`) の 1 件だけで、探索枠の趣旨 (視野を広げる) に厳密に従うならこちらになる。**規則どおりに読めば採用は「YuE2 を採る 6 件」または「探索枠を空ける 5 件」。**学びの価値で DN-MOPD を優先した。
3. **fm_distill の 2 枠目は同点 4.0 の 3 本 (OG-OPD / R²-OPD / UNI2-h 蒸留) からの選択。**hf は全部 0 でタイブレークにならないため、内容で決めた (環境とやり取りする複数ターン設定が closed-loop 運転に近い OG-OPD)。

採用: P1 1/2 ・ P2 2/2 ・ P3 2/2 ・ wildcard 1/1 = **6/6**。

## §2 不採用 (candidates.json の 60 件)

スコアは主プロジェクトの 0-5。「次点」は quota で落としたもので、質が低かったわけではない。

## planner_ai

- 2609.35619: CollisionSplatting: Collision-Aware Motion Planning in 3DGS Scenes with Image-Conditioned Objectives and Adjustable Conservatism — P1 2.5 — 3DGS シーン上の衝突距離を GPU で高速に出して MPPI/RRT に入れる。manipulation・屋内移動が対象で運転の planner 評価には直結しない。collision cost を「保守性つまみ付きの確率的距離」にする発想だけメモ
- 2609.35130: CTP-FL: Common-Trajectory Gradient Prediction for Federated Learning — P1 0.5 — 連合学習の勾配推定。`trajectory` は最適化の経路の意味で keyword に誤一致 (欠陥#4)
- 2609.35000: Graph-Based Simultaneous Path and Foothold Planning for Multi-Limbed Intra-Vehicular Robots in Space Stations — P1 1.0 — 宇宙ステーション内の多脚ロボの足場計画。`motion planning` 一致だが運転と無関係 (欠陥#7: planner_ai の 3 件はすべて運転以外)

## fm_distill_finetune

- 2609.35767: Learning Native Reflection in Unified Models with Interleaved Reinforcement Learning — P2 2.5 — unified multimodal model の自己修正を RL で学ぶ (hf 35)。蒸留・適合ではなく RL post-training
- 2609.35765: Retrieving Biblical Intertextual References in Karen Blixen's Seven Gothic Tales — P2 0.5 — 文学テキストの聖書引用検索。`fine-tuning` 一致のみ
- 2609.35764: Reliability-Gated Fusion of Consumer Head and Foot IMUs for Lower-Body 3D Pose — P2 1.5 — 消費者 IMU の信頼度ゲート付き融合。チャネル単位の信頼度学習は面白いが P2 外
- 2609.35741: Shockingly Simple Self-retrospection Improves Agentic Models Without RL — P2 2.5 — agent が自分の経験の説明文だけで fine-tuning すると SWE-bench が伸びる (ROFT)。teacher なし・RL なしの自己改善で、蒸留 recipe ではない
- 2609.35614: EvE: An Alternate Optimizer to Adam — P2 1.0 — 差分進化 + Adam fallback の optimizer。HPO 向け
- 2609.35562: Revisiting Risky Tackle Detection with Vision Transformers — P2 0.5 — アメフトのタックル検出 ViViT の再現性報告
- 2609.35544: Less Sycophancy, Stronger Refusal? Lessons for AI Safety from Mechanistic Interpretability — P2 2.0 — SAE の特徴を fine-tuning 中に注入して sycophancy の獲得を抑える (CFI)。「学ばせたくない概念を fine-tuning 中に抑える」は忘却対策の変わり種だが安全性が主題
- 2609.35517: Reward-Aligned Reweighting for On-Policy Distillation — P2 4.0 — **次点 (同点 3 本の 1 つ)**。R²-OPD: OPD の token 重みを「結果と一致するか × teacher-student の不一致の大きさ」で再配分、数学 7 ベンチで +3.5/+2.4 pt。採用した OG-OPD (`2609.35319`) と同じ主張の数学推論版で、2 本並べると冗長。OG-OPD の方が環境とやり取りする複数ターン設定で運転に近いため落とした。**R2 で「結果で監督を配分する」例を 2 本引くときに併読**
- 2609.35505: An RL View of OPD: Least Square Policy Distillation for Sample-Efficient LLM Reasoning — P2 3.5 — LSPD: OPD の reverse KL を KL 正則化 RL と対応づけ、楽観的探索と off-policy 再利用を入れる。理論は綺麗だが、同日の `2609.35259` (KL の向きと学習率が支配的) を読んでからでないと利得の由来が判断できない
- 2609.35490: AHMAD: Adaptive Hybrid Multi-task Vision Learning with Assisted Distillation for Keypoint Detection — P2 2.5 — 5 タスクの汎用視覚 multitask + assisted distillation (AHMAD)。蒸留は keypoint 用の補助で、recipe として切り出しにくい
- 2609.35473: Handwritten Text Recognition Lives in the High-Pixel Variance Subspace — P2 2.0 — 手書き文字認識では画素復元型 SSL が勝つ理由を「識別信号が高分散方向にある」で説明。transfer の予測則としては面白いがドメインが遠い
- 2609.35464: W2Rep: Learning Visual Representations by Watching the World Change — P3 3.0 / P2 2.0 — W2Rep: 別時刻の単画像から masked feature を予測して「時間変化に強い単画像特徴」を学ぶ。world model の encoder 事前学習の候補だが運転での検証なし
- 2609.35429: Multi-Task Learning of Conditional Mean Operators: applications to dynamical systems and uncertainty quantification — P2 1.5 — 条件付き平均作用素の multi-task 学習。理論寄り
- 2609.35407: BiMoGen: Bidirectional Motion-Text Generation via Unified Masked Discrete Diffusion — P2 1.0 — motion-text 双方向生成 (masked discrete diffusion)
- 2609.35392: The Hidden Ratio in Adam: Stable Structure, Compression, and Sign Dynamics — P2 2.0 — Adam の二次モーメントを圧縮可能な状態に置き換える再パラメータ化。optimizer の memory 削減で、蒸留・適合ではない
- 2609.35348: From Data to Program: Fast & Direct Generative Program Inference from Empirical Data — P2 1.5 — データから生成プログラムを 1 回の forward で推定する事前学習モデル (PRODiGI)
- 2609.35295: Simulation-Based Inference for Plate Reverb System Identification — P2 0.5 — plate reverb のパラメータ推定 (SBI)
- 2609.35293: Decide, Don't Generate: Competitive Dimensional ABSA with Jev's Typed Decisions — P2 1.5 — 凍結モデルに型付きの質問をして CPU で係数 488 個を合わせるだけで ABSA 1 位。「backbone を触らず出力側の較正だけで適合する」例としてはメモ
- 2609.35291: Narrow Multimodal Fine-Tuning Can Induce Emergent Misalignment — P2 2.0 — 狭い multimodal fine-tuning で emergent misalignment が起きる。適合の副作用の警告としてのみ関係
- 2609.35290: EvoIn: Bridging Evolution and Internalization for Agent Fine-Tuning — P2 2.0 — agent の意思決定手順を harness で進化させ、その推論 trace をモデルに内部化する fine-tuning (EvoIn)。LLM agent 固有
- 2609.35289: Domain-adaptive Zero-Shot Image Enhancement via Locality-Constrained Diffusion Guidance — P2 2.0 — 事前学習済み diffusion で domain 間の画像強調を zero-shot で行う局所制約 guidance
- 2609.35269: eval-unlearn: Benchmarking unlearning in Text-to-Image Diffusion Models — P2 1.0 — T2I diffusion の unlearning ベンチマーク library
- 2609.35257: AIM-ZO: Activation-Informed Subspace Maintenance for Zeroth-Order LLM Fine-Tuning — P2 2.5 — ZO (zeroth-order; 逆伝播なしで順伝播の差分から勾配を推定する) fine-tuning の摂動部分空間を activation で維持 (AIM-ZO)。省メモリ適合として P2 の端だが、車載機での学習は現状の要件に無い
- 2609.35203: From UNI2-h to ConvNeXt-T: Lightweight Nuclei Instance Segmentation via Knowledge Distillation — P2 4.0 — **次点 (同点 3 本の 1 つ)**。病理の基盤モデル UNI2-h (ViT) を ConvNeXt-T (1/20) に output-level KD で蒸留、teacher の 98.8%・21.8× 高速。**「視覚 FM → 小さな CNN は出力の蒸留だけで足りる」という recipe の実例**で P2 の本題に最も近いが、手法の新規性が薄く abstract だけで要点が尽きる。視覚 FM の蒸留を始める段で baseline 設計の根拠として引く
- 2609.35201: From Normative Frameworks to Alignment Data: Constructing and Evaluating SFT and Preference Data — P2 1.0 — 規範的枠組みから SFT/選好データを作る方法論 (アラビア語・英語)
- 2609.35120: Style-Driven Data Synthesis and Degradation-Aware Enhancement for Ultrasound Image Restoration — P2 2.0 — 未整列の LQ/HQ 超音波画像から style transfer で整列ペアを合成して強調モデルを学ぶ。「対になっていないドメイン間データから擬似ペアを作る」型として P2 の domain gap 対策の端
- 2609.35090: Advancing Video-Text Pretraining with Multi-View Captions — P2 1.5 — 動画-テキスト事前学習に多視点キャプションを使う
- 2609.35083: Continuous Variational Synthesis — P2 0.5 — DNA 合成の variational synthesis

## next_arch

- 2609.35761: DexRoam: Learning Mobile Bimanual Dexterous Manipulation from Egocentric Whole-Body Human Demonstrations — P3 2.0 — 人の全身デモから移動 + 両手 dexterous 操作を学ぶ (DexRoam)。ロボット操作
- 2609.35709: Humanoid Loco-Manipulation With Discrete VLA Model — P3 3.0 — humanoid 全身の離散 VLA (Holo-M)、身体部位別の action tokenizer。高次元・異種の行動空間の tokenization は運転 VLA には過剰
- 2609.35704: DynaTokens: Teaching Dynamics to Camera-Controlled Video Models at Test Time — P3 3.0 — camera 制御付き video world model に scene 固有の学習可能 token を足して動的シーンを教える (DynaTokens)。test-time のシーン別学習で汎用 world model の設計とは別
- 2609.35664: MS-GLA: Multi-Scale Gated Linear Attention for Addressing Representational Bottlenecks via Multi-Temporal Resolution — P3 3.0 — Gated Linear Attention の head を複数の時間解像度に分ける (MS-GLA)。efficient transformer として正統だが言語モデリング中心
- 2609.35652: MM-ABC: Towards Generalist Mobile Manipulation via Seeing, Coordinating and Imagining — P3 2.5 — モバイルマニピュレーションの基盤モデル (MM-ABC)
- 2609.35575: F4R: Failure-Driven Recognition, Reconstruction, Refinement, and Redeployment for Continual Robot Self-Improvement — P3 3.0 — VLA の実機失敗を自動診断 → sim に再構成 → 学習 → 再配備 (F4R)。RefineDrive と同じ「失敗から学ぶ」系統で、運転版の RefineDrive を優先
- 2609.35545: Graph World Models for Constrained Epidemic Policy Planning — P3 2.0 — 疫学政策の graph world model。`world model` 一致だが分野が遠い
- 2609.35469: Rethinking Causal Action Tokenization with Conditional Annealing in Flow Matching — P3 3.5 — **次点**。CATok: flow matching を段階的に弱めて coarse-to-fine の因果的な action token を作る。自己回帰 VLA の action tokenizer として筋が良いが、運転の軌跡出力は連続回帰/拡散 head が主流で、tokenizer の選択は P3 の現段階の論点ではない
- 2609.35450: Uni-VLaT: Whole-Body Tactile Adaptation of VLA Policies for Humanoid Loco-Manipulation — P3 2.5 — humanoid の全身触覚を VLA に入れる (Uni-VLaT)
- 2609.35441: Riccati State Space Models: Non-iterative Parallelization for Nonlinear Sequence Modeling — P3 3.0 — Riccati 方程式で非線形なのに厳密に並列 scan できる SSM (RiccatiSSM)。state space model の構造として面白いが、実用規模の結果が abstract に無い
- 2609.35432: Self-Evolving Coding Agents: From Digital Programs to Physical-World Intelligence — P3 3.0 — VLA の代わりに coding agent が明示的な状態と手順を書いて実世界を扱う (hf 90)。立場表明寄りの survey 的論文で、実験の具体が薄い
- 2609.35427: LLMs are General Asynchronous Agents — P3 1.5 — 非同期に入力を受ける LLM agent の枠組み
- 2609.35375: From Pixel to Poses: Object-centric Tool Manipulation Learning from Human Demonstrations — P3 2.0 — 人のデモから物体中心で道具操作を学ぶ (P2P-T)
- 2609.35311: RoGSW4RLD: Feed-Forward 4D Gaussian Lifting for Robot World Model Rollouts — P3 3.0 — 多カメラの world model rollout を feed-forward で 4D Gaussian に持ち上げる (RoGSW4RLD)。多カメラ一貫性は運転の world model にも関係するがロボット操作の設定
- 2609.35249: Spatial Grafting: Grounding 3D Features for Flow-Matching Robot Policies — P3 3.0 — 凍結した 3D 再構成特徴をロボット基準の座標に結び付けて flow-matching action expert に cross-attention で入れる (Spatial Grafting)。凍結特徴の注入設計の参考
- 2609.35231: Zero-Shot Reactive Obstacle Avoidance for Generative Robot Policies — P3 3.0 / P1 3.5 — NUDGE: diffusion/flow policy の推論時に SDF (符号付き距離場; 各点から最も近い障害物までの距離) の勾配を注入して学習なしで障害物回避。ECO (`2609.31383`) と並ぶ「学習なしの後処理で安全性を足す」型だが、P1 の他トピック流用基準 4.0 に届かず。運転の拡散 planner に安全制約を後付けする段で読む
- 2609.35138: FlexiWorld: Learning and Planning via Flexible Action Chunks Across Multiple Time Scales — P3 3.5 — **次点**。FlexiWorld: JEPA world model に可変長 action chunk と混合 span の goal 監督、Student Forcing で exposure bias 対策。CGS と同じ latent planning の系統で、今日は loss 1 項で 2D toy にしやすい CGS を優先
- 2609.35052: OPIS: An Input-Grounded Benchmark for Multi-Object Memory in Video World Models — P3 3.5 / P1 3.0 — **次点**。OPIS: video world model が初期観測の物体を何個・同一性まで保持できるかの input-grounded ベンチマーク。物体数 20→40 超で Identity 40.2→23.1 に落ちる。closed-loop 評価用 world model の「他車を覚えているか」の評価に使える。world model を評価器として使う段で最初に読む
- 2609.35047: EMPIRIC: Experiment-Driven Learning of Residual World Models for Robot Planning — P3 3.0 — 物理エンジンに欠けた機構をコードで足す residual world model (EMPIRIC)。08-28 の Code World Model と同系統
- 2609.35039: Do Not Cut When Uncertain: Rejectable and Calibrated Decision Heads for VLA Policies in Robotic Harvesting — P3 2.5 / P1 2.5 — 凍結 VLA に「棄権できる・較正された」判定 head を後付け (RCDH)。収穫ロボ。運転の「判断保留」出力の発想としてのみメモ
- 2609.35032: JRDB-AVR: An Active Visual Reasoning Benchmark for Embodied Agents in Real-World Environments — P3 1.5 — 能動的視覚推論ベンチ (JRDB-AVR)
- 2609.35023: Proxy2World: Learning to Generate Worlds From Lightweight Proxies without Seeing Them — P3 2.5 — 簡易 proxy からシーン映像を生成する制御可能 world model (Proxy2World)。コンテンツ制作寄り
- 2609.35003: Learning to Act under Visual Interruptions with Vision-Language-Action Models — P3 3.0 / P1 3.0 — カメラ途絶下の VLA を評価する MAIL-Bench。センサ欠落の closed-loop 評価は P1 の頑健性評価と同型だがロボット操作
- 2609.34982: ActionUNet: Improving Robustness of VLA Models with Efficient Multi-scale Fine-tuning — P3 2.5 — VLA に軽量 temporal U-Net を足す multi-scale fine-tuning (ActionUNet)
- 2609.34968: RoboFL: Federated Expert Assembly for World Action Models — P3 2.5 / P2 2.5 — world action model の LoRA adapter を連合学習で組み立てる (RoboFL)
- 2609.34944: Adjoint Guidance Flow: Amortized Critic Guidance for VLA Policies — P3 3.0 — flow VLA の critic guidance を最適制御の costate として軽量 network に償却 (AGF)。理論的に綺麗だが操作タスク
- 2609.34911: Don't Throw Away the Tail: Action Upcycling for Policy Acceleration — P3 3.0 / P1 3.0 — Action Upcycling: chunk で出した行動の捨てていた後半を、速度が滑らかな間は再利用して policy 呼び出しを 1.2〜1.7× 減らす (学習なし)。運転の planner の再計画周期の議論にそのまま移るが、今日は 4.0 に届かず

## sns_wildcard

- 2609.29233: Post-Training Leaves Behavioral Shadows on Unrelated Decisions — wildcard / P2 3.5 (hf 205) — ATD: teacher が「祖先モデルがほぼ五分五分の 2 語」のどちらを選ぶかだけを 5,664 件学ばせると HumanEval+ +5.34 pt。**蒸留データに「タスクと無関係な形で能力が漏れる」という現象**で、蒸留データの管理の観点で重要だが、recipe としては使えない。探索枠は 1 件で、実務に直結する DN-MOPD を優先
- 2609.33757: YuE2: Unifying Symbolic and Audio Music Generation at Frontier Quality — wildcard / P3 2.0 (hf 194) — YuE2: 楽譜 (記号) で計画してから音声を生成する統一モデル。「読める中間計画を挟むと品質が上がる (49.3% vs 34.6%)」は VLA の言語 plan と同型の証拠。**本日唯一の真の分野外候補**で、探索枠の本来の趣旨ならこちらだが、学びの価値 (中間計画の効果という既知の論点の別分野での再確認) で DN-MOPD に劣ると判断

## §3 前日までの未読の繰り越し (まだブリーフなし)

- `2609.30818` Evaluation Is All You Need for Multi-Modal Autonomous Driving (P1) — 09-29 TOP3 の 1 位。候補の中に良い軌跡があるのに選択で間違える
- `2609.31383` ECO: Endpoint-Constrained Trajectory Optimization (P1・P3) — 09-29 TOP3 の 2 位。今日の NUDGE (`2609.35231`) と同じ「学習なしの後処理」型
- `2609.28931` HelloWorld (P3) — **5 日連続で未読**

## §4 上限 30 で落ちた本流 104 件のうち、今日の採用と同等以上の 6 件 (ブリーフなし・手動で開く)

`max_results=200` の再実行 (§0) で拾った。candidates.json には無いので今日の採点対象外だが、abstract ベースの暫定スコアを付ける。

- **`2609.34085` AD-E2E-JEPA: A Joint-Embedding Predictive Architecture For End-to-End Autonomous Driving — P3 4.5 / P1 4.0。**既存の JEPA world model (LeWM / DINO-WM / JEPA-WM) を E2E 運転で、**policy を学習せずに「正解の未来観測を goal にした zero-shot planning」で比べ、world model の質を policy から切り離して評価**。「運転で正確だが重い」か「軽いが planning に足りない」かの二択だと示し、projector で planning 用 patch を 16 分の 1・次元を 4 分の 1 にして 100 倍速。**今日採用した CGS と同じ LeWM を baseline に使っており、2 本で「latent world model で運転を planning できるか」の評価と改善が揃う。今日いちばん惜しい 1 本**
- **`2609.34106` SpecMatch: Spectrum-Balanced Feature Matching — P2 4.5。**視覚基盤モデルの feature 蒸留で、L2 の feature matching は teacher 表現の分散の大きい方向ばかり再現し、分散の小さい (しかしタスクに効く) 方向を学び残す、と指摘。補正する loss を提案。**P2 の「新しい loss・視覚 FM の蒸留」の直球**。FuseReg (09-29) の層選択と並べて読む
- **`2609.34489` When Less Data Favors Smaller Teachers — P2 4.5。**データが少ないと小さい teacher の方が良い。原因をクラスの順位関係 (relational ordering) と確率の大きさ (score geometry) に分解し、予算に合った難しさ・多様な関係信号のサンプルを選ぶ DVA を提案。**capacity gap (teacher と student の大きさの差が蒸留を難しくする問題) 対策の高優先に当たる**
- `2609.33854` ReDrive: Shaping Representations with World Modeling for End-to-End Driving — P3 4.0。未来の表現を予測する world modeling で planning 向け特徴を作り、推論時は予測モジュールを使わない 3 段の学習
- `2609.34684` Natural State-Prediction Accuracy can Hide Weak Controlled Responsiveness in VLA Readouts — P1 4.0 / P3 3.5。VLA の内部表現から状態を「当てられる」ことと、状態を変えたときに予測が「追従する」ことは別、と分離して評価する枠組み。open-loop 精度と制御への応答性のずれは P1 の評価設計と同型
- `2609.34387` CAR-VLA — P3 3.5。場面の複雑さと危険度で運転 VLA の推論の深さと形 (直感 / 熟考 / 反射) を切り替える

他に on-policy distillation 系が 6 本 (`2609.34838` DivOPD / `2609.34036` UOPD / `2609.35058` TIDE / `2609.34009` Fisher-Informed Recalibration / `2609.34082` K-OPSD / `2609.33838` ChemOPD)。**candidates.json 内の 5 本 (R²-OPD / LSPD / OG-OPD / On-or-Off-Policy / DN-MOPD) と合わせて 1 日 11 本。**うち OG-OPD・R²-OPD・DivOPD・UOPD の 4 本は「どのターン (token) に teacher の監督を当てるか」を選ぶ手法。
