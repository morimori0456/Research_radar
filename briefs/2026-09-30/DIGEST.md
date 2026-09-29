# 2026-09-30 (水) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリ自体が未作成。W39 の推薦 = 2D toy の初 commit は未着手)。

候補 **66 件** → 採用 **6 件** / 不採用 60 件。**上限 6 に対し 6。**

**quota の割当:** planner_ai 1/2 (next_arch から再分類 1) ・ fm_distill_finetune 2/2 ・ next_arch 2/2 ・ sns_wildcard 1/1 (中身は P2)。

> **arXiv API の 406 エラーは 10 回連続で止まり、本流が 09-22 以来 8 日ぶりに届いた。**ただし `fetch_candidates.py` は変わっておらず、直ったのは arXiv 側である。
>
> **代わりに件数上限 (`max_results=30`) が効いた。**fm_distill と next_arch はちょうど 30 件ずつで、それぞれ投稿時刻で 5 時間・7 時間分しかない。同じ窓で上限を 200 にすると 96 件・70 件あり、**104 件が上限で落ちていた。**その中に、今日の採用より関連度の高い論文が 3 本ある (AD-E2E-JEPA / SpecMatch / 小さい teacher の論文 → [rejected.md §4](rejected.md))。

---

## 今日読むべき TOP3

### 1. Control-Geometry Straightening (CGS; `2609.35603`) —— P3 4.0

**なぜ読むか: loss を 1 項足すだけの論文で、2D toy の初 commit にそのまま使えるから。W39 から 9 日止まっている着手 1 件の候補として、今日の中でいちばん小さく試せる。**

latent world model (画像を圧縮した潜在空間の中で「この行動をするとどうなるか」を予測するモデル) で planning するとき、予測が正確でも、良い行動列を探しにくい潜在空間になっていることがある。CGS は「似た向きの行動は、潜在空間でも似た向きに状態を動かす」ように表現を揃える loss を足し、ランダムに行動列を試す planner の成功率を最大 20 pt 上げた。2D の点を動かす環境で loss あり/なしの 2 回の学習を比べれば再現を確認できる (ブリーフの実験 1)。上限で落ちた **AD-E2E-JEPA (`2609.34085`)** は同じ LeWM を baseline に、この種の world model が **運転**で planning に足りるかを policy を学習せずに評価しており、2 本を並べると「toy で効く → 運転で効くか」の線がつながる → [ブリーフ](2609.35603.md)

### 2. RefineDrive (`2609.35078`) —— P1 4.0 / P3 4.0

**なぜ読むか: planner の失敗を「スコアが低い」で終わらせず、simulator から「何が・いつ起きたか」を取り出して学習に使う設計で、P1 の評価の記録方法をそのまま変えられるから。**

運転用の VLA (Vision-Language-Action; カメラ画像と言語から走行軌跡を直接出す大規模モデル) の失敗について、衝突や車線外へのはみ出しを simulator の状態から判定し、「失敗した軌跡の近くで、安全な人間の軌跡」を引いてきて修正の手本にする。さらに「安全でなければ前進しても点を与えない」段階的な報酬の RL で、NAVSIM (実走行データから作った運転 planner のベンチマーク) の総合スコアを 87.7 → 91.7 に上げた。P1 ですぐ使えるのは学習より評価側で、失敗の種類と発生時刻を記録すること、「どれだけずらせば安全だったか」を連続値の指標にすること、の 2 つ → [ブリーフ](2609.35078.md)

### 3. On-Policy or Off-Policy Learning? (`2609.35259`) —— P2 4.5

**なぜ読むか: 蒸留の設定を決めるとき、「student 自身に生成させたデータで学ぶか (on-policy)」は、思われているほど効かないと示したから。先に決めるべきは loss の向きと学習率だ、という優先順位が得られる。**

条件を 1 つずつ変えて比べると、性能を決めていたのは KL (2 つの確率分布のずれ) を teacher 基準で測るか student 基準で測るかの「向き」で、忘却を決めていたのは学習率だった。teacher 基準の向き (forward KL) なら、誰が生成したデータでも性能は安定する。on-policy のデータ生成は student の推論を回すぶん高くつくので、**off-policy で足りれば蒸留の計算コストがそのまま下がる。**これまで P2 で重視してきた「on-policy + 監督を当てる範囲」という読みの前提も、条件付きになる → [ブリーフ](2609.35259.md)

