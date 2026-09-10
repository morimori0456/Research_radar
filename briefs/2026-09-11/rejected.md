# 2026-09-11 不採用の候補と、本日の fetch 診断

候補 **49 件** (planner_ai 3 / fm_distill_finetune 30 / next_arch 13 / sns_wildcard 3) / 採用 **5 件** / 不採用 **44 件**。

**上限 6 に対し 5。1 枠を意図的に空けた。**空いたのは **planner_ai の 2 枠**で、**届いた 3 件のいずれもスコア 3.0 に届かなかったため。**枠を埋めるために基準を下げていない。**理由は下の §0 に書く。**

**quota 上の割当: planner_ai 0/2 / fm_distill_finetune 2/2 / next_arch 2/2 / sns_wildcard 1/1。**
**内容による再分類後: P3 2 / P2 2 / wildcard 1。**

> `git log -1 -- topics.yaml fetch_candidates.py` は **`313a283` (2026-07-03)** のまま = **設定は 1 行も変わっていない。修正 4 行・20 分・未実施 19 日目。**

---

## §0 本日の fetch 診断 —— 天井は 2 日連続、そして今日は「窓が 1 日分しかない」

**実測値 (本日 `generated_at` = 2026-09-10T18:00Z、`lookback_days=2` / `max_results=30`):**

| topic | 件数 | 最古の published | 最新の published | 診断 |
|---|---|---|---|---|
| planner_ai | **3** | 09-09T07:46Z | 09-09T14:15Z | **天井に当たっていない。キーワードで飢えている** |
| fm_distill_finetune | **30** | 09-09T06:12Z | 09-09T17:53Z | **ちょうど 30 = `max_results` の天井。2 日連続** |
| next_arch | 13 | 09-08T23:15Z | 09-09T17:59Z | 天井に当たっていない |
| sns_wildcard | 3 | 09-02T20:00Z | 09-07T20:00Z | 別経路 (HF Daily Papers) |

**① 天井は 2 日連続で当たった。**`fm_distill_finetune` は 09-10 に続き本日もちょうど 30 件。**しかも本日は返った 30 件が全部 09-09 の 1 日分に収まっている** (最古 09-09T06:12Z は cutoff の 09-08T18:00Z より新しい)。**`lookback_days` はこのトピックでは 2 日連続で一度も効いていない。切っているのは件数上限だけである。**

**② 09-10 に確定した「2 つは独立でない」という数値は、本日の実測とも整合している。**
`lookback_days:2→5` と `max_results:30→100` は互いの効果を隠す (09-10 実測: 現行 42 / lb だけ 67 / mr だけ 45 / **両方 150**)。**片方だけ入れて「効かなかった」と判定してはいけない。**本日のデータはこの構図をもう一度示している —— **fm_distill は mr を上げないと窓を広げても伸びず、next_arch と planner_ai は mr を上げても窓を広げないと伸びない。**

**③ 本日いちばん重い所見: planner_ai が 3 件で、しかも全部 09-09 の 1 日分。**
**天井 (30) には遠く及ばないので、これは件数上限の問題ではない。keyword が拾えていない。**09-10 には **PlannerForge (自動運転 motion planner のテストの論文) が `fm_distill_finetune` に落ちていた**という実物の証拠が出ている。**修正③ (planner_ai の keyword 追加) は ① と独立で、単独で効く。**

> **そして本日、その帰結が初めて「枠が埋まらない」という形で表に出た。**09-06 (2 件) や 09-07/08 (0 件) は候補総数そのものが少なかったが、**本日は候補 49 件と豊作でありながら、P1 の枠だけが埋まらなかった。**入力の量ではなく、**入力の宛先が間違っている**ことが露出した形である。

**④ 欠陥#2 (dedup) は 6 回目の実測。**`sns_wildcard` 3 件のうち **1 件 ([2609.04010](../2026-09-09/2609.04010.md)) が 09-09 に読んだばかりの論文の再配信。**wildcard 枠の 1/3 が消えた。**原因は `briefs/*/*.md` の既存ファイル名を見ていないこと。修正は 3 行。**

**修正順序 (09-10 から変更なし):**
1. **`lookback_days:2→5` と `max_results:30→100` を同時に。**片方だけは不可。
2. **dedup** —— `briefs/*/*.md` の basename を除外集合にする (3 行)。
3. **planner_ai の keyword 追加** —— ① と独立、単独で効く。**本日の「枠が埋まらない」がこの修正の直接の証拠である。**
4. **wildcard の cutoff は必ず最後、かつ緩い窓 (21 日) を別に。**

