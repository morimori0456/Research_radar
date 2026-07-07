# 却下候補 — 2026-07-08

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **52件**(planner_ai 1 / fm_distill_finetune 30 / next_arch 18 / sns_wildcard 3)→ 選定 **6件**(max_deep_per_day 上限)、却下 **46件**。

- **4日ぶりに P1/P2/P3 の本枠候補が復活**(07-05〜07-07 は wildcard のみだった)。fetch の本枠取得は回復。
- **dedup 不具合は残存**: wildcard の 2606.29526 (MIPI/MIPU) は **昨日 2026-07-07 にブリーフ作成済み**なのに再提示された(hf 111→154 に更新されただけ)。[[fetch-duplicate-candidates]] を更新。既読 ID の除外を fetch 側で実装するまで、選別側で「briefs/ 配下に既存の id は既読扱い」を継続する。
- P3 は 5 点級が 4 本あり quota 2 では入り切らなかった。UNIVERSE (2607.05133) は fetch が P2 に分類していたため P2 枠で採用(内容は P3 交差)。次点筆頭は Multiplayer World Models (2607.05352)。

---

## planner_ai (P1) — 候補1件、1件選定、却下なし

(2607.05369 GaP を 3/5 で選定。P1 枠の却下候補なし)

---

## fm_distill_finetune (P2) — 30件中 2件選定 (TGRIP / UNIVERSE)、28件却下

**次点(読む価値あり):**

- **2607.05180: VLM-CASE — Context-Adaptive Safety Envelopes for Anticipatory Safe Autonomous Driving** — 3.5/5。LoRA で fine-tune した VLM が路面・視界を報告し、responsibility-sensitive safety 由来の安全包絡 (safety envelope) を文脈適応させて MPC を制約する。自動運転ドメインで closed-loop 検証まであり惜しいが、fine-tuning 自体は標準的な LoRA で P2 の新 recipe に乏しく、価値の中心は安全アーキテクチャ (P1 寄り)。TGRIP/UNIVERSE に枠を譲った。P1 の安全評価メモとして保留。
- **2607.04733: LP-SFT — Local-Preserving Supervised Fine-Tuning** — 3.5/5。SFT が pretrained の局所選好構造 (次トークンの代替候補間の相対確率) を壊して元能力を劣化させる問題に、代替トークン集合上の保存 loss を足す新 loss。P2 の「適合しても元能力を守る」に直結する一般 recipe だが、検証が LLM テキストタスクに閉じており quota 競争で敗退。次回類似の続報があれば拾う。
- **2607.04640: Wrong Before Right — Late Rescue and Interface Failure in Aligned LMs** — 3/5。中間層で一度誤答に傾き後段で救済される「wrong-dip」が、pruning/低 rank 圧縮での失敗を 3-7 倍予測するという知見。**圧縮耐性の事前診断**として P2 の model compression に面白いが、LLM の interpretability 研究で移植コストが読めない。
- **2607.04599: DPRD — Displacement Preserving Relational Distillation for Medical Segmentation** — 3/5。teacher の潜在空間の変位ベクトル (向き・相対スケール) を保存する relational KD で、5% パラメータの student が teacher 同等。dense prediction への KD recipe として自社 segmentation に移植可能性はあるが、医療特化の検証のみで優先度負け。
- **2607.04574: A Few Teacher Steps Go a Long Way — On-Policy Data Augmentation for Agent Post-Training** — 3/5。teacher 予算を「student が到達した文脈での少ステップ継続」に配分するのが最も費用対効果が高いという budget-allocation の知見。on-policy 蒸留の主題は wildcard で採用した UI-MOPD (2607.04425) と重複するためそちらに代表させた。
- **2607.05364: REDDIT — Correcting Timestamp Drift in ASR without Forgetting** — 3/5。「特定の欠陥挙動だけを、frozen base の分布に他を合わせながら外科的に修正する」replay-based distribution editing は忘却なし部分修正の recipe として一般性があるが、ASR timestamp という遠いドメインでの実証のみ。
- **2607.04919: When Do Foundation Models Pay Off? — Break-Even Analysis** — 3/5。FM 導入の損益分岐を系統的に測り「短系列では LoRA fine-tuning が逆に性能を落とす」等の運用知見。time series 予測ドメインだが「FM vs 従来手法の意思決定を先に安く済ませる」枠組みは運用メモとして記録。

**relevance 不足:**

