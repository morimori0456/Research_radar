# 却下候補 — 2026-07-09

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **50件**(planner_ai 1 / fm_distill_finetune 30 / next_arch 16 / sns_wildcard 3)→ 選定 **5件**、却下 **45件**。

- **wildcard 3件は全て既出のため選定ゼロ**: 2606.29526 (MIPI) は 07-07 ブリーフ済みの**3回目の再提示**、2607.04425 (UI-MOPD) は 07-08 ブリーフ済み、2607.04033 (OmniOpt) は 07-08 却下済み。fetch 側の既読 dedup 未実装が継続 ([[fetch-duplicate-candidates]] 更新済み)。探索枠を無駄にしないため、選別側の「briefs/ 配下の既存 id は既読」運用を継続。
- 本枠は2日連続で健全 (P1: 1 / P2: 30 / P3: 16 の新規 ID)。P3 は今日も 4 点級が量産され quota 2 で入り切らず。次点筆頭は Lift3D-VLA (2607.06564)。

---

## planner_ai (P1) — 候補1件、1件選定、却下なし

(2607.06499 CE-MPPI を 3.5/5 で選定。P1 枠の却下候補なし)

---

## fm_distill_finetune (P2) — 30件中 2件選定 (Few-Medoids / 合成 pretraining)、28件却下

**次点(読む価値あり):**

- **2607.05711: FourTune — Fully 4-Bit Efficient Post-Training for Diffusion Models** — 3.5/5。**P2 落選中の最上位**。W4A4G4 (重み・活性・勾配すべて4bit) で diffusion モデルの post-training を回す枠組み。LoRA に frozen numerical stabilizer を足した triple-branch で量子化に弱い外れ値を隔離し、専用 fused kernel で FLUX.1-dev (12B) のメモリ 2.25 倍削減・スループット 2.27 倍。蒸留タスクでも full-precision 同等。効率的適合のインフラとして価値が高いが、diffusion 特化 + カスタムカーネル依存で移植コストが読めず、汎用 recipe の Few-Medoids / 合成 pretraining に枠を譲った。
- **2607.05937: Is Domain Adaptation Always Helpful?** — 3/5。frozen backbone での domain adaptation の効果は「backbone が target ドメイン知識を既に持つか」で決まり、DANN (Domain-Adversarial Neural Networks; ドメイン識別器を騙すよう特徴を揃える適合法) は FinBERT のような特化 backbone の構造をむしろ壊す、という実務判断に効く知見。予備的研究で規模が小さく落選だが、「適合手法を足す前に backbone のドメインカバレッジを測れ」は運用メモとして記録。
- **2607.06140: CurateEvo — Data-Curation Evolving for Agentic Post-Training** — 3/5。データキュレーション戦略を実行可能コードとして表現し、失敗軌跡から反復的に書き換える枠組み。「curation を固定前処理でなく失敗駆動で進化させる」発想は蒸留/適合データの整備にも一般化しうるが、エージェント post-training 特化の実証のみ。
- **2607.06175: Reward Function Design for LLM Process Model Generation** — 3/5。多次元品質の RL では均等重み報酬が狙い撃ち重みに一貫して勝ち、特定次元の強調はその次元すら改善せず低品質モードに崩壊しうる、という 48 構成の系統的比較。報酬設計の一般知見として面白いが BPMN 生成ドメイン。
- **2607.05658: GNSS ZWD を Weather FM に統合** — 3/5。既存の foundation model (Aurora) に新しい観測変数を追加学習させ、下流 fine-tuning (降水予測) を改善する「FM への新センサ統合」の実例。センサ追加の recipe として発想は近いが気象ドメイン。
- **2607.06552: MonoIR-RS — 赤外リモセンの CLIP/VLM 適合** — 3/5。RGB 学習済みの CLIP/VLM を赤外モダリティに適合させる大規模データセット + recipe。モダリティギャップ克服の実例だがリモセン特化のデータセット論文。

**relevance 不足:**

