# Planner Evaluation & Safe Motion Planning — Living Survey
最終更新: 2026-08-09

## 一言でいうと
自動運転プランナを「衝突率」一本で測る時代を終わらせ、**過保守・介入頻度・安全被覆を保証付きで**測る評価と、
その保証を計画制約に埋め込む手法を追う分野。論点は採点 → 診断 → 評価器の認定 → 評価の入力側(shortcut 監査・
対向エージェントの強さ)→ **未来を展開して選別する**(particle / world model rollout の cost-vs-risk Pareto)と降り、
いま芯にあるのは **「最終スコア1つを中間構造に分解せよ」**: 衝突率を **エンティティ別の確率 × 深刻度**に、
成否の1ビットを **中間マイルストーンの回収率**に、失敗を **予期ミス / 反応ミス**に、性能を **計算予算あたりの性能**に。
評価の入力側も **検証済みシナリオを再帰的に難化**させて飽和ベンチを脱する方向へ。
プランナー本体では多仮説を安く出し1本に畳む集約をラベルなしで学習でき、制約は微分可能 energy として生成に注入する。

## 系譜マップ
- **最終スコア1つを中間構造に分解する(2026-W32 の芯)— 一律スカラーをやめる4方向**
  - **被害を「確率 × 深刻度」に分解**: **Failing Gracefully / FailBench (05313)** — 故障は必ず起きる前提に立ち、
    「誰と接触しうるか」の確率と「その相手にとってどれだけ酷いか」の深刻度を**別々に定量化**して planner の
    意思決定に入れる。一律の衝突率は**歩行者と路側構造物を同じ重みで潰している**。あわせて **MuJoCo ベースの
    故障注入基盤**を公開し、センサ異常・アクチュエータ故障を「たまに起きる事故」でなく**制御可能な実験変数**にした。
    **R1(過保守・介入頻度を保証付きで測る)の骨格そのもの** — 深刻度重み付き被害期待値は conformal の
    非適合度スコアにそのまま載る(家庭サービスロボット由来、指標の定式化のみ移植)
  - **成否の1ビットを中間マイルストーンに分解**: **ABSeeker (05102)** — 正解から逆算して「途中で掴んでいるべき
    だった手がかり」を復元し各ステップを採点。**失敗軌道にも部分点が入る**ので、現在の「衝突したか否か」を
    「必要な認知イベントをいくつ踏んだか」に置き換えれば**失敗走行同士に優劣が付く** /
    **AgentOPSD (05987)** — teacher/student の確率差を log-odds 空間で再帰更新し **信念の変化量が大きい turn** を
    pivotal と判定。**衝突の 0.5 秒前(手遅れ)でなく 5 秒前の車線選択(真の分岐点)**を指せる可能性
    (fm-distillation サーベイと相互参照。運転では「1 turn とは何か」の設計が最初の壁)
  - **予測失敗を「予期ミス / 反応ミス」に分解**: **INTraJ (05673)** — social influence を **planning 段階
    (他者の未来から reference trajectory を作る)と reaction 段階(full-context 予測との残差)**に明示分解。
    予測が外れた時に**大枠の予期を間違えたのか局所反応の見積もりを外したのか**を切り分けられる。
    FDE と long-horizon 一貫性で効く = **planner が効く 3〜8 秒先**の改善を ADE 中心の評価は見落とす。Argoverse 2
  - **性能を「計算予算あたりの性能」に分解**: **Adaptive-WAM (06008)** — NAVSIM PDMS と **end-to-end latency
    (170ms)を同じ表で報告**。我々の評価は精度に偏っており、**latency 予算を固定した PDMS** を常設指標に足すべき。
    trajectory-quality scorer は軌道単位の信頼度を出すので conformal の非適合度スコア候補
    (vla-world-model / fast-generative-inference サーベイと相互参照)
- **評価の入力側を「再帰的に難化」させる(2026-W32 新設)— 飽和ベンチへの回答**
  - **RST (05466)** — 検証済み seed から **(instruction, environment, reference solution, verifier) の4点を
    整合させたまま再帰的に難化**。肝は「作ってから検証」ではなく **「検証を通ったものだけが次の種になる」**。
    15 ラウンドで強モデルの pass@4 が 90% → 2.5%、**1件 $0.05**。運転に写すと
    **(シナリオ, 参照走行, 評価器) の三点セットを自動難化**するパイプライン。ただしターミナルは決定的で
    verifier が書きやすいという圧倒的に有利な条件があり、**連続・確率的・多目的な運転で verifier をどう追従させるかが
    我々側の研究余地**(EXPLORE 枠からの移植、hf 206)