- **2607.05392: SynCity 3000 — Scene-Scale 3D Diffusion** — 2/5 (hf 2)。3D シーン生成。fine-tuning は手段にすぎず、蒸留/適合の学びが薄い。
- **2607.05377: Cortex — Bidirectionally Aligned Embodied Agent** — 2/5。VLM-VLA 階層 manipulation。中身は P3 寄りのデータ生成工学で、P2 の蒸留/適合 recipe ではない。
- **2607.05300: Subspace-Constrained Adaptation Against Fine-Tuning Poisoning** — 2/5。信頼済み adapter 群の部分空間に適合を制約する防御。セキュリティが主題で P2 の適合効率とは目的が違う。
- **2607.05274: CARE — Precise Concept Removal in Diffusion Models** — 1/5。拡散モデルの concept erasure。対象外。
- **2607.05271: TGSR-PINN — Transfer Learning for PINN Inverse Problems** — 1/5。PDE 逆問題特化。対象外。
- **2607.05224: Iterative Pseudo-Labeling for Code-Switching ASR** — 2/5。半教師あり pseudo-label の標準的適用。ASR 特化で新規性薄。
- **2607.05175: Platonic Projection Structures** — 2/5。observability の operator 理論。蒸留の解釈は与えるが実務適用が遠い。
- **2607.05114: Localized LoRA-MoE** — 2.5/5。block-wise LoRA expert + 動的 routing。PEFT 構造として関心圏だが、評価が合成/tabular 中心で実務証拠が弱く、記述も誇張気味 ("gradient warfare")。
- **2607.04921: SNN for Automotive Detection and Tracking** — 2/5。neuromorphic/SNN の transfer learning。ハード前提が特殊で現行 P2 スコープ外。
- **2607.04894: ProCon — Training-Free Anomaly Detection** — 2/5。メモリベース異常検知。蒸留/適合と接点薄。
- **2607.04846: Pretraining Curricula Enable Selective Fine-tuning** — 2.5/5。カリキュラムが回路の分離を促し fine-tuning の選択性を上げる科学的知見。面白いが pretraining 段階の介入で、適合工程を回す P2 に直接効かない。
- **2607.04809: TL-ANDI — Context-Constrained Transfer for Tabular FMs** — 2.5/5。tabular FM の in-context 転移特化。negative transfer 対策の発想のみメモ。
- **2607.04755: Continual Model Merging with TTA for WSI** — 2/5。病理画像特化のベンチマーク研究。
- **2607.04747: MergeSurv — Merging-Based Continual Learning for WSI Survival** — 2/5。同上 (同グループ)。model merging を継続適合に使う方向性だけ記録。
- **2607.04726: Observation-Aligned Supervision for Chart-to-Code** — 2/5。教師信号の識別可能性という着眼は良いが chart 特化。
- **2607.04674: V-LITE — Video Generation Models Are Inherent Lighting Estimators** — 2/5。照明推定。対象外。
- **2607.04653: VPT — Enhancing Video Physical Consistency** — 2.5/5。video 拡散の物理整合性 fine-tuning。P3 world model 周辺だが生成品質の話でドメイン遠い。
- **2607.04612: StructuredEdit — Graphic Design Editing** — 1/5。デザイン編集。対象外。
- **2607.04593: TORINO — Token Reduction via Concept Overlap** — 3/5。SAE (Sparse Autoencoder) の概念空間で visual token を適応的に削減、fine-tuning 不要。VLM 推論効率化メモとして保留、蒸留 recipe ではないため落選。
- **2607.04577: Green Tea — Energy-Aware Code Generation** — 1.5/5。省エネコード生成。対象外。
- **2607.04557: PREDIKTOR — Therapeutic Outcome Prediction** — 1/5。創薬/オミクス。対象外。

---

## next_arch (P3) — 18件中 2件選定 (PixelPilot / InternVLA-A1.5)、16件却下

**次点(読む価値あり):**

- **2607.05352: Multiplayer Interactive World Models with Representation Autoencoders** — 4/5 (hf 12)。**落選中の最上位**。複数エージェントの行動ストリームに条件付けし、シーン変化を正しいプレイヤーに帰属する初の multiplayer world model (Rocket League、5B latent diffusion、B200 1枚で 20fps リアルタイム、5分超の安定 rollout)。「他エージェントを環境扱いせず行動条件に入れる」問題設定は**多エージェント環境そのものである自動運転の world model に直結**し、codec/目的関数/条件付けの設計比較とスケール分析も充実。純粋ゲームドメインである点だけで、AD 直球の PixelPilot / InternVLA に quota を譲った。時間があれば読む価値が高い。
- **2607.04681: Pinocchio — Faithfulness in Embodied Reasoning** — 3.5/5。VLA の chain-of-thought が方策の内部決定過程を本当に反映しているか (faithfulness) を、**自動運転の SoTA reasoning モデルの人間評価**で検証し、接地性・一貫性を測る critic を RL 報酬に使う。P1 (評価) と P3 の交差点で、reasoning 品質と軌跡改善の結合が不安定という指摘は重要。次回 P1 枠に空きがあれば再考。
- **2607.04978: Qantara — Bridge-Flow Training for Multi-Paradigm JEPA Control** — 3.5/5。JEPA (Joint-Embedding Predictive Architecture; pixel 再構成なしで latent 予測を学ぶ自己教師あり world model) の単一 checkpoint から planning / behavior cloning / inverse dynamics の3推論方式を選べる訓練法。deploy 制約に応じ推論方式を後決めできる発想は魅力だが manipulation ベンチ特化。
- **2607.04500: Geographic Diversity Beats Data Volume for JEPA Driving World Models** — 3.5/5。nuPlan→Argoverse2 の zero-shot 転移で「単一地域 20万シナリオ < 多地域 6.3万シナリオ」を示す。**データ収集戦略への実務示唆**が明確だが、単著・小規模で surprise score という代理指標のみの検証。データ戦略メモに記録。
- **2607.04464: Operator-on-F — Planning-Time Diagnostic for Latent World Models** — 3.5/5。reward/価値の予測誤差では見えない「k-step latent rollout の計画関連誤差」を測る診断指標で、return との rank 相関 -0.90。world model の**評価手法**として P1 とも交差。単著・cheetah-run 中心の小規模検証で見送り、評価指標メモに記録。

