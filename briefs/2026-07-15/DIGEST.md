# Research Digest — 2026-07-15

候補 40 件超から deep 6 件を選定(P1×1, P2×2, P3×2, wildcard×1 = max_deep_per_day 上限)。
今日は久しぶりに P1/P2/P3 の本枠候補が揃って届いた(直近3日続いた「wildcard のみ」問題は解消)。

---

## 今日読むべき TOP3

### 1. Direct-OPD — 蒸留を「最終状態のコピー」から「RL の変化分の転送」へ (2607.05394, hf 91)
小さいモデルで検証可能報酬 RL(答えの正誤を自動判定して報酬にする学習)を安く回し、その **学習前後のチェックポイントの log 比**を「RL がどの行動を増やした/減らしたか」の密な報酬として強い student に適用する。ターゲットの大モデル上で高価な RL を回さずに済む。Qwen3-1.7B を AIME 2024 で 48.3→58.3% に 4時間で改善。**なぜ読むべきか**: P2 の蒸留 recipe に直接効く新しい定式化で、「差分を蒸留する」という発想は driving ポリシーの世代交代(小モデルで安全に検証した改善を本番モデルへ移す)にも写像できる。wildcard 枠だが本線価値が最も高い。

### 2. UMoE — 推論コストを一切増やさずに MoE をドメイン適合させる前処理 (2607.11444, 5/5)
MoE(入力ごとに一部の expert だけ使う疎なモデル)を特定ドメインに fine-tuning すると、多くの expert が遊んだまま残る。UMoE は SFT の前に「低寄与 expert を prune → 摂動で元数まで regrow」するだけで、パラメータ数・推論コストを据え置いたまま 2アーキ×5ドメイン×12ベンチすべてで通常 SFT を上回る(math +3.4pt、SWE-bench Verified +6.0pt)。**なぜ読むべきか**: エッジ配備前提の P2 と相性が良い「コスト不変の適合 recipe」。ハイパラをドメインごとに触らない単一 recipe で効くのが実務的に強い。

### 3. See like a Robot — 観測と行動の座標系ずれを ego 座標 pointmap で埋める (2607.11498, 4/5)
VLA は action をロボット座標系で出すのにシーンをカメラ座標で見ており、多様なカメラ設置のデータでは視点汎化が難しくなる。各ピクセルに **ロボット座標系の 3D 座標**を格納した pointmap を追加入力するだけ(dense グリッド形状は保つので既存 2D VLA に最小改修)で、未知のカメラ配置への汎化が大きく改善。**なぜ読むべきか**: 自動運転はマルチカメラ + ego-vehicle 座標系で、まさにこの frame mismatch を抱える。ego-frame pointmap への読み替えで既存の driving VLA/E2E モデルに後付けでき、車種・センサ構成をまたぐ転用(P2 的適合)にも波及しうる。

---

## 全ブリーフ一覧

| id | title | topic | score |
|----|-------|-------|-------|
| [2607.05394](2607.05394.md) | Weak-to-Strong Generalization via Direct On-Policy Distillation | wildcard→P2 | 5/5 (hf91) |
| [2607.11444](2607.11444.md) | UMoE: Unlocking Every Expert in Domain-Specific Training | P2 | 5/5 |
| [2607.11498](2607.11498.md) | See like a Robot: Robot-Centric Pointmaps for VLA | P3 | 4/5 |
| [2607.11397](2607.11397.md) | WALA: Executable Latent Actions from Action-Free Videos | P3 | 4/5 |
| [2607.11557](2607.11557.md) | SAKD: Shift-Augmented Knowledge Distillation | P2 | 4/5 |
| [2607.11442](2607.11442.md) | Velocity Scheduled Flow Matching (VSFM) | P1 | 3/5 |

不採用の全候補と理由は [rejected.md](rejected.md) 参照。

---

## プロジェクト別の要点

### P1 — Planner AI + 評価
- **VSFM (2607.11442)**: flow matching の「一定速度」前提を、motion planning 由来の速度プロファイルに一般化。**再学習なしで推論時の積分グリッドを変えるだけ**で NFE(推論コスト)を抑えつつ品質改善。生成系の軌道プランナーはNFEがそのままレイテンシ予算になるため、ほぼゼロコストで試せる改善候補。評価面では「NFE を横軸にした品質カーブ」を生成系プランナー比較の標準プロトコルに入れる価値。
- 今日は planner 評価指標そのものの新提案(本来の最優先)は無し。CR-Solver / DEX-RL はキーワード一致のみで不採用。

### P2 — Foundation Model 蒸留 + 適合
- **蒸留 recipe が今日の主軸**。3つの異なる切り口が揃った:
  - **Direct-OPD (2607.05394)**: teacher の RL 前後の差分(log 比)を dense reward として転送。weak→strong で高価な RL を回避。
  - **UMoE (2607.11444)**: SFT 前に expert プールをドメインへ組み替え。推論コスト不変でドメイン適合。
  - **SAKD (2607.11557)**: student の進化中の特徴を条件に cyclic shift でビュー生成。追加パラメータ・多段学習なしで multi-teacher 級の多様性。capacity gap 対策。
- 共通テーマ: いずれも**既存の学習ループへの小改修**で足せる軽量 recipe。手元の蒸留/適合パイプラインで A/B 比較しやすい。次点の LaGuadia(言語誘導 multi-teacher 蒸留)、ARMT(context 拡張 recipe)も要フォロー(rejected.md)。

### P3 — 次世代アーキテクチャ (VLA / World Model / E2E)
- **pointmaps (2607.11498)**: 観測と行動の frame mismatch を ego 座標 pointmap で解消。driving のマルチカメラ + ego 座標構図に直接写像でき、最小改修で既存 VLA に足せる。視点/センサ構成をまたぐ汎化に効く。
- **WALA (2607.11397)**: action ラベルなし動画からダイナミクスを学ぶ。豊富なドライブ動画の活用に直結。予測ターゲットを raw pixel でなく **DINOv3 特徴 + depth の delta** にする設計は driving world model のターゲット設計への示唆。
- 2つを合わせると「大量のラベルなし運転動画 (WALA) を、ego 座標の幾何 (pointmaps) で構造化して VLA/world model を学習・適合する」という次世代 driving スタックの設計仮説が立つ。次点 Lumo-2(world model + scaling 則)、Xiaomi-U0(world foundation model as data engine)も方向性が近く継続監視。

---

## 運用メモ

- 本枠(P1/P2/P3)候補が本日は正常に届いた。直近3日続いた wildcard 偏りは解消。念のため [fetch の重複候補疑い](../../) の件(candidates.json が前日と同一で届く疑い)は、今日の3 wildcard(2607.05394 / .10383 / .10350)が過去 briefs に未出であることを確認済み — 今日は重複なし。
