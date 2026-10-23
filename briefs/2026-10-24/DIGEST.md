# DIGEST 2026-10-24

採用は 6 本 (P1 2 / P2 2 / P3 2、上限いっぱい)。うち 3 本 (2610.31095・2610.30953・2610.30880) は candidates.json に無く、arXiv RSS から回収した。planner_ai の候補 4 件はすべて robot の multi-robot / manipulation の話で運転に使えず、fm_distill_finetune は 10 時間分 (10-22 08:00Z〜17:59Z) で 30 件の上限に当たっていたため。wildcard は 3 件とも不採用。

## 今日読むべき TOP3

1. **[2610.30319 TerraTransfer++](2610.30319.md)** (P3 / 学習データの出どころ) — end-to-end 自動運転 (画像から直接軌道を出す model) は、人間の運転ログを真似るのが標準だが、ログには衝突寸前のような稀な状況がほとんど無い。著者は、画像を描画しない高速な simulator で self-play (自分同士で走らせて学ぶ) させた policy を teacher にし、その出力を flow-matching (ノイズから軌道を作る生成手法) の teacher に蒸留して、凍結した視覚 backbone の上の軽い adapter に写す。人間の demonstration は一切使わず、NAVSIM (自動運転 planner の標準 benchmark の一つ) の難しい split で既存最良の 57.1 を超える 59.4 EPDMS (衝突・進捗・快適性などを合成した score) を出した。蒸留 (P2)・学習データ (P3)・planner の評価 (P1) の 3 つにまたがるので、今日の一本目。
2. **[2610.31563 AOPD](2610.31563.md)** (P2 / 蒸留 recipe) — 蒸留は普通、teacher の出力に student を全ての場面で近づける。だが teacher が強すぎると、student が真似ても結果が良くならない場面が多い。AOPD (Advantage-Based On-Policy Distillation) は、student 自身が生成した trajectory の上で、teacher の行動が student の成功率をどれだけ上げるか (advantage) で重みを付け、役立たない箇所の教えを弱める。追加の rollout は要らず、最終 reward と teacher/student の確率比だけで推定できる。capacity gap (teacher と student の能力差が大きすぎる問題) への対策を、既存の蒸留 run に数行で足せる形で出している点が実務向き。
3. **[2610.31095 Route or Adapt](2610.31095.md)** (P1 / 新しい地域への展開の評価) — 地域ごとの expert adapter (小さな追加 module) を持つ diffusion planner が、学習していない地域に出たとき、「最も合う expert を選ぶ」のは、シーンごとに最良を選ぶ oracle でも横ずれが平均 0.9 m しか減らない。一方、新地域の 20 シーンでの fine-tuning は 12.4 m を 6.9 m まで減らす。nuPlan では open-loop の数字が良くなっても closed-loop (planner の出力で自車が実際に動く評価) は悪化し、2 つのベースラインは退化した軌道で低い数字を出していた。指標が改善したときに信じてよいかを確かめる具体的な点検項目になる。

## 全ブリーフへのリンク

