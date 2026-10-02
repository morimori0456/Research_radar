# 2026-10-03 (土) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリはまだ無い)。

candidates.json の候補は **66 件** (planner_ai 4・fm_distill 30・next_arch 29・wildcard 3)。これに、RSS で回収した本流の未読 **54 件** を加えて採点した。**採用 6 件 / 不採用 114 件。上限 6 に対し 6。**

**quota の割当:** planner_ai 2/2 ・ fm_distill_finetune 2/2 ・ next_arch 2/2 ・ sns_wildcard 0/1。

> **fetch のエラーは 2 日連続で 0 件。ただし fm_distill と next_arch は max_results=30 の上限に 3 日連続で当たった。**fm の 30 件は 10-01 の約 7.5 時間分しかなく、RSS と照合すると keyword に一致した fm の論文 66 件のうち 42 件が candidates.json に入っていなかった。**採用 6 本のうち 1 本 (DriftOPD) はこの落ちた分から回収した。**
>
> 照合の途中で、candidates.json の id には版番号 (`v1`) が付いていて、RSS と `briefs/` の id には付いていないことに気づいた。そのまま比べると重複が見つからない。dedup を実装するときの注意として [rejected.md §0](rejected.md) に書いた。wildcard の 3 件は 3 件とも過去の再配信。

---

## 今日読むべき TOP3

### 1. CLRE (`2610.00992`) —— P1 4.5

**なぜ読むか: 学習済みの運転 planner を一切変えずに、後ろに最適化の補正を足すだけで、closed-loop のスコアが 13 点上がることを示したから。逆に言えば、planner 同士の比較は後処理の差に大きく左右される。**

planner の出力軌跡を「参照」として、数秒先までの最適制御を初期値を変えて何度か解き、候補を作る。そのうち、予測された他車との距離が足りない候補を捨て、残った中で cost 最小のものを実行する。上流の planner は VAD (公開の E2E 運転モデル) のままで、新しい学習モデルは足していない。closed-loop (planner の出力で simulator 内の車を実際に動かして採点する方式) のベンチマーク Bench2Drive で、driving score 43.4 → 56.4、衝突 70 → 53 回。09-29 の ECO (終点を固定する後処理) に続く同じ型の 2 本目なので、P1 の評価では「後処理あり / なし」の両方のスコアを出す必要がある → [ブリーフ](2610.00992.md)

### 2. Criterion-aligned 補助 loss (`2610.01224`) —— P3 4.0 / P1 3.5

**なぜ読むか: 「world model の内部表現に、成否の判定に必要な情報が入っているか」を測る診断と、足りないときの直し方が、どちらも線形の head を 1 つ付けるだけで済むから。今日の 6 本の中で一番小さく試せる。**

latent world model (観測を圧縮した内部表現の中で未来を予測するモデル) で planning するときは、候補の行動を内部表現の距離で採点する。ところが、調べた 4 つのモデルすべてで、成否を決める物理量 (ロボットの手先の位置) が、成否の判定に必要な精度より粗くしか表現に入っていなかった。それでは成功する候補と失敗する候補を区別できない。学習中だけ、その物理量を回帰する線形 head を付けて誤差を loss に足すと、成功率が約 +3.5%。head は学習後に捨てるので、推論時のモデルは変わらない。運転なら、物理量を他車との最小距離や TTC (Time-to-Collision; 今の速度のままだと何秒後に衝突するか) にすればよい。10-02 の Planning Limits (予測が正確でも planning は失敗しうる) と組み合わせて読むと、world model の距離で採点する planning の弱点が 2 つの面から分かる → [ブリーフ](2610.01224.md)

### 3. PAGER (`2610.01589`) —— P2 4.0

**なぜ読むか: 基盤モデルを別の入力条件に移すとき、全体を fine-tuning するより、凍結して小さな module だけで合わせた方が、別のデータセットへの転移で強かった。P2 で「どこまで凍結するか」を決める根拠になる。**

3D の点群 encoder は部屋全体の点群で学習されているので、1 フレーム分しか見えない点群を入れると、分割の精度が 72 → 2.6 mIoU (領域分割の精度) に崩れる。PAGER は encoder を凍結し、小さな adapter だけを学習して、部分観測の特徴を全体の点群の特徴に合わせる。使う loss は 2 つで、「同じ点の特徴を一致させる」ものと「特徴同士の類似度の構造を保つ」もの。ラベルは不要。ラベルを使った PEFT (一部のパラメータだけを学習する適合) にも、全体を fine-tuning したモデルにも、別のデータセットへの転移で勝った (53.9 vs 48.1 mIoU)。運転では「地図の点群で学習した encoder を 1 フレームの LiDAR に使う」「別の車種のセンサ配置に移す」といった場面に同じ形で当てはまる → [ブリーフ](2610.01589.md)

(繰り越し: 10-02 の AD-Memo `2609.38641` (運転 VLA の言語による記憶) は、今日もブリーフになっていない。今日の次点は UniWAM `2610.02054` (人とロボットの co-training のスケール則) と Kinematic MeanFlow `2610.00864` (Jetson Orin で action head の遅延 -70%)。)

