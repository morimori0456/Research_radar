# rejected 2026-10-29

採用 6 本 (P1 2 / P2 2 / P3 2、max_deep_per_day の上限どおり) 以外の記録。candidates.json は 58 件 (本流 55 + sns_wildcard 3、generated_at 2026-10-28T18:00Z)。評価は topics.yaml の relevance_criteria に沿った 0-5 点。主要な候補は abstract 全文、それ以外は冒頭を読んだ上での判断。過去ブリーフ・rejected との id 重複は 2610.33568 の 1 件だけだった (id は `v1` を外して照合)。

## sns_wildcard (3 件、全件不採用)

本流に評価 4 以上が十分あり、上限 6 本が埋まったため wildcard 枠は使わなかった。

- 2610.33568: Trajectory2Gym: Decision-Grounded Compositional Interaction Synthesis for Tool-Use Agents (hf 360) — 10-28 に rejected 済みで再来 (評価 2.5)。tool-use agent の学習データ設計の話で、運転・基盤 model 適合に移す recipe が見えない
- 2610.34283: ChronoReplay: One Answer Interface Is Not Enough for Streaming Spatial Intelligence (hf 315) — spatial VLM の post-training が 1 つの回答形式 (例: 左右の関係) に偏ると、別の形式 (距離の推定) に転移しにくい、という指摘。問題設定は面白いが、運転への接続は薄い (評価 2.5)
- 2610.36077: The Trinity: Capability-Driven Recursive Self-Improvement for Multimodal Agents (hf 310) — 環境と harness (agent の足場) を自動で作り、multimodal agent が自己改善する枠組み。agent 基盤の話で P1-P3 から遠い (評価 2.0)

## 惜しかったもの (quota または上限で落ちたもの)

- 2610.37381: PDRVLA: A Vision-Language-Action Model with Physical Dynamics Representations (hf 135) — VLA が物理の動きを理解できるよう、軽量な Physical Dynamics Module が視覚・言語特徴から physical token を取り出す。未来の RGB・depth・optical flow (画素の動き) の特徴を直接予測し、凍結した video world model で補助的に監督する。動画の生成が推論に入らないので latency が低く、LIBERO 99.3%、RoboTwin 2.0 93.6% など。P3 の VLA × world model に当たり、P3 の 3 本目だった。同じ「動画を生成せず、将来の特徴を予測して VLA を強くする」方針は、採用した 2610.37219 (JAM) の方が切り分けが明確で、この話題は JAM から読むのが先 (評価 4.0、次点)
- 2610.37666: ThinkWorld: World Imagination Reinforces Chain-of-Dynamics Reasoning (hf 45) — 行動の思考を Chain-of-Dynamics (離散 motion token の列) で表し、予測した未来が観測と合う CoD を強化学習で強める。行動ラベルの無い人間の動画から、direct な supervision が取れる。manipulation の cross-embodiment 転移の話で、運転への接続は遠い (評価 3.5)
- 2610.37588: Understanding the limits of latent world models — world model を faithful (環境の遷移と latent の dynamics が equivariant) かどうかで測る latent rollout consistency (LRC) を提案し、調べた最新の latent world model のどれも環境の dynamics を忠実に学んでいない、と報告する。P3 の world model の評価の観点として面白いが、手法の提案ではなく診断で、abstract だけでは対象の model と環境が分からない (評価 3.5)
- 2610.36662: SWIM: Learning What Matters from Behaviors for JEPA World Models — JEPA (将来の embedding を予測する world model) の latent に simulator の状態を supervision として入れるとき、どの状態特徴が重要かを、offline の軌跡から inverse-dynamics model で学ぶ。状態特徴を人手で選ぶ・一様に重み付けする問題への対策。simulator の状態が前提で運転 log への移し方が難しい (評価 3.5)
- 2610.36959: Live-OPSD: On-Policy Self-Distillation for Proactive Streaming Large Video Models — 訓練時だけ使える hint (関連する証拠を示す) を付けた同じ model を teacher として、hint 無しの policy 自身の出力を監督する on-policy self-distillation。LiveProBench で最強の continued-SFT より 5.26 点高い。privileged 情報で蒸留する recipe として P2 に当たるが、30B の streaming video model が前提で、採用した 2610.37021 / 2610.36507 の方が運転に移しやすい (評価 3.5)
- 2610.37510: A note on data-efficient finetuning of vision foundation models — Attention / Convolution / Mamba 系の vision foundation model と、Visual Prompting (VP; 入力に学習可能な prompt を足す適合)・Linear Probing・Full Fine-tuning・LoRA の組合せを実測で整理し、VP に regularization を足す。実務の guideline としては有用だが新しい手法ではなく、運転ドメインでの検証もない (評価 3.5)
- 2610.37206: SimplexLoRA: Dynamic Rank Updating via Alternating Minimization with Simplex Projection — LoRA の rank を adapter ごとの重要度に応じて warm-up 中に決めて凍結する。parameter 数と推論 cost を増やさず、低 rank で最も効く。12 task で標準 LoRA 以上だが、NLP のみ (評価 3.5)
- 2610.36765: Evaluation-Guided Demonstration Refinement for Vision-Language-Action Policies (MetaFine 優勝) — π0.5 を task ごとに fine-tune し、局所評価で見つけた失敗 (把持・押し・挿入) に対して demonstration の修正と、policy が到達した状態からの expert の続きを足した。評価を instruction ごとに見て、1 つの改善が別の劣化を隠さないようにした。fine-tuning の運用の知見としては良いが、競技の report で手法の一般性は薄い (評価 3.5)

