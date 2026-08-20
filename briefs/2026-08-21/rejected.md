# 落選候補 — 2026-08-21

候補 **41 件**、採用 **6 件** (max_deep_per_day の上限ちょうど)、**落選 35 件。**

> **本日の性格: 「world model を意思決定にどう繋ぐか」という 1 つの問いに、独立した 3 本が同じ日に着地した日。** **next_arch は候補が 16 件 → 7 件に減ったのに、4.5 以上が 3 本ある。密度が上がった。** **一方 planner_ai は候補 1 件で、しかも自動運転ですらない (ロボット組立)。本枠は本日 0 件である。** **fm_distill は 3 日連続で「30 件中 in-field は 2 割」を記録した。**

---

## 選別と quota の数え方

| topic | 候補数 | quota | 採用 | 備考 |
|---|---|---|---|---|
| planner_ai (P1) | 1 | 2 | **1** | **本枠の候補 1 件は relevance 2.0 で不採用。採用 1 件は next_arch から振り替えた [DA-WAM](2608.19085.md) (下記)** |
| fm_distill_finetune (P2) | 30 | 2 | **2** | **30 件中、P1/P2/P3 に接続するのは 6〜7 件 (欠陥 #5 が 3 日連続で同値)** |
| next_arch (P3) | 7 | 2 | **2** | **候補は半減したのに 4.5 が 3 本。quota で 4.5 が 1 本、4.0 が 2 本落ちた。本日最も惜しい枠** |
| sns_wildcard (探索枠) | 3 | 1 | **1** | **3 件中 1 件が既処理の再放送 (欠陥 #2 が 4 日連続)。残り 2 件から 1 件採用** |
| **計** | **41** | — | **6** (max_deep_per_day = 6) | |

### 本日の枠の埋まり方には、記録すべき事情がある

**まず、[DA-WAM](2608.19085.md) を planner_ai の枠として数えた。** fetch は `world model` というキーワードで next_arch に入れたが、**中身は NAVSIM 上で軌道候補を採点して選ぶ自動運転 planner そのもの**であり、planner_ai の relevance_criteria (プランナー実装・評価指標に直接使えるか) を next_arch の criteria より直接的に満たす。**欠陥 #4 (トピック取り違え) の 3 例目として記録する。**

**この振り替えの結果、採用は 5 本ではなく 6 本になった。** 振り替えなければ next_arch は DA-WAM と Decision-Metric Alignment で埋まり、[RP1](2608.18669.md) は quota 落ちしていた。**判断が誤りなら、本日の正しい採用数は 5 本である。** 判断の根拠を上に書いたので、後から覆せるようにしておく。

**次に、6 枠目は wildcard でしか埋まらなかった。** planner_ai の残り 1 枠は候補が尽きており (本枠の唯一の候補は 2.0)、fm_distill と next_arch は quota 2 で塞がっている。**つまり本日の wildcard は「in-field の 4.0 を押しのけた」のではなく、「他に埋める手段がない枠に入った」。** **08-20 に wildcard を 0 件にした判断 (in-field 4.0 を押しのける水準にない) と矛盾しない** —— 08-20 は in-field と競合していたが、本日は競合していない。**quota の形が、この差を作っている。**

---

## quota で落ちた最有力 3 本 —— 内容の問題ではないので別扱いで記録する

### 2608.18433: The Embodiment Gap in Robot Foundation Models **relevance 4.0 / 5。落選理由は「next_arch の quota 2 を 4.5 の 2 本が埋めたため」。**

**ロボット基盤モデル (VLA を含む) を「スケールすれば汎化する」という視点ではなく、「汎化しても、特定の機体で動かすまでにはまだ作業が残る」という視点で整理した survey。** **その残作業を embodiment gap と名付け、① 何が機体をまたいで再利用できるか、② 新しい機体で何を実装し直す必要があるか、の 2 点で既存手法を 2 軸のマップに配置する。** 軸は **「共有される構造の種類」×「適応が必要になる段階」。** **さらに、成功率だけでは見えない適応コストを報告するための reporting framework を提案している。**

**なぜ惜しいか。R3 の次のアクションは「既存統合手法の分類マップ作成」であり、本論文はまさにそのマップを 1 つ提供している。** **加えて本日採用した [GS-VLA](2608.19066.md) は、この gap のうち観測側の 1 成分 (カメラ視点) について「ほぼ吸収できる」という解を出している。** **survey が分解を与え、実装論文が 1 成分を埋める、という対応が本日成立している。** **そして W34 課題カード2 (建設 retrofit —— 油圧特性の異なる複数メーカーの掘削機に 1 つの方策を載せる) は、この survey の語彙で書くべき問題である。**

**次に P3 の枠が空いた日、最優先で拾い直す。** 特に **reporting framework は R1 の関心 (何を報告すべきか) と直結**しており、P3 ではなく P1 側の材料として読む価値もある。

### 2608.18410: Role-Conditioned Sub-Token Routing for Efficient Vision-Language-Action Policies (RoleSub) **relevance 4.0 / 5。落選理由は同上。**

**VLA の推論コストを、トークンを捨てる (token pruning) のではなく、残したトークンの値の幅を狭める (sub-token compression) 方向で削る。** **理由付けが良い: トークンを消すとその表現が丸ごと消えるので、強い圧縮では脆くなる。** **RoleSub は残したトークンの value 表現を直交空間でグループに分け、軽量な router がどのグループを残すかを決める。** **判断は ① トークン表現、② 学習された「役割」の潜在表現、③ 言語文脈の 3 つを条件にする —— 知覚・言語理解・制御で重要な情報の在り処が違う、という観察を設計に落としている。**

**数字: OpenVLA-OFT-7B・LIBERO 4 suite で、同一の visual KV 予算下で 36 設定中 33 で対照手法を上回る。視覚と言語の両方を圧縮すると KV 全体が元の 9.2〜11.3% になる。**

**P2 の観点で惜しい。これは「モデルを小さくする」ではなく「実行時の表現を小さくする」圧縮であり、R2 が扱う capacity gap とは別軸の圧縮である。** **蒸留は容量を減らし、RoleSub は帯域を減らす。2 つの軸を分けて整理する材料になる。** **fm_distill の枠が空いた日に拾い直す。**

### 2608.18484: Partition the Support, Reconstruct the Residual (SparsePR) **relevance 3.5 / 5。落選理由は同上。**

**学習不要で video transformer の attention を疎にして高速化する手法。** **「attention が集中しているから疎にできる」で終わらせず、疎化した後に残る誤差を、少数の正確な行を使って事後的にアフィン補正する (probe-fitted residual reconstruction)。** **実行される要素対を 22〜26% に落として 1.48〜2.61 倍の end-to-end 高速化、生成品質は維持。**

**P3 の観点では「world model はどこまで粗くしてよいか」という問いの計算側の答え。** 本日採用した [SemComp-Bench](2608.17426.md) が要求仕様の側から同じ問いを立てており、**2 本を並べると「粗さの上限」を計算と仕様の両側から挟める。** ablation で「効いているのは probe fitting の方」と自分で切り分けている点も作法として良い。

---

## wildcard の在庫状況と、採らなかった 2 件

### 2608.15089: StateM — Terminal-Bench 2.1 で 95.3% / $15 フロンティア実行 — hf 428 — **既処理 (08-20 に落選済み) の再放送。欠陥 #2 が 4 日連続で実害。**

**08-20 の rejected.md に記録済みで、内容の評価も済んでいる。** **本日の hf は 296 → 428 に上がっているが、hf は relevance を上書きしない副次シグナルであり、既に評価を終えた論文の再提示に対しては何の情報も足さない。** **dedup が無いために、本日も探索枠の 3 分の 1 が既知の論文で埋まった。**

### 2608.14036: Demystifying Agent Skills: Why They Work—Until They Don't — hf 152 — **relevance 3.0。新規だが、採った [SemComp-Bench](2608.17426.md) (3.5) に一歩及ばず。ただし教訓を 2 つ持っているので記録する。**

**LLM エージェントに「skill (構造化された知識のパッケージ)」を持たせると成績が上がることは知られているが、いつ・なぜ効き、どこで失敗するかは測られてこなかった。** 本論文は複数のベンチマーク・ハーネス・LLM で統制実験を行い、**8,135 件の試行記録を正規化、240 件の open coding から 238 のラベルを残して、3 カテゴリ・12 の使用モードの分類を作った。**

**記録すべき数字が 2 つある。**

1. **skill が効く主因は「知識の注入」ではなく「手順の固定」だった。** **procedural anchoring (skill が手順の錨になり、ぶれる実行を安定させる働き) が事例の 65.7% を占め、明示的な知識注入は 4.5% にすぎない。** **これは R1 にとって示唆的である —— 外から与えた構造が性能を上げたとき、それが「新しい情報を与えたから」なのか「振る舞いのばらつきを減らしたから」なのかは、区別しないと原因を誤る。** **同じ混同は planner の改善でも起こる。**

2. **検索が別のボトルネックになる。skill の候補プールを 5 件から 100 件に増やすと、実際に使われた skill の適合率が 29.6% から 3.3% に落ちる。** **20 倍のプールで適合率が 9 分の 1 —— 「持っている知識を増やすほど、正しい知識に辿り着けなくなる」。** **本 research loop 自身への警告として読める。ブリーフを 1 日 6 本蓄積し続けることの価値は、週次レビューでの検索が効くかどうかに完全に依存している。** **蓄積は自動で増えるが、検索は自動では良くならない。**

---

## 以下、落選候補の全リスト

### planner_ai (P1) — 1 件

- **2608.18454**: Backward Layout Search for Sequence-Constrained Robotic Assembly — **relevance 2.0。ロボット組立の配置計画であり、自動運転の planner でも評価指標でもない。** 「後の工程の実行可能性は、現在と以降の部品の初期姿勢にのみ依存する」という依存構造を見抜いて探索順を逆転させる着想自体は良いが、**P1 の criteria (自動運転のプランナー実装・評価に直接使えるか) に接続しない。** **なお本枠の候補がこの 1 件のみであることは、08-20 の申し送り 4 (planner_ai のキーワードが 4 語しかない) が悪化した形である。**

### next_arch (P3) — 5 件 (うち 3 件は上記で別扱い)

- **2608.18433**: The Embodiment Gap in Robot Foundation Models — **relevance 4.0 — quota 落ち (上記で別扱い)**
- **2608.18410**: Role-Conditioned Sub-Token Routing for Efficient VLA (RoleSub) — **relevance 4.0 — quota 落ち (上記で別扱い)**
- **2608.18484**: Partition the Support, Reconstruct the Residual (SparsePR) — **relevance 3.5 — quota 落ち (上記で別扱い)**
- **2608.18234**: GigaBrain-WBC-0.5: A Behavior World Model for Robust Whole-Body Control — **relevance 3.5。ヒューマノイドの全身制御に world model を入れ、次の行動・次の状態・次の潜在コマンド分布を同時に予測させる。** **「予測した分布で、実行不可能な指令を検知して学習済みの振る舞いに引き戻す」という使い方は、R1 の introspective uncertainty (自分の能力外を自分で検知する) と同型で興味深い。** **落選理由は quota と、対象がヒューマノイド全身制御で P1/P3 への距離があること。** 実機転移 (Unitree G1 → Maker L01 を簡単な fine-tuning で) の記述は P2 側の材料にもなるので、枠が空けば拾い直す価値はある。

### fm_distill_finetune (P2) — 28 件

**P1/P2/P3 に接続しうるが quota / 相対順位で落ちたもの (5 件):**

- **2608.18590**: FD-CanKD: Frequency-Decoupled Cross-Attention Distillation — **relevance 3.0。検出器の蒸留を予測レベル・関係レベル・周波数レベルの 3 層で行う。** **落選理由は主張の弱さ: COCO の 50 epoch 統制比較で「代表的な baseline と競争的」であり、上回るとは書いていない。** **R2 が欲しいのは「どの条件で破綻するか」であって、複数の整列項を足した手法ではない。**
- **2608.18755**: SED-FOD: Scattering-Aware Expert Decomposition for Few-Shot Cross-Sensor SAR Object Detection — **relevance 3.5。特徴を「共有パス」と「センサ固有の専門家パス」に分解し、共有側だけを domain alignment に使う。** **「ドメイン不変な特徴だけを追うと、検出に有用なセンサ固有の情報まで潰してしまう」という問題設定は、本日採用した [GS-VLA](2608.19066.md) の embodiment gap 分解と同じ構造である。** **落選理由は quota と、対象が SAR (合成開口レーダ) で読み替えのコストが高いこと。** **「共有 + 固有」の分解を機体差に当てる発想だけを持ち帰る。**
- **2608.18647**: Progressive Experience Fusion for Multi-Task World Model Control in Endovascular Navigation — **relevance 3.0。TD-MPC2 (world model ベースの制御手法) を多タスクで訓練し、患者ごとのシミュレーションで fine-tuning して実物のシミュレータへ転移。** **「30 個の血管形状で学習 → 未知 10 個で成功率 90%」と、40k ステップの fine-tuning で実物転移が改善という数字は、P2 の「少データでの適合」に対応する。** **落選理由は quota と、医療応用に特化していること。** 適応的な planning horizon のヒューリスティック (残差の分散で先読み長を変える) は着想として記録。
- **2608.18709**: A Critical Synthesis of Uncertainty Quantification and Foundation Models for Semantic Segmentation — **relevance 3.0。SAM2 の上に軽量デコーダを載せた baseline に対し、UQ 手法 4 種 (MC Dropout / Deep Sub-Ensemble / Test-Time Augmentation / Evidential Deep Learning) を精度・較正・不確実性の質・推論時間で比較。** **R1 の関心 (較正) に触れるが、対象が semantic segmentation であり、かつ conformal prediction が比較対象に入っていない。** **R1 が本当に知りたい「有限サンプルの被覆保証を持つ手法との比較」が欠けているため、材料としては弱い。** ただし **「較正と推論時間のトレードオフ」を並べた表は、R1 が同種の表を作る際の雛形になる。**
- **2608.18825**: Understanding Multilingual Medical ASR Adaptation Through Layer-Wise Analysis — **relevance 3.0。Whisper を医療・多言語に適合させたとき、内部表現が層ごとにどう変わるかを WER の外側で見る。** **二段階適合 (EN → EN+DE) と直接適合 (EN+DE) を比較しており、P2 の「適合の順序」という問いに触れる。** **落選理由は、結論が「設定によって最良モデルが変わる」に留まり、系統則になっていないこと。** **加えて独語側は 86 発話・単一話者という診断規模で、一般化の主張ができない (論文自身がそう書いている点は誠実)。**

**分野外・P1/P2/P3 に接続しないもの (23 件):**

- **2608.18940**: Training Chemical Plausibility-Aware LLMs for Single-Step Retrosynthesis — hf 29 — **relevance 2.0。逆合成解析。Top-K prompting で「一対多の正解」を扱う枠組みは評価設計として興味深いが、化学分野固有。hf は relevance を上書きしない。**
- **2608.18888**: Assessing Quality of Experience in Natural Language Generation of German Text — **独語 NLG の人間中心評価データセット。対象外。**
- **2608.18881**: Falcon Perception-HD: High Density Perception via Reinforcement Learning — **relevance 3.0。SFT の交差エントロピーが precision/recall と噛み合わないので GRPO (Group Relative Policy Optimization; PPO を簡略化した、LLM の RL 学習に使う手法) で直接整列させる。** **「代理目的と評価指標のずれ」という問題設定は R1 と同型だが、対象が open-vocabulary 検出であり、かつ本日の [Decision-Metric Alignment](2608.18746.md) が同じ論点をより一般的な形で扱っている。**
- **2608.18767**: Gradient Mirage: Trainable yet Label-Unidentifiable Gradients in LLM Split Learning — **split learning における勾配からのラベル復元攻撃への防御。プライバシー分野で対象外。**
- **2608.18696**: Impact of Iterative Fine-Tuning on Transcription Accuracy in Complex Historical Sanskrit Manuscripts — **歴史文書 OCR。反復 fine-tuning の応用報告で、系統的な知見ではない。**
- **2608.18689**: Aslema at NADI 2026: Augmentation through Fewshot for SLU — **shared task の参加報告。チュニジア方言の意図認識・スロット埋め。対象外。**
- **2608.18679**: FRAGMENT: Factorized Graph Representations for Document Generation and Editing — **構造化文書を型付き関係グラフとして生成。文書生成分野で対象外。**
- **2608.18655**: TranslatePsy-AfriSLM: High-Quality Data Scaling For Low-Resource Machine Translation — **アフリカ諸語の低資源機械翻訳。データ構築が主。対象外。**
- **2608.18627**: PCQA-R1: Generalized 3D Point Cloud Quality Assessment with RL — **点群の主観品質評価。RL でデータセット横断の汎化を狙う。品質評価分野で対象外。**
- **2608.18622**: PALATE: Personalized Aesthetic Learning for Multi-User Portrait Retouching — **人物写真のレタッチの個人化。ユーザごとにモデルを持たない設計は PEFT 的だが、目的が主観的美的嗜好であり P2 の適合とは問題が違う。**
- **2608.18597**: Off-Manifold Collapse in Guided Protein Language Models — **relevance 2.5。タンパク質言語モデルを推論時に誘導すると、活性化が「ランダム入力と統計的に区別できない領域」に落ちるのに、最適化対象の oracle はそれを成功と採点してしまう。** **「最適化している指標が、崩壊を目撃できない」という構造は R1 の関心と同型で、その一点だけは記憶する価値がある。** 分野はタンパク質設計で対象外。
- **2608.18575**: Beyond LLM-Based Reasoning: Lightweight GNNs for Agent Failure Attribution — **マルチエージェントの失敗をどのエージェントのどの誤りに帰属させるか。LLM ではなく軽量 GNN で解く。** 失敗の帰属という問題設定は本日の [RP1](2608.18669.md) の留保 (world model の誤りか探索器の誤りか切り分けられない) と響き合うが、対象が LLM エージェント系で直接の接続はない。
- **2608.18573**: PATE-Forensics: Perception-as-Tool for Explainable Deepfake Forensics — **深層偽造検出。検出・位置特定と説明生成を構造的に分離する設計は「指標を畳まない」思想と近いが、分野が対象外。**
- **2608.18544**: Zero-Shot SAM2 Segmentation and ViT-Based Recognition of Elamite Cuneiform — **楔形文字の認識。対象外。**
- **2608.18539**: Evaluating and Explaining Prompt Sensitivity of LLMs Using Interactions — **プロンプトの微細な変化で性能が振れる現象を、最終出力の比較ではなく内部の相互作用で説明する。** 「変わらなかったことを頑健性と読まない」という 08-20 の教訓と近縁だが、対象が LLM のプロンプト感度で P1/P2/P3 に接続しない。
- **2608.18531**: Pairwise Ranking Outperforms Single-Action RL for Offline Explanation Selection — **推薦の説明文を事前生成して小さな選択器で選ぶ、という実務報告。「生成と選択を分ける」構成自体は本日の主題と形が似ているが、対象が推薦システムの運用コストで対象外。**
- **2608.18521**: Which Negatives Matter? Ask Your Text Encoder (HN-CLIP) — **relevance 2.5。dense caption の対照学習で InfoNCE が早期飽和する (最初の 1 epoch で 80% のバッチで損失が 10^-3 未満、47% の測定で fp32 の勾配が厳密にゼロ) という診断が具体的で良い。** **「損失が下がりきっているのに学習すべきことが残っている」は蒸留でも起こりうる現象なので、診断の作法だけ記録する。** 手法自体は検索タスク特化で対象外。
- **2608.18474**: OmniAlign: A Unified Multilingual Aligner for Word and Sentence Alignment — **多言語の単語・文アラインメント。対象外。**
- **2608.18438**: Pedagogical AI in Mental Health: A Tri-Stream Fine-Tuned LLM Framework — **臨床スーパービジョンの自動化。応用特化で対象外。**
- **2608.18361**: Figurative and Cultural Knowledge in LLMs: Cross-Domain Transfer through Fine-Tuning — **relevance 2.5。文化データでの fine-tuning が比喩理解を改善するか (逆も) を 4 モデル・6 データセットで系統的に調べる。** **「ある領域の fine-tuning が別の領域に転移するか」を格子で測る設計は R2 の実験設計として参考になるが、対象がアラビア語の比喩・文化知識で P2 に接続しない。**
- **2608.18303**: SESSE: LLM-as-Judge Evaluation via Structured Decomposition — **relevance 3.0。LLM 審判の A/B 総合判定を、判定基準から自動で掘り出した下位質問に分解する (学習不要)。** **本日採用した [SemComp-Bench](2608.17426.md) と完全に同じ構造の主張が、同じ日に別分野から出ている —— 「総合判定を分解せよ」。** **落選理由は fm_distill の quota と、対象が LLM 出力評価であること。** **だが「同日に独立 2 本」という事実は DIGEST に記録する価値があるので、そちらに書いた。**
- **2608.18274**: Model Card for OpenAI Privacy Filter — **PII 検出・秘匿の小型分類モデルのモデルカード。** 自己回帰チェックポイントを双方向の帯状 attention 分類器に変換するという構成は技術的に面白いが、**モデルカードであり研究論文ではない。**
- **2608.18242**: ClosureBench: A Constructive Benchmark for Compositional Graph Reasoning — **relevance 2.5。テストセットを固定せず、正解をプログラム実行で機械検証しながら問題を都度生成する。** **「データ汚染に強いベンチマーク」という設計思想は R1 が評価プロトコルを書くときの参考になる (正解が構成的に検証可能なら、審判は要らない)。** 対象はグラフ推論で P1/P2/P3 に接続しない。

### sns_wildcard (探索枠) — 2 件

- **2608.15089**: StateM — hf 428 — **既処理の再放送 (上記で別扱い)**
- **2608.14036**: Demystifying Agent Skills — hf 152 — **relevance 3.0、僅差で落選 (上記で別扱い。教訓 2 件を記録済み)**

---

## 本日の欠陥観測 (fetch_candidates.py への申し送りは DIGEST に集約)

- **欠陥 #2 (wildcard に dedup が無い): 4 日連続で実害。** 本日は 3 件中 1 件が 08-20 に落選済みの再放送。**08-18 以降の 4 日間で、探索枠が供給した新規候補は実質 3 件である。**
- **欠陥 #5 (キーワードが汎用語すぎる): 3 日連続でほぼ同値。** **fm_distill_finetune は 30 件中 in-field 6〜7 件 (20〜23%)。08-19 は 20%、08-20 は 21%。** **3 日連続で 2 割なら、これは変動ではなくキーワード設計の定常状態である。**
- **planner_ai の候補が 1 件、かつ自動運転ですらない。** 08-20 は 2 件、本日は 1 件。**枯渇が進行している。** キーワード 4 語のうち "motion planning" と "trajectory prediction" が汎用語なので、**ロボットアーム・組立系を拾って自動運転を拾えていない。** 追加候補語: closed-loop evaluation / driving benchmark / scenario generation / NAVSIM / nuPlan。
- **欠陥 #4 (トピック取り違え): 3 例目。** 本日は [DA-WAM](2608.19085.md) が `world model` で next_arch に入ったが、中身は自動運転 planner。**本日は振り替えたので実害はないどころか採用数が増えたが、判断が人手に依存している状態は変わらない。**
- **next_arch の候補が 16 件 → 7 件に半減した。** 内訳は全 7 件が in-field (81% → 100%)。**08-20 に「next_arch は放置してよい」と書いたが、件数が減ったことは別途観測しておく。** 1 日の変動か、fetch 側の問題かは、明日以降の件数で判断する。
