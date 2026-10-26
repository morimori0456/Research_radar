# rejected 2026-10-27

採用 6 本 (P1 2 / P2 2 / P3 2、max_deep_per_day の上限どおり) 以外の記録。評価は topics.yaml の relevance_criteria に沿った 0-5 点。abstract を読んだ分はその根拠で、タイトルだけで判断した分は末尾の「タイトルのみで判断」にまとめた。

## candidates.json の sns_wildcard (3 件、全件不採用)

本流の候補が 6 枠すべて RSS 回収分で埋まり、上限に達したため wildcard 枠は使わなかった。

- 2610.31668: Reading, Writing, Sharing, and Interacting with the World through Video — video world model の survey (hf 211)。10-24 に rejected 済み (その時は hf 5)。全体像の把握には使えるが新手法ではない (評価 2.5)
- 2610.30932: UserArena: Benchmarking Interactive User Simulation for Long-Horizon Shopping Agents — e-commerce の user simulator の benchmark。On-Policy Trajectory Distillation (OPTD; student の生成した rollout に対し、軌道全体の意図から密な teacher 目標を与える蒸留) は P2 の蒸留と形は近いが、対象が購買行動で運転・基盤 model 適合への移し方が弱い (評価 2.5)
- 2610.31162: HiSTEVE 1.0: Harnessing Human-Interface VLA Agents for Open-World Games — Minecraft の VLA agent。10-24 に rejected 済み。ゲーム内の hierarchical VLA で、運転への接点は薄い (評価 1.5)

## 本流 (RSS 回収分): 惜しかったもの

quota (各トピック 2 本) で落ちたものを先に書く。

- 2610.31918: Beyond On-Policy vs. Off-Policy: At What Level Should LLM Agent Distillation Follow the Student? — LLM agent の蒸留で、「履歴を作る policy」と「action の token prefix を作る policy」の 2 段階の on-policy 度合いを分けて比べる controlled study。student の履歴 + teacher の action prefix が最強、という実用的な結論。P2 の quota 2 本が埋まったため落とした。対象が text agent (評価 4.0、P2 次点)
- 2610.32581: From Parameter Rebasin to Functional Transfer Across Heterogeneous Transformers (Ariadne) — fine-tuning の差分 (task vector) を、深さ・幅の違う Transformer へ、activation の変化を揃えて closed-form で移す training-free な方法。他機種への適合の観点では面白いが、評価が language model 側で P2 の quota に入らなかった (評価 3.5)
- 2610.32431: When to Stop Penalizing Actions? Martingale GRPO for VLA Reinforcement Learning — GRPO (Group Relative Policy Optimization; PPO の簡略版で RL 学習に使う) で、失敗 rollout の全 action に同じ penalty がかかる問題を、VLM が誤り区間を特定して打ち切ることで緩和する。VLA の RL 学習として良いが、操作 task で P3 の quota から外れた (評価 3.5)
- 2610.32977: UniAction: Unified Action Conditioning for World Models — force、camera、hand pose、robot pose など異なる action を、動画 model の位置空間に写して 1 つの world model で扱う。1 つの model が action 専用の expert を上回る。運転で複数種類の action 条件を持つ world model の参考になる (評価 3.5)
- 2610.32802: Frontier-OPD: Discovering the Edge of Agent Capability and Teaching Agents to Go Beyond — multi-turn agent の on-policy distillation で、student が少し助けがあれば続けられる「learning frontier」の場面を選んで teacher が介入する。text agent 向け (ALFWorld、WebShop、ScienceWorld)(評価 3.5)
- 2610.32512: Fast and Useful: Adapting Distilled Generators for Visual Learning — 蒸留済みの画像生成 model に low-rank update を足し、学習データ用の生成品質を上げる (ImageNet-1k の ResNet-50 top-1 が 8.4% → 34.2%)。分類器の学習データ生成の話で、運転・planner からは遠い (評価 3.5)

## 本流 (RSS 回収分): その他、abstract を読んで見送ったもの

