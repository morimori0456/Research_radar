# 却下候補 — 2026-07-05

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **3件**(すべて topic=sns_wildcard/EXPLORE)→ 選定 **1件**、却下 **2件**。
- 本日は P1/P2/P3 の本枠候補がゼロで、wildcard 探索枠のみ。探索枠は **最大1件**の制約があるため、3件中で最も学びが大きく実利のある PAW(P2 に直結)を選定し、残り2件を見送った。
- hf_upvotes は副次シグナル(タイブレーク用)であり relevance を上書きしない。今回は relevance でも upvotes でも PAW(68)が首位で判断は一致。

---

## wildcard(sns_wildcard)— EXPLORE 枠は最大1件、PAW を選定

- **2607.02255: AgenticSTS — A Bounded-Memory Testbed for Long-Horizon LLM Agents** — score 3/5(hf 43)。「agent の memory は将来の各判断が何を見てよいかの contract(契約)」と捉え、生の全履歴を append する方式の代わりに、typed retrieval(型付き検索)で毎回ゼロから境界付きの prompt を組む方式を提案し、各 memory 層を単独で ablation(切除して寄与を測る)できるようにした点は方法論的に良質。Slay the Spire 2 上で skill 層追加により 3/10→6/10 勝利(ただし n=10 で Fisher exact p≈0.37、方向性どまりで統計的に決定的ではないと著者自身が明記)。**評価方法論(交絡を切り分ける実験設計)としては P1 の評価観点に間接的に通じる**が、対象が deck-building game の LLM agent memory で自社プランナ評価からの距離が大きく、探索枠1件制約により PAW に譲った。「bounded memory contract + 単独 ablatable」という設計思想は将来の評価基盤づくりのメモとして保留。

- **2607.02440: EvoPolicyGym — Evaluating Autonomous Policy Evolution in Interactive Environments** — score 3/5(hf 41)。固定の interaction budget(相互作用回数の上限)下で agent が実行可能な policy を反復編集する Autonomous Policy Evolution という評価設定を提案。最終スコアや汎用ソフトウェア工学の進捗と混同しがちな“policy 改善能力”を切り出し、trajectory-level diagnostics(軌跡単位の診断: budget をどう配分し feedback をどうパラメタ調整に変換したか)を提供する点が良い。GPT-5.5 が 16 環境で最強。**「closed-loop で policy を反復改善する過程を、最終スコアだけに潰さず診断する」という評価哲学は P1(closed-loop 評価・planner evaluation)と思想的に接続する**が、対象が compact な interactive RL 環境の汎用 agent で AD プランナ評価への適合は間接的。探索枠は P2 直結の PAW を優先し見送り。budget 配分の trajectory 診断という発想は R1(HIL × conformal 評価)で「介入頻度・過保守の配分を可視化する」際の参考としてメモ。
