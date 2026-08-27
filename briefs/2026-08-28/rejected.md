# 2026-08-28 不採用の候補

候補 **51 件** / 採用 **6 件** (= `max_deep_per_day` 上限ちょうど) / 不採用 **45 件**。
内訳: planner_ai **2** / fm_distill_finetune 30 / next_arch 16 / sns_wildcard 3。

**planner_ai が 5 件 → 2 件に落ちた。**08-27 の rejected.md で「5 件来たのは 08-24 と 08-25 の 2 日分がまとまって入ったからで、偶然である」と書いた通りになった。
**`lookback_days: 2` のまま週末に入るので、明日以降さらに痩せる。**memory に記録済みの `lookback_days: 5` への変更 (5 分) が、本日時点でも未実施である。

**quota 配分の実際 (本日は planner_ai が枯れたため、上限ちょうどに埋めるのに wildcard 枠を使った):**

| topic | quota | 候補 | 採用 |
|---|---|---|---|
| planner_ai | 2 | 2 | **1** (2 件目は基準に届かず、埋めなかった) |
| fm_distill_finetune | 2 | 30 | 2 |
| next_arch | 2 | 16 | 2 |
| sns_wildcard | (最大 1) | 3 | 1 |
| **計** | **6** | **51** | **6** |

**以下の不採用の大半は、質が低いからではなく quota に入らなかったからである。**next_arch は 16 件中 2 件しか採れず、**本日は 4.0 以上が 6 本あった。**

---

## planner_ai (quota 2 / 候補 2 / 採用 1)

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.25830](2608.25830.md) | Anytime Global Tensor Motion Planning | **3.5** | 0.5 | 1.5 | 0 | **採用** |
| 2608.25641 | U-TAMP: Inter-object Affordances for Contact-rich Planning | 2.0 | 0.5 | 1.5 | 0 | 不採用 |

- **2608.25641 (U-TAMP)** — TAMP (Task and Motion Planning; 「何をするか」の記号的な行動列と「どう動くか」の連続的な軌道を同時に解く枠組み) に、**VLM (Vision-Language Model) が生成した物体間の affordance (この物体はこの物体を支えられる、掴める、といった相互作用の可能性) を制約として注入する。**計画成功率が上がり、計画時間が 1〜2 桁短縮というのは立派な数字である。
  **落とした理由は対象領域が遠すぎること。**評価はシミュレータ上の台所のテーブル整理であり、**扱っている「接触が支配的な操作」は、車両の運動計画とは問題の構造が違う。**P1 の主関心である評価指標にも当たらない。`motion planning` というキーワードに一致しただけで、**topics.yaml の relevance_criteria (自動運転のプランナー実装・評価指標に直接使えるか) には届いていない。**
  **quota 2 に対して候補 2 なので「埋めれば 2 件採れた」が、埋めなかった。**基準に届かないものを quota のために採ると、**DIGEST の TOP3 の質が落ち、翌日以降の判断基準も緩む。**

---

## next_arch (quota 2 / 候補 16 / 採用 2) — 本日いちばん競争が激しかった

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.26067](2608.26067.md) | StreamPI: streaming temporal modeling for VLA | 2.5 | 1.5 | **4.5** | 16 | **採用** |
| [2608.25757](2608.25757.md) | LM-X: progress / event / uncertainty prediction | 3.5 | 1.5 | **4.5** | 0 | **採用** |
| 2608.25017 | RDR: Rollout-Decoded Reconstruction for latent world models | 1.5 | 2.0 | 4.5 | 0 | 不採用 (**繰越候補**) |
| 2608.26058 | UCAG-P: One Policy, Many Embodiments | 1.0 | 3.5 | 4.5 | 0 | 不採用 |
| 2608.25659 | GaussianDream++: 3D Gaussian world modeling in VLA | 1.0 | 1.0 | 4.0 | 0 | 不採用 |
| 2608.25308 | V-Link: recovering visual reps in Action DiT | 1.0 | 1.0 | 4.0 | 0 | 不採用 |
| 2608.25572 | ConfAL-WM: confidence-guided active learning for WM | 1.5 | 2.5 | 3.5 | 0 | 不採用 |
| 2608.25956 | 4DGS-WAM: object-centric 4DGS world action model | 2.5 | 0.5 | 3.5 | 0 | 不採用 |
| 2608.25479 | 4DStreamCtrl: interactive 4D-controllable video gen | 1.5 | 1.0 | 3.5 | 0 | 不採用 |
| 2608.25585 | RA-VLA: retrieval-augmented test-time adaptation | 1.0 | 2.5 | 3.0 | 0 | 不採用 |
| 2608.25864 | MA-VLA: multi-arm VLA | 0.5 | 1.0 | 3.0 | 5 | 不採用 |
| 2608.25798 | TacForcing: streaming action gen with tactile feedback | 1.0 | 0.5 | 3.0 | 0 | 不採用 |
| 2608.25666 | PRISM: sampling-based MPC for bimanual manipulation | 2.0 | 0.5 | 1.5 | 0 | 不採用 |
| 2608.25395 | TARCAT: taxonomy of construction task activities | 0.5 | 0.5 | 1.5 | 0 | 不採用 |
| 2608.25327 | Failure remedies for Physics-Informed Neural Networks | 0.5 | 1.5 | 1.0 | 0 | 不採用 |
| 2608.25190 | BanglaMamba: SSM for Bangla fake news detection | 0.5 | 0.5 | 1.0 | 0 | 不採用 |

