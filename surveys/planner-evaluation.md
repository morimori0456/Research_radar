# Planner Evaluation & Safe Motion Planning — Living Survey
最終更新: 2026-07-19

## 一言でいうと
自動運転プランナを「衝突率」一本で測る時代を終わらせ、**過保守・介入頻度・安全被覆を
保証付きで**測る評価と、その保証を計画制約に埋め込む手法を追う分野。論点は採点 → **診断** →
**評価器そのものの信頼性認定**へ拡張し、さらに「**評価セット自体が能力を測れているか**(shortcut 監査)」と
「**対向エージェントの強さ**」という評価の入力側にまで降りてきた。プランナー本体では
多仮説を安く出して1本に畳む設計が主流化し、その集約をラベルなしで学習できるかが実装上の焦点。

## 系譜マップ
- 安全保証を計画に埋め込む
  - conformal prediction 系 … 予測不確実性を分布フリー保証に変換
    - **Conformalized Distance Fields (FCP/AFCP, 00776)** — 距離場ごとに conformalize、online 更新
  - 時空間最適化系 … 通行可能領域の過渡的開閉を凸集合で定式化
    - **ST-GCS (00444)** — space-time の凸集合グラフ、ECD 占有予約
  - 生成の途中に安全を強制: **MDOC (12423)** — CBF 射影を diffusion ステップに挿入(学習型プランナーの後段に後付け可)
- プランナー本体: 多仮説の生成と集約(今週の主戦線)
  - **DRIFT (14507)** — 軌道 latent の one-step drift で 48 proposal を1パス、**品質ラベルなし**で集約を学習。NAVSIM EPDMS 90.4 / 10.82ms
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
- 評価データ・評価語彙
  - **K-Risk (07103)** — 20 データセット統一基準の高リスクシナリオバンク(extreme 1,036 件)
  - **AUTOPILOT-VQA (08745)** — incident 中心 VQA。avoidability(回避可能性)を問う質問設計
- 縦の接続仮説: 予測不確実性 →(FCP)conformal 制約 →(ST-GCS)時空間予約。
  評価軸の三層: **評価セットの健全性 (29616) → 対向エージェントの強さ (13028) → 評価器の認定 (07196)**。
  評価基盤 →(Post-Training サーベイ 08072)学習信号の供給源として再定義。

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
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