- **2607.06555: ProxyPose — 6-DoF Pose Tracking via Video-to-Video Translation** — 2.5/5。video diffusion の fine-tuning は手段で、主題は pose tracking の再定式化。発想は面白いが P2 の recipe ではない。
- **2607.06549: Mammography の UDA** — 2/5。style transfer ベースの標準的 UDA。医療特化。
- **2607.06527: RSF-GLLM — Multi-Hop KGQA** — 1.5/5。知識グラフ QA。対象外。
- **2607.06495: Pitwall — F1 実況の faithful 生成** — 2.5/5。verifier で SFT データをゲートする faithfulness 設計は一読の価値があるがドメインが遠い。
- **2607.06481: PACR-Video — 長尺動画外挿の PEFT** — 2.5/5。adapter + prompt routing の PEFT 構造だが動画生成特化。著者情報も含め再現性に不安。
- **2607.06478: 交通標識状態評価の VLM** — 2.5/5。交通ドメインだが VLM 応用システム論文で、適合 recipe の新規性なし。
- **2607.06364: クラウドセキュリティ準拠マッピング** — 1.5/5。sentence transformer のドメイン適合応用。対象外。
- **2607.06289: Sinhala→Dhivehi ASR 転移** — 2/5。低資源言語 ASR の標準的 transfer learning。
- **2607.06160: LongCrafter — 長文脈 SFT データ合成** — 2/5。LLM 長文脈特化のデータ合成。
- **2607.06150: 溶接シーム segmentation の転移学習** — 2/5。BiSeNetV2 + loss 工夫の応用論文。
- **2607.06097: PVCap — 3D Dense Captioning** — 2.5/5。teacher-student での pseudo-label 生成を使うが 3D captioning 特化。
- **2607.05968: InfluMatch — 4B カスケードで frontier 品質** — 2.5/5。小型モデルカスケードで frontier LLM 同等というシステム論文。「pointwise の fine-tuning が end-to-end ランキングを壊す」観察のみメモ。
- **2607.05933: 組込み GPU の DVFS で SLM fine-tuning 省エネ** — 2.5/5。Jetson AGX Orin での fine-tuning 電力最適化 (平均 13% 削減)。**手元の Jetson 環境に実務的に関係する**ためブックマーク推奨だが、P2 の蒸留/適合 recipe ではない。
- **2607.05898: Unlearning アルゴリズムの監査** — 1.5/5。unlearning 検証。対象外。
- **2607.05880: Harrison.Rad 1.5 — 放射線科 FM 技術報告** — 2.5/5。domain adaptation → contrastive vision encoder → VQA fine-tuning の3段 pipeline は FM ドメイン特化の参考例だが医療特化の技術報告。
- **2607.05859: AVA-VLM — 建設現場監視の coarse-to-fine VLM** — 2.5/5。低解像度全体像から必要時のみ高解像度 crop を要求する設計は遠距離監視系で示唆があるが応用論文。
- **2607.05850: Generative Randomization で spurious correlation 打破** — 2.5/5。背景不変表現の contrastive 学習。robustness 一般論で適合 recipe でない。
- **2607.05752: LLM の search routing** — 2/5。検索要否のルーティング学習。対象外。
- **2607.05716: SaGe — Scene Graph で構造化視覚推論** — 2.5/5。MLLM の post-training だが scene graph 推論が主題。
- **2607.05645: 気候 downscaling の時間的 OOD 適合** — 2.5/5。temporal distribution shift への domain alignment。発想は関心圏だが気候特化。
- **2607.05626: Twitter の DSM-5 症状プロファイリング** — 1/5。計算精神医学。対象外。
- **2607.05625: 創傷モニタリングの dual-stream LoRA** — 2.5/5。2系統 LoRA の cross-contextual fusion という構造だけメモ。医療特化。

---

## next_arch (P3) — 16件中 2件選定 (Point as Skeleton / RynnWorld-4D)、14件却下

**次点(読む価値あり):**

