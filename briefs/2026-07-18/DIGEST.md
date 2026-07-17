# DIGEST — 2026-07-18

候補 54 件を relevance_criteria で選別。採用 6 件 (max_deep_per_day=6 上限)。内訳: P1×1・P2×2・P3×2・wildcard×1。

---

## 今日読むべき TOP3

### 1. RoboTTT: Context Scaling for Robot Policies (P3, up=12)

robot foundation model の visuomotor 履歴を **8K timestep** (従来比3桁) まで伸ばしても推論が遅くならない学習レシピ。カギは履歴を attention で持たず **fast weights (推論時にも勾配で更新する重み)** に圧縮すること。**「事前学習の context 長を伸ばすほど閉ループ性能が単調に伸びる」**という新しい scaling 軸を初めて観測した点が効く — 運転 E2E で数分の走行文脈をどう低レイテンシで扱うかという未解決問題に、attention 長系列コストを回避する具体的な設計選択肢を与える。

### 2. SEED: Self-Evolving On-Policy Distillation (P2, up=64)

疎な最終報酬しかない agentic RL に、**生徒モデル自身**が自分の軌道から「再利用可能な手順・失敗回避ルール」を抽出し、その効果を token 単位の dense な蒸留信号に変換して RL と同時最適化する。**固定 teacher を要さず self-distillation で密な監督を作る**点が新しく、capacity gap が大きい/teacher を用意できない社内蒸留設定にそのまま効く発想。sample efficiency 改善が実測されコードも公開。

### 3. DRIFT: Drift and Aggregation for Motion Planning (P1, up=0)

AD の end-to-end プランナー向けに、多仮説を安く出して1本に畳む実装レシピ。軌道 latent 空間で **one-step drift** により 48 候補を1パス生成し、**候補品質のラベルなしで**最終軌道を直接回帰する。NAVSIM navtest で EPDMS 90.4、proposal+集約が RTX 4090 で 10.82ms。追っている planner 評価パイプラインに「アノテーション無しで多仮説集約」を持ち込める点で、社内でラベルが乏しい状況に直接噛み合う (up=0 だが relevance が最優先、注目度は選定理由にしていない)。

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| P1 planner_ai | [2607.14507](2607.14507.md) | DRIFT: Drift and Aggregation for Motion Planning |
| P2 fm_distill_finetune | [2607.14777](2607.14777.md) | SEED: Self-Evolving On-Policy Distillation for Agentic RL |
| P2 fm_distill_finetune | [2607.14552](2607.14552.md) | Answer-Conditioned CoT Degrade Verifiable-Reasoning Distillation |
| P3 next_arch | [2607.15275](2607.15275.md) | RoboTTT: Context Scaling for Robot Policies |
| P3 next_arch | [2607.15065](2607.15065.md) | DriftWorld: Fast World Modeling through Drifting |
| wildcard EXPLORE | [2607.13285](2607.13285.md) | Harness Handbook: Readable/Navigable/Editable Agent Harnesses |

落選 48 件の理由: [rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1: Planner AI + 評価

- **DRIFT** が本日唯一の AD プランナー直撃。「多仮説を安く生成 → ラベル無しで直接集約」と map-derived boundary regularizer による drivable-area 遵守がポイント。EPDMS/推論時間で現行後段と A/B する価値あり
- **DriftWorld** (P3 掲載) はオフライン simulator として rollout スコアが実測と最大 0.99 相関 → P1 の**プランナー評価**にも橋渡し可能。DRIFT 型の proposal 生成 × DriftWorld の高速 rollout 評価の組み合わせが横断アイデア
- 次点だった BridgeFlow (SE(2)-equivariant) は等変性を安価に得る canonicalization が着想として残る

### P2: Foundation Model 蒸留 + 適合

- **SEED** = 蒸留レシピの「positive」side: teacher 無しで self-distillation を dense 化。**Answer-Conditioned CoT** (2607.14552) = 「negative」side: 失敗サンプルを gold で補完すると correctness filter で気づけない形でデータが最大27pt劣化する → **answer-blind 生成せよ**。この2本はセットで「蒸留データの作り方」の指針になる
- 実務アクション: 社内の reasoning 蒸留コーパスで「early final-answer statement 出現率」を fine-tune 前に計測し、劣化を事前検知するチェックを入れる

### P3: 次世代アーキテクチャ (VLA / World Model / E2E)

- **RoboTTT**: context 長 = 新しい scaling 軸。fast weights による履歴圧縮で長期依存タスク (occlusion 後の再認識、長時間文脈) に効く可能性
- **DriftWorld**: diffusion world model の 17倍高速化を「一発生成の drift」で達成 → 推論時 action search が実用域に。運転の候補軌道 rollout 評価に輸入候補
- 次点の Reflex (flow-matching VLA の O(1) streaming 推論) と Video=World+Event Stream (up=13) も実運用効率の観点で継続ウォッチ

### EXPLORE (wildcard)

- **Harness Handbook** (up=186): エージェント harness の behavior→code 対応付けを自動生成。この research_loop 自体が evolving harness であり、fetch/選別/dedup ロジックの保守 ([[fetch-duplicate-candidates]] の dedup 強化など) に応用できる視点