---

## §1 planner_ai (3 件中 0 件採用)

**本流 P1 の枠を 2 つ空けた。以下が届いた全部である。**

- `2609.10215`: Adaptive Shared Control with Online Bounded-Rational Human Behavior Estimation — **人間とロボットの共有制御。level-k bounded rationality (相手の思考の深さを k 段でモデル化する枠組み) で人の方策を有限個の候補に落とし、残差で候補分布を推定する。**着想としては「相手の合理性を仮定しすぎない」という R1 と同じ問題意識だが、**対象は control-affine system の共有制御であり、自動運転の planner 評価に持ち込むには距離がありすぎる。**スコア 2.5。**「相手の反応を仮定した版を感度解析に置く」という論点は 09-10 の MamMA で既に拾っており、本論文からの追加分がない。**
- `2609.10050`: Grounding Generated Video Plans in Simulation Towards Versatile Dexterous Controllers — **生成映像を運動の参照として使い、シミュレータ内の HOI (hand-object interaction) tracker で実行可能な制御に落とす。**手先操作の話で、**"motion planning" の語で拾われただけ。**P1 との接点なし。スコア 1.5。
- `2609.09840`: TempTPI: Informer-Based trajectory prediction for maritime vessels — **AIS (Automatic Identification System; 船舶の位置を発信する仕組み) データからの船舶軌跡予測に Informer (ProbSparse attention で長系列を安く扱う 2021 年頃の Transformer 変種) を使う。****trajectory prediction ではあるが対象が船舶、手法も既存アーキテクチャの適用で、P1 に新しい知見がない。**スコア 2.0。

## §2 fm_distill_finetune (30 件中 2 件採用)

**採用: [OnPoKD (2609.10321)](2609.10321.md) / [SalamandraTA (2609.09999)](2609.09999.md)。**

**惜しかった 3 件 (スコア 3.5-4.0、quota で落ちた):**

- `2609.10333`: Learning to Adapt and Calibrate: Score Distribution Alignment for Few-Shot Uncertainty Prediction in Medical VLMs — **conformal prediction (予測の外れ率を分布の仮定なしで保証する統計手法) を few-shot 転移で使おうとすると、exchangeability (較正データと試験データが交換可能であるという仮定) と十分な較正データ量の 2 つが崩れる、という問題設定。****supervised fine-tuning がモデルを動かすと nonconformity score の分布がずれる**という指摘は P2 に効く。**スコア 4.0 で、quota 2 の 3 番手。**次点として明示的に記録する —— **「適合させたら不確実性の保証が壊れる」は P2 で必ず踏む地雷である。**
- `2609.09863`: Pretraining and Distillation Matter More Than Architecture Family for Label-Free Single-Cell Classification — **顕微鏡画像で CNN vs Transformer の結論が割れている件を、source-image-disjoint split (同じ親画像由来のパッチが train/test に跨らない分割) で統制して検証。****CNN 優位とされてきたものは大半が pretraining の差で説明できた**という結論。**「アーキテクチャ族より pretraining と distillation が効く」は P2 の優先順位付けを支持する良い証拠だが、ドメインが単一細胞顕微鏡で、スコア 3.5。**
- `2609.10522`: Show-Harness: Just a VLM Agent Can Play Robots (**up=82、本日の本流最多**) — **VLM に離散的な semantic action unit を提示し、embodiment ごとの interpreter が決定的にロボット動作へ落とす。closed-source の frontier VLM を zero-shot でロボット制御に使える。****中身は P3 (VLA の代替設計) の論文で、`fm_distill_finetune` に入っているのは分類ミス。**fm_distill の基準 (蒸留 recipe / loss / capacity gap) では 3.0。**upvote 82 は同点タイブレークにしか使わない規則なので、ここでは効かせていない。**なお **[Programmable World Model](2609.10540.md) と設計思想が同じ** (生成モデルの上に決定的な interpreter を挟む) ので、採用済みブリーフで論点は回収できている。

**明確に対象外 (25 件) —— 落とした理由付き:**

