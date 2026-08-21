# 落選候補 — 2026-08-22

候補 **42 件**、採用 **6 件** (max_deep_per_day の上限ちょうど)、**落選 36 件。**

> **本日の性格: 「中間表現の良さを測る指標が、最終的な判断の良さを保証しない」という同じ穴が、3 つの別分野で同時に見つかった日。**
> **planner の benchmark ([2608.20111](2608.20111.md))、latent action の proxy metric ([2608.19613](2608.19613.md))、そして 08-21 の world model のコスト関数。R1 の問いが、自動運転固有ではないことの証拠が揃った。**
>
> **数字の面での変化を 1 つ。fm_distill の in-field 率が 11/27 = 41% に上がった。08-18〜08-21 の 3 日間は 20-23% で固定されていたので、これは初めての明確な変動である。**
> **一方 wildcard は 3 件中 2 件が既処理の再提示で、新規は 1 件のみ。この欠陥は 5 日連続。**

---

## 選別と quota の数え方

| topic | 候補数 | quota | 採用 | 備考 |
|---|---|---|---|---|
| planner_ai | 6 | 2 | **1** | 2 枠目 (2608.19453) を wildcard に譲った。理由は下記 |
| fm_distill_finetune | 27 | 2 | **2** | うち 1 件は next_arch から再配置 |
| next_arch | 6 | 2 | **2** | うち 1 件は fm_distill から再配置 |
| sns_wildcard | 3 | 1 | **1** | 新規は 1 件のみ (残り 2 件は 08-21 に処理済み) |
| **計** | **42** | — | **6** | max_deep_per_day 6 に対し 6 |

**トピック再配置 (2 件・等価交換)。** fetch のキーワード分類が内容とずれていたため入れ替えた。総数は変えていない。

- `2608.19613` What Matters for Latent Actions: "fine-tuning" に反応して fm_distill に入っていたが、実体は LAM の設計研究 → **next_arch (P3)**
- `2608.19490` Fine-Tuning VLAs with Self-Demonstrated Control: "VLA" に反応して next_arch に入っていたが、実体は「別機体への適合で元の能力を失わない方法」→ **fm_distill_finetune (P2)**

**planner_ai の 2 枠目を空けた判断。** 残った最有力は 2608.19453 (LTLf を stream-based TAMP に載せる、relevance 3.0) だったが、対象は PDDLStream のマニピュレーションで自動運転ではない。一方 wildcard の [EnvHarness](2608.19880.md) は分野こそ LLM agent だが、**設計原理が P1 の closed-loop 評価環境にほぼそのまま移せる** (方策の弱点を診断して環境を合成し、元の verifier は壊さない)。P1 への実効的な寄与で後者が上回ると判断した。**枠の名前ではなく寄与で選んでいる、という点は明示しておく。**

---

## planner_ai (6 件中 5 件落選)

- `2608.20284v1`: Towards Surgical World-Action Modeling — **惜しい 1 件 (relevance 3.0)。** 視覚と器具軌道を同時予測する world-action model で、chunked autoregressive rollout が one-shot 予測を全 horizon で上回る (PSNR 18.86→23.11 dB、ADE 45.77→22.22 px)。**「world model を軌道レベルで評価する」という論点は P1 に効く。**が、著者自身が preliminary と明記し、長 horizon での視覚劣化と誤差蓄積が未解決のまま残っている。手術ドメイン固有の話も多く、[Orthogonal JEPA](2608.20065.md) が同じ論点をより一般的な形で扱っているため見送り。**chunked rollout > one-shot という知見だけは記憶しておく価値がある。**
- `2608.19453v1`: When Automata Meet Streams (SAM-TD) — **relevance 3.0、quota 判断で落選 (上記)。** LTLf (Linear Temporal Logic over finite traces; 有限の実行系列に対して「順序」「不変」「いつか到達」といった時間的制約を書く論理) を stream-based TAMP に初めて載せた。**交通規則を論理式で書いて planner に強制する、という自動運転側の応用が素直に想像できる**ため、planner_ai の候補が薄い日に再提示されたら採るべき。
- `2608.20084v1`: Evidence-Gated TAMP with VLMs (EAFG) — relevance 2.5。VLM が観測の裏付けなしに subgoal を作ってしまう問題に対し、証拠を取りにいく探索 subgoal と feasibility gate (続行 / 追加証拠取得 / 停止 の三択) を入れる。**「確信が持てないなら止まる」を planner に組み込む形は P1 の abstention 設計と同型**で興味深いが、対象は調理タスクのマニピュレーションで、gate の判定自体に保証がない。R1 が求める「保証付きの棄権」とは距離がある。
- `2608.20087v1`: AdaPT / humanoid tennis — relevance 2.0。放送映像からプロのテニス動作を学び、planner (様式的な運動を生成) と tracker (それを実行) の階層構成で Unitree G1・Dobot Atom に載せる。sim-to-real gap を「ランダム化した実行速度を追従できるよう学習する」で埋める部分は工夫だが、P1/P2/P3 のいずれにも移す先がない。
- `2608.19740v1`: Keeping the Franka Emika Panda alive — relevance 0.5。ROS 2 スタックの実装論文。位置制御の不安定性の原因が制御ループのタイミングと sampling jitter にあると特定した点は工学的に誠実だが、研究上の示唆はない。
- (採用: `2608.20111v1`)

