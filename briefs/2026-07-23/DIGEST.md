# DIGEST — 2026-07-23

> 候補 47 件。採用 **6 件(P1×2・P2×2・P3×2)** で max_deep_per_day=6 に到達。**本枠だけで上限が埋まり、wildcard は 0 件。**
> **注記:** sns_wildcard の 3 件(RynnBrain 1.1・TimeLens2・RAGU)は **全て過去にブリーフ済みの重複再提示**だった。今日は本枠が強く実害はなかったが、dedup 欠如の症状は継続([[fetch-duplicate-candidates]])。
> 本日のテーマは明確で **「生成分布・未来を *展開して* 選別/監督する」**。world model(P3)・on-policy 蒸留(P2)・particle rollout 計画(P1)が同じ原理で並んだ。

---

## 今日読むべき TOP3

### 1. Masked Visual Actions — action を「動画中の軌跡」として与える world model(P3、本命・横断)
本日いちばん射程が広い 1 本。video model が学んだ物理 prior に、**action を pixel 空間の *部分開示された軌跡* として渡す**という一手。これで同じ 1 モデルが「行動→シーン応答」を予測する forward dynamics にも、「望む物体運動→必要な行動」を出す inverse にもなる。効く理由が我々に直結で、**imagined rollout の結果が実行結果と相関 → 候補となる複数の未来を順位付けして planning を改善**できる。つまり P3(action を視覚空間で条件付けする world model 設計)と P1(rollout で planner を評価・選別)を同時に射抜く。実写+シミュ 15 時間の finetune で動く点も適合コスト面で好材料。→ [ブリーフ](2607.19343.md)

### 2. ABot-World-0 — 長ホライズンで崩れない action-conditioned world model(P3、本日最注目 hf=148)
world model を長時間 autoregressive に回すと必ず起きる **drift(誤差蓄積で世界が崩壊)** に、正面から効く 2 つの技を提示。**LongForcing**(student の長い self-rollout を、より長ホライズンの teacher に整合させ distribution shift を抑える訓練)と、**ODE distillation**(多ステップの拡散/フロー生成を少ステップに蒸留)。この 2 つは、我々が driving world model を 30–60 秒 rollout で使う時の drift 対策テンプレートそのもの。加えて RTX 5090 単体で 720P 16 FPS の推論スタック co-design は、軽量な closed-loop 評価環境を自前で組む足場になる。→ [ブリーフ](2607.19191.md)

### 3. Stochastic Multi-Objective Kinodynamic Planning — 「反応性」を織り込んで過保守を減らす計画(P1、本命)
我々が NAVSIM で悩む **「open-loop 評価は自車の反応を無視して過保守になる」** 問題を、計画空間を **closed-loop policy の系列** に移して解く。risk 評価を **Monte-Carlo particle rollout**(粒子で未来を確率展開)で木構築に直接組み込み、**cost(進行)と risk(衝突確率)の Pareto-front** を出す。しかも非ガウス・状態依存の不確実性に対し有限サンプルでの違反確率上界を導出。planner を単一スコアでなく **collision-vs-progress のフロントで比較する評価軸** に流用できるのが持ち帰り。→ [ブリーフ](2607.19284.md)

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| P1 planner | [2607.19284](2607.19284.md) | Stochastic Multi-Objective Kinodynamic Planning(closed-loop policy 空間 + particle rollout risk) |
| P1 planner | [2607.18887](2607.18887.md) | NaviAIS/NaviLane(vectorized lane prior + consequence-aware evaluator。海事→AD の方法論移植) |
| P2 distill/ft | [2607.18835](2607.18835.md) | ABOPD(on-policy distillation で生成軌跡上を teacher が監督) |
| P2 distill/ft | [2607.19171](2607.19171.md) | Point Ladder Tuning(凍結 point backbone + 2.7% param の局所性 PEFT) |
| P3 next_arch | [2607.19343](2607.19343.md) | Masked Visual Actions(pixel 軌跡で action 条件付けする world model) |
| P3 next_arch | [2607.19191](2607.19191.md) | ABot-World-0(LongForcing + ODE distillation で長ホライズン world model) |

