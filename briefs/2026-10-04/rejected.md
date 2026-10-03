# 2026-10-04 不採用: 1 件 (candidates.json 3 件のうち)

## §0 fetch 診断 (選別の前に実施)

- **fetch のエラーは無かった** (3 日連続)。`~/research_loop.log` の最新の実行では、planner_ai・fm_distill_finetune・next_arch の 3 トピックとも `0 new` で、`[fetch]   error` の行は無い。
- **0 件の原因は announce 遅延で、取りこぼしではない。**今日の fetch は 10-03T18:00Z (土曜 UTC) に走り、窓の下端 (cutoff) は 10-01T18:00Z。fm の keyword で arXiv API に直接問い合わせると、最新の論文の投稿時刻は `10-01T17:59:55Z` で、cutoff の 5 秒前だった。木曜 14:00 ET (=18:00Z) より後に投稿された論文は、月曜 00:00Z の announce まで API にも RSS にも出ない。だから土曜 UTC の fetch では、窓の中が構造的に空になる (memory の「土日月 0 件」の機構どおり)。
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ) は 5 本とも 200 を返したが、new/cross は 0 件。**土曜は announce が無いので、正常な空 feed。回収するものは無く、今日の喪失は 0 件。
- **予告: 10-06 の実行 (fetch は 10-05T18:00Z、月曜 UTC) で、木曜 18:00Z〜金曜 18:00Z の投稿分をまとめて失う見込み。**この分は月曜 00:00Z の announce で API に出る。しかし、その日の cutoff は 10-03T18:00Z なので、投稿時刻で窓を切る `parse_entries` は全部を窓の外として捨てる。fetch はエラー無しで `0 new` を返すはず。同じ分は月曜の RSS には載っているので、**10-06 は RSS 回収分を candidates と同じ基準で採点すること** (09-29 には同じ曜日に 40 件を失った)。10-05 の実行 (日曜 UTC) は API も RSS も空になる見込み。
- wildcard の 3 件は 3 件とも新規 (`briefs/` に既出なし)。3 件とも LLM の後学習の論文で、うち 2 件は OPD (on-policy distillation; student 自身の生成物の上で teacher に合わせる蒸留) の系統。

## §1 判断の分岐点

1. **RIDE (`2609.36484`) は wildcard から fm_distill_finetune に移して採用した (P2 4.0)。**topics.yaml の fm の keyword には 1 つも一致しないが、relevance_criteria にある「新しい loss」「capacity gap 対策」の両方に正面から当たる。keyword が一致しない理由は、abstract が蒸留を "on-policy distillation" とだけ呼んでいるため。09-21 の `2609.20511` と同じ形で、**「fm_distill に "on-policy distillation" / "distillation" を足す」修正 (欠陥③) の犠牲者の 2 例目**。今日は本流が 0 件で fm の枠が空いていたので、拾えた。
2. **探索枠は CrossFit (`2609.39102`) に使った。**分野は運転から最も遠いが、「pseudo-label を付ける側と検証する側が同じ誤りに合意し、内部の指標だけが伸びる」という失敗の型は、P2 の自動ラベリングのループと P1 の learned evaluator の両方にそのまま当てはまる。視野を広げる枠の趣旨に一番合う。
3. **UniEvo-VL は P2 3.0 で不採用 (下記)。**fm の 2 枠目も空いてはいた。それでも、直近 2 週間で OPD を 6 本以上読んでいることと、実行がボトルネック (出力が 0) の状況で読む量を増やす価値は低いことから、3.0 は採らなかった。

採用: P1 0/2 ・ P2 1/2 ・ P3 0/2 ・ wildcard 1/1 = **2/6**。

## §2 不採用

- 2609.38721: UniEvo-VL: An On-policy Self-Distillation Training Recipe for Multimodal Model Self-improvement — P2 3.0 (hf_upvotes 274) — 1 つの multimodal model に、teacher (自分の self-critique、つまり自己批評を privileged information として見せた文脈) と student (質問だけの文脈) の 2 役をさせる。student 自身の生成の軌跡の上で、2 つの拡散の分布の差を縮める。外部の teacher が要らないのは利点。「teacher だけが特権情報を見る」という構図は、運転の蒸留で、teacher に未来の正解軌跡や HD map (高精度地図) を見せ、student にはセンサ入力だけを与える定番の形と同じ。その意味で、P2 への移しやすさはある。落とした理由は 3 つ。評価が画像生成 (GenEval 0.747 → 0.808) だけであること。著者自身が「文字の描画では改善が一様でない」と書いていること。特権情報を使う蒸留の仕組み自体は、既読の 09-26 Tasteful Agent (`2609.25804`; 同じモデルの teacher にだけ正解を見せる privileged information distillation で、正答率 30.0 → 47.9%) と、運転の privileged distillation の定番でカバー済みであること。**次点 (P2 で特権情報型の自己蒸留を試すときに戻る)**。
