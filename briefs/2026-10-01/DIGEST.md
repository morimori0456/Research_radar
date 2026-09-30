# 2026-10-01 (木) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリはまだ無い。W39 で推薦した 2D toy の初 commit は未着手)。

candidates.json の候補は **9 件** (planner_ai 6 件・wildcard 3 件)。これに RSS で回収した本流の未読 **198 件** (P2 120 件・P3 83 件のうち、両トピックに重複する 5 件を 1 件と数えた) を加えて採点し、**採用 6 件 / 不採用 201 件。上限 6 に対し 6。**

**quota の割当:** planner_ai 2/2 (2 本とも next_arch のクエリから再分類) ・ fm_distill_finetune 2/2 ・ next_arch 2/2 ・ sns_wildcard 0/1。

> **本流 2 トピックが今日も 0 件で、原因はまた fetch のエラー。**fm_distill は timeout、next_arch は HTTP 429 (リクエストが多すぎる) だった。09-30 に 406 が止まったあと、別の種類のエラーが出た。選別中に再クエリしても 429 のままだった。
>
> **今日は RSS で回収した本流も、candidates.json と同じ基準で採点した (採用 6 本はすべてこの分)。**過去 3 回は RSS 分を繰り越しに回したが、繰り越した論文はブリーフにならないまま残っている (09-29 の TOP3 2 本は 3 日目、HelloWorld は 6 日目)。今日の candidates.json だけで選ぶと、P2・P3 は 0 本になり、P1 も manipulation の論文 (最高 3.0) しか残らなかった。経緯は [rejected.md §0](rejected.md) にある。

---

## 今日読むべき TOP3

### 1. World4Scorer (`2609.36438`) —— P1 4.5

**なぜ読むか: 09-29 から読めていない「planner は候補の中に良い軌跡を持っているのに、選ぶ段で間違える」(`2609.30818`) への、学習側からの答えだから。2 本を並べると、評価で失敗を「生成」と「選択」に分けて記録する理由と、選択側の直し方が揃う。**

複数の軌跡を生成して採点で 1 本を選ぶ planner では、採点器は「走らなかった候補」も採点しなければならない。ところが走行ログには、実際に走った 1 本の未来しか残らない。World4Scorer は、simulator で全候補に結果 (衝突したか・どこまで進んだか) のラベルを付けて採点器を学習する。ログに残った本物の未来は、予測が現実から離れないよう繋ぎとめるためにだけ使う。NAVSIM-v2 (実走行ログから作った運転 planner のベンチマーク) で SOTA。P1 ですぐできるのは、自分の planner の候補集合に simulator で結果ラベルを付けて、**採点器の順位が正しいかを planner 全体の成績と切り離して測る**こと (ブリーフの実験 1) → [ブリーフ](2609.36438.md)

### 2. Not All Errors Matter (DRPE; `2609.32322`) —— P1 4.0 / P3 4.0

**なぜ読むか: 「予測の誤差が小さいモデルほど planning が上手い」という前提が崩れる、具体的な数字があるから。しかも 2D の格子で、学習なしに半日で再現でき、止まっている 2D toy の初 commit にいちばん近い。**

予測の誤差の合計が 1% しか違わない 2 つのモデルで、planning の成功率が 97% と 37% に分かれた。違いは、誤差が「意思決定に効く状態」に乗っていたかどうか。合計の誤差と成功率の相関は弱く (ρ = −0.25)、意思決定に効く次元だけの誤差 (DRPE; Decision-Relevant Prediction Error) とは強い (ρ = −0.84)。P1 では、他車の軌跡予測を平均の距離誤差で評価している部分を、「自車の経路に近い車の誤差」に重みを付けた指標と並べて出すだけで試せる。toy 版は、正解の遷移に大きさを固定したノイズを因子ごとに割り振るだけで作れて、ネットワークの学習がいらない → [ブリーフ](2609.32322.md)

### 3. SFT・RLVR・OPD の組み合わせ (`2609.31900`) —— P2 4.5

**なぜ読むか: 蒸留パイプラインの「段の順序」が、teacher の大きさより効くと示したから。P2 の既存の手順を、そのまま 3 項目の check list で見直せる。**

LLM の蒸留を 9 通りの teacher-student の組で比べると、効果を決めていたのは teacher の大きさではなく、student が teacher に追いつける「相性」だった。相性は前の段で変わる。student に短い予備学習を入れると蒸留が効き、**先に RL で強くした student は、同じ teacher から蒸留すると逆に性能が下がる。**teacher 側を student のタスクに寄せると、そのぶん蒸留後の精度も上がる。この 2 つの準備だけで、同じ蒸留ステップ数での精度が 29.2% → 43.8% になった。09-30 の TOP3 の `2609.35259` (loss の向きと学習率が、on-policy かどうかより効く) と合わせると、蒸留の recipe で先に決めるべき項目の順番がわかる → [ブリーフ](2609.31900.md)