(09-29 から繰り越している P1 の 2 本 `2609.30818` / `2609.31383` と、HelloWorld `2609.28931` (**5 日連続で未読**) は、今日もブリーフがない。)

---

## 全ブリーフ

- [2609.35078 — RefineDrive: Reliable Failure-Guided Learning for Vision-Language-Action Driving](2609.35078.md) (planner_ai に再分類 / P1 4.0・P3 4.0)
- [2609.35259 — On-Policy or Off-Policy Learning? A Systematic Study of Distillation Dynamics](2609.35259.md) (fm_distill_finetune / P2 4.5)
- [2609.35319 — Teacher-Student Gaps Are Not Enough: Outcome-Guided On-Policy Distillation for Multi-Turn Autonomous Agents](2609.35319.md) (fm_distill_finetune / P2 4.0)
- [2609.35347 — Beyond Teacher Assignment: Domain-Normalized Multi-Teacher On-Policy Distillation](2609.35347.md) (sns_wildcard 枠 / P2 4.5 / hf 138)
- [2609.35603 — Control-Geometry Straightening for Sampling-Based Latent Planning](2609.35603.md) (next_arch / P3 4.0)
- [2609.35560 — WorldPlay2: Extending Real-Time Interactive World Models in Control and Horizon](2609.35560.md) (next_arch / P3 4.0 / hf 23)

[不採用 60 件、fetch 診断 (上限で 104 件落ちた)、繰り越し → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1 — 「失敗をどう記録するか」が 3 日分の論文で揃ってきた

planner_ai に届いた 3 件は、宇宙ステーションのロボット・連合学習・3DGS (3D Gaussian Splatting; 多数の 3D ガウス分布でシーンを表す表現) 上の衝突判定で、今日も運転の論文は 0 件 (keyword のずれ; 欠陥#7)。P1 枠は next_arch から RefineDrive を移して使った。09-29 の繰り越し 2 本 (候補の中から選ぶ段で間違える / 軌跡の途中の点が追従しにくい) と並べると、**失敗が「生成」「選択」「追従」のどこで起きたかを分けて記録する**、という評価設計の材料が揃う。上限で落ちた `2609.34684` (状態を当てられることと、状態の変化に予測が追従することは別) も同じ方向の論文。NUDGE (`2609.35231`; 障害物までの距離の勾配を推論時に足して、学習なしで回避する) は後処理で安全性を足す型で、ECO の隣に置く。

### P2 — on-policy distillation (student の生成に teacher が密に指導する蒸留) の論文が 1 日に 11 本

candidates.json に 5 本、上限で落ちた分に 6 本。共通する問いは **「teacher の指導を、どこに・どれだけ強く当てるか」**。
- **どこに:** OG-OPD (最終的に成功につながったターンに寄せる) ・ R²-OPD (同じ考え方の数学推論版) ・ 落ちた UOPD / DivOPD。
- **どれだけ強く:** DN-MOPD。複数の teacher の信号の大きさが揃っていないと 1 分野が学習を独占する。**固定重みでもほぼ同じ性能なので、実務では「分野ごとの loss の分散を 1 回測る」だけで効く可能性が高い。**
- **その前提として:** `2609.35259` が、on-policy そのものより KL の向きと学習率が効くと示した。
- 視覚の基盤モデルの蒸留に直結するのは、上限で落ちた SpecMatch (`2609.34106`; feature 蒸留の L2 loss は分散の小さい方向を学び残す) と `2609.34489` (データが少ないと小さい teacher が勝つ)。**今日の P2 で本来いちばん読むべきはこの 2 本で、fetch の上限を直さない限り毎日こういう取りこぼしが起きる。**

### P3 — latent world model で planning する論文が 3 本重なった

CGS (planning しやすい潜在空間を作る loss)・FlexiWorld (`2609.35138`; 行動のまとまりの長さを可変にする、次点)・上限で落ちた AD-E2E-JEPA (運転での評価と 100 倍の高速化) はいずれも JEPA (Joint-Embedding Predictive Architecture; 画素を復元せず、潜在空間の中で次の状態を予測する学習法) 系の world model で planning する。WorldPlay2 は映像を生成する側の world model で、長時間生成の誤差蓄積と蒸留の不安定さを、メモリ圧縮と rollout 全体の再生で抑える。運転の world model を closed-loop 評価に使うときの課題に直結する。
