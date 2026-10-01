# 2026-10-02 (金) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリはまだ無い)。

candidates.json の候補は **65 件** (planner_ai 4・fm_distill 30・next_arch 28・wildcard 3)。これに、RSS で回収した本流の未読 **91 件** を加えて採点した。**採用 6 件 / 不採用 150 件。上限 6 に対し 6。**

**quota の割当:** planner_ai 2/2 ・ fm_distill_finetune 2/2 ・ next_arch 2/2 ・ sns_wildcard 0/1。

> **今日は fetch のエラーが無かった** (09-23 以来初めて、3 トピックとも正常に返った)。**ただし fm_distill と next_arch は max_results=30 の上限に当たって、取得が途中で切れていた。**fm の 30 件は 09-30 の約 5 時間分、next は約 11 時間分しかない。RSS と照合すると、keyword に一致する論文のうち、fm は約 3/4、next は約半分が candidates.json に入っていなかった。
>
> **採用 6 本のうち 2 本 (TrafficSignBench・Truck VLA) はこの落ちた分から回収した**もので、どちらも今日の各トピックの最高点。エラーが止まっても、上限による取りこぼしは毎日起きる。詳細は [rejected.md §0](rejected.md)。

---

## 今日読むべき TOP3

### 1. Planning Limits of Latent World Models (`2609.39235`) —— P3 4.5 / P1 4.0

**なぜ読むか: 「world model の予測を正確にすれば planning も上手くなる」という前提が成り立たない範囲を、予測誤差ゼロの条件でも示したから。2D toy で、学習なしに半日で再現できる。**

world model (行動を入れると未来を予測するモデル) で planning するとき、「5 ステップ先まで想像して、終点が目標に一番近い行動を選ぶ」というやり方では、目標が想像の範囲より遠いと行動の良し悪しを区別できなくなる。予測器を 81 倍大きくしても改善しない。world model を本物の simulator (予測誤差ゼロ) に替えても、目標が 5 ステップ先なら成功率 92%、20 ステップ先なら 41% に落ちる。原因は予測の精度ではなく、想像する長さと目標までの距離が合っていないこと。10-01 の DRPE (`2609.32322`; 誤差の合計は planning の成否を説明しない) と同じ格子の環境で、本物の遷移を使えばネットワークを学習せずに確かめられる → [ブリーフ](2609.39235.md)

### 2. TrafficSignBench (`2609.38463`) —— P1 4.5

**なぜ読むか: planner の評価で使われる集計指標 (driving score・到達率・衝突率) が、交通ルール違反を見落とすことを数字で示した評価論文だから。データとコードが公開されていて、自分の planner をすぐに測れる。**

34 種の交通標識それぞれに違反の自動判定を付けた closed-loop (planner を simulator 内で実際に走らせて採点する) ベンチマーク。既存の planner 17 種で、「ルールを守って目的地に着く」率は 2.9〜9.0% しかない。衝突率は最も近い代理指標だが、経路選択のルール (進入禁止・一方通行など) とはほぼ相関が無い。ルールを守る教師データで fine-tuning すると 72.3% まで上がる。この論文で P1 に一番役立つのは、失敗を「ルール違反」と「守ったが着かなかった」に分けて数えていること。fine-tuning 後の失敗は、後者が 24.7% で、違反は 3.4% だった → [ブリーフ](2609.38463.md)

### 3. Driving VLA をトラックに適合 (`2609.38570`) —— P2 4.5 / P3 4.0

**なぜ読むか: P2 の「他機種への適合」の recipe と、それに必要なデータ量の比較が 1 本に揃っているから。**

乗用車で学習した公開の運転 VLA (Vision-Language-Action model; 画像と言語の理解から直接、走行軌跡を出すモデル) である NVIDIA の Alpamayo 1.5 を、大型トラックに適合させた。手順は 2 段。まず、画像と言語を扱う backbone を凍結して軌跡の生成部だけを fine-tuning する。次に、そのモデルも凍結して、生成の各ステップに小さな補正を足す。データは工事区間・事故現場の実トラック 229 場面だけで、軌跡の誤差は半分以下になった。同じ場面数なら、目的の場面に絞ったデータの方が一般の走行データより誤差が 19〜26% 低く、約 65 倍の一般データで fine-tuning したモデルと同等だった。ただし評価は open-loop (ログ上の軌跡との距離) のみで、test は 26 場面と小さい → [ブリーフ](2609.38570.md)

(繰り越し: AD-Memo `2609.38641` (運転 VLA が言語で記憶を書き出す) が今日の次点の筆頭。10-01 から繰り越した Bilinear World Models `2609.36305` と車両版の評価論文 `2609.32512` も、まだブリーフが無い。)