---

## fm_distill_finetune (27 件中 25 件落選)

### in-field だが quota・優先度で落ちたもの (9 件)

- `2608.20281v1`: Inject, Align, Recover (IAR) — **最も惜しい 1 件 (relevance 4.0)、hf_upvotes 4 で本 topic 最高。** 文書集合を parametric knowledge に内在化する 3 段構成: Inject (継続・書き換え・指示条件付き再構成の目的関数に変換) → Align (回答のみの QA 教師) → **Recover (ドメイン適応済みモデルを base の instruct モデルと merge して汎用能力を戻す)**。Vanilla SFT に対し domain QA で平均 +3.6 pt、汎用性能で **+12.1 pt**。**「適合させると汎用性が落ちる」に model merging で答えている点が [2608.19490](2608.19490.md) と同じ問題・別解であり、本来は 2 本並べて読みたい。**同点タイブレークで hf_upvotes は IAR に有利だったが、対象が文書 QA でありロボティクス側への移植コストが高いこと、そして 19490 のほうが「別機体への適合」という P2 の一次要求に直撃していることで後者を採った。**明日以降 fm_distill の候補が薄ければ最優先で拾うべき 1 件。**
- `2608.19800v1`: LoRA-GA² — relevance 3.0。LoRA の初期化を multi-step gradient の情報で決める (従来の 1 step 近似を多段化)、spectrum-aware な rank 配分付き。GPU メモリ増加なし。ただし改善幅が GLUE +0.66 / GSM8K +1.03 / HumanEval +0.87 pt と小さく、**LoRA 初期化の改良は既に混雑した領域である。**手元で LoRA を回す段になったら実装だけ借りればよく、ブリーフ 1 ページを割く価値はまだない。
- `2608.19540v1`: Continuous Adversarial MeanFlow Transfer — relevance 3.5。**構成は本日いちばん美しい。**異なるパラメータ化 (ε / x / v / u) の pretrained 拡散・flow モデルを共通の速度表現に写し、ドメイン適応と高速化 (few-step 化) を 1 つの学習ループに統一する。4 つの ImageNet ソースモデル → 5 ドメインで、NFE (Neural Function Evaluation; サンプリング 1 回あたりのモデル呼び出し回数) を最大 125 分の 1 にして teacher の FID を同等以上。**「適合と蒸留を別工程にしない」という発想は R2 に効く。**落とした理由は対象が画像生成モデルに限られ、P2 が実際に扱う知覚・制御系モデルに移すには橋がもう 1 本要るため。
- `2608.19890v1`: Reliable Neural Collapse Approximation (ReNC) — relevance 3.0。open-world TTA (Test-Time Adaptation; 学習後、ラベルなしのテストデータで適応する手法) で、neural collapse (十分学習した分類器の特徴が、クラスごとに 1 点へ収束する現象) を構造的 prior として使い、pretrained 分類器の重みを source prototype とみなして OOD サンプルを弾く。着想は良いが、分類タスク前提で回帰・軌道出力に移せない。
- `2608.19920v1`: Learning how to Forget — relevance 3.0。KV cache の sparse attention 方策と**モデルを共適応させる** fine-tuning 手法。A100 40GB 一枚で回り、exact attention で学習したモデルを上回ることがある。実装 (KeysAndValues, awslabs) が公開されている点も良い。長文脈 LLM 推論の話であり、P2 の現在の射程 (視覚・制御系の適合) から外れるため見送り。**長文脈が要る局面が来たら即座に拾う。**
- `2608.19710v1`: Robust Cross-Modal FM Perception for Underwater Robots — relevance 3.0。凍結 DINOv2 に sonar を融合し、**融合機構だけを劣化の全域で学習する** (encoder は凍結のまま)。極端劣化下で balanced accuracy 0.4610→0.6152 (+33.5%)、sonar の寄与率が 14.2%→41.3% に自動的に増える。**「基盤モデルの表現は有用だが情報が失われた条件下では不十分」を数字で示した点は誠実。**凍結 backbone + 適応的融合という形は [Projector Is All You Train](2608.19726.md) と同じ思想で、そちらのほうが主張が一般的なため代表として 1 本に絞った。
- `2608.19743v1`: Gallileo-4D — relevance 2.5。**負の結果として面白い。**4D 再構成チャレンジで、pretrained backbone の fine-tuning 13 構成のうち **12 が性能を悪化させ**、勾配更新ゼロの frozen ensemble が 27 チーム中 3 位に入った。「fine-tuning が常に正とは限らない」を実証した記録だが、コンペ報告であり方法論的な一般化がない。**この 1 行の教訓だけで十分。**
- `2608.20255v1`: Transfer Learning in Nonparametric Regression with Deep ReLU Networks — relevance 2.5。群共通構造 + 群固有オフセットを仮定した 2 段推定の L2 誤差上界。positive transfer が起きる条件を明示している点は理論として価値があるが、深層 ReLU の理論保証と実務の蒸留 recipe の距離が遠く、R2 の系統則に直接は使えない。
- `2608.20069v1`: V-REX — relevance 2.5。獣医用 X 線に特化した VLM を、**大規模基盤モデルを fine-tuning するのではなくゼロから作って**上回った。tokenization・事前学習・grounding をドメインに合わせて設計し直す方針。「専門特化には巨大 FM の適合が必須」という前提を疑う姿勢は良いが、獣医放射線という単一ドメインの工学報告であり、recipe の一般化が書かれていない。