- `2609.10395`: Rosetta at AlexandriaX-2026 (LoRA-Adapted NileChat, アラビア語方言翻訳) — shared task の system report。**LoRA という語で拾われただけで、方言翻訳固有。**
- `2609.10366`: AVSRBench (音声視覚音声認識のマルチ条件ベンチマーク) — **「LRS3 での sub-1% WER は真の汎化か domain adaptation か」という問題意識は良いが、対象が AVSR。**
- `2609.10363`: SceneHI (3D シーンのテクスチャ生成) — **"without model fine-tuning" の語で拾われた誤検出。**
- `2609.10315`: TRACE (因果探索エージェントを合成報酬で訓練) — シミュレータに介入を注入して oracle label を作る発想は面白いが、**診断推論のドメインで P1/P2/P3 いずれとも接点なし。**
- `2609.10311`: One Loop, Two Gains (active learning と lottery ticket の反復訓練ループを共有) — **計算量削減の話。蒸留にも適合にも直結しない。**
- `2609.10305`: RiLM (Riemannian 多様体上の測地距離でデコードし出力行列を消す) — **100 万パラメータ未満の言語モデルの話で、規模が P2 の関心と合わない。**
- `2609.10244`: Two-Token Features and Small-Large Ensembles (VLM hallucination 検出の shared task) — 順位報告中心。
- `2609.10192`: Who Argues What? (政治討論の argument mining) — 分野外。
- `2609.10155`: From Retrieval to Weights (個人のテキスト履歴を DoRA adapter に書き込む認知シミュレーション) — **DoRA の語で拾われた。目的が認知科学。**
- `2609.10142`: Active Adaptation, Not Static Defense (悪意ある fine-tuning への preventative steering の時間動態) — **安全性研究。P2 の適合とは目的が逆向き。**
- `2609.10113`: Data-Centric Post-Training for Financial Reasoning — **データ構築パイプラインの構成は SalamandraTA と一部重なるが、金融ドメイン固有で controlled study がない。採用した [SalamandraTA](2609.09999.md) の下位互換。**
- `2609.10092`: RAP (LLM が研究動向の変化を予測できるかのベンチマーク) — **全診断モデルが EWMA ベースラインに負けたという結果は面白いが、P1/P2/P3 と無関係。**
- `2609.10022`: Deterministic Prompting for Low-Resource Greek TTS — **speaker LoRA の語で拾われた。TTS 固有。**
- `2609.10016`: MetroLLM-Bench (LLM を交通券売機の政策層として評価) — 分野外。
- `2609.09984`: Multi-Functional Embedding Models for Funder Name Disambiguation — 分野外。
- `2609.09974`: Filipino G2P with Weakly-Supervised ByT5 Fine-Tuning — **fine-tuning の語で拾われた。**
- `2609.09971`: sEMG からの手指意図デコード (脳卒中リハビリ) — 分野外。
- `2609.09964`: 5-Dialects-BN (ベンガル語方言ベンチマーク) — 分野外。
- `2609.09953`: SALT (多言語文エンコーダの token 表現改善) — **post-training 手法だが対象が cross-lingual token 表現。**
- `2609.09949`: Vague2Detect (曖昧なプロンプトでの open-world 物体検出) — **YOLO-World + KB 検索のハイブリッド。工学的だが新規性が薄い。**
- `2609.09920`: 胸部 X 線から CT を合成 — **DRR と実 X 線の domain gap を扱う点は "domain adaptation" だが医療画像固有。**
- `2609.09905`: FlowCPO (flow model の選好整合を divergence の観点で統一) — **offline forward-KL の目的関数は理論的に綺麗だが、対象が画像生成の preference alignment。**
- `2609.09901`: Deep and shallow biases in language models — **バイアスの深さを測る指標。P2 と無関係。**
- `2609.09794`: Privacy-Preserving Split Learning for Federated LLM Fine-Tuning — **プライバシ制約下の分散学習。P2 の制約条件に該当しない。**
- `2609.09768`: Fine-Tuning a KV Cache Concatenation-Aware Model or Recomputing KV Caches? — **RAG の TTFT (Time-To-First-Token; 最初のトークンが出るまでの時間) 短縮。推論最適化であって適合ではない。**

## §3 next_arch (13 件中 2 件採用)

**採用: [DRiF (2609.10377)](2609.10377.md) / [Programmable World Model (2609.10540)](2609.10540.md)。**

**惜しかった 2 件 —— ここが本日いちばん判断が割れた場所:**

