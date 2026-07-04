# DIGEST — 2026-07-05

候補 **3件**(すべて topic=sns_wildcard/EXPLORE)→ 選定 **1件**(deep research)、却下 2件。
上限: max_deep_per_day=6、quota P1=2 / P2=2 / P3=2 + wildcard≤1。
本日の配分: **wildcard=1**(P1/P2/P3 は本枠候補ゼロ)。
- 本日は P1/P2/P3 の該当新着が無く、届いたのは探索枠(sns_wildcard)3件のみ。探索枠は最大1件の制約に従い、最も学びが大きく実利のある1件だけを選定。
- hf_upvotes は SNS 注目度の代替=**副次シグナル**として扱い、relevance は上書きしていない。今回は relevance でも upvotes でも PAW が首位で判断が一致。

---

## 今日読むべき TOP3

> 本日は選定1件のみ。TOP1 に選定論文、TOP2/3 は「読むなら次点」として却下2件を理由付きで併記する(探索枠の枠制約による見送りであり、質は読む価値あり)。

1. **[2607.02512 — Program-as-Weights (PAW)](./2607.02512.md)** (wildcard/EXPLORE, 4/5, hf **68**)
   4B の compiler モデルが、自然言語の仕様から **小さな追加重み(parameter-efficient adapter; LoRA と同系の“挙動差分だけを持つ軽量パラメータ”)を直接生成**する。これを凍結した 0.6B interpreter に差すだけで、32B モデルへの直接 prompting と同等性能を **推論メモリ約 1/50・MacBook M3 で 30 tokens/s** で達成する。foundation model を「入力ごとの問題解決器」から「関数ごとに1度だけ呼ぶ道具作り」へ転換する枠組みで、**capacity gap(教師と生徒の容量差)を跨ぐ具体例**として P2 の蒸留/PEFT に直結。エッジ環境で推論を offline・低メモリに落とす適合レシピとしても今週すぐ試せる。

2. **[2607.02255 — AgenticSTS(却下: [rejected.md](./rejected.md))]** (wildcard, 3/5, hf 43) — *読むなら次点*
   long-horizon な LLM agent の memory を「各判断が何を見てよいかの contract(契約)」と捉え、生の全履歴を毎回 append する方式に代えて、**typed retrieval(型付き検索)で毎回ゼロから境界付き prompt を組み、各 memory 層を単独で ablation(寄与を切り分け測定)できる**設計を提案。評価の交絡を切り分ける実験設計として学びがあるが、対象が deck-building game の agent で自社プランナ評価からの距離が大きく、探索枠1件制約で見送り。

3. **[2607.02440 — EvoPolicyGym(却下: [rejected.md](./rejected.md))]** (wildcard, 3/5, hf 41) — *読むなら次点*
   固定の interaction budget(相互作用回数の上限)下で agent が policy を反復編集していく **Autonomous Policy Evolution** という評価設定と、**trajectory-level diagnostics(budget をどう配分し feedback をどう調整に変換したかを軌跡単位で診断)**を提供。「closed-loop の改善過程を最終スコアに潰さず診る」哲学は P1 と思想的に接続するが、対象が汎用 RL 環境で AD 適合は間接的。

---

## 全ブリーフ一覧

| id | title | project | score | hf | brief |
|---|---|---|---|---|---|
| 2607.02512 | Program-as-Weights (PAW) | EXPLORE (→P2) | 4 | 68 | [link](./2607.02512.md) |

却下候補と理由 → [rejected.md](./rejected.md)

---

## プロジェクト別の要点

### P1 — Planner AI + 評価
- 本日は該当新着なし。ただし却下2件が評価方法論として接点あり:
  - **AgenticSTS** の「bounded memory contract + 各層を単独 ablatable」は、評価で交絡を切り分ける設計思想として R1(HIL × conformal 評価)のメモに追加。
  - **EvoPolicyGym** の trajectory-level diagnostics(budget 配分の可視化)は、R1 で「介入頻度・過保守の配分を軌跡単位で可視化する」際の参考。

### P2 — Foundation Model 蒸留 + 適合
- 本日の目玉 **PAW**。通常の蒸留(教師出力を生徒に模倣)と違い、**教師 compiler が生徒の adapter 重みを直接生成する amortized 方式**で、R2「capacity gap 系統則」に新しい軸(0.6B が 32B に並ぶ具体点)を与える。
- まず試すべき: hypernetwork 型蒸留の予備検証(compiler が adapter を吐く方式を小規模タスクで再現し、feature/output 蒸留と同一 student サイズで精度/メモリ比較)、adapter emit vs LoRA fine-tune のコスト対効果、interpreter サイズを振った capacity gap の走査。
- 公開予定の **FuzzyBench(10M 例)**は蒸留/適合レシピ再現の外部データとして価値あり。

### P3 — 次世代アーキテクチャ(VLA / World Model / E2E)
- 本日は該当新着なし。運用メモ: 本日は本枠候補が全トピックでゼロ(fetch 側の新着が探索枠に偏った可能性)。lookback_days=2 の範囲で P1/P2/P3 のキーワードに掛かる候補が本当に無かったのか、次回 fetch_candidates.py の取得ログを確認する価値あり。
