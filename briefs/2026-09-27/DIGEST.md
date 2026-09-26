# 2026-09-27 (日) DIGEST

候補 **3 件** → 採用 **1 件** / 不採用 2 件。**上限 6 に対し 1。**

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch 0/2 ・ sns_wildcard **1/1**。

> **本流 3 トピックは今日も arXiv API の HTTP 406 で 0 件だった。これで 8 回連続になる。**ただし今日は週末で、arXiv は新着を公開していない。RSS の中身は 40 件すべてが 09-26 に数えた分と同じだった。**今日の取りこぼしは 0 件で、累計は 243 件のまま。**次に取りこぼしが増えるのは、平日の announce が再開したときである。
>
> wildcard 3 件のうち 2 件は 09-26 の再配信で、新規は 1 件だけだった。詳細は [rejected.md](rejected.md)。

---

## 今日読むべき TOP3

新しいブリーフは 1 本だけなので、2 番と 3 番は繰り越しになる。

### 1. Your Transformer Can Hold Two Thoughts at Once (`2609.29845`) —— 探索枠 / P2 2.0

**なぜ読むか: 「複数の teacher の出力を平均して蒸留の目標を作る」ときに、平均の取り方しだいで少数派の答えが消える理由を、具体的に示しているから。**

この論文は、2 つの無関係な文章の入力ベクトルを平均して LLM に 1 回通すと、出力に 2 本それぞれの次の単語が残ることを示した。ただし、softmax の前のスコア (logit) を平均すると、確率としては掛け算の平方根 (幾何平均) になる。そのため、「片方だけが強く推す答え」は大きく抑え込まれる。P2 で teacher を複数使う蒸留にそのまま当てはまる。答えが複数に分かれる軌跡予測では、目標を logit の平均で作るか確率の平均で作るかで、student が少数派の候補を学ぶかどうかが変わりうる。半日で比べられる。**なお、題名から期待される「推論 2 倍速」は、普通に 2 本を batch で流すのと同じ速度だった。**実用の主張ではなく、現象の観察として読むのがよい。

### 2. HelloWorld: Towards Practical Applications of Generative Driving World Models (`2609.28931`) —— 繰り越し / P3・P2 (ブリーフなし、スコアなし)

**なぜ読むか: fetch が壊れていなければ next_arch の最有力候補だった論文で、09-26 から 2 日続けて「読むべき」に挙がったまま、まだ誰も読んでいないから。**

2B の運転 world model (環境が次にどうなるかを予測・生成するモデル) で、7 カメラの映像と LiDAR (レーザー距離センサ) の点群を同時に生成し、少ないステップで生成できるよう蒸留もしている。P3 の構造と P2 の蒸留の両方にかかる。本流の fetch が直らない限り候補には入ってこない。そのため、読むなら手動で開く必要がある → https://arxiv.org/abs/2609.28931

### 3. Training Object Permanence in World Models (`2609.28654`) —— 09-26 のブリーフ / P3 3.0

**なぜ読むか: 今日も hf_upvotes 194 で注目度が最も高く、候補として再配信されたから。ブリーフは 09-26 にある。**

物体が物陰に隠れても存在し続けることを、動画生成型の world model が理解しているかを測る課題集。運転では、「駐車車両の陰に入った歩行者が、生成した未来の中で消える」失敗を数える評価に移せる。2 番の HelloWorld は、この評価をかける対象の第一候補でもある。→ [09-26 のブリーフ](../2026-09-26/2609.28654.md)

---

## 全ブリーフ

| # | id | 論文 | topic | project | スコア |
|---|---|---|---|---|---|
| 1 | [2609.29845](2609.29845.md) | Your Transformer Can Hold Two Thoughts at Once: Evidence of Linear Superposition in LLMs | sns_wildcard | EXPLORE → P2 / P3 | P2 2.0 / P3 1.5 |

[不採用 2 件、fetch 診断、繰り越し候補 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1 — 新しい材料なし

今日の候補に P1 向けのものは無かった。RSS で拾い直した planner_ai の一致は 09-26 と同じ 3 件で、運転に関係するのは交差点の歩行者の軌跡予測 (2609.29706) だけだった。09-26 の [Taste-Bench](../2026-09-26/2609.25804.md) で挙げた「seed 違いの closed-loop 実行 (planner の出力で自車を動かし続けるシミュレーション) で軌跡が分かれる点を掘り出す」実験が、引き続き最も手近な候補。

### P2 — multi-teacher の目標は「確率の平均」と「logit の平均」で別物

[Linear Superposition](2609.29845.md) は、logit を平均すると、確率としては 2 本の幾何平均になることを示した。そのため片方だけが推す答えは強く抑え込まれる。複数の teacher (seed や checkpoint が違うもので足りる) から蒸留するとき、`softmax(mean(logits))` と `mean(softmax(logits))` の 2 通りで student を作り、「1 つの teacher だけが上位に置いた候補」を student が残す率を比べる。もう 1 つの注意点として、この論文の self-distillation (同じモデルの凍結コピーを teacher にする蒸留) は、「混ぜた入力」に合わせるほど単独入力の性能を大きく落とした (perplexity 12.4 → 65.5)。P2 で mixup (入力と目標を同じ比率で混ぜる data augmentation) を蒸留に使うなら、単独入力の指標を別に記録しているかを確認しておく。

### P3 — 新しい材料なし。HelloWorld が未読のまま

今日の新規は P3 向けではない。RSS で拾い直した next_arch の 13 件は、すべて 09-26 と同じだった。運転の world model は HelloWorld (TOP3 の 2 番) の 1 本だけ。ほかに、VLA (Vision-Language-Action; 画像と言語から行動を出すモデル) の action token の作り方を見直す [DSD](https://arxiv.org/abs/2609.28865) と、world model で計画するとき近い中間目標を狙う [Aim Short](https://arxiv.org/abs/2609.30036) がある。いずれもブリーフは無い。
