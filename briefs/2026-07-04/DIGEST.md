# DIGEST — 2026-07-04

候補 47件 → 選定 **6件**(deep research)、却下 41件。
上限: max_deep_per_day=6(6件で完全消化)、quota P1=2 / P2=2 / P3=2 + wildcard≤1。
本日の配分: **P1=1 / P2=2 / P3=2 / wildcard=1**。
- P1 は強候補が CommonRoad-Game の1件のみ(2番手はマニピュレーション VLA で適合が間接的)。空いた1枠を、より学びの大きい探索枠(Orca)に回した。
- hf_upvotes は SNS 注目度の代替=**副次シグナル**として扱い、relevance は上書きしていない(同点タイブレークのみ)。

---

## 今日読むべき TOP3

1. **[2607.01382 — CommonRoad-Game: Human-in-the-Loop Simulation Framework](./2607.01382.md)** (P1, 5/5)
   録画リプレイでは測れない「対人インタラクション下でのプランナ挙動」を、wall-clock 同期の決定論的 HIL 環境で再現可能に採取できる。CommonRoad 互換なので自社/標準プランナを即差し込め、**衝突率だけでなく過保守や人間の介入頻度という評価軸**を closed-loop スイートに追加できる。P1 の高優先「評価手法の新提案」に直撃で、今週すぐ触れる実利が最大。

2. **[2607.01658 — DriveTeach-VLA: Teaching VLAs What to See and Where to Look](./2607.01658.md)** (P3, 5/5)
   「VLA は言語推論に偏り、軌道予測に必要な空間接地を欠く」という診断が的確。知覚事前情報の vision encoder への蒸留(DVD)→ 軌道誘導プロンプト(2D-TGP)→ GRPO の3段で **NAVSIM/nuScenes に SOTA**。P3 の本丸(end-to-end 自動運転 × VLA)そのもので、自社評価ベンチでも再現・比較可能。

3. **[2606.30534 — Orca: The World is in Your Mind](./2606.30534.md)** (wildcard/EXPLORE, 4/5, hf **199**)
   本日突出の注目度(199 upvotes)。Next-State-Prediction を軸に理解・予測・行動を**単一 world latent**で統一する world foundation model。凍結 latent + 軽量 readout で text/image/action を出す設計は、自社が world model とプランニングを一体化する際の上位アーキ仮説になる。探索枠だが P3 と直結し実利も見込める。

---

## 全ブリーフ一覧

| id | title | project | score | hf | brief |
|---|---|---|---|---|---|
| 2607.01382 | CommonRoad-Game: HIL Simulation Framework | P1 | 5 | 0 | [link](./2607.01382.md) |
| 2607.02158 | Efficient PEFT with Adaptive Checkpointing (edge/VLM) | P2 | 4 | 0 | [link](./2607.02158.md) |
| 2607.01851 | Geometric Foundation Model Distillation (Lunar 3D) | P2 | 4 | 0 | [link](./2607.01851.md) |
| 2607.01658 | DriveTeach-VLA (What to See / Where to Look) | P3 | 5 | 0 | [link](./2607.01658.md) |
| 2607.01586 | VLAFlow: Unified VLA Training / Future Latent Align | P3 | 4 | 0 | [link](./2607.01586.md) |
| 2606.30534 | Orca: World Foundation Model | EXPLORE | 4 | 199 | [link](./2606.30534.md) |

却下候補と理由 → [rejected.md](./rejected.md)

---

## プロジェクト別の要点

### P1 — Planner AI + 評価
- 本日の目玉は **CommonRoad-Game(評価基盤)**。対人 HIL を軽量・決定論的に回せるのが強み。まず自社/標準プランナを接続し、合流・交差点・割り込みで「衝突率／過保守／TTC 分布」を録画リプレイ評価と比較して乖離を定量化したい。
- 収集される人間走行ログは、難シナリオのシード・回帰テストのゴールデン基準に転用可能。
- 次点メモ: 2607.01378(制約付き flow-matching で予測衝突を先回り修正)は安全プランニング層の着想として保留。2607.01736(latent world model の closed-loop 性能予測)も評価観点で接点あり。

### P2 — Foundation Model 蒸留 + 適合
- 本日は蒸留/PEFT が豊作。選定2件で「**適合レシピ**」と「**蒸留レシピ**」を両取り:
  - **2607.02158(Efficient PEFT)**: 2GB VRAM 予算下の PEFT 比較表。QLoRA/BitFit は省エネ20–30%で精度低下1–2%、凍結 DINOv2+線形ヘッドが微調整超え。本ループのエッジ環境での適合意思決定に直結。
  - **2607.01851(Geometric FM Distillation)**: **feature 蒸留 > output 蒸留 / エンコーダ容量温存 / SVD warm start** という汎用ガイドライン。自社の大教師→小生徒蒸留にそのまま移植して検証すべき。
- **翌日最優先の再検討候補**: 2607.01827(C2E, AD ドメインのマルチ教師対照蒸留)、2606.30626(DOPD, privilege illusion を回避する二重蒸留、hf 91)、2607.01763(Denser≠Better, 自己蒸留の負の結果)。いずれも quota 超過のみで見送っており、質は選定級。

### P3 — 次世代アーキテクチャ(VLA / World Model / E2E)
- 本日最も豊作。選定2件で「**e2e AD の VLA**」と「**VLA 学習パラダイムの統制比較**」を押さえた:
  - **2607.01658(DriveTeach-VLA)**: 運転特化の知覚蒸留 + 軌道誘導で空間接地を注入。自社 e2e プランナに 2D-TGP 相当の軌道誘導プロンプトを足す実験が有望。
  - **2607.01586(VLAFlow)**: language 共学習は汎化を保全、future latent alignment は状態遷移モデリングを改善(=軽量 world-model 信号)。自社 VLA に future-latent 補助損失を足す価値。
- world model 系(Orca, WorldDirector, WorldSample, Bridge-WA, ACID)が同日に多数。**「Next-State-Prediction / future-latent を行動学習に接続する」流れが明確なトレンド**。Orca を探索枠で拾い、TAP(2607.02466)と WorldDirector(2607.02517)を翌日再検討の筆頭に。
- P3 は候補過多で quota=2 が律速。良質な取りこぼしが多い日は、次回 topics.yaml 見直しで P3 quota の一時引き上げ、または world_model サブトピック分離を検討する価値あり。
