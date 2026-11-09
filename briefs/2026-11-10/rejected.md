# rejected 2026-11-10

採用 5 本 (上限 6 本)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。採用の閾値は直近の運用と同じ 3.5 点。

## 候補の出どころ

candidates.json は 3 件で、すべて sns_wildcard (generated_at 2026-11-09T18:00Z = 月曜夜の fetch)。planner_ai / fm_distill_finetune / next_arch は 0 件だった。月曜は金曜〜日曜の投稿分が announce される日で、本来は数十件ある。エラー無しで 0 件に見えた可能性が高いので、arXiv の新着 feed (RSS; Really Simple Syndication) を直接取得して回収分を採点した。回収分は 137 件 (既読・replace を除き、本流 keyword に一致したもの)。そこから上の 3 トピックの基準で選んだ。回収分には hf_upvotes が無いので、タイブレークには使えていない。

## 採用 (5 本)

- 2611.09888 (P1 4.5) Scenario Orchestration — 閉ループ評価で狙った場面を保つ
- 2611.03953 (P2 4.5; wildcard → fm_distill_finetune に移した) P^2-MOPD
- 2611.09042 (P2 4.0) FPRT
- 2611.08631 (P3 4.0) BEVCast
- 2611.08657 (P3 3.5) JEPAhead

## 不採用: candidates.json の wildcard

- 2611.08264: SplatAnything: Gaussian Spacing Normalization for Feed-forward 3DGS across Arbitrary Scenes — [2.0] feed-forward 3DGS (Gaussian Splatting; 3D scene を Gaussian の集合で表す手法を、1 回の forward で出す版) の scale 正規化。world model の表現として遠くつながるが、運転の予測・planning への接点が abstract に無い。hf_upvotes は 59 と高いが、relevance を上書きしない規則どおり落とした。
- 2611.06856: LongBanana: An Expert-Verified Benchmark for Long-Context Multi-Reference Image Synthesis — [1.0] 画像生成 agent の benchmark。P1/P2/P3 のいずれにも接点が薄い。wildcard 枠は P^2-MOPD を本流に移したため、wildcard としての採用は 0 件。

## 不採用: RSS 回収分 (3.0〜3.5 の次点)

- 2611.09524: RadarDINO: Distilling a Visual Foundation Model into mmWave Radar for Human Mesh Reconstruction — [3.5] DINOv3 の特徴を、calibrated な RGB-radar の幾何で radar の voxel に蒸留する。別 modality への転用 recipe として P2 に近い。ただし対象が人体 mesh で、P2 の quota (2) は P^2-MOPD と FPRT で埋まった。次点。
- 2611.08800: On the Few-Shot Adaptation of Vision-Language Models: A Few Gradient Signs Are All You Need — [3.5] gradient の符号と上位 magnitude の位置だけで更新する state-free な optimizer (SignSparseSGD)。少データ適合の観点で P2 に合うが、CLIP の few-shot 分類が対象で、quota に入らなかった。次点。
- 2611.06817: Open-HumanWAM: An Open Recipe for Scaling Human and Robot Experience for Embodied Foundation Models — [3.5] egocentric 人間動画 50,000 時間の pretraining と log-linear な scaling law。P3 の scaling に関係するが manipulation 限定。P3 の quota (2) は BEVCast と JEPAhead で埋まった。次点。
- 2611.09670: Goodhart in the Planner: Sampling-Based Control Exploits Rewards Learned from Human Preferences — [3.0] 学習した reward model に対して探索 (MPPI; sampling で制御列を選ぶ手法) を強くするほど true return が下がる、という計測と補正則。planner が learned scorer を過剰に最適化する問題として P1 に参考になるが、HalfCheetah / Meta-World が対象で運転ではない。
- 2611.09270: EGT: Execution-Grounded Traversability through Learned Closed-Loop Trajectory Distributions — [2.5] 不整地走行の可否を、閉ループ trajectory の分布 (flow matching) で見積もる。「評価指標が closed-loop の挙動を無視する」という問題意識は P1 に近いが、off-road の地形が対象。
- 2611.08827: ActPrune: Action-Grounded Visual Token Pruning for Efficient Vision-Language-Action Models — [3.0] 直前の action chunk から visual token の pruning を encoder の前で決める training-free 手法。manipulation の camera 配置 (固定 view + wrist view) に依存する。先日の T3R (11-08 不採用) と同じ理由。
- 2611.09684: SURE: Spatiotemporal Uncertainty Representation for Efficient Vision-Language-Action Learning — [3.0] 10% の demonstration data で baseline VLA に並ぶ data 効率化。manipulation 限定で、運転の action 分布に移る根拠が abstract に無い。
- 2611.08917: PRISM: Primitive Routing via In-context Skill Mixing for Retentive VLA Adaptation — [3.0] skill ごとの LoRA を bank に持ち router で合成する。適合の観点はあるが、manipulation の composite task に特化。
- 2611.09672: ODEAction: From Predicting Chunks to Evolving Actions — [3.0] action chunk の境界の不連続を、ODE で action を連続的に発展させて消す。manipulation 評価のみ。
- 2611.08959: Accuracy Is Not Value: Choosing Weak Supervisors by What the Student Inherits — [3.0] weak supervisor の価値を student の learning operator 越しに測る理論。線形 learner と squared loss の仮定で、実務の recipe にならない。
- 2611.09024: Knowledge Distillation from Neural Networks to Differentiable Logic Networks — [2.5] MLP から DLN (Differentiable Logic Network; 論理ゲートを学習する軽量 classifier) への蒸留。tabular 分類 20 task が対象で、foundation model の蒸留とは距離がある。
- 2611.08561: Towards Label-Efficient Geospatial Foundation Model Adaptation via Positive-Unlabeled Learning for Building Damage Mapping — [3.0] 損傷建物のラベルが少数でも PEFT (Parameter-Efficient Fine-Tuning; 一部の重みだけ更新する適合) を回す PUMA。少ラベル適合の観点は合うが、リモートセンシング限定。
- 2611.09625: Encoding Memory in World Models with Test-Time Model-Based Reinforcement Learning — [3.0] 推論時に gradient descent で episode の記憶を world model の重みに書き込む。Memory Maze の長期記憶が対象で、運転への接点が薄い。
- 2611.09888 以外の運転・planner 関連で 3.0 未満: 2611.09139 (CARGO; 協調運転の MARL)、2611.09210 (TPS-A*; any-shape vehicle の path planning)、2611.08681 (自動運転車の認証の制度比較)。

## 不採用: RSS 回収分のうち上記以外

keyword に一致しただけで、P1/P2/P3 と無関係な論文 (医療・音声・agent・protein・財務・LLM 安全性など約 110 件) は 1 件ずつ記録しない。keyword 一致の例は "teacher" (NLP の teacher-student)、"compression" (KV cache・BPE)、"fine-tun" (domain 特化 LLM の監査) など。

## 運用メモ

- 今日の candidates.json は月曜 18:00Z の fetch なのに本流 0 件。予告 (10-06 型: 金〜日投稿分が月曜 announce なのに窓外 / エラーで 0 件) と一致する。fetch の log はこの環境から確認できず、原因 (API エラーか窓の問題か) は特定できていない。`fetch_candidates.py` / `topics.yaml` は変更していない。
- 回収に使った script は /tmp/rss_1110/run.py (過去の /tmp/rss_1103/run.py のコピー)。採用 5 本のうち 4 本 (P^2-MOPD 以外) は RSS 回収分だった。
- 11-07 の次点 2611.07349 (GEAR) と 2611.07939 (WAM-Sim0.1) は、RSS 回収分に出ていない。
