# 落選候補 — 2026-08-15

候補 **44 件**、採用 **6 件** (max_deep_per_day 6 の上限ぴったり)、**落選 38 件**。

内訳: planner_ai 3 件中 **1 採用** / fm_distill_finetune 21 件中 **1 採用** / next_arch 17 件中 **3 採用** / sns_wildcard 3 件中 **1 採用**。

> **quota の数え方について、本日 1 件だけ明示的な付け替えをした。** **2608.13395 (FIRE-VLA)** は fetch が keyword 一致で next_arch に入れているが、**実質的な貢献は蒸留の recipe** (凍結した自分のコピーを teacher にし、失敗した group にだけ適用する) なので **P2 / fm_distill_finetune の quota で数えた。** したがって quota 消費は **planner_ai 1 / fm_distill 2 (PseudoMapLabeler + FIRE-VLA) / next_arch 2 (BrainWAM + Objective-Bottleneck) / wildcard 1 = 6** で、**どのトピックも上限を超えていない。** 付け替えなしだと next_arch が 3 で上限違反になるため、この判断は結論を変えている。**気に入らなければ次点の 2608.12764 (SSPO) と差し替えれば整合する。**

---

## 取得側の健全性 — wildcard は自然に回復、planner_ai は原因が確定した

**本枠 (arXiv 3 トピック) は 4 日連続で健全。** 41 件が入り、**id 重複・題名重複ともにゼロ。** published は 08-12〜08-13 で lookback_days=2 の窓の内側。

**wildcard 枠は 4 日ぶりに完全に入れ替わった。3 件とも新規** —— 過去の briefs/ にも rejected.md にも存在しない (2608.11924 / 2608.00677 / 2608.10915)。**ただしこれは修正が入ったからではない。** dedup は依然として未実装で、**HF のトレンド上位が自然に回転しただけ**である。**3 日連続で同じ 3 件を返した状態が、たまたま解消した。** [[fetch-duplicate-candidates]] の「wildcard の dedup 欠如」は **未修正のまま残っている** と記録しておく。次に HF が停滞すれば同じことが起きる。

**取得上限 30 件による静かな切り捨ても継続中。** fm_distill_finetune と next_arch はいずれも `max_results=30` に張り付いており (30 件取得 → cutoff と重複除去の後に 21 / 17)、**上限の外に何が落ちているかは観測できない。**

### planner_ai の枯渇 —— dedup のせいではなく、キーワードが古い

**候補数は 4 → 4 → 2 → 3 と痩せ続けている。しかも本日の 3 件中 2 件はキーワードの誤検出だった** (電力変圧器の熱モデル / range-bearing relay の自己校正)。**実質 1 件で、quota 2 に対して選ぶ余地が無いどころか、埋まっていない。**

**本日、原因が確定した。dedup の被害者ではない。** `fetch_candidates.py` はトピックを topics.yaml の順に処理し、**planner_ai は最初に処理される**ので、他トピックに先取りされることは構造上ありえない。**純粋に arXiv へのクエリが当たっていない。**

**決定的な証拠が本日出た。P1 に最も刺さった 2 本が、planner_ai ではなく next_arch 経由で入ってきている。**

- **2608.12854 (BrainWAM)** —— NAVSIM で SOTA の end-to-end 運転 planner。abstract に "motion planning" も "trajectory prediction" も無く、**"end-to-end driving" (next_arch のキーワード) で拾われた。**
- **2608.13395 (FIRE-VLA)** —— nuScenes での運転 planner の RL post-training。同じく **planner_ai のキーワードに 1 つも一致しない。**

**planner_ai の keywords ("motion planning" / "trajectory prediction" / "planner evaluation" / "closed-loop simulation") は、2026 年の運転 planner 論文の語彙とずれている。** 自分の担当分野の主戦場を **1 件も捕まえていない。** 枯渇に見えていたものは供給不足ではなく、**検索語の陳腐化**だった。

**修正案 (topics.yaml):** planner_ai に `"end-to-end autonomous driving"` `"driving planner"` `"trajectory planning"` `"nuPlan"` `"NAVSIM"` `"closed-loop evaluation"` `"scenario generation"` を追加する。

