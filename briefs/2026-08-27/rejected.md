# 2026-08-27 不採用の候補

候補 **54 件** / 採用 **6 件** (= `max_deep_per_day` 上限ちょうど) / 不採用 **48 件**。
内訳: planner_ai 5 / fm_distill_finetune 30 / next_arch 16 / sns_wildcard 3。

**本流トピックが 2 日連続で潤沢である。**特筆すべきは **planner_ai が 5 件来たこと** — 08-26 は 1 件、その前は 3 日連続ゼロだった。
**P1 で初めて quota 2 に対する競争が成立した日**であり、`lookback_days` を触らずに済んだのは偶然ではなく、
08-24 (月) と 08-25 (火) の 2 日分がまとめて入っているからである。

**以下の不採用の大半は、質が低いからではなく quota に入らなかったからである。**
fm_distill_finetune は 30 件中 2 件、next_arch は 16 件中 2 件しか採れない。

---

## 採否の一覧

### planner_ai (quota 2 / 候補 5 / 採用 2)

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.24094](2608.24094.md) | SIREN-Bench | **5.0** | 0.5 | 2.5 | 0 | **採用** |
| [2608.24282](2608.24282.md) | CARE: Camera-Residual Reserves | **4.0** | 0.5 | 1.5 | 0 | **採用** |
| 2608.23972 | Safety-aware MPPI with Signal Temporal Logic | 3.0 | 0.5 | 1.0 | 0 | 不採用 |
| 2608.24019 | Trusted Polytopic Action Sets | 2.5 | 0.5 | 1.0 | 0 | 不採用 |
| 2608.24618 | VIP: Variation-based Iterative-learning Planning | 2.0 | 0.5 | 1.0 | 0 | 不採用 |

- **2608.23972 (STL-MPPI)** — 今日いちばん惜しい不採用。**STL (Signal Temporal Logic; 「10 秒以内に領域 A に到達し、その間ずっと領域 B を避ける」のように時間つきの要求を式で書く形式言語)** を **CBF (Control Barrier Function; 安全な状態集合から出ないことを保証する制約関数)** に変換して **MPPI (Model Predictive Path Integral; 大量の軌跡をサンプリングして重み付き平均で制御入力を決める並列化しやすい制御)** に組み込む、という筋の良い構成。**手法としては AD の planner にそのまま移せる。**落とした理由は評価が火星ローバー 4 例と Isaac Lab の quadcopter で、**AD ドメインでの検証がゼロ**であること、および CARE が持つ評価設計上の知見の方が R1 に直結すること。**「時間つきの安全要求を式で書いて planner に入れる」という道具立てが必要になった時点で拾い直す価値がある。**
- **2608.24019 (Trusted PAS)** — 劣駆動系の局所的な凸行動集合を online で作る。kinodynamic RRT 比 14〜78 倍高速は立派だが、**評価は平面の雑然環境と非線形ベンチマークで、車両ダイナミクスではない。**P1 の関心 (評価指標) にも当たらない。
- **2608.24618 (VIP)** — 無限次元関数空間で計画指令を直接更新する。数学的には面白いが**対象がロボット群のナビゲーションで、AD の planner にも評価にも接点がない。**topics.yaml の `motion planning` に一致しただけ。

### fm_distill_finetune (quota 2 / 候補 30 / 採用 2)

