# 2026-08-26 不採用の候補

候補 **49 件** / 採用 **6 件** (= `max_deep_per_day` 上限ちょうど) / 不採用 **43 件**。

**4 日ぶりに本流トピックの候補が戻った日である。**08-23〜08-25 は本流 3 トピックが 3 日連続で 0 件、wildcard のみだった。
本日は planner_ai 1 / fm_distill_finetune 30 / next_arch 15 / sns_wildcard 3。**初めて選別に競争が生じた。**

**したがって以下の「不採用」の大半は、質が低いからではなく quota に入らなかったからである。**
特に fm_distill_finetune は 30 件中 2 件しか採れず、next_arch は 15 件中 2 件しか採れない。

---

## 採否の一覧

### planner_ai (quota 2 / 候補 1 / 採用 1)

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.23486](2608.23486.md) | GeoWAM | **4.5** | 1.0 | **4.5** | 0 | **採用** |

**候補が 1 件しかないため不採用ゼロ。quota 2 に対し 1 件しか埋まらなかった。**
memory に記録済みの `lookback_days` 問題がここに現れている — **P1 だけキーワードが狭く、投稿数が構造的に少ない。**

### fm_distill_finetune (quota 2 / 候補 30 / 採用 2)

| id | タイトル | P2 | hf | 採否 |
|---|---|---|---|---|
| [2608.22854](2608.22854.md) | ADAPT: Amortized Distillation Across Post-Trained LLMs | **4.5** | 0 | **採用** |
| [2608.23153](2608.23153.md) | Conformal Risk Minimization for SSDA via Optimal Transport | **4.0** | 0 | **採用** |
| 2608.23563 | EG-ARSA: Expert-Grounded Open Model for Visual Road Safety Auditing | 3.5 | 0 | 不採用 |
| 2608.23253 | E2S-Pruner: Two-Stage Evidence Fusion for Visual Token Pruning | 3.0 | 0 | 不採用 |
| 2608.22898 | SelFusion: Self-distillation for Diffusion Language Models | 3.0 | 0 | 不採用 |
| 2608.23476 | On the Threat Model of Weird Generalization and Emergent Misalignment | 2.5 | 0 | 不採用 |
| 2608.23338 | The Emergence of Relevance Through Axiomatic Attention Patterns During LoRA Fine-Tuning | 2.5 | 0 | 不採用 |
| 2608.23018 | SplitLite: Low-Rank Residual Compression for Split Learning | 2.5 | 0 | 不採用 |
| 2608.22817 | Industrial-Instruction: Framework for Building Instruction-Tuning Datasets | 2.5 | 3 | 不採用 |
| 2608.23497 | Mitigating Reasoning-Induced Misalignment via Safety-Direction Penalty | 2.0 | 0 | 不採用 |
| 2608.23391 | Cross-Domain, Multi-Task Data-to-Text Generation without In-Domain Training Data | 2.0 | 0 | 不採用 |
| 2608.22996 | ENCORE: Entropy-Guided Cropping and Attention Regularization | 2.0 | 0 | 不採用 |
| 2608.22963 | Buried in Textual Debt: Context Pruning with Visual Evidence Preservation | 2.0 | 0 | 不採用 |
| 2608.23499 | SVD-Based Typicality Maps for OOD Detection in ViTs | 1.5 | 0 | 不採用 |
| 2608.23261 | A Scalable Cross-Domain Event Extraction System | 1.5 | 0 | 不採用 |
| 2608.23235 | Multi-Domain Multi-Task Generative Framework for Cross-Domain Event Extraction | 1.5 | 0 | 不採用 |
| 2608.22950 | WADE: Benchmark for Multi-Instance Floating-Waste Grounding | 1.5 | 0 | 不採用 |
| 2608.22885 | DRAgent: Discriminative Reasoning Agent for Referring Expression Segmentation | 1.5 | 0 | 不採用 |
| 2608.22780 | Can We Perform Online RL for Image Editing without Editing Rewards? | 1.5 | 0 | 不採用 |
| 2608.22631 | Learning Generalizable Behaviors for Terminal Agents | 1.5 | 0 | 不採用 |
| 2608.22622 | Teaching LLMs How ICU Physicians Approach Clinical Reasoning | 1.5 | 0 | 不採用 |
| 2608.23503 | ActPair: Action-Aligned Retrieval for Text-Based Person Anomaly Search | 1.0 | 0 | 不採用 |
| 2608.23248 | Future Querying: Can LLMs Serve as Implicit Medical World Models? | 1.0 | 0 | 不採用 |
| 2608.23234 | MLLM-Assisted Audio VOS (LSVOS Challenge 3rd place report) | 1.0 | 0 | 不採用 |
| 2608.23213 | Bee Detection and Tracking at Hive Entrance using YOLO11 and ByteTrack | 1.0 | 0 | 不採用 |
| 2608.22789 | GuidedFlow: Attention-Guided Anomaly Detection in Additive Manufacturing | 1.0 | 0 | 不採用 |
| 2608.23284 | Dynamic Topic Modeling for Cross-Corpus Temporal Analysis | 0.5 | 0 | 不採用 |
| 2608.23124 | LITERARYBIGFIVE: Author-Personalized Text Generation | 0.5 | 0 | 不採用 |
| 2608.22909 | Exploring Dowker Homology for Sentence Similarity | 0.5 | 0 | 不採用 |
| 2608.22906 | AquaFlow: Monocular Gaussian Splatting SLAM for Underwater Reconstruction | 0.5 | 0 | 不採用 |

