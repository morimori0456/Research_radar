# DIGEST 2026-10-23

採用は 6 本 (P1 2 / P2 2 / P3 2、上限いっぱい)。うち 2 本 (2610.29435・2610.29134) は candidates.json に無く、arXiv RSS から回収した。planner_ai の候補が 1 件しかなく、fm_distill_finetune は 10 時間分 (10-21 07:46Z〜17:57Z) で 30 件の上限に当たっていたため。wildcard は 3 件とも不採用 (1 件は 10-21 に見送り済みの再来)。

## 今日読むべき TOP3

1. **[2610.29676 DriveMLP](2610.29676.md)** (P1 / planner の学習方法) — 人間の運転ログを真似るだけの planner は、自分の出力で自車が動く closed-loop 評価で少しずつ逸れて崩れる。著者は、closed-loop で planner を走らせ「記録された人間の軌道との距離」を報酬にして RL (試行と報酬で学ぶ方法) で最適化する、という学習方法だけで、ただの MLP が nuPlan (自動運転 planner の標準 benchmark) の反応型 closed-loop 設定で既存最良を +3.2 上回り、15 倍以上速く動くことを示した。読む理由は、「性能向上の大部分は model の大きさでなく学習手順から来る」という主張を統制実験で示している点。手元の planner の改善が model 側か学習側かを同じ方法で切り分けられる。報酬設計 (衝突などの重み) が不要なので試すコストも低く、コードが公開されている。
2. **[2610.29378 OnQ](2610.29378.md)** (P2 / 圧縮時の蒸留 recipe) — LLM を 2〜3 bit に量子化して再学習すると長い reasoning で崩れる。原因は 2 つで、(a) 学習時は元の model の固定の応答で教えるので、student が自分で生成するときの文脈とずれる、(b) student は token 候補ごとに確率を過小・過大に偏らせる。修正は、student 自身の生成の上で元の model が教える on-policy distillation と、候補ごとに「取りこぼし」と「出しすぎ」の罰を比率で切り替える KL loss。2 bit では全 model サイズ・全 benchmark で全 baseline を上回り、8B で平均 +10.26。読む理由は、loss の差し替えは量子化に限らず通常の蒸留にもそのまま使え、10-22 の OPTD と並べて on-policy distillation の改善点 (loss 側と表現側) が見えること。最初の実験は、手元の蒸留 run で過小・過大予測の偏りを集計するだけで済む。
3. **[2610.29435 Events, Not Pixels](2610.29435.md)** (P1 評価 / P3 world model) — world model で plan の良し悪しを順位付けするとき、return (将来の報酬の合計) の誤差の大部分 (中央値 70%) は、報酬が出る・episode が終わる数少ない step から来る。そうした step は画像としては他と同じくらいきれいに描けているので、画像の誤差が大きい step を直してもランダムに直すより効かない。読む理由は、学習済み world model や反応型 simulator を closed-loop 評価に使う場合、画質指標で simulator を選ぶと planner の順位付けを誤る、という評価設計上の警告が統計的に強く示されていること (44 組中 39 組、符号検定 p=1.4×10^-7)。運転なら衝突や割り込みの瞬間だけ実データに差し替えて誤差の減り方を見る、という診断がそのまま作れる。検証は Atari と制御 task で、運転での再現は未確認。

## 全ブリーフへのリンク

