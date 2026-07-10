# Rejected — 2026-07-11

候補 43件 (planner_ai 3 / fm_distill_finetune 30 / next_arch 7 / wildcard 3) 中、6件を選定し 37件を却下。

## planner_ai (P1)

- **2607.08402: Swapping Faces, Saving Features (歩行者プライバシーの face swap パイプライン)** — 1.5/5。データセット公開のためのプライバシー保護であり、planner の実装・評価指標には寄与しない。
- **2607.08316: INTENT (LSTM による交差点意図予測)** — 2/5。intention 予測自体は関連するが、LSTM + 単一データセット (InD) で 99.71% という設定は新規性・汎化の面で弱く、評価手法の提案でもない。

## fm_distill_finetune (P2)

- **2607.08733: Super Weights in LLMs and the Failure of Selective Training** — 3.5/5 (次点)。「重要パラメータの選択的学習は機能せず、LoRA 的な低ランク構造が効く」という fine-tuning 実務に効く知見だが、LLM 内部解析寄りで P2 の蒸留/適合 recipe への即効性で ZipDepth・Wat3R に譲る。
- **2607.08409: Better Call GRPO (合成音声のみでの ASR 適合に GRPO)** — 3/5。「合成データ適合では SFT より RL」という知見は面白いが音声ドメイン特化。合成データ適合を回す時に再訪。
- **2607.08540: Model Merging for Conversational IR** — 3/5。training-free の model merging (Model Soup/Slerp) で catastrophic forgetting を回避する話は適合の道具として有用だが、IR 特化の検証で優先度は中。
- **2607.08393: Knowing–Using Gap (fine-tuning で記憶した知識が推論に使われない機構解明)** — 3/5。知識注入 FT の失敗解析として興味深いが LLM 知識注入特化で、P2 の視覚系蒸留・適合からは遠い。
- **2607.08164: Continual Test-Time Adaptation サーベイ** — 3/5。ドメインシフト適応の整理として有用な参照資料だが、サーベイでありオンライン適応 (CTTA) は現行 P2 スコープの外縁。
- **2607.08268: Different Teachers, Different Capabilities (sub-1B オンデバイス蒸留)** — 3/5。teacher の性質ごとに転移する能力が違うという観察は蒸留実務に有益だが、単一タスク・小規模検証で一般性が弱い。
- **2607.08763: OpenCoF (video generation で推論する Chain-of-Frame)** — 2.5/5。話題としては P3 寄りで面白いが、蒸留/適合 recipe ではなく、video reasoning はプロジェクト直結度が低い。
- **2607.08770: LongE2V (event camera 動画復元を video diffusion で)** — 2.5/5 (hf 19)。foundation video model の fine-tuning 事例だが event カメラ映像復元というタスクが遠い。
- **2607.08503: CT-CLIP 肺がん生存予測** — 2.5/5。frozen/full-FT/LoRA の適合戦略比較という枠は P2 的だが、医療特化で知見の移植性が低い。
- **2607.08312: Write-Protected Discrete Bottlenecks (言語 grounding と離散 world model)** — 2.5/5。language gradient が discrete bottleneck を壊すという指摘は P3 的に興味深いが、小規模・単著の toy 実験段階。
- **2607.08161: SQuaD-SQL (SLM への Text-to-SQL 蒸留)** — 2.5/5。KD + 合成データ + PEFT の標準構成で、recipe としての新規性が薄い。
- **2607.08208: Diarization-Guided Qwen-ASR Adaptation** — 2/5。SFT→LoRA→GRPO の適合 recipe だがチャレンジシステム報告で一般性が低い。
- **2607.08203: Metrics or Mirage? (polyp segmentation 評価の監査)** — 2/5。評価の再現性監査は P1 的教訓に富むがドメインが遠い。
- **2607.08201: TMI (T2I + I2I で long-tail instance segmentation を増強)** — 2/5。データ合成の話で蒸留/適合の中心から外れる。
- **2607.07993: Hallucination Self-Play** — 2/5。detector/generator の自己対戦 bootstrap は面白いが hallucination 検出特化。
- **2607.08046: What LLM Forecasters Know but Don't Say** — 2/5。内部表現 probing による校正は興味深いが forecasting 特化で P2 と接点が薄い。
- **2607.08765: Canvas360 (panorama 生成の geometric-aware pretraining)** — 1.5/5 (hf 14)。panorama 生成でプロジェクトと接点なし。
- **2607.08143: HIPE-OCRepair (歴史文書 OCR 修正コンペ報告)** — 1.5/5。ドメイン外。
- **2607.08168: MuScriptor (多楽器採譜)** — 1.5/5。合成→実データ FT→RL の流れは王道だが音楽ドメイン。
- **2607.08014: FedTR (連合学習 + 転移学習の外観検査)** — 1.5/5。転移学習は表層的で FL が主題。
- **2607.07989: AgentLocate (multi-agent 失敗箇所特定)** — 1.5/5。agent システム診断でドメイン外。
- **2607.08236: TVTA (event camera 読唇)** — 1/5。ドメイン外。
- **2607.08404: DrugGen 2 (創薬言語モデル)** — 1/5 (hf 5)。ドメイン外。
- **2607.08281: KidSat (衛星画像の貧困予測)** — 1/5。ドメイン外。
- **2607.08112: VSRo-200 (ルーマニア語読唇データセット)** — 1/5。ドメイン外。
- **2607.08071: COBART (広告見出し生成)** — 1/5。ドメイン外。
- **2607.08011: CodeTracer (backdoor コード補完の追跡)** — 1/5。セキュリティフォレンジクスでドメイン外。
- **2607.07957: 自閉症関連行動分類のフレームレート評価** — 1/5。ドメイン外。

## next_arch (P3)

- **2607.08575: FabriVLA (1B 級軽量 VLA + flow-matching action head)** — 4/5 (次点、quota 落ち)。compact VLA で MT50 90% は P3 直結だが、AD 直球の WCog-VLA と分野の見取り図を与える Post-Training サーベイを優先。再浮上したら選定検討。
- **2607.08448: Harness VLA (frozen VLA を memory-guided agent で拡張)** — 3.5/5。fine-tuning なしで VLA の適用範囲を広げる合成的アプローチは示唆的だが、manipulation 特化で quota 内の 2 本に及ばず。
- **2607.08283: TFP (VLA への temporally conditioned memory)** — 3.5/5。stage 依存タスクへの belief 注入は VLA メモリ設計の一案だが、07-10 の LaMem-VLA/NativeMEM と重なる話題で増分が小さい。
- **2607.08182: LEEVLA (latent evolution への注意誘導)** — 3/5。where-how の学習枠組みは一般性があるが、ベンチマーク・説明とも増分が読みにくい。
- **2607.08076: LDFE (RGB-IR 検知の特徴融合ブロック)** — 2/5。センサ融合の検知モジュールで「次世代アーキテクチャ」の射程外。

## sns_wildcard (再提示分)

- **2607.06559: RynnWorld-4D** (hf 83) — 07-09 に**ブリーフ作成済み** (briefs/2026-07-09/2607.06559.md)。3日連続の再提示。
- **2607.06291: AlayaWorld** (hf 80) — 07-09 に 3/5 で却下、07-10 も却下済み。3回目の再提示で判断変わらず。
- (wildcard 3件中、初出の Vidu S1 のみ選定。fetch 側の既読 dedup 未実装が 4日連続で継続 — [[fetch-duplicate-candidates]])
