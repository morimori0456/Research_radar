# DIGEST 2026-10-21

採用は 5 本 (P1 1 / P2 2 / P3 2)。うち 2 本 (Cartender・SPOD) は candidates.json に無く、arXiv RSS から回収した。fm_distill_finetune が 30 件の上限に当たり、10-19 06:38Z より前の投稿分が落ちていたため。wildcard は不採用 (3 件とも重複か見送り済み)。

## 今日読むべき TOP3

1. **[2610.26390 Cartender](2610.26390.md)** (P1 / RSS 回収分) — 運転ログには「実際に取った行動」しか残らないので、指示を無視する policy と、シーンの制約を無視して指示に従う policy が同じデータに同じようにフィットしてしまう。この論文は VLM (画像と言葉を扱う大規模モデル) に「選ばなかった運転」を提案させて負例を作り、指示が実行可能かを判定する gate を学習する。読む理由は評価の設計にある。入力 (録画) を固定して指示だけを差し替え、挙動の変化を測る方式は、手元の planner の条件入力 (目標速度・ルート・intent) が本当に効いているかを調べる counterfactual 評価にそのまま使える。実行不可能な指示を実行してしまう率が 53.36% から 14.18% に下がった、という数値も基準値の目安になる。RFS (Rater Feedback Score; 人間の評価者の採点を模した運転品質の指標) は Waymo の基準に依存する点に注意。
2. **[2610.25034 SPOD](2610.25034.md)** (P2 / RSS 回収分) — OPD (On-Policy Distillation; student 自身が生成した軌跡の上で、teacher が各 step の確率分布を教える蒸留) を長く回すと、student が teacher を一度追い越し、その後に成績が落ちる現象 (distillation overshoot) を報告している。原因は、teacher が好まないが実は成功していた student の選択を、teacher の指導が削ってしまうこと。対策は、成功した episode で teacher と衝突する部分を mask し、確率に下限を入れるだけで、必要なのは成功/失敗の 2 値だけ。蒸留で「途中の checkpoint の方が最終より良い」と見たことがあるなら、まず原因の確認に使える。対象は LLM の agent 課題で、運転への移植には「成功」の定義が要る。
3. **[2610.25734 LECDrive](2610.25734.md)** (P3) — VLA (画像と指示から行動や軌道を直接出すモデル) を運転に使うと、教師信号が疎な軌道だけになり、シーンの細かい情報をモデルが捨てる、という主張。VLM に少数の latent token を足し、学習時に DINOv3 (汎用の視覚特徴)・SAM3 (物体領域の分割)・DepthAnything3 (単眼の奥行き推定) の知識を、representation → semantics → geometry の順に移す。推論時は外部 model を呼ばない。最小の追試は depth だけを auxiliary loss (補助の教師信号) で入れる版で、効果の大半がどの expert 由来かを切り分けられる。改善幅は abstract に無く、既存の強い E2E planner に対する優位は未確認。

## 全ブリーフへのリンク

- [2610.25734](2610.25734.md) — LECDrive: Think Densely, Act Sparsely (P3 / VLA 運転)
- [2610.26390](2610.26390.md) — Cartender: Verifiable Language-Conditioned Driving (P1 / RSS 回収分)
- [2610.25034](2610.25034.md) — SPOD: Distillation Overshoot in Agentic On-Policy Distillation (P2 / RSS 回収分)
- [2610.26124](2610.26124.md) — Nash-MOPD: Multi-Teacher On-Policy Distillation の domain 配分 (P2)
- [2610.25666](2610.25666.md) — Fréchet Forcing: 短い clip から長期 streaming world model を学ぶ (P3)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 58 件 + RSS 次点)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 本流 2 件 (CAOS-SLAM・VQ-WM) は転用先が薄く不採用。代わりに RSS 回収分の Cartender から、「録画を固定して条件だけ差し替える」評価を取る。最小実験は、手元の planner の intent / route 入力を同じ recorded scene で差し替え、軌道が変わるかを見ること (変わらなければ入力を無視している)。Fréchet Forcing が示す長期 rollout の安定化は、world model 内の closed-loop simulation で planner を評価する土台にもなる。
- **P2 (FM 蒸留 + fine-tuning)**: SPOD と Nash-MOPD はどちらも OPD の運用上の失敗を直す recipe で、併用できる (SPOD は teacher が 1 つの場合の erosion、Nash-MOPD は teacher が複数の場合の domain 配分)。手元の蒸留 run があれば、(a) checkpoint ごとに「teacher と食い違い、かつ student が正解していた割合」を数える、(b) domain 別の reverse-KL (student から見た teacher とのずれ) の推移をログに取る、の 2 つが先にできる。次点は SPAR (2610.26487; VLA の pruning + RL 回復で 3.37B → 1.12B、1.98 倍高速化) と LOOP (2610.25679; 1 層ずつ削って OPD で回復する layer pruning) で、compression と distillation を同時に扱う。明日以降の最優先候補。
- **P3 (次世代アーキテクチャ)**: LECDrive は「密な視覚 expert 知識を latent token で VLA に移す」構成、Fréchet Forcing は「teacher なしで world model の長期 drift を抑える」recipe。どちらも追試のコストが小さい (LECDrive は depth 1 つから、Fréchet Forcing は 36 GPU 時間規模)。world model の planning では NGC (2610.25013; latent の距離を manifold 上の最短路にして retraining 不要) も候補。

## 運用メモ

- fetch は月曜 18:00Z 実行 (generated_at 2026-10-20T18:00Z)。fm_distill_finetune が 30/30 の上限、next_arch は 26 件、planner_ai は 2 件。エラーの有無は確認できず (ログが無い)。fetch_candidates.py はまだ RSS 取得や dedup に変わっていない。
- 天井の日の運用に従い、RSS 5 本 (cs.LG / CL / CV / RO / AI) を走査した。candidates に無く keyword に当たったのは 631 件 (多くは分野外)。上位を abstract まで読み、上記 2 本を採用、他を rejected.md に記録。**採用 5 本のうち 2 本、TOP3 のうち 2 本が RSS 回収分** = candidates.json だけでは、この日の最良の P1 と P2 を取り逃していた。
- 10-20 に採用した 2610.22471 と、見送った 2610.20424 が wildcard として再来している (重複)。dedup が wildcard 経路にも要る、という既存の観察と一致する。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
