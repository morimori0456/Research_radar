# Daily Research Digest — 2026-07-09

候補 50件 (P1: 1 / P2: 30 / P3: 16 / wildcard: 3) から **5件選定** (上限6)。
wildcard は3件全て既出 (2件ブリーフ済み・1件却下済み) のため今日は探索枠なし — fetch の既読 dedup 未実装が継続中。

## 今日読むべき TOP3

1. **[Point as Skeleton (2607.06516)](2607.06516.md)** — E2E 自動運転の評価が抱える「closed-loop の相互作用性 vs 実写の視覚忠実度」のトレードオフに、生成型センサシミュレーションで正面から答える論文。ego の行動を毎ステップ条件に入れた自己回帰映像生成を、蓄積点群の「骨格」で係留して誤差蓄積を抑え、nuPlan ベースの closed-loop 評価インターフェースまでコード公開している。P3 の world model と P1 の planner 評価の両方に直撃する、本日唯一の 5/5。
2. **[RynnWorld-4D (2607.06559)](2607.06559.md)** — world model の予測対象を RGB だけでなく depth と optical flow (画素ごとの動きベクトル) に広げると表現が行動に近づく、という設計仮説を大規模データ (2.5億フレーム) と実機 SOTA で裏付けた。多段 denoising を回さず内部表現から1回の forward で行動を出す policy 構成は、拡散系 world model を実時間制御に使う際のレイテンシ問題への実用解。hf 72 で本日のコミュニティ注目度も最高。
3. **[Few-Medoids (2607.05891)](2607.05891.md)** — 少データ蒸留のサンプル選定は「各クラスの平均に最も近い典型例を選ぶ」だけで random と既存手法に一貫して勝つ、という拍子抜けするほど単純な recipe。実装数行・コード公開で、今の蒸留パイプラインに今日から A/B テストを仕込める即効性が選定理由。凝った多様性最大化系の coreset selection が random に勝てないという比較結果自体も過剰設計への警鐘として有用。

## 全ブリーフ

| id | タイトル | project | 点 | hf |
|---|---|---|---|---|
| [2607.06499](2607.06499.md) | CE-MPPI: Clustering-Embedded MPPI | P1 | 3.5 | 0 |
| [2607.05891](2607.05891.md) | Few-Medoids: 少データ蒸留の coreset selection | P2 | 4 | 0 |
| [2607.06483](2607.06483.md) | 合成 pre-training で domain shift 克服 (floor plan) | P2 | 3.5 | 0 |
| [2607.06516](2607.06516.md) | Point as Skeleton: closed-loop AD シミュレーション | P3 | 5 | 0 |
| [2607.06559](2607.06559.md) | RynnWorld-4D: RGB+depth+flow の 4D world model | P3 | 4.5 | 72 |

却下 45件の理由は [rejected.md](rejected.md)。

## プロジェクト別の要点

### P1: Planner AI + 評価
- **CE-MPPI** は sampling-based planner の古典的な弱点 — 左回避と右回避の rollout を重み付き平均して障害物へ直進する averaging-induced failure — を、クラスタリングをコントロール則に組み込んで解く。「rollout 分布の多峰性を計測して hesitation を検出する」という評価メトリクスのアイデアが持ち帰りどころ。
- **Point as Skeleton** (P3 選定) は P1 にとっても重要: nuPlan ベースの renderer レベル closed-loop 評価系が公開されており、ログ再生評価と生成型 closed-loop 評価の指標乖離を測る実験が組める。
- 次点メモ: world model の長期破綻を診断する iKCE (2607.05966) は planner 評価に転用できる可能性があるが、まだ予備的。

### P2: FM 蒸留 + 適合
- **Few-Medoids**: 蒸留データ選定の即試せる baseline 改善。クラスラベルのないデータでは teacher embedding 空間の k-means medoid で代替する変種から。
- **合成 pre-training (2607.06483)**: 「実データに似せる」のでなく「守るべき物理制約だけ強制し、見た目のリアリズムは捨てて多様性を極大化した」procedural 合成データでの pre-training が、少データの新ドメイン適合を最大 40% 改善。他機種・他地域展開の recipe として直輸入を検討する価値あり。
- 次点筆頭は **FourTune (2607.05711)**: 4-bit 完全量子化での post-training 基盤。12B 級 diffusion の fine-tuning コストが問題になったら立ち返る。
- 運用メモ: domain adaptation は backbone が target ドメイン知識を欠くときだけ効き、adversarial 系は特化 backbone を壊しうる (2607.05937)。手元の Jetson に直接関係する fine-tuning 省エネ DVFS 論文 (2607.05933) もブックマーク。

### P3: 次世代アーキ (VLA / World Model / E2E)
- 今日は world model の当たり日。選定2本は補完関係: **Point as Skeleton** が「world model を E2E-AD の closed-loop 評価器として使う」方向、**RynnWorld-4D** が「world model の表現 (RGB-DF) を policy に直結する」方向。
- 共通する設計教訓: 純粋な画素予測に明示的な幾何 (点群骨格 / depth+flow) を係留すると、長時間 rollout の安定性と行動への接続が改善する。
- 次点筆頭 **Lift3D-VLA (2607.06564, 4.5点)** は VLA へ 3D を注入する設計として本日最良。VLA に幾何を入れる設計検討を始めるときは必読。RynnWorld-Teleop (兄弟論文, hf 67) は world model によるデモデータ量産という別軸で、データ収集がボトルネック化したら読む。

### EXPLORE (wildcard)
- 選定ゼロ。3件とも過去に処理済みの ID の再提示 (MIPI は3回目)。fetch_candidates.py に「briefs/*/ 配下の既存 id を除外」する dedup を入れるまで、この枠は機能不全が続く。