### 惜しい不採用 3 本 (いずれも実質 4.0 以上)

- **2608.25017 (RDR) — 本日いちばん惜しい。DIGEST に繰越として再掲する。**
  **latent world model (観測を直接扱わず、圧縮した潜在状態の上で未来を予測する world model) は、decoder を「観測に紐付いた潜在」で学習しておきながら、実際には「モデル自身が自由走行させた、最後の観測から数百ステップ先の潜在」に対して使われる。**この学習と評価のずれを、**損失項を 1 つ足すだけで閉じる** — 学習中にも評価と同じように自由走行させ、その全ステップを復元して真値と比べる。
  **評価すべき点が 3 つある。(1) パラメータを増やさず、重み 0 で標準の目的関数に戻るので、全比較が「フラグ 1 つの A/B」になる。(2) 事前登録した 10 設定すべてで効き、選定に使っていない seed でも確認している。(3) 193,568 パラメータという極小規模で、valid prediction time が 3.87 → 6.97 と 1.8 倍。**
  **落とした理由は quota のみである。**検証が Kuramoto-Sivashinsky 方程式 (カオス的な挙動を示す偏微分方程式で、長期予測の難しさを測る標準的な題材) という単一系で、他 2 タスクの対照実験は著者自身が preliminary と書いている — この点は割り引くべきだが、**主張している原理「評価と同じ形で学習しろ」は領域に依存しない。**
  **そして 08-27 の WorldSync (world model は専門家がやらない行動に追従できない) と正面から噛み合う。**あちらが診断で、こちらが処方の 1 つである。
  **さらに、memory に記録された実行のボトルネック (実験着手 8 週連続ゼロ、原因は 90 分ブロックの確保) に対して、本日の候補で最も相性が良いのがこの論文である** — **20 万パラメータ、損失項 1 つ、フラグ 1 つの A/B。**手元で回せる規模として、本日の 51 件の中で群を抜いている。**quota を理由に落としたが、拾う価値は採用 6 本の下位と同等以上である。**

- **2608.26058 (UCAG-P: One Policy, Many Embodiments)** — **VLA の汎化を阻む最大の障害は、身体・カメラ配置・行動空間がデータごとにバラバラであること。**この論文は**行動をロボット固有の指令ではなく「カメラから見える anchor の動き」として表現し直す**ことで、ロボットアーム・ヒューマノイド・人間の手を**同じ行動スキーマの異なる実装**として扱う。ロボット/シミュレーション 4,030 時間 + 人間デモ 2,340 時間で学習し、**単一チェックポイントで LIBERO 98.3%、LIBERO-Plus に zero-shot で 82.0%。**
  **落とした理由は StreamPI / LM-X との quota 競合。**ただし **P2 (他機種・他ドメインへの適合) にも 3.5 で当たる稀な論文である** — 「異種の身体をまたぐ共通表現を設計してから学習する」という発想は、**別機種への適合を fine-tuning でなく表現設計で解く道**であり、P2 の relevance_criteria の後半 (基盤モデルを別ドメインに転用する recipe) に該当する。**P2 と P3 の両方に効く論文は珍しいので、拾い直しの優先度は高い。**

