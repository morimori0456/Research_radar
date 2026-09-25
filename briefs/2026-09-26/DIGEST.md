# 2026-09-26 (土) DIGEST

候補 **3 件** → 採用 **2 件** / 不採用 1 件。**上限 6 に対し 2。**

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch **1/2** ・ sns_wildcard **1/1**。

> **本流 3 トピックは今日も arXiv API の HTTP 406 で 0 件だった。これで 7 回連続になる。**同じ日の RSS で数えると、窓には 68 件あった。09-23 からの累計で **243 件**を失っている。RSS は今日も 5 本とも 200 で、中身は 09-25 分と 1 件も重ならない。**RSS はその日の分しか返さないので、直すまで毎日取りこぼし続ける。**
>
> 今日の候補は wildcard 3 件だけだったが、3 件とも新規だった。そのうち 1 件 (Object Permanence) は、RSS で確かめると next_arch の keyword に一致していた。本来は本流で届くはずの論文なので、next_arch の枠で採用した。
>
> 詳細は [rejected.md](rejected.md)。

---

## 今日読むべき TOP3

### 1. Training Object Permanence in World Models (`2609.28654`) —— P3 3.0

**なぜ読むか: 運転の world model (環境が次にどうなるかを予測・生成するモデル) で一番困る失敗、「駐車車両の陰に入った歩行者が、生成した未来の中で消える」を、1 問ずつ測る方法を示しているから。**

この論文は、物体が隠れても存在し続けること (object permanence) と、固い物体はすり抜けないこと (object solidity) を試す合成動画の課題を 150 種作った。動画を「鍵になる出来事の直前」で切り、続きを生成させて採点する。今の運転 world model の評価は画質の指標が中心で、この失敗を直接には測れない。同じ切り方を運転ログに当てれば、「隠れた物体が正しく再出現するか」を数えられる (ブリーフに半日で回せる手順を書いた)。**ただし、「学習で身に付く」というタイトルの主張は、fine-tuning 前のモデルと比べていないので、この論文からは確かめられない。**読むのは評価の作り方の部分でよい。

### 2. The Tasteful Agent (`2609.25804`) —— 探索枠 / P1 2.5・P2 2.5

**なぜ読むか: 「答えを知っている teacher から、答えを知らない student へ判断力を蒸留する」手順が、具体的な設定値つきで書かれているから。そして、「最終成否では差がつかないモデルが、途中の判断では差がつく」ことを示した評価の作り方が、planner の評価にも移せるから。**

LLM agent の実行記録から「方針が分かれた点」を自動で掘り出し、どちらが良かったかを後からの結果で決めて二択問題にする。最良のモデルでも正答率は 59.7% だった。二択なので偶然でも 50% である。蒸留では、同じモデルの teacher にだけ正解を見せて推論させ、student はそれを真似る。student の判断を助言として渡すと、別の agent の成功率が 14.6% から 33.7% に上がった。P2 では「将来の軌跡を見た teacher」からの蒸留、P1 では「seed 違いの closed-loop 実行の分岐点」での planner 比較が試せる。

### 3. HelloWorld: Towards Practical Applications of Generative Driving World Models (`2609.28931`) —— P3 / P2 (RSS で拾い直した候補。スコアなし)

**なぜ読むか: 今日の候補には入っていないが、fetch が生きていれば next_arch の最有力候補だったから。**

2B の運転 world model で、自車の動き・地図・周辺物体の 3D box を条件に、7 カメラの映像と LiDAR (レーザー距離センサ) の点群を同時に生成する。さらに、少ないステップで生成できるよう蒸留している。1 番の論文の「遮蔽の再出現率」を測る実験で、評価対象の第一候補になる。

---

## 全ブリーフ

| # | id | 論文 | topic (割当) | project | スコア |
|---|---|---|---|---|---|
| 1 | [2609.28654](2609.28654.md) | Training Object Permanence in World Models | next_arch (候補上は sns_wildcard) | P3 | P3 3.0 |
| 2 | [2609.25804](2609.25804.md) | The Tasteful Agent: Measuring and Improving Taste in Long-Horizon Tasks | sns_wildcard | EXPLORE → P1 / P2 | P1 2.5 / P2 2.5 |

[不採用 1 件、fetch 診断、RSS で拾い直した候補 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1 — 最終指標で差がつかない planner を「分岐の判断」で比べる

[Taste-Bench](2609.25804.md) では、SWE-bench Verified (コード修正の最終成功率を測る benchmark) の上位 4 モデルは 4.0 点以内に並んでいた。それが分岐の判断の問題では 10.7 点に開いた。P1 の closed-loop 評価でも、同じ場面を seed 違いで何度も走らせれば、軌跡が分かれる点を自動で掘り出せる。「分かれた後、最終的に良かった側を選んだ率」を planner ごとに出せば、人手の注釈なしで判断力のテスト集になる。既存のログがあれば半日で試せる。planner_ai の keyword での本流の一致は、RSS で拾い直しても運転関係は 1 件 (交差点の歩行者の軌跡予測) だけだった。

### P2 — 「未来を見た teacher」からの蒸留

[Taste-Bench](2609.25804.md) の蒸留は、teacher と student が同じモデルで、teacher にだけ正解を入力で見せる形だった。LoRA rank 16、forward KL (teacher の出力分布に student を寄せる標準的な蒸留 loss) で、A100 1 枚 2 時間。運転に置き換えると、teacher には数秒後の実際の周辺車両の動きを見せ、student には現在までの観測だけを渡す形になる。合流のように結末が分かれる場面で、正解軌跡だけで学ばせた場合より判断が良くなるかを確かめる価値がある。

### P3 — world model の評価に「遮蔽からの再出現」を足す

[Object Permanence](2609.28654.md) の結果で注目すべきは、同じ fine-tuning でも効き方が分かれた点である。遮蔽物の陰の追跡 (系統内 1〜3 位) には効いたが、衝突の力学 (8 位) には効きにくかった。運転 world model でも、「隠れた物体を覚えているか」と「接触・衝突を正しく描けるか」は別々に測るべきだ、という示唆になる。RSS で拾い直した next_arch の 22 件では、運転の world model は [HelloWorld](https://arxiv.org/abs/2609.28931) が 1 本あった。VLA (Vision-Language-Action; 画像と言語から行動を出すモデル) の action token の作り方を見直す [DSD](https://arxiv.org/abs/2609.28865) も、運転の軌跡の token 化に試せる。