### 分野外 (16 件)

*P2 の relevance_criteria は「蒸留プロセスを実務で回すのに適用できるか / 他機種・他ドメインへの適合に使えるか」。以下は fine-tuning という語で引っかかっただけで、手法ではなく応用先の報告である。*

- `2608.20334v1`: Swift-Image — 6B の統合画像生成モデル。学習エンジニアリングの押し込みで、手法上の新規性が薄い。
- `2608.20331v1`: G-CARL — 患者向け医療レポート解釈の checklist 型報酬学習。医療コミュニケーション固有。
- `2608.20326v1`: TCPα — 音楽情報検索の post-hoc 信頼度推定。**凍結分類器に軽量ヘッドを後付けして信頼度を出す構図は R1 に遠く関係するが**、対象ドメインが遠すぎる。
- `2608.20315v1`: BERT-LER — 構造化 EHR の臨床予測 + 解釈性。
- `2608.20154v1`: AI-ColoWorkflow — 大腸手術のワークフロー解析、多施設汎化研究。
- `2608.20099v1`: Reward-Guided Autoregressive Graph Generation — LLM マルチエージェントの通信トポロジ設計。
- `2608.20011v1`: Manifold Drift in Flow Preference Optimization — flow matching の選好最適化で reward hacking が起きる原因を manifold からの逸脱として特定。**理屈は綺麗だが生成モデルの alignment 固有。**
- `2608.19957v1`: 1C:Enterprise のコード検索ベンチマーク + bi-encoder。
- `2608.19807v1`: Answer-Level Trust Selection — VLM の物理量推定を「この 1 件の予測を信じてよいか」で選別。**論点は R1 と同型 (個別予測の信頼)** だが、手法が VLM の回答選択に閉じている。
- `2608.19669v1`: Scaffolding Minds — マルチモーダル推論の latent visual target 表現最適化。SFT + RL の 2 段。
- `2608.19666v1`: MUST-PET — 複数トレーサ横断の PET/CT 病変セグメンテーション、自己教師あり。
- `2608.19637v1`: TextRefine — 商品ポスターのテキスト編集 (字形描画・配置)。
- `2608.19583v1`: VGI-BENCH — 動画生成モデルの視覚的知能を測るベンチマーク。08-21 の SemComp-Bench と主題が近く、そちらを既に読んでいる。
- `2608.19567v1`: Block3D — ブロック単位拡散による text-to-3D 高速化。
- `2608.19463v1`: LLM as Detector — 表形式データの異常検知を in-context learning で。
- `2608.19361v1`: Mizo ASR コーパス — 低資源言語 17.62 時間、Whisper と SraVaani の fine-tuning。
- (採用: `2608.19726v1`、`2608.19613v1`→next_arch へ再配置)

---

## next_arch (6 件中 4 件落選)

