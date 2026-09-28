# 2026-09-29 (火) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (W39 の推薦 = CodeMidas ヒストグラムの 2D toy 初 commit は未着手)。

候補 **3 件** → 採用 **1 件** / 不採用 2 件。**上限 6 に対し 1。**

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch 0/2 ・ sns_wildcard 1/1。

> **本流 3 トピックは arXiv API の HTTP 406 で 0 件。10 回連続。**今日は日曜夜の announce 分が届く初日で、RSS で数えると **本流 keyword に一致する 40 件 (P1 3 / P2 22 / P3 15) を取りこぼした。累計 283 件。**
>
> 候補は wildcard 3 件だけで、FuseReg を探索枠で採用した。ただし今日いちばん読む価値があるのは、候補に入らなかった RSS 側の 2 本である ([rejected.md](rejected.md) の繰り越し)。

---

## 今日読むべき TOP3

### 1. Evaluation Is All You Need for Multi-Modal Autonomous Driving (`2609.30818`) —— RSS 繰り越し / P1 (ブリーフなし・スコアなし)

**なぜ読むか: 「planner の出した候補の中に良い軌跡はあるのに、選ぶ段で間違えている」という、P1 の評価設計そのものに関わる主張だから。**

複数の軌跡候補を出す planner では、「候補の中の最良」で採点すると高得点なのに、実際に 1 本を選ぶと点が大きく落ちる。つまり伸びしろは生成ではなく選択の側にある、という指摘。P1 の評価でも「候補集合の最良スコア」と「実際に選ばれた軌跡のスコア」を別々に記録すれば、同じ差があるかをすぐ確かめられる。fetch が壊れていて候補に入らなかったので、手動で開く → https://arxiv.org/abs/2609.30818

### 2. Guiding End-to-End Driving Models with Endpoint-Constrained Trajectory Optimization (`2609.31383`) —— RSS 繰り越し / P1・P3 (ブリーフなし・スコアなし)

**なぜ読むか: 学習なしの後処理 1 層で closed-loop の成績が上がる、という主張で、2D toy で半日あれば確かめられるから。**

E2E 運転モデル (カメラ入力から直接軌跡を出すモデル) の予測軌跡は、終点は正確でも途中の点が車で追従しにくい形になっている。そこで、終点と車の直前の走行履歴を固定し、途中の点だけを滑らかに整え直す (ECO)。6 種類の policy すべてが 2 つの closed-loop simulator (車の動きが次の入力に反映されるシミュレーション) で改善した。W39 で決めた 2D toy の初 commit の候補としても、CodeMidas ヒストグラムと並べられる小ささである → https://arxiv.org/abs/2609.31383

### 3. FuseReg (`2609.31620`) —— 今日のブリーフ / 探索枠 P3 2.5・P2 2.0

**なぜ読むか: 凍結した基盤モデルの特徴を下流で使うとき、「どの層を使うか」を決め打ちせずに済む、計算コストゼロの工夫だから。**

学習中に encoder のどの層を混ぜるかを毎回ランダムに変えるだけで、1 つの decoder がどの層の組み合わせでも使えるようになり、画像生成の品質も上がった (gFID 3.01 → 2.21)。P3 の world model の latent を何層目から取るか、P2 の feature 蒸留で teacher のどの層に合わせるか、の両方に同じ実験がそのまま移せる。→ [ブリーフ](2609.31620.md)

(HelloWorld `2609.28931` は **4 日連続で未読**。P3 の最有力の繰り越しなのは変わらない。)

---

## 全ブリーフ

- [2609.31620 — FuseReg: Regularizing Layer Fusion Mitigates the Reconstruction-Generation Gap in Representation Autoencoders](2609.31620.md) (sns_wildcard / P3 2.5)

[不採用 2 件、fetch 診断 (40 件取りこぼし)、RSS 繰り越し 7 件 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1 — 候補 0 件だが、RSS 側に評価設計の 2 本がある

fetch に届いた P1 候補は 0。RSS 側で、「候補の生成より選択が弱い」(TOP3 の 1 番) と「途中 waypoint の追従しにくさが open-loop と closed-loop の差を生む」(TOP3 の 2 番) が見つかった。どちらも P1 の評価指標に「oracle (候補中の最良) と選択結果の差」「途中 waypoint の追従性」という 2 つの記録項目を足す根拠になる。closed-loop シミュレーションの描画品質の RECAST (`2609.31374`) も繰り越しに置いた。W39 の着手 1 件は、今日も未着手 (上の 0 件)。

### P2 — 新規ブリーフなし。RSS の 22 件は大半が一般の fine-tuning

FuseReg の「teacher の層をランダムな部分集合で平均して目標にする」は、feature 蒸留の層選択を減らす半日の実験になる ([ブリーフ](2609.31620.md) の実験アイデア 2)。RSS 側では、蒸留時の prompt 書式で student の既存能力が崩れる話 (`2609.30802`) と、teacher の細かい層を student の粗い層に合わせる cross-scale 蒸留 (`2609.30395`) が P2 に近い。

### P3 — world model の特徴の使い方が 2 本重なった

FuseReg (凍結 encoder のどの層を latent にするか) と、RSS 側の WALT (`2609.30436`; 凍結した運転 world model の特徴を軌跡の latent に移す) は、どちらも「凍結した事前学習モデルの特徴を、下流でどう取り出すか」の話で、併読すると設計の選択肢が揃う。HelloWorld は 4 日未読のまま。