| id | タイトル | P2 | hf | 採否 |
|---|---|---|---|---|
| [2608.23911](2608.23911.md) | PROOF-Gen: From Optimized Data to Better Distillation | **4.5** | 0 | **採用** |
| [2608.23816](2608.23816.md) | AQLoRA: A Zero-Search Recipe for Fast Quantized LoRA | **4.5** | 0 | **採用** |
| 2608.24070 | Compression Trinity (sparsity × quantization × low-rank) | 4.0 | 0 | 不採用 |
| 2608.24154 | Zero-Shot Cross-City Object Detection | 3.5 | 0 | 不採用 |
| 2608.24469 | Low-Rank Ternary Adaptation for Fine-Tuning Transformers | 3.5 | 0 | 不採用 |
| 2608.24482 | Beyond Static Interpretability (pre-SFT からの localization) | 3.5 | 0 | 不採用 |
| 2608.24188 | Paritok-4B: Intent-Conditioned Context Compression | 3.5 | 0 | 不採用 |
| 2608.24727 | Parameter-Efficient Self-Supervised Adaptation for EEG-FM | 3.0 | 0 | 不採用 |
| 2608.24429 | Joint Distribution Alignment for Universal Domain Adaptation | 3.0 | 0 | 不採用 |
| 2608.23879 | Spatiotemporal Distillation via Recurrent Bottlenecks | 3.0 | 0 | 不採用 |
| 2608.24130 | Syn2RealTrack | 3.0 | 0 | 不採用 |
| 2608.23799 | Restoring Without Forgetting | 2.5 | 0 | 不採用 |
| 2608.23903 | Continual Visual Learning under Evolving Semantic Concept Shift | 2.5 | 0 | 不採用 |
| 2608.23987 | Sparse Neural Operators with Distillation Assistance | 2.5 | 0 | 不採用 |
| 2608.24597 | Invariance-oriented pre-training for EEG foundation model | 2.5 | 0 | 不採用 |
| 2608.24342 | Metadata-Aware Adaptation for Conditional CMR Synthesis | 2.5 | 0 | 不採用 |
| 2608.24364 | B-MIM: Biased Masked Image Modeling | 2.0 | 0 | 不採用 |
| 2608.24093 | Joint-Embedding Prediction of Masked Point Tubes | 2.0 | 0 | 不採用 |
| 2608.24549 | Persistent Cross Entropy | 2.0 | 0 | 不採用 |
| 2608.24354 | Region-Aware Consistency Repair of Backdoors in MLLMs | 1.5 | 0 | 不採用 |
| 2608.23830 | Mitigating Exploration Bias in RL for Multi-Instruction Following | 1.5 | 0 | 不採用 |
| 2608.24848 | BrowserForge: Scaling Web Episode via Parallel Browser Sandboxes | 1.5 | 0 | 不採用 |
| 2608.23959 | NeuronGuard: Robust LLM Safety Alignment | 1.5 | 0 | 不採用 |
| 2608.24275 | RePolicy: RL for Safety-Policy Invocation | 1.5 | 0 | 不採用 |
| 2608.24621 | Consequence-Aware Evaluation for Safety-Critical Language | 1.5 | 0 | 不採用 |
| 2608.23869 | Gen2Physics: Grounding Generated 3D Meshes in Physics | 1.5 | 0 | 不採用 |
| 2608.24707 | Lost in Speech: Trilingual Spoken Hallucination Detection | 1.0 | 0 | 不採用 |
| 2608.24268 | ROBE: Extracting Extreme Long-tail Events from Historical Texts | 1.0 | 0 | 不採用 |
| 2608.24133 | PlaceSeek: Human-Centered Geospatial Retrieval | 1.0 | 0 | 不採用 |
| 2608.24127 | Anatomy of a Scam Call | 0.5 | 0 | 不採用 |

**当落線上の 5 本についてだけ理由を書く。**

- **2608.24070 (Compression Trinity)** — sparsity / quantization / low-rank を単独でなく同時に掛けるという統一的な見取り図で、**P2 の「圧縮技術の地図」としては本日いちばん価値がある。**落とした理由は、これが**学位論文であり、収録されている 5 つの手法 (MKOR / SLoPe / OPTIMA / PATCH / SLiM) はいずれも既発表**だからである。新規の知見ではなく統合された整理であり、**その性質上「今日読む」より「必要になった日に地図として引く」方が正しい使い方である。** → `surveys/` に地図として登録する候補。**AQLoRA と関心が重なる (どちらも量子化下の適合) ため、今日は recipe として即使える AQLoRA を採った。**
- **2608.24154 (Cross-City Detection)** — 都市間のドメインシフトを**target データを一切見ずに (blind)** 克服する pipeline。**class-agnostic objectness distillation (クラス名を捨てて「物体らしさ」の幾何だけを蒸留する) と、色に依存した近道を潰す Grayworld 変換**の 2 本柱。**P2 の「他ドメインへの適合」と driving ドメインの両方に当たる数少ない候補で、+24.29 mAP は大きい。**落としたのは、貢献が **AI City Challenge というコンペ向けの工学的積み上げ**で、一般化可能な原理として取り出しにくいため。**ただし「色の手がかりを潰すと形の事前分布が残る」という 1 点だけは、他機種カメラへの適合に直接効く。**明日以降に候補が薄い日があれば拾い直す。
- **2608.24469 (Ternary LoRA)** — ternary (重みを −1 / 0 / +1 の 3 値に量子化) のまま、**dequantization なしに adapter を merge できる**という設計は綺麗で、Kronecker 分解による離散更新の表現も筋が通っている。**AQLoRA と同じ「量子化下の PEFT」枠で競合し、実務での適用範囲 (ternary 前提) が狭いため負けた。**
- **2608.24482 (pre-SFT localization)** — **SFT 後に重要になるパラメータを、SFT 前の勾配から Taylor 展開で予測する**という発想は本日いちばん理論的に面白い。落としたのは、**得られるものが「より良い SFT の当て方」であって、P2 が今欲しい recipe (回して結果が出る手順) ではない**こと、および検証コストが高いこと。
- **2608.24188 (Paritok-4B)** — gpt-4.1-mini teacher を 4B の LoRA compressor に蒸留し、**コーディングエージェントの context を 25.7% に圧縮して解答品質の 86.5% を保つ。**蒸留の実例として質が高く、**「圧縮器としての gpt-5 は下流の節約分より高くつくので採算が合わない」**という経済性の結論は実務的に鋭い。**用途がコーディングエージェント特化で、P1/P2/P3 のいずれにも転用先が見えないため落とした。**

