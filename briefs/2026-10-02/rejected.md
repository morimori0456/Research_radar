# 2026-10-02 不採用: candidates.json の 61 件と、RSS で回収した本流の不採用 89 件

## §0 fetch 診断 (選別の前に実施)

- **今日は fetch のエラーなし。** `~/research_loop.log` 03:00 の実行で 3 トピックとも正常に返った (planner_ai 4 / fm_distill 30 / next_arch 30)。09-23 以来続いた「本流 0 件 = API エラー」は今日は起きていない。
- **ただし fm_distill と next_arch は max_results=30 の天井に当たっている** (09-30 に記録した律速と同じ)。窓は 09-29T18:00Z から始まるが、返った 30 件の投稿時刻は:
  - fm_distill_finetune: 09-30 **13:16Z〜17:59Z (約 5 時間分)**
  - next_arch: 09-30 **07:11Z〜17:59Z (約 11 時間分)** (next_arch の 30 件のうち 2 件は fm と重複して 28 件)
  - planner_ai: 4 件で天井に届いていない (09-29 22:59Z〜09-30 12:06Z)
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ、Thu 01 Oct の announce) は 5 本とも 200。**new/cross 1,138 件を topics.yaml の keyword で照合すると、planner_ai 4 件 (candidates.json と同じ 4 件)、fm_distill 92 件 (うち candidates.json にあるのは 20 件)、next_arch 51 件 (同 28 件)。`briefs/` の既読 id と candidates.json を除くと、**未読は fm 69 件・next 23 件 (両方に一致した 1 件を 1 件と数えて 91 件)。**fm の keyword 一致の 3/4、next の約半分が、天井で落ちていた。
- **判断: 10-01 と同じく、RSS で回収した分も candidates.json と同じ基準で採点した。**10-01 の記録は「fetch がエラーの日は RSS 分を採点する」だったが、今日のように天井で切れている日も、落ちた分が窓の内側にあることは同じなので、扱いを揃えた。**採用 6 本のうち 2 本 (TrafficSignBench・Truck VLA) は RSS 回収分**で、どちらも今日の各トピックの最高点だった。天井が無ければ candidates.json に入っていたはずの論文。
- wildcard の 3 件のうち 2 件 (`2609.33439` Raven / `2609.36012` ICL for Robots) は **10-01 の rejected.md で採点済み**の再配信 (欠陥#2 dedup)。

## §1 判断の分岐点

1. **P1 枠は TrafficSignBench (RSS・fm の keyword `fine-tuning` で一致) を planner_ai に再分類して使った。**candidates.json の planner_ai は 4 件のうち運転が 2 件 (EMPlan 4.0・Sparse Planner 3.5)。TrafficSignBench は「評価手法の新提案」で P1 の最高優先に当たる (4.5)。2 本目は EMPlan。
2. **P2 枠の 1 本目は Truck VLA (RSS・next の keyword `VLA` で一致) を fm_distill に配属した。**内容は P2 の fine-tuning の観点 (他機種への少データ適合) にほぼ完全に一致する (4.5)。2 本目は、capacity gap 対策の GFD-OPD (4.0) を、同点の transfer map (`2609.39702`)・OLIVE (`2609.36246`)・self-distillation の 3 軸の比較 (`2609.39494`) より優先した。09-30〜10-01 で LLM の OPD を 4 本読んでおり、拡散・flow 系の蒸留はまだ 1 本も読んでいないため。
3. **P3 の 2 本目は ReWAM (4.0) と AD-Memo (`2609.38641`; 4.0) が同点。**ReWAM は NAVSIM SOTA で E2E 運転の WAM、AD-Memo は運転 VLA の記憶。ReWAM の評価が non-reactive だけという弱点を承知で、「他車を応答する主体として扱う」という設計軸の新しさを取った。AD-Memo は繰り越しの筆頭。
4. **探索枠 (sns_wildcard) は空けた。**新規の 1 件 (MaLiang-Harness) は 2.0、残り 2 件は再配信。本流の 4.0 以上で上限 6 を使い切った。

採用: P1 2/2 ・ P2 2/2 ・ P3 2/2 ・ wildcard 0/1 = **6/6**。

## §2 次点 (4.0 前後。quota で落としたもので、質が低いわけではない)


- 2609.38641: Vision-Language-Action Autonomous Driving Agent with Language-based Memory — P3 4.0 [RSS] — AD-Memo: 運転 VLA が、周囲の重要物体の記録を chain-of-thought の延長として言語で書き出し、次の入力に戻す。全方向一時停止の到着順のような「記憶が要る」場面に効く。学習は SFT + semi-closed-loop の RL (Da Capo; 記憶には軌跡単位、運転にはステップ単位の advantage)。P3 の 2 本目と同点で、NAVSIM SOTA の ReWAM を優先したが、**明日以降の繰り越しの筆頭**
- 2609.39702: A helps B while B hurts A: directed transfer in instruction-tuning mixture — P2 4.0 [candidates] — instruction-tuning のデータ混合で、「A は B を助けるが B は A を害する」という非対称な転移を符号付きの transfer map として推定し、混合を事前に選ぶ。map はモデルの大きさをまたいで転移する。**ドメイン適合でどのデータを混ぜるかの決め方として P2 に効く**が、quota 2 を Truck VLA と GFD-OPD に使ったので次点の筆頭
- 2609.36246: Learning from Teacher Continuations at Student States — P2 4.0 [RSS] — OLIVE: student が書いた途中から teacher が続きを書き、その teacher の token で student を学習する online 蒸留。teacher の確率が不要で、OPD より強い (ScienceWorld で offline SFT +13%)。**teacher の出力が文字列しか取れない状況での蒸留として P2 の次点**。LLM の OPD は既読が多いので上限で落とした
- 2609.39494: Disentangling Self-Distillation: Measuring and Modeling Acquisition and Retention — P2 4.0 [RSS] — 特権情報付きの self-distillation を、rollout の出所・teacher の更新の仕方・KL の向きの 3 軸に分け、1,200 回の適合実験で全組み合わせを比べた。「どの軸を先に調整すべきか」の地図として有用。次点
- 2609.39570: Sparse Planner: A Hybrid Planner for Efficient Sampling via a Conditional Variational Autoencoder — P1 3.5 [candidates] — sampling 型の planner (候補軌跡を多数ばらまいて cost で選ぶ方式) の sample を、CVAE (Conditional Variational Autoencoder; 条件付きの生成モデル) で「良さそうな領域」に絞る。FISS+ より低 cost で sample 密度 1/8。実時間性と実行時間のばらつき削減は P1 に効くが、評価は自前の場面のみで、ベンチマーク比較がない。EMPlan (同じ「候補を減らして速く」) を優先した
- 2609.39971: When Instructions Retrieve Trajectories: Diagnosing and Mitigating Generalization Failures in VLA Models — P3 3.5 [candidates] — VLA が「指示を読んで行動を変える」べき場面で、指示から学習時の軌跡を引き出しているだけ、という失敗の診断。集計の頑健性スコアがこの失敗を隠す、という評価側の指摘は P1 にも効く。manipulation のみなので上限で落とした
- 2609.39822: Toward Real-Time VLAs: Stage-Aware Two-Step Flow Denoising and System-Level Evaluation — P3 3.5 [candidates] — VLA の flow-matching の denoising を、速度場の性質に合わせて 10 → 2 ステップに減らし、推論 61.6 → 22.0 ms。システム全体の遅延の計測と実行方式 6 種の比較もある。車載の実時間性に効くが、評価は服たたみ 1 タスク。次点
- 2609.40222: LOCI: Spatial Linear Memory for Streaming World Models — P3 3.5 [candidates] — video world model の記憶を、KV cache と、カメラの幾何で読み書きする linear attention の記憶の混成にして、再訪した場所を正しく再現しつつメモリを 30% 減らす。長時間の運転シーン生成に効く構造だが、評価はゲーム的な環境。次点
- 2609.39182: MEND: Label-Free Detection, Localisation, and Correction of Latent Hallucination in World Models — P3 3.5 [candidates] — latent world model の「ありえない次状態」(hallucination) を、ラベル無しで検出・局所化・補正する。score network 1 つで 3 役。world model を planner に使うときの監視として有用だが、評価は navigation の 2 環境だけ。次点
- 2609.39757: Revisiting On-policy Adversarial Black-Box Distillation: Calibrating Groupwise Reward Geometry for Effective Advantage Construction — P2 3.5 [candidates] — API でしか触れない LLM の black-box 蒸留で、識別器の報酬から GRPO の advantage を作るときの、報酬のばらつきの潰れを補正する。LLM の OPD は既読が多く、teacher の確率が取れない状況は P2 の現状と合わないので次点
- 2609.39920: MCD: Causal Distillation of Multimodal In-Context Learning in Large Vision-Language Models — P2 3.5 [candidates] — 大きい VLM の in-context learning の能力を小さい VLM に蒸留する。出力分布ではなく「どの証拠に基づいて答えたか」を因果的な介入で移す。蒸留の新しい監督信号としては面白いが、ICL の能力に限られる。次点

## §3 candidates.json の不採用 (次点以外)

### planner_ai (P1)

- 2609.38707: Residual Wrench Certification and Margin-Aware Control Synthesis for Aerial Physical Interaction — P1 0.5 — マルチロータ (ドローン) が接触しながら作業するときの、残りの推力余裕の保証。運転と無関係
- 2609.38640: Yggdrasil: a Layer-First 3D Scene Graph for Real-Time Querying — P1 1.0 — ロボットの 3D scene graph (物体と関係をグラフで表す地図) を実時間で問い合わせるためのデータ構造。planner の評価には繋がらない

### fm_distill_finetune (P2)

- 2609.40361: Ranking-Aware Prompt Optimization for Multimodal Clinical Diagnosis — P2 1.5 — 臨床診断の MLLM のプロンプト最適化を AUROC で行う。不均衡データでは accuracy でなく順位の指標で最適化せよ、という主張は一般的に正しいが、蒸留・適合の recipe ではない
- 2609.40356: ViTeX-Bench: Benchmarking High-Fidelity Video Scene Text Editing — P2 0.5 — 動画中の文字を書き換える編集のベンチマーク。分野外
- 2609.40353: AssemblyWorld: Rethinking 3D Assembly with General-Purpose Agents — P2 1.0 — 汎用 agent に 3D の組み立てをさせる環境。`fine-tuning` は「追加学習なしで」の文脈
- 2609.40335: Is Weight Tying Still Beneficial for Decoder-Only LLMs in Private Settings Under DP-SGD? — P2 1.0 — 差分プライバシー付き学習 (DP-SGD) での weight tying の是非。プライバシーの設定に限られる
- 2609.40322: MatLoom: Layered Text-to-Material Generation in a Compact Program Space — P2 0.5 — テキストから材質 (PBR) をプログラムとして生成。分野外
- 2609.40253: ComputerSD: Online Self-Distillation from Real-Time Feedback for Computer-Use Agents — P2 3.0 — computer-use agent の online self-distillation。特権情報で採点し直す OPSD を、実行時のフィードバックに合わせて更新する。LLM agent 専用で、09-30〜10-01 に LLM の OPD を 4 本読んだので優先度を下げた
- 2609.40236: Comparison of techniques for fine-tuning open-weight models for entity extraction from radiology reports — P2 2.0 — 放射線レポートからの抽出で Gemma-3-12B を fine-tuning して GPT-4o と比べる。手法の比較 (LoRA 等) はあるが医療テキストに閉じている
- 2609.40230: EviRover: Reinforcing Agentic Perception Beyond a Glance — P2 1.0 — 画像だけでは答えられない質問に、agent が追加の証拠を探しに行く RL。適合とは無関係
- 2609.40159: Reinforcement Learning-Guided Graph Transformations for SpTRSV Optimization — P2 0.0 — 疎な三角行列の求解を RL で最適化。分野外
- 2609.40111: Agent Error Dataset: Scaling 50,000 Error--Diagnosis Pairs for Failure Analysis and Error-Aware Post-Training (hf 28) — P2 2.0 — LLM agent の失敗と診断の 50,000 ペアのデータセット (hf 28)。「失敗した rollout から学ぶ」は面白いが、蒸留・適合の recipe ではない。hf_upvotes は今日の本流で最大だが relevance を上書きしない
- 2609.40108: OverdoseMoE: A Multi-Expert Framework for Opioid Overdose Risk Prediction — P2 1.0 — オピオイド過剰摂取リスクの予測 (医療 ICD 系列)。分野外
- 2609.40075: Accelerated Algorithm for Sparse Regularized Partial Optimal Transport — P2 0.5 — 疎な正則化付き partial optimal transport の高速化。純粋な最適化アルゴリズム
- 2609.40064: From Tweets to Trades: Analyzing the Influence of Public Mood over Stock Market Performance in Turkiye — P2 0.0 — トルコの SNS の世論と株価。分野外
- 2609.40043: MAGiDiff: Sampling the Photospheric Vector Field from UV/EUV Filtergrams — P2 0.5 — 太陽の磁場を紫外線画像から推定する拡散モデル。分野外
- 2609.40030: Fenchel Tilting: Weighted Correction for Efficient Finetuning of Generative Models — P2 3.0 — 生成モデルを任意の効用関数に合わせる fine-tuning を、重み付きの flow matching 1 段で行い、サンプリング軌跡を微分しない (最大 20 倍効率)。diffusion planner の報酬調整に効く可能性はあるが、評価は画像と分子だけ
- 2609.39912: TRACE: Trajectory Selection for Parallel Scaling of Search Agents — P2 1.0 — 並列検索 agent の答えの選択を学習した selector で行う。分野外
- 2609.39866: Preemptive LLM Unlearning against Forbidden Capability Acquisition via Gradient Sealing — P2 1.0 — 公開前の LLM に「悪用目的の fine-tuning で能力を得られない」よう封印する。安全性の研究
- 2609.39839: Dynamic LoRA-Experts and Prototype-Ensemble Matching for Class-Incremental Learning — P2 2.5 — class-incremental learning (クラスを順に追加しながら忘れずに学ぶ) を LoRA の expert と prototype の照合で。PEFT の使い方として参考程度
- 2609.39838: Learning Steganography Is Easy, Learning Steganographic Reasoning Is Hard — P2 0.5 — LLM が推論を隠す steganography の学習しやすさ。安全性の研究
- 2609.39810: A Comprehensive Benchmark of Source-Free Universal Domain Adaptation on Time Series Representations — P2 2.5 — 時系列での source-free universal domain adaptation (元データにアクセスせず、ラベル集合のずれも許す適合) の初のベンチマーク。時系列の基盤モデルも比較している。domain adaptation だが時系列分類で、運転のセンサー系列にすぐ繋がる形ではない
- 2609.39794: Inline Memory Meets Reusable Skills: Memory-centric Framework for Vision-Language-Action Model — P3 3.0 — VLA の新タスクへの適合を、重みを変えずに記憶 (クエリ→スキルの照合) で行う。fine-tuning を避ける適合の一案だが manipulation 専用
- 2609.39773: Riemannian Flow Models with Reinforcement Learning for Molecular Crystal Structure Prediction — P2 0.5 — 分子結晶の構造予測。分野外
- 2609.39749: Validity-Preserving Hierarchical RL for Joint Routing and Switch Placement in EDA — P2 0.0 — チップ設計の配線と配置の階層 RL。分野外
- 2609.39709: BTC3D: Blended Tile Conditioning for Detail-Enhancing Image-to-3D Generation — P2 0.5 — 画像から 3D を生成するときの細部の再現。分野外
- 2609.39704: When Masking Helps or Hurts Robustness in Compressed CLIP: A Pre-Deployment Diagnostic — P2 3.0 — 圧縮した CLIP で、マスクによる token の間引きが頑健性を上げるか下げるかを、デプロイ前にラベル無しで予測する指標。圧縮モデルの事前診断として面白いが、対象は spurious correlation のベンチマーク

### next_arch (P3)

- 2609.40358: Physis-Lang: Self-Evolving Language as a Physical Representation for Video World Model (hf 6) — P3 3.0 — video world model の物理的な正しさを、自己進化する言語表現で補う (hf 6)。「言語で物理を表せる」という主張は面白いが、運転への接続が遠い
- 2609.40306: DynaHarness: A Dynamic Physical Harness for Self-Evolving Robot Agents — P3 1.5 — 長い horizon の manipulation で、意味の推論と物理の実行を結ぶ harness。ロボット agent の系
- 2609.40177: Social-WM: Safety-Aware Latent World Models for Robot Social Navigation — P3 3.0 — ロボットの social navigation で、指令した行動と実際に実行できた行動のずれを latent world model で学ぶ。歩行者の中を走るロボット向け
- 2609.40165: PrefPI: Preference-Guided Steering into Out-of-Distribution Behaviors — P3 2.0 — 生成型のロボット policy を、自分の軌跡に対する相対的な好みだけで分布の外に導く。manipulation
- 2609.40153: Dream4ACT: A Shared Visual Action Interface for Multi-Embodiment Video-Action Modeling — P3 2.5 — 複数のロボットの体に共通の「視覚的な行動の表現」を作り、動画生成モデルで行動を学ぶ。embodiment をまたぐ設計は P2 の他機種適合と通じるが、ロボットアーム間の話
- 2609.40134: Tactile Curiosity Drives Robot Interaction — P3 1.0 — 触覚の好奇心で manipulation の RL を効率化。分野外
- 2609.40007: Multi-Link Safety Filtering for VLA Policies Around Moving Hazards — P3 2.5 — VLA の腕全体を、動く危険物から実行時に遠ざける安全フィルタ。再学習なし。manipulation
- 2609.40003: DashVMC: Real-Time Discrete World Model Control in Geometry Dash — P3 2.0 — ゲーム Geometry Dash を 2 時間のプレイから学んだ離散 world model で実時間制御。world model の実時間性の toy としては面白いが学びは小さい
- 2609.39973: EWAM: Emergent Depth-Wise Specialization in a Unified Embodied Model -- From Semantic Understanding through Visual Foresight to Action — P3 3.0 — VLA と WAM を統合したモデルで、層の深さごとに「意味の理解 → 未来の予測 → 行動」の役割分担が自然に生じる。構造の分析として面白いが manipulation
- 2609.39820: Learning from Runtime Feedback through Failure-Bank Self-Evolution for Vision-Language-Action Models — P3 2.5 — VLA と安全シールドの不一致を失敗のバンクに溜めて自己改善する。manipulation
- 2609.39751: Beyond Policy Alignment: Closing the Planning-Learning Loop for Robot Control with Learned World Models — P3 3.0 — TD-MPC 型 (学習した world model の中で最適化して行動を決め、その経験で価値と方策を学ぶ) の planning と学習のループを、critic の監督と終端の価値の推定まで含めて調整する。HumanoidBench で大きく伸びるがタスク依存
- 2609.39727: OverForge: Reasoning Through Strategies and Tactics Helps Cooperative Lifelong Adaptation — P3 1.0 — 協調する LLM agent の戦略と戦術の分離。分野外
- 2609.39685: RoboCoach: World Models as Active Coaches for Compositional Robot Skills (hf 7) — P3 3.0 — world model で失敗を想像し、どのスキルに追加の実演を頼むかを決める (hf 7)。「想像した失敗でデータ収集を導く」は運転の long-tail 収集にも通じるが manipulation
- 2609.39670: From Local Whole-Body VLA Behaviors to Scene-Scale Aerial Manipulation — P3 1.5 — ドローンに付けたアームでの VLA。分野外
- 2609.39601: GroundingPI: A Grounding Foundation Model towards Physical Intelligence with Visual Primitives — P3 2.5 — VLA の前段に置く 4B の grounding (どの物体がどこにあるかを点で示す) 基盤モデル。manipulation
- 2609.39526: Discrete Forcing: Infusing Discrete Guidance into Continuous Denoising for Few-Step Action Experts — P3 3.0 — VLA の action expert で、離散 token の粗い構造を連続の flow-matching に誘導として入れ、少ステップで精度を出す。action head の設計として参考
- 2609.39514: Spike-driven Vision-Language-Action Model — P3 2.0 — spiking neural network で VLA を省電力化。運転の車載では現実性が低い
- 2609.39403: IronMind: Scaling Humanoid Dexterous Manipulation via Camera-Space Ego-Centric Pretraining — P3 1.5 — 人の一人称動画から humanoid の器用な操作を事前学習。分野外
- 2609.39324: MotionWeave: Learning Motion-Centered Future Dynamics for Vision-Language-Action Policies — P3 3.0 — VLA に未来の動き中心の予測を補助タスクとして入れる。未来の画像全体ではなく、行動に関係する局所的な動きだけを予測する点は DRPE と同じ発想
- 2609.39198: DSDyn-VLA: A Dual-Stream Dynamic Manipulation Framework with Motion Perception, Future Awareness, and Realtime Correction — P3 2.0 — ベルトコンベア上の動く物体を扱う VLA。知覚・遅延・制御の 3 つのギャップ。manipulation
- 2609.39179: LocoWM: High-Precision Locomotion through World-Model-Guided Residual Adaptation — P3 2.0 — 脚ロボットの高精度な歩行を world model で先回りして補正。分野外
- 2609.39178: Exploiting Vulnerabilities: Universal Adversarial Attacks on Vision-Language-Action Models in Robotics — P3 1.5 — VLA への汎用の敵対的攻撃。安全性の研究
- 2609.39145: Blackout vs. Freeze: Analyzing Physical Failure Modes of VLAs under Camera Faults — P3 2.5 — VLA のカメラが真っ暗になる / 固まるときの物理的な失敗の違い。センサー故障時の挙動の分析は運転にも関係するが、manipulation の 2 モデルのみ

### sns_wildcard (探索枠)

- 2609.33439: Raven: The Harness of Harnesses for Composable Agentic Intelligence (hf 495) — EXPLORE 2.5 — **10-01 の rejected.md で採点済み**の再配信 (hf 495)。wildcard の fetch が既読 id を除外していない (欠陥#2)。評価は変わらない
- 2609.34309: MaLiang-Harness: A Programmable Path to Image and Video Generation (hf 383) — EXPLORE 2.0 — 画像・動画の生成を MLLM が書くプログラムで行い、「プログラムは動くが絵が要求と違う」ずれを反復で詰める harness (hf 383)。注目度は高いが P1〜P3 に繋がる学びがない
- 2609.36012: In-Context Learning for Robots: Methods and Applications (hf 358) — EXPLORE 3.0 — **10-01 の rejected.md で採点済み**の再配信 (hf 358)。ロボットの ICL のサーベイ。上限に余裕のある日に読む価値は変わらない

## §4 RSS 回収分の不採用 (次点以外)

### 蒸留・適合・運転・world model に関係するもの

- 2609.38666: Understanding Off- vs On-Policy Distillation: A Tale of Distinct Training Objectives — P2 3.5 — off-policy (forward KL) と on-policy (reverse KL) の蒸留が、複数 teacher のときに別の目標 (算術平均 vs 幾何平均) を学ぶことを理論で示す。OPD の脆さの説明として 10-01 の KL 論文と組で読める
- 2609.39338: Learning Beyond Full Imitation: Task-Preserving Knowledge Distillation — P2 3.5 — student が teacher より正解クラスを鋭く識別しているとき、完全な模倣はその識別力を手放させる。正解の優位を保ったまま不正解クラス間の関係だけを移す TPKD。CIFAR-100 で +0.47pt と改善は小さい
- 2609.38987: Smaller Models, Better Rejects: Preference Distillation Scaling — P2 3.5 — preference 蒸留の「悪い例」は、student 自身より小さい凍結モデルが作った方が効く (7B〜72B)。データ作成のコストを下げる実務的な知見だが LLM のコードと数学に限られる
- 2609.36734: Distilling What Matters: Confidence-Aware Selective Distillation for Large Language Models — P2 3.5 — teacher が student より自信がない token では蒸留の更新を止め、自信の比に応じて forward/reverse KL を切り替える。8 組の teacher-student で一貫した改善
- 2609.39390: Decoupled and Distilled: Task-Adaptive LoRA-Teachers with Ensemble Knowledge Transfer for Few-Shot Class-Incremental Learning — P2 3.0 — 少数ショットの class-incremental learning で、タスクごとの LoRA teacher の ensemble から蒸留する
- 2609.38898: K2P: Label-Free Knowledge to Prompt Distillation — P2 2.5 — ラベル無しで知識をプロンプトに蒸留する。重みを変えない適合
- 2609.36707: LAURA: Knowledge Distillation for Interpretable Ambiguous Clause Identification in Legal Contracts — P2 1.5 — 法務の契約文の曖昧さ判定への蒸留。分野外
- 2609.39367: A Dynamical Theory of LoRA in Continual Learning — P2 3.0 — continual learning での LoRA の学習の力学を理論で解析。「LoRA は忘れにくい」の条件を与える
- 2609.39445: Raw-Routed Mixture of Adapters: A Causal Intervention for Routing Collapse in Time Series Foundation Models — P2 3.0 — 時系列基盤モデルの mixture of adapters で routing が潰れる問題に、生の入力で routing する因果的な介入
- 2609.39681: MC-PanDA++: Simpler, Stronger, and More Robust Domain-Adaptive Panoptic Segmentation — P2 3.0 — panoptic segmentation (物体と背景を同時に分ける) の domain adaptation を単純化して強くした。運転の知覚の適合には近いが planner・基盤モデルの蒸留からは外れる
- 2609.38637: Template-Search Domain Adaptation via Multi-Stage Feature Alignment for Cross-Modal Object Tracking — P2 2.0 — RGB と赤外など異なるモダリティ間の物体追跡の domain adaptation
- 2609.38547: Towards Universal Wasserstein Barycenters through Flow Matching — P2 1.5 — flow matching で Wasserstein 重心を求める。理論寄り
- 2609.39627: Introduction to Computer Vision — P2 0.0 — コンピュータビジョンの入門の教科書
- 2609.39684: Unapologetically Distributed: A Call for Decentralized Document Analysis — P2 0.5 — 分散型の文書解析の提言
- 2609.38472: Diffusion-2BC: Hybrid Diffusion and Regression Training for Offline Behavior Cloning in Autonomous Driving — P1 3.0 — 拡散モデルの behavior cloning に、学習時だけ決定的な回帰の補助 loss を足して closed-loop を安定させる。評価は CARLA の BEV 入力の小規模な設定
- 2609.38855: Online Evolution Strategy for Flow-Matching VLA Policies via Self-Supervised Trajectory Distribution Optimization — P3 3.0 — flow-matching の VLA を、自己教師ありの軌跡分布の最適化で online に進化させる (evolution strategy)
- 2609.38616: Correcting WHERE, Preserving HOW: Compositional Generalization for Vision-Language-Action Models via Referential Guidance — P3 3.0 — VLA の組み合わせの汎化: 「どこへ」は参照で直し、「どう動くか」は保つ
- 2609.38989: Cue the Flow: Steering Flow-Matching Policies for Open-World Delivery Manipulation — P3 2.5 — 配送の manipulation で flow-matching policy に手がかりを与えて誘導
- 2609.39038: Looking Back to Move Forward: Temporal Verification for Generative Robot Policies — P3 3.0 — 生成型ロボット policy の出力を、過去を振り返る時間方向の検証で選ぶ
- 2609.38401: Memorize, Adapt, Ignore: Diagnosing Robot Learning Mechanisms under Training Data Variation — P3 3.0 — 学習データの変化に対して、ロボット policy が「記憶・適合・無視」のどれで反応しているかを診断。データの効き方の分析として P2 にも少し効く
- 2609.38216: Fiatlux: A Long-Horizon Benchmark for Humanoid Ladder Climbing and Light-Bulb Replacement — P3 1.5 — humanoid が梯子を登って電球を替える長い horizon のベンチマーク
- 2609.39323: HiWE: Hierarchical World Knowledge Model with Visual Keypoint Enhancement for Zero-Shot 3D Path Planning — P3 2.5 — 階層的な world knowledge と視覚の keypoint でゼロショットの 3D 経路計画
- 2609.38927: World-as-Graph: Relational World Modeling Through Latent Space Graphs — P3 3.0 — world model の潜在空間を物体間の関係グラフとして学ぶ。運転の多エージェントの表現に繋がる可能性
- 2609.39101: Beyond Prediction: Steering VLM Agents with Retrospective World Modeling — P3 2.5 — VLM agent を、過去の予測の当たり外れを振り返る world model で導く
- 2609.39135: Asking the World: Generalist Physical Reasoning through Agentic World Modeling and Probing — P3 2.5 — agent が world model に問い合わせて物理推論をする
- 2609.38562: LongTake: Learning to Sustain Dynamics in Long-Horizon Video Generation — P3 2.0 — 長い動画生成で動きが止まる問題
- 2609.38839: FrameMorrow: Future-guided Frame Selection with Prospective Tokens for Long-Horizon Video Generation — P3 2.0 — 長い動画生成で未来を見越したフレーム選択
- 2609.38444: Audible World Models: Spatially Aware Sound Generation for 3D Worlds — P3 1.0 — 3D 世界の音の生成。分野外
- 2609.38278: Masked Swingers: Harnessing Data Augmentation to Advance Autoencoders for Self-Supervised Learning — P3 1.5 — autoencoder の自己教師あり学習のデータ拡張
- 2609.38733: Code to Control: Synthesizing Parameterized Reactive Controllers — P3 2.0 — コードから反応型の制御器を合成。`world model` は周辺語
- 2609.36314: Fractional State Space Transition for Long Sequence Modeling — P3 2.5 — 分数階の状態遷移を持つ state space model で長い系列をモデル化。構造の提案だが運転への接続は未提示
- 2609.35811: Lookahead-R: Budget-Aware Tool Retrieval via Execution-Centric Planning — P3 1.0 — LLM agent のツール検索。`world model` は周辺語
- 2609.36344: DeepRewind: Predicting and Repairing Premature Commitments in Deep Research Agents — P3 1.0 — deep research agent の早すぎる決めつけの修復。分野外
- 2609.36920: Benchmarking Automatic Speech Recognition Tools for Iberian Languages — P3 0.0 — イベリア諸語の音声認識のベンチマーク。`world model` の一致は誤検出
- 2609.38193: EHR2Trace: Auditable EHR Data Infrastructure for Patient World Models and Clinical Agents — P3 0.5 — 患者の world model のための医療データ基盤。分野外
- 2609.38285: GaugeVLM: Structuring Spatial Supervision with Measured Geometric Interventions — P2 2.5 — VLM の空間理解の監督を、測定した幾何の介入で構造化する
- 2609.37175: VLM Fine-Tuning for End-to-End Combinatorial Optimization — P2 2.5 — VLM を fine-tuning して組合せ最適化を end-to-end で解く
- 2609.38027: Layer-Informed Fine-Tuning via Three-Stage Functional Segmentation of LLMs — P2 2.5 — LLM の層を機能で 3 区分して、区分ごとに fine-tuning の扱いを変える。PEFT の層選択として参考程度
- 2609.39321: GRPO Training Dynamics for Small Language Models — P2 2.5 — 小さい LLM での GRPO (Group Relative Policy Optimization; PPO の簡略版で LLM の RL に使う) の学習の力学。蒸留ではない
- 2609.36590: SEED: Self-Speculative Decoding via Implicit Encoder-Decoder — P2 2.0 — LLM 自身を encoder-decoder とみなす self-speculative decoding で推論を速くする。圧縮ではなく推論の工夫
- 2609.36738: Backpropagated Output Momentum: Relocating Optimizer History from Parameters to Task Space — P2 2.0 — optimizer の momentum をパラメータ空間から出力空間に移す。fine-tuning 一般の最適化
- 2609.39441: CAST: Causal Advantage-Structured Training with Spatially Grounded Compositional Rewards for Diffusion Models — P2 2.0 — 拡散モデルの RL で、空間的に接地した報酬から因果的に advantage を構成する。画像生成
- 2609.37974: On Trajectory-Aware Training for Masked Diffusion Language Models — P2 1.5 — masked diffusion の言語モデルの学習を、生成の軌跡に合わせる
- 2609.39550: Hyperbolic Prototype Routing for Rehearsal-Free Class-Incremental Learning — P2 2.0 — rehearsal 無しの class-incremental learning を双曲空間の prototype routing で
- 2609.39600: GroundAnything: Reconciling Parallel Decoding with Precise Visual Grounding at Flash Speed — P2 1.5 — 並列 decoding と精密な visual grounding の両立。VLM の推論速度
- 2609.36691: Video2Skill: From Streaming Experience to Reusable Embodied Skills — P3 2.0 — ストリーミングの経験から再利用できる embodied スキルを抽出
- 2609.38632: Proper Scoring Rule-based Diffusion for Probabilistic Weather Forecasting — P2 1.0 — 確率的な気象予測の拡散モデル。分野外
- 2609.39190: Dynamics to decision: A mathematical theory of Lyapunov spectra and decision boundaries in deep classifiers — P2 1.0 — 深い分類器の Lyapunov スペクトルと決定境界の理論
- 2609.38395: Unified Optimality Conditions for Stochastic Optimal Control in the Rough Path and It\^o Frameworks — P2 0.5 — 確率最適制御の理論 (rough path)。分野外
- 2609.39296: Semantic-Aware Joint Source-Channel Optimization for Encoder-Agnostic Digital Video Communication — P2 0.5 — 映像通信の符号化。分野外

### keyword `fine-tuning` が一般語として一致しただけのもの (36 件・すべて P2 0.5〜1.5)

理由はすべて同じ: LLM の post-training / alignment / 評価 / 応用の論文で、keyword `fine-tuning` が一般語として一致しただけ。蒸留・他ドメイン適合の recipe ではない。

- 2609.35805: Alignment Forecasting: Predicting Misalignment From Training Data
- 2609.35810: TRACE: Deployable Tree-Relational Structure Enhancement for Oncology LLMs
- 2609.35816: PrimeSeeker: Capability-Oriented Supervision for Deep Search Agents
- 2609.36239: Cognitive Expert Language Models Better Align with the Corresponding Brain Systems
- 2609.36253: Population Fidelity: Evaluating Population Representativeness in LLMs
- 2609.36316: Training LLMs to Verbalize Evaluation Awareness
- 2609.36804: VAA-CSEC: Vote-guided Advantage Allocation for Chinese Semantic Error Correction
- 2609.36893: Momentum-Coupled Rubric Adaptation for Detailed Image Captioning
- 2609.36913: BaLEEN: Biasing with Latent Encoded Entities for Context-Aware ASR
- 2609.36914: Can Language Models Learn to Forecast Stock Prices
- 2609.36982: SRJudge: Empowering Large Language Models with Selective Reasoning for Fine-Grained Knowledge Concept Tagging
- 2609.36987: CypherTurn: A Multi-Turn Benchmark for Conversational Text-to-Cypher Evaluation and the Autonomy Divergence
- 2609.37040: Selecting The Most Informative Tokens in Natural Language Autoencoders
- 2609.37104: What Does Post-Training Change in Multilingual Reasoning?
- 2609.37491: Regime Boundary Alignment for Evidence-Gated Question Answering
- 2609.37543: RunyaNER: Auxiliary Language Selection for Runyankore NER
- 2609.37588: Rational Clarification by Assistive Agents via Value-of-Information Reasoning
- 2609.37590: FOCUS: Training-Free Decision-Preserving Context Compression for LLM Agents
- 2609.37624: Correct, Don't Delete: Mitigating Emergent Misalignment with Corrective Supervision
- 2609.37807: CompOrca: Corpus-Scale Compliance Labelling of Instruction-Tuning Data
- 2609.37914: The Unequal Influence of Bad Advice: Using Training Data Attribution to Modulate Emergent Misalignment
- 2609.38197: DualCast: A Dual-Path Language Model for Bimodal Financial Time-Series Forecasting
- 2609.38379: Aligned Data Can Induce Misalignment via Context Confusion
- 2609.38384: LeanPolish: Verified Supervision for Lean Proof Compression
- 2609.38428: MOBA-VL: Event-Localized Multi-Turn Reinforcement Learning for Real-Time MOBA Commentary
- 2609.38642: ChartRevise: A Dataset and Evaluation Protocol for Exact Chart Editing via Code
- 2609.38645: Alignment via Training Against Probes Without Losing Monitorability
- 2609.38680: ReGain: Restoring Subject Fidelity in Personalization on Synthetic Images
- 2609.38797: Evaluating Persistent Calibration under Evolving Model Knowledge
- 2609.39024: Persistent Watermarking of Text-to-Image Models
- 2609.39072: Beyond Text: LLM-Based Dimensional Emotion Evaluation in Multimodal Dialogue
- 2609.39371: EHR-RobustGym: Benchmarking and Training Agents for Robust Clinical Reasoning
- 2609.39378: EgoTools: Towards Tool-Centric Reasoning in Real-World Egocentric Videos
- 2609.39420: QuantCode Model: Specializing Language Models for Executable Algorithmic Trading Code
- 2609.39533: CATCH: A Controllable Analysis Testbed for Reward Hacking in Coding RL
- 2609.39566: From Given to Gathered Evidence: Agentic Learning for Longitudinal Medical Reasoning

## §5 欠陥の記録 (fetch)

- **今日のエラーは 0 件だが、max_results=30 の天井で fm の keyword 一致の約 3/4 (92 件中 72 件)、next の約半分 (51 件中 23 件) が落ちた。**採用の 2 本 (TrafficSignBench・Truck VLA) はこの落ちた分から来ている。エラー (backoff) と天井 (max_results) は別の欠陥で、**エラーが止まった日にも天井の分は毎日落ちる。**
- RSS は announce 1 回分をそのまま返すので、天井も announce 遅延も無い。09-25 の修正案 (取得元を RSS に替える) は、今日の天井の問題も同時に消す。
