# Rejected — 2026-07-13

- **2607.03118: Vidu S1: A Real-Time Interactive Video Generation Model** — 2026-07-11 に選定・ブリーフ作成済みの再提示 (3日連続で候補に登場、差分は hf_upvotes 114→120 のみ)。既読のため除外。fetch 側の既読 dedup 欠如による再浮上 (メモリ fetch-duplicate-candidates 参照)。
- **2601.16211: Why Can't I Open My Drawer? Mitigating Object-Driven Shortcuts in Zero-Shot Compositional Action Recognition** — 3/5。shortcut 学習の抑制 (co-occurrence を hard negative に使う正則化、temporal order への感度強制) は評価・学習双方に学びがあるが、Zero-Shot Compositional Action Recognition という対象分野が P1-P3 から遠い。wildcard 枠は最大1件で、同じ「shortcut」テーマならベンチマーク監査という形で P1 に直接転用できる Video-Oasis (2603.29616) が優先。hf_upvotes のタイブレークでも劣後 (48 vs 51)。

## 補足: 本枠候補ゼロ (2日連続)

candidates.json に P1 (planner_ai) / P2 (fm_distill_finetune) / P3 (next_arch) の本枠候補が今日も 1件も含まれず、wildcard 3件のみ。07-12 に続き2日連続の完全枯渇で、fetch_candidates.py の本枠取得の失敗が疑われる。取得ログと lookback 窓の確認が必要。