---

## 全ブリーフ

- [2610.00992 — Closed-Loop Refinement and Execution for Learned Driving Planners](2610.00992.md) (planner_ai / P1 4.5)
- [2610.01319 — Cross-entropy optimization with prioritized constraints](2610.01319.md) (planner_ai に再分類 / P1 3.5)
- [2610.00317 — DriftOPD: Sequence-Level Reverse-KL Distillation for One-Step VLA Policies](2610.00317.md) (fm_distill_finetune に配属 / P2 4.0・P3 4.0 / RSS 回収)
- [2610.01589 — PAGER: Partial-to-global Alignment via Geometric and Relational Distillation](2610.01589.md) (fm_distill_finetune / P2 4.0)
- [2610.01942 — Latent-Foresight: End-to-End Learning Predictable Representations for Latent World Models](2610.01942.md) (next_arch / P3 4.0)
- [2610.01224 — Supervise What Decides Success: Criterion-Aligned Auxiliary Losses for Latent World-Model Planning](2610.01224.md) (next_arch / P3 4.0・P1 3.5)

[不採用 114 件 (candidates.json 61 件 + RSS 回収 53 件)、fetch 診断、次点 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1: Planner AI + 評価

- **planner の比較から「後処理の寄与」を切り離す。**CLRE は planner を変えずに driving score を +13 点動かした。09-29 の ECO と合わせて、後処理だけでスコアが動く例が 2 本になった。P1 で planner を比べるときは、(a) planner の出力をそのまま実行、(b) 共通の後処理を通して実行、の 2 つのスコアを並べて出す。
- **失敗をカテゴリ別に数える設計がまた 1 つ。**CLRE が挙げる closed-loop の失敗は 3 種 (止まって動かない / 他車と衝突 / 急ブレーキ)。10-02 の TrafficSignBench (ルール違反 / 守ったが着かなかった) と合わせ、1 つのスコアにまとめずに出すカテゴリの候補が増えた。
- **rulebook を sampling 型の planner に入れる最小の方法。**TierCEM は「衝突回避 > ルール > 快適性 > 進捗」のような優先順位を、重みを付けずに候補のふるいの順序として入れる。重み付き cost の planner と並べれば、「重みを変えると、どの制約が破られるかが予測しにくい形で入れ替わる」ことを評価で示せる。
- **scorer の診断:** Criterion-aligned loss の診断 (内部表現から衝突の判定に必要な量を線形に読み出せるか) は、学習した scorer にも使える。

### P2: Foundation Model 蒸留 + 適合

- **蒸留 loss を「各時刻の模倣 + 将来への影響」に分ける。**DriftOPD は、sequence 全体の reverse-KL (student 側から見た teacher との KL divergence) が、各 chunk の模倣の項と、今の行動が将来に与える影響の項に分かれることを示した。後者は offline のデモから学習した Q 関数で見積もる。運転の planner を蒸留するとき、軌跡の誤差に「数秒後に危険になるか」の項を足す形にそのまま移せる。
- **凍結 + 軽量 module の方が転移に強い。**PAGER は、凍結した基盤モデルの特徴空間を teacher とみなし、別の入力条件 (部分観測) をそこに合わせた。全体を fine-tuning するより、別のデータセットへの転移で強かった。10-02 の Truck VLA (backbone を凍結して生成部だけ適合) と同じ方向で、「どこまで凍結するか」の根拠が 2 本になった。
- **次点のうち「どの入力で蒸留するか」:** 表形式 FM の蒸留 recipe (`2610.01435`) は、合成した query で入力の被覆を広げると student が強くなる、と報告している。運転なら、ログに少ない場面を合成して teacher に採点させることに当たる。

### P3: 次世代アーキテクチャ (VLA / World Model / E2E)

- **latent world model の「表現に何を残すか」が、今日の 2 本 + 10-02 の 1 本で 3 方向に揃った。**(1) Latent-Foresight: 予測しやすい表現を、tokenizer と予測器の同時学習で作る。(2) Criterion-aligned loss: 成否を決める物理量を補助 loss で残させる。(3) 10-02 の Planning Limits: 予測が完璧でも、採点の仕方がずれると planning は失敗する。2D toy で 3 つを同じ環境に入れて比べる実験が、ブリーフの実験アイデアからそのまま組める。
- **1 ステップ化が車載の現実解になりつつある。**DriftOPD (offline で 1 ステップに蒸留) と、次点の Kinematic MeanFlow (Jetson Orin で action head の遅延 -67〜74%) は、flow/拡散型の action head を車載の計算予算に載せる 2 つの方法。
- **スケール則 (次点 UniWAM):** 人の一人称視点データとロボットデータを混ぜた co-training で、性能がデータ量に対して log-linear に伸びる。運転でも、人の運転動画 (行動ラベル無し) を混ぜて事前学習する設計の根拠になりうる。

### 探索枠 (sns_wildcard)

- 今日は空き。3 件とも 10-01・10-02 の再配信で、新規の wildcard は 0 件。