## 本流: abstract を読んで見送ったもの

### planner_ai として届いたもの
- 2610.36726: Learning Side-by-Side Navigation for Personal Mobility Vehicles from Human Drivers — 2 台の personal mobility vehicle が並走する social formation を、人間の運転から学ぶ。sampling-based MPC (Model Predictive Control; 先の動きを予測しながら制御入力を最適化する手法) の cooperative planning だが、低速の協調走行で運転 planner の評価に使えない (評価 2.5)

### fm_distill_finetune として届いたもの
- 2610.37157: What Survives Distillation? A Mechanistic Interpretability Study of GPT-2 and DistilGPT-2 — 蒸留後の student が teacher の circuit をどれだけ保つかを調べる。IOI circuit は完全に壊れ (35.2% 対 94.8%)、Greater-Than circuit は 87.7% 保たれる。aggregate の指標では circuit の崩壊が見えないという指摘は蒸留の検証に使えるが、GPT-2 の小さな実験で recipe ではない (評価 3.0)
- 2610.37068: Hierarchical Low-Rank Reparameterization for Parameter-Efficient fine-tuning — PEFT の trainable parameter を正方行列に並べ直して低 rank 分解を再帰的に重ね、parameter 数をほぼ 1 桁減らしても LoRA / DoRA に並ぶ。NLP のみ (評価 3.0)
- 2610.37481: Follow the Gradient: Tracing Safety Degradation Back to Training Data (SimpleLoRIF) — 無害に見える instruction data が fine-tuning で safety を崩す原因を、gradient embedding で特定する。LLM の safety の話 (評価 2.5)
- 2610.36755: Robust LLM Data Selection via Content-Invariant Gradient Attribution — 表面形式の偏りを避ける gradient 帰属による data 選択。LLM の instruction tuning 向け (評価 2.5)
- 2610.36734: CAMR: Compatibility-Aware Memory Replay for Continual Learning in LLMs — 新しい知識を足すとき、どの例を監督・再生するかを選ぶ continual learning。LLM 向け (評価 2.5)
- 2610.37393: Learning Quality-Controllable Robot Policies with Iterative Hindsight Relabeling — 実行速度や滑らかさのような品質の属性を条件にした robot policy。運転の速度制御には近いが、採用した 2610.36079 (CLAP-AD) の方が運転で直接検証されている (評価 3.0)
- 2610.37178: INTR++: INterpretable TRansformer with better Accuracy, Interpretability, and Adaptability — domain をまたぐ interpretable transformer。画像分類の解釈性が中心 (評価 2.5)
- 2610.37093: Learning to Look Beyond Screens: Transferable Visual Observation from GUI Grounding (LBS) — GUI grounding を spatial supervision にして、interface の外にも転移する観測行動を学ぶ。teacher 生成データで初期化する VLM だが GUI 中心 (評価 2.5)
- 2610.36877: GUI-JEPA — mobile GUI agent の行動を、token 生成でなく候補条件付きの JEPA latent で選んで高速化する。GUI 向け (評価 2.5)
- 2610.37375: Agent-Conditioned Routing: Diverse Reasoning Paths Within One Frozen Model — 凍結した sparse MoE (複数の expert を切り替える model) の routing で、推論の多様性を出す。LLM の reasoning (評価 2.0)
- 2610.37266: Watermark Basins: Black-Box Detection of Distilled LLMs — API 蒸留された student を watermark で検出する。蒸留の防御側の話で recipe にならない (評価 2.0)
- 2610.37085: On the Sparsity of Direct Preference Optimization: Weight Disentanglement in the NTK Regime — DPO の update が sparse になる理論的説明。理論で実務の recipe にならない (評価 2.0)
- 2610.36708: Conservative Dueling Bandits: Preference Learning under Baseline Constraints — 選好学習の bandit 理論 (評価 1.5)
- 2610.37001: Meta Models: Models that Model Learning — 過去の学習実験から、新しい学習 run の性能・学習曲線・hyperparameter を予測する。fine-tuning の実験計画には間接的に効くが、適合の recipe ではない (評価 2.5)
- 2610.36882: HPNAS-RL — 自動運転 RL 向けに NAS と HPO を進化的に同時探索する。運転 RL だが小規模な設定の探索で、評価も限定的 (評価 2.5)
- 2610.36809: Latent Visual Contrastive Reasoning with Multi-Branch Exploration — MLLM の視覚推論を latent 空間の複数 branch で行う (評価 2.0)
- 2610.36759: DocSkill — 多言語の文書 QA の agentic reasoning (評価 1.0)
- 2610.37265: REGLAT at ArGuard Shared Tasks — アラビア語の有害内容分類 (評価 1.0)
- 2610.37245: Aligning Large Language Models for Safety in African Languages: A Case Study of Hausa — Hausa 語の safety alignment (評価 1.5)
- 2610.37216: Zhengrong-Spatial-Aware 1.0 — 3D 認識 VQA の fine-tuning (HiSpatial-3B と Qwen3-VL の QLoRA) の実装報告。3D の空間理解の適合だが、報告書で手法の新しさが薄い (評価 2.0)
- 2610.37026: Interpretable Deep Learning Models for Breast Cancer Diagnosis Using Medical Imaging — 乳がんの画像診断 (評価 1.0)
- 2610.36978: Explicit Regional Representations For Video Quality Assessment — 動画品質評価 (評価 1.0)
- 2610.36911: Developing a Speech Language Model for Basque — バスク語の音声 language model (評価 1.5)
- 2610.36876: HoloRecon — 長いパノラマ列の incremental 3D 再構成 (評価 1.5)
- 2610.36868: Sample-and-Score: Surrogate-Guided Coordinated Spatial Reuse in IEEE 802.11 Networks — Wi-Fi の無線資源制御 (評価 0.5)

