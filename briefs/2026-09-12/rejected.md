# 2026-09-12 不採用の候補と、本日の fetch 診断

候補 **44 件** (planner_ai **0** / fm_distill_finetune 30 / next_arch 11 / sns_wildcard 3) / 採用 **5 件** / 不採用 **39 件**。

**quota 上の割当: planner_ai 1/2 (他トピックからの 1 件) / fm_distill_finetune 2/2 / next_arch 2/2 / sns_wildcard 0/1。**
**上限 6 に対し 5。**wildcard の 1 枠は、届いた 3 件が**全部既読**だったため空けた。

> **planner_ai 枠の扱い (本日の判断):** planner_ai の候補が 0 件だったため、**他トピックの候補のうち planner_ai の基準で 4.0 以上の 1 件 ([fork ledger](2609.10954.md)) に限り planner_ai 枠を使った。**P1 の基準で 4.0 に届いたのはこの 1 件だけで、2 枠目は空けた。**基準を下げて埋めてはいない。**この扱いで fetch の欠陥が隠れるわけではない —— §0 の数字は planner_ai 由来 0 件のまま記録している。

> `git log -1 -- topics.yaml fetch_candidates.py` は **`313a283` (2026-07-03)** のまま = **設定は 1 行も変わっていない。修正 4 行・20 分・未実施 20 日目。**

---

## §0 本日の fetch 診断 —— planner_ai が初めて 0 件。原因はエラーではなく keyword

**実測値 (`generated_at` = 2026-09-11T18:00Z、cutoff = 09-09T18:00Z、`lookback_days=2` / `max_results=30`):**

| topic | 件数 | 最古の published | 最新の published | 診断 |
|---|---|---|---|---|
| planner_ai | **0** | — | — | **09-10 提出の該当が 0 件。keyword で飢えている** (下記①) |
| fm_distill_finetune | **30** | 09-10T00:53Z | 09-10T17:59Z | **ちょうど 30 = `max_results` の天井。3 日連続** |
| next_arch | 11 | **09-09T18:02Z** | 09-10T17:45Z | **最古が cutoff の 2 分後。窓で切れている** |
| sns_wildcard | 3 | 08-28 | 09-07 | **3 件とも既読 (初めて 100%)** |

**① planner_ai 0 件は fetch のエラーではない (09-12 に同じクエリを再実行して確認)。**
arXiv は 30 件 (= 上限) を返しているが、**最新は 09-09T14:15Z (09-11 に届いた 3 件と同じ) で、30 件は 08-26〜09-09 の 17 日分にまたがる。1 日あたり約 1.8 件である。**
- **`lookback_days` を 5 に広げても、拾えるのは 7 件 (09-07〜09-09) にとどまる。**`max_results` はこのトピックでは律速ではない。
- **09-10 提出分に `abs:"autonomous driving"` を 1 語足してクエリすると 2 件ヒットする** (MC-DeTra: 鳥瞰での検出と軌跡予測の同時推定 / **CARLAverse: CARLA (自動運転研究で標準のオープンソース・シミュレータ) 上の human-in-the-loop シミュレーション基盤**)。**CARLAverse は closed-loop 評価の基盤そのもので、P1 に直接効く候補を keyword 不足で 1 件落としている。**(1 日分・1 回だけの試し打ちであり、件数の一般化はしないこと。)
- **結論: P1 を動かせるのは修正③ (planner_ai への keyword 追加) だけである。**修正① (lb と mr) は P1 にはほぼ効かない。

**② fm_distill_finetune は 3 日連続で天井。**返った 30 件は全部 09-10 の 1 日分 (最古 09-10T00:53Z > cutoff)。**このトピックでは `lookback_days` が 3 日連続で一度も効いていない。**

**③ next_arch は逆に「窓」で切れている。**最古が cutoff の 2 分後で、件数は 11 (天井の 30 より遠い)。**09-10 に確定した「2 つは独立でない」構図が今日も同じ形で出た —— fm_distill は `max_results` を上げないと伸びず、next_arch は `lookback_days` を広げないと伸びない。片方だけ入れて「効かなかった」と判定しないこと。**