- [2610.29676](2610.29676.md) — DriveMLP: closed-loop IL + expert 距離報酬の RL (EGRL) で MLP planner が nuPlan 最良 (P1)
- [2610.29435](2610.29435.md) — Events, Not Pixels: world model の return 誤差は event step に集中 (P1 / RSS 回収分)
- [2610.29378](2610.29378.md) — OnQ: on-policy distillation + Dynamic KL で低 bit 量子化の reasoning を回復 (P2)
- [2610.29134](2610.29134.md) — NormTune: PEFT の更新 norm 不足を層ごとに補う (P2 / RSS 回収分)
- [2610.30129](2610.30129.md) — CADRE: world model 用 video autoencoder の圧縮率の設計 (P3)
- [2610.29989](2610.29989.md) — FCP: 離れた未来 chunk の予測で autoregressive video 生成に変化を学ばせる (P3)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 57 件中 53 + RSS 次点 9)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 学習側と評価側で 1 本ずつ。DriveMLP は「model を変えずに学習を closed-loop に替えると何点動くか」を測る統制の作法、Events, Not Pixels は「simulator の誤差が score を決める瞬間に集中していないか」を測る診断。最小実験は、(a) 手元の IL planner の学習だけを EGRL 型に替えて closed-loop score の差と内訳 (衝突 / 進捗 / 快適性) を見る、(b) closed-loop 評価で score を決めた event 時刻だけ実データに差し替え、ランダムな時刻の差し替えと誤差の減り方を比べる。次点は 2603.11417 (都市を跨ぐ zero-shot 転移を E2E 運転の stress test にする; NAVSIM の closed-loop。改訂版なので見送り)。
- **P2 (FM 蒸留 + fine-tuning)**: 蒸留は OnQ (student 自身の生成の上で教え、KL の向きを token 候補ごとに切り替える)。適合は NormTune (LoRA などの PEFT が reasoning task で負けるのは、一部の層の更新量が full fine-tuning より小さすぎるからで、その層を強めれば rank-8 で平均 +24%、rank-256 で full fine-tuning 並み)。どちらも診断が学習なしで先にできる: (a) 蒸留 run での過小・過大予測の偏りの集計、(b) LoRA run と full fine-tuning run の層ごとの更新 norm の比較。次点は D-Skill (2610.28914; 重みを触らず自然言語の skill 文書で gap を埋める)、CORD (2610.29965; RL と蒸留の勾配の衝突を射影で除く)、jet tagging の系統的な蒸留比較 (2610.29439; gain は主に teacher の強さで決まる)。
- **P3 (次世代アーキテクチャ)**: 今日の 2 本はどちらも video world model の「学習の器」の話。CADRE は autoencoder の圧縮の置き方で、カメラが動く設定 (運転が該当) では空間を強く圧縮するほうが安い、静止カメラで空間 token を粗くすると画質より動きが壊れる、という設計指針を出す。FCP は推論を変えずに「離れた未来の予測」を補助 loss として足し、直前のコピーという shortcut を潰す。運転の world model は直進区間が多く、他車の変化が薄い学習信号になりやすいので両方当てはまる。評価は画質ではなく他車の軌跡誤差で行うべきで、P1 の Events, Not Pixels と同じ結論に寄る。次点は ALPS (2610.30120; world model 用の視覚 encoder、FCP と同点で upvotes 差で落とした)、表現の nuisance orthogonality で WAM の汎化を事前予測する 2610.29168、NavBind (2610.29203; 指示だけ変えて action が変わるかの診断)。

## 運用メモ

- fetch は木曜 18:00Z 実行 (generated_at 2026-10-22T18:00Z)。planner_ai 1 件、fm_distill_finetune 30/30 の上限 (10 時間分)、next_arch 23 件。エラーの有無は確認できず (ログが無い)。
- 天井の日の運用に従い、RSS 5 本 (cs.LG / CL / CV / RO / AI) を走査した。lastBuildDate は 2026-10-22 04:00Z で、10-22 実行時とは別 build。candidates に無く keyword に当たったのは 266 件、10-22 の走査済み・過去ブリーフ記録済みの id を除いた 248 件を見た。**採用 6 本のうち 2 本が RSS 回収分** = candidates.json だけでは P1 の 2 本目と P2 の 2 本目を取り逃していた。
- wildcard の 2610.26802 (brain encoding の PEFT) が 10-21 に続いて再来。dedup が wildcard 経路にも要る、という既存の観察と一致する。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