**ただし、キーワードを足すだけでは済まない構造的な問題がある。** `fetch_candidates.py` は `seen` 集合でトピック間の重複を排除しており、**先に処理されたトピックが論文を独占する。** planner_ai に "end-to-end autonomous driving" を足すと、**今度は next_arch が痩せる** —— 本日の BrainWAM は P1 と P3 の両方に属する論文であって、どちらか一方に排他的に割り当てるのが誤りである。**トピック間の排他 dedup をやめ、1 論文が複数トピックに属せるようにする**のが正しい修正で、キーワード追加はその後にやるべき。**この順序を間違えると、P3 の枯渇と引き換えに P1 が回復するだけになる。**

### hf_upvotes の被覆は改善したが、タイブレークは本日も不発

**本枠 41 件のうち upvotes が 0 でないのは 5 件** (81 / 79 / 41 / 32 / 6) で、**昨日の 1 件から改善した。** ただし **本日は同点が発生しなかったため、タイブレークとしては使われていない。** 副次シグナルとして relevance を上書きしない運用は維持しており、**その結果として hf 81 の Alaya-EVOKE と hf 79 の DreamX-Phi が、hf 0 の論文に負けて落選している。** ルールどおりの挙動である。

---

## 惜しかった 3 件 (枠が空いた日に繰り上げ推奨)

- **2608.13546: Alaya-EVOKE: From Linear-Scaling Supervision to Endless World** (next_arch, hf **81** — 本枠最高) — **繰り上げ最優先。** relevance は 4.5 で、BrainWAM / Objective-Bottleneck に次いで **next_arch の quota 2 から溢れただけ。** 外部の camera-indexed world state bank に幾何を退避させて denoiser の context を有界に保つ、teacher 側を chunk 分割 + 遠方フレーム検索 + linear attention で線形スケールにして長horizon の監督を可能にする、30 秒の distribution-matching で 3 ステップ student へ転移する —— **P3 (長horizon の world model) と P2 (few-step 蒸留) の両方に効く数少ない 1 本。** H200 単体で 1.5 秒チャンクを 2.11 秒で生成、という実運用寄りの数字も出ている。
- **2608.12764: Beyond Outcome Rewards: Step-Level Self-Distilled Policy Optimization** (fm_distill) — **採用した FIRE-VLA と骨格がほぼ同型** (特権情報を持つ teacher → 教師学生の不一致を GRPO の advantage 重みに変換)。**同型の 2 本を同日に読む価値は低い**と判断し、運転ドメインである FIRE-VLA を採った。SSPO 側の利点は **「不正解の軌道にだけ適用し、正解軌道は触らずに多様性を保つ」**という切り分けの明快さと、**オーバーヘッドが 1 forward pass ぶんの約 5%** という安さ。FIRE-VLA を移植するなら、この設計判断は併せて読む。
- **2608.13026: Temporal GRPO: Beyond Trajectory-Level Credit in VLA RL** (next_arch) — **問題の切り方は本日の中でいちばん綺麗。** GRPO が rollout 全体に 1 つの advantage を配るせいで、**途中まで正しく進んだ行動が最後の失敗で罰される (trajectory-level credit aliasing)** という指摘。段階を検出し、**同じ段階に到達した rollout 同士だけを比較する。** ドメインが RoboTwin/LIBERO の操作系なので次点にしたが、**FIRE-VLA と併読すると「GRPO の credit 割当てをどう細かくするか」の設計空間が見える。**

---

## fm_distill_finetune (21 件中 20 落選)