- [2610.30319](2610.30319.md) — TerraTransfer++: self-play の teacher を蒸留して demonstration なしで end-to-end planner を作る (P3 / P2 / P1)
- [2610.30814](2610.30814.md) — DRILL: world model を pixel の精度でなく policy の改善量で学習する (P3)
- [2610.31563](2610.31563.md) — AOPD: student に役立つ teacher の行動だけを強く学ばせる on-policy distillation (P2)
- [2610.30880](2610.30880.md) — MCPD: 特権情報の複数の view で teacher を平均して蒸留の target を安定化 (P2 / RSS 回収分)
- [2610.31095](2610.31095.md) — Route or Adapt: unseen region では expert の選択より少数シーンの fine-tuning (P1 / RSS 回収分)
- [2610.30953](2610.30953.md) — driving VLA の推論と軌道は弱くしか結びつかない、を counterfactual で示す (P1 評価 / P3 / RSS 回収分)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 57 件中 54 + RSS 次点 9)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 今日の 2 本はどちらも「指標の数字をそのまま信じない」ための評価の知見。Route or Adapt は、open-loop の offset が良くなっても closed-loop が悪化し得ること、退化した軌道でも offset が低く出ること、を示す。2610.30953 は、driving VLA (画像と言語から軌道を出す model) が出す「推論の文章」を書き換えても軌道はほとんど変わらないが、カメラ画像を黒塗りすると大きく変わる、つまり説明と挙動は弱くしか結びつかないと示す。最小実験は、(a) 手元の planner の新条件への適合を、expert の選択と 20〜50 シーンの fine-tuning で同じ評価セット上で比べ、open-loop と closed-loop を並べる、(b) 評価 script に「軌道が静止・直線に潰れていないか」の検出を足す、(c) VLA があれば、推論文の書き換えとカメラの黒塗りで軌道の変化量を比べる。
- **P2 (FM 蒸留 + fine-tuning)**: 蒸留の話が 2 本で、どちらも on-policy distillation (student 自身の生成の上で teacher が教える方法) の「teacher の教えをそのまま信じない」側の改良。AOPD は student に役立たない箇所の教えを弱め、MCPD (Monte Carlo Privileged Distillation) は teacher だけが見る特権情報 (正解の参照解など) の見せ方を変えると出力が大きく変わる不安定さを、複数の部分的な view の平均で抑える。どちらも診断が学習なしで先にできる: (a) 蒸留 run で teacher の重みが小さくなる場所の集計、(b) teacher の特権入力を等価な 2 通りに替えたときの出力の食い違い (KL) の測定。適合の側では Route or Adapt が「20 シーンの fine-tuning + 元データの replay」を具体的な recipe として示す。次点は 2610.30231 (誤った student の rollout の teacher が不利と見る token だけを罰する蒸留) と 2610.30691 (別 backbone で学習した LoRA を足し合わせる)。
- **P3 (次世代アーキテクチャ)**: TerraTransfer++ は「end-to-end の学習データを人間のログから self-play に替える」設計で、稀な状況の欠落を直接狙う。DRILL は world model の目的関数を「次の画像が正確か」から「その world model で想像した rollout が policy を改善するか」に替え、pixel の誤差が 17% 高くても policy は良くなる例を示す。昨日の Events, Not Pixels (world model の return 誤差は少数の event step に集中する) と同じ方向の知見が 2 日続いたので、運転の world model の学習・評価で pixel/latent の誤差を主指標にすることを見直す根拠が 2 本そろった。最小実験は、手元の world model の複数の checkpoint で「予測誤差」と「その world model で想像した policy の改善量」の相関を測ること。次点は 2610.30735 (flow matching の VLA は 1 step 生成で multi-step とほぼ同等 = 再学習なしで低遅延にできる)。

## 運用メモ

- fetch は金曜 18:00Z 実行 (generated_at 2026-10-23T18:00Z)。planner_ai 4 件 (すべて運転と無関係)、fm_distill_finetune 30/30 の上限 (10-22 の約 10 時間分)、next_arch 20 件、wildcard 3 件。エラーの有無は確認できず (ログが無い)。
- 天井の日の運用に従い、RSS 5 本 (cs.LG / CL / CV / RO / AI) を走査した。lastBuildDate は 2026-10-23 04:00Z。candidates と過去ブリーフの id を除いた keyword 一致 138 件 (replace 配信を除く) を見て、**採用 6 本のうち 3 本が RSS 回収分** = candidates.json だけでは P1 の 2 本と P2 の 1 本を取り逃していた。planner_ai の candidates が運転に使えない日は RSS が P1 の唯一の供給元になる。
- wildcard の 2610.28402 (StreamEval) が 10-23 に続いて再来。dedup が wildcard 経路にも要る、という既存の観察と一致する。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
