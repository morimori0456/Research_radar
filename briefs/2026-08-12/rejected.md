# 落選候補 — 2026-08-12

候補 **52 件**、採用 **6 件** (max_deep_per_day 6 の上限ぴったり)、**落選 46 件**。

内訳: planner_ai 4 件中 1 採用 / fm_distill_finetune 30 件中 2 採用 / next_arch 15 件中 2 採用 / sns_wildcard 3 件中 1 採用 (wildcard 上限 1)。

**取得は正常。** 08-09〜08-11 に 3 日連続で発生していた「topic 別の arXiv 候補がゼロ件」([[fetch-duplicate-candidates]] の主症状) は**本日は再発せず**、49 件の本枠候補が入っている。重複も**内部・過去 briefs ともにゼロ**。published は全件 08-09〜08-10 で lookback_days=2 の窓の内側。**取得側は本日に関しては健全。**

**落選の性格:** 46 件のうち **「質が低いから落とした」ものはほとんど無い**。大半は **quota と max_deep_per_day の上限に当たって落ちた**もの、または **題材が我々のプロジェクトから遠い**もの。特に fm_distill_finetune はキーワード ("fine-tuning" / "domain adaptation" / "transfer learning") が広すぎて **30 件中 20 件以上が「LLM/VLM を何かに fine-tuning してみた」応用論文**で埋まっている —— これは topics.yaml 側の課題として週次で扱うべき (下記「今後の調整メモ」)。

---

## 惜しかった 4 件 (quota に当たって落ちた)

- **2608.09876: Energy-Structured Latent World Models with Neural Time Fields for Physically Consistent Open-World Motion Planning** — **本日最も惜しい落選。** latent state に energy と momentum を明示的に持たせ、dissipation/control port で因果的な遷移を保証する world model + Eikonal 方程式による到達時間場。衝突率 12.1%→5.8%。**採用した LDR (2608.09926) と主張が同型**(「latent に物理構造を入れると外挿・信頼性が上がる」)で、**LDR の方が主張が大きく (初の分布外外挿)、効率の数字も強い**ため代表として LDR を採った。**本日 2 本が独立に同じことを言っている事実自体が重要な信号**なので、DIGEST の P3 欄に記載した。planner_ai quota の 2 枠目は空けたまま (3.5 点で採用水準に届かないと判断)。題名に typo ("Constistent") があるのも減点材料。

- **2608.09298: WorldSimProbe — Diagnosing Simulator Faithfulness in Action-Conditioned World Models** — **評価手法の新提案として本来は高優先。** action-conditioned world model が「物理シミュレータとして満たすべき最小の契約」(与えた action が対応する動きを生み、環境の反応がその動きに接地していること) を形式化し、5 スイート・18,000 インスタンスで 6 つの公開モデルを診断。**「世界モデルが本当にシミュレータとして使えるか」を見た目の品質ではなく能力で測る**という発想は、P1 の評価の作法にも R1 にも効く。next_arch quota 2 に対し LDR と FactorDrive を優先したため落選。**来週の精読候補として最も強い 1 本**であり、weekly review で拾い直すこと。

- **2608.09730: World Tokens — Enhancing Embodied Policies with Training-Time World Modeling** — 学習時だけ world model を使い、**推論時には world model の枝を丸ごと外す** VLA。World Adapter が VLM 特徴を固定個数の world token に変換し、それが action expert の唯一の視覚言語文脈になる (exclusive routing で迂回を禁止)。**これは 08-11 に採用した SimWAM と本質的に同じ設計**で、依存を構造的に禁止する仕掛けまで同じ発想 (SimWAM は isolated attention mask、こちらは exclusive routing)。**教訓を既に banked しているため落選** —— ただし **1 日おいて別グループが独立に同じ設計に到達した**という事実は、この設計が定着しつつあることの強い傍証。DIGEST の P3 欄に記載。

- **2608.09381: JEPA-WAM — Learning VLA Policies with Joint-Embedding World Modeling** — 事前学習済み V-JEPA 空間の上に latent world model を作り、**共有 predictor を通して遷移予測と行動生成を結合**する。LIBERO-Plus で 79.2% (大規模ロボット事前学習なし)、π0.5 版で 86.3%。**既存 VLA にも後付けできる**という主張が実務的。next_arch quota で落選。R3 のマップには載せる。

---

## その他の落選 (42 件)

### planner_ai (3 件)

- 2608.09860: Entanglement-Free Trajectory Planning for Tethered Mobile Robots — ケーブル付き移動ロボットの絡まり回避。**題材が特殊すぎて転用先が無い。** 本日唯一の「関連度ほぼゼロ」候補。
- 2608.09771: SLIM-0.5B — Action-Grounded Predictive Latents for Robot Manipulation — 0.5B の小型 VLA、masked trajectory prediction + Mixture-of-Transformers + flow matching。低レイテンシ・低メモリで大規模 VLA に匹敵。**質は高いが planner ではなく manipulation**。「小さいモデルが構造で勝つ」という本日の裏テーマの 3 例目ではある。
- (2608.09876 は上記「惜しかった」を参照)

