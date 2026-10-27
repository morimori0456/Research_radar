# rejected 2026-10-28

採用 6 本 (P1 2 / P2 2 / P3 2、max_deep_per_day の上限どおり) 以外の記録。candidates.json は 54 件 (本流 51 + sns_wildcard 3、generated_at 2026-10-27T18:00Z)。評価は topics.yaml の relevance_criteria に沿った 0-5 点で、全件 abstract の冒頭を読んだ上での判断。過去ブリーフ・rejected との id 重複は 2610.31668 の 1 件だけだった (id は `v1` を外して照合)。

## sns_wildcard (3 件、全件不採用)

本流に評価 4 以上が十分あり、上限 6 本が埋まったため wildcard 枠は使わなかった。

- 2610.33568: Trajectory2Gym: Decision-Grounded Compositional Interaction Synthesis for Tool-Use Agents (hf 330) — tool-use agent の学習データについて、成功した軌跡でも「観測と action の依存関係の網羅」と「各 action が agent に見える履歴で正当化されること」が足りなければ supervision として弱い、という指摘と合成法。data 設計の考え方は蒸留・fine-tuning の data 作りに通じるが、対象が text の tool-use agent で、運転・基盤 model 適合へ移す recipe が見えない (評価 2.5、wildcard 内では次点)
- 2610.31668: Reading, Writing, Sharing, and Interacting with the World through Video (hf 285) — 10-24 と 10-27 に rejected 済み。video world model の survey (評価 2.5)
- 2610.34662: StreamVibe: Proactive Video Agents for Evolving User Intent (hf 235) — 動画ストリームを見ながら、暗黙のユーザー意図に先回りして応答する VLM agent と benchmark。運転との接点は薄い (評価 1.5)

## 惜しかったもの (quota または上限で落ちたもの)

- 2610.35636: Adapt for Planning, Not just Prediction: Optimistic Test-Time World Model Adaptation (OpTTA) — 凍結した latent world model を deployment 中に更新する test-time adaptation (TTA) で、prediction loss だけでなく planner の goal-reaching cost も最小化する。成功率の向上が +13.5 点で、prediction-only (AdaJEPA) の +6.9 点の約 2 倍。P3 の world model と P2 の適合の両方に当たり、P3 の 3 本目だった。manipulation / navigation の JEPA で運転は未検証。P3 の quota 2 本が埋まったため落とした (評価 4.0)
- 2610.34717: VLA-HWBench: Where the Time Goes When VLA Models Run on Edge Hardware — 18 個の open VLA を Jetson AGX Thor と AMD Ryzen AI Max+ PRO 395 で測り、推論を 7 stage に分解。latency は model size より action 生成の方式で決まり (Jetson で 82 倍の差)、少ない flow-matching step で長い action chunk を出す型が制御に間に合う。kernel fusion + 4-bit で π0.5 / GR00T N1.7 が torch.compile 比 2.6-2.9 倍。architecture の設計・学習の話ではなく配備の測定なので P3 の基準からは外れるが、Jetson Thor 上の実測として手元の検証環境に直接役立つ (評価 3.5、次点)
- 2610.34756: Mechanistic Insights into LoRA: Layer Sparsity for Adaptive Fine-Tuning via Path Patching (Adaptive-LoRA) — LoRA の効果は layer ごとに偏り、重要な layer は task ごとに違う。frozen-base zero-ablation で task 固有の layer を選ぶと、30% の layer で全 layer LoRA を上回り、adapter parameter が 3.5 分の 1 (Qwen2.5-1.5B、推論 11 task)。PEFT の効率化で使える recipe だが、language model 側の結果で運転ドメインとの接点が弱く、P2 の 2 本には入らなかった (評価 3.5)
- 2610.35846: Preserve to Expand: Source-Aware Adaptation and Model Merging for Multilingual LLM-Based ASR — 新しい言語を足すとき、source 言語データを再利用せずに元の性能を保つための adaptation と model merging の比較。「新 domain を足しつつ旧 domain を保つ」点は P2 の関心に近いが、音声認識の connector に閉じる (評価 3.0)
- 2610.35670: Continuous-Time Safe Planning and Control for Agile Quadrupeds — Bernstein polynomial (凸包の性質を使って、軌道全体の衝突回避と入力制約を保証できる多項式表現) で、四脚ロボットの軌道を連続時間で safe にする。運転の planner の制約処理に読み替えられるが、動力学が全く別で、評価の知見ではない (評価 3.0)
- 2610.35385: EmbodiedLab: Benchmarking Embodied Agents That Act to Know — 物理法則の発見などで、環境に働きかけて情報を得る agent の benchmark。planner 評価というより embodied AI の評価で、運転から遠い (評価 2.5)

## 本流: abstract を読んで見送ったもの