---

## 全ブリーフ

- [2609.38463 — TrafficSignBench: Rule-Centric Closed-Loop Evaluation of Traffic-Sign Compliance in Autonomous Driving](2609.38463.md) (planner_ai に再分類 / P1 4.5 / RSS 回収)
- [2609.38862 — EMPlan: Efficient Multi-Modal Planning with Reward-Guided Preference Optimization for Autonomous Driving](2609.38862.md) (planner_ai / P1 4.0)
- [2609.38570 — Data-Efficient Adaptation of a Driving VLA to Class 8 Trucks](2609.38570.md) (fm_distill_finetune に配属 / P2 4.5・P3 4.0 / RSS 回収)
- [2609.39692 — GFD-OPD: Guidance-Folded On-Policy Distillation of Diffusion Models Across Scales](2609.39692.md) (fm_distill_finetune / P2 4.0)
- [2609.39235 — The Planning Limits of Latent World Models](2609.39235.md) (next_arch / P3 4.5・P1 4.0)
- [2609.39245 — ReWAM: Reciprocal World Action Models for Interactive Autonomous Driving](2609.39245.md) (next_arch / P3 4.0)

[不採用 150 件 (candidates.json 61 件 + RSS 回収 89 件)、fetch 診断、次点 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1: Planner AI + 評価

- **集計指標では見えない失敗を、カテゴリに分けて数える。**TrafficSignBench は「違反」と「守ったが着かなかった」を分け、Planning Limits は「目標までの距離ごとに、expert の行動が何 % のランダム候補より上位か」を測る。どちらも、1 つの成功率にまとめると隠れる失敗を、別の軸に分けて取り出している。10-01 の DRPE と合わせると、P1 の評価指標で「何を分けて出すか」の候補が 3 つ揃う。
- **候補を選ぶ採点器を何で学習するか。**EMPlan は rule スコアの値を回帰させるのをやめ、ペアにしない preference (KTO; Kahneman-Tversky Optimization。良い例と悪い例を個別に与えるだけで学べる preference 学習) で候補の選び方を学ぶ。10-01 の World4Scorer (simulator の結果ラベルで学ぶ) と比べられる選択肢が 1 つ増えた。
- **評価の注意:** ReWAM は「他車との相互作用」を主張しているのに、評価は他車が反応しない NAVSIM だけで行っている。相互作用を主張する planner には、他車が反応する closed-loop 評価を必須にする根拠として使える。

### P2: Foundation Model 蒸留 + 適合

- **他機種への適合: backbone は凍結し、行動の生成部だけを、目的の場面に絞った少量のデータで学習する。**Truck VLA では、その後さらに凍結して、生成の途中を残差モジュールで補正すると誤差がもう一段下がった。データを集めるときは、量より場面の選び方が効く (65 倍の一般データと同等)。
- **拡散・flow 系を大→小で蒸留するときの capacity gap。**GFD-OPD によると、CFG (classifier-free guidance; 条件ありと条件なしの予測の差を拡大して条件への忠実度を上げる手法) が student の誤差を増幅していた。teacher の guided 出力を CFG を使わない student に直接合わせると、この増幅を避けられる。flow-matching の action head (Alpamayo など) や diffusion planner を小型化するときに、最初に確認する項目。
- 次点: transfer map (`2609.39702`; instruction-tuning のデータ混合で、片方向にしか効かない転移を事前に推定する) は、ドメイン適合でどのデータを混ぜるか決める方法として P2 に効く。

### P3: 次世代アーキテクチャ

- **world model を planning に組み込むとき、想像する長さ (horizon) と目標までの距離を揃える必要がある。**予測を正確にしたりモデルを大きくしたりしても、この条件は変わらない (Planning Limits)。現実的な選択肢は、近い subgoal を出す上位の仕組みを置くか、world model を「候補を選ぶ役」に限ること。VLA が出した候補から world model で選ぶと、成功率が 65% → 77% に上がった。
- **WAM (World Action Model; 未来シーンの生成と行動の生成を同時に行う構造) で、他車を「予測される対象」ではなく「自車に応答する主体」として扱う。**ReWAM は Level-k 推論 (相手が 1 段浅く考えると仮定して最適に応答する段階的な推論) を使い、Level-2 で効果の大半が出る。
- **flow-matching の action head は、重みを変えずに生成ステップ単位で手を入れられる。**Truck VLA は生成の途中を残差で補正し、次点の Real-Time VLAs (`2609.39822`) は生成のステップ数を 10 → 2 に減らした。適合 (P2) と高速化 (車載) の両方で、生成のステップ単位で手を入れる設計が使われている。