- **2607.06564: Lift3D-VLA — 3D Geometry and Dynamics-Aware Manipulation** — 4.5/5。**P3 落選中の最上位**。点群を pretrained 2D positional embedding に幾何整合させて VLA の vision encoder に直接入れ、GC-MAE (現在の点群の再構成 + 未来の幾何進化の予測を同時に行う自己教師あり学習) で 3D 構造と物理ダイナミクスを内在化させる。MetaWorld/RLBench で先行 VLA 比 +10.8/+11.1 点。VLA への 3D 注入の設計としては本日最良だが、選定2本 (closed-loop AD sim + 4D world model) との重なりで quota 負け。VLA に幾何を入れる設計検討時は必読。
- **2607.06558: RynnWorld-Teleop — Action-Conditioned World Model for Digital Teleoperation** — 4/5 (hf 67)。実機なしで手姿勢ストリームから world model が egocentric 映像を合成し、demonstration データを量産する「digital teleoperation」。生成データのみで Sim2Real zero-shot が成立。データ収集ボトルネックへの world model 活用として重要だが、同グループの RynnWorld-4D を優先し兄弟論文は見送り。
- **2607.06403: LingBot-VLA 2.0 — From Foundation to Application** — 4/5 (hf 10)。6万時間 (ロボット軌跡5万 + egocentric 人間動画1万) の pretraining、全身自由度への行動空間拡張、video 表現 + depth 推定を使った future prediction proxy task。VLA の実用スケーリング報告として貴重。技術報告で手法の新規性が薄い分、次点。
- **2607.06442: SIEVE — Structure-Aware Data Selection for VLA** — 3.5/5 (hf 2)。demonstration を「再利用可能な primitive + 遷移」の合成と見なし、構成パターン単位で選択予算を配る data selection。50% のデータ・学習で full-data 超え。P2 の Few-Medoids と主題が重なり、簡便さでそちらを採用。
- **2607.06262: OTQL — Optimal Transport Q-Learning for Flow Policy** — 3.5/5。flow policy を 50-60 エピソードの実経験で RL post-training し、成功率 36→86%、推論ステップ 70% 削減。flow 系 policy の廉価な post-training として記録。
- **2607.06370: ActionCache — VLA の training-free 高速化** — 3.5/5。過去の中間 action をキャッシュして flow/diffusion の denoising を warm-start、最大 34 倍高速化。plug-and-play で実用性が高いが、加速のみで設計思想の学びは薄い。
- **2607.05966: Imagined Rollouts are Kinematic, Not Dynamic** — 3.5/5。world model の長期破綻を「kinematic にしか想像していない (物理条件の変化に応答しない)」と再定式化し、iKCE (imagined Kinematic-Consistency Error) という診断量を提案。world model の評価指標として P1×P3 交差の価値があるが、DreamerV3 + walker-walk の単一実証で予備的。

**relevance 不足:**

- **2607.06501: Hypothesis-driven Model Expansion for Open-World Planning** — 3/5。記号的 world model の仮説生成・検証。サービスロボット特化。
- **2607.06291: AlayaWorld — Playable Video World Generation** — 3/5 (hf 66)。ゲーム world model の full-stack オープンソース基盤。インフラとして注目度は高いがゲームドメインで、AD 直球の Point as Skeleton を優先。
- **2607.06256: VLA スキル合成の Semantic Handoff 失敗診断** — 3/5。単一スキル成功と長期合成成功のギャップ診断。知見は良いが household タスク特化。
- **2607.06216: MoWorld — Flash World Model** — 3/5。NPU で 50 FPS の実時間 world model。効率化の方向性は関心圏だが技術詳細が薄い宣伝色の強い報告。
- **2607.06155: Tool Use と有限精度 RNN/SSM の表現力** — 2/5。理論結果として面白いが実装に効かない。
- **2607.05669: EVC-Mamba — 車両 localization の速度補正** — 2.5/5。AD 隣接だが localization 特化で P3 のアーキ設計に効かない。evidential 不確実性 + ESKF の構成のみメモ。
- **2607.05577: Narrative World Model — 小説執筆の writer memory** — 1.5/5。"world model" は名前だけで文芸支援。対象外。

---

## sns_wildcard (EXPLORE) — 3件中 0件選定 (全て既出)

- **2606.29526: MIPI/MIPU — Monotonic Inference Policy Improvement** (hf 157) — **07-07 にブリーフ作成済み**。hf 154→157 の更新のみで3回目の再提示。既読につき却下。
- **2607.04425: UI-MOPD — Multi-Platform On-Policy Distillation** (hf 65) — **07-08 にブリーフ作成済み**。既読につき却下。
- **2607.04033: OmniOpt — Modern Optimizers の Taxonomy とベンチマーク** (hf 68) — **07-08 に却下済み** (survey は辞書として URL 記録で足りるとの判断)。再評価しても判断は変わらず。
