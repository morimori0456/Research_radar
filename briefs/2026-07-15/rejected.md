# Rejected — 2026-07-15

## P1 (planner_ai)

- **2607.11340: CR-Solver: GPU-Accelerated Kinematics Solver for Tendon-driven Continuum Robots** — 1/5。"motion planning" キーワード一致だが、対象は tendon-driven continuum robot(腱駆動の連続体ロボット)の逆運動学・軌道最適化で、剛体前提を外した専用ソルバ。自動運転プランナーの実装・評価には接点がない。
- **2607.10960: Reinforcement Learning for Execution under Dynamic Fees in a Closed-Loop DEX Simulator** — 1/5。"closed-loop simulation" 一致だが実体は DeFi の AMM(自動マーケットメイカー)手数料下の執行を RL で学ぶ金融論文。closed-loop simulator の設計思想は一般論としては読めるが、planner 評価への適用経路がない。

## P2 (fm_distill_finetune) — 採用2件(UMoE 5/5, SAKD 4/5)、以下は quota 超過・低relevance で不採用

- **2607.11257: LaGuadia: Language-Guided Adaptive Distillation from Pathology Foundation Models** — 4/5。臨床言語で teacher 寄与を動的重み付けする multi-teacher 蒸留で、87M student が GigaPath/UNI 級に匹敵する capacity-gap 対策として優秀。quota=2 の最後の1枠を、より汎用(CIFAR/ImageNet、アーキ非依存)で recipe が移植しやすい SAKD に譲った。病理ドメイン特化な点がタイブレークで不利。
- **2607.11614: Extending LLM Context via Associative Recurrent Memory (ARMT)** — 4/5。continued pretraining + 合成長文脈 + curriculum の context 拡張 recipe で FLOPs 30%減。良質だが「蒸留/ドメイン適合」より long-context 化寄りで、P2 の中心テーマからは半歩外れる。
- **2607.11475: HyperSafe: Inference-Time Safety Recovery for Fine-Tuned Language Models** — 3/5。fine-tuning で劣化した安全性を、重み非改変・推論時の side network で回復。fine-tuning の副作用対策として着眼は良いが、P2 の「ドメイン適合の性能 recipe」とは目的が異なる。
- **2607.11720: Active Offline-to-Online RL** — 3/5。O2O-RL で限られたオンライン予算を policy 評価と fine-tuning に配分する active selection。fine-tuning 予算配分の視点は面白いが RL 前提でドメインが遠い。
- **2607.11886: SpectraReward (MLLM を training-free の reward model に)** — 3/5。生成画像から元プロンプトを復元する log-likelihood を報酬にする training-free reward。着想は鋭いが T2I 生成 RL 特化で P2 への適用経路が薄い。
- **2607.11862: Evidence-Backed Video QA** / **2607.11798: StoryTeller** / **2607.11581: CycleGRPO** / **2607.11732: GFR-SAM** / **2607.11199: DynEval** / **2607.11106: BEE** — 2-3/5。いずれも MLLM/VLM の grounding・評価・ツール利用の良作だが、蒸留 recipe / ドメイン適合という P2 の軸から外れる。
- **2607.11754: Higher-Order Cell Tracking Transformer** / **2607.11578: DiffEEG** / **2607.11509: CFR-Net** / **2607.11366: SSL multispectral UAV** / **2607.11257 以外の医療・地理系** — 2/5。ドメイン特化タスクで、fine-tuning が容易/少データ適合の観点はあるが対象ドメインが遠く、汎用 recipe としての一般化度が低い。
- **2607.11722: STEP(キャリアパス推薦)** / **2607.11515: Dzongkha 次単語予測** / **2607.11434: Han-Nom 翻訳 RLHF** / **2607.11215: Q-BridgeNet(手話翻訳)** / **2607.11341: In-Car Sign Language Corpus** / **2607.11163: UGP(多言語 ASR 継続学習)** / **2607.11030: MMRM(EC検索ランキング)** / **2607.10911: NL2SQL** / **2607.11276: 教科書監査 multi-agent** — 1-2/5。応用特化で P1-P3 への転用経路が乏しい。UGP の catastrophic forgetting 対策(継続学習)だけは P2 の「別ドメイン適合で既知を壊さない」観点に弱く触れるが、ASR 特化で優先度は低い。
- **2607.11843: Q-DIBA(QNN への backdoor 攻撃)** / **2607.11289: Backpropagation as a Nilpotent Linear System** — 1-2/5。前者は量子NNのセキュリティ、後者は逆伝播の作用素論的再定式化。理論的には面白いが実務適用が遠い。