### planner_ai として届いたもの
- 2610.35851: Nonprehensile Robotic Catching Using Virtual Constraints — 物体を掴まずに受け止める制御。manipulator の話 (評価 1.5)
- 2610.35687: TrySee: Modular Perception-Enhanced VLM Grounding for Closed-Loop Robot Task Planning in Specialized Domains — VLM に専門 domain の perception module を足す task planning。ロボットの task 計画で運転 planner ではない (評価 2.0)
- 2610.35289: Reward-Guided RRT* for Budgeted Task and Motion Planning — 移動距離の予算内で報酬の高い地点を巡る sampling-based planning。古典 planning の拡張で、運転 planner の評価に使えない (評価 2.0)

### fm_distill_finetune として届いたもの
- 2610.35374 以外で運転に近いもの:
  - 2610.34993: Reason or Recite: Complementary Specialists with an LLM Judge for Traffic Anomaly Reasoning — 交通異常の動画理解で、正確な推論と参照文への文体の一致が逆向きに働くため specialist を 2 つ使い、LLM judge で選ぶ。planner と無関係の video QA (評価 2.5)
  - 2610.35070: Joint Dynamic Lane Reversal and Variable Speed Limit Control: A Graphormer-Based Approach — 道路網全体の車線方向と速度制限の制御。交通管制で、自車の planner ではない (評価 1.5)
- 蒸留・圧縮・適合に近いが、対象か内容が合わなかったもの:
  - 2610.35175: DAC-Loop: Distillation-Aware Compression for Remote Sensing CNN — 蒸留した student をどこまで圧縮できるかの手法。衛星画像の小型 CNN で、蒸留後の圧縮という観点は参考になるが、数値が abstract から取れない (評価 3.0)
  - 2610.34904: Accuracy and efficiency of compact foundation models for surface-water mapping during floods — Prithvi-EO-2.0-Tiny を fine-tuning / frozen / 乱数初期化で比較し、データ量を変えて効果を測った評価。少データ適合の評価の設計は参考になるが、洪水の水域 mapping で結論が domain 固有 (評価 3.0)
  - 2610.34886: ThinkBit: Search Codewords, Recalibrate Scales, Select by Reasoning — reasoning model を 2 bit (scalar) に量子化し、推論の質を保つ。LLM の量子化で、運転と離れる (評価 2.5)
  - 2610.35457: Prior Predictive Matching for Bayesian LoRA — Bayesian LoRA の prior を fine-tuning 前に closed-form で決める。不確実性推定の話で P2 の recipe からは遠い (評価 2.5)
  - 2610.34589: HARP-LoRA: Hierarchy-Conditioned Rank Projection for Low-Rank Adaptation in Scientific Table Understanding — 薬物動態の表の理解向けの LoRA (評価 2.0)
  - 2610.35132: Domain-Adapted Latent Diffusion Models for CT-to-PET Image Translation — CT から PET への変換のための domain 適合 (評価 2.0)
  - 2610.35396: Toward Clinical Translation of Deep Learning-Based Intracranial Super-Resolution 4D Flow MRI Using Multi-Cohort Transfer Learning — 合成データでの事前学習 + cohort をまたぐ transfer。医療画像 (評価 2.0)
  - 2610.35560: Multi-Fidelity Training Reshapes Uncertainty Decomposition in Atomistic Models — 低精度データの事前学習 → 高精度データでの fine-tuning が不確実性に与える影響。原子 model (評価 2.0)
  - 2610.35314: Beyond Wasserstein Proximity: Finding Better Transfer Sources — 転移元 domain の選び方で、「近い」より「広い」source が良い場合があるという理論と暗号資産の volatility 予測の実験。source 選択の考え方は参考になるが、時系列予測が対象 (評価 2.5)
  - 2610.35491: S²-RL: Sample-Set Dual Reinforcement Learning for Generative Semantic Segmentation Dataset Distillation — semantic segmentation の dataset distillation (少数の合成 sample に data の情報を凝縮する)。model の蒸留ではなく data の蒸留 (評価 2.5)
  - 2610.35113: UTA: Universal Training Adaptive Learning Rate Decay — Adam 系 optimizer 向けの learning rate decay。汎用の学習技術で、主題とのつながりは弱い (評価 2.0)
  - 2610.35246: NOMAD-EEG: Native Omni-Montage Adaptive Diffusion — 電極数に依らない EEG の foundation model (評価 1.5)
  - 2610.34845: PosePlaner: Denoising Any Feed-Forward Pose Predictor from Pairwise Planar Geometry — VGGT などの feed-forward pose predictor を後処理で改善する。3D 再構成で、fine-tuning の話ではない (評価 2.5)