- `2609.09528`: MotionBlind: Probing the Illusion of Motion Understanding in Video-LLMs — **Video-LLM は「どちらのクリップが速いか」に答えられない、という反証ベンチマーク。**同じ人物・同じ部屋で運動だけが違う near-identical なクリップ対を作り、速度・大きさ・方向を問う。**Video-LLM を world model の知覚前段に置く設計が広まっている中で、その前提を直接壊しにいく論文で、スコアは 4.0。****[Programmable World Model](2609.10540.md) と同点になり、規則どおり hf_upvotes (0 vs 59) でタイブレークして落ちた。**
  > **これは規則に従った結果だが、記録しておく価値がある —— タイブレークが「注目度ゼロの反証論文」を「注目度の高い提案論文」に負けさせる方向に働いた。**反証論文は構造的に upvote が付きにくい。**hf_upvotes をタイブレークに使う限り、この偏りは毎回同じ向きに出る。****次に topics.yaml を触るとき、この 1 点も併せて検討すること (「同点時、negative result を優先する」の 1 行で済む)。**
- `2609.09941`: HaWMPO (world model の想像 rollout に含まれる hallucination を検出して policy 最適化に反映) — **long-horizon rollout の予測が破綻したまま policy 学習を誤導する問題**は P3 に効く論点。スコア 3.5。**[Programmable World Model](2609.10540.md) の「状態を生成モデルに任せない」という答えと同じ問題に対する別の答えで、採用済みブリーフと論点が重なるため落とした。**

**その他 (9 件):**

- `2609.10506`: DUET-DINO (側面・手首の 2 視点を同時に条件付ける latent world model) — **7-DoF 制御のための cross-view 条件付け。マニピュレーション固有で、運転の視点構成と対応しない。**スコア 3.0。
- `2609.10464`: Semigroup-JEPA (JEPA world model の物理汎化を重力場を変えて検証) — **JEPA (Joint-Embedding Predictive Architecture; 画素ではなく潜在表現の未来を予測する枠組み) の物理外挿能力という問いは良いが、玩具的な力学タスク。**スコア 3.0。
- `2609.10405`: FreqFM (VLA の action を DCT 周波数座標で flow matching する) — **action chunk の周波数不均一性を明示の条件付け次元に上げる。**着想は良いが**マニピュレーション向けで、運転の action 空間 (低次元・低周波) では効果が出にくい。**スコア 3.0。
- `2609.09925`: Time-Frequency Geometric Cross-Attention for Chunked VLA — **上の FreqFM とほぼ同じ問題 (chunk 内の周波数と位相幾何) を attention 側から解く。同日に 2 本来た時点で、この論点自体は既に飽和気味。**スコア 2.5。
- `2609.10243`: FolDeX (布の長時間操作の実機ベンチマーク) — **異種の物理経験をどう再利用するかという問いは P2 と隣接するが、対象が衣類折り畳み。**
- `2609.10021`: RoboDrop (local gradient compatibility で VLA post-training データを選別) — **勾配の整合性でデータを選ぶ。[SalamandraTA](2609.09999.md) の一般形に近いが、こちらはより重い実装で、しかも VLA 固有。**スコア 3.5。**「サンプルは等価ではない」の 4 本目として、本日の傾向を補強する事実としてだけ記録する。**
- `2609.09808`: GTA-2 (複数 VLM で object-centric な task axis からスキルを合成) — マニピュレーション固有。
- `2609.09776`: Proof-Carrying Cognition (検証器と正解の相関 rho が test-time compute と能力の交換レートになるという理論) — **verifier の健全性が N^(1/rho^2) のペナルティを払うという結果は、評価設計の話として面白い。**だが**対象が LLM の推論で、P1 の planner 評価に直訳できない。**スコア 3.0。
- `2609.09597`: Compact Visuotactile World Models for Lifting — **触覚を足すと力の予測誤差が 1.058N→0.228N。だが「単に前フレームの触覚値を保持する」ベースラインが 0.095N でさらに良いという自己反証を含む。**誠実だが規模が小さい。

## §4 sns_wildcard (3 件中 1 件採用)

**採用: [NeoHorse-1 (2609.08183)](2609.08183.md) (up=384)。**

- `2609.08936`: AuK Technical Report (音声生成・編集の統合基盤モデル、up=198) — **30.3 億の instruction-audio 対と 195 万時間という規模、consistency initialization と task-routed Decoupled DMD による蒸留で 4 step 推論・4.5 倍高速化 —— 蒸留の実例としては立派だが、音声固有の設計が大半で、P2 に持ち帰れる一般則が薄い。**wildcard は最大 1 件で、NeoHorse-1 のほうが転用可能な形をしていた。
- `2609.04010`: Unlocking Lossless Speedups in LLMs via Discrete Diffusion (up=137) — **★ 09-09 に読んだばかりの再配信。→ [briefs/2026-09-09/2609.04010.md](../2026-09-09/2609.04010.md)。****dedup 欠陥の 6 回目の実測。wildcard 3 枠のうち 1 枠がこれで消えた。**