**④ wildcard は 3 件とも既読。欠陥#2 (dedup) の 7 回目の実測で、初めて 3 枠全部が再配信で消えた。**
- `2609.08183` NeoHorse-1 → [09-11 にブリーフ作成済み](../2026-09-11/2609.08183.md)。
- `2609.08936` AuK → 09-10・09-11 と 2 回不採用。**3 回目。**
- `2608.12564` WMRL → [08-15 に不採用](../2026-08-15/rejected.md)。**28 日後の再配信。wildcard 経路には年齢の cutoff が無い (欠陥#4)。**
- 原因は 09-11 までの記録と同じで、`fetch_candidates.py` が `briefs/*/*.md` を見ていないこと (修正②・3 行)。

---

## §1 次点 (quota で落とした 4.0)

- `2609.11127` **KuaiRP Series Role-playing Models Technical Report** — **P2 4.0。quota 落ち (fm_distill の 3 位)。**ドメイン知識を SFT と RL で注入すると汎用能力が壊れる問題に対し、**ドメイン適合後のモデルを teacher、元の base model を student にする逆向きの self-distillation** (自分自身の別版から学ぶ蒸留) を OPD (on-policy distillation; student が自分で生成した系列に teacher が教師信号を付ける蒸留) で行い、Cumulative-Divergence Decay で乖離を段階的に抑える。**「適合で壊れた能力を後から修復する」方向の答えで、本日採用の [soft prompting](2609.11310.md) (そもそも重みを触らないので壊れない) と対になる。**2 位の 2 本 (4.5) と比べ、技術報告で役割演技という特殊なドメインのため一般則の抽出が難しい点で差がついた。
- `2609.11697` **ActSafeGuard: Differentiable and Training-Aligned Constraint Enforcement for Flow-Matching Policies** — **P3 4.0 / P1 3.5。quota 落ち (next_arch の 3 位)。**flow matching (ノイズから行動への連続変換を学ぶ生成手法) の policy に、**微分可能な「安全層」を学習時から組み込み**、ray-scaling (実行可能領域の内側の点に向かって行動を縮める操作) で境界を意識した勾配を流す。π0.5 / Fast-WAM でステップごとの安全率 100%、成功率は維持。**「推論時にだけ安全化すると学習と実行がずれる」という指摘は planner にもそのまま当てはまる。**ただし ray-scaling が素直に使えるのは星形の領域 (内側のある 1 点から、境界のどの点も直線で見通せる領域) で、**運転の衝突回避 (時間とともに変わる非凸な領域) にどこまで持ち込めるかが不明なため、P1 枠には入れなかった。**

---

## §2 fm_distill_finetune (P2) — 28 件

- `2609.11163` **LILA: Calibration-Free Structured Pruning of LLMs via Latent Spectral Geometry** — **3.5。**FFN の重み行列の特異値分布が、ニューロンを除いたときにどれだけ変わるかを KS 距離 (Kolmogorov–Smirnov 距離; 2 つの分布の累積分布関数の最大差) で測り、校正データなしで structured pruning (行・列単位の刈り込み) を行う。**校正データを持ち込めない現場の圧縮には効くが、蒸留の recipe ではなく、P2 の優先項目 (蒸留 loss・capacity gap・適合) に当たらない。**
- `2609.11355` **SEAR: Segment-Evidence-Aware Routing for Weak-to-Strong Multilingual Speech MCQ** — **3.5。**テキストだけで解ける問題は SFT、音声がないと解けない問題は RL (GSPO; Group Sequence Policy Optimization、系列単位で重みを付ける GRPO 系の RL 手法) に振り分ける。**「text-only probe でデータを分けて、学習法ごとに割り当てる」は 09-11 に記録した「サンプルは等価ではない」の新しい変種で面白いが、コンペ用システムで要素の切り分け (ablation) が abstract からは見えない。**
- `2609.11687` **Structured Transforms for Low-Overhead Quantization of Language Models** — **3.0。**Kashin 分解ベースの 2-bit 量子化で、密な直交行列を符号付き DCT (離散コサイン変換) に置き換え O(N²)→O(N log N)。QuIP 系が発散する設定でも数値的に安定。**圧縮としては堅実だが、蒸留・適合の論点ではない。**
- `2609.11929` **SenseNova-U1.5: Towards Native Unified Visual Intelligence** — **3.0 / hf 117 (本日の本流で最多)。**8B の統合マルチモーダル生成モデル。専門家モデル群を multi-expert on-policy distillation で 1 つにまとめる。**蒸留が post-training の要として使われている実例ではあるが、abstract には蒸留の設計の中身がなく、学習コードの公開を待ってから読むべき。**注目度は生成品質に対してのもの。
- `2609.11872` **Evaluating Time-Series Foundation Models and Multimodal Dietary Context for CGM Forecasting** — **3.0。**時系列の基盤モデルは zero-shot では専用の単純なモデル (Elastic Net, PatchTST) に勝てず、**軽い fine-tuning で RMSE が 6.5〜18.4% 下がる。**「基盤モデルは適合してはじめて使える」の医療時系列での実測。**結論は P2 の既存の理解の範囲内で、新しい手法はない。**
- `2609.11236` **HALDETECT at ImageEval 2026: Answer-First Contrastive Grounding with QLoRA** — **2.5。**QLoRA (4-bit 量子化した重みの上で LoRA を学習する、メモリを節約した PEFT) で Qwen2.5-VL を適合。**「seed を変えたら、データを増やすほど良くなるという曲線が消えた」という自己反証は価値があるが、共有タスクのシステム報告。**
- `2609.11063` **The information geometry of large language models is shared, learned, and controllable** — **2.5。**次トークン確率の Fisher-Rao 幾何 (確率分布の空間での自然な距離) は、アーキテクチャが違っても揃う。その幾何に沿った介入は他の挙動を乱しにくい。**理論寄りで、fine-tuning の改善を主張しているが実務の recipe には落ちていない。**
- `2609.11029` **Rebalancing Token Importance in LMs with TF-IDF Weighted Cross-Entropy Loss** — **2.5。**TF-IDF (単語の出現頻度の偏りで重要度を測る古典的な重み) でトークンごとの loss を重み付けし、丸暗記を減らす。**目的が memorization の抑制で、蒸留・適合とは別の論点。**
- `2609.11463` **BruNet: A Cross-Domain Transfer Framework for Bruise Segmentation** — **2.5。**DINOv3 + SAM の decoder を皮膚病変データで学習し、打撲のセグメンテーションに追加学習なしで転用。**医療ドメインの単発の転用事例で、recipe として一般化しにくい。**
- `2609.11201` **CEM-TUDASR: unsupervised domain adaptive super-resolution** — **2.5。**カプセル内視鏡の超解像で、劣化モデルを学習してドメインギャップを埋める。**ドメイン固有の設計が中心。**
- `2609.11900` **MindTopo: Can Foundation Models Reason in Topological Space?** — **2.5。**位相的な関係 (連続性・包含・結び目など) の推論ベンチマーク。MLLM は推論より planning (closed-loop で行動を選ぶ設定) のほうが一貫して弱く、**動画生成モデルを world model 代わりに使うと、環境の動力学も位相も保たれない。**P3 の world model 評価の傍証になるが、主題が位相推論で遠い。
- `2609.11913` **Distance generalization in transformers: why bother with positional encoding?** — **2.0。**学習時と推論時でトークン間距離が変わったときの汎化を、合成タスクで RoPE / ALiBi / NoPE (位置エンコーディングなし) で比較。**基礎研究で、結論も「メカニズムの理解が必要」にとどまる。**
- `2609.11878` **Domain-Specific Hallucination Detection in LLMs** — **2.0。**DeBERTa + MC Dropout で hallucination を検出。一般ドメインで学習した検出器は生物医学ドメインに移らない (F1 0.52)。**よく知られた結論の確認。**
- `2609.11864` **RetroThinker: Enabling Retrospective Thinking in Speech LLMs** — **2.0。**音声 LLM がストリーミング中に推論を自己訂正する。**音声対話固有。**
- `2609.11724` **The Eloquence submission for Task 2 of the Interspeech 2026 MLC-SLM challenge** — **2.0。**LoRA より、凍結した大モデルの in-context learning (プロンプト内に例を並べるだけで適合させる方法) のほうが良かった (0.72 vs 0.81)。**コンペ報告で、比較条件 (モデルの大きさが違う) が揃っていない。**
- `2609.11472` **BridgeMatch: Conditional Transport Bridges for 3D Deformable Registration** — **2.0。**非剛体の点群対応を diffusion + transport bridge で解く。**分野が遠い。**
- `2609.11799` **SpecGuard: Inference-Time Backdoor Detection For Free** — **1.5。**speculative decoding (小さな draft model が先に候補トークンを出し、大きなモデルが検証して高速化する推論法) の受理率の変化から backdoor を検出する。発想は巧みだが、**セキュリティの論点。**
- `2609.11892` **Nuha-Speech: Building General-Purpose Arabic Speech-LLMs** — **1.5。**アラビア語音声 LLM のデータ基盤。
- `2609.11790` **Dynamic language model representations for multi-objective reaction optimisation** — **1.5。**化学反応の最適化。
- `2609.11772` **Whisper-Based Speech Transcription from Videos Across Multiple Languages** — **1.5。**少量の fine-tuning で誤り率 30%→20%。**新しい手法なし。**
- `2609.11708` **Language-Augmented Semantic Priors for B-Spline Surface Fitting** — **1.5。**CAD の曲面フィッティング。
- `2609.11580` は next_arch 側に記載。
- `2609.11569` **EXYGEN: Knowledge Graph Understanding at Scale** — **1.0。**知識グラフへの RAG。
- `2609.11860` **Explainability Assistant: Conversational XAI for Energy Consumption Models** — **1.0。**"without task-specific fine-tuning" の 1 語でこのトピックに入った典型例 (09-10 の PlannerForge と同じ構造)。
- `2609.11851` **IndicTriMix: Language Identification for Tri-Language Code-Mixing** — **1.0。**
- `2609.11334` **E-CONAN: Arabic Textual Entailment Benchmarks** — **1.0。**
- `2609.11521` **Generalized Score Matching for Parameter Estimation on Convex Domains** — **1.0。**統計的推定の理論。
- `2609.10935` **Membership Inference Attacks on NLP Text Classifiers: SST-2** — **1.0。**プライバシー攻撃のベースライン研究。

## §3 next_arch (P3) — 8 件

- `2609.11697` ActSafeGuard — §1 参照 (4.0)。
- `2609.11875` **UniMPA: Unified Memory-Prediction-Action Model** — **3.5。**VLA に「未来予測」と「過去の実行経験の検索」を組み込み、予測した遷移が実行可能かを経験のメモリで確かめる。**問題の整理 (見た目は同じでも作業段階が違う・予測がきれいでも実行できない) は鋭いが、構成要素が多く、何が効いたかの切り分けが abstract からは見えない。**
- `2609.10706` **HuRo: Robotizing Human Videos for Scalable VLA Pretraining** — **3.5。**人の動画 63 万エピソードをロボット視点・ロボット行動に変換して VLA を事前学習。**規模を増やすと OOD (学習分布の外) での完了率が 34.9%→72.2%。**「安いデータを変換して使う」は運転でも人の運転動画で成り立つ話で、次点に近い。
- `2609.11308` **2AM: Agent-Side Memory for Steerable Action Models** — **3.5。**長い作業の記憶を VLA の外側 (エージェント) に持たせ、VLA は状態を持たない実行器にする。LIBERO-Mem で 14.8%→76.3%。**「記憶は policy の中に要らない」という設計判断は P3 に示唆があるが、ロボット操作に閉じた評価。**
- `2609.11548` **World in World: Explore the World with World Models** — **3.0 / hf 5。**凍結した動画 world model に、学習なしで視点制御を足す推論時のインターフェース。**学習なしで既存モデルを制御できる点は面白いが、映像の再レンダリングが主題で、運転への接続が遠い。**
- `2609.11499` **Recursive Code World Models** — **3.0 / hf 5。**世界を実行可能なコードとして 1 枚の画像から再構成し、全体→部分→全体と再帰的に組み立てる。**09-11 の [Programmable World Model](../2026-09-11/2609.10540.md) と同じ「状態は書けるものは書く」系譜にある。**ただし主題は静的なシーン再構成で、ダイナミクス (時間発展) を扱っていない。
- `2609.11553` **CAP: Perception-Blind Humanoid Locomotion via Learned Denoising** — **3.0。**深度が部分的に壊れても、world model の encoder を「壊れた入力から綺麗な深度を復元する denoiser」として学習し、1 つの policy で滑らかに劣化させる。**センサ劣化への頑健性は運転でも重要な論点だが、ヒューマノイドの歩行制御で遠い。**
- `2609.11580` **AmazonSWE: Imputing Water Surface Elevation on a Sparse Spatiotemporal Graph** — **1.5。**河川の水位補間。state space model (系列を線形の状態遷移で処理する、transformer より長い系列に強いアーキテクチャ) の応用だが、分野が遠い。

## §4 sns_wildcard — 3 件 (全部既読)

- `2609.08183` **NeoHorse-1** (hf 391) — **重複。**[09-11 にブリーフ作成済み](../2026-09-11/2609.08183.md)。
- `2609.08936` **AuK Technical Report** (hf 208) — **3.0。3 回目の不採用。**09-10・09-11 と同じ理由 (4 step への蒸留は立派だが、音声固有の設計が大半で P2 に持ち帰れる一般則が薄い)。新しい情報はない。
- `2608.12564` **Scaling Automatic Research Agents via World Models** (hf 434) — **3.0。08-15 のスコア (3/5) を維持。**環境の実行を world model で置き換えて RL を 3〜4 倍速くし、world model の報酬の偏りとノイズを Online Debiasing / Inverse-Variance Denoising で補正する。**「学習したシミュレータの誤差をどう補正するか」は本日の [FARM](2609.11445.md) や [fork ledger](2609.10954.md) と話がつながるが、同じ abstract に日によって違う点を付けると日次スコアの比較ができなくなるので、再評価はしない。**必要なら 08-15 の記録から手動で拾うこと。
