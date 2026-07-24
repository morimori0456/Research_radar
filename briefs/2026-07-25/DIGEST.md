# DIGEST — 2026-07-25

> 候補 39 件。採用 **6 件(P1×1・P2×2・P3×2・wildcard×1)= max_deep_per_day 到達**。
> **選別メモ:** 本日の在庫は **world model / VLA に大きく偏重**(next_arch 4・sns_wildcard も world model 1)。P1 は 2 件のみ在庫かつ両方が自動運転 planner から遠く(片方は化学プロセス制御、片方は両腕マニピュレーション)、**P1 は 1 件で under-fill**。よって P2×2・P3×2・wildcard×1・P1×1 で 6 に到達。
> **重複バグ継続:** wildcard の目玉 ABot-World-0(207 up)は **3 日連続の再提示で無効**(2026-07-23 ブリーフ済)。[[fetch-duplicate-candidates]] の dedup 欠落が今日も発火。wildcard は次点の AREX を採用。
> **今日のテーマ:** **「world model の状態をどう持ち、どこで grounding するか」**。pixel か latent か(HyWorldVLA)、履歴か明示レジスタか(WorldWeaver)、単一ヘッドか MoE か(MoE VLA)——**"状態と行動の持ち方"の設計選択**が並んだ。加えて P2 は **「収集した経験を SFT で焼くと 96% 捨てる」**という蒸留レシピの直撃(Experience Distillation)。

---

## 今日読むべき TOP3

### 1. HyWorldVLA — VLA×world model×E2E 自動運転の直球、pixel と latent を両取り(P2 タグだが実質 P3 本命・P1 も直撃)
自動運転の VLA(画像・言語から行動を出す基盤モデル)に world model(未来予測)を足す時、**pixel-level 予測は細かいがノイズに弱く、latent 予測は頑健だが表現が劣化する**というトレードオフを、1 つの hybrid で解く。肝は **pre-train では pixel 再構成で latent を実映像に接地(grounding)し、実運用の co-fine-tuning では latent 予測だけに絞る**二段レシピ。NAVSIM(自動運転の closed-loop planner ベンチ)で pixel/latent 両 baseline を有意に上回り、しかも **world model のノイズ頑健性を初めて定量評価する軸を新設**した。我々の driving world model の default 構成候補であり、NAVSIM 評価の論点(過保守・帰属曖昧さ)にも刺さる。→ [ブリーフ](2607.20988v1.md)

### 2. Experience Distillation — 収集した経験を SFT で焼くと利得の 96% を捨てている(P2 本命)
高コストな環境対話でためた agent 経験を重みに入れる時、**素朴な SFT(集めた入出力をそのまま教師に微調整)は in-context learning の利得の 3.8% しか回収できない**。対して **context distillation(文脈に入れて ICL で得た振る舞いを重みへ内在化する蒸留)**なら、**追加の環境対話ゼロで 64.8% 以上を保持**し、RL baseline 同等性能を **9.6 倍少ない環境サンプル**で達成。閉ループ実験が高コストな我々の設定で、「同じデータからの回収率」を跳ね上げうる再現価値の高い recipe。明日できる:手持ちの経験で SFT vs Experience Distillation の回収率を実測する。→ [ブリーフ](2607.21051v1.md)

### 3. WorldWeaver — 観測履歴を引きずる代わりに「世界状態レジスタ」で持つ(P3 本命)
multi-agent の world model は、見た目の整合だけでなく **世界状態がエージェント間・視点間で共有され時間発展する**必要がある。既存の autoregressive video diffusion(過去フレームを条件に次を拡散生成)は履歴を条件付けに持ち越すだけで共有状態を保てない。WorldWeaver は **world state registers(世界情報を蓄える学習可能な記憶スロット。チャンク生成ごとに更新)**を導入し、**BEV(真上からの俯瞰図)や scene text で接地**、さらに **状態推論と描画を別重みに分ける Mixture-of-Transformers** で分業させる。周辺車両(multi-agent)・自車/俯瞰(multi-view)の状態を一貫させたい driving world model に直結する設計選択肢。→ [ブリーフ](2607.21594v1.md)

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| P2 distill/ft(横断 P3/P1) | [2607.20988](2607.20988v1.md) | HyWorldVLA(pixel+latent の hybrid world-VLA、NAVSIM で E2E 自動運転) |
| P2 distill/ft | [2607.21051](2607.21051v1.md) | Experience Distillation(経験を context distillation で内在化、SFT の 17 倍回収) |
| P3 next_arch | [2607.21594](2607.21594v1.md) | WorldWeaver(world state registers + MoT で multi-agent world model) |
| P3 next_arch | [2607.20771](2607.20771v1.md) | Emergent Compositional Skills in MoE VLAs(MoE action head で原始技能が創発分離) |
| P1 planner | [2607.21341](2607.21341v1.md) | BiCompoDiff(制約を微分可能エネルギー化し拡散生成中に勾配注入、多目的軌道最適化) |
| wildcard | [2607.21461](2607.21461.md) | AREX(discovery-verification 非対称を使う再帰自己改善 deep research agent) |

