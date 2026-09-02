# 2026-09-03 不採用の候補

候補 **45 件** / 採用 **6 件** / 不採用 **39 件** (採用率 13%)。
届いたラベル別内訳: planner_ai **2** / fm_distill_finetune **30** / next_arch **10** / sns_wildcard **3**。
**内容による再分類後の採用内訳: planner_ai 2 / fm_distill_finetune 2 / next_arch 2 / sns_wildcard 0** (quota 通り、`max_deep_per_day: 6` に一致)。

> **本日、planner_ai のラベルが 4 日ぶりに 0 件でなくなった。届いたのは 2 件で、採用は 0 件である。**
> **そして本日の P1 最重要論文は、fm_distill_finetune のラベルで届いた。**
> `git log -- topics.yaml fetch_candidates.py` の最終変更は初期構築時のまま = **設定は 11 日間 1 行も変わっていない。**

---

## §0. fetch の診断 —— 欠陥#7 の形が確定し、欠陥#1 に初めて直接証拠が出た

### 【確定・より鋭い形】欠陥#7: planner_ai の keyword は「1 語ずれている」

09-02 は **「planner_ai の 4 キーワードが 49 件の abstract に 1 件も出現しない (0/49)」**という形で欠陥#7 を確定した。**本日はキーワードが 3 件ヒットしたので、より正確な診断ができる。**

```
planner_ai keyword hits: 3 / 45
  2609.01579 (planner_ai)   "motion planning"   ← 農業ロボット (ピーマン収穫)
  2609.01260 (planner_ai)   "motion planning"   ← 古典的な非線形 motion planning
  2609.00111 (sns_wildcard) "motion planning"   ← Qwen-Drive-1.0 (本流に取りこぼされた)
```

**4 キーワードのうち実際に機能しているのは `motion planning` だけであり、それはロボットアーム・農業機械の論文を大量に引き込む語である。**残る 3 語 (`trajectory prediction` / `planner evaluation` / `closed-loop simulation`) は**本日も 0 ヒット。**

**そして決定的な観測がこれである。**

> **本日の P1 最重要論文 [2609.00718 A Closed-Loop Evaluation of Capability Loss and Recovery in Compressed Driving Policies](2609.00718.md) は、planner_ai の 4 キーワードを 1 つも含まない。**
> **著者が書いているのは `closed-loop evaluation`。設定にある語は `closed-loop simulation`。****語が 1 つ違うだけで拾えていない。**
> この論文は `knowledge distillation` にヒットして **fm_distill_finetune** のラベルで届いた。**偶然、圧縮の論文でもあったから届いただけである。**

**したがって欠陥#7 の修正内容は、09-02 の「語彙を足す」よりも具体的になる。**

| 現在の keyword | 判定 | 置き換え/追加 |
|---|---|---|
| `motion planning` | **ノイズ源** (農業ロボット・アーム操作を大量に引く) | 残すが単独では不十分 |
| `trajectory prediction` | 0 ヒット | 残してよい (害はない) |
| `planner evaluation` | **0 ヒット・著者が書かない語** | **削除候補** |
| `closed-loop simulation` | **0 ヒット・1 語ずれ** | **`closed-loop evaluation` に修正** |
| — | — | **追加: `end-to-end autonomous driving` / `driving policy` / `NAVSIM` / `nuPlan` / `Bench2Drive` / `planning benchmark`** |

### 【新規・直接証拠】欠陥#1 (lookback_days: 2 が狭い) が、初めて実物で示された

**これまで「lookback が狭い」は候補ゼロの日から推測していた。本日は、取りこぼされた具体的な論文が特定できた。**

> **[2609.00111 Qwen-Drive-1.0](2609.00111.md) —— hf_upvotes 335 (本日 2 位)、abstract に `motion planning` を含む、P1 と P3 の両方に直撃する論文。**
> **これが `sns_wildcard` のラベルで届いている。**

理由は `fetch_candidates.py` の 2 つの経路の窓の違いである。

```
L129: cutoff = now - timedelta(days=lookback_days)     # = 2 日 → 08-31T18:00Z 以降のみ
L91 : for d in range(lookback_days + 1)                # = 3 日分の HF Daily Papers ページ
```