- `2608.13505` **Intern-S2-Preview: Scientific Agentic Foundation Model** (hf 41) — **3/5。** post-training に on-policy distillation、partial rollout の off-policy 補正、online speculative decoding など P2 に効く部品は多いが、**397B のフルスタックで、我々の規模で再現できる recipe ではない。** ただし **Memory Decoder (凍結した 397B を一切変えずに専門化し、Biology-Instructions を 56.92 → 60.32)** は「他ドメインへの適合」の一形態として単独で追う価値がある。**要素として記録し、本体は落とす。**
- `2608.13495` **TraVEL: Trajectory-Guided Video Embedding Learning** — **3.5/5。** 運転動画検索。ego 軌道の類似度を GRPO の報酬に使い、**軌道は学習時のみの特権情報**として扱う (推論は単一ベクトル検索のまま)。**本日の FIRE-VLA と同じ「特権情報を報酬/教師に使う適合」の型**で、データキュレーションは P1 にも効く。**落とした理由は、検索性能が現在の我々のボトルネックではないため。**
- `2608.13387` **CROP: Task Relevance via Counterfactuals for Selective On-Policy Distillation** — **3.5/5。** どのトークンに監督を厚く配るかを、**paraphrase で較正した counterfactual 感度**で決める。P2 に正面から効くが、**改善が +1.92 / +2.96 点と小さく、original-paraphrase-counterfactual の三つ組を検証付きで作るコストが高い。** 費用対効果で FIRE-VLA に負けた。
- `2608.13205` **HPSD: Hybrid-Policy Self-Distillation for TI2V Diffusion** — **3.5/5。** 単一モデルが条件を変えるだけで teacher と student を兼ねる (teacher は高品質な first frame つき、student は素の prompt のみ)。**「容量差ゼロ・情報差ありの自己蒸留」という本日 3 本目の実例**で、R2 の 2 軸整理の参考になる。**動画生成ドメインで適用先が遠いため落選。**
- `2608.12597` **Predicting When Random Low-Dimensional Reparameterizations Train NNs** — **3/5。** LoRA 的な低次元再パラメータ化が成功する潜在次元を、曲率スペクトルと変位方向から予測する理論。**PEFT の次元選択を sweep なしで決められるなら実務価値は大きい**が、**理論の前提が実際の fine-tuning にどこまで当てはまるかが未検証。** 基礎寄りで、月次のサーベイ枠向き。
- `2608.13341` **UltraIR: Simulation-to-real transfer for IR spectroscopy** — **2/5。** 6000 万件の模擬スペクトルで事前学習し、少量の実測で適合。**「シミュレーションで事前学習して実データへ移す」型としては綺麗**だが、**ドメインが化学分析で、転移できる設計判断が乏しい。**
- `2608.13023` **Incremental Evaluation and Training in Relational Deep Learning** — **2/5。** リレーショナル DB 上の学習を逐次的に評価・更新する。効率の筋は良いが、我々のデータ形式と合わない。
- `2608.12748` **Scaling Representation Diversity (Visual Grounding)** — **2/5。** attention の変調と再構成正則化で視覚接地を改善。手法は一般的だが、我々の課題に直結しない。
- `2608.12746` **Dual-Stream Cross-Anchor Correction** — **2/5。** 長文キャプションの接地と、オブジェクトレベルのアンカーが効かなくなる領域の分析。同上。
- `2608.12515` **Can VLMs Assess Proxemic Risk from Egocentric Robot Images?** — **2.5/5。** **「VLM を安全性の評価器として使えるか」を検証する向きは R1 と同じ**だが、対象が対人距離で、評価も定性的。R1 の関連研究として名前だけ記録。
- `2608.12549` **StrAD: Streaming Audio Description for Long-form Videos** — **1.5/5。** 長尺動画のストリーミング推論の型としてのみ見所がある。適用先が遠い。
- `2608.13538` **SAEVerbalizer** — **1/5。** sparse autoencoder の特徴に自然言語説明を付ける解釈性研究。蒸留・適合に接続しない。
- `2608.13304` **Refusing Intent, Not Form** — **1/5。** LLM 安全性のラッパーベース監督。対象外。
- `2608.13239` **Reasoning for Social Audio-Visual QA** — **1/5。** 現状調査。対象外。
- `2608.12845` **FSGR: Mitigating Token Frequency Bias for Generative Recommendation** — **1/5。** 推薦システム。対象外。
- `2608.12795` **Fine-tuned Normalizing Flows for ALICE ZDC Fast Simulation** — **1/5。** 高エネルギー物理の高速シミュレーション。"fine-tuning" の語のみ一致した誤検出。
- `2608.12611` **From Visual Widgets to UI Code** — **1/5。** UI コード生成。対象外。
- `2608.13004` **HybridRAG-BN: Bangla KBQA** — **0.5/5。** 対象外。
- `2608.12677` **NLU in Multimodal Video-Based Dengue Diagnosis** — **0.5/5。** 医療。対象外。
- (`2608.12764` SSPO は上の「惜しかった 3 件」を参照)