- 2610.32177: Ψ-0.6: Adaptive Streams of Thought in a Unified Vision-Language World Model — 知覚・言語・幾何・simulation を 1 つの推論過程に混ぜる unified vision-language world model。空間推論の VQA が中心で、数値が abstract から取れず、運転に移す recipe が見えない (評価 3.0)
- 2610.31845: EgoForesight: Effectively Scaling Policy Learning with Noisy Egocentric Actions — 一人称動画から作った信頼度の低い action label の影響を下げ、EMA teacher の未来表現で蒸留する。VLA の学習データ拡張の話で、操作 task (評価 3.0)
- 2610.32657: DT-JEPA: Learning to Predict Future Representations for Decision-Making — Decision Transformer に JEPA を足す。offline RL の設定で、運転・VLA との接点が弱い (評価 3.0)
- 2610.32381: UniWorld: A Unified World Model for Real-Time Visual World Simulation — depth と見た目を 1 本の動画生成 model で扱い、実時間で生成する。評価が生成品質寄りで、運転 policy の学習・評価への接続が書かれていない (評価 3.0)
- 2610.32941: If at First You Don't Succeed, Backtrack: Lightweight Recovery for Frozen VLAs — 凍結 VLA の内部表現から失敗を予測し、直前の動きを巻き戻して再試行する。LIBERO の操作 task (評価 3.0)
- 2610.32208: Do VLAs Know They Will Fail? — OpenVLA の SAE (Sparse Autoencoder; 内部表現を疎な特徴に分解する手法) 表現から失敗を事前に予測する。診断の話で、設計・学習への示唆が弱い (評価 3.0)
- 2610.32501: DRIVE: Fine-tuning via Data Contribution- and Diversity-aware Weighting with Prior Regularization — 事前学習データが無いときの forgetting を、sample ごとの重み付けで抑える。P2 の適合に近いが、abstract に具体的な task と数値が出ず、再現できる recipe かの判断ができない (評価 3.0)
- 2610.32142: Rethinking LoRA Initialization for Robust Asymmetric Learning Rates — LoRA+ (A と B で learning rate を変える方法) の不安定さを初期化で抑える。実務では使えそうだが、改善幅が abstract から見えない (評価 3.0)
- 2610.32442: Learning Fine-Grained Visual Classification with Text as Privileged Information via Multimodal Distillation — 学習時だけ使える属性文を teacher に入れ、画像のみの student に蒸留する。細粒度分類で、蒸留の形は標準的 (評価 3.0)
- 2610.31899: Silence Is Not Assurance: When Production Lane Keeping Assist Does Not Warn, and What It Costs (CANDID-LKA) — 市販の車線維持支援 (LKA) の表示状態が、劣化した車線認識の 47% しか報告しないことを、CAN bus の信号と第三者の視覚系で調べた研究。ground truth なしの潜在クラスモデルによる評価の発想は P1 の評価に使えるが、対象が市販 ADAS の診断で planner ではない (評価 3.0)
- 2610.32719: Cross-Scenario Controller Parameter Transformation from Real-World Driving Data through Flow Matching — ACC (Adaptive Cruise Control; 前走車に追従する車間制御) の parameter を、少数の demonstration から別シナリオへ flow matching で写す。運転者個別化の話で、planner 評価とは遠い (評価 2.5)
- 2610.32612: DriveOSS: Dataset and Benchmark for 3D Anomaly Segmentation and Open-set Semantic Segmentation in Autonomous Driving — 未知物体の 3D segmentation の dataset。perception の benchmark で P1 の planner 評価ではない (評価 2.5)
- 2610.32573: Standing on Open Shoulders: Regional Fine-Tuning of Open-Weight Camera-Trap Models for UK Wildlife — 公開 weight を少量データ + 単一 GPU で地域適合した事例。少データの適合の実例だが、手法が標準的 (評価 2.5)
- 2610.32094: TTT in VLA Models: Exploring Training with Human Demonstrations — Test-Time Training を VLA に足したが、demonstration に基づく target 選択が改善しなかった、という否定的な結果の記録 (評価 2.5)
- 2610.32943: Knowledge Distillation across Item and Code Spaces for Parallel Generative Recommendation — 推薦の semantic ID への蒸留。蒸留の発想は参考になるが、推薦に閉じる (評価 2.5)
- 2610.32854: Singular Geometry of Low-Rank Adaptation — LoRA の学習複雑度を singular learning theory で扱う理論研究。実務で回せる recipe ではない (評価 2.0)
- 2610.32742: Adaptive World-Models for Anomaly Recognition (AWARE) — 外部 camera だけでクレーンの異常を検出する world model。運転と無関係 (評価 2.0)
- 2610.32888: When Human Corrections Travel: Safety in Federated VLA Adaptation — 実験結果の無い position paper (評価 2.0)

## タイトルのみで判断 (abstract は精読していない)

topics.yaml の keyword に一致したが、題名から対象が明らかに離れていたもの。評価はいずれも 2.5 以下。

- 圧縮・高速化 (2.0〜2.5): 2610.31897 (Learning Structured Sparsity for Large Models)、2610.32009 (GS-MoE)、2610.32878 (SVD-based LLM Compression)、2610.32492 (Accordion)、2610.32233 (TileShare)、2610.31911 (LazyFlash)、2610.32229 (MXFP4 での MoE LLM 学習。数値精度の話として 31859 と関連するが LLM 事前学習)、2610.32784、2610.32794
- ロボット操作・navigation の VLA / policy (1.5〜2.5): 2610.32312、2610.32271、2610.32093、2610.31779、2610.32909、2610.32348、2610.32554、2610.32596、2610.32633、2610.32225、2610.32676
- 運転周辺だが planner と無関係 (1.5〜2.0): 2610.32230 (BEV 3D 認識への物理的 camouflage 攻撃)、2610.31898 (交通動画の captioning)、2610.32666 (lane-keeping 制御)、2610.32365 (Graphs of Trajectory Bundles; 非線形 motion planning だが、対象が運転かは未確認で見送り)
- 医療・音声・推薦・物理・地理・科学計算など別分野 (1.0〜2.0): 上記の RSS 回収候補 175 件のうち、残り約 100 件
- 候補は RSS の new / cross 分で、replace は除外。過去ブリーフ・rejected に出た id も除外した

## 運用メモ

- candidates.json は wildcard 3 件のみ (generated_at 2026-10-26T18:00Z、月曜 fetch)。本流 0 件。RSS 5 本 (cs.LG / cs.CL / cs.CV / cs.RO / cs.AI) は全て HTTP 200、lastBuildDate は 2026-10-26 04:00Z (月曜 announce) で、月曜の本流 announce 分が candidates.json に入っていなかったことになる。回収した RSS 分は 175 件 (keyword 一致、重複除外後)。
- 回収スクリプトは /tmp/rss_1027/run.py。