- **2608.25659 (GaussianDream++)** — **VLA の backbone に World State Token と World Prediction Token を直接差し込み、学習時だけ動く head がそれを 3D Gaussian の現在と未来へ復号する。推論時には head も renderer も補助目的関数も全部外し、20 個の world token だけが残る。**LIBERO 98.6%、実機で π0.5 再現版の 29.2% → 52.5%。
  **R3 (VLA × world model 統合) の分類マップにおける「world model を学習時の補助信号としてのみ使い、推論時には消す」という設計点の代表例。**この行は本日採用の 2 本では埋まらない。**マップを作る段階で必ず参照する。**

### その他の不採用理由

- **2608.25308 (V-Link)** — 「action expert が VLM の特徴に十分アクセスできていない」という診断は鋭く、LIBERO-Plus +31.2% は大きい。**GaussianDream++ と問題意識が近く (VLA 内部の情報経路の設計)、両方は採れなかった。**
- **2608.25572 (ConfAL-WM)** — world model の誤差が局在する (アーム・操作対象・接触部・遮蔽物) という観察と、confidence map で学習データを選ぶ枠組み。**筋は良いが、EVAC という特定の基盤の上に構築されており、そこへの依存が強い。**
- **2608.25956 (4DGS-WAM)** — **KITTI-MOT で評価している数少ない運転寄りの world model。**動的物体と静的背景を分けて、背景は再生成しないという発想は素直で良い。**落としたのは評価が短期予測と過去再構成に留まり、方策や計画との接続が無いこと。**運転ドメインという点で P1 に 2.5 を付けたが、**評価指標の話ではないので R1 には届かない。**
- **2608.25479 (4DStreamCtrl)** — カメラ運動・物体軌跡・深度を単一の 3D point-track 表現に統合し、**因果的な streaming student に蒸留して 480p を 20FPS。**「制御可能なシミュレータ」としては魅力的だが、**行動の忠実な追従が検証されていない** — 08-27 の WorldSync が突いたのはまさにそこである。**映像として妥当なことと、指令通りに動くことは別。**
- **2608.25585 (RA-VLA)** — test-time adaptation を retrieval で行う方向は本日の VoiceMem とも通じるが、**abstract が抽象語 (「superficial retrieval mechanisms」「behavioral inertia」) で構成されており、何を実際にやったかが読み取れない。**具体性の欠如を理由に落とす。
- **2608.25864 (MA-VLA, hf 5)** — Arm Shuffle (学習時に腕ごとの観測・状態・指示を入れ替えて役割固定を壊す) は綺麗な発想だが、**多腕協調は P1〜P3 のどれにも接続しない。**
- **2608.25798 (TacForcing)** — 触覚を実行中に取り込む streaming action expert。**chunk 単位の行動予測では実行中に条件が古くなる、という指摘は AD にも通じるが、触覚という modality が遠い。**
- **2608.25666 (PRISM)** / **2608.25395 (TARCAT)** / **2608.25327 (PINN)** / **2608.25190 (BanglaMamba)** — 順に双腕 MPC、建設作業の分類体系、PINN の失敗要因の統制実験、Bangla のフェイクニュース検出。**いずれも `state space model` や `world model` 等のキーワードに一致しただけで、追っているプロジェクトに接点がない。**
  ただし **2608.25327 (PINN) だけは方法論として一言。**「FP32→FP64 にする」対「backbone を SSM に替える」という 2 つの処方を、**144 回の事前登録実験で seed を対応付けて比較し、両者が互いに代替しない (効く領域が重ならない) ことを示している。**さらに **同じ精度切り替えが seed ごとに逆方向に効く**と報告している。**内容は無関係だが、「seed ごとに報告せよ」という結論は 08-27 の AQLoRA の計測 3 原則と同じ方向を指しており、P2 の実験設計の傍証として数えてよい。**

---

