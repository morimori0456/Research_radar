# 却下候補 — 2026-07-10

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **39件**(planner_ai 3 / fm_distill_finetune 23 / next_arch 10 / sns_wildcard 3)→ 選定 **5件**、却下 **34件**。

- **wildcard 3件は今日も全て既出のため選定ゼロ (3日連続)**: 2607.06559 (RynnWorld-4D) は 07-09 に**ブリーフ済み**の再提示、2607.06291 (AlayaWorld) は 07-09 却下済み、2607.04033 (OmniOpt) は 07-08・07-09 に続く**3回目の却下**。fetch 側の既読 dedup 未実装が継続 ([[fetch-duplicate-candidates]] 更新)。
- 新規 ID 枠 (P1: 3 / P2: 23 / P3: 10) は健全。P3 は今日も 4 点級 (NativeMEM, LingBot-World 2.0) が quota 2 に入り切らず。

---

## planner_ai (P1) — 3件中 1件選定 (K-Risk)、2件却下

- **2607.07357: HumAIN — Human-Aware Implicit Social Robot Navigation** — 3/5。骨格キューを使う社会的ナビゲーションで、prediction-planning gap を蒸留で埋める構成 (transformer teacher → 軽量 student) は P1/P2 双方に示唆があるが、ドメインが歩行者混在の対人ロボットで、評価も trajectory prediction 指標のみ。AD planner への直接転用点が薄く選外。
- **2607.06989: 卓球サーブの motion planning** — 2/5。motion primitives + MPC + Bayesian Optimization の組み合わせは堅実だが、高スピン生成という卓球固有の物理問題で、AD planner・評価への知見なし。

---

## fm_distill_finetune (P2) — 23件中 2件選定 (Soft Clamp / Flow-ERD)、21件却下

**次点(読む価値あり):**

- **2607.06918: LoCA — Spatially-Aware Low-Rank Convolutional Adaptation** — 3.5/5。**P2 落選中の最上位**。LoRA を conv 層の 4D テンソルに素直に適用すると空間トポロジーが壊れる問題に対し、channel 適合と spatial 適合を分離 (spatial 基底は学習済みカーネルの SVD から抽出) する conv-aware PEFT。domain-generalized segmentation で SOTA 級。vision FM の他ドメイン適合 recipe として本命級だが、同点帯で「新 loss + 挙動診断」の Soft Clamp と「closed-loop 蒸留 + AD 直結」の Flow-ERD に quota を譲った。明日以降も候補に挙がれば再考。
- **2607.07557: PALS — Percentile-Aware Layerwise Sparsity** — 3.5/5。activation の 99 percentile で層別 sparsity を ±5% 調整するだけの低コスト pruning 改善。「gradient ベースの割当はランダム以下」という反直観的な負の結果も実務価値がある。ただし効果が architecture 依存 (LLaMA-2 のみ大きい) と論文自身が認めており、汎用 recipe として一段落ちる。
- **2607.06796: KD for Time Series Classification** — 3.5/5。UCR Archive 全体で「KD は中間複雑度の student に最も効く」を 3 アーキテクチャ横断で示した系統的実証。capacity gap の実務知見 + コード公開で criteria に合うが、時系列分類ドメインで手法的新規性は薄い。
- **2607.07023: Online Data Selection Is Implicit Alignment** — 3.5/5。SFT 中のオンラインデータ選択が暗黙の alignment として挙動 (冗長性・拒否率・追従性) を系統的に動かすという指摘。タスク精度が同じでも挙動が分岐する、は Soft Clamp と同型の「集計指標に見えない挙動シフト」問題で、選定 2 本と論点が重複するため枠を譲った。データ選択を使う fine-tuning 運用者は一読推奨。
- **2607.06856: Gen4U — 動画 diffusion を frozen encoder として統一利用** — 3.5/5。動画 diffusion の中間表現が semantic/幾何タスク双方に強い encoder になることを mutual-kNN 分析で示す。P3 の world model 表現学習に示唆があるが、P2 の適合 recipe ではなく、P2 quota 内で優先度が届かず。

**relevance 不足:**