**下位 15 本 (スコア 2.0 以下) は、`fine-tuning` / `transfer learning` / `domain adaptation` という現代の ML 論文のほぼ全てに出現する語に一致しただけである。**
特に **2608.24127 (詐欺電話 1 万件の分析)** は、蒸留とも適合とも無関係な純然たる雑音。

### next_arch (quota 2 / 候補 16 / 採用 2)

| id | タイトル | P3 | P1 | hf | 採否 |
|---|---|---|---|---|---|
| [2608.24525](2608.24525.md) | RoG-DAgger: Rollout-Guided Post-Training for E2E Driving | **5.0** | **4.5** | 0 | **採用** |
| [2608.24885](2608.24885.md) | Do Robotic World Models Really Follow Actions? | **4.5** | **4.0** | 0 | **採用** |
| 2608.24855 | LeFlow: Generative Latent Flow Planning for World Models | 4.0 | 3.0 | 0 | 不採用 |
| 2608.23720 | Platonic Representation Hypothesis on World Models | 3.5 | 1.0 | 0 | 不採用 |
| 2608.24044 | XP-JEPA: Cross-Predictive Physics Grounding | 3.5 | 1.5 | 0 | 不採用 |
| 2608.24042 | Hierarchical Skill Retrieval for VLA Adaptation | 3.0 | 1.0 | 0 | 不採用 |
| 2608.24680 | Game2World Engine | 3.0 | 1.0 | **8** | 不採用 |
| 2608.24101 | TrAct: Bridging Robot Control and Visual Prediction | 3.0 | 1.0 | 0 | 不採用 |
| 2608.23831 | Learning to Act While Waiting (推論遅延下の RL finetuning) | 3.0 | 2.0 | 0 | 不採用 |
| 2608.23863 | DreamLedger: Execution-Settled Credit Files | 2.5 | 1.5 | 0 | 不採用 |
| 2608.24603 | Gripper-aware Vision Language Action Models | 2.5 | 0.5 | 0 | 不採用 |
| 2608.24115 | PonderPounce: Pretrained MLLM as Episode Context Engine | 2.5 | 1.0 | 0 | 不採用 |
| 2608.24199 | NVIDIA Cosmos-H-Dreams (手術ロボット向け生成物理シム) | 2.5 | 1.5 | 0 | 不採用 |
| 2608.23790 | Primate vision reveals a missing principle for robust dynamic AI | 2.0 | 0.5 | 0 | 不採用 |
| 2608.24561 | SeisMamba (単一観測点の地震マグニチュード推定) | 1.0 | 0.5 | 0 | 不採用 |
| 2608.23746 | CRISP: Visual State Space Duality for Remote Sensing | 1.0 | 0.5 | 0 | 不採用 |

**当落線上の 4 本。**

