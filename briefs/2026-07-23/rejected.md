# 落選候補 — 2026-07-23

採用 6 件(P1×2・P2×2・P3×2、wildcard×0)。max_deep_per_day=6 に対し本枠だけで上限到達。
以下は落選 41 件と理由。「近い次点」は 🔶 で明示。

## P1 planner_ai
- 2607.18855v1: Pose-Parameterized Motion Planning and CBF-QP Self-Collision Filtering for a Long-Reach Drilling Boom — 産業用ドリルブームの self-collision 回避。手法(CBF-QP)は堅実だが対象がロボットアーム機構で、AD プランナー実装・評価に転用しづらい。relevance 低。

## P2 fm_distill_finetune
- 🔶 2607.18725v1: Find Before You Fine-Tune (FiT) — 「小型 LLM は fine-tune で parametric knowledge を毀損する、事前診断で無駄な適合を回避」という実務教訓は P2 に有用。quota=2 で ABOPD/PLT を優先し次点。近日読む価値あり。
- 🔶 2607.19270v1: GUIDED — GNN の spatial transferability 向け network-agnostic な特徴初期化。domain gap 克服 + parameter-efficient 転移という P2 観点に合致するが対象が交通量割当(traffic assignment)で AD 知覚/計画から遠く、次点。
- 🔶 2607.19064v1: Mage-Flow (hf=55) — 4B 級の効率的画像生成基盤モデル。few-step distillation + tokenizer/backbone/system co-design は蒸留 recipe として学びあり。ただし対象が image gen/edit で AD 直結度が低く次点。
- 🔶 2607.18773v1: Privileged Lesion-Context Relational Distillation — 訓練時のみマスクを使う privileged distillation。着想は ABOPD と同系だが医療画像特化で、privileged 蒸留の一般論は ABOPD で代表させた。
- 2607.18693v1: Rationale-Guided KD for Cross-Lingual Stance Detection — CoT rationale を compact student へ蒸留。recipe は一般的だが NLP stance 特化で AD 適用が薄い。
- 2607.19341v1: ExpertVerse — 専門家級推論のベンチマーク。評価データセットで手法/蒸留 recipe ではない。
- 2607.19339v1: OmniReasoner — long audio-video の native tool use 推論。マルチモーダル agent 寄りで蒸留/適合の中心ではない。
- 2607.19317v1: CircuitKIT — mechanistic interpretability のツールキット。解釈性研究で P2 の適合/蒸留と目的が異なる。
- 2607.19219v1: Beyond Score Prediction — エッセイ採点 + フィードバック生成(RL)。教育ドメイン特化。
- 2607.19181v1: Reasoning Before Translation — 法律機械翻訳の structured reasoning。ドメイン特化で汎用 recipe 薄い。
- 2607.19061v1: Now You See the Hate — 隠れヘイト画像検出の adaptive view retrieval。コンテンツモデレーション特化。
- 2607.19044v1: RLVR for Molecular Generation — 分子生成の verifiable reward RL。化学特化で AD 転用薄い。
- 2607.19033v1: Content is What Remains — 並行発話からの invariant speech tokenization。音声表現特化。
- 2607.18988v1: DobicVLM — 胸部 X 線レポート生成の臨床報酬整合。医療 VLM 特化。
- 2607.18960v1: SFGA — trustworthy 向け統計ゲーティング + escalation。信頼性 gating で蒸留/適合の中心でない。
- 2607.18958v1: Dual Adversarial Fine-tuning for VLM Robustness — VLM の敵対的頑健化。robustness 寄りで蒸留 recipe ではない。
- 2607.18934v1: Transcription Policy as Latent Variable (hf=4) — 逐語 ASR の可制御化。音声特化。
- 2607.18912v1: Multilingual ASR → Kenyan-Language — data-centric な低資源適合。着想はあるが ASR 特化。
- 2607.18845v1: NSMA — adaptive bitrate streaming の neuro-symbolic 整合。ネットワーク制御特化。
- 2607.18820v1: CASE — CoT faithfulness 向上の causal alignment。解釈性/整合寄りで AD 適用薄い。
- 2607.18789v1: Moving Alphabet — text-to-video の訓練データ統制研究。データ分析で手法薄い。
- 2607.18772v1: RF-Agent — RFIC 設計向け言語 agent。EDA ドメイン特化。
- 2607.18770v1: GLID — face-forgery 検出の盲点補修。偽造検出特化。
- 2607.18762v1: Weakly Supervised PET Content Retrieval — 医療画像検索特化。
- 2607.18756v1: RAGAL — 行政向けローカル RAG アシスタント。応用システムで新規手法薄い。
- 2607.18700v1: Decoupled Pipeline for PU Marine (proposal rerank + score fusion) — 海洋 positive-unlabeled 特化。
- 2607.18673v1: MissingBench-Verified — VLM が欠損物体を検出できない件の probing ベンチ。評価用で適合 recipe ではない。
- 2607.18639v1: Mark, Don't Erase — dual-use 知識の token inoculation。安全性/unlearning 特化。

## P3 next_arch
- 🔶 2607.18703v1: Generative World Renderer at Speed of Play (AlayaRenderer-Flash, hf=63) — physics engine の world state → RGB を few-step 蒸留で 0.56→31.5 FPS 実時間化。world model + 蒸留として魅力的な次点。quota=2 で ABot-World-0/Masked Visual Actions を優先。
- 🔶 2607.18709v1: RoboInter1.5 — 密な intermediate representation で embodied world modeling。データ/ベンチ規模が大きく設計参照価値あり。ただし manipulation 中心で AD 距離あり、次点。
- 🔶 2607.18589v1: Planning as Emergent Behavior in RL with Relational Hidden States — model-free RL から planning が創発する条件を relational hidden state に帰属。着想は面白いが grid 世界の分析研究で実装距離が遠い。
- 2607.18625v1: Norm or Direction? Decoding Vision Mambas — VMamba vs MambaOut の表現解析(SSM の必要性)。efficient backbone の知見だが解析中心で AD 直結薄い。
- 2607.18565v1: Integrity-Gated Eco-CACC — 信号交差点の協調運転で world model の整合を監視し制御権限を調整。AD 応用だが energy-optimal cruise 特化で next_arch の中核でない。
- 2607.19190v1: Agentic Real2Sim — VLA agent による physics-based world modeling。real2sim パイプラインで、world model 本体より構築 agent 寄り。
- 2607.19038v1: FilmWorld — 小説→映画の agentic cinematic world modeling。映像生成応用特化。
- 2607.19147v1: Incomplete Observations Boost Evolutionary Performance in Ocean Modeling — 海洋モデリングの進化計算。分野外。

## sns_wildcard(全件 dedup バグで再提示 = 実質選択不能)
- 2607.17977 (hf=180): RynnBrain 1.1 — **昨日 2026-07-22 にブリーフ済み**([[briefs/2026-07-22/2607.17977]])。重複再提示。
- 2607.17423 (hf=154): TimeLens2 — **昨日 2026-07-22 にブリーフ済み**。重複再提示。
- 2607.11683 (hf=136): RAGU — **2026-07-21 にブリーフ済み**。3 日連続で再提示。dedup 欠如が継続([[fetch-duplicate-candidates]])。