(繰り越し: 09-29 の P1 の 2 本 `2609.30818` / `2609.31383` は 3 日目、HelloWorld `2609.28931` は **6 日目** で、どれもまだブリーフが無い。明日以降の繰り越しの最優先は Bilinear World Models `2609.36305` (planning 時間がほぼ 1/1000) と車両版の評価論文 `2609.32512`。)

---

## 全ブリーフ

- [2609.36438 — World4Scorer: Outcome-Grounded World Modeling for Autonomous Driving](2609.36438.md) (planner_ai に再分類 / P1 4.5・P3 4.0 / RSS 回収)
- [2609.32322 — Not All Errors Matter: Decision-Relevant Prediction Error Predicts Planning Quality](2609.32322.md) (planner_ai に再分類 / P1 4.0・P3 4.0 / RSS 回収)
- [2609.31900 — Understanding the Synergy between SFT, RLVR, and OPD in LLM Post-Training](2609.31900.md) (fm_distill_finetune / P2 4.5 / RSS 回収)
- [2609.36374 — OTT3R: Multi-View 3D Reconstruction and Fast Dataset Generation at 1% Compute](2609.36374.md) (fm_distill_finetune / P2 4.5 / RSS 回収)
- [2609.36851 — RoXDrive: Closed-Loop Reinforcement Learning for End-to-End Autonomous Driving via Action-Faithful Rollouts](2609.36851.md) (next_arch / P3 4.5 / RSS 回収)
- [2609.37441 — Anisotropic Representations Improve Planning in JEPA World Models](2609.37441.md) (next_arch / P3 4.0 / RSS 回収)

[不採用 201 件 (candidates.json 9 件 + RSS 回収分)、fetch 診断、次点 → rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1 —「予測の正確さ」ではなく「選択の正しさ」で評価する

candidates.json の planner_ai 6 件は、すべて manipulation か多脚ロボの論文だった (keyword のずれ; 欠陥#7)。運転の論文は今日も next_arch のクエリの側に来た。採用した 2 本と次点に共通する主張は、**全体の誤差や全体の成功率で評価すると、どこで間違えたのかが見えなくなる**ということ。
- World4Scorer: 採点器を、走らなかった候補まで含めて評価・学習する
- DRPE: 予測誤差を「意思決定に効く次元」に絞って測る
- 次点の Benchmark Bugs (`2609.37771`): 異常に良い結果を手がかりに、評価器のバグを 22 個見つけた。修正後は手法の順位が逆転した
- candidates.json 内の最高点 Executor-aware (`2609.36597`): 実行できない候補を選ぶ前に弾く

09-29 の繰り越し (選択で間違える / 追従しにくい) と合わせると、**失敗を「生成」「選択」「追従」のどの段で起きたかに分けて記録する**という評価設計の材料が、4 日分でほぼ揃った。次に要るのは論文ではなく、自分の planner のログでこの 3 段の分類を 1 回やってみることだ。

### P2 — 蒸留の効果は「teacher の大きさ」ではなく「相性」と「段取り」で決まる

- `2609.31900`: 相性は前の段で変わる。student の予備学習と teacher の適合で +50% (相対)
- 次点 Train4Merge (`2609.32303`): RL で作った teacher は初期値から離れていないので、student が追いやすい
- 次点 TeacherGRPO (`2609.33426`): teacher の側を student に寄せる

3 本とも、capacity gap (teacher が大きすぎると蒸留が効かない問題) を「teacher を小さくする」以外の方法で解く論文。視覚の側では OTT3R が、**大きな 3D 基盤モデルを GPU 2 枚で 1/10 に蒸留し、計算量 0.2% の追加学習で特定ドメインに特化させる**という 2 段の recipe を、コード付きで示した。P2 の「他ドメインへの適合」の予算を見積もる基準になる。

### P3 — LeWM の正則化の改良が 1 日で 4 本

AnisoWM・ATLAS・ALeWM・LRC-JEPA の 4 本が、いずれも LeWM (JEPA 型の小型 latent world model) を baseline に、**「予測は正確で collapse もしていないのに、planning に向かない潜在空間になる」**問題を直している。09-30 の CGS も同じ系統。今日ブリーフにした AnisoWM は、正則化の目標を全方向同じ分散から方向ごとに学習する分散に替えるだけなので、CGS と同じ 2D toy で 2×2 の比較ができる。運転の側では RoXDrive が、**world model を RL の学習環境に使う前に「行動を変えたら映像がそのとおり変わるか」を判定し、変わらないロールアウトを捨てる**方法で、安全違反を 27〜34% 減らした。P1 の DRPE・World4Scorer と合わせると、今日の 6 本のうち 4 本が「world model は予測の正確さではなく、意思決定への効き方で評価すべき」という同じ主張をしている。