- `2608.19589v1`: OrthoSkillVLA — **本日いちばん惜しい落選 (relevance 4.0)。** pretrained VLA に新スキルを逐次追加する際の catastrophic forgetting に対し、**VLA の内部で役割の違う部品を区別する**という着眼が良い: VLM 部は広い意味表現を保つので容量枯渇に弱く、ActionHead は意味を局所的な速度パターンに落とすので摂動に敏感。よって直交部分空間の制約を両者に**別々に**かける。出力層は凍結すると表現力のボトルネックになり更新すると過去の速度写像を壊すため、スキルごとに小さな expert を割り当て、学習不要のルータが特徴空間の近さで選ぶ MoE decoder にする。デモの再生 (replay) を要らなくしている点も実務的。**落とした理由は quota のみで、質ではない。**[Orthogonal JEPA](2608.20065.md) と直交部分空間という道具を共有しており、そちらが world model 側という P3 のより中核に位置するため優先した。**明日 next_arch が薄ければ最優先。**
- `2608.19661v1`: World-Model-Grounded LLM Planning for AUV/ASV — relevance 3.0。「LLM が何をするかを決め、world model がどれだけの時間そうするかを決める」という役割分担が明快で、物理接地された neural world model + 3 段の勾配ベース軌道最適化 + trust-region ガード付き MPC 再計画。GazeboSim 移行後も無衝突、目標距離誤差を 70-93% 削減。**LLM の意味理解と物理的実行可能性を分離するという構図は P3 に効く**が、海洋ロボット固有の記述が多く、[2608.20111](2608.20111.md) の survey が world-model-based planner を一段抽象的に整理しているため代表をそちらに譲った。
- `2608.19492v1`: Beyond Multimodal Alignment (DBOSC) — relevance 1.5。「異なるセンサが同じ**実行可能な**意味を運んでいるか」を証明書の形で問う。attribute access / response substitution / fusion closure / ordered execution を別々にテスト可能な達成として分離する枠組みで、主張の分解の仕方は野心的。だが記述が独自用語 (response chart、modality compiler、pre-registered budget) で固められており、投入した読解時間に対する回収が見込めない。**16 チェック中 14 通過という報告の仕方も、何が示されたのかを掴みにくくしている。**
- `2608.19779v1`: An Irreducible Quantum Advantage in Aligning World Models with Reality — relevance 1.0。**理論的には面白い。**真の世界が古典的であっても、有限の古典 world model では最適方策の一致を保証できない世界が構成でき、同じ世界を 1 qutrit の量子モデルが厳密に再現する。「world model の忠実度と方策の一致は別物」という含意は R1 の関心に触れる。しかし量子計算資源を前提とする以上、実務への経路がない。**教養として記憶に留めるだけでよい。**
- (採用: `2608.20065v1`、`2608.19490v1`→fm_distill へ再配置)

---

## sns_wildcard (3 件中 2 件落選 — いずれも重複)

- `2608.14036`: Demystifying Agent Skills (hf 158) — **08-21 に落選済みの再提示。** 判断は変わらない。skill が効くのは知識注入ではなく「procedural anchoring (手順のアンカーとして実行を安定させる働き)」が 65.7% で、retrieval が別のボトルネック (プールが 5→100 で実使用精度 29.6%→3.3%) という知見は良質だが、LLM agent 運用の話で P1/P2/P3 に接続しない。
- `2608.17426`: SemComp-Bench (hf 155) — **08-21 に採用してブリーフ作成済み** ([該当ブリーフ](../2026-08-21/2608.17426.md))。同じ論文が翌日また候補に上がっている。
- (採用: `2608.19880`)

---

## fetch_candidates.py への申し送り

**5 つの欠陥のうち、本日実害が出たものと、状況が変わったものを分けて記録する。**

| # | 欠陥 | 本日の状況 |
|---|---|---|
| 2 | **wildcard の dedup 欠如** | **5 日連続で実害。** 3 件中 2 件が既処理で、探索枠が実質 1 件しか機能していない。過去に処理した id を除外するだけで直る。**原因確定から 7 日、修正ゼロ。** |
| 4 | **トピック誤配** | **4 例目。**本日は 2 件を相互に入れ替えた。08-21 に続き、是正が採用の質を上げている。キーワード一致ではなく abstract を見た分類が要る (特に "fine-tuning" と "VLA" は両 topic に跨る語)。 |
| 5 | fm_distill の in-field 率 | **状況が変わった。** 3 日連続の 20-23% が、本日 **11/27 = 41%** に上がった。3 日間の固定値がキーワード設計の定常状態だという先の見立ては、少なくとも「常に 2 割」ではない。**もう 2-3 日観測して、変動なのか改善なのかを確定させる。** |
| — | planner_ai の候補品質 | 6 件に回復 (08-21 は 1 件)。うち自動運転は 1 件のみで、残りは手術・テニス・調理・Franka。**キーワード 4 語が汎用的すぎてアーム・組立系を拾う問題は未解決。** "autonomous driving" / "closed-loop planner evaluation" を足すべき。 |