### next_arch (quota 2 / 候補 15 / 採用 2)

| id | タイトル | P3 | P1 | hf | 採否 |
|---|---|---|---|---|---|
| [2608.23405](2608.23405.md) | MomADv2: Reliable Temporal Memory for E2E Autonomous Driving | **5.0** | **4.5** | 0 | **採用** |
| [2608.23070](2608.23070.md) | From Generation to Simulation: How Far Are World Models from Being True Simulators? | **4.5** | **4.0** | 2 | **採用** |
| 2608.23478 | Act with Intent: Distilling Behavior Intent for VLA Models | 4.0 | 0 | 0 | 不採用 |
| 2608.23189 | EchoWM: Open and Enterable Omnimodal World Models | 3.5 | 0 | 62 | 不採用 |
| 2608.22869 | UniMem: Unifying Multimodal Memory and Control for VLA Models | 3.5 | 0 | 0 | 不採用 |
| 2608.23224 | TOWN-VLA: Prompt-Authority Control for Selective Slow-Path Intervention | 3.0 | 0 | 0 | 不採用 |
| 2608.23138 | Pointing-VLA: Typed Spatial Grounding Interfaces | 3.0 | 0 | 0 | 不採用 |
| 2608.22990 | InstructMove: A Text-Indispensable Benchmark for Instruction-Following Manipulation | 3.0 | 0 | 0 | 不採用 |
| 2608.22750 | MOSH-WM: Mask-Grounded Soft-Hamiltonian Object-Centric World Models | 3.0 | 0 | 0 | 不採用 |
| 2608.23452 | Reward-Free Continual Adaptation for Resilient Space Robots | 2.5 | 0 | 0 | 不採用 |
| 2608.23320 | ROS2SmolVLA: Small VLA Models for Industrial-Grade Lightweight Robots | 2.5 | 0 | 0 | 不採用 |
| 2608.22800 | Triplet2Track: Hierarchical System for Long-Horizon Manipulation | 2.5 | 0 | 0 | 不採用 |
| 2608.23383 | Long-Horizon Audio-Visual Generation (JoyAI-Echo-1.5) | 2.0 | 0 | 0 | 不採用 |
| 2608.22861 | MGMVFI: Motion-Guided Mamba for Video Frame Interpolation | 2.0 | 0 | 0 | 不採用 |
| 2608.22642 | Mol-JEPA: Multimodal JEPA for Molecules | 1.5 | 0 | 0 | 不採用 |

### sns_wildcard (最大 1 / 候補 3 / 採用 1)

| id | タイトル | hf | 採否 |
|---|---|---|---|
| [2608.23283](2608.23283.md) | Apodex 1.1: Scaling Agentic Intelligence for Complex Work | **167** | **採用** |
| 2608.20958 | TLive-Omni: Omni-Modal Understanding for E-Commerce Live Streaming | 52 | 不採用 |
| 2608.16812 | Unlocking the Potential of Image Editing via Concept Scaling | 45 | 不採用 |

---

## 落とした理由 (個別)

### 惜しかったもの — quota に阻まれた 4 件

