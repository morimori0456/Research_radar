# rejected 2026-11-09

採用 0 本。candidates.json は 3 件で、すべて sns_wildcard (generated_at 2026-11-08T18:00Z = 日曜夜の fetch。planner_ai / fm_distill_finetune / next_arch は 0 件)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。採用の閾値は直近の運用と同じ 3.5 点。

## 不採用

- 2611.08449: VFlash: Fast, Accurate Visual Planning via Flash Primitive Decoding — [3.5 / 既読] 2026-11-08 に wildcard 枠でブリーフ済み ([briefs/2026-11-08/2611.08449.md](../2026-11-08/2611.08449.md))。同じ内容を書き直さない。published は 11-04 で、昨日の candidates.json にも載っていた論文の再来。
- 2611.08373: SLA: Scaling Spatial-Language-Action Model via Continual Pre-training — [3.5 / 既読] 2026-11-08 に next_arch としてブリーフ済み ([briefs/2026-11-08/2611.08373.md](../2026-11-08/2611.08373.md))。今日も sns_wildcard に分類されているが、keyword "VLA" に当たる本流の論文。再ブリーフはしない。
- 2611.05376: From Autonomous Agents to Cognitive Symbionts: Toward AI-Augmented Human Intelligence — [1.5] 「人を拡張する AI (AHI; AI-augmented human intelligence)」を lifelong・private・proactive な companion (cognitive symbiont) として捉える position paper。手法・実験が abstract に無く、abstract も末尾が切れている。P1 (planner 評価)・P2 (蒸留 / 適合)・P3 (VLA / world model) のどれにも使える手法や評価がない。hf_upvotes は 116 と今日最大だが、注目度は relevance を上書きしない規則どおり落とした。published は 11-03 で、約 6 日遅れで wildcard に入ってきた論文。

## 運用メモ

- 今日の 3 件のうち 2 件は昨日のブリーフの再来で、実質の新規は 1 件 (低評価) のみ。ブリーフ 0 本は、候補が少ない日に水増しして採用しなかった結果。
- 本流 3 トピックが 0 件なのは、fetch が日曜 18:00Z (週末は announce が無い) だったため。過去の記録 (日曜 fetch は全 feed 空で正常) と整合する。ただし fetch の log はこの環境から確認できず、エラーで 0 件に見えている可能性は排除できていない。月曜 18:00Z の fetch (10-06 型: 月曜 announce 分) で通常の件数に戻るか確認する。
- 11-07 の次点 2611.07349 (GEAR; LoRA の dynamic rank) と 2611.07939 (WAM-Sim0.1; 運転 world model) は candidates.json に再来しなかった。abstract が手元に無いため、今日は評価も採用もしていない。