**Qwen-Drive の公開は 08-30。本流の arXiv クエリの窓 (08-31T18:00Z 以降) から外れており、HF 側の広い窓だけが拾った。****キーワードは一致していたのに、日付で落ちた。**

**これは「wildcard 枠が本流の取りこぼしを偶然救っている」という状態であり、wildcard 枠 (3 件) が探索に使われていないことを意味する。**本日の wildcard 3 件のうち、**1 件は本流の取りこぼし、1 件は重複、残り 1 件だけが本来の探索枠だった。**

### 【6 日連続】欠陥#2: dedup が無い

**[2608.31046 On-Policy Distillation](../2026-09-02/2608.31046.md) が本日も届いた。09-02 にブリーフ済みである。**
09-02 の記録では 5 日連続だったので、**これで 6 日連続。**hf_upvotes は 88 → **125** と伸び続けており、**注目度の高い論文ほど長く wildcard 枠を占有し続ける構造は変わっていない。**

### 修正の順序 (09-02 から変更なし・11 日目)

所要 **20 分**。**この 11 日間、上記の欠陥はすべて再現し続けている。**

1. **`lookback_days: 2 → 5` と `max_results: 30 → 100` を同時に。**片方だけだと窓を広げた分が打ち切りで消える。**← 本日 Qwen-Drive の実例で必要性が確定した。**
2. **`briefs/*/*.md` のファイル名を除外集合に追加** (dedup。6 日連続)。
3. **planner_ai の keyword を上表の通り修正** (①と独立。`closed-loop simulation → closed-loop evaluation` の 1 語修正が最も費用対効果が高い)。
4. **wildcard の cutoff を触るのは必ず最後。**かつ**緩い窓 (21 日) を別に持たせる。**注目が集まるまでに時間差があるため、本流と同じ窓にすると wildcard が機能しなくなる。

---

## §1. 不採用の一覧

### planner_ai ラベル (2 件・採用 0)

- **2609.01579: SG-AMP: Scene-Graph-Guided Active Perception and Semantics-Aware Motion Planning for Pepper Plants** — **P1 1.0。**ピーマンの収穫ロボットの active perception。`motion planning` にヒットしただけで、自動運転のプランナーとも評価指標とも接点がない。**欠陥#7 の「`motion planning` がノイズ源」の典型例。**
- **2609.01260: Dual Process Motion Planning** — **P1 2.5。**古典的な記号ソルバを System-2、学習モジュールを System-1 に置く neuro-symbolic な非線形 motion planning。**筋は悪くないが、評価は非線形ベンチマーク環境であり、閉ループの運転評価でも指標の提案でもない。**R1 に効かない。**次点として記録するほどでもない。**

### fm_distill_finetune ラベル (30 件・採用 2)

**採用: [2609.01532 Switch Distillation](2609.01532.md) / [2609.00746 Sink Strength](2609.00746.md)。**
**内容により P1 として採用: [2609.00718 圧縮運転方策の閉ループ評価](2609.00718.md)。**

**次点 (quota が 1 枠多ければ採ったもの):**