### next_arch として届いたもの
- 2610.37518: World Dreamer v5-lite — 複数 robot の共有 world state を持つ multi-robot world-action model。manipulation の多 robot 制御で運転への接点は薄い (評価 3.0)
- 2610.37091: GAWM: A Compact Latent World-Action Model for Multi-Task Robot Manipulation — 凍結した DINOv3 の latent で将来を予測する、100M parameter 未満の compact な WAM。軽量な点は車載に近いが、採用した 2610.37219 (JAM) と方針が重なり、JAM の方が切り分けが明確 (評価 3.0)
- 2610.36068: Rollback: Experience Backtracking in World Models for Policy Improvement — world model を過去の決定点まで巻き戻し、別の行動に分岐して結果を比べ、行動単位の supervision を作る。manipulation の policy 改善で、運転では world model の精度が前提 (評価 3.0)
- 2610.36791: RynnWorld-Latent — 異なる embodiment の動画を、3D に根ざした latent action で共通に扱う video world model (23 dataset、約 5.5 億 frame)。cross-embodiment だが manipulation 中心 (評価 3.0)
- 2610.37330: Tokens of Motion: Primitive Motion Learning for Human-Humanoid Skill Transfer (AFIL) — 成功のみの behavioral cloning は失敗で脆いので、policy 自身が作った失敗 rollout を negative guidance にする。VLA の頑健化だが humanoid / manipulation (評価 3.0)
- 2610.37215: Retrieve to Act: Motion Primitive Graph Retrieval for Robust VLA Execution (R2A) — OOD の視覚変化に対し、訓練 demonstration から作った motion primitive の graph を検索して補正する test-time の手法 (評価 3.0)
- 2610.37378: VLA-Stem: A Lightweight Safety Mechanism for VLA Models via RL — VLA を fine-tune せず、action chunk を motion reference に変えて、障害物回避を RL で後付けする。「後付けの安全層」は P1 に近いが、manipulation の障害物回避 (評価 3.0)
- 2610.36285: ASPEN — navigation VLA で、直前の command が続くかを予測して semantic reasoning の呼び出しを間引く。VLA の呼び出しが 9.5%、推論時間が 8.1% 減るだけで効果が小さい (評価 2.5)
- 2610.36420: SO-101 Bench — 低コスト arm 向けの simulation benchmark (評価 2.0)
- 2610.37437: Representing the Unseen: Rethinking Visual Imagination for Spatial Reasoning — 空間推論に RGB 以外の表現で world model が想像する話 (評価 2.5)
- 2610.37257: GameVerse — 分単位のゲームプレイ動画 dataset による長い horizon の interactive world model (評価 2.5)
- 2610.36729: Hy-Nomas: Towards Free-form Interactive World Generation (hf 104) — 8B の diffusion backbone による対話的な world 生成。生成型の video world model で、運転 planning への接続が見えない (評価 2.5)
- 2610.36371: BoxWorld — object の状態と規則を world engine が持ち、video generator は描画だけを担当する分離 (評価 2.5)
- 2610.37175: MLE-World — ML 実験の出力を実行せずに予測する world model (Qwen3.5-4B の fine-tune)。名前が world model だが agent の実験予測の話 (評価 1.5)
- 2610.36761: Making Self-Driving Laboratories Auditable — 実験室自動化の監査 framework。名前に self-driving が付くだけで運転と無関係 (評価 0.5)