落選 41 件の理由(近い次点 🔶 付き): [rejected.md](rejected.md)

---

## プロジェクト別の要点

- **P1(Planner AI + 評価):** 本枠 3 件中 2 件採用。中心は **「未来を展開して選別する」評価思想**。Kinodynamic Planning([[2607.19284]])は「open-loop 過保守 → closed-loop policy + particle rollout で cost-vs-risk の Pareto-front」を提供し、我々の NAVSIM の open-loop/closed-loop 乖離論点に直撃。NaviLane([[2607.18887]])からは **consequence-aware evaluator(候補を interaction risk で順位付け)** と **discrete macro-action codebook(可変個数の未来を離散意図で表現)** を持ち帰り(海事ドメインなのでコード直用は不可、方法論移植)。**明日立てられる実験:** 候補プランを particle rollout で展開して collision 確率を有限サンプル上界付きで推定 → open-loop collision 指標との過保守差を定量化。

- **P2(FM 蒸留 + 適合):** 相補的な 2 件。**ABOPD**([[2607.18835]])= **on-policy distillation**(student 自身の生成軌跡上で teacher が監督し exposure bias を潰す)という反復/自己回帰生成モデル全般に効く recipe。**Point Ladder Tuning**([[2607.19171]])= 凍結 point backbone + 2.7% param で「downsampling が捨てた局所幾何を ladder で拾い直す」PEFT で、**AD の LiDAR 知覚適合に直結**。実験候補: (1) offline 蒸留 vs on-policy 蒸留で closed-loop drift を比較、(2) 別 LiDAR 機種への domain adaptation を PLT の instance-aware prompt だけで。**次点で読む価値大:** FiT([[2607.18725]]、fine-tune が小型 LLM の知識を毀損する事前診断)。

- **P3(次世代アーキ):** world model 2 件で本枠確保、しかも横断性が高い。**Masked Visual Actions**([[2607.19343]])は action を視覚空間の軌跡で条件付け → AD の連続軌跡 action と相性良く、rollout ランキングで P1 評価も兼ねる。**ABot-World-0**([[2607.19191]])は **LongForcing / ODE distillation** で long-horizon drift を抑える具体手法。**共通原理は「生成分布上で teacher を当てる」** で、ABOPD(P2)とも地続き。次点 AlayaRenderer-Flash([[2607.18703]]、physics state→RGB を実時間蒸留)、RoboInter1.5([[2607.18709]]、intermediate representation で world 予測を条件付け)も追跡価値。

- **横断(本日の芯):** **「未来を *展開して* 選別・監督する」** が P1(particle rollout での risk 選別)・P2(on-policy 蒸留で生成軌跡を監督)・P3(world model rollout のランキング/LongForcing)を貫く。**具体化実験:** 学習済み driving world model 上で自車候補軌跡を Masked Visual Action として展開し、rollout 上の collision/progress で planner をランキング → 実 closed-loop メトリクスとの相関を測る(open-loop で closed-loop を近似できるか)。ここに Kinodynamic の particle-rollout risk 上界を接ぐと、world model 上の closed-loop risk 推定パイプラインになる。

---

## パイプライン状況

- **本枠(P1/P2/P3)は良質で 6 枠を自足。** arXiv 取得は今日は成功。
- **dedup 欠如は今日も顕在** — sns_wildcard の 3 件が **全て過去ブリーフ済みの重複**(RynnBrain 1.1・TimeLens2 = 昨日 07-22、RAGU = 07-21 で 3 日連続再提示)。今日は本枠が強く wildcard 枠を使わなかったため実害ゼロだったが、探索枠が重複で潰れる構造は未修正。
- 根治(取得失敗の握り潰し検知 + wildcard の dedup)は依然として判断待ち。→ [[fetch-duplicate-candidates]]