- 安全保証を計画に埋め込む
  - conformal prediction 系 … 予測不確実性を分布フリー保証に変換
    - **Conformalized Distance Fields (FCP/AFCP, 00776)** — 距離場ごとに conformalize、online 更新
  - 時空間最適化系 … 通行可能領域の過渡的開閉を凸集合で定式化
    - **ST-GCS (00444)** — space-time の凸集合グラフ、ECD 占有予約
  - 生成の途中に安全を強制: **MDOC (12423)** — CBF 射影を diffusion ステップに挿入(学習型プランナーの後段に後付け可)
- 未来を「展開して」選別・監督する(2026-W30 の芯)— open-loop の過保守を closed-loop 展開で断つ
  - **closed-loop policy 空間 + particle rollout risk**: **Kinodynamic Planning (SMO-SST, 19284)** — open-loop 評価は自車の反応を無視し過保守。計画空間を **closed-loop policy の系列**に移し、risk を **Monte-Carlo particle rollout** で木構築に組込み、**cost vs risk の Pareto-front** を出す。非ガウス不確実性に有限サンプルの違反確率上界。planner を単一スコアでなくフロントで比較する評価軸に転用可
  - **world model rollout でランキング**: **Masked Visual Actions (19343)** — 学習済み driving world model に自車候補軌跡を Masked Visual Action として展開、rollout の collision/progress で planner を順位付け → 実 closed-loop との相関(open-loop で closed-loop を近似)。vla-world-model サーベイと相互参照
  - **軽量 closed-loop 評価の足場**: **ABot-World-0 (19191)** — RTX 5090 単体 720P 16FPS の対話 rollout。実 sim の代替として評価環境を自前で組む
  - **consequence-aware evaluator**: **NaviLane (18887)** — vectorized lane prior + **候補を interaction risk で順位付け**、可変個数の未来を **discrete macro-action codebook** で表現(海事ドメイン、方法論移植)
- 評価から「抽出器の誤差」を追い出す(2026-W30 新設)
  - **KineBench (19876)** — 生成映像から行動を逆推定する IDM をやめ、汎用視覚 FM で手先 6D pose を直接抽出 → 物理シミュ再実行で closed-loop 検証。IDM が OOD で壊れる **attribution ambiguity**(world model が悪いのか抽出器が悪いのか)を断つ。NAVSIM の帰属曖昧さ論点に直撃
- prediction と planning の重み競合(2026-W30)
  - **DPT / Unified Prediction & Planning (19971)** — 予測と計画を1 backbone に載せると層/チャネル単位で重みを奪い合う **Skill Conflict**。タスク別に核パラメータを分離 → **sparse merge** で解く。層別勾配コサインで競合を可視化できる
- プランナー本体: 多仮説の生成と集約 / 制約の注入
  - **DRIFT (14507)** — 軌道 latent の one-step drift で 48 proposal を1パス、**品質ラベルなし**で集約を学習。NAVSIM EPDMS 90.4 / 10.82ms
  - **BiCompoDiff (21341)** — 衝突回避・comfort・実行可能性・安全マージンという競合制約を各々 **微分可能 energy** 化し拡散生成の逆過程に勾配注入。制約ごとに energy が出るので **軌道単位で「どの制約がどれだけ効いた/破れた」を分解**でき評価の解釈性に効く(両腕マニピュレーション由来、転用)
  - **MDOC (12423)** — score を既知 dynamics から計算(デモデータ不要)、multi-robot は CBS で分解
  - **VSFM (11442)** — flow matching の「一定速度」前提を motion planning 由来の速度プロファイルに一般化。**再学習なしの推論時 τ-schedule 変更**で低 NFE 域を改善
  - **CE-MPPI (06499)** — rollout 分布の多峰性で averaging-induced failure を検出(集約の失敗モード側)
