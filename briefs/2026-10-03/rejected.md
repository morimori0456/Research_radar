# 2026-10-03 不採用: candidates.json の 61 件と、RSS で回収した本流の不採用 53 件

## §0 fetch 診断 (選別の前に実施)

- **今日も fetch のエラーは無かった** (2 日連続)。`~/research_loop.log` の最新の実行で 3 トピックとも正常に返った (planner_ai 4 / fm_distill 30 / next_arch 30。next の 1 件は fm と重複して 29 件)。
- **fm_distill と next_arch は、今日も max_results=30 の上限に当たっている** (3 日連続)。取得窓は 09-30T18:00Z から始まるが、返ってきた 30 件の投稿時刻の範囲は次のとおり:
  - fm_distill_finetune: 10-01 **10:31Z〜17:59Z (約 7.5 時間分)**
  - next_arch: 10-01 01:28Z〜17:59Z (約 16.5 時間分)
  - planner_ai: 4 件で、上限には届いていない
- **RSS (`rss.arxiv.org/rss/<cat>`、5 カテゴリ、Fri 02 Oct の announce 分) は 5 本とも 200 を返した。**new/cross の 947 件を topics.yaml の keyword で照合すると、planner_ai 4 件 (4 件とも candidates.json にある)、fm_distill 66 件 (candidates.json にあるのは 24 件)、next_arch 37 件 (同 24 件)。`briefs/` の既読 id と candidates.json を除いた**未読は、fm 42 件・next 13 件 (両方に一致した 1 件を 1 件と数えて 54 件)。**落ちた分は全部 09-30 の投稿 (`2610.00xxx`) で、上限で切れた窓の手前側に当たる。
- **照合の注意 (今日見つけた):** candidates.json の id には版番号が付いている (`2610.01959v1`) が、RSS と `briefs/` の id には付いていない。そのまま比べると重複が 0 件に見える (最初の照合では未読を 105 件と誤って数えた)。`id.split('v')[0]` で版番号を外してから比べること。fetch_candidates.py に dedup (欠陥#2) を入れるときも同じ注意が要る。
- **判断:** 10-01・10-02 と同じく、RSS で回収した分も candidates.json と同じ基準で採点した。**採用 6 本のうち 1 本 (DriftOPD `2610.00317`) が RSS 回収分。**
- wildcard の 3 件は 3 件とも、10-01・10-02 の rejected.md で採点済みの再配信 (欠陥#2 dedup。うち 2 件は 3 日連続)。新規の wildcard は 0 件。

## §1 判断の分岐点

1. **P1 は CLRE (4.5) で決まり。2 本目は TierCEM (`2610.01319`) を next_arch から planner_ai に再分類して使った。**candidates.json の planner_ai 4 件のうち、運転の論文は CLRE だけ (残りは経路探索・宇宙機・時系列予測)。TierCEM は運転の実験こそ無いが、「優先順位付きの制約で候補を選ぶ」という仕組みは、rulebook 型の planner の設計と評価にそのまま使える (3.5)。同じ CEM を扱う `2610.00921` (3.0) より、P1 への移しやすさで上。
2. **P2 は DriftOPD (RSS) と PAGER (4.0 同点の 2 本)。**表形式 FM の蒸留 recipe (`2610.01435`; 3.5) は「再現可能な recipe + コード」で P2 の高優先に当たるが、表形式から運転への移しやすさで 1 段下げた。DriftOPD は P3 にも 4.0 で当たるが、P3 は 4.0 が 3 本で混んでいるので、P2 側の枠で採った。
3. **P3 は 4.0 が 3 本 (Latent-Foresight / Criterion-aligned loss / UniWAM) で同点。**hf_upvotes は 3 本とも 0 で、タイブレークに使えない。**小さく試せるかで決めた:** Criterion-aligned loss は線形 head を 1 つ足すだけで、学習し直さなくても「診断」だけ先にできる。Latent-Foresight はコードと重みが公開されている。UniWAM は人の一人称視点データとロボットデータを大規模に使う構成で、手元では再現できない。スケール則の知見は DIGEST に要点だけ記す。
4. **探索枠 (sns_wildcard) は空けた。**新規の wildcard が 0 件 (3 件とも再配信)。

採用: P1 2/2 ・ P2 2/2 ・ P3 2/2 ・ wildcard 0/1 = **6/6**。

## §2 次点 (3.5〜4.0。quota で落としたもので、質が低いわけではない)

- 2610.02054: UniWAM: Unified World-Action Model — P3 4.0 [candidates] — 物理推論器・world 生成器・行動予測器を統合した world-action model。行動を自然言語で表し、VQA・人の一人称視点データ・ロボットデータを部品ごとに割り当てて事前学習する。**人とロボットのデータの co-training で log-linear のスケール則**。P3 の同点 3 本目。大規模な構成で手元では再現できないので外した
- 2610.00864: Kinematic MeanFlow: One-Step Action Generation Policy for Robotic Foundation Models — P3 3.5 / P2 3.0 [RSS] — MeanFlow (flow matching を 1 ステップ生成にする手法) をロボット基盤モデルにそのまま使うと崩れる。原因を速度場の 2 つの性質 (終盤の加速度の急増・サンプル間のばらつきの拡大) に特定し、時間の区間を 2 つに分けて直した。**GR00T-N1.6 の action head の遅延を Jetson Orin で 67.5〜74.4% 削減**。DriftOPD と並べて読むと 1 ステップ化の比較になる
- 2610.01435: Distillation of Tabular Foundation Models into Efficient Predictors — P2 3.5 [candidates] — 表形式の FM (in-context learning で予測する基盤モデル) を軽量 student に蒸留する recipe。teacher の文脈は学習データ全体にし、student は teacher の予測だけで学習し、合成した query で入力の被覆を広げる。教師ありで調整した student より Elo +57〜98、推論は 3〜21.6 倍速い。コードあり。「どの入力で蒸留するか (query の被覆)」の論点は P2 に移せる
- 2610.02123: Harnessing Domain Specialists in Multimodal Mixture-of-Experts for Efficient Adaptation — P2 3.5 [candidates] — ExpertLens: MoE の router の重みから、データ無しでドメイン専門の expert を見つけ、その expert だけ fine-tuning。全体の fine-tuning と同等以上で、更新は 21.7〜47.0% のパラメータ、学習は 4 倍速く、LoRA より強い
- 2610.01974: Sim+Real: Joint Simulation - Experiment Training Improves Balanced Prediction in Physical Systems — P2 3.5 [candidates] — sim で事前学習 → 実測で fine-tuning すると、sim 側の性能を忘れる。両方を同時に学習した方がバランス良く強い。流体の PDE での検証だが、運転の sim-to-real の適合の指針として使える
- 2610.00926: A Survey on End-to-End Autonomous Driving Training from the Perspectives of Data, Strategy, and Platform — P3 3.5 [candidates] — E2E 自動運転の学習を Data / Strategy / Platform の 3 層で整理した survey。新しい知見は無いが、文献 repo が継続更新される。P3 の文献の地図として 1 回は目を通す価値あり
- 2610.00368: DeepJEPA: Scaling World Models from Within — P3 3.5 [RSS] — world model の遷移ごとに計算の深さを変え、判断に効く遷移 (接触の瞬間など) でだけ深く計算する。平均 1.00〜1.26 回の更新で、固定の深さの最良と同等以上
- 2610.00722: JEPA-TTT: Persistent Test-Time Training of Latent World Models for Planning under Dynamics Shifts — P3 3.5 [RSS] — 動力学が変わった環境で、world model の予測器だけを自己教師で更新し続ける。500 エピソード後に予測誤差 -83%・planning +153%。P2 の「別の車種・別の路面への適合」の world model 版
- 2610.02162: World Observer: Joint Actor-Observer Generation for Persistent World Modeling — P3 3.5 [candidates] (hf 45、今日の本流の最多) — 視野外に出た物体の状態を保つため、行動者の視点と俯瞰の observer の視点を同時に生成する。運転の遮蔽 (前の車に隠れた歩行者など) と同じ問題だが、重い video 生成の構成
- 2610.01172: Learning Rate Transfer for Hybrid Transformer-SSM Architectures — P3 3.5 [candidates] — Transformer と SSM の hybrid でも、μP の規則だけで最適な学習率が幅 8 倍まで変わらない。理論の条件からは外れるのに効く理由を、2 つの条件に分けて説明。LM が対象
- 2610.01741 ATI-VLA / 2610.01559 CAG / 2610.00575 Token-World — P3 3.5 — いずれも manipulation の VLA・world action model の改良。理由は §3 に記載

## §3 candidates.json の不採用 (61 件)

### planner_ai (3)

- 2610.01959: Training-Free Diffusion Planning with Analytical Local Scores — P1 3.0 — 学習データ無しで diffusion planner (軌跡をノイズから段階的に生成する planner) を動かす手法。対象は経路探索とマルチロボットで、運転の場面・評価が無い [candidates]
- 2610.01093: OrbitTAMP: Grounding Language Models for Task and Motion Planning in Spacecraft Rendezvous — P1 1.0 — 宇宙機のランデブーの TAMP (Task and Motion Planning; 作業手順と動作計画の同時計画) に LLM を接地。分野が遠い [candidates]
- 2610.00976: Variational Streaming Flow: Probabilistic Forecasting in Physical Time — P1 2.5 / P3 3.0 — 確率的な時系列予測を flow matching で物理時間のまま行う (VSF)。JEPA 型の world model の予測器に差し替えられるが、評価は力学系と簡単なナビで運転の軌跡予測は無い [candidates]

### fm_distill_finetune (29)

- 2610.02206: KaliBench: A Fine-Grained Benchmark for Cybersecurity Tool Use on Kali Linux with Runtime-Free Verifiable Rewards — P2 1.0 — サイバーセキュリティのツール呼び出しのベンチマーク。蒸留・適合と無関係 [candidates]
- 2610.02199: TACO: Ternary Absolute-max Column-wise One-sparse Optimizer for LLM Fine-Tuning — P2 3.0 — TACO: LLM の全パラメータ fine-tuning の optimizer state のメモリ削減。適合の効率化だが、P2 の対象 (蒸留・ドメイン適合の recipe) からは一段遠い [candidates]
- 2610.02189: Generative modeling of intrinsically disordered protein regions by reinforcing sparse autoencoder features — P2 0.5 — 天然変性タンパク質の生成モデル。分野外 [candidates]
- 2610.02186: Higher-Order Molecular Grammars for Generative and Foundation Models in Chemistry — P2 0.5 — 分子の高次文法表現。分野外 [candidates]
- 2610.02163: AutoCompact: Learning When to Compact Context in Long-Horizon Coding Agents — P2 1.5 — coding agent がいつ文脈を圧縮するかを学習。agent の話で P2 と無関係 [candidates]
- 2610.02123: Harnessing Domain Specialists in Multimodal Mixture-of-Experts for Efficient Adaptation — P2 3.5 — ExpertLens: multimodal MoE (Mixture-of-Experts; token ごとに一部の expert だけを使う構造) の router 重みからドメイン専門の expert をデータ無しで見つけ、その expert だけ fine-tuning。LoRA より速く強い。**次点** (§2) [candidates]
- 2610.02076: LLM2Jev: LLMs Are Already Jev-Style Decision Models -- When and How to Fine-Tune Them — P2 2.0 — LLM を選択肢の確率分布を出す判定器として使う recipe。適合の話だが LLM の出力形式に特化 [candidates]
- 2610.02058: Foundations without Fundamentals: Zero-Shot Blind Spots in Time Series FMs — P2 2.0 — 時系列 FM の zero-shot の盲点を単純な unit test で暴く診断。fine-tuning で直る範囲の議論はあるが P2 の主題から外れる [candidates]
- 2610.02015: On Language Drift during RLVR Post-Training — P2 2.0 — RLVR 後の CoT の言語ドリフトの原因分析。LLM 推論に特化 [candidates]
- 2610.02000: Weather-Aware Domain Adaptation for Street-View Weather Recognition — P2 3.0 — 天気認識の domain adaptation (WA-ADDA; 天気の予測で条件付けた敵対的 DA)。運転のカメラ画像が対象だが、天気の分類だけで planner や基盤モデルの適合には距離がある。ADDA 自体は 2017 年の手法 [candidates]
- 2610.01974: Sim+Real: Joint Simulation - Experiment Training Improves Balanced Prediction in Physical Systems — P2 3.5 — Sim→Real の fine-tuning は simulation 側の性能を忘れる。sim と実測の同時学習の方が両方で良い。流体の PDE で検証。**sim-to-real の適合の指針として次点** (§2) [candidates]
- 2610.01963: Counterfactual Auditing of Bias in Open-Source Large Language Models for Clinical Triage — P2 1.0 — 臨床トリアージでの LLM の偏りの監査。分野外 [candidates]
- 2610.01917: MoLE: Mixture of Latent Experts for Complementary Visual Reasoning — P2 1.5 — VLM の latent な視覚推論で latent token 同士を補完的にする。蒸留・適合と無関係 [candidates]
- 2610.01892: Selection-Based Structured Reasoning: Toward Efficient Multimodal Search Agents — P2 1.5 — 小型の multimodal 検索 agent の推論を「選択」に置き換える。P2 と無関係 [candidates]
- 2610.01890: Unsupervised Domain Adaptation for Enhanced Radiometer Image Precipitation Estimation using Conditional Flow Matching — P2 2.0 — 衛星の放射計画像の教師なし domain adaptation を conditional flow matching で行う。ドメインが遠い [candidates]
- 2610.01835: Varda-single-1.0: deterministic data-driven weather forecasting at 1 km resolution over Switzerland's complex topography — P2 1.5 — スイスの 1km 解像度の気象予測システム。事前学習 → 地域 fine-tuning の構成だが分野外 [candidates]
- 2610.01729: Function-Structured Reinforcement Learning with Executable Verifiers for Mathematical Reasoning — P2 1.5 — 数学推論の RL (GRPO) を関数グラフ + 実行可能な検証器で。LLM 推論に特化 [candidates]
- 2610.01728: Removing spurious minima for planar features by skip connections — P2 1.5 — teacher-student 設定の浅い ReLU ネットの loss landscape 理論。keyword `teacher student` は理論の設定名で、蒸留とは無関係 [candidates]
- 2610.01710: CoEvolve: Construct-to-Edit Visual Grounding with Bidirectional State Refinement — P2 1.0 — visual grounding の段階的な box 修正。無関係 [candidates]
- 2610.01702: Task-Oriented Rank Adaptation for Continual Learning in Text Classification — P2 2.5 — TORA: LoRA の低ランク構造を使って、継続学習で過去タスクの adapter を再利用するか決める。テキスト分類のみ [candidates]
- 2610.01674: Invent a Dataset: Measuring dataset generation abilities with zero seed — P2 2.0 — zero-data からの学習データ生成の評価。データ合成の話で P2 から遠い [candidates]
- 2610.01649: CrossGMN: Graph Metanetworks for Cross-Architecture Weight-Space Transformations — P2 3.0 — CrossGMN: 異なる構造の network 間で重みを変換する weight-space network。圧縮 (大→小の構造変換) を含むが、小規模の MLP/CNN での検証 [candidates]
- 2610.01634: Yo-ByT5: Efficient and High-Fidelity Diacritic Restoration for Yorùbá — P2 1.0 — ヨルバ語の発音記号の復元。分野外 [candidates]
- 2610.01625: Beyond Domain-Level Adaptation: Margin-Oriented Semantic-Appearance Interaction Correction for Personalized Federated Vision-Language Models — P2 2.0 — federated (データを共有せず各クライアントで学習) な VLM の PEFT で、クラスごとのドメインずれを補正。federated の設定が P2 に無い [candidates]
- 2610.01537: FedFit: Federated Fine-Tuning of LLMs via Vector-Bank Parameterization and Quantization — P2 2.0 — federated な LoRA の通信量削減。P2 に federated の設定が無い [candidates]
- 2610.01522: Langevin-Informed Transfer Learning: Replacing Target Samples by Black-Box Feedback — P2 1.5 — Langevin 動力学の転移学習。分野外 [candidates]
- 2610.01493: No Model Required: Text Entropy Rate Filtering Mitigates Iterative Fine-Tuning Collapse — P2 2.0 — 合成データでの反復 fine-tuning の model collapse を、テキストのエントロピー率で filter して防ぐ。LLM の合成データに特化 [candidates]
- 2610.01453: Repurposing Obsolete Representations for Post-Deployment Adaptation — P2 2.5 — Deep Repurposing: 不要になった出力クラスの表現を、fine-tuning 無しで別用途に振り直す。展開後の適合の話だが、分類器の小さな設定のみ [candidates]
- 2610.01435: Distillation of Tabular Foundation Models into Efficient Predictors — P2 3.5 — 表形式データの基盤モデル (TabPFN 型) を軽量 student に蒸留する recipe。teacher の文脈は学習データ全体、student は teacher の予測だけで学習、合成 query で被覆を広げる。コードあり。**再現可能な recipe として次点** (§2) [candidates]

### next_arch (26)

- 2610.02205: ROWBench: Do Video Models Render What the Program Specifies? — P3 3.0 — PROWBench: プログラムで動く world model の映像が、プログラムで指定した事象どおりかを評価するベンチマーク。ゲームエンジン向けで運転と距離がある (hf 32) [candidates]
- 2610.02162: World Observer: Joint Actor-Observer Generation for Persistent World Modeling — P3 3.5 — World Observer: 視野外に出た物体の状態を保つため、行動者視点と俯瞰の observer 視点を同時に生成する video world model。運転の遮蔽にも通じるが重い video 生成 (hf 45)。**次点** (§2) [candidates]
- 2610.02161: DuoMind: Enabling Distributed Multi-Robot Coordination with Semantic Communication — P3 2.5 — 複数ロボットの協調を VLA + VLM orchestrator の意味通信で。単一車両の運転には距離 [candidates]
- 2610.02160: 4Director: Controlling Video World Models with Rigid 3D Geometry — P3 2.5 — 4Director: 剛体 3D 幾何で video world model の物体運動を制御。映像制作向け (hf 14) [candidates]
- 2610.02054: UniWAM: Unified World-Action Model — P3 4.0 — UniWAM: 物理推論器・world 生成器・行動予測器を統合した world-action model。人の一人称視点データとロボットデータの co-training に log-linear のスケール則。**P3 の 3 本目で同点**。大規模構成で再現が難しく、今日は小さく試せる 2 本を優先した (§1) [candidates]
- 2610.01939: Fewer Tokens, Better Action: GPT-6 Astra Robot Agents with 14% Higher Success Rate but 65% Fewer Tokens — P3 2.0 — VLM agent がロボットを Python で制御する際の token 削減 (hf 15)。VLA の構造・学習とは別の話 [candidates]
- 2610.01856: ChunkVLA-AM: Parallel Action Chunking for Vision-Language-Action Robot Control in Additive Manufacturing — P3 2.0 — OpenVLA-OFT を積層造形のロボットに展開する事例。新規性は展開手順 [candidates]
- 2610.01794: Continuous Conditioning of VLAs with Augmenting EMG and Visual Task Descriptors — P3 2.0 — VLA に筋電信号などの連続値で条件付け。運転と無関係 [candidates]
- 2610.01786: Inferring Multi-Timescale Neural Dynamics with Switching Linear Dynamical Systems — P3 1.0 — 神経活動の多時間スケールの状態空間モデル。keyword `state space model` は統計モデルの意味で無関係 [candidates]
- 2610.01741: ATI-VLA: Action-Centric Predictive Vision-Language-Action Models via Actionable Alignment Then Adaptive Injection — P3 3.5 — ATI-VLA: 未来予測を持つ VLA が直接行動予測に負ける原因を、観測と行動の不整合と目的の衝突に求め、行動中心の整列 → 段階的注入で直す。manipulation のみ。次点 [candidates]
- 2610.01614: Oneira: From Open-Ended Generation to Open-World Interaction in Video World Models — P3 2.5 — Oneira: 生成された世界の新しい物体を操作可能にする video world model。ゲーム寄り [candidates]
- 2610.01559: Completion Aware Guidance for World Action Models — P3 3.5 — CAG: world action model が「もっともらしいがタスクを完了しない未来」を想像する問題を、学習不要の sampling 誘導で直す。manipulation のみ。次点 [candidates]
- 2610.01531: Towards Reliable Vision-Language Models for Autonomous Driving — P3 3.0 / P1 3.0 — 運転 VLM 5 種 (Alpamayo-1.5 を含む) の画像劣化に対する精度と確信度の信頼性を評価。結論は「モデル・データ・条件で効果が違う」で一貫した知見が無い [candidates]
- 2610.01373: Learning Commute-Time-Preserving World Models for Planning — P3 3.0 — commute time (グラフ上の往復の期待時間) を保つ latent を自己教師で学習し、latent の距離で planning。理論寄りで運転への道筋が遠い [candidates]
- 2610.01351: Is Success All You Need? Investigating the Impact of Input Perturbations on VLA Behaviour in Tabletop Manipulation Tasks — P3 2.5 — VLA の頑健性を成功率でなく「成功した軌跡の実行の仕方」で測る評価。LIBERO の manipulation のみ。考え方は P1 の評価にも通じる [candidates]
- 2610.01201: iSEE: Object Permanence Through Self-Supervision — P3 2.5 — iSEE: slot attention で遮蔽中の物体の永続性を自己教師で学習。運転の遮蔽に通じるが、video 表現学習の基礎研究 [candidates]
- 2610.01172: Learning Rate Transfer for Hybrid Transformer-SSM Architectures — P3 3.5 — Transformer と SSM (State Space Model; Mamba 系の系列モデル) の hybrid で μP (幅を変えても最適な学習率が変わらないようにする初期化・学習率の規則) がそのまま効く。スケール則の実務知見だが LM が対象。次点 [candidates]
- 2610.01162: PhysicsLENS: Diagnosing Physical Property Blindness in Video Generation Models — P3 2.5 — PhysicsLENS: 重さ・粘性など見えない物性に対する video 生成モデルの盲点を測るベンチマーク [candidates]
- 2610.01092: Ego2Act: Evaluating Goal-Directed Manipulation in Egocentric Video Generation — P3 2.5 — 一人称視点の video 生成で、目的達成までの複数ステップの操作を評価するベンチマーク [candidates]
- 2610.01083: WBAG: A Whole-Body and Attached-Geometry Safety Framework for Vision-Language-Action Manipulation — P3 2.0 — VLA の全身 + 把持物体の衝突を見る安全層。manipulation 特有 [candidates]
- 2610.01019: FutureWorlds: Learning Robotic World Models from Alternative Futures — P3 3.0 — FutureWorlds: 複数の代替未来を beam search で作り、相対的な良さで world model を RL 学習 [candidates]
- 2610.00982: Divide-and-Remember: Recursive Action-Relevant Memory for Long-Horizon VLA Policies — P3 3.0 — VLA の記憶を、行動と記憶の条件付き相互情報量の最大化として設計。manipulation のみ。10-02 の AD-Memo (運転 VLA の言語記憶) の方が P3 に近い [candidates]
- 2610.00926: A Survey on End-to-End Autonomous Driving Training from the Perspectives of Data, Strategy, and Platform — P3 3.5 — E2E 自動運転の学習を Data / Strategy / Platform の 3 層で整理した survey と文献 repo。新しい知見は無いが、P3 の文献地図として有用。次点 (§2) [candidates]
- 2610.00921: In CEM, a World Model Is Also a Proposal Mechanism — P3 3.0 / P1 3.0 — CEM では world model が「採点」と「次の候補の提案」の 2 役を兼ねることを分けて評価。Walker/Cheetah のみ。TierCEM と同じく CEM の採点を扱うが、運転への示唆が間接的 [candidates]
- 2610.00913: eRLT: Efficient VLA Reinforcement Learning via Action-Relevant Token Routing — P3 3.0 — eRLT: 凍結 VLA の online RL で、行動に関係する token を選んで actor/critic の状態にする [candidates]
- 2610.00899: TOAST: Stochastic Robot Action Tokenization for Autoregressive Vision-Language-Action Models — P3 3.0 — TOAST: VLA の行動 token 化 (FAST) を確率的にして少データでの学習効率を上げる [candidates]

### sns_wildcard (3)

- 2609.33439: Raven: The Harness of Harnesses for Composable Agentic Intelligence — wildcard 再配信 — 10-01・10-02 の rejected.md で採点済み (欠陥#2 dedup。3 日連続) (hf 509) [candidates]
- 2609.34309: MaLiang-Harness: A Programmable Path to Image and Video Generation — wildcard 再配信 — 10-02 の rejected.md で採点済み (欠陥#2 dedup) (hf 395) [candidates]
- 2609.36012: In-Context Learning for Robots: Methods and Applications — wildcard 再配信 — 10-01・10-02 の rejected.md で採点済み (欠陥#2 dedup。3 日連続) (hf 366) [candidates]

## §4 RSS 回収分の不採用 (53 件。candidates.json に無く、max_results=30 の上限で落ちていた分)

- 2610.00524: Same Scene, Different Task: Skill Alignment for Compositional Generalization in VLAs — P3 3.0 — VLA が、fine-tuning で見ていない skill の組み合わせに汎化しない原因を「視覚の shortcut」とし、skill の整列で直す ・ kw=fine-tuning [RSS]
- 2610.00864: Kinematic MeanFlow: One-Step Action Generation Policy for Robotic Foundation Models — P3 3.5 / P2 3.0 — Kinematic MeanFlow: ロボット基盤モデルの action head を 1 ステップ生成にする。GR00T-N1.6 の action head の遅延を L40 と **Jetson Orin** で 67.5〜74.4% 削減。DriftOPD と同じ「1 ステップ化」で、車載の遅延の数字が具体的。**次点** (§2) ・ kw=fine-tuning [RSS]
- 2610.00685: Backdoor Purification for LoRA-Tuned LLMs via Null-Space Projection — P2 1.5 — LoRA で fine-tuning した LLM の backdoor 除去。安全性の話 ・ kw=fine-tuning [RSS]
- 2610.00087: Legal text classification in Korean sexual offense cases: from traditional machine learning to large language models with XAI insights — P2 1.0 — 韓国の法律文書の分類。分野外 ・ kw=fine-tuning,domain adaptation [RSS]
- 2610.00309: Tokenized Key-Gated Adapter Routing: A Secure Access Control Mechanism Against Private Data Leakage in LLMs — P2 1.0 — LLM の個人情報漏えいを adapter の鍵で防ぐ。分野外 ・ kw=fine-tuning [RSS]
- 2610.00571: Interpreting Reasoning of Large Language Models via Partial Information Decomposition — P2 1.0 — LLM 推論過程の情報理論的解釈。無関係 ・ kw=fine-tuning [RSS]
- 2610.00717: Sequential Functional Structured Tucker Compression for Large Language Model Attentions — P2 3.0 — LLM の attention を、前段の圧縮で生じた表現のずれを考慮しながら Tucker 分解で逐次圧縮。圧縮の recipe だが LLM の attention に特化 ・ kw=fine-tuning [RSS]
- 2610.00767: Pre-training interventions, ex post facto: Grafting model beliefs across checkpoints — P2 1.5 — 事前学習中の介入を checkpoint 間で移植する。alignment 研究 ・ kw=fine-tuning [RSS]
- 2610.00812: Video Generation Models: A Survey of Post-Training and Alignment — P2 2.0 — video 生成モデルの post-training と alignment の survey ・ kw=fine-tuning [RSS]
- 2610.00814: Training-Aware Target Coverage for Synthetic Data Selection — P2 2.0 — 合成データの選択の線形理論。LLM の学習データ ・ kw=fine-tuning [RSS]
- 2610.00997: Distilling Directional Verification — P2 3.0 — teacher が一方向でしか思い出せない事実を、知っている方向で採点して正解ラベルを作る蒸留。LLM の事実知識に特化 ・ kw=knowledge distillation [RSS]
- 2610.01143: Parameter-Efficient Distributionally Robust Adaptation of Tabular Foundation Models under Subpopulation Shift — P2 3.0 — 表形式 FM を部分集団のずれに対して頑健に PEFT で適合。表形式に特化 ・ kw=fine-tuning [RSS]
- 2610.01166: CineMR: Tool-Integrated Vision-Language Reasoning for Quantitative Cardiac MRI Assessment — P2 0.5 — 心臓 MRI の定量評価の VLM。分野外 ・ kw=fine-tuning [RSS]
- 2610.00436: Every Batch Is Its Own Validation Set: Leave-One-Out Gradient Matching for Online Data Selection in LLM Fine-Tuning — P2 2.5 — LLM fine-tuning の online のデータ選択で、各例を自分の評価目標から外す (leave-one-out) と gradient matching が効く ・ kw=fine-tuning [RSS]
- 2610.00580: From Task Mixtures to Specialized Experts — P2 2.0 — federated fine-tuning で、クライアント内の潜在タスク混合を分けて専門 expert にする ・ kw=fine-tuning [RSS]
- 2610.00665: Analysis of Quantized and Efficiently Adapted Protein Language Models — P2 2.0 — タンパク質言語モデルの 4bit 量子化と LoRA の影響の分析。分野外 ・ kw=fine-tuning,parameter efficient fine-tuning [RSS]
- 2610.00730: Reformulation-Contrastive Learning for Mixed Integer Programs — P2 1.0 — 混合整数計画の対照学習。無関係 ・ kw=fine-tuning [RSS]
- 2610.00771: Localizing Transfer Between Memorization Tasks — P2 2.0 — 記憶タスク間の転移の起きる場所を特定する分析。基礎研究 ・ kw=fine-tuning,transfer learning [RSS]
- 2610.00835: TrueMuse: A Benchmark for Data Attribution in Text-to-Music Models — P2 0.5 — 音楽生成のデータ帰属のベンチマーク。分野外 ・ kw=fine-tuning [RSS]
- 2610.00895: Towards Fast and Disentangled Counterfactuals for Visual Foundation Models — P2 2.0 — 視覚 FM の反事実説明 (DiDAE)。説明可能性 ・ kw=knowledge distillation,fine-tuning [RSS]
- 2610.01076: GLoC-EHR: Evidence-Cited Clinical Reasoning over Global Context and Local EHR Events — P2 0.5 — 電子カルテの臨床推論。分野外 ・ kw=fine-tuning [RSS]
- 2610.00026: High-Value Synthetic Supervision for Parameter-Efficient Adaptation of a Compact Japanese Speech Model — P2 2.5 — 日本語の介護引き継ぎ音声を、182 本の合成音声で 1.47B 音声モデルに LoRA 適合。少データ適合の事例だが音声 ・ kw=fine-tuning [RSS]
- 2610.00191: Improving scoring functions for protein-protein docking with LambdaLoss — P2 0.5 — タンパク質ドッキングの scoring。分野外 ・ kw=fine-tuning [RSS]
- 2610.00320: Refusal Localizes, the Damage Relocates: Safety Layers Under Few-Sample Fine-Tuning — P2 1.5 — 少数の有害データでの fine-tuning による安全層の破壊。安全性 ・ kw=fine-tuning [RSS]
- 2610.00431: ChainLoRA: Geometry-Preserving Task Vector Merging for Continual Learning in LLMs — P2 2.5 — ChainLoRA: replay 無しで LoRA の task vector を幾何を保って合成する継続学習。LLM のみ ・ kw=fine-tuning [RSS]
- 2610.00724: Reason in Style: Discovering and Controlling Style in Language Models — P2 1.0 — LM の出力の style の発見と制御 ・ kw=fine-tuning [RSS]
- 2610.00045: SCM-based Fairness and Faithful Explainability for Legal Document Classification — P2 0.5 — 法律文書分類の公平性。分野外 ・ kw=fine-tuning [RSS]
- 2610.00408: UniBuc at SemEval-2024 Task 2: Tailored Prompting with Solar for Clinical NLI — P2 0.5 — SemEval 2024 の臨床 NLI の prompt 工夫。fine-tuning 無し ・ kw=fine-tuning [RSS]
- 2610.00679: Bayesian Fine-tuning Yields Language Models that are as Bayesian as their Beliefs Allow — P2 1.5 — Bayesian モデルの出力で LM を fine-tuning すると Bayesian らしく振る舞う。LM の推論 ・ kw=fine-tuning [RSS]
- 2610.00689: Towards Robust Numerical Claim Verification — P2 1.5 — 数値の主張検証の敵対的 fine-tuning ・ kw=fine-tuning [RSS]
- 2610.00928: Efficient Task Adaptation in Large Language Models: A Survey of Weight-Based, Prompt-Based, and Embedding-Based Adaptations — P2 2.5 — LLM の効率的タスク適合の survey (重み / prompt / embedding) ・ kw=fine-tuning [RSS]
- 2610.01066: Probe with Participation Trophies: Random-Reward RL as a Probe of LLM Capability — P2 1.0 — random reward の RL を LLM の probe として使う ・ kw=fine-tuning [RSS]
- 2610.00196: GPEC: Efficient Pre-LLM Gaussian Process Embedding Correction for Cardiac Video Caption Generation — P2 0.5 — 心エコー動画の caption 生成。分野外 ・ kw=fine-tuning [RSS]
- 2610.00414: From Image Latent Space to Fuzzy Rules: Interpretable Analysis of Gastrointestinal Foundation Model — P2 0.5 — 消化器内視鏡 FM の解釈。分野外 ・ kw=fine-tuning [RSS]
- 2610.00973: Concept Driven Domain Adaptation: Finding an Abstract Needle in a Haystack — P2 1.0 — 抽象概念での動画 moment 検索の domain adaptation。分野外 ・ kw=domain adaptation [RSS]
- 2610.00994: VIEScore2: Unified Image Evaluation with Spatially Grounded Explanations — P2 1.0 — 画像生成の評価器。無関係 ・ kw=fine-tuning [RSS]
- 2610.01039: Bootstrapping Video Interaction Generation with Synthetic State Transitions — P2 / P3 2.0 — 合成の状態遷移で video の相互作用生成を学習 ・ kw=fine-tuning [RSS]
- 2610.01098: MVDG: Efficient Multi-view 3D Disambiguation on Unconstrained Real-World Images — P2 1.0 — 3D 再構成の見分けにくい面の判別。無関係 ・ kw=fine-tuning [RSS]
- 2610.01215: AutoGUIWorld: Image Generators as Visual World Models for GUI Agent — P3 2.0 — GUI agent 用に画像生成器を world model として使う ・ kw=fine-tuning [RSS]
- 2610.01229: A Compact Explicit 4D Representation for Dynamic Scenes — P2 1.5 — 動的シーンの疎な 4D 表現 autoencoder ・ kw=fine-tuning [RSS]
- 2610.01286: Dyna3: VLM-Guided Training-Free 4D Reconstruction via Depth Foundation Models — P2 2.0 — 深度 FM (Depth Anything 3) で学習不要の 4D 再構成 ・ kw=fine-tuning [RSS]
- 2610.01291: ODDR: One-Step Deshadow Diffusion via Reward Guidance — P2 1.0 — 影の除去の 1 ステップ拡散 ・ kw=fine-tuning [RSS]
- 2610.00368: DeepJEPA: Scaling World Models from Within — P3 3.5 — DeepJEPA: world model の遷移ごとに計算の深さを変え、接触の瞬間など判断に効く遷移でだけ深く考える。test-time scaling (推論時に計算を増やして性能を上げること) の新しい軸。次点 ・ kw=world model [RSS]
- 2610.00575: Token-World: World Modeling in Vision-Language Model Token Space for Robot Manipulation — P3 3.5 — Token-World: VLM の視覚 token 空間で world model を作り、画素を予測して encode し直す手間を省く。次点 ・ kw=VLA,world model [RSS]
- 2610.00601: When Reasoning Helps Action: Monitoring and Steering Chain-of-Thought in Vision-Language-Action Policies — P3 3.0 — 推論付き VLA の CoT を監視・修正して行動を直せるかの評価 ・ kw=VLA [RSS]
- 2610.00727: CF-JEPA: Improving Robustness of JEPA World Models via Controllability Factorization — P3 3.0 — CF-JEPA: 制御できる要素とできない要素を分けて、JEPA world model の背景ノイズへの弱さと collapse を防ぐ ・ kw=world model [RSS]
- 2610.00801: ECoMEM: Explicit Concept Memory for Memory-Dependent Robot Control — P3 3.0 — ECoMEM: VLA の記憶を明示的な概念として保持 ・ kw=VLA [RSS]
- 2610.00604: MIKASA-Robo-VLA: Benchmarking Memory in VLA Models for Long-Horizon Manipulation — P3 3.0 — VLA の記憶を測る 90 タスクのベンチマーク ・ kw=VLA [RSS]
- 2610.00280: Stable and Counterfactually Robust Physical World Models from Imposed Structure and Learned Physics — P3 2.5 — 物理法則の構造をどこまで入れれば world model の長期予測が安定するか ・ kw=world model [RSS]
- 2610.00329: Beyond Diagonal State Space Models: Exact Non-Abelian Group Tracking, Solvability Barriers, and Geometric Physical Manifolds — P3 2.0 — 対角でない SSM の表現力の理論 ・ kw=state space model [RSS]
- 2610.00722: JEPA-TTT: Persistent Test-Time Training of Latent World Models for Planning under Dynamics Shifts — P3 3.5 — JEPA-TTT: 動力学が変わったとき、world model の予測器だけを test-time training で更新し続ける。P2 の「別ドメインへの適合」にも通じる。次点 ・ kw=world model [RSS]
- 2610.00686: SemanTok: Predictable Semantic Tokens for Efficient Autoregressive Video Generation — P3 2.5 — video world model 用の予測しやすい意味 token の tokenizer ・ kw=world model [RSS]
- 2610.00544: Memorizon: Training World Models Beyond Their Context Window — P3 3.0 — Memorizon: 長い時間幅の再訪の一貫性を、文脈窓を超えて学習する video world model ・ kw=world model [RSS]
