# DIGEST 2026-11-10

今日の新規ブリーフは **5 本** (P1 1 / P2 2 / P3 2)。上限 6 本には届かず、水増しはしていない。ただし candidates.json は 3 件で、全部 sns_wildcard (本流 3 トピックは 0 件)。月曜 18:00Z の fetch なのに本流が空なのは異常なので、arXiv の新着 feed (RSS; Really Simple Syndication) を直接取得して回収し、同じ基準で採点した。採用 5 本のうち 4 本が回収分。評価はすべて abstract のみに基づく。

## 今日読むべきTOP3

1. **[2611.09888 Scenario Orchestration: 閉ループ評価で「狙った場面」を保つ](2611.09888.md)** (P1) — scenario-based simulation (「前方の車が割り込む」といった場面を台本化して走らせる評価) では、評価対象の運転 policy が台本と違う動きをすると、狙った場面そのものが成立しなくなる。この論文は、他車の出発時刻・経路・役割を毎 step の最適化で調整して狙った interaction を保ち、「場面が成立したか」と「policy がどう応答したか」を分けて採点する。台本の崩れを policy の失敗に数えない評価に直せるので、planner の評価指標に直結する。手元の評価結果を「場面が成立した試行だけ」で再集計するだけでも試せる。
2. **[2611.03953 P^2-MOPD: 複数 expert の蒸留を速くする](2611.03953.md)** (P2) — 専門化した複数の model を 1 つの student に統合する multi-teacher on-policy distillation (MOPD; student 自身の出力に teacher が supervision を与える蒸留を複数 teacher で行う) は遅い。P^2-MOPD は、expert との重みの線形結合を 1 つの微分可能な model とみなし、混合係数と student の重みを同じ蒸留 loss で同時に学習する。報告では MOPD の最終性能を半分の学習 step で超え、1.7B model の平均 recovery (各 domain で expert の性能にどこまで戻したか) が 80.9% から 94.7% になった。評価は LLM の domain 統合のみ。
3. **[2611.08631 BEVCast: 走行 path の周りだけ BEV を細かくする](2611.08631.md)** (P3) — 画像から直接 trajectory を出す E2E (end-to-end) 運転 model は、BEV (Bird's-Eye-View; 車を真上から見た格子状の表現) を全 cell 同じ解像度で作る。しかし車が通るのは一部の cell だけ。BEVCast は粗い格子で全体を作り、予測した path に沿った 10% の cell だけを細かくする。encoder 時間は 66% に減り、NAVSIM (運転 benchmark) の EPDMS (Extended Predictive Driver Model Score; 運転の総合採点) も 81.28 から 82.51 に上がっている。ただし開ループ寄りの評価で、閉ループの安全性は未確認。

## 全ブリーフへのリンク

- [2611.09888](2611.09888.md) — Scenario Orchestration for Closed-loop Policy Evaluation of Autonomous Driving (P1 / 4.5)
- [2611.03953](2611.03953.md) — P^2-MOPD: Accelerating Multi-Teacher On-Policy Distillation via Parameter Priors (P2 / 4.5; wildcard → 本流に移した)
- [2611.09042](2611.09042.md) — Failure Profiling and Reachable Trajectory Selection for Reasoning Distillation (P2 / 4.0)
- [2611.08631](2611.08631.md) — BEVCast: Path-Adaptive BEV for Efficient End-to-End Autonomous Driving (P3 / 4.0)
- [2611.08657](2611.08657.md) — JEPAhead: From Inpainting to Causal Forecasting for Urban Driving (P3 / 3.5)
- [rejected.md](rejected.md) — 不採用の記録 (candidates.json の wildcard 2 件 + RSS 回収分の次点)
- 昨日の DIGEST: [briefs/2026-11-09/DIGEST.md](../2026-11-09/DIGEST.md)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: Scenario Orchestration が今日の本命。最小実験は、手元の閉ループ評価を「intent 成立 / 不成立」で再集計し、不成立を除いたときの planner の失敗率を見ること。orchestrator の実装は要らない。次点の 2611.09670 (Goodhart in the Planner; 学習した reward に対して探索を強めるほど true return が下がる) は 3.0 で見送ったが、learned scorer で planner を選ぶ運用がある場合は参考になる。
- **P2 (FM 蒸留 + fine-tuning)**: P^2-MOPD は「重みの merge を prior にして蒸留する」recipe、FPRT (2611.09042) は「student が再現できる teacher の出力だけを学習 data に選ぶ」capacity gap 対策。どちらも loss や architecture でなく学習の回し方の話で、手元の蒸留に差し込みやすい。両方とも LLM が対象で、vision への移植は未検証。次点は 2611.09524 (RadarDINO; DINOv3 を radar に蒸留) と 2611.08800 (少データ適合の optimizer)。
- **P3 (次世代アーキテクチャ)**: BEVCast は計算配分を task に追従させる効率化、JEPAhead (2611.08657) は凍結 encoder の上に causal な未来予測 predictor を載せる world model の最小構成。JEPAhead は著者自身が downstream の有用性を未検証と書いており、planner に効くかを確かめるのが次の一歩。次点は 2611.06817 (Open-HumanWAM; 人間動画 50,000 時間の scaling law)。
- **wildcard**: 採用 0 件。P^2-MOPD は keyword "distillation" に一致するので本流の P2 に移した。SplatAnything (hf_upvotes 59) は feed-forward 3DGS (3D scene を 1 回の forward で Gaussian の集合に変換する手法) の正規化で P1/P2/P3 への接点が薄く、LongBanana は画像生成 agent の benchmark で無関係。注目度は relevance を上書きしない。

## 運用メモ

- 月曜 18:00Z の fetch で本流が 0 件だった。10-06 に予告した型 (金〜日の投稿分が月曜に announce されるのに、窓外 / エラーで 0 件) と一致する。RSS 回収分は 137 件 (本流 keyword に一致したもの) あり、採用 5 本のうち 4 本が回収分。fetch の log はこの環境から確認できないため、原因 (API エラーか窓の問題か) は未特定。`fetch_candidates.py` / `topics.yaml` は変更していない。
- 次に確認する点: 火曜 18:00Z の fetch で通常の件数に戻るか。戻らないなら log の `[fetch]   error` を最初に見る。
- 回収分は hf_upvotes が無く、同点のタイブレークに使えていない。