- **2608.23478: Act with Intent: Distilling Behavior Intent for VLA Models** — **本日の最有力の次点。**VLA の action decoder が behavior cloning (お手本の行動をそのまま真似る学習) しか使っていないため、「どの motor command を出したか」は学べても「その行動が果たそうとしていた局所目的」が暗黙のまま残る、という問題設定は的確。**Intention Distillation は P2 (蒸留) と P3 (VLA) の交点にあり、topics.yaml の両方の高優先条件を同時に満たす。**落としたのは next_arch quota 2 を MomADv2 と Gen2Sim が埋めたためで、**質の判断ではない。**→ **明日の候補に残らないなら、手動で拾い直す価値がある。**
- **2608.23189: EchoWM** — hf 62 で本日 2 番目の注目度。720p 映像・環境音・音楽・音声を同時生成し、連続的なナビゲーション入力に応答する omnimodal world model。**camera intent を metric-scale の 6-DoF 軌跡に統一して制御する設計は着想として良い。**ただし用途が「入って歩ける生成メディア」であり、**driving や manipulation への転用経路が遠い。**規定どおり hf_upvotes を relevance の上書きには使わず、同点タイブレークの場面もなかったため落選。**Gen2Sim (採用) の 8 capability の物差しで EchoWM を採点する、という読み方なら価値がある。**
- **2608.22869: UniMem** — VLA の non-Markovian task (過去の情報がないと解けないタスク) 向けメモリを、外部 VLM に頼らず統合する。**MomADv2 の memory gating と問題意識が重なる**が、MomADv2 の方が driving に直結し closed-loop 評価も持つため後塵。**2 本を並べて読むと「メモリの取捨選択」という共通論点が立つ**ので、MomADv2 を精読する際の副読本として適する。
- **2608.23563: EG-ARSA** — teacher の VLM を権威ある実地監査に対して校正し、**その校正を通ってからでないと大規模アノテーションを許さない**という gating が入った蒸留 recipe。**「疑似ラベルを大量生成する前に teacher の質を保証する」という手順は P2 の実務にそのまま移せる。**落としたのは fm_distill quota 2 を ADAPT と Conformal SSDA が埋めたためだが、**この 3 本目は惜しい。**道路安全という応用先が P1 の隣接領域である点も含め、次点として記録する。

### 主題が P1/P2/P3 から外れる (関連語だけ一致)

