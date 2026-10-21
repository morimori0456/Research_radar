# DIGEST 2026-10-22

採用は 6 本 (P1 2 / P2 2 / P3 2、上限いっぱい)。うち 3 本 (2610.27714・2610.25497・2610.28122) は candidates.json に無く、arXiv RSS から回収した。planner_ai が 0 件、fm_distill_finetune が 12 時間分 (10-20 06:17Z〜17:59Z) で 30 件の上限に当たっていたため。wildcard は 3 件とも不採用 (2 件は 10-21 に見送り済みの再来、1 件は分野外)。

## 今日読むべき TOP3

1. **[2610.28184 Perceives but Doesn't Brake](2610.28184.md)** (P1 / 評価の診断) — 運転用の VLA (画像と指示から軌道を直接出す model) に reasoning を足しても、危険物を「見えている」「説明できる」のに減速しない失敗が起きる。著者は、危険の情報が model の内部に符号化されているのに、縦方向の軌道が自車の過去の速度にばかり引っ張られ、危険物との距離にほとんど反応しないことを、危険物の距離だけ変えた対のシナリオで示す。修正は、再学習なしで、軌道を生成する sampler に「危険物に近い軌道ほど高くなるコスト」を足す guidance だけで、障害物への侵入率が 58.1% から 14.5% に下がる。読む理由は診断の方法にある。手元の planner に同じ「片方の要因だけ変える」対を入れれば、軌道の誤差では出ない欠陥が分かる。数値は障害物の正確な幾何が与えられた場合で、perception 誤差がある実運用の値ではない。
2. **[2610.28122 DirectWAM](2610.28122.md)** (P3 / 蒸留も兼ねる) — 未来の映像を予測してから行動を出す world-action model (WAM) は、diffusion を何度も反復するので遅い。1 ステップに切ると成功率が落ちる。著者は、映像側のノイズをやり直しても行動はほとんど変わらないこと、予測誤差の中に行動に効くものと効かないものがあることを見つけ、student の予測した未来を「そこから decode した行動の誤差」で評価して蒸留する。推論は 28.0 倍速くなり、LIBERO (robot manipulation の標準 benchmark) で平均成功率 97.1%。読む理由は、onboard の latency が壁になる world model 系の policy で、蒸留の目的関数を表現の一致ではなく下流の制御結果に置く、という設計の方針が持ち帰れること。検証は manipulation のみで、運転のように複数の妥当な軌道がある設定で多様性が保てるかは未確認。
3. **[2610.28048 OPTD](2610.28048.md)** (P2 / capability gap 対策) — OPD (On-Policy Distillation; student 自身の生成した軌跡の上で teacher が各 token の確率分布を教える蒸留) は、最終層の分布だけを合わせる。この論文は、層から層へ予測がどう動くか (層間の log-probability の増分) も合わせると、teacher との能力差の回復率が約 75% から約 90% に上がると報告する (3 domain の蒸留)。根拠となる診断は、正解した応答ほど teacher との層間の動きが近い、という観察。既存の OPD に項を足すだけなので実装が軽く、最初の実験は診断の再現だけで済む。対象は teacher と student が同じ語彙を持つ LLM で、層の対応付けが違う組には abstract に答えがない。

## 全ブリーフへのリンク

- [2610.28184](2610.28184.md) — Perceives but Doesn't Brake: reasoning 運転 VLA の perception-action binding gap (P1 / next_arch の候補を P1 枠で採用)
- [2610.27714](2610.27714.md) — When Does Experience Memory Help Closed-Loop LLM Driving Agents?: closed-loop 評価の統制項目 (P1 / RSS 回収分)
- [2610.28048](2610.28048.md) — OPTD: On-Policy Transition Distillation (P2)
- [2610.25497](2610.25497.md) — Self-Distillation for SFT (Gold-Conditioned Distillation): 外部 teacher なしの適合 recipe (P2 / RSS 回収分)
- [2610.28594](2610.28594.md) — VPM: 点 trajectory 予測で multi-view world model を 3D 整合させる (P3)
- [2610.28122](2610.28122.md) — DirectWAM: action-sufficient distillation で WAM を 1 ステップ化 (P3 / RSS 回収分)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 59 件中 53 + wildcard 3 + RSS 次点)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 今日の 2 本はどちらも「何を測るか」の話。2610.28184 は ego-speed の履歴と危険物の距離を別々に振る counterfactual 診断、2610.27714 は seed / warmup pool の resample と token 数を揃えた無関係な入力の対照。最小実験は、手元の planner で (a) 障害物の距離だけを振って減速量の感度を曲線にする、(b) 最近出した「改善」を seed 10 通りで resample して、改善幅が分散に収まるか見る、の 2 つ。2610.27714 の実験場は単純な高速道路 simulator と gpt-4o-mini で、planner 実装の知見ではなく評価の作法として読む。
- **P2 (FM 蒸留 + fine-tuning)**: 蒸留は OPTD (層間 transition を足して gap の回復率を上げる)。適合は GCD (正解を context に入れた自分自身を teacher にし、SFT より新 task の accuracy が高く、汎用性能の劣化が小さい)。GCD は外部 teacher が要らないので、少データでの別ドメイン適合の最小実験にしやすい。先にできる 2 つは、(a) OPD の run で正解/不正解の応答の層間 KL に差があるかを測る、(b) 少データ fine-tuning で SFT と GCD を並べ、新 task と元の汎用 benchmark の 2 つの数字を比べる。次点は TILDE (2610.25376; 事前学習済み embodied foundation model から policy へ、on-policy distillation と teacher 介入の復帰軌跡で移す)、MuPACE (2610.28072; LoRA の学習率を meta-learn)。
- **P3 (次世代アーキテクチャ)**: VPM は world model に点 trajectory を補助出力として足してカメラ間の 3D 整合を取る (運転は multi-camera なので当てはまる)。DirectWAM は推論 latency の壁への蒸留による解。両方とも検証は manipulation で、運転への移植は未確認。world model まわりの次点は LaLa-World (2610.27851; 言語 action で学習コスト 6 分の 1、planning 13.9 倍速)、Action Influence Maximization (2610.27387; world model が action を無視する問題をデータ収集で解く)。後者は closed-loop 評価に world model を使う P1 にも効く。

## 運用メモ

- fetch は水曜 18:00Z 実行 (generated_at 2026-10-21T18:00Z)。planner_ai 0 件、fm_distill_finetune 30/30 の上限、next_arch 26 件。エラーの有無は確認できず (ログが無い)。fetch_candidates.py は RSS 取得や dedup に変わっていない。
- 天井の日の運用に従い、RSS 5 本 (cs.LG / CL / CV / RO / AI) を走査した。lastBuildDate は 2026-10-21 04:00Z で、10-21 実行時の取得分と同じ build の可能性がある。candidates に無く keyword に当たったのは 581 件で、10-20 / 10-21 の記録済み id を除いた 537 件を見た。上位を abstract まで読み、3 本を採用。**採用 6 本のうち 3 本が RSS 回収分** = candidates.json だけでは、この日の P1 の 2 本目と P2 の 2 本目、P3 の 2 本目を取り逃していた。
- planner_ai の candidates が 0 件の日の P1 枠は、next_arch から運転 VLA の診断論文 (2610.28184) を移して埋めた。planner_ai の keyword ("motion planning" など) に当たる論文が cs.RO / cs.LG にほとんど無いのか、fetch の窓の問題かは、この日の情報では切り分けられない。
- wildcard の LEV (2610.20951) と BizBench (2610.20424) が 10-21 に続いて再来している。dedup が wildcard 経路にも要る、という既存の観察と一致する。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