**relevance 不足:**

- **2607.05396: CamVLA — Calibration-Free View-Robust VLA** — 3/5。camera 幾何と操作制御の分離 (camera-centric action + hand-eye 行列予測)。PixelPilot と同じ「カメラ依存性の切り離し」問題意識だが manipulation 特化で、AD 側は PixelPilot に代表させた。
- **2607.05390: Deform360 — Visuotactile Dataset for Deformable World Models** — 2.5/5 (hf 2)。変形物体 world model のデータセット/ベンチマーク。ドメイン遠い。
- **2607.05122: Green for Go — Visual Grounding via Segmentation for VLA Navigation** — 2.5/5。走行可能領域を色分けして入力する training-free trick。効果は trajectory 長の正則化が主で、アーキ知見に乏しい。
- **2607.04927: DSWAM — Dual-System World Action Foundation Model** — 3/5。WAM 実行系 + 必要時のみ VLM planner を起動する dual-system と、条件を揃えた WAM vs VLA 実機比較は有用だが、deformable manipulation 特化で工学寄り。
- **2607.04880: PRISM — Personalized Robotic Dataset Generation** — 2.5/5。1枚画像からの digital cousin シーン生成でデモを合成。データ生成 pipeline の話で P3 のアーキ/学習知見でない。
- **2607.04816: CAC-VLA — Context-Gated Action Conditioning** — 3/5。VLM 内に latent action の粗→細予測を仕込み gate で action expert を条件付け。LIBERO 系で高成功率だが差分が小さく、同系統では InternVLA-A1.5 の方が設計思想の学びが大きい。
- **2607.04652: KAM-WM — Kinematic Affordance Maps from Latent World Models** — 3/5。frozen video world model の 1-step latent 速度を affordance 事前情報として抽出。「frozen video model を prior に使う」流れは InternVLA-A1.5 に代表させた。
- **2607.04609: SEAM — Smooth Execution of Action-Chunked Motion** — 3/5。action chunk 境界の不連続を training-free で平滑化する inference trick。有用だが局所的な工夫で深掘り対象でない。
- **2607.04591: Simple-to-Complex Structured Demonstrations for VLA** — 2.5/5。デモ収集の組織化 (段階的複雑化)。データ運用の常識的知見で新規性薄。
- **2607.04546: Mask2Real-WM — Segmentation Masks as Sim-to-Real Bridge** — 3/5。dynamics を segmentation mask 空間で学び rendering を分離して sim-to-real ギャップを縮める2段構成。発想はメモ価値あるが dexterous manipulation 特化。
- **2607.04498: UniSkip-Mamba — Audio-Visual Forgery Localization** — 1.5/5。deepfake 検出。"state space model" キーワードの誤爆で、P3 と無関係。

---

## sns_wildcard (EXPLORE) — 3件中 1件選定 (UI-MOPD)、2件除外/却下

- **2606.29526: The Mirage of Optimizing Training Policies (MIPI/MIPU)** — **既読除外**(relevance 評価対象外)。**2026-07-07 にブリーフ作成済み**([../2026-07-07/2606.29526.md](../2026-07-07/2606.29526.md))の候補が hf_upvotes の更新 (111→154) のみで再提示された。fetch の「既ブリーフ ID 除外」が未実装である事実を [[fetch-duplicate-candidates]] に追記。
- **2607.04033: OmniOpt — Taxonomy, Geometry, and Benchmarking of Modern Optimizers** — 3/5 (hf 64)。100超の optimizer を5段階 meta-pipeline と LMO (linear minimization oracle) で統一し、横断ベンチマークまで付けた survey/cookbook。**reference としての価値は高い**が、探索枠の「深掘りブリーフ」に向くのは単一の主張を持つ研究論文で、survey は必要時に引く辞書として URL 記録で足りる。hf は UI-MOPD とほぼ同点 (64 vs 62) のため、P2 への交差学習価値で UI-MOPD を採った。optimizer 選定に迷ったら立ち返る先としてブックマーク推奨。