- **2608.23503: ActPair** — 人物異常検索の retrieval / reranking。蒸留・適合の話ではない。
- **2608.23499: SVD-Based Typicality Maps** — ViT の OOD 検出。手法は綺麗だが適合とも蒸留とも無関係。
- **2608.23284: Dynamic Topic Modeling** — トピックモデルの時系列比較。分野が完全に外。
- **2608.23261 / 2608.23235: 2 本の event extraction** — cross-domain を名乗るが対象は NLP の情報抽出。**「domain adaptation」の語が一致しただけで、扱っている domain の性質が違う。**
- **2608.23234: MLLM-Assisted Audio VOS** — チャレンジの技術報告 (3 位)。training-free の組み合わせ手法で、新規の知見が薄い。
- **2608.23213: Bee Detection (YOLO11 + ByteTrack)** — **transfer learning というキーワードが一致しただけ。**backbone の段階的解凍が全解凍より安定という知見は一般的すぎる。
- **2608.23124: LITERARYBIGFIVE** — 著者性格に基づく文体生成。
- **2608.22909: Dowker Homology for Sentence Similarity** — 位相的手法で文類似度を解析。純粋に面白いが接点なし。
- **2608.22906: AquaFlow** — 水中 Gaussian Splatting SLAM。**3D 再構成という点で P3 の geometry 表現に隣接しなくもないが、水中の光学劣化という課題設定が特殊すぎる。**
- **2608.22789: GuidedFlow** — 積層造形の異常検知。
- **2608.22950: WADE** — 浮遊ごみ検出のベンチマーク。compact VLM の評価という枠は近いが、対象領域が遠い。
- **2608.22885: DRAgent** — referring expression segmentation。
- **2608.22780: Online RL for Image Editing** — 画像編集の RL 報酬設計。
- **2608.23248: Future Querying (Medical World Models)** — **「world model」の語で fm_distill_finetune に配属されているが、実体は臨床予測の LLM 応用。**トピック配属の誤りでもある (下記 欠陥#4)。
- **2608.22622: ICU Physicians Clinical Reasoning** — 臨床推論の学習。医療応用として真っ当だが P2 の recipe にはならない。
- **2608.22642: Mol-JEPA** — **JEPA を分子に適用した「molecular world model」。**アーキテクチャ系統としては P3 の関心だが、**化学・創薬のドメイン知識が本体**で、構造の学びに対して読解コストが見合わない。

### 主題は近いが、今日の 6 枠には届かない

- **2608.23253: E2S-Pruner** — 学習不要・追加パラメータ不要の visual token pruning。**推論コスト削減として P2 の隣接だが、蒸留 recipe ではなく推論時の枝刈り。**VLM の実配備を始める段になれば読み直す価値がある。
- **2608.22898: SelFusion** — diffusion language model への自己蒸留。**「素朴な KD が効かない、むしろ悪化する」という観察は蒸留一般に示唆的**だが、DLM という前提が特殊で、自分の系に移せる部分が限られる。
- **2608.23476 / 2608.23497: fine-tuning による misalignment の 2 本** — narrow fine-tuning が予期せぬ広範な挙動変化を生む現象の分析。**「適合したら別のところが壊れる」という P2 に効く警告ではある**が、対象が安全性であり、適合の性能を上げる手立てにはならない。
- **2608.23338: LoRA の attention 解析** — LoRA が何をどこで学ぶかの解釈研究。**面白いが、明日の実験を変える情報ではない。**
- **2608.23018: SplitLite** — split federated LoRA の通信量削減。**分散学習の制約がある環境が前提**で、現状の運用に該当しない。
- **2608.22817: Industrial-Instruction** (hf 3) — 産業技術文書から instruction-tuning データを作るパイプライン。**データ構築の recipe としては具体的**だが、対象文書の種類が特殊。
- **2608.23391: Cross-Domain D2T without In-Domain Data** — 構造化データからのテキスト生成。ゼロ in-domain データという設定は P2 と形が似るが、タスクが遠い。
- **2608.22996 / 2608.22963: VLM の視覚情報保持の 2 本** — 前者は画像分割で物体が切れる問題、後者はエージェントの長い軌跡でテキストが視覚証拠を押し流す問題。**後者の "textual debt" という概念は、長時間動作するシステム一般に効く着眼**だが、今日の 6 枠には及ばない。
- **2608.22631: Terminal Agents** — 合成環境の忠実度とドメインギャップの話。**採用した Apodex 1.1 の Environment Scaling と主題が重なるため、wildcard 側を優先した。**
- **2608.23224 / 2608.23138 / 2608.22990 / 2608.22750 / 2608.22800: VLA と object-centric world model の 5 本** — いずれも P3 の関心圏内。**TOWN-VLA の「retrieved text を prompt に足すだけで成功率が 92.47% → 3.00% に落ちる」という監査結果は単体で衝撃的**で、prompt に情報を足す操作が制御介入になるという指摘は覚えておく価値がある。**quota 2 に対して候補が多すぎるため機械的に落ちた。**
- **2608.23452: Reward-Free Continual Adaptation for Space Robots** — 報酬が観測できない環境で latent-state world model を使って継続適応する。**設定が宇宙機に特化。**
- **2608.23383: JoyAI-Echo-1.5** — 長尺の音声映像生成。**cross-shot memory の設計は長時間一貫性の話として近いが、生成メディア寄り。**
- **2608.22861: MGMVFI** — フレーム補間向けの Mamba 改良。**SSM の走査順を optical flow で決めるという発想は、SSM を空間データに使う際の一般的な論点に触れる**が、タスクが補間に限定。

### wildcard 枠 (最大 1 のため構造的に 2 件が落ちる)

- **2608.20958: TLive-Omni** (hf 52) — **Per-vGrid (各映像グリッドと時間的に対応する音声を境界トークンで括ってまとめるトークン配置) は、多モーダル長系列の並べ方として P3 に移せる可能性があった。**本日は本流枠で world model 系を 2 本採ったため、探索枠は「本流で埋まらない視点」に使うと判断して落選。**惜しい。**
- **2608.16812: Unlocking the Potential of Image Editing via Concept Scaling** (hf 45) — 1,000 以上の編集概念の階層分類と 1,200 万ペアのデータセット。**「概念の粒度を細かくし、監督信号を密にする」というデータ設計の原則は一般性がある**が、画像編集への特化が強い。**なお公開から 8.9 日経過しており、`lookback_days: 2` の対象外のはずのものが混入している (欠陥#3)。**

---

## パイプライン診断 (本流候補が戻ったため、3 日ぶりに観測できた項目)

### 欠陥#5 (fm_distill_finetune の in-field 率) — **3 日ぶりに観測点が取れた**

fm_distill_finetune の候補 **30 件**のうち、**蒸留・fine-tuning・domain adaptation・PEFT・圧縮のいずれかを実際の貢献としている**ものを数えると **15 件 (50%)**。
さらに厳しく「**recipe として自分の運用に移せるもの**」に絞ると **8 件 (27%)** まで落ちる。

**残り半分は関連語の一字一句一致で入ってきている。**典型は 2608.23213 (bee detection の "transfer learning")、2608.23248 ("world model" が fm_distill に配属)、2608.22906 (水中 SLAM)。
**キーワードが広すぎるのが原因で、`fine-tuning` `transfer learning` `domain adaptation` の 3 語は現代の ML 論文のほぼ全てに出現する。**
→ **対処案: これら 3 語は単独一致では拾わず、タイトル出現に限る、あるいは `knowledge distillation` `PEFT` `LoRA` `model compression` との共起を要求する。**ただし **`lookback_days` の修正 (memory に記録済み・未実施) より優先度は低い。**候補が多すぎる問題は quota が吸収しており、実害は選別の手間だけである。

### 欠陥#4 (トピック誤配) — 3 日ぶりに観測点、新たに 3 例

- **2608.23248** "Future Querying: Can LLMs Serve as Implicit Medical World Models?" → **`world model` にマッチしているのに fm_distill_finetune に配属。**next_arch であるべき (そして分野外)。
- **2608.22642** Mol-JEPA → next_arch に配属は語としては正しいが、**分子の world model であり分野外。**
- **2608.23478** "Act with Intent: **Distilling** Behavior Intent for VLA" → next_arch 配属。**これは誤配ではなく正当な二重該当**だが、**現在の実装は 1 論文を 1 トピックにしか置けないため、fm_distill の quota 競争に参加できていない。**→ **既知の 5 例に 2 例を追加し、計 7 例。**

**加えて新しい観測: 二重該当を単一トピックに潰す設計そのものが、今日のような候補潤沢な日には損失を生む。**Act with Intent は P2 でも P3 でも上位に来る論文だが、next_arch の 15 件競争で 3 位に沈んで落選した。fm_distill 側なら 3 位以内 = 当落線上だった。

### 欠陥#3 (`lookback_days` が wildcard に効かない) — **本日も再確認**

fetch は 2026-08-25T18:00Z 実行、`lookback_days: 2` なので cutoff は 08-23 18:00Z。
wildcard 3 件の経過日数は **1.9 日 / 4.9 日 / 8.9 日**で、**3 件中 2 件が cutoff の外にある。**未修正。

**ただし本日は本流候補が 46 件あるため、この欠陥による実害はない。**
**修正順序は memory の記録どおり `lookback_days` を上げるのが先、#3 の修正は後。**順序を逆にすると、週末ギャップの日に候補が完全にゼロになる。

### 欠陥#1 (fetch が重複候補を再提示) — **本日は 0 件**

本日の候補 49 件を **過去の全 briefs ディレクトリの id と照合したところ、重複は 0 件だった。**
**ただし 08-25 と同じく、これは修正の結果ではない。**本流候補が 08-24 (月) 投稿の新着で埋まったため、そもそも再提示の余地がなかっただけである。**コードは未変更。**

### `lookback_days` について — 本日は 2 のままで足りた。しかし結論は変わらない

本日の本流候補 46 件は**すべて 08-23 (日) / 08-24 (月) の投稿**である。
**08-24 が月曜で、週末に溜まった投稿が一斉に出たため、`lookback_days: 2` でも十分な量が取れた。**

**これは設定が正しいことを意味しない。**08-23〜08-25 の 3 日間ゼロは、金曜 (08-21) 投稿を最後に土日ギャップに入り、cutoff が 2 日では届かなかったためである。
**同じことが次の週末にも必ず起きる。**memory に記録済みの推奨値 **`lookback_days: 5`** は依然として未実施であり、**本日の潤沢さはその必要性を減じない。**

なお **planner_ai は本日も候補 1 件で quota 2 を埋められなかった。**月曜の潤沢な投稿日ですらこうなる以上、**P1 のキーワードが狭すぎるという別の問題が独立に存在する。**
`lookback_days: 5` にすれば 7 件取れることは 08-25 に実測済みだが、**キーワード側の拡張 (例: `planning benchmark` `driving evaluation` `scenario generation`) も併せて検討する価値がある。**
