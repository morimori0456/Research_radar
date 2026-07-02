# DIGEST — 2026-07-02

候補 9件 → 選定 **4件**(deep research)、却下 5件。
上限: max_deep_per_day=5(4件で消化)、quota P1=2 / P2=2 / P3=1。
P3(next_arch)は該当候補ゼロのため今日は未使用。

---

## 今日読むべき TOP3

1. **[2607.00776 — Conformalized Distance Fields for Safe Motion Planning](./2607.00776.md)** (P1, 5/5)
   予測不確実性を「距離場ごとconformalize」して分布フリーの安全保証をMPCに埋め込む。
   歩行者ベンチ(ETH–UCY)で評価済みで、**自社AVプランナーの安全性評価に新指標(certified-safe率/過保守率)をそのまま追加できる**のが今週試す価値の核心。予測→計画の継ぎ目を原理的に締められる。

2. **[2607.00514 — Cross4D-JEPA: Dense Cross-modal Correspondence Distillation](./2607.00514.md)** (P2, 5/5)
   凍結2D基盤モデル(DINOv2/V-JEPA2)を**13x小さいエンコーダへ密蒸留して同等性能**。negatives/decoder/momentum不要でレシピが単純。capacity gap対策の実例として自社蒸留パイプラインへ最短で移植できる。

3. **[2607.00444 — ST-GCS Spatiotemporal & Multi-Robot Motion Planning](./2607.00444.md)** (P1, 4/5)
   時空間の凸集合グラフ上でtime-optimal計画。交差点・合流など**通行可能領域が過渡的に開閉するAVシーン**の定式化に直結。決定論的探索で回帰テストのゴールデン基準にも向く。

---

## 全ブリーフ一覧

| id | title | project | score | brief |
|---|---|---|---|---|
| 2607.00776 | Conformalized Distance Fields for Safe Motion Planning | P1 | 5 | [link](./2607.00776.md) |
| 2607.00444 | ST-GCS Spatiotemporal & Multi-Robot Motion Planning | P1 | 4 | [link](./2607.00444.md) |
| 2607.00514 | Cross4D-JEPA: Cross-modal Correspondence Distillation | P2 | 5 | [link](./2607.00514.md) |
| 2607.00382 | Vitality-Aware Compression for DiT | P2 | 3 | [link](./2607.00382.md) |

却下候補と理由 → [rejected.md](./rejected.md)

---

## プロジェクト別の要点

### P1 — Planner AI + 評価
- **評価の高度化が今日の目玉**。00776 は「分布フリーの安全被覆保証」をclosed-loop評価指標に翻訳できる。衝突率だけでなく *過保守(不要な急減速)* を定量化する軸を導入したい。
- 00444 は予測軌道を space-time の「占有予約(ECD)」として扱う定式化。予測不確実性を凸集合の膨張で表現でき、00776 の不確実性→制約の思想と相補的。
- **合わせ技の仮説**: 予測器の不確実性 →(00776)距離場conformal制約 →(00444)時空間予約プランナー、という縦の接続を1本の実験系で検証する価値あり。

### P2 — Foundation Model 蒸留
- 00514 が本命。「グローバル埋め込みでなく密な対応で蒸留」+「13x圧縮で同等」は、自社の大教師→小生徒蒸留にそのまま効く汎用原則。まず既存グローバル蒸留と差し替えてラベル効率を比較。
- 00382 は蒸留そのものではないが「層ごとvitalityで圧縮強度を配分」という直交する着想。蒸留後の生徒をさらに圧縮する**後段**として組み合わせ、(サイズ, レイテンシ, 精度)パレートを描くのが筋。

### P3 — 次世代アーキテクチャ
- 該当新着なし。今日は入力ゼロ。lookback窓/キーワード(efficient transformer, SSM, attention alternative)が機能しているか、次回 topics.yaml 見直し時に収集ログを確認すること。
