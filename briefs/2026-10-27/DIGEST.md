# DIGEST 2026-10-27

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は sns_wildcard 3 件だけで本流は 0 件だったので、RSS (rss.arxiv.org の 5 カテゴリ、月曜 04:00Z announce 分) から回収して同じ基準で採点した。6 本すべて RSS 回収分で、wildcard 3 件は上限に達して採用していない。

## 今日読むべき TOP3

1. **[2610.31859 fp32 master copy が無いと VLA の fine-tuning 更新が消える](2610.31859.md)** (P2) — VLA (画像と言語から行動を出す model) を bf16 (16 bit 浮動小数点) の weight のまま、32 bit の複製 (fp32 master copy) 無しで fine-tuning すると、weight の 1/512 未満の更新が丸めで消える、という報告。LeRobot の SmolVLA default を含む公開 recipe の多くが該当し、複製を足すだけで LIBERO (操作 task の simulation benchmark) の成功率が 4.3% → 49.3% (SmolVLA)、5.1% → 80.9% (π0.5) になる。新手法ではなく測定なので、手元の fine-tuning script の dtype を 1 回確かめれば自分に当てはまるかがすぐ分かる。P2 の適合実験の前に潰しておく項目。
2. **[2610.32069 DriveMind](2610.32069.md)** (P1) — MLLM (画像と言語を扱う大規模 model) が運転の判断をするとき、毎フレーム 1 つの解釈に決め打ちしてしまう問題に、複数の仮説を保持して重みを更新する belief tracking (particle filtering という状態推定の手法に着想) で対処する。Bench2Drive (CARLA 上の closed-loop 評価) で Driving Score が 68.50 → 81.37 になり、改善は信号のない交差点や対向車がいる場面に集中している。P1 にとっての価値は手法そのものより、「曖昧な場面に分けて評価すると差が出る」という評価の切り方。ただし推論コスト (仮説の数だけ model を回すはず) は abstract に無い。
3. **[2610.32566 Reuse, Don't Retrain](2610.32566.md)** (P2) — 凍結した大きな teacher の patch ごとの特徴を、小さい ViT に合わせさせる feature distillation だけで、同じ大きさの公開 model を mIoU (segmentation の重なり率) で 2〜3 点上回り、1 つ上の大きさの公開 model に並ぶ。TerraMind-Base の蒸留は事前学習コストの約 0.5% (A6000 で 43 時間)。loss が単純でコストが teacher 比で示されているので、P2 の「実務で回す recipe」の見本として読める。対象は衛星画像なので、運転画像で同じ利得が出るかは別に確認が要る。

## 全ブリーフへのリンク

- [2610.32069](2610.32069.md) — DriveMind: 複数仮説を保持する belief tracking で曖昧な運転場面を改善 (P1 / planner_ai / 4.0)
- [2610.31835](2610.31835.md) — SAGE: 工事区間で、geometry の候補経路から VLM の軌道を preference に選ぶ。selection regret を分けて測る (P1 / planner_ai / 3.5)
- [2610.31859](2610.31859.md) — Full-Weight VLA Fine-Tuning Without an fp32 Master Copy: bf16 で更新が消える (P2 / fm_distill_finetune / 4.5)
- [2610.32566](2610.32566.md) — Reuse, Don't Retrain: feature distillation で GeoFM を小さくし、複数 teacher を 1 つの trunk に集約 (P2 / fm_distill_finetune / 4.0)
- [2610.32102](2610.32102.md) — Coupling Execution Horizon and Sampling Depth: flow-matching VLA の step 数と実行区間の長さが結び付く (P3 / next_arch / 4.0)
- [2610.31762](2610.31762.md) — RepresentNav: 全層特徴の選択と、JEPA 型の未来表現予測を policy の内側に持つ navigation model (P3 / next_arch / 3.5)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件 + RSS 回収分の惜しかったもの・見送ったもの + 運用メモ)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「全体の平均では見えない所を分けて測る」話。DriveMind は場面タイプ別 (曖昧な場面) の Driving Score、SAGE は候補集合に良い軌道があるのに選べない分 (selection regret; ranker の誤りの 53%) を分ける。自前の planner ログがあれば、(a) 候補集合の oracle 誤差と選択後の誤差の差、(b) 場面タイプ別の score、の 2 つを集計する script が最小の一歩。
- **P2 (FM 蒸留 + fine-tuning)**: 31859 は fine-tuning の足元の確認 (dtype)、32566 は蒸留 recipe の見本。惜しかった 2610.31918 (LLM agent の蒸留で、履歴を作る policy と action prefix を作る policy を分けて選ぶ) は rejected.md に記録。on-policy distillation の設計を調べる日が来たら先に読む。
- **P3 (次世代アーキテクチャ)**: 32102 は再学習なしで試せる (flow matching の step 数 K と実行区間 H の格子)。運転は頻繁に re-plan するので、論文の「step を減らすと良くなる」側ではなく逆側に入る可能性があり、どちらに入るかを測ること自体が実験。RepresentNav は world model を「policy の内側の補助予測」として持つ例で、衝突が 4 分の 1 減る。どちらも操作・navigation の結果で、運転での再現は未確認。

## 運用メモ

- **fetch の欠陥 (本流 0 件)**: 今回の candidates.json は月曜 18:00Z の fetch で、10-26 に予告した「金曜投稿〜月曜 announce 分が入る最初の回」だったのに本流 0 件だった。RSS (cs.LG 321 / cs.CL 169 / cs.CV 205 / cs.RO 107 / cs.AI 321 item、lastBuildDate 2026-10-26 04:00Z) には月曜 announce 分が入っていたので、API 側の窓外・エラーが疑われる。`[fetch] error` のログは確認できていない。0 件の日は先に fetch のエラーと、`published` の窓外を疑う。
- 回収した RSS 分の keyword 一致は 175 件 (過去ブリーフ・rejected に出た id と replace を除く)。6 本は全部ここから採用した。採用上位の論文が candidates.json に 1 本も入っていないので、fetch 経由だけでは今日のブリーフは wildcard 経由の 0〜1 本になっていた。
- wildcard の 2610.31668 と 2610.31162 は 10-24 に rejected 済みで、今回また再来した。dedup が wildcard 経路に要る、という既存の観察と一致する。
- 10-26 のブリーフ 2610.24738 (LayerEditor) の最小実験、10-24 の Route or Adapt と driving VLA の counterfactual 評価の最小実験は未着手のまま。今日のブリーフから 1 つだけ選ぶなら 2610.31859 の dtype 確認 (script 数行、実験 0 回で済む)。
- ブリーフは abstract のみに基づく。数値表・ablation・本文の実装詳細は未確認。