- **2609.01244: Post-Training Science for Supervised Fine-Tuning** — **P2 4.0。次点筆頭。**learning rate / batch size / LoRA vs full / epoch 数 / optimizer を **1 度に 1 つずつ振る sweep** で、Qwen3 と Llama、dense と MoE、4 つの実顧客 SFT データセットにわたって測った実務向けの大規模実験。**「validation loss は下流品質を正しく順位付けするか」という問いを含む点が R1 の論法と同型。**落とした理由は**新規性ではなく優先度** —— **09 月は R1 に絞る方針で、これは今月動かせない。**10 月に P2 を再開するときの最初の 1 本として記録する。
- **2609.01573: Scaling Near-Optimal SFT-RL Annotation Budget Allocation from Small to Large LLMs** — **P2 3.5。**SFT と RL のアノテーション予算配分の **near-optimal region (最高性能から一定の許容幅に収まる配分の集合)** が広く、**小さい代理モデルから大きいモデルへ転移する**という結果。**「小モデルで測って大モデルに使う」は R2 の実験コストを下げる型だが、対象が予算配分であって蒸留ではない。**接続が 1 段遠い。
- **2609.00762: Frozen Cores Need Task Signal (FCCA)** — **P2 3.5。**PEFT を「何個更新するか」ではなく**「どの部分空間で更新するか」**の問題として立て直す。**R2 の「監督を当てる範囲」と同じ発想だが、対象が重み空間の基底選択で、蒸留の教師信号とは層が違う。**本日は同型の例が [IMPACT](2609.00161.md) と [Switch Distillation](2609.01532.md) で既に 2 本採れているため、3 本目は不要。
- **2609.01091: Subliminal Learning as Trait-Direction Drift** — **P2 3.0。**教師が system prompt で偏っていると、数列のような意味的に無害なデータ経由でも生徒が隠れた選好を継承する現象の機構解明。**「教師が何を運んでいるか」という問いは R2 の中心だが、運ばれるものが能力ではなく trait であり、R2 の系統則には乗らない。**
- **2609.00734: Online Self-Weighted Fine-Tuning** — **P2 3.0。**SFT が全ての教師デモに同じ重みを当てている点を、モデルの習熟度に応じて動的に変える。**「どこに監督を当てるか」の 7 例目に当たるが、本日既に採用済みの 2 本と主張が重なる。**W35 の結論を補強するだけで、新しい軸を足さない。
- **2609.01345: Cheap Verifiers, Large Blind Spots** — **P2 3.0。**安いモデルで大半を答え、難しい尾を frontier モデルに escalate する cascade の信頼性コストを測る。**「コストを下げる仕掛けが何を壊すか」という論法は本日の採用 4 本と同型だが、対象が推論時の routing であり、蒸留にも適合にも直接は効かない。**

**明確に対象外 (23 件):**

