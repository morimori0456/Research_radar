# DIGEST — 2026-07-06

候補 **3件**(すべて topic=sns_wildcard/EXPLORE、**2026-07-05 と同一の3 ID**)→ 選定 **1件**(deep research)、却下 2件。
上限: max_deep_per_day=6、quota P1=2 / P2=2 / P3=2 + wildcard≤1。
本日の配分: **wildcard=1**(P1/P2/P3 は本枠候補ゼロ)。
- 本日の candidates.json は昨日と完全に同一の3件で、hf_upvotes だけ微増(68/43/41 → 81/46/43)。fetch 側が新着を取れず前日分を再提示した可能性が高い(→ P3 運用メモ / [rejected.md](./rejected.md))。
- 通常なら首位の **PAW(4/5, hf 81)を採るところだが、PAW は昨日 deep research 済み**([../2026-07-05/2607.02512.md](../2026-07-05/2607.02512.md))。再ブリーフの学習価値はほぼゼロのため見送り、**未カバーで P1 の評価哲学に最も近い EvoPolicyGym を探索枠に採用**した。
- hf_upvotes は SNS 注目度の代替=**副次シグナル**。今回は「未カバーか否か」と P1 relevance で差がつき、upvotes によるタイブレークは不要だった。

---

## 今日読むべき TOP3

> 本日は新規選定1件。TOP1 に選定論文、TOP2/3 は「読むなら次点」として却下2件を理由付きで併記する。

1. **[2607.02440 — EvoPolicyGym](./2607.02440.md)** (wildcard/EXPLORE → P1, 3/5, hf 43)
   agent が **固定の interaction budget(環境とやり取りできる回数の上限)** の中で、実行可能な policy(方策=環境で動く制御ルール)を繰り返し編集して改善していく過程を、**最終スコア1点に潰さずに評価する**ベンチマーク。単なる順位表だけでなく、「budget をどう配分し、feedback をどう調整に変換したか」を **軌跡単位で診断(trajectory-level diagnostics)** できるのが肝。これは P1 が追う closed-loop 評価(プランナを走行 feedback で改善するループ)の思想そのもので、R1(HIL × conformal 評価)で「介入頻度・過保守の配分を可視化する」設計テンプレとして今週すぐ流用できる。読む価値は「評価設計の哲学」にある。

2. **[2607.02512 — Program-as-Weights (PAW)](./2607.02512.md)** (wildcard → P2, **4/5**, hf **81**) — *質は最高だが昨日既読*
   4B の compiler モデルが自然言語仕様から **parameter-efficient adapter(挙動差分だけを持つ軽量重み。LoRA と同系)を直接生成**し、凍結した 0.6B interpreter に差すだけで 32B への direct prompting と同等性能を **推論メモリ約 1/50・MacBook M3 で 30 tokens/s** で達成する。**capacity gap(教師と生徒の容量差)を跨ぐ具体例**として P2 の蒸留/PEFT に直結する目玉論文だが、**2026-07-05 に既に deep research 済み**のため本日は再ブリーフせず却下。詳細と実験アイデアは[昨日のブリーフ](../2026-07-05/2607.02512.md)を参照し、P2 の実行タスクとして継続する。

3. **[2607.02255 — AgenticSTS(却下: [rejected.md](./rejected.md))]** (wildcard, 3/5, hf 46) — *読むなら次点*
   long-horizon な LLM agent の memory を「各判断が何を見てよいかの contract(契約)」と捉え、生の全履歴を毎回 append する方式に代えて、**typed retrieval(型付き検索)で毎回ゼロから境界付き prompt を組み、各 memory 層を単独で ablation(切除して寄与を測定)できる**設計を提案。評価の交絡を切り分ける実験設計として学びはあるが、対象が deck-building game の agent memory で自社プランナ評価からの距離が大きく、探索枠1件制約で EvoPolicyGym に譲った。

---

## 全ブリーフ一覧

| id | title | project | score | hf | brief |
|---|---|---|---|---|---|
| 2607.02440 | EvoPolicyGym | EXPLORE (→P1) | 3 | 43 | [link](./2607.02440.md) |

却下候補と理由 → [rejected.md](./rejected.md)

---

## プロジェクト別の要点

### P1 — Planner AI + 評価
- 本日の目玉 **EvoPolicyGym**。「closed-loop で policy を反復改善する過程を、最終スコアに潰さず **軌跡単位で診断**する」という評価哲学が P1 の核心に直結。
- まず試すべき: (1) 自社 closed-loop シミュレータで、プランナが feedback(衝突・介入・快適性違反)を受けて改善する過程を「budget 配分 × feedback→調整」の軌跡単位で可視化、(2) シミュレーション実行回数を固定 budget として **budget あたりの改善量(sample efficiency)を一級の評価軸に格上げ**、(3) 「どのシナリオ族で正しい回避 mechanism を獲得したか」を R1 レポートに追加。
- 却下の **AgenticSTS**「bounded memory contract + 各層を単独 ablatable」も、評価で交絡を切り分ける設計思想として R1 のメモに保留継続。

### P2 — Foundation Model 蒸留 + 適合
- 本日は新規本枠候補なし。**PAW は昨日 deep research 済み**のため再掲せず、実行フェーズへ移行: hypernetwork 型蒸留の予備検証(compiler が adapter を吐く方式を小規模タスクで再現し feature/output 蒸留と同一 student サイズで精度/メモリ比較)、adapter emit vs LoRA fine-tune のコスト対効果、interpreter サイズを振った capacity gap 走査 — 詳細は[昨日のブリーフ](../2026-07-05/2607.02512.md)。
- 公開予定の **FuzzyBench(10M 例)** の公開状況を継続ウォッチ。

### P3 — 次世代アーキテクチャ(VLA / World Model / E2E)
- 本日は該当新着なし。**運用アラート**: candidates.json が 2026-07-05 と完全に同一の3件(hf のみ微増)で届いた。fetch_candidates.py が新着を取得できず前日分を再提示した、あるいは dedup が効いていない可能性が高い。次回実行前に fetch_candidates.py の取得ログ・lookback_days=2 の窓・重複除去ロジックを確認し、2日連続で本枠(P1/P2/P3)候補ゼロ+同一 wildcard が続いた原因を切り分けること。