- **2607.07646: RL Post-Training Builds Compositional Reasoning** — 2.5/5。RL post-training が primitive スキルを合成する機構の制御実験。科学として面白いが toy 文法環境で、蒸留/適合の実務 recipe から遠い。
- **2607.07469: SynthAVE — LLM-Arena による合成ラベル検証** — 3/5。21 judge 構成の多数決で人手同等 (κ=0.92) の合成ラベル品質管理。データ整備の参考になるが e-commerce 属性抽出特化。
- **2607.07361: BUS — 教師なし self-reflection for VLM** — 3/5。backward prediction を学習信号にする label-free 学習は着想として面白いが、VLM 推論ベンチ特化で適合 recipe への落とし込みが不明。
- **2607.07388: TF-Engram — SSD-backed な train-free メモリ** — 2.5/5。fine-tuning の代替としての外部メモリはシステム論文として興味深いが 0.6B モデルでの検証のみ。
- **2607.07542: SonoRank — 超音波義手のキャリブレーションフリー化** — 2.5/5。pairwise ranking を pretraining 信号にする subject 非依存化は転用可能な発想だが医療デバイス特化。
- **2607.06799: Text-to-SQL の selective prediction** — 2.5/5。「fine-tuned verifier は in-domain 限定で、schema 横断汎化は凍結大規模モデルの推論力に依る」は評価設計に効く知見だが SQL ドメイン。
- **2607.07173: SPaRa-DCAL — 個人化 T2I の stage-aware LoRA** — 2.5/5。denoising 段階別に LoRA 強度を変える発想は一般化しうるが T2I 個人化特化。
- **2607.07233: HPG-Diff — 物理誘導 diffusion によるトポロジー最適化** — 2/5。LoRA 適合は付録的。構造設計ドメイン。
- **2607.07382: FRB 検出の zero-shot VLM ベンチマーク** — 2/5。天文ドメインの zero-shot 応用評価。
- **2607.07408: ブラジルポルトガル語の韻律境界分割** — 2/5。Whisper fine-tuning の言語特化応用。
- **2607.07117: Tree-of-Thoughts for T2I-ICL** — 2/5。学習なしの prompting 工夫。
- **2607.07195: DiffCVE — 圧縮動画の diffusion 強化** — 1.5/5。動画復元特化。
- **2607.06948: 点群 leaf-wood segmentation の SSL** — 2/5。森林計測ドメイン。SSL pretraining の cross-site 頑健性という主題は真っ当だが遠い。
- **2607.06841: Tensor Train Diffusion** — 1.5/5。高次元サンプリングの数値解法。対象外。
- **2607.06839: LEMUR 2 — NAS ベンチマーク** — 2/5。アーキテクチャ多様性のデータ基盤。蒸留/適合 recipe ではない。
- **2607.07267: 26億スケッチの文化差分析** — 1/5。計算社会科学。対象外。

---

## next_arch (P3) — 10件中 2件選定 (LaMem-VLA / WM Admissibility)、8件却下

**次点(読む価値あり):**

- **2607.06678: NativeMEM — VLA の native memory 圧縮** — 4/5。**P3 落選中の最上位**。VLA 自身の vision encoder を再利用して履歴 1 フレームを 1 token に圧縮、外部プランナーも新規メモリモジュールも不要で 32.4%→84.0% の大幅改善 + データ効率 5 倍。LaMem-VLA と同じ「VLA の長期記憶」問題への対照的な (より軽量な) 解で、quota が許せば選定級。LaMem-VLA のブリーフ内で対比参照として言及済み。
- **2607.07534: LingBot-World 2.0 — 無限 horizon の interactive world model** — 4/5。causal pretraining で無限 interaction horizon、蒸留で 720p/60fps 実時間化、pilot/director の agentic 統合と、world model の工学的到達点として重要。ただしゲーム的 world simulator 寄りで、14B/1.3B の系はブログ的な技術報告色もあり、AD 評価に直結する WM Admissibility を優先。
- **2607.07287: TouchWorld — 触覚 foundation model** — 3.5/5。「遅い task reasoning と速い接触 feedback を単一ループに混ぜない」階層分離 (planning / goal-conditioned 生成 / 高周波 residual 補正) は、レイテンシ階層を持つ運転スタックにも通じる設計。ただし触覚センサ前提の manipulation 特化。

**relevance 不足:**

- **2607.06706: VLA 総説 (UAV + bimanual, 183本)** — 3/5。P3 の見取り図として有用でブックマーク推奨だが、総説は deep dive 枠でなく随時参照でよい。
- **2607.06724: EvoPlan — 進化的 neuro-symbolic planning + STL 制約** — 3/5。nuPlan から STL 制約をマイニングして VLA/駆動ポリシーを shield する部分は P1 に触れるが、全体は LLM+PDDL の汎用ロボット計画で焦点が散漫。
- **2607.07403: 車載 VLM のマルチエージェント倉庫制御** — 2.5/5。オンボード小型 VLM 構成の実証は参考になるがシステム応用論文。
- **2607.07491: Smooth Operator — サンプリングベース hand retargeting** — 2.5/5。teleop データ品質は VLA の上流課題だが手指 retargeting 特化。
- **2607.07420: Initiation Safety** — 2/5。社会的行動の開始権限というポジションペーパー。運転への転用は薄い。

---

## sns_wildcard (EXPLORE) — 3件中 0件選定 (全て既出)

- **2607.06559: RynnWorld-4D** (hf 79) — 07-09 に**ブリーフ作成済み** (briefs/2026-07-09/2607.06559.md)。再提示。
- **2607.06291: AlayaWorld** (hf 78) — 07-09 に 3/5 で却下済み (ゲームドメインの full-stack world model 基盤)。再評価しても判断は変わらず。
- **2607.04033: OmniOpt** (hf 72) — 07-08・07-09 に続く 3 回目の再提示。optimizer 総説としてブックマーク価値はあるが deep dive 枠ではない。
