# 却下候補 — 2026-07-06

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **3件**(すべて topic=sns_wildcard/EXPLORE、しかも 2026-07-05 と同一の3 ID)→ 選定 **1件**(2607.02440 EvoPolicyGym)、却下 **2件**。

- **運用上の重要事項**: 本日の candidates.json は昨日と **完全に同じ3件**(id: 2607.02512 / 2607.02255 / 2607.02440)。hf_upvotes だけが 68/43/41 → 81/46/43 に微増している。fetch_candidates.py が新着を取れず前日分を再提示した可能性が高く、次回 fetch のログ/dedup 挙動を確認する価値あり(P3 の運用メモにも記載)。
- 探索枠(sns_wildcard)は **最大1件**。通常なら relevance でも upvotes でも首位の PAW(4/5, hf 81)を採るところだが、**PAW は昨日 2026-07-05 に deep research 済み**(→ [../2026-07-05/2607.02512.md](../2026-07-05/2607.02512.md))。再ブリーフの **限界学習価値はほぼゼロ**のため、探索枠の目的(=学びの価値)に照らして PAW を見送り、**未カバーで P1 評価哲学に最も近い EvoPolicyGym を採用**した。
- hf_upvotes は副次シグナル(タイブレーク用)で relevance を上書きしない。今回は「未カバーか否か」と「P1 relevance」で差がついたため upvotes によるタイブレークは不要だった。

---

## wildcard(sns_wildcard)— EXPLORE 枠は最大1件、EvoPolicyGym を選定

- **2607.02512: Program-as-Weights (PAW)** — relevance 4/5(hf **81**、本日候補中の最高評価・最高 upvotes)。4B compiler が自然言語仕様から parameter-efficient adapter(挙動差分だけを持つ軽量重み。LoRA と同系)を直接生成し、凍結 0.6B interpreter に差すだけで 32B への direct prompting と同等性能を推論メモリ約 1/50 で達成する枠組み。P2(蒸留/PEFT)に直結し質は極めて高いが、**2026-07-05 に既に deep research 済み**([../2026-07-05/2607.02512.md](../2026-07-05/2607.02512.md))。同一論文の再ブリーフは新たな学びを生まないため、探索枠1件を新規学習に充てる方針で本日は却下。実験アイデア(hypernetwork 型蒸留の予備検証 等)は昨日のブリーフに記載済みで、そちらを P2 の実行タスクとして継続する。

- **2607.02255: AgenticSTS — A Bounded-Memory Testbed for Long-Horizon LLM Agents** — relevance 3/5(hf 46)。「agent の memory は将来の各判断が何を見てよいかの contract(契約)」と捉え、生の全履歴を毎回 append する方式に代えて、typed retrieval(型付き検索)で毎回ゼロから境界付き prompt を組み、各 memory 層を単独で ablation(切除して寄与を測る)できる設計を提案。Slay the Spire 2 上で skill 層追加により 3/10→6/10 勝利(ただし n=10、Fisher exact p≈0.37 で方向性どまりと著者自身が明記)。評価の交絡を切り分ける実験設計としては良質で **P1 の評価観点に間接的に通じる**が、対象が deck-building game の LLM agent memory で自社プランナ評価からの距離が大きい。探索枠1件を、より P1(closed-loop 評価)に近い EvoPolicyGym に譲った。「bounded memory contract + 単独 ablatable」の設計思想は将来の評価基盤メモとして保留(昨日と同じ保留判断を継続)。

---

## 選定側との比較メモ(なぜ EvoPolicyGym を残したか)
AgenticSTS と EvoPolicyGym はどちらも「評価方法論」系で relevance 3/5 と接戦。決め手は **P1 のキーワード適合度**: EvoPolicyGym は "closed-loop で policy を反復改善する過程を最終スコアに潰さず診断する" 設計で、topics.yaml の P1 が高優先に挙げる "closed-loop simulation" / "planner evaluation" に **より直接**掛かる。AgenticSTS は memory contract の評価設計であり接続はやや間接的。hf は AgenticSTS(46)> EvoPolicyGym(43)だが、relevance で差がついたため副次シグナルでは覆さない、という方針どおりに判断した。