- 評価・agent・言語系で別分野:
  - 2610.35823: Back to Basics: A Skill-Centric Approach to Generalist Web Agents (MiniWeb) — web agent の skill 別診断 (評価 2.0)
  - 2610.35817: Pretraining Knows What, Simulation Teaches How (ZAP) — 27B VLM を simulation 上の SFT と GRPO で robot に使う recipe。zero-real (実機データ無し) の適合で P2 の観点に近いが、操作 task で運転への移し方が見えない (評価 3.0)
  - 2610.35743: SEMA-Auto — jailbreak 攻撃 (評価 1.0)
  - 2610.35497: When Fine-Grained Credit Assignment Helps and Hurts — 動画編集 task での multimodal agent の RL (評価 2.0)
  - 2610.35472: Amplify, Locate, Estimate (ALE) on Rare-Failure Rates of Fine-Tuned LLMs — safety fine-tuning 後の稀な失敗率の推定。稀な失敗の推定は P1 の評価と形が似るが、LLM の安全性が対象 (評価 2.5)
  - 2610.35426: Intent-Preserving Adversarial User Simulation for Multi-Turn Agent Evaluation (StressSim) — 敵対的な user simulator での agent 評価 (評価 2.0)
  - 2610.35295: Did the Model Use That? Counterfactual Training Boosts Self-Attribution in Language Models — LM の自己帰属 (評価 1.5)
  - 2610.35114: Quality over Quantity: Rethinking Data and Model Assumptions for Bengali Coreference Resolution (評価 1.5)
  - 2610.35029: Synthetic Child-Adult Interactions Are Not Developmentally Plausible (評価 1.0)
  - 2610.34626: Entity Matching using Decision Models (評価 1.0)

### next_arch として届いたもの
- 2610.35832: Profiling a Frontier Agent with EBench — 大規模 MLLM を harness 経由で robot に使い、VLA と WAM と比べる評価 report。manipulation (評価 2.5)
- 2610.35626: Robot-Aligned 3D Gaussian Splatting for Precise Reaching with Wrist-Camera VLA Policies — 電子廃棄物の分解向けの data 収集。VLA の学習 data 作りだが manipulation (評価 2.5)
- 2610.35529: WorldPager: Zero-Stall Tiered Memory for Long-Horizon World Models on a Single Consumer GPU — 対話型 world model の KV memory を host memory と SSD に階層化し、1 台の RTX 4090 で長時間動かす。系の工夫で、architecture の設計・学習の示唆は薄い (評価 3.0)
- 2610.35252: Labference: Benchmarking the Reasoning-Action Connection in Robotic Laboratories — 実験室ロボットの benchmark (評価 1.5)
- 2610.35010: JevVLA: Jev-Inspired Energy-Based Adaptation for Vision-Language-Action Policies — 事前学習済みの VLA に energy-based な軽い adaptation を足し、離散選択と連続 action chunk の両方を改善する。VLA の適合 (P2 / P3 の両方に近い) だが、pick-and-place の評価で、abstract に数値が無い (評価 3.0)
- 2610.34879: LayoutMamba: Efficient Document Layout Analysis with Hybrid Mamba-Transformer Networks — 文書 layout の hybrid Mamba (state space model の一種) - Transformer。architecture の組み合わせとして面白いが、document 領域 (評価 2.5)
- 2610.34797: TimeWorld: Towards Action-Conditioned Multimodal World Models for Time Series Forecasting — 時系列予測の world model (評価 2.0)
- 2610.34650: Dream to Assist: Intent-Conditioned World Models for Shared Vehicle Control — 人の意図を推定する world model (recurrent state-space model) で、運転支援の shared control を学習する。車の制御だが、人と補助 agent の協調が主題で E2E driving の architecture ではない (評価 3.0)
- 2610.34649: RobotAgentBench: Towards Open-world Robot Autonomy — robot agent の benchmark (評価 2.0)
- 2610.34564: FlockWorld: Toward Population-Scale Multi-Agent Video World Models through Artificial Life Simulation — 多数 agent の video world model の研究環境 (Boids)。運転の多数の他車に通じる発想はあるが、人工生命の simulation 上の予備的な設定 (評価 2.5)
- 2610.34519: TRIAGE: Efficient Vision-Language-Action Inference Needs Both Reuse and Pruning — 視覚 token の再利用と刈り込みの両方で VLA の prefill latency を下げる、training-free な加速。組み込み board 向けで 34717 と合わせて配備の観点では有用だが、manipulation 用で数値が abstract から取れない (評価 3.0)

## 運用メモ

- 本流 51 件は 3 トピックに偏っており、fm_distill_finetune が 30 件で fetch の max_results (30) の天井に当たっている可能性が高い (件数がちょうど 30)。天井で落ちた論文があるかは、この日は RSS を取っていないため確認していない。
- 10-27 は candidates.json に本流が無く RSS から採点した。今日は本流が届いたので RSS は使っていない。
