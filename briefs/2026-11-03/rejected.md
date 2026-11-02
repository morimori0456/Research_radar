# rejected 2026-11-03

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。candidates.json は 3 件 (generated_at 2026-11-02T18:00Z) で、**3 件とも sns_wildcard、本流 3 トピックは 0 件**。fetch の log に `error` は無く、3 トピックとも `0 new`。

**0 件の原因を実測した:** arXiv API を直接引くと、planner_ai の keyword で最新の `published` が 2026-10-30T12:35Z だった。今日の cutoff (実行 18:00Z から lookback_days=2 を引いた 10-31 18:00Z) より古いので、API に出ている論文は全部窓外に落ちる。月曜 announce 分 (金曜夜〜日曜の投稿) は `published` が金曜以前の時刻なので、lb=2 では月曜の窓が構造的に空になる (09-13 に確定した機構と一致)。エラーが無いので log では見分けられない。

**RSS で回収した。** 5 カテゴリすべてが月曜 announce 分を返している (lastBuildDate 2026-11-02 05:00Z; cs.LG 337 / cs.CL 138 / cs.CV 165 / cs.RO 110 / cs.AI 297 件)。過去のブリーフ・rejected に出た id と replace 版を除き、topics.yaml の keyword で絞った 167 件のタイトルを見て、上位 18 件の abstract を読んで採点した。残りの約 150 件はタイトルの時点で 3 トピックの基準に合わず、評価を付けていない (医療・化学・LLM の安全性・multi-agent など)。評価は topics.yaml の relevance_criteria による 0-5 点で、abstract のみに基づく。

## 採用 (6 本)

2610.40935 (P3 4.5) / 2610.41185 (P1 4.0) / 2610.41772 (P1 4.0) / 2610.40900 (P2 4.0) / 2610.40857 (P2 4.0) / 2610.41609 (P3 3.5)。総数の上限 6 に合わせ、最低点の wildcard (3.0) を見送った。

## sns_wildcard (candidates.json の 3 件、全部不採用)

- 2610.36545: FrameForge — 動画 model の事前知識を、条件付き画像生成の時間位置の割り当てで使い分ける (MoTE と CoTR)。基盤 model の転用の発想は P2 に近いが、運転・制御への接点が無い (評価 3.0, hf 109)。**次点。** 上限 6 本に届かず見送り。ブリーフは作っていない
- 2610.39497: Does Scaling Toward AGI Depend on What System-1 Lets System-2 Execute? — 軽い予測器 (System-1) が候補を選別し、高価な実行 (System-2) は選ばれたものだけに使うと、実行 cost は有用な相互作用の密度 ρ_u の逆数に近づくという理論。選別器の誤差と margin で regret (選択の損失) に上界を与える。GATS (2610.40935) の「token を選別して計算を減らす」と同じ構図で読めるが、実験が abstract に無い (評価 3.0, hf 52)。**次点**
- 2610.22740: R^2Orch — 自己対戦で agent の orchestrator (複数の skill を使い分ける上位 model) を改善する LLM agent の学習。3 プロジェクトに接点が無い (評価 2.0, hf 86)

## 次の空き日に繰り越せる次点 (今日の RSS 分、評価 3.5)

- 2610.41408: SACQ — VLA 向けの ultra-low-bit (極端に少ない bit) の weight 量子化。出力 action の誤差で層ごとの bit を配分する。GR00T N1.7 で評価 (P3)。運転への接点が無い
- 2610.42096: CausalWAM — world action model が、action の原因となる latent だけで action を出すよう、sparsity 制約で分離する。同定可能性の証明つき (P3)。abstract に実験結果の数値が無い
- 2610.42146: ID-WM — 高位 model で到達可能な subgoal を出し、低位 world model を逆動力学として接地する階層 world model (P3)。navigation 3 task のみ
- 2610.41330: Hourglass — body に依存しない world model と、各 robot の微分可能な ego-dynamics を camera の ego-motion でつなぎ、cross-embodiment の motion planning を行う (P1・P3)。他機種適合の観点でも使える。flat ground の仮定が強い
- 2610.41130: TetraState — world model の regression testing (4 つの設定での判定と、harness の版管理)。accuracy の変化が 0.2 point でも 11 個の test の判定が変わる (P1 の評価設計)。対象が物理の動画 test で、運転に遠い
- 2610.40922: Confidence-Modulated Safety Filtering — E2E policy の confidence で safety filter の保守度を変える (P1)。F1TENTH の simulation のみで予備的
- 2610.41970: When Does Test-Time Search Help World Action Models? — test-time の候補選択は random より悪く、速度向上も 1.15 倍と目標に届かないという事前登録の否定的結果 (P3)。manipulation のみ
- 2610.41663: ResMerge — 凍結した policy に、RL で学ぶ residual policy を足して merge する continual adaptation (P2)。robot manipulation のみ
- 2610.41362: Task-Performance Routing — 領域ごとの誤差で multi-teacher distillation の重みを決める (P2)。CT segmentation のみ
- 2610.40954: CAMEL — 眼底画像の基盤 model を、cross-architecture の蒸留で超軽量にする (P2)。abstract に数値が無い

## 評価 3.0 以下で見送り

- 2610.42000: Less Loss, Fixed Weights — fine-tuning の忘却を、固定した語彙 bias と温度で戻せるか。回復は最大 36% で、数学で追加学習した model はほぼ戻らない (3.0)。P2 の忘却の議論に使えるが、否定的な結果が中心
- 2610.41147: HyperRepair — fine-tuning した LLM が失った一般能力の回復 (3.0)。LLM 限定
- 2610.41769: Stepwise-Querying — teacher の chain-of-thought が見えなくても推論を蒸留する (3.0)。LLM の reasoning 限定
- 2610.42135: A Better Critic Matters for Distribution Matching Distillation — 拡散 model の少 step 蒸留の critic の改善 (3.0)。画像生成が対象
- 2610.41041: Before We Adapt — continual world model の zero-shot 汎化の限界を、FourRooms の小さな環境で測る (3.0)。toy 環境
- 2610.41477: AC-SMPC — 状態制約つきの微分可能な actor-critic MPC (3.0)。robot navigation の小規模な検証
- 2610.41834: ObjectGuidedMap — 遮蔽の多い場面の BEV (Bird's Eye View; 真上から見た地図) 予測 (3.0)。perception の話で planner に直結しない
- 2610.40947: UFMF — radar を使った 4D occupancy の予測 (3.0)。perception 側
- 2610.41022 / 2610.41273: latent world model を使う RL / 連続時間 world model (3.0)。運転・制御への接点が abstract に無い
- 2610.42021: Nexus-VLA — 人と robot の経験を共有する階層的な semantic latent (3.0)。人の動画 → robot の転用で、運転への接点が薄い
- 2610.41009: STAR — 推論時に action の表現を steering する (3.0)。manipulation のみ
- 上記以外の RSS の約 130 件は、タイトルで 3 トピックの基準に合わないと判断し、評価を付けていない。

## 前日 (11-02) の rejected.md に残した次点 11 件

今日は本流の RSS 分だけで 6 本の枠が埋まったので使っていない。2610.39416 / 2610.40373 / 2610.39812 / 2610.39721 / 2610.39278 / 2610.38356 / 2610.39876 / 2610.38637 / 2610.38681 / 2610.38383 / 2610.38160 は、評価 (3.5) と理由を 11-02 の rejected.md に残したまま、次の空き日に使える。
