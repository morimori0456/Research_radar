# Daily Digest — 2026-07-10

候補 39件 (+ wildcard 再提示 3件) から 5件を選定。planner_ai 1 / fm_distill_finetune 2 / next_arch 2 / wildcard 0 (3件全て既出、3日連続)。

## 今日読むべき TOP3

1. **[WM Admissibility (2607.07196)](2607.07196.md)** — world model をポリシー評価の合否判定器に使うなら、その world model 自体をまず認定せよ、という枠組みの提案。視覚的な生成品質で上位のモデルが「入力した行動どおりに世界が応答するか」では下位という**逆転**を driving world model 2 つで実証しており、見た目の指標 (FVD 等) を world model の信頼性の代理にしてはいけないことを示した。P3 の world model 開発と P1 の評価基盤の両方の設計判断に今すぐ効く。
2. **[Soft Clamp / Behavior Leverage Imbalance (2607.07050)](2607.07050.md)** — 複数 teacher からの蒸留で、集計 loss は健全なのに「tool を呼びすぎる」方向へ挙動が歪む現象を token レベルで解明。モード切替を担う少数の token が生成全体を支配する (leverage の不均衡) ためで、per-token の発散を soft に圧縮する校正 (Soft Clamp) で精度を保ったまま修正できる。蒸留を実務で回すときの「loss が下がっているのに挙動がおかしい」への診断手順として汎用性が高い。
3. **[K-Risk (2607.07103)](2607.07103.md)** — 欧中米 20 データセットから高リスク運転事象 31,398 件 (衝突寸前 1,036 件) を統一基準で抽出し、軌道 + LLM 生成の因果リスク分析を closed-loop simulator で検証付きで公開したデータセット。planner の安全性評価に不足しがちな long-tail シナリオの評価バンクとして即戦力で、まず extreme サブセット 1,036 件の取り込みを試す価値がある。

## 本日のブリーフ一覧

| ID | タイトル | Project | 点数 |
|---|---|---|---|
| [2607.07103](2607.07103.md) | K-Risk: 高リスク運転シナリオの知識拡張データセット | P1 | 4.5 |
| [2607.07050](2607.07050.md) | Multi-Teacher On-Policy Distillation の挙動シフトと Soft Clamp | P2 | 4.5 |
| [2607.06957](2607.06957.md) | Flow-ERD: Flow Matching + Entropy-Regularized Distillation の交通シミュレーション | P2 | 4.5 |
| [2607.07608](2607.07608.md) | LaMem-VLA: VLA の latent 空間ネイティブな Dual Memory | P3 | 4.5 |
| [2607.07196](2607.07196.md) | World Model シミュレータの admissibility 認定 (L0–L4) | P3 | 4.5 |

却下 34件の理由は [rejected.md](rejected.md)。次点は LoCA (P2, conv-aware PEFT)・NativeMEM (P3, VLA メモリ圧縮)・LingBot-World 2.0 (P3, 実時間 world model)。

## プロジェクト別の要点

### P1: Planner AI + 評価
- **K-Risk** で long-tail 高リスクシナリオの評価バンクが手に入る。extreme サブセットを closed-loop 評価へ取り込むのが最短の一手。
- **Flow-ERD** (P2 選定) は planner 評価側にも直結: sim agent の多様性を log-free に測る指標と、realism–diversity の Pareto front で評価環境を位置づける視点。
- **WM Admissibility** (P3 選定) は学習ベースシミュレータを評価に使う際の信頼性ゲートの設計指針。評価器の評価、という一段上の課題に枠組みを与える。

### P2: FM 蒸留 + 適合
- **Soft Clamp**: 蒸留の「集計指標に見えない挙動シフト」への token 位置別診断 + 低コストな per-token loss 校正。蒸留パイプラインに発散の位置別ログを足すだけでも価値がある。
- **Flow-ERD**: entropy 正則化 reverse-KL で「teacher 追従と多様性維持」を両立する closed-loop 蒸留 recipe。生成ポリシーの deployment 前調整の一般パターン。
- 次点の **LoCA** (conv 層の空間構造を壊さない PEFT) は vision FM 適合の本命級。再浮上したら選定検討。

### P3: 次世代アーキテクチャ
- 今日の主題は **VLA の長期記憶**: LaMem-VLA (検索型 dual memory を latent 系列に編み込む) と次点 NativeMEM (1 フレーム 1 token の極限圧縮) が対照的な解を提示。Markovian な現行 E2E 設計に長時間文脈をどう足すかの設計空間が急速に埋まりつつある。
- **WM Admissibility** は world model を「作る」だけでなく「信用してよい条件」を定義する初期研究。行動追従性テスト (L1–L2) の最小実装は自社 world model の health check として今すぐ作れる。

## 運用メモ
- wildcard 枠は 3 日連続で全件が再提示 (RynnWorld-4D はブリーフ済み、AlayaWorld / OmniOpt は却下済み)。fetch 側の既読 dedup 実装までは「briefs/ 配下の既存 id は既読」の選別側運用を継続する。