- **2609.01604: Beyond Scores: Understanding LLM-as-a-Judge Mechanisms in Summarization Evaluation** — P2 2.5。要約評価における LLM-as-a-judge の内部手続きを 8 種の摂動攻撃で機構解析。**評価器の癖の解析は W35 の [VBVR-Pro](../2026-08-29/2608.26105.md) で既に押さえた論点で、追加の軸がない。**
- **2609.01575: Closing Cost-Quality Gap in Document VLMs** — P2 2.0。規制業界の文書からの構造化フィールド抽出。難易度を考慮したデータ選別と配備の経済性。**応用が特化しすぎ。**
- **2609.01564: From Confusion to Clarity (Confusion-Aware Retrieval)** — P2 1.5。ラベル数の多い分類での候補検索と知識注入。**テキスト分類の応用。**
- **2609.01554: BS: Take the Hint (Interactive Multitracer PET/CT Lesion Segmentation)** — 1.0。医用画像・チャレンジ参加報告。
- **2609.01427: Pix2Rep-v2** — 1.5。医用画像の dense 自己教師あり表現学習。
- **2609.01417: Predicting Subsurface Abnormalities Growth using PINNs** — 1.0。地中レーダーへの physics-informed neural network 適用。分野外。
- **2609.01397: Measuring consistency via ensemble margin and local prediction variability** — P1 2.5。**Rashomon effect (同程度に正確なモデルが同じ入力に異なる予測を返す現象) を意思決定システム全体で測る。****「同じスコアでも中身が違う」は R1 と主題が近いが、対象が公共部門の意思決定監査で、閉ループ制御に持ち込む道筋がない。**惜しいが今月は不要。
- **2609.01325: VerTox (Corpus Poisoning Against Neural Ranking Models)** — 1.0。検索ランキングへの攻撃。分野外。
- **2609.01310: GazeRefine (Expert Gaze as Test-Time Prompt)** — 1.5。医用画像の学習不要セグメンテーション。
- **2609.01294: Explore Before Committing (Hypothesis-Guided Search for Deep Research Agents)** — 2.0。探索エージェントが早期に 1 方向へ固定する失敗モードの是正。**主題は面白いが P1/P2/P3 のどれにも接続しない。**
- **2609.01051: SAGE (Subpopulation-Aware Generative Enhancement)** — 2.0。spurious correlation の緩和。**「多数派の見かけ上の相関に引きずられる」は [IMPACT](2609.00161.md) の supervision-allocation mismatch と近縁だが、そちらを採用済み。**
- **2609.01041: ViTAMINS (Synthetic Hard Negatives for SSL ViT)** — 2.0。自己教師あり ViT 事前学習の実証研究。
- **2609.01016: Phrase-Localized Language-Contrastive Guidance** — 1.0。code-switching 音声合成のアクセント制御。分野外。
- **2609.01014: Low-Quality Face Recognition** — 1.0。分野外。
- **2609.00981: Prior-Guided Implicit Neural Representations for dMRI Super-Resolution** — 1.0。医用画像。
- **2609.00948: From Terminology to Diagrams** — 1.5。科学図表理解のための視覚指示データ生成。
- **2609.00920: VerNav (Verifier-First Low-Latency VLN)** — P3 2.5。**vision-and-language navigation で、毎ステップの自己回帰生成をやめて検証器を先に置き遅延を下げる。****「速い経路と遅い経路を分ける」という点で [ZimaBlue](2609.00188.md) の Slow-Fast と同型だが、そちらの方が規模も主張も強い。**
- **2609.00898: Vision-Language-Guided Pseudo-Labels for UDA (Waste Sorting)** — P2 2.5。**ターゲット領域のアノテーション無しで domain adaptation。**recipe は素直だが、**適用先がゴミ分別で、蒸留の系統則には効かない。**
- **2609.00873: Membership Inference in Fine-tuned Diffusion Language Models** — 1.5。プライバシー攻撃。分野外。
- **2609.00834: Replacing Training with Memory (Listwise Selection for Text-to-SQL)** — 1.5。Text-to-SQL の候補選択。
- **2609.00791: Instella-MoE Technical Report** — P2 2.5。16B 総パラメータ / 2.8B 活性の完全オープン MoE をゼロから学習した技術報告。**再現可能な recipe という点では価値があるが、蒸留・適合の話ではなく事前学習の話。**AMD GPU での学習という点は記録に値するが、ブリーフ 1 枠を使うほどではない。
- **2609.00940 は next_arch ラベルのため下記。**

### next_arch ラベル (10 件・採用 2)

**採用: [2609.00188 ZimaBlue](2609.00188.md) / [2609.00161 IMPACT](2609.00161.md)。**

**次点:**

- **2609.01560: H3-World: Turning Language Understanding into World Control** — **P3 4.0 (hf_upvotes 40 = next_arch 内で最高)。次点筆頭。**33B の動画生成モデル MiniMax-H3 を、**行動モジュールを新設せずに**対話的な world model に変える。行動を「キャラクタ指示 + カメラ指示」の構造化された組として表し、**temporal attention routing (各指示を意図した時間区間だけに効かせ、行動どうしの制御の漏れを減らす仕組み)** で時間的に精密化。**8,000 サンプル・LoRA 10,000 step・学習パラメータ 0.199%** で成立。
  **落とした理由: [ZimaBlue](2609.00188.md) と枠を争い、R3 の分類マップへの寄与で負けた。**H3-World は軸 ①(時間をどこに持つか) に対して「時間区間へのルーティング」という値を足すが、**ZimaBlue の Slow-Fast 非同期の方が、実時間制御という制約付きで測られている分だけ主張が強い。****hf_upvotes は 40 対 39 でほぼ同点であり、タイブレークではなく relevance で決めた。****R3 に着手する 10 月には必ず読む 1 本。**