- 評価基盤(closed-loop / HIL / 学習ベース sim)
  - 決定論的 HIL: **CommonRoad-Game (01382)** — wall-clock 同期で対人評価を再現可能に
  - 生成型 closed-loop: **Point as Skeleton (06516)** — 点群骨格で係留した自己回帰映像生成、nuPlan IF 公開
  - 高速 world model による代理評価: **DriftWorld (15065)** — 一発生成で 30+fps、rollout スコアが実測と最大 **0.99 相関**
  - 評価器の認定: **WM Admissibility (07196)** — L0–L4 ladder。視覚品質と行動追従性の「逆転」を実証
- 評価の入力側を疑う(新設: 評価セットと対向エージェント)
  - シナリオ監査: **Video-Oasis (29616)** — ベンチの **55% が入力を見ずに解ける shortcut**。「監査→フィルタ→残った難問で設計比較」の3段。open-loop planning の ego-status 近道と同型
  - 対向エージェントの強化: **TerraZero (13028)** — self-play で育てた sim agents はログ再生より攻めた挙動を作れる。InterPlan / val14 の参照点
- 評価の診断化(最終スコアから過程・モードの分解へ)
  - **EvoPolicyGym (02440)** — 固定 interaction budget 下の policy 改善過程を trajectory 単位で診断
  - **GaP (05369)** — planner を計算グラフとして生成、失敗シナリオ→回帰テスト自動生成
  - **RoboHarness (18060)** — 異種 planner(rule/learned/MPC)の集合で、各 planner の **in-distribution state region を推定**し planner 間の **disagreement** を「どの planner も自信のない領域」の検知 = fallback trigger / eval シグナルに(manipulation 由来、設計思想の移植)
- 評価データ・評価語彙
  - **K-Risk (07103)** — 20 データセット統一基準の高リスクシナリオバンク(extreme 1,036 件)
  - **AUTOPILOT-VQA (08745)** — incident 中心 VQA。avoidability(回避可能性)を問う質問設計