## next_arch (17 件中 14 落選)

- `2608.13489` **DreamX-Phi 1.0: Action-Conditioned Video World Model** (hf **79**) — **4/5。** ロボット操作の行動条件付き動画 world model。**部品の見本市として有用:** 腕ごとの SE(3) 変換を attention に注入して腕の同一性と剛体運動を保つ、幾何のための depth branch、SAM3 マスク + 凍結 V-JEPA teacher で把持中の物体一貫性、DMD で少ステップ化。**WorldArena 2.0 で Track 1 位。** 落とした理由は、**ドメインが操作系で、個々の部品はそれぞれ既知**のため。「行動の忠実性を幾何で縛る」という発想だけ記録。
- `2608.13552` **PlayWorld: Benchmarking World Models with Agent Players** (hf 32) — **3.5/5。** **「固定した action 列で world model を比較するのは不当だ」**という指摘は正しく、エージェントに長horizon の目標を追わせて評価する。**本日の OpenART と同じ「評価は能動的でなければならない」という型**で、2 本が独立に同じ主張をしているのは記録に値する。**対象がゲーム/汎用動画で運転の評価に直結しないため落選。**
- `2608.12939` **Diagnosing JEPA World Models with Action-Conditioned Predictive Consistency** — **4/5。** 視覚的な摂動が action 条件付き予測をどれだけずらすかを **bisimulation (2 つの観測を同じ状態と見なしてよいのは、行動に対する帰結が一致するときだけ、という等価性の基準)** の観点から診断し、**Invariance Radius と Separation Rate という 2 指標**にまとめる。**摂動による予測誤差と planner コストの変化を上から抑える証明つき** —— **R1 の「保証つき指標」と方向がまったく同じ。** 採用した 2608.12959 と同系統 (world model を予測精度以外で測る) で、**行動を変える力で 12959 に譲った。R1 の指標設計を書く際には必ず引く。**
- `2608.13474` **Decoding Task Progress from VLA Representations** — **3.5/5。** π0.5 の residual stream から **task progress が線形に読める**、しかも **ロボットデータで学習する前の PaliGemma backbone の時点で既に存在する。** 単一の線形 probe が未知タスクにも汎化し、**ラベル不要の OOD 検出器**として SOTA 級。**運用中の policy を軽量に監視する手段**として実務価値は高い。対象が操作 VLA なので次点。**P1 の実行時監視を設計する段階で戻る。**
- `2608.12564` **Scaling Automatic Research Agents via World Models** — **3/5。** RL の学習コストが**環境実行**に支配される (生成はバッチで共有できるが、実行は 1 本ずつ実機時間を食う) という指摘から、**環境実行を world model で置き換えて 3-4 倍高速化。** 報酬のバイアスとノイズを **Online Debiasing / Inverse-Variance Denoising** で補正し、収束保証の改善を証明。**「シミュレータを学習モデルで置き換えるときの誤差をどう補正するか」は P1 の closed-loop 評価にも効きうる。要素として記録。**
- `2608.13456` **A Unifying Perspective on Causal World Models** — **3/5。** world model を因果の視点で階層化し、causal representation learning / object-centric learning / 因果探索 / SCM / model-based 意思決定と接続する形式化。**R3 のマップを作るときの語彙として有用**だが、**手法も実験も無い立場表明。日次の深掘り枠ではなく、月次のサーベイ枠で読むべき。**
- `2608.13438` **ContactGuard: Pre-Contact Execution Monitoring** — **3/5。** 接触前に潜在空間で結果を予測し、失敗しそうなら中止する。**08-14 に指摘した「学習済みモデルの外に決定論的な検証層を貼る」型の継続**で、この設計パターンの定着をさらに裏づける。接触リッチな操作に特化しているため落選。
- `2608.13453` **UniTexture: Cross-Task Universal Adversarial Textures for VLA** — **2.5/5。** 単一のテクスチャ付き 3D 物体で、複数タスクにまたがって VLA の行動を狙った方向へずらす (成功率 90.0% → 48.4%、モデル間転移あり)。**OpenART と同じ「能動的に失敗を探す」型**だが、**物理的なテクスチャ攻撃は我々の脅威モデルと違う。**
- `2608.13103` **S2-HWM: Sparse Event-Structured Hierarchical World Model** — **2.5/5。** イベント境界を学習して**可変長のセグメント**で imagination し、primitive step の horizon を超えて manager を学習させる構造は筋が良い。**評価が SurRoL の PegTransfer 1 タスク (98.7%) のみで、一般性が見えない。**
- `2608.13049` **H2R-Bench: Human-to-Robot Manipulation Video Generation** (hf 6) — **3/5。** 人間の一人称動画からロボット動画を生成する **cross-embodiment 転移**の評価ベンチ。**「他機種への適合」という P2 の関心と方向は同じ**だが、測っているのは動画生成の品質。
- `2608.13518` **Intervention-Aware Clinical World Model** — **1.5/5。** 心臓アブレーション後の再発予測。**「不規則な時刻に届く介入イベントで潜在状態を更新する」構造は一般的**だが、ドメインが医療。
- `2608.12904` **HounsWorld: Multimodal World Model for Patient-State** — **1.5/5。** CT 中心の患者状態 world model。医療。
- (`2608.13546` Alaya-EVOKE と `2608.13026` Temporal GRPO は上の「惜しかった 3 件」を参照)