- **2609.00908: Knowing When to Stop: Adaptive Action Chunking via Internal Cross-Attention Dynamics in VLAs** — **P3 3.5 / P1 3.0。**VLA の action chunking (数ステップ分の行動をまとめて出し、開ループで実行する方式) の実行長を、**cross-attention の entropy が高止まりする合図で動的に打ち切る。**学習不要で、方策が既に計算済みの attention だけを使う。
  **落とした理由は惜しい —— 「観測との接地が失われた瞬間を内部信号で検出する」という発想は、R1 の solvability と問題意識が近い。**ただし **R1 が測りたいのは環境側の余裕 (逃げ道が何本残っているか) であり、こちらはモデル側の確信度である。**別の量なので、混ぜると主張が濁る。**本日は [IMPACT](2609.00161.md) が同じ「内部信号を使う」型をより広い含意で提供しているので、そちらを採った。**

**対象外 (6 件):**

- **2609.01549: NashDreamer (MBRL for Zero-Sum Imperfect-Information Games)** — P3 2.5。model-based RL のゼロ和不完全情報ゲームへの拡張。**world model ではあるが、対象がゲーム理論的均衡で、身体性も知覚もない。**
- **2609.01404: Evaluating MLLMs as Generalist VLA Agents for Drone Control** — **P3 3.0 (hf_upvotes 20)。**MLLM をドローンの制御ループに直接置き、行動空間を prompt だけで宣言する評価。**「基盤モデルをそのまま制御に落とすとどこまで行けるか」の実測は面白いが、評価対象がドローンで、指標も成功率中心。**R1 にも R3 にも新しい軸を足さない。
- **2609.01281: EmbodiedSkills** — P3 2.5。VLA エージェントの編成・学習・配備の統合フレームワーク。**エンジニアリング寄りで、アーキテクチャの主張が薄い。**
- **2609.01215: REFACTOR-VLA (Unsupervised Library Learning of Typed Motor Programs)** — P3 3.0。モノリシックな VLA を、再利用可能な型付きの運動プログラムの library に分解する。**R3 の軸 ③(終点か過程か) に関係するが、長時間タスクの抽象化が主眼で、world model との統合という R3 の中心からは外れる。**
- **2609.00940: A Dataset for Modeling Iterative Problem-Solving** — 2.0。反復的な問題解決の系列モデリング用データセット。
- **2609.00776: Solaris: Towards Interfaces That Are Generated, Not Coded** — P3 2.0。UI をコードでなく world model でフレーム単位に生成する。**world model の応用としては新奇だが、制御も物理も無い。**

### sns_wildcard ラベル (3 件・採用 0)

**wildcard 枠として採用したものは無い。3 件の内訳が、そのまま §0 の診断になっている。**

- **2609.00111: Qwen-Drive-1.0** — **本流の取りこぼし。**`motion planning` に一致していたが `lookback_days: 2` の窓から外れた。**[P1 + P3 本流として採用](2609.00111.md)** (欠陥#1 の直接証拠)。
- **2608.31046: Does On-Policy Distillation Really Distill?** — **重複。**[09-02 にブリーフ済み](../2026-09-02/2608.31046.md)。**hf_upvotes は 88 → 125 に伸びており、枠を占有し続けている** (欠陥#2・6 日連続)。
- **2609.01591: StudentSim: Training LLM-based Student Simulators** — **本日唯一の真の wildcard (hf_upvotes 390 = 全候補中 1 位)。P1 2.5 / P2 2.5 / P3 1.5。**
  個々の学習者の疎なデータから**個別化されたシミュレータ**を作り、**behavioral fidelity (その学習者の応答をどれだけ再現するか)** と **guidance responsiveness (指導を与えたときどれだけ更新されるか)** の 2 軸で測る。チェス・第二言語英作文・数学の 3 領域 60 名で GPT-5.4 を上回る。
  **学びはある —— 「模倣の忠実度」と「介入への応答性」を直交する 2 軸として分離した点は、R1 が [Intervention Gap](../2026-09-02/2608.29998.md) から取った「当てはまりと介入忠実度は別物」と完全に同じ構造で、教育という無関係な分野で独立に再発見されている。**
  **それでも落とした理由は 2 つ。**① **この主張は 09-02 に既にブリーフ済みで、R1 に新しい情報を足さない。**② **wildcard は「視野を広げる枠」であり、既知の主張の別分野版はその目的を満たさない。****上限 1 件を使う価値がなかったので、本日は wildcard 枠を空けた。**