- 縦の接続仮説: 予測不確実性 →(FCP)conformal 制約 →(ST-GCS)時空間予約。
  評価軸の三層: **評価セットの健全性 (29616) → 対向エージェントの強さ (13028) → 評価器の認定 (07196)**。
  評価基盤 →(Post-Training サーベイ 08072)学習信号の供給源として再定義。

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-08-09 | AgentOPSD (2608.05987) | teacher/student の log-prob 差を log-odds Bayesian 更新し pivotal turn を同定(失敗の帰属に転用) | [brief](../briefs/2026-08-09/2608.05987.md) |
| 2026-08-09 | ABSeeker (2608.05102) | 正解から逆算した中間 clue の回収率で採点、失敗軌道に部分点を付ける | [brief](../briefs/2026-08-09/2608.05102.md) |
| 2026-08-08 | Failing Gracefully / FailBench (2608.05313) | 被害を確率 × エンティティ別深刻度に分解、故障を制御可能な実験変数にする sim 基盤 | [brief](../briefs/2026-08-08/2608.05313v1.md) |
| 2026-08-08 | INTraJ (2608.05673) | social influence を planning 段階と reaction 残差に分解、失敗の帰属が付く。Argoverse 2 | [brief](../briefs/2026-08-08/2608.05673v1.md) |
| 2026-08-08 | Adaptive-WAM (2608.06008) | PDMS と end-to-end latency を同じ表で報告、計算予算あたりの性能という評価軸 | [brief](../briefs/2026-08-08/2608.06008v1.md) |
| 2026-08-08 | RST (2608.05466) | 検証済みタスクを種に (課題, 模範解, 採点器) を再帰的に難化、$0.05/件 | [brief](../briefs/2026-08-08/2608.05466.md) |
| 2026-07-25 | BiCompoDiff (2607.21341) | 競合制約を微分可能 energy 化し拡散生成に勾配注入、制約別に破れを分解 | [brief](../briefs/2026-07-25/2607.21341v1.md) |
| 2026-07-24 | DPT / Unified Pred&Plan (2607.19971) | 予測と計画の Skill Conflict を層別勾配で可視化、sparse merge で分離 | [brief](../briefs/2026-07-24/2607.19971v1.md) |
| 2026-07-24 | KineBench (2607.19876) | IDM-free で world model を closed-loop 評価、抽出器誤差を評価から分離 | [brief](../briefs/2026-07-24/2607.19876v1.md) |
| 2026-07-23 | Kinodynamic Planning (2607.19284) | closed-loop policy 空間 + particle rollout risk で cost-vs-risk Pareto-front | [brief](../briefs/2026-07-23/2607.19284.md) |
| 2026-07-23 | Masked Visual Actions (2607.19343) | world model rollout の collision/progress で planner をランキング | [brief](../briefs/2026-07-23/2607.19343.md) |
| 2026-07-23 | NaviLane (2607.18887) | vectorized lane prior + consequence-aware evaluator(海事→AD 移植) | [brief](../briefs/2026-07-23/2607.18887.md) |
| 2026-07-22 | GeoWorldAD (2607.17521) | latent future geometry で過保守を減らし NAVSIM v1/v2 SOTA、collision-vs-progress | [brief](../briefs/2026-07-22/2607.17521.md) |
| 2026-07-22 | RoboHarness (2607.18060) | planner の in-distribution 推定と disagreement を fallback trigger / eval に | [brief](../briefs/2026-07-22/2607.18060.md) |
| 2026-07-18 | DRIFT (2607.14507) | one-step drift で 48 proposal を1パス、品質ラベルなしで集約学習。EPDMS 90.4 | [brief](../briefs/2026-07-18/2607.14507.md) |
| 2026-07-18 | DriftWorld (2607.15065) | 一発生成の world model、rollout スコアが実測と 0.99 相関(代理評価器) | [brief](../briefs/2026-07-18/2607.15065.md) |
| 2026-07-16 | TerraZero (2607.13028) | デモ0件 self-play RL、InterPlan 首位。閉ループ評価の対向エージェント供給源 | [brief](../briefs/2026-07-16/2607.13028.md) |
| 2026-07-16 | MDOC (2607.12423) | デモ不要の model-based diffusion + CBF 射影で hard constraint を厳守 | [brief](../briefs/2026-07-16/2607.12423.md) |
| 2026-07-15 | VSFM (2607.11442) | 速度プロファイル一般化。推論時 τ-schedule 変更のみで低 NFE 品質を改善 | [brief](../briefs/2026-07-15/2607.11442.md) |
| 2026-07-13 | Video-Oasis (2603.29616) | ベンチの 55% が shortcut。評価セットを監査してフィルタする診断プロトコル | [brief](../briefs/2026-07-13/2603.29616.md) |
| 2026-07-11 | AUTOPILOT-VQA (2607.08745) | incident 中心 dashcam VQA、avoidability の評価語彙 | [brief](../briefs/2026-07-11/2607.08745.md) |
| 2026-07-10 | K-Risk (2607.07103) | 高リスク運転事象 31,398 件の統一基準バンク、closed-loop 検証付き | [brief](../briefs/2026-07-10/2607.07103.md) |
| 2026-07-10 | WM Admissibility (2607.07196) | 評価器としての world model を L0–L4 で認定、視覚品質×行動追従の逆転 | [brief](../briefs/2026-07-10/2607.07196.md) |
| 2026-07-09 | Point as Skeleton (2607.06516) | 点群骨格係留の生成型 closed-loop 評価、nuPlan IF 公開 | [brief](../briefs/2026-07-09/2607.06516.md) |
| 2026-07-09 | CE-MPPI (2607.06499) | クラスタリング内蔵 MPPI で平均化故障を解消、hesitation 指標の着想 | [brief](../briefs/2026-07-09/2607.06499.md) |
| 2026-07-08 | GaP (2607.05369) | 失敗シナリオから回帰テスト用 sim 課題を自動生成する自己改良ループ | [brief](../briefs/2026-07-08/2607.05369.md) |
| 2026-07-06 | EvoPolicyGym (2607.02440) | budget 配分×feedback→調整を trajectory 単位で診断する評価哲学 | [brief](../briefs/2026-07-06/2607.02440.md) |
| 2026-07-04 | CommonRoad-Game (2607.01382) | wall-clock 同期の決定論的 HIL で対人プランナ評価を再現可能に | [brief](../briefs/2026-07-04/2607.01382.md) |
| 2026-07-02 | ST-GCS (2607.00444) | 時空間凸集合グラフで time-optimal 計画、予測を占有予約に | [brief](../briefs/2026-07-02/2607.00444.md) |
| 2026-07-02 | Conformalized Distance Fields (2607.00776) | 距離場を conformalize し分布フリー安全保証を MPC に | [brief](../briefs/2026-07-02/2607.00776.md) |