落選 33 件の理由(次点 🔶 付き)+ 重複バグの記録: [rejected.md](rejected.md)

---

## プロジェクト別の要点

- **P1(Planner AI + 評価):** 在庫が薄く本枠採用は BiCompoDiff([[2607.21341]])1 件のみ(両腕マニピュレーションからの転用)。持ち帰りは **「衝突回避・comfort・実行可能性・安全マージンという競合制約を、各々微分可能な energy にして拡散生成の逆過程に勾配注入する」**という多目的 planner の作法。制約ごとにエネルギー値が出るので **軌道単位で "どの制約がどれだけ効いた/破れた" を分解**でき、planner 評価の解釈性に効く。加えて横断で **HyWorldVLA([[2607.20988]])の NAVSIM closed-loop 評価 × ノイズ頑健性軸**が P1 の評価論点に直撃。**明日:** 手持ちの軌道 diffusion prior に衝突・comfort・TTC 下限を energy 注入し、violation 率と smoothness を無ガイダンス比で測る。

- **P2(FM 蒸留 + 適合):** 2 件は「経験をどう重みに焼くか」と「world model をどう適合させるか」。Experience Distillation([[2607.21051]])は **SFT が経験の 96% を捨てる**という強い実測 + context distillation という代替 recipe——**まず自前パイプで SFT の回収率を測る**のが第一手。HyWorldVLA([[2607.20988]])の **pre-train(pixel grounding)→ co-fine-tuning(latent 専用)**の二相は、基盤 world model を自社ドメインへ適合させる recipe として転用可。次点に **adapter 容量のビット実測([[2607.21351]]、MLP に置くと約2倍書ける)**と **multi-teacher distillation×全天候 AD([[2607.21526]]、コード公開)**が渋滞、枠が空けば即拾う価値。

- **P3(次世代アーキ):** 本日の核。**"世界状態と行動をどう持つか"の設計選択**が 3 通り並んだ——(a) 予測ターゲットを **pixel か latent か**、pre-train で pixel 接地し実運用は latent 専用(HyWorldVLA [[2607.20988]])、(b) 状態を **観測履歴か明示レジスタか**、world state registers + MoT で共有状態を持つ(WorldWeaver [[2607.21594]])、(c) action head を **単一か MoE か**、MoE 化で原始技能(車線維持・合流・停止等)が expert に自然分離(MoE VLA [[2607.20771]])。driving world model を 30–60 秒 rollout で使う我々には、**latent 中心 + 明示 state register + MoE action head** が有力な組み合わせ仮説。次点 **PhysCoRe([[2607.20653]]、微分可能 MPM + residual の hybrid world model)**は枠が空けば最優先。

---

## 運用メモ(パイプライン)
- **wildcard dedup が依然未修正。** 本日の wildcard 目玉 ABot-World-0(207 up)は **3 日連続で再提示**(2026-07-23 ブリーフ済)。既ブリーフ ID を candidates 生成時に除外する修正が未実施のまま症状が続く([[fetch-duplicate-candidates]])。判断待ち。
- **在庫の分野偏重。** 本日 fm_distill_finetune タグ 30 件のうち相当数が医用/音声/無線など**ドメイン特化で P2 のコア(蒸留 recipe・PEFT・適合)から外れ**、逆に **next_arch 相当(world model/VLA)が P2 タグに紛れ込む**(HyWorldVLA など)。キーワードマッチのトピック割当が粗く、**relevance ベースの再仕分け**を人手で毎回強いられている。keyword→topic の割当精度も要改善。