## P3 (next_arch) — 採用2件(WALA 4/5, pointmaps 4/5)、以下は quota 超過で不採用

- **2607.11270: Lumo-2: Towards Predictive, Aligned, and Scalable Robot Learning** — 4/5。latent world-action model + 多段の modality pre-alignment + scaling 則/OOD 分析。世界モデル+表現幾何の一般原理として濃く、僅差。quota=2 のため、ラベルなし動画活用という運転データ戦略に直結する WALA と、ego 座標系ずれに直結する pointmaps を relevance 優先で採用。次点として要フォロー。
- **2607.11643: Xiaomi-Robotics-U0(38B world foundation model, hf_upvotes=2)** — 4/5。基盤 world model を embodied 生成に統一し、data engine としても機能、pi_0.5 の OOD 成功率を 36.9%→63.2%。driving のシミュ・データ生成に効きうるが規模が大きく、まず WALA/pointmaps の軽量な設計示唆を優先。
- **2607.11119: VIA: Visual Interface Agent for Robot Control(Fable 5 で 96.7-100%)** — 3/5。FM エージェントがブラウザ 3D UI 経由でロボットを zero-shot 制御。「あなたのコーディングエージェントは実はロボット制御エージェント」という主張は刺激的だが、アーキテクチャ設計というより agentic な運用フレームで、P3 の構造/学習の軸からは外れる。
- **2607.11689: From World Action Models to Embodied Brains(ロードマップ)** — 3/5。WAM→embodied brain の統合ロードマップ。概念整理として有用だがサーベイ的で、具体の設計・実験示唆は薄い。
- **2607.11673: ABot-3DWorld 0(汎用 3D world model)** — 3/5。text/image/video から探索可能な 3DGS 世界を生成。driving シミュレーションへの示唆はあるが、コンテンツ生成寄りで制御・予測との接続が弱い。
- **2607.11796: Selective State-Space Models の state 利用の厳密測定** — 3/5。Mamba 系の各 mode 利用を厳密に測る instrument と input-driven migration の発見。SSM の効率化・解釈に有用だが、driving アーキ設計への距離があり優先度は中。
- **2607.11560: CVPR 2026@AdvML Challenge(driving VLA への敵対的攻撃)** — 3/5。driving VLA のロバスト性評価の実践的リファレンス。防御設計の参考にはなるが新アーキ提案ではない。

## sns_wildcard (EXPLORE) — 採用1件(Direct-OPD 5/5, hf91)、以下は上限で不採用

- **2607.10383: ABot-N1(Visual Language Navigation 基盤モデル, hf79)** — 4/5。slow-fast アーキで CoT 推論器が pixel goal を出し、fast action expert が waypoint を生成。pixel-grounded anchor を統一インタフェースにする設計は P3 に学びがあるが、wildcard 枠は最大1件。蒸留手法で P2 にも直結する Direct-OPD を relevance 優先で選定(hf 91 > 79 のタイブレークも Direct-OPD)。
- **2607.10350: ABot-AgentOS(ロボット Agent OS + 生涯マルチモーダル記憶, hf67)** — 3/5。低レベル制御の上に推論・記憶・検証・ツール利用の runtime 層を置く。設計は野心的だが agentic な運用層で、P1-P3 の構造/学習への直接の適用が薄い。