## fm_distill_finetune (quota 2 / 候補 30 / 採用 2)

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.25677](2608.25677.md) | QLoRA: An Acquisition-Retention Frontier | 0.5 | **4.5** | 1.5 | 0 | **採用** |
| [2608.25643](2608.25643.md) | Token-Level Analysis of Reverse-KL On-Policy Distillation | 0.5 | **4.5** | 1.0 | 0 | **採用** |
| 2608.25810 | Label-Free Foundation Model Selection under Distribution Shift | 1.5 | 4.0 | 1.0 | 0 | 不採用 |
| 2608.25756 | TailSFT: Filtered Fine-Tuning Improves Post-Training | 0.5 | 4.0 | 1.0 | 0 | 不採用 |
| 2608.25927 | Code World Model: Coding Agent as World Brain | 1.0 | 1.5 | 4.0 | 14 | 不採用 (**topic 誤配**) |
| 2608.25941 | When Pruning Meets Interpretability (SAE robustness) | 0.5 | 3.5 | 0.5 | 0 | 不採用 |
| 2608.25692 | CloSeR: Unified Relational Distillation | 0.5 | 3.5 | 0.5 | 0 | 不採用 |
| 2608.25826 | Unfolding Scientific Papers into Generation Trajectories | 0.5 | 3.0 | 0.5 | 0 | 不採用 |
| 2608.25580 | V-Rubrics: rubric-based RL for visual faithfulness | 1.0 | 3.0 | 2.0 | 12 | 不採用 |
| 2608.25568 | CrossMambaTuning (PEFT for learned image compression) | 0.5 | 3.0 | 1.5 | 0 | 不採用 |
| 2608.25893 | Molecular FM transfers across olfactory tasks | 0.5 | 2.5 | 0.5 | 0 | 不採用 |
| 2608.25707 | Fairness-Aware Test-Time Prompt Tuning | 0.5 | 2.5 | 0.5 | 0 | 不採用 |
| 2608.25605 | Instruction-tuned LLMs for harmful content mitigation | 0.5 | 2.0 | 0.5 | 0 | 不採用 |
| 2608.25851 | DEFUSE: backdoor defense for self-supervised encoders | 0.5 | 2.0 | 0.5 | 0 | 不採用 |
| 2608.25935 | TAU-Agent: agentic RAG for traffic anomaly understanding | 2.0 | 1.5 | 1.0 | 0 | 不採用 |
| 2608.25881 | Loss-Based Active Learning for Abstractive Summarization | 0.5 | 2.0 | 0.5 | 0 | 不採用 |
| 2608.25768 | MoganBert-TR (Turkish encoder, CLM-to-MLM curriculum) | 0.5 | 2.0 | 0.5 | 0 | 不採用 |
| 2608.25559 | AdaVDR: adaptive tool use for video deep research | 0.5 | 1.5 | 1.0 | 0 | 不採用 |
| 2608.25601 | Dual-Transformer for Multi-Camera View Recommendation | 1.0 | 1.0 | 1.0 | 0 | 不採用 |
| 2608.25579 | Chinese metaphor identification: prompting vs fine-tuning | 0.5 | 1.5 | 0.5 | 0 | 不採用 |
| 2608.25539 | CropCop: auditable 120-class plant-health model | 0.5 | 1.5 | 0.5 | 0 | 不採用 |
| 2608.25934 | Robustness of automated fact-checking systems | 0.5 | 1.0 | 0.5 | 0 | 不採用 |
| 2608.25738 | MeMark: watermarking for spiking neural networks | 0.5 | 1.0 | 0.5 | 0 | 不採用 |
| 2608.25862 | Timestep-decoupled guidance for fair face generation | 0.5 | 1.0 | 0.5 | 0 | 不採用 |
| 2608.26090 | Interpretable latents in a neutrino foundation model | 0.5 | 1.0 | 0.5 | 0 | 不採用 |
| 2608.26060 | Fine-Tuning Whisper for Baniwa ASR | 0.5 | 1.0 | 0.5 | 0 | 不採用 |
| 2608.25866 | LUTSeg: ulcer tissue segmentation dataset | 0.5 | 0.5 | 0.5 | 0 | 不採用 |
| 2608.25845 | THA-Flow: prosthesis geometry from preoperative CT | 0.5 | 0.5 | 0.5 | 0 | 不採用 |
| 2608.25693 | Anatomical feature learning via diffusion models | 0.5 | 0.5 | 0.5 | 0 | 不採用 |
| 2608.25648 | MAMA-FLUX.2: breast DCE-MRI synthesis | 0.5 | 0.5 | 0.5 | 0 | 不採用 |

### 惜しい不採用 3 本

