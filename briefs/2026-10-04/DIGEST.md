# 2026-10-04 (日) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリはまだ無い)。

candidates.json の候補は **3 件** (本流 3 トピックは 0 件・wildcard 3 件)。**採用 2 件 / 不採用 1 件。上限 6 に対し 2。**

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 1/2 (wildcard から移した RIDE) ・ next_arch 0/2 ・ sns_wildcard 1/1。

> **本流の 0 件は、fetch の失敗ではなく announce 遅延による。**fetch のエラーは 3 日連続で無い。arXiv API の最新の論文は `10-01T17:59:55Z` の投稿で、今日の窓の下端 (10-01T18:00Z) の 5 秒前だった。木曜 18:00Z より後の投稿は、月曜 00:00Z まで arXiv に出てこない。RSS も、土曜は announce が無いので 5 本とも空。**今日の喪失は 0 件。**
>
> **予告: 10-06 の実行 (月曜 UTC の fetch) で、木〜金の投稿分を丸ごと失う見込み。**月曜に announce されるが、窓の外として捨てられ、fetch はエラー無しの `0 new` を返すはず。その日は RSS 回収分を採点すること。詳細は [rejected.md §0](rejected.md)。

---

## 今日読むべき TOP3

### 1. RIDE (`2609.36484`) —— P2 4.0

**なぜ読むか: 蒸留で student が teacher を超えるには、teacher を「目標地点」でなく「進む方向」として使えばよい、という主張だから。そのときの方向は、teacher と、その teacher を作る前の checkpoint の差で測る。P2 では、fine-tuning 前と後のモデルがどちらも手元にあるので、そのまま試せる。**

RL (強化学習) で後学習した teacher と、RL 前のモデルの内部表現 (各層の hidden state) の差を、層ごと・トークンごとに計算する。student の内部表現は、teacher からその差の方向にさらに少し先の点に寄せる。logit (出力の確率) の上で同じことをすると、最終層で変化が縮み、ノイズが増幅されて不安定になる。それを、表現の上で行うことで避けた。4 組の teacher で、RL 済みの teacher に迫るか上回り、平均で teacher を超えたのはこの手法だけだった。teacher の変化が小さいときは、logit の上での外挿はかえって student を悪化させた。これも P2 の蒸留 recipe の注意点として使える → [ブリーフ](2609.36484.md)

### 2. CrossFit (`2609.39102`) —— 探索枠 (P2 3.0 / P1 2.5)

**なぜ読むか: モデルが自分でラベルを付けて自分を鍛えるループでは、ラベルを付ける側と答える側が「同じ間違い」に合意して、内部の指標だけが伸びる。その失敗を測り、データを 2 つに分けるだけで抑えた。P2 の自動ラベリングにも、P1 の学習した評価器にも、同じ落とし穴がある。**

LLM の検索 agent で、問題を作るモデルと解くモデルが一緒に学習すると、ラウンドを重ねるほど「両方が同じ誤った答えに合意する」割合が増え、本当の正解率は横ばいか低下した。対策として、出典の文書を A・B に分け、A から作った問題は B だけで学習したモデルに採点させる。誤りへの合意の割合は 6.1 → 3.0%、下流の性能は平均 +8.8 点。運転では、走行ログを地域や車両で分け、片方で付けた pseudo-label (モデルが付けたラベル) を、もう片方で学習したモデルで検証する形に移せる。ブリーフに、CPU で数分の 2D toy の実験を 2 つ書いた → [ブリーフ](2609.39102.md)

### 3. (繰り越し) Criterion-aligned 補助 loss (`2610.01224`、10-03) —— P3 4.0 / P1 3.5

**なぜ読むか: 今日の新着は 2 本だけなので、3 枠目には「既読で、一番小さく試せるもの」を回す。日曜で新着も少ないので、読むより 1 本動かす日にしたい。**

latent world model (観測を圧縮した内部表現の中で未来を予測するモデル) の表現に、成否を決める物理量が十分な精度で入っているかを、線形の head を 1 つ付けるだけで診断できる。足りなければ、その head の誤差を学習中の loss に足せばよい。学習し直す前に、診断だけ先に回せる → [ブリーフ](../2026-10-03/2610.01224.md)

(繰り越し: 10-02 の AD-Memo `2609.38641` (運転 VLA の言語による記憶) は、今日もブリーフになっていない。今日の次点は UniEvo-VL `2609.38721` (同じモデルに、自己批評を見せる teacher 役と見せない student 役をさせる自己蒸留)。)

---

## 全ブリーフ

- [2609.36484 — The Teacher Is a Direction, Not a Destination: Extrapolating RL-Induced Representation Residuals in On-Policy Distillation](2609.36484.md) (fm_distill_finetune に配属 / P2 4.0 / wildcard から移した)
- [2609.39102 — False Frontiers: Diagnosing and Mitigating Co-Cheating in Self-Evolving Search Agents](2609.39102.md) (sns_wildcard / 探索枠)

[不採用 1 件、fetch 診断、10-06 の予告 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1: Planner AI + 評価

- 新着は 0 件 (announce 遅延)。
- CrossFit から得られるチェック項目: **learned evaluator (人の判断を真似して軌跡を採点する学習済みモデル) と被評価の planner が同じ走行ログで学習されていないか。**同じなら、共通の盲点を「問題なし」と採点しうる。「評価器の点数」と「外部の監査 (人のラベルや別のデータで学習した評価器)」の差を追う。

### P2: Foundation Model 蒸留 + 適合

- **RIDE:** 「適合前の base → 適合後の teacher」の差を、student に押し込む方向として使う。fine-tuning で作った teacher から蒸留するなら、base も teacher も手元にあるので試せる。前提は、hidden state 同士を対応付けられること。teacher と student で幅が違う場合は、射影の扱いを本文で確認する。
- **CrossFit:** pseudo-label のループを回すなら、ラベルを付けるデータと検証するデータを分ける。分割が本当に独立か (同じ地図・同じシナリオが両側にないか) が効果を左右する。
- **keyword の欠陥③ の 2 例目:** RIDE は "on-policy distillation" としか書いておらず、fm の keyword 8 個に 1 つも一致しない。今日は本流が 0 件で枠が空いていたので、wildcard から拾えた。平日なら本流のクエリに入らず、HF の注目度が無ければ見えなかった。
- OPD (on-policy distillation; student 自身の生成物の上で teacher に合わせる蒸留) に触れた既読ブリーフは、09-21 以降で 8 本ある (RIDE が 9 本目)。整理の軸は「何を target にするか」(logit / 系列の結果 / 表現の方向) と「誰のサンプルで学習するか」。

### P3: 次世代アーキテクチャ

- 新着は 0 件 (announce 遅延)。3 枠目の繰り越し (Criterion-aligned 補助 loss) が、今日の P3 の唯一の行動候補。
