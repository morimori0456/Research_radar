# Rejected — 2026-07-14

- **2607.08964: Long-Horizon-Terminal-Bench: Testing the Limits of Agents on Long-Horizon Terminal Tasks with Dense Reward-Based Grading** — 3/5。長時間タスクを graded subtask に分解して dense な中間報酬・部分点で評価する設計は、planning 評価 (P1) の「最終結果だけ見るスコアの粗さ」への処方箋として学びがある。ただし対象が terminal 上の AI agent (SWE・実験再現等) で、自動運転プランナーとはタスク構造が遠い。wildcard 枠は最大1件で、world model / E2E pretraining に直結する GenCeption (2607.09024, 4/5) を relevance 優先で選定。hf_upvotes は 43 vs 36 で本候補が上だが、hf_upvotes はタイブレーク専用のため relevance 差を覆さない。
- **2607.09657: Scalable Visual Pretraining for Language Intelligence** — 2/5。文書を text 抽出せず視覚のまま pretraining する方が text-only より強い、という主張は pretraining パラダイムの視野を広げるが、対象は言語知能の獲得であり P1-P3 (planner 評価・蒸留/適合・driving アーキテクチャ) への具体的な適用経路が見えない。同じ「pretraining パラダイム転換」テーマなら、知覚・3D理解への転移を実証した GenCeption の方が学びが直接的。

## 補足: 本枠候補ゼロ (3日連続)

candidates.json に P1 (planner_ai) / P2 (fm_distill_finetune) / P3 (next_arch) の本枠候補が今日も 1件も含まれず、wildcard 3件のみ (07-12, 07-13 に続き3日連続)。一方、昨日まで続いた既読の再提示 (Vidu S1) は今日は解消し、3件とも新規。fetch_candidates.py の本枠取得 (カテゴリ/キーワードのクエリ) の失敗が濃厚で、取得ログの確認が引き続き必要。