- **2608.25810 (Label-Free Foundation Model Selection)** — **今日の P2 で 3 番目。問いが実務そのものである — 「候補となる基盤モデルが複数あり、source ドメインにはラベルがあるが、実際に配備する target ドメインにはラベルが無い。どれを選ぶか。」**
  提案は **AURCC** という指標で、**target の未ラベルデータを予測確率で区切り、各区間で pseudo-label (モデル自身の予測を仮のラベルとして使うこと) の食い違いを測って、クラス混入の度合いを見る。**target のラベルも fine-tuning も要らない。6 つの vision-language model を胸部 X 線で 3 通りの施設間分布シフトにわたって順位付けし、**真の順位との Spearman 相関が最大 0.943。**
  **特筆すべきは、素朴な基準線 (source の hold-out 精度で順位付けする) との勝敗が条件依存だと正直に書いていること** — **source のラベルが大量にあるときは互角、少ないときに AURCC が勝つ。**「常に勝つ」と言わない論文は信用できる。
  **落とした理由は quota と、医療画像という検証領域。**ただし **P2 の「他ドメインへの適合」において、適合の前に来る「どれを適合させるか」の段階を扱う唯一の候補であり、この段階を扱った論文は今週初めてである。**手法自体は領域非依存なので、**拾い直す価値は高い。**
- **2608.25756 (TailSFT)** — **SFT (Supervised Fine-Tuning) の段階で「もう十分に当てられるようになった系列」を学習から外し、まだ模倣できていない裾の分布に学習を集中させる。**OLMo-3 7B で pass@16 が最大 17 ポイント改善し、**その checkpoint から GRPO (Group Relative Policy Optimization; PPO を簡略化した、LLM の強化学習で広く使われる手法) を回すと pass@1 が最大 4 ポイント改善する。**
  **主張の骨格が P2 に効く — 「中間 checkpoint を、それ自身の性能ではなく、次の段階の学習をどれだけ支えるかで評価せよ」。**蒸留を多段で回すときの評価観点そのものである。
  **落としたのは、貢献の中心が RL 事前の SFT にあり、topics.yaml の蒸留・適合の軸からはやや外れること。**ただし **「効きそうな設定を事前に見分ける軽量な診断」を用意している点は、本日の LM-X の pretraining gate と同じ思想である。**
