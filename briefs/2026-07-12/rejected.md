# Rejected — 2026-07-12

候補は3件すべて sns_wildcard。うち2件が既読の再提示、1件 (SciReasoner) を探索枠で選定。既読2件を却下。

- **2607.03118: Vidu S1 — 既読却下**。2026-07-11 にブリーフ作成済み (briefs/2026-07-11/2607.03118.md、hf 107→114 の微増のみ)。3日連続で wildcard 上位に居座る再提示で、新規学習価値ゼロ。fetch 側の既読 dedup 未実装により hf_upvotes 上位を毎回取り直す構造の典型例。
- **2607.07608: LaMem-VLA (Dual Latent Memory in VLA) — 既読却下**。2026-07-10 にブリーフ作成済み (briefs/2026-07-10/2607.07608.md、当時 relevance 4.5/5、hf 44→51)。内容は P3 に高価値だが既に深掘り済みのため再選定せず。

## 運用メモ
- 本枠 (P1/P2/P3) の新規候補が今日はゼロで、candidates.json は wildcard 3件のみ。うち初出は SciReasoner (2607.07708) 1件だけ。
- wildcard の「既読除外なしで hf_upvotes 上位を再提示」構造は継続 ([[fetch-duplicate-candidates]] 参照)。fetch_candidates.py で briefs/*/ 配下の既存 id を除外する根本対応が引き続き必要。選別側の既読扱い除外は 07-12 も適用。
