# 落選候補 — 2026-07-25

候補 39 件中、採用 6 件(P1×1・P2×2・P3×2・wildcard×1、max_deep_per_day=6 到達)。以下 33 件は落選。
🔶 = 惜しい次点(枠が空けば拾う価値あり)。

## 重複(パイプラインのバグ由来)
- 2607.19191: ABot-World-0 — **2026-07-23 にブリーフ済み**(当時 hf=148 → 本日 up=207 で再々浮上)。2026-07-24 も重複として落選済み。wildcard の dedup 欠落で 3 日連続再提示。[[fetch-duplicate-candidates]] 症状が継続。

## P3 next_arch(quota 2 は WorldWeaver / MoE VLA で充足)
- 🔶 2607.20653: PhysCoRe — 微分可能 MPM シミュ + residual 学習の hybrid world model。material-aware で不確実性駆動探索も持つ良球。deformable 物体寄りで driving から一歩遠く、今回は WorldWeaver/MoE VLA を優先。枠が空けば最優先で拾う。
- 🔶 2607.21588: AXIS — community-driven なロボット操作データエンジン + VLA 評価スイート。scaling 分析は有用だが、アーキ論でなくデータ基盤寄り。P3 の 2 枠はアーキ novelty を優先。

## P2 fm_distill_finetune(quota 2 は HyWorldVLA / Experience Distillation で充足)
- 🔶 2607.21351: How Many Bits Can an Adapter Write — LoRA 容量をビットで実測。attention より MLP に置くと約2倍書ける等、PEFT 設計の実務レバーが具体的。今回は distillation テーマを優先し次点。枠が空けば即採用級。
- 🔶 2607.21526: All-Weather Self-Supervised Depth — uncertainty-aware multi-teacher distillation + radar 融合、AD 全天候、コード公開。P2×AD の直球だが HyWorldVLA と AD が重複するため見送り。
- 🔶 2607.21080: Self-Output Fine-Tuning (SOFT) — autoregressive 天気予測の exposure bias/drift を自己出力で1ステップ較正。world model の rollout drift(P3)にも通じる転用性。ドメインが気象で今回は外す。
- 🔶 2607.21582: Scale Up Strategically — instruction factor bias を診断し under-grounded 因子へデータ再配分、半分のデモで汎化。sample-efficient 適合の good practice。robot manipulation 寄りで次点。
- 2607.21291: AdaDSF — 事前学習 LLM を再学習なしで depth-sparse 化(層の cosine 類似で token 保持率配分)。効率化として堅実だが coreテーマから外れ次点圏外。
- 2607.21076: C-PTQ — Fisher 重み付き channel-wise の PTQ(量子化)for MLLM。圧縮系だが今回の distill/adapt 主題と距離。
- 2607.20914: TRISHUL — federated PEFT の spectral 制御。堅実だが federated 前提でニッチ。
- 2607.21074: SpecTraL — federated LoRA の層別 global rank 発見。同上、federated 特化でニッチ。
- 2607.21546: UnDA — 医用画像の unpaired cross-modal distillation(OT + ProtoNCE)。手法は転用余地あるがドメイン特化。
- 2607.21356: Emergent Misalignment persona subspace — narrow fine-tune が既存 persona 部分空間を賦活。安全性の良い実測だが我々の適合レシピと直結せず。
- 2607.21069: CWE 予測の hierarchy-aware 学習信号 — GRPO が SFT を上回る知見は面白いがセキュリティ分類ドメイン特化。
- 2607.21090: Self-Explanation Faithfulness を RL 最適化 — 忠実性 metric を報酬化。解釈性寄りでコア外。
- 2607.21300: FAIRGET/FAUN — MLLM unlearning の公平性ベンチ。unlearning 主題でコア外。
- 2607.21111: TOUR — offline RL の trajectory-level unlearning ベンチ。同上 unlearning、コア外。
- 2607.20887: TwistedMerge — model merging の証明付き診断/棄権。理論寄りで実務適用が遠い。
- 2607.21366: HOPE — 学習表現を Hilbert 空間で解体する圧縮理論。proof-of-concept 段階。
- 2607.21403: JITAI-Twins — mobile health の diffusion デジタルツイン。手法は sim-before-deploy として一般性あるが医療介入ドメイン特化。
- 2607.21370: ASTRA-Net — 睡眠内視鏡セグメの anatomy-specific 転移。医用特化。
- 2607.21540: DONDO — アフリカ諸語 ASR base モデル群。annealed fine-tuning recipe は良いが音声・言語特化。
- 2607.21332: Chengdu Mandarin の forced alignment — 低資源音声、ブートストラップ pipeline。ドメイン特化。
- 2607.21570: MedGame — 医学教育のストーリーゲーム化 LLM。応用寄りでコア外。
- 2607.21290: 動画ゲーム状態の multi-task/転移学習 — 応用研究、コア外。
- 2607.21284: news-crawler-LM — HTML→構造化の小型長文脈モデル。応用特化。
- 2607.21137: assistive navigation の歩道/車道セグメ — スマホ配備制約は面白いが応用特化。
- 2607.21522: GS-Agent — 自然言語→物理シミュ 4D 世界を作る multi-agent。生成コンテンツ寄りで driving world model と距離。
- 2607.21498: Artificial Epanorthosis — LLM が古典修辞を過用する分析 + LoRA 緩和。言語学的で実務直結せず。
- 2607.20909: RadioTrace — 無線マップ推定の Tx-aware diffusion。deploy-time fine-tuning 不要は面白いが無線特化。
- 2607.20871: 二重量子ドットの電荷状態分類 CNN — 少パラ・転移学習は堅実だが量子デバイス特化。

## P1 planner_ai(quota 2 は BiCompoDiff 1 件のみ採用、在庫不足で under-fill)
- 2607.21292: LLM-Driven Process Control — LLM で多変数制御を自動設計、closed-loop 検証 + BO tuning。化学プロセス制御ドメインで、自動運転 planner の実装/評価指標には遠い。BiCompoDiff を優先。

## wildcard(max 1 は AREX で充足)
- 2607.16617: DataFlow-Harness — LLM データパイプラインを編集可能な DAG として構築する code-agent プラットフォーム(133 up)。P2 のデータ構築に間接的に有用だが、今回は RL/自己改善の学びが大きい AREX を1枠に選択。
