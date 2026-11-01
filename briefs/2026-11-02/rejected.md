# rejected 2026-11-02

採用 6 本 (P1 1 / P2 2 / P3 2 / sns_wildcard 1) 以外の記録。candidates.json は 3 件 (generated_at 2026-11-01T18:00Z) で、**3 件とも sns_wildcard、planner_ai / fm_distill_finetune / next_arch は 0 件**。評価は topics.yaml の relevance_criteria に沿った 0-5 点で、すべて abstract に基づく。

## sns_wildcard (3 件中 2 件)

- 2610.36671: Look Only When Needed: Certificate-Guided Visual Routing for Efficient Diffusion VLMs — LOWN。diffusion VLM (拡散方式で text を生成する vision-language model) の各 step で画像が必要な割合は 7.9-22.8% しかないと測り、画像なしの予測と直前の画像つきの予測が一致する間は画像を処理しない。学習も閾値の調整も不要で、10 benchmark で score の 99.6% を FLOPs 35.3% で保つ。「画像が必要な step は少ない」という測定は VLA の推論の節約にも示唆があるが、対象は LLaDA-V (拡散型の VLM) で、運転・制御への接点が abstract に無い (評価 3.0, hf 101)。wildcard は 1 件までなので 2610.39302 を優先した。次点
- 2610.38568: A-RSI: Adaptive Task Refresh for Zero-Data Multimodal Self-Improvement — 学習ログの reward の変動と正答率から、課題の pool を入れ替える時期を決める自己改善。外部データも人手のラベルも使わない。multimodal の QA が対象で、3 プロジェクトのどれにも接点が無い (評価 2.0, hf 65)

## 本流 (candidates.json に 0 件)

日曜 18:00Z の fetch で、3 トピックとも該当なし。fetch の log は確認していない。ただし RSS は cs.LG / cs.CL / cs.CV / cs.RO / cs.AI の 5 カテゴリすべてが 0 件 (lastBuildDate 2026-11-01 04:00Z、新規の item が無い)。日曜は announce が無く、月曜 00:00Z の announce 分は今日の fetch に間に合わない、という既知の機構 (09-13 に確定、10-05 に日曜の 0 件を確認) と合うので、**喪失は 0 件**と判断した。月曜 announce 分が候補に入るのは、次の fetch (月曜 18:00Z) から。

## 今日 10-31 / 11-01 の次点から繰り越して採用 (5 本)

本流が空の日の枠は、前日までの rejected.md に評価つきで残した次点で埋めた (11-01 と同じ運用)。abstract は arXiv API で取得した。

- 採用: 2610.40257 (P1 3.5)、2610.39516 (P2 3.5)、2610.38001 (P2 3.5)、2610.40026 (P3 3.5)、2610.39451 (P3 3.5)
- 採用の基準: 評価が同点 (3.5) の中で、(a) 各 topic の relevance_criteria の優先項目に当たる (評価手法の提案、少データ・他機種への適合、軌道出力の設計)、(b) 運転への移植で最初の実験が書ける、(c) 3 プロジェクトに散らす、の順で選んだ。

## 次の空き日に繰り越せる次点 (評価はすべて 3.5、いずれも abstract のみ)

- 2610.39416: Decoding Geometry, Not Tokens: Efficient VLMs for Robot Affordance and Trajectory Prediction — VLM の中間特徴から waypoint を直接回帰する軽量 head (P3)。対象が robot の 2D 予測
- 2610.40373: HiFOR: Hierarchical Foresight with Action-Guided World Grounding for VLA — 階層的な foresight で VLA を改善 (P3)。対照の厳密さが abstract から読めない
- 2610.39812: GROME — world model の memory を static と dynamic に分解し、学習なしで注入する (P3)。制御の評価が無い
- 2610.39721: WorldProbe — video world model の long-horizon 診断 benchmark (P3)。運転に直結しない
- 2610.39278: WorldFlow — 動画と 3D motion の同時予測 (P3)。運転の適用は未検証
- 2610.38356: CLIK (Encode Once, Answer Many) — context から LoRA の重みを 1 回の forward で生成する hypernetwork (P2)。LLM の知識注入が対象
- 2610.39876: Turing LLM Post-Training (C-MOPD) — multi-teacher on-policy distillation (P2)。MoE の実行基盤の話が大きい
- 2610.38637: TESD — teacher を reward で更新する on-policy self-distillation (P2)。LLM の reasoning 限定
- 2610.38681: Weaken to Strengthen — 弱めた自分との対比を signal に使う (P2)。LLM の reasoning 限定
- 2610.38383: How Much Do Teacher Bridges Matter in Interleaved On-Policy Distillation? — 差が検出できない事前登録つきの否定的結果 (P2)
- 2610.38160: ATI-OPD — 乖離した接頭部を teacher の文で置き換える OPD (P2)。数学の text 推論のみ

## その他

上記以外の 10-31 / 11-01 の rejected.md の項目 (評価 3.0 以下) は、評価を変えずに見送った。