## planner_ai (3 件中 2 落選)

- `2608.13260` **Virtual Temperature Sensors in Power Transformers Using Neural ODEs** — **0/5。** 電力変圧器の熱挙動予測。**運転の planner とは無関係で、cs.LG というカテゴリ一致だけで入った完全な誤検出。** キーワード側が何に一致したのかも判然としない。
- `2608.12528` **Excitation-Supervised Closed-Loop Self-Calibration for Range-Bearing Relay** — **1/5。** `"closed-loop simulation"` に引っかかったが、中身は**中継局の位置・方位が未知のときの自己校正と可識別性**の古典制御理論。**「校正が十分かを証明可能な指標で判定し、足りなければ探索動作を再発火させる」という監督構造そのものは R1 の発想と遠くない**が、学習ベースの planner 評価には接続しない。ROS 2/Gazebo の SIL 実験あり。

## sns_wildcard (3 件中 2 落選 — 探索枠は 1 件/日が上限)

- `2608.11924` **Spark-to-Paper: End-to-End Research Paper Generation as a Composable Skill** (hf **273** — 本日最高) — **枠が 1 件のため落選。** 内容は **13 個の composable skill で論文生成を end-to-end 化**するシステムで、**research_loop 自身の運用への示唆は確かにある:** モデルの判断と決定論的に検証できる操作を分離する、**結果を見る前に必要な証拠を確定させてから実験を回す (実験計画と報告の分離)**、繰り返し実験が元の研究目的を棄却し続ける **Self-Refutation Loop** を明示的に有界化する、引用の妥当性 99.5%、**単一パスの下書きでは 14% だった捏造検出が、整合性チェックと批評を入れて 92% に上がる。** **落とした理由は、ML の中身ではなくワークフロー設計の論文**であり、**「学びの価値」の密度で OpenART に劣ると判断したため。** ただし **research_loop の改善を考える日には、これを読むほうが本日の採用 6 本より有用かもしれない。**
- `2608.10915` **ComBodied Agents: a New Paradigm of Human-Centric Agentic AI** (hf 186) — **落選。** 人間の状態軌跡そのものを一次のモデリング対象に据えるエージェント像の**立場表明論文。** "Personal World Model" という語は出るが、**形式化も実験も無い。** hf 186 は概念的な訴求力によるもので、**技術的な持ち帰りがない。**