### next_arch (11 件)

- 2608.09449: **Sekai2** — 2,826 時間・113 か国のカメラ軌跡付き実世界動画データセット。ループと再訪を含む 982 の全天球シーケンスが目玉 (**同じ場所を時間と視点を変えて何度も観測できる = 永続的な場面表現の学習に効く**)。**資源として価値は高いが、手法ではなくデータセット**で、我々の規模では消化できない。使うときに取りに行く。
- 2608.09448: VANE — VLA の test-time training を「未来の視覚的帰結」で検証してから採用する。更新を本番ポリシーから隔離し、後続の観測で裏付けが取れたときだけ commit する設計は堅実 (+3.2pt)。**改善幅が小さく、embodiment 依存**と著者自身が認めている。
- 2608.09073: Latent World Models with Monotone Planning Costs for Image-Goal Navigation — 凍結 DINO encoder + autoregressive rollout loss + **Monotone Cost Ranking** (行動列を乱すほどコストが上がるよう直接学習させる)。**「予測が正確なこと」と「コストが候補を正しく順位付けすること」は別問題**という指摘は良い。実機 zero-shot もあり。ナビゲーション寄りで quota 落ち。
- 2608.08982: Twin Rollouts — 世界モデルの中で反実仮想 (もし t* から違う行動を取っていたら) を、ノイズを共有した双子の rollout として定式化。自己生成なので Pearl の abduction が厳密になる、という論点は綺麗。**ただし "experiments are forthcoming" —— 実験がまだ無い。** 概念だけの note なので今回は見送り (P1 の反実仮想評価に効く可能性があるので、本実験版が出たら拾う)。
- 2608.09468: MixFormer — Mixture of Memory Experts を持つ linear transformer。SSM の入力適応性とメモリ容量の制約に対処。**アーキテクチャとしては本流だが、我々のボトルネックが長文脈ではない。**
- 2608.08904: From Recovery to Drop-off — VLA 化 (action post-training) すると VLM の深度推定能力が全層で劣化することを probing で示す。**「行動を学ばせると空間理解が削れる」は VLA 設計者が知るべき事実**だが、診断のみで処方が無い。
- 2608.09410: Skills in Weights, Memory in Code — 非マルコフ的な操作タスクで、技能は重みに、記憶はコードに置くハイブリッド。発想は面白いが manipulation 特化。
- 2608.09467: RecoverFly — UAV の vision-language navigation の失敗認識型 RL post-training。ドメインが遠い。
- 2608.09125: Trajectory Divergence Horizon Decision — 両腕手術ロボットの subtask。ドメインが遠い。
- 2608.09266: EndoClock — 医療 world model の前処理 (固定レート格子への再標本化) が事象を消していないか監査する。**「観測のタイミング自体が情報を持つ」という指摘は、非同期センサを扱う我々にも刺さる**が、医療パイプライン特化。
- 2608.09031: HOPPER — 線形化グラフ系列モデルの hop 抽出。グラフ学習で対象外。

### fm_distill_finetune (28 件)

**蒸留・PEFT として筋が良いが quota 落ち (4 件):**

- 2608.09287: **UniDFKD** — data-free knowledge distillation (元の学習データ無しで蒸留する) を architecture-agnostic にする。既存手法が BatchNorm 統計に依存していて **ViT では使えない**という問題を、言語由来の埋め込みによる意味的事前情報で置き換える。平均 20% 以上の改善。**P2 の関心には合うが、我々はデータを持っている**ので data-free の前提が要らない。
- 2608.09490: When Do Task Vectors Interfere? — 重み空間での task vector の合成が、いつ関数の合成として成立するかの境界を測る。**結論が「限定的にしか成立しない」という否定的な内容**で、しかも入力分布と書式に強く依存する。**08-11 の SFT/RL 干渉の論文と同じ問題圏だが、こちらは処方が出ない。**
- 2608.09742: FedAS-LoRA — federated LoRA で A と B のどちらを共有すべきかを、学習前に指標 (RSS) で選ぶ。**「A を共有 = 入力側部分空間の共有、B を共有 = 出力側部分空間の共有」という分解は綺麗**だが、federated という前提が我々に無い。
- 2608.09193: CPDA — 時系列の教師なしドメイン適応をクラス条件付きの経路分布の整合で行う。13 ベンチ・30 手法比較と検証は手厚い。**センサ時系列の適合として P2 に読み替えは効く**が、優先度で落選。

**関連はするが優先度が低い (6 件):**