- **2608.24855 (LeFlow)** — 本日最も惜しい next_arch の不採用。**world model を「黒箱シミュレータとして毎回ゼロから最適化を回す対象」ではなく「再利用可能な計画の事前分布を持つもの」に変える提案。** rectified flow (ノイズから目標へ直線的に進む速度場を学習する生成手法。diffusion より少ステップで済む) で潜在空間の未来経路を一気に描き、inverse dynamics decoder で行動列に戻し、凍結した world model が rollout で検証する。**計画時間が一桁減る。**落としたのは、対象が goal-conditioned な画素制御ベンチマークで **driving の連続的な再計画とは要求が違う**こと、および同じ枠で **WorldSync の方が「world model が信用できるか」というより手前の問いに答えている**こと。**R3 (VLA × world model 統合) の分類マップを作る段では必読に格上げすべき 1 本。**コードは公開されている (github.com/hsiangwei0903/LeFlow)。
- **2608.23720 (Platonic Representation Hypothesis on World Models)** — 異なる visual encoder から出発した world model が、**共通の状態遷移目的で学習すると幾何的に似た内部構造へ収束する**ことを示し、**model stitching (片方の中間特徴をもう片方に差し込む) が性能をあまり落とさずに通る**ことまで確認している。**「異なる world model の内部表現が互換である」は、P2 の蒸留と P3 の統合アーキテクチャの両方に効く可能性がある命題。**落としたのは、検証が DINO-WM 1 系統の encoder 差し替えに限られ、**主張の一般性がまだ細いため。**
- **2608.24044 (XP-JEPA)** — 視覚と物理状態を別々に符号化し、**共有の行動条件付き predictor で両方を進めて互いに合わせる。**物理側は学習後に捨てるので、**推論時は視覚のみ。**rollout の drift が 0.361 → 0.104、制御成功率 53.6% → 78.2% と効果は大きい。**「特権情報で接地して、推論時には捨てる」は蒸留の一形態であり P2 との二重該当。**落としたのは quota で、**WorldSync と問題意識 (潜在ダイナミクスが物理から乖離する) が重なるため。**
- **2608.24042 (HSR)** — VLA を少数デモで新タスクに適合させるための retrieval。**タスク全体の一致は稀でも、部分スキルの一致は豊富**という着眼は正しい。**これも next_arch と fm_distill_finetune の二重該当で、fm_distill 側に配されていれば当落線上だった。**

**明確な誤配が 2 件。** **2608.24561 (SeisMamba)** は地震のマグニチュード推定、**2608.23746 (CRISP)** はリモートセンシングの意味分割。どちらも `state space model` というキーワードに一致しただけで、P3 とは無関係。

### sns_wildcard (最大 1 / 候補 3 / 採用 0)

| id | タイトル | hf | 採否 |
|---|---|---|---|
| 2608.23283 | Apodex 1.1: Scaling Agentic Intelligence for Complex Work | **181** | 不採用 (**重複**) |
| 2608.15875 | GigaBrain-0.7: Scaling Embodied Foundation Models | 87 | 不採用 (quota) |
| 2608.20492 | Annotations as Rollouts (OraRL) | 87 | 不採用 |

- **2608.23283 (Apodex 1.1)** — **08-26 に採用済みでブリーフが既にある ([briefs/2026-08-26/2608.23283.md](../2026-08-26/2608.23283.md))。**重複の再提示であり、内容による不採用ではない。**memory に記録済みの欠陥#1 の再発である (後述)。**
- **2608.15875 (GigaBrain-0.7)** — **本日の wildcard 3 件で唯一、内容として採る価値があった (実質スコア 4.0)。**VLA を understanding / prediction / action の 3 系統に分けた構成、37,000 時間超の異種身体データでの事前学習、**理解と多身体の行動生成を同時に最適化する one-stage alignment training**、そして重みとコードの公開予定。**R3 (VLA × world model 統合アーキテクチャ) の参照実装として直球である。**
  **落とした理由は 2 つ。**(1) `max_deep_per_day: 6` を本流 3 トピックの quota が使い切っている。(2) **内容が P3 の本流そのものであり、wildcard 枠の趣旨 (分野外を覗いて視野を広げる) に合わない。**枠の意味を守るなら、これは next_arch として競争させるべき候補である。
  **→ 明日以降への繰越候補。**08-15 公開で既に 12 日経っており、**候補として再提示されない可能性が高いので、手動で拾う必要がある。**
