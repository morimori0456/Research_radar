# 2026-10-05 不採用: 2 件 (candidates.json 3 件のうち)

## §0 fetch 診断 (選別の前に実施)

- **fetch のエラーは無かった** (4 日連続)。`~/research_loop.log` の 10-05 03:00 の実行では、planner_ai・fm_distill_finetune・next_arch の 3 トピックとも `0 new` で、`[fetch]   error` の行は無い。
- **0 件の原因は announce 遅延で、取りこぼしではない。**fetch は 10-04T18:00Z (日曜 UTC) に走った。日曜は announce が無く、木曜 18:00Z より後の投稿は月曜 00:00Z まで API に出ない。
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ) は 5 本とも 200 を返し、new/cross は 0 件** (`/tmp/rss_1005.json`、18:00Z に取得)。日曜の正常な空 feed (09-28 と同じ)。**今日の喪失は 0 件。**
- **予告 (10-04 から継続): 10-06 の実行 (fetch は 10-05T18:00Z、月曜 UTC) で、木曜 18:00Z〜金曜 18:00Z の投稿分をまとめて失う見込み。**月曜の announce で API に出るが、cutoff (10-03T18:00Z) より前の投稿なので `parse_entries` が窓の外として捨て、エラー無しの `0 new` になるはず。**10-06 は RSS 回収分を candidates と同じ基準で採点すること。**
- **wildcard の 3 件のうち 1 件 (`2609.35259`) は既読** (09-30 に fm_distill_finetune で P2 4.5 としてブリーフ済み)。HF daily papers 経由の wildcard は、過去の briefs/ と照合されずに 5 日後に戻ってきた。欠陥② (dedup) が wildcard の経路にもある実例。

## §1 判断の分岐点

1. **探索枠は OneStreamer (`2610.01762`) に使った。**分野は動画 LLM だが、「モデル自身が書いた文章を記憶にする」という設計が、今日の P3 の AD-Memo とそのまま対になる。加えて、PSTL (状態が変わる時刻を重点的に監督する) は、運転データの「ほとんどが等速」という偏りへの処方として、P1/P3 に移せる。
2. **P3 の枠には、10-02 の RSS 回収分 AD-Memo (`2609.38641`; P3 4.0) を入れた。**3 日続けて「繰り越しの筆頭」と書かれたままブリーフが無かった。今日は本流が 0 件で P3 の枠が 2 つとも空いているので、繰り越しを書く日にした (memory の「本流 0 件の日に『読むものが無い』は成立しない」に従う)。
3. **GraphForge は fm の keyword `fine-tuning` に一致するが、本流には移さなかった。**一致は「Qwen を agent の軌跡で fine-tuning した」という一文だけで、relevance_criteria の「他機種・他ドメインへの適合」や蒸留の recipe には当たらない (下記)。

採用: P1 0/2 ・ P2 0/2 ・ P3 1/2 (繰り越し) ・ wildcard 1/1 = **2/6**。

## §2 不採用

- 2609.35259: On-Policy or Off-Policy Learning? A Systematic Study of Distillation Dynamics — **既読 (09-30 にブリーフ済み、P2 4.5)** (hf_upvotes 168) — 蒸留の性能を決めるのは on-policy かどうかより token 単位の KL の向き (forward / reverse) で、忘却を決めるのは学習率、という結果。内容は [09-30 のブリーフ](../2026-09-30/2609.35259.md) にある。重複なので再評価しない。
- 2609.38923: GraphForge: Training Working Agents with Graph-Anchored Workspace Synthesis — P1 2.0 / P2 2.0 (hf_upvotes 144) — 事務作業の agent (ファイルを読み、ツールを使い、成果物を作る LLM) の学習データを、実在のファイルの関係を表す evidence graph (どのファイルのどの記述が、どの事実の根拠かを表すグラフ) から合成する。課題文と採点 rubric (採点基準の項目リスト) を同じグラフから作るので、各採点項目が、検証に必要なファイルに結び付く。2,169 本の軌跡で Qwen3.6-27B を fine-tuning し、GDPVal +65.7。落とした理由は、分野が運転から遠く、転用できる部分が「rubric を根拠のデータに結び付けて、自動採点の質を上げる」という一般論に留まるため。P1 の評価で、シナリオと合否基準を同じ地図・同じログから自動生成する場合の参考にはなる。ただし、課題と採点基準を同じ出典から作るのは、昨日の CrossFit (`2609.39102`) が警告した「作る側と検証する側が同じ出典を見る」構図そのものでもある。探索枠は 1 件なので、運転の設計に直接つながる OneStreamer を優先した。