- **2608.25927 (Code World Model, hf 14) — topic の誤配である。**
  `fm_distill_finetune` に分類されているが、**中身は world model であり、正しくは next_arch に属する。**内容は、**world の状態遷移を映像モデルに学習させるのをやめて、コーディングエージェントが実行可能なコードとして状態と規則を保持し、映像モデルはその可視化だけを担当する**という分業。**中間に proxy representation (フレームごとの時空間的な制約を符号化した表現) を置き、それを proxy video にコンパイルして映像モデルを条件付ける。**
  **R3 にとって重要なのは、これが「世界の状態を、モデルの中の潜在ではなく、外の読み書きできるコードとして持つ」という設計点だからである。**08-26 の Gen2Sim から出た論点 (world model の状態を外から読めない) に対する、最も極端な回答になっている。
  **落としたのは fm_distill_finetune の quota を、P2 に本当に効く 2 本が埋めていたためで、topic が正しければ next_arch で競っていた。**キーワード分類が topic を跨ぐ論文を取りこぼす、という **fetch 側の欠陥の実例として記録する (欠陥 #4 の累計 10 例目)。**

### まとめて落とした群

- **医療画像 6 件** (2608.25866 / 2608.25845 / 2608.25693 / 2608.25648 / 2608.25810 の一部文脈 / 2608.26090 の隣接) — **手法として汎用のものもあるが、検証が医療画像に閉じており、追っているプロジェクトへの移植可能性を abstract から判断できない。**2608.25810 だけは手法が領域非依存なので上で個別に扱った。
- **特定言語・特定ドメインの fine-tuning 報告 5 件** (2608.26060 Baniwa ASR / 2608.25768 Turkish encoder / 2608.25579 Chinese metaphor / 2608.25190 Bangla / 2608.25539 plant health) — **`fine-tuning` に一致しただけで、recipe としての一般化可能な知見が abstract に書かれていない。**
- **安全性・公平性・透かし 5 件** (2608.25851 / 2608.25862 / 2608.25707 / 2608.25738 / 2608.25605) — **topics.yaml のどの relevance_criteria にも該当しない。**
- **2608.25941 (Pruning × SAE)** — 落としたが**事実として 1 つ持ち帰る価値がある: 全ての pruning 手法に共通して、中間層が最初と最後の層より有意に敏感である。**そこから層ごとに sparsity を配分すると、同じ平均圧縮率で perplexity が下がる。**model compression は topics.yaml のキーワードに含まれており、P2 に 3.5。**quota が理由の不採用。
- **2608.25935 (TAU-Agent)** — **交通映像の異常を検出・説明するエージェント。**運転ドメインなので P1 に 2.0 を付けたが、**中身はコンペ (AI City Challenge 2026) 向けのツール統合パイプラインであり、planner にも評価指標にも新規の知見がない。**
- **2608.25580 (V-Rubrics, hf 12)** — **報酬をスカラーではなく rubric (答えを原子的な命題に分解し、視覚的忠実性・推論の一貫性・指示追従の 3 観点で採点する評価票) にする。**「スカラー報酬では、どの視覚的事実が根拠を欠いていたのかを特定できない」という credit assignment の診断は鋭い。**落としたのは対象が VLM の後学習であり、蒸留・適合の軸から外れるため。**ただし **「部分点を構造化して与える」という発想は蒸留の教師信号設計にも移せる**ので、R2 が loss の設計に入る段階で拾い直す。

---

## sns_wildcard (最大 1 件 / 候補 3 / 採用 1)

| id | タイトル | hf | 採否 |
|---|---|---|---|
| [2608.26005](2608.26005.md) | VoiceMem: Streaming Dual-Brain Memory | 144 | **採用** |
| 2608.23283 | Apodex 1.1: Scaling Agentic Intelligence | 194 | 不採用 (**重複 — 3 回目の提示**) |
| 2608.19583 | VGI-BENCH: Probing Visual Intelligence in Video Gen | 127 | 不採用 (**重複 — 2 回目の提示**) |

- **2608.23283 (Apodex 1.1, hf 194) — 08-26 に採用してブリーフ済み ([briefs/2026-08-26/2608.23283.md](../2026-08-26/2608.23283.md))。08-27 に重複として不採用、本日で 3 回目の提示である。**
  **memory に「欠陥 #2 (dedup) は 08-27 に再発を確認」と記録済みだが、これで再発は 2 日連続となった。**`fetch_candidates.py` が過去の briefs ディレクトリを参照していないことが原因と考えられる。**hf_upvotes 上位を毎日そのまま拾う wildcard 枠は、話題の論文が数日間上位に留まる性質上、重複が構造的に起きる。**修正順序としては memory 記載の通り `lookback_days` が先だが、**wildcard 枠は本流と違って母数が 3 件しかないため、重複 2 件で枠が実質 1 件に潰れる。影響は本流より大きい。**
- **2608.19583 (VGI-BENCH, hf 127) — 08-22 に不採用として記録済み ([briefs/2026-08-22/rejected.md](../2026-08-22/rejected.md))。公開は 08-19 で、本日時点で 9 日前の論文である。**
  **`lookback_days: 2` の設定に対して 9 日前の論文が出てくるのは、wildcard 枠だけが別経路 (hf のランキング) で取得されているためと思われる。**本流と wildcard で新着判定の基準が違う、という設計上の不整合。
  内容自体は**映像生成モデルに視覚的推論能力があるかを 27 タスク 810 事例で測るベンチマークで、最強の Seedance 2.0 でも 51.0%。**「後段の denoising step は初期の仮説を精緻化するだけで、推論の誤りを訂正しない」という分析は world model の評価に効くが、**08-22 に判断済みのため再評価しない。**

---

## 本日の fetch 側の所見 (memory 更新用)

1. **`lookback_days: 2` の影響が予告通り出た。** planner_ai が 5 → 2 件。**08-27 の DIGEST で「今週末に本流ゼロが再発する」と予測した通りの推移で、修正 (5 分) は依然として未実施。**
2. **欠陥 #2 (dedup) が 2 日連続で再発。** Apodex が 3 回目、VGI-BENCH が 2 回目。**wildcard 枠 3 件中 2 件が重複という、これまでで最も重い日。**
3. **欠陥 #4 (topic 誤配) の累計 10 例目 — Code World Model (2608.25927)。**world model の論文が `fm_distill_finetune` に入った。**キーワード一致だけで topic を決めているため、複数トピックに跨る論文が本来の quota 枠で競えない。**
4. **wildcard 枠の取得経路が本流と非同期である (新規観測)。**9 日前の論文が「新着」として出てくる。**`lookback_days` が wildcard に適用されていない可能性が高い。**