- 2608.09907: **DistMoE** — 分散した private データで MLLM を instruction tuning する。言語 decoder の各層で、公開 FFN に**クライアント固有の private FFN expert** を足す MoE 構成。**「データを持ち寄れないまま、ドメインごとの知識を別々の expert に持たせる」**という形は、P2 の「機種ごとの適合を分けて持つ」に読み替えが効く (落選した Macaron-V1 の Mixture-of-LoRA とも同型)。ただし**我々にデータを集約できない制約は無い**ので、前提が過剰。
- 2608.09091: TLDChoiceNet — 転移学習の元データセットをどう選ぶか。**問いは良い** (我々も「どの事前学習を使うか」を勘で決めている) が、実験が小規模で主張が弱い。
- 2608.09630: Unsupervised Domain Adaptation with Extreme Label Shift (CTAO 望遠鏡) — 極端なクラス不均衡下での DA。**importance weighting の扱いは参考になる**が題材が天文物理。
- 2608.09682: Thinking With Tools, Not With Pixels — 「画像で考える」VLM の性能向上は、返ってきた画素ではなく**ツール呼び出しが吐く構造化テキスト**が担っている、という反証的な主張。**面白いが我々の設計に直結しない。**
- 2608.09292: Zeroth-Order Optimization for Self-Evolving LLM Agents — 自己進化がモデル固有の能力境界を超えられない問題に、ゼロ次最適化で対処。
- 2608.09153: TRACE — エージェントの軌跡から context (プロンプト/知識/ツール記述) の欠陥を自動で特定する。**運用の話としては有用**だが研究の入力にならない。

**題材が遠い応用・ドメイン特化 (17 件):**

- 2608.09880: FinATOM (株式リターン予測と配分を token 生成として解く) — 金融
- 2608.09818: MedPixel (医療の推論とセグメンテーションの統合) — 医療
- 2608.09142: Colorectal Cancer の治療計画エージェント — 医療
- 2608.09122: UGC 画像の視覚的歪み検出 — IQA
- 2608.09691: VLM で 3D 植生シーンを作り検出器の学習データを合成 — 生態調査 (**手法自体は synthetic-to-real の話で、採用した 2608.09100 と問題圏が同じ**。そちらを代表として採用)
- 2608.09683: 熱帯低気圧の最大風速半径の欠損補完 — 気象
- 2608.09650: 医療手続きの reranker 比較 — 情報検索
- 2608.09529: 音声→画像生成のデータセットと枠組み — 生成
- 2608.09510: LLM 生成の偽情報検出ベンチ — 安全性
- 2608.09493: GeoRoute (交通の未来フレーム予測の幾何整合) — **自動運転周辺ではあるが、映像生成の品質の話で planner に届かない**
- 2608.09432: ZetaGPT (位置埋め込み不要の状態空間 × attention 言語モデルの参照実装) — **参照実装であり新規主張が薄い**
- 2608.09420: Intent Speaks Louder (ユーザシミュレータの意図制御, hf 3) — 対話
- 2608.09344: LVLM の hallucination を学習なしで抑える per-instance 部分空間 — 生成の信頼性
- 2608.09322: Asynchronous Token Decoding による拡散画像編集 — 画像編集
- 2608.09244: 被写体駆動 text-to-image の in-loop 適合 — 画像生成
- 2608.09236: Federated Learning の label granularity skew — federated
- 2608.09189: EmoS (音声言語モデルの感情知能の評価と整合) — 音声

### sns_wildcard (2 件 / 上限 1 のため)

- **2608.09802: SWE-Bench ProMax** (hf 115) — 7 言語・170 インスタンスの多言語コードリファクタリングベンチ。**落としたが、教訓は 1 つ盗む価値がある** —— 既存の SWE-bench Verified の未解決インスタンスの**約 60% がテスト側の欠陥** (正しい解を弾く狭すぎるテスト / 明示されていない要件を検査する広すぎるテスト) だったという監査結果。**これは我々の closed-loop 評価スイートにそのまま刺さる問い**である: 「うちの評価シナリオのうち、planner の失敗ではなく**シナリオ側の欠陥**で落ちているものは何割か」。**R1 (評価手法の提案) をやるなら、この監査は避けて通れない。** DIGEST の P1 欄に記載。
- **2608.09819: Macaron-V1** (hf 146) — Mixture-of-LoRA (base を凍結し、chat/agent/coding/GenUI の 4 つの LoRA specialist を合成、ユーザのターンごとに 1 つ選ぶ) による継続学習。**「機種ごとに LoRA を用意して切り替える」は P2 の適合の話として読み替えが効く**が、**744B ベースのシステム報告書**であり、我々が再現も検証もできない。手法論文ではなく製品技術報告として扱う。

---

## 今後の調整メモ (weekly review 向け)

1. **fm_distill_finetune のキーワードが広すぎる。** 30 件中、蒸留・PEFT の手法論文は 4 件のみで、残りは "fine-tuning" を含むだけの応用論文だった。**"fine-tuning" 単独と "transfer learning" 単独は、ほぼノイズしか拾っていない。** より狭い句 ("on-policy distillation", "capacity gap", "LoRA", "synthetic-to-real") への差し替えを提案する。
2. **planner_ai が慢性的に薄い (本日 4 件、うち転用可能 3 件)。** キーワードに "occupancy", "NAVSIM", "nuPlan", "closed-loop evaluation", "trajectory scoring" を足すことを検討。本日 planner に最も関係が深かった FactorDrive と GeoRoute は**どちらも planner_ai ではなく別トピックに分類されていた。**
3. **next_arch に world model 論文が集中している (15 件中 7 件)。** これは分野の実態を反映しており、キーワードは適切に機能している。