- **2608.20492 (OraRL)** — video MLLM の RL post-training で、**annotation を採点役だけでなく「oracle rollout」として最適化対象そのものに入れる。**そこで生じる **advantage inversion (高報酬の oracle が集団の基準を押し上げ、本来正の advantage を負に反転させてしまう現象)** を、基準線と oracle の寄与を分離した advantage 推定で回避する。**GRPO (Group Relative Policy Optimization; PPO を簡略化し、同じ入力への複数出力の相対比較で LLM を RL 学習する手法) + chain-of-thought の 4.9 倍に対し、SFT の 2.2 倍の step 時間で済む。**筋は良いが、**wildcard 枠は 1 件までで、GigaBrain の方が P3 への距離が近い。**

---

## パイプライン所見

**本日は本流 51 件・2 日連続の潤沢さで、観測点が複数取れた。**

- **欠陥#1 (重複再提示) — 再発。**2608.23283 (Apodex 1.1) が **08-26 に採用済みでブリーフが存在するのに、hf_upvotes 181 で再提示された。**
  memory には「08-25 に実害が途切れたが修正ではなく HF 上位の入れ替わりによる偶然」と記録してあるが、**その読みが正しかったことが本日確認された。**
  HF Daily Papers の上位は数日居座るので、**wildcard 枠は構造的に重複しやすい。**
  **対処: `briefs/*/` に既存のブリーフがある id を候補から除外する。**`fetch_candidates.py` で `glob('briefs/*/{id}*.md')` を見るだけで済み、**5 分の変更である。**
  **本日の実害は明確 — wildcard 枠 3 つのうち 1 つが重複で潰れ、残り 2 つのうち採る価値のある GigaBrain は quota で落ちた。結果として wildcard 枠の収穫はゼロ。**

- **欠陥#3 (`lookback_days` が wildcard に効かない) — 未修正、3 日連続で観測。**
  wildcard 3 件の公開日は 08-23 / 08-19 / 08-15 で、cutoff (2 日) の外がそれぞれ **1.9 日 / 7.9 日 / 11.9 日**。
  **欠陥#1 の直接の原因でもある** — 古い論文が残り続けるから重複する。**修正順序は memory の記録どおり lookback → 欠陥#3 の順。**

- **欠陥#4 (トピック誤配) — 本日 2 例、累計 9 例。**SeisMamba (地震) と CRISP (リモートセンシング) が `state space model` 一致で next_arch に入った。
  **加えて二重該当の損失も再現している** — XP-JEPA と HSR は next_arch と fm_distill_finetune の両方に当たるが、単一トピックに潰されて next_arch の 16 件競争で沈んだ。**fm_distill 側なら当落線上だった。**08-26 の Act with Intent とまったく同じ形の損失で、**2 日連続。偶発ではなく構造である。**

- **欠陥#5 (fm_distill の in-field 率) — 2 日目の観測点。**30 件中、蒸留/適合を実際の貢献としているのは **16 件 (53%)**、recipe として実務で使えるのは **7 件 (23%)**。
  **08-26 の 50% / 27% とほぼ一致した。**2 点の観測で安定しているので、**これはこのトピック定義の定常的な性質とみてよい。**quota が実害を吸収しているため優先度は低いままだが、**「30 件中 7 件しか使えない」という比率が分かったこと自体は、キーワード改訂の判断材料になる。**

- **`lookback_days: 5` — 依然として未実施。**本日 `2` で足りたのは、**08-24 (月) と 08-25 (火) の 2 日分が入っているからである。**
  memory の記録どおり **08-25 実測で lb=4 では不足、lb=5 が必要**という結論は変わっていない。
  **今週末 (08-29 土 / 08-30 日) に、また本流ゼロが再発する。**この設定変更は 1 行・5 分で、90 分ブロックを必要としない。

- **新しい所見: planner_ai のキーワードは、思ったより狭くない。**
  08-26 の所見で「P1 だけキーワードが狭く投稿数が構造的に少ない」と書いたが、**本日 5 件来た。**
  **狭いのはキーワードではなく `lookback_days` である。**P1 は他トピックより投稿の絶対数が少ないぶん、**2 日窓の分散が大きく出る。**
  → **P1 のキーワード拡張より先に `lookback_days: 5` を実施すべき。**08-26 の所見はこの点で訂正する。
