# DIGEST 2026-11-02

採用は 6 本 (P1 1 / P2 2 / P3 2 / sns_wildcard 1)。**candidates.json は 3 件で、3 件とも sns_wildcard、本流 3 トピックは 0 件だった。** 日曜 18:00Z の fetch は通常 0 件になる (arXiv の announce が月曜 00:00Z まで出ない機構) ので、fetch の欠陥ではない。RSS も 5 カテゴリすべてが 0 件 (lastBuildDate 2026-11-01 04:00Z) で、喪失は 0 件。空いた枠は、10-31 / 11-01 の rejected.md に残した次点 (評価 3.5) の繰り越しで埋めた。ブリーフはすべて abstract のみに基づく。

## 今日読むべきTOP3

1. **[2610.39451 Smooth Action Chunking: 出力の表現を替えるだけで軌道のガタつきを減らす](2610.39451.md)** (P3) — policy が数 step 先の action をまとめて出す方式 (action chunking) は、軌道が jerk (加加速度; 加速度の時間変化で、滑らかさの指標) の大きいガタついたものになり、chunk と chunk のつなぎ目でも不連続が出る。この論文は、軌道を「滑らかな基底関数の線形結合」(movement primitive) として表し、policy には係数を出させる。architecture も loss も変えず、chunk 内の jerk が 2.4 倍〜1 桁下がり、つなぎ目の不連続も 73-84% 減る。運転の E2E (画像から直接軌道を出す方式) は同じ構造で再計画するので、乗り心地の指標として移せる。ただし検証は manipulation のみで、急ブレーキのような急な変化を基底で表せるかは未確認。ブリーフに最小の検証を書いた。
2. **[2610.38001 逐次 fine-tuning で distillation が元の能力を守る](2610.38001.md)** (P2) — 基盤モデルを domain A、B の順に LoRA (低ランクの差分だけを学習する軽量 fine-tuning) で適合させると、元の model が持っていた性質が劣化する。この論文は、劣化を防ぐ 2 つの手段 (過去の振る舞いの例を混ぜる replay と、元の model の出力に近づける distillation) を切り分けた。distillation だけで劣化がほぼ防げ、replay が起こす「安全な依頼まで断る」副作用も小さい。対象は LLM の safety で、そのまま運転には移せないが、「元の model を教師にした KL 項を適合の正則化に使う」recipe は少データの他機種適合に直結する。内部の特徴の類似度が振る舞いの代理にならない、という結果も、適合後の健全性チェックの注意点になる。
3. **[2610.40026 RoboSeed: 成功率だけでなく cost と証拠の欠測も並べる評価](2610.40026.md)** (P3、評価設計は P1) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) と WAM (world model と行動出力を組み合わせた model) を、capability、学習し直す cost、動かす cost、手元での検証、再現の証拠の 5 dimension で 0-100 の profile にする。測れていない項目は空欄で残し、欠測のある総合点は出さない。予算で最適な backbone が変わることを示している。planner の評価でも「閉ループの score 1 つ」から「欠測を隠さない profile」に変える設計の手本になる。anchor の値は robot 用なので、運転版は作り直しが要る。

## 全ブリーフへのリンク

- [2610.39451](2610.39451.md) — Smooth Action Chunking: movement primitive で chunk を滑らかにする (P3 / next_arch / 3.5 / 次点の繰り越し)
- [2610.38001](2610.38001.md) — Sequential Fine-Tuning の safety 劣化: replay と logit distillation の切り分け (P2 / fm_distill_finetune / 3.5 / 次点の繰り越し)
- [2610.40026](2610.40026.md) — RoboSeed: VLA と WAM の 5 dimension 評価 (P3・P1 / next_arch / 3.5 / 次点の繰り越し)
- [2610.40257](2610.40257.md) — Learned Terminal Costs: MPC の終端 cost を RL の value で与える (P1 / planner_ai / 3.5 / 次点の繰り越し)
- [2610.39516](2610.39516.md) — LiDAR の sensor 間 domain generalization: 重ねた scan の occupancy を補助教師にする (P2 / fm_distill_finetune / 3.5 / 次点の繰り越し)
- [2610.39302](2610.39302.md) — Platonic Representation Hypothesis を JEPA で証明: good views が alignment の鍵 (P3・P2 関連 / sns_wildcard / 3.5 / hf 62)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 2 件、次の空き日に使える次点 11 件、RSS 0 件の確認)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 1 本のみ。Learned Terminal Costs は、制約を守る MPC を残し、先の見積もりだけを RL の value に任せる分担を示す。評価は simulation のみで数値も abstract に無いので、手法の採用より、構成の切り方 (terminal cost ゼロ、base policy の rollout、RL 単独、hybrid) を比較の型として借りる価値が大きい。評価設計は RoboSeed も効く。最小実験は、手元の MPC 型 planner の horizon を短くしたときに、terminal cost を学習した value に替えて衝突率がどう変わるかを測ること。planner_ai の本流は今日 0 件。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本はどちらも「他の domain へ適合するとき、何を教師・制約に使うか」の話。LiDAR の論文は **target を見ず、教師だけを豊かにする** (重ねた scan の occupancy を補助 loss にする) ことで、推論 cost を増やさずに未知の sensor へ効かせる。Sequential fine-tuning の論文は、**元の model の出力を教師にした distillation** で、適合による劣化を抑える。共通するのは、適合のために新しい仕組みを足さず、損失の側で解く点である。LiDAR 側は効く条件が「certain setups」で、abstract に数値が無い。最小実験は、重ねる scan の枚数を変えて汎化の変化を見ること。
- **P3 (次世代アーキテクチャ)**: Smooth Action Chunking は出力表現の設計、RoboSeed は候補を選ぶ評価の枠組み。wildcard の JEPA (Joint-Embedding Predictive Architecture; 同じ場面の 2 つの view の一方から他方の embedding を予測する自己教師あり学習) の論文は、「どの 2 つの観測を positive pair にするか」が表現の質を決めると主張する。world model の latent を設計するときの問いとして使える。最小実験は、手元の別々の 2 つの encoder に同期データを通し、回転 1 つで揃うかを測ること。

## 運用メモ

- candidates.json は 3 件 (generated_at 2026-11-01T18:00Z)。3 件とも sns_wildcard で、id は 2610.36671 / 2610.38568 / 2610.39302。過去のブリーフ・rejected のどこにも無い新規で、うち 1 本 (2610.39302) を採用した。wildcard の再来は今日は無い。
- RSS は cs.LG / cs.CL / cs.CV / cs.RO / cs.AI の 5 カテゴリすべてが 0 件 (lastBuildDate 2026-11-01 04:00Z)。10-31 の cs.AI の 605 件のような再配信も無く、keyword 一致の新規は 0 件。fetch の log は確認していない。
- 次点の記録に評価と理由を残せば、本流が空の日の枠をそのまま消化できる運用を 11-01 から続けた。rejected.md に、評価 3.5 の次点 11 件を繰り越し用に残した。
- 月曜 announce 分 (金曜夜〜日曜の投稿) が候補に入るのは、次の fetch (月曜 18:00Z) から。そこで本流が 0 件のままなら、log の `[fetch]   error` を最初に見る。