## Open Questions
- **エンティティ別の深刻度重みを入れると planner の順位は入れ替わるか**(05313)— 既存の評価ログを重み付きで
  再集計するだけで測れる。**入れ替わるなら現行指標は誤った planner を選んでいた**ことになり R1 の新規性主張が1つ立つ
  (W32 推薦実験。前提: 評価ログに衝突相手のエンティティ種別が残っていること)
- 故障(カメラ dropout・100–300ms 遅延・操舵応答劣化)を注入すると、正常系で同点の planner は分かれるか(05313)。
  分かれるなら「正常系 PDMS だけを見る評価」は実配備で効く差を潰している
- **失敗走行同士に優劣を付けられるか** — 逆算で抽出したサブゴールの回収率(05102)で、
  「回収率が高いのに失敗」と「低くて失敗」が分離するか。分離すれば飽和ベンチ問題への別解になる
- pivotal turn の同定(05987)は、人手アノテーションした「分岐点」とどれだけ一致するか。
  そもそも**分岐点は人間の間で一致するのか**(手法実装より先にここを確かめる)
- **latency 予算を固定した PDMS**(100/200/400ms)を常設指標にすると planner の序列はどう変わるか(06008)
- 予測を reference / residual に分解(05673)した時、我々の失敗ケースはどちらに偏るか。
  **予測精度 → planning 品質の伝達率**が薄いなら予測改良への投資を止める判断材料になる
- RST 型の再帰難化(05466)で、運転の verifier をどう追従させるか — シナリオを難しくすると
  **何をもって成功とするかの定義自体が曖昧になる**(譲るべきか進むべきか)。ここが本丸の研究余地
- **particle rollout の collision 確率(有限サンプル上界付き, 19284)は、open-loop collision 指標の過保守をどれだけ減らすか** —
  NAVSIM シナリオで両者を並べれば「うちの評価がどれだけ甘い/過保守か」が数字で出る(W30 実験候補)
- world model rollout ランキング (19343) は実 closed-loop メトリクスとどれだけ相関するか。Kinodynamic の
  particle-rollout risk 上界と接げば world model 上の closed-loop risk 推定パイプラインになるか
- unified 予測+計画の Skill Conflict (19971) は自社モデルで層別勾配コサインが負になる層として実在するか。
  sparse merge の merge 率と collision/progress のトレードオフ曲線はどう出るか
- KineBench 型 (19876) の IDM-free 評価は、NAVSIM の帰属曖昧さをどれだけ解消するか(vla-world-model と共有)
- **自社の評価セットは何割が「知覚を見ずに解ける」か**(Video-Oasis 型 blind evaluation。W29 推薦実験)
- 対向エージェントをログ再生 → self-play 型に替えると collision/TTC はどれだけ悪化するか
  = 現行評価がどれだけ甘いかの定量化(13028)
- 高速 world model の rollout スコア (DriftWorld で 0.99 相関) は、運転ドメインでも実測 EPDMS の
  代理になるか。なるなら評価コストの桁が変わる(07196 の admissibility 認定と組で使えるか)
- 多仮説の集約を品質ラベルなしで学習する (DRIFT) 際、何が暗黙の選好になっているか —
  「安全側に寄る」のか「平均に落ちる」のか、多峰シーンで分解して見る必要
- 距離場ごとの conformal 被覆は、時間ステップ間の相関をどう扱うと過保守を抑えられるか?
- HIL で採取した対人ログを「certified-safe 率/過保守率」の評価に載せられるか(R1 の合わせ技)
- admissibility (L1–L2) を通過した world model 上の評価は、ログ再生評価とどこで乖離するか
  (06516 の公開 IF で測定可能 — W28 推薦実験)
- 「world model 上での planner 合否判定」の誤り率に conformal 的な分布フリー上界を与えられるか
  (07196 × 00776 の接続 — R1 の新規性候補)
- K-Risk の extreme サブセットは既存シナリオ集で見えない failure mode を出すか
- trajectory diagnostics(budget×feedback)を「介入頻度・過保守」軸とどう合成するか(R1)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
