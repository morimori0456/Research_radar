# Fast Generative Inference — 推論ステップを削る生成 — Living Survey
最終更新: 2026-07-19

> 新設 (2026-W29)。プランナー (P1) と world model (P3) の双方で「反復 denoising を捨てる」
> 論文が独立に3本以上溜まり、既存2サーベイのどちらにも収まらなくなったため分離した。

## 一言でいうと
軌道生成も world model も diffusion / flow matching で書けるようになった一方、車載では
**NFE (Number of Function Evaluations; サンプリング時のネットワーク評価回数) がそのままレイテンシ予算**になる。
この分野は「品質を保ったまま推論ステップを何段まで削れるか」を、学習し直さずに削る (schedule) /
学習して削る (one-step drift) / そもそも生成を1回にする、の3系統で攻めている。
削ると失うのは多様性・多峰性であり、**どこまで削ってよいかは下流タスクが決める**のが共通の教訓。

## 系譜マップ
- **学習し直さずに削る**(既存の学習済みモデルに追加コストゼロ)
  - **VSFM (11442)** — flow matching の「一定速度」という暗黙の設計選択を任意の速度プロファイル v(t) に一般化。
    学習済みモデルでも **ODE を非一様な時刻グリッド (τ-schedule) で積分するだけ**で適用可。
    利得の理由は Euler 積分の local truncation error が誘導グリッド上で小さくなるため(理論が明快)。
    プロファイルは motion planning の速度計画(braking 等)から借用しているのが面白い
- **学習して削る**(推論を単一 forward に畳む)
  - **DRIFT (14507, P1)** — 軌道 latent 空間で one-step drift。48 proposal を1回のバッチ推論で生成、
    proposal+集約が 10.82ms。alpha (ノイズ強度) で多様性/保守性を振る
  - **DriftWorld (15065, P3)** — action-conditioned drift を学習時に獲得し、推論は現在観測+候補 action から
    単一 forward で未来フレーム生成。diffusion 比 **平均17倍高速・30+fps**
  - **RynnWorld-4D (06559)** — denoising を回さず 1-forward で行動を出す(4D 予測系からの流入)
- **削った先に何が開くか**(速さが機能を生む)
  - 推論時 **action search** が実用域に入る (15065): 1制御周期あたり評価できる候補軌道の本数が桁で増える
  - **オフライン代理評価器**になる (15065): rollout スコアが ground truth と最大 **0.99 相関**
  - **実時間の対話的生成** (03118 Vidu S1): 民生 GPU 540p/42FPS。few-step 蒸留と専用サービングを対で設計
- **削ると失うものを管理する**
  - **多峰性の消失**: 候補集合を平均するとモード間の谷に落ちる (**CE-MPPI 06499** の averaging-induced failure)
  - **多様性 vs 追従性**: **Flow-ERD (06957)** — entropy 正則化 reverse-KL で teacher 追従と多様性を両立させる
    realism–diversity パレート。few-step 化の代償を明示的に測る枠組み
  - **集約の設計**: **DRIFT (14507)** — 多仮説を1本に畳む集約を **proposal 品質ラベルなし**で学習
- 直交する軸: **制約の厳守**。**MDOC (12423)** は CBF 射影を生成ステップに挿入し、
  ステップ数を削っても hard constraint (衝突回避・走行可能領域) を破らない道を示す

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-18 | DriftWorld (2607.15065) | 一発生成の action-conditioned world model、17倍高速・rollout 評価 0.99 相関 | [brief](../briefs/2026-07-18/2607.15065.md) |
| 2026-07-18 | DRIFT (2607.14507) | 軌道 latent の one-step drift で 48 proposal を1パス、ラベルなし集約 | [brief](../briefs/2026-07-18/2607.14507.md) |
| 2026-07-16 | MDOC (2607.12423) | CBF 射影で生成中も hard constraint を厳守、score は dynamics から計算 | [brief](../briefs/2026-07-16/2607.12423.md) |
| 2026-07-15 | VSFM (2607.11442) | 速度プロファイル一般化。再学習なしの τ-schedule 変更で低 NFE を改善 | [brief](../briefs/2026-07-15/2607.11442.md) |
| 2026-07-11 | Vidu S1 (2607.03118) | 民生 GPU 42FPS の実時間対話型生成(few-step 蒸留 × サービング) | [brief](../briefs/2026-07-11/2607.03118.md) |
| 2026-07-10 | Flow-ERD (2607.06957) | entropy 正則化で few-step 化の realism–diversity パレートを測る | [brief](../briefs/2026-07-10/2607.06957.md) |
| 2026-07-09 | RynnWorld-4D (2607.06559) | 4D 予測 + 1-forward で行動を出す | [brief](../briefs/2026-07-09/2607.06559.md) |

## Open Questions
- **NFE を横軸にした品質カーブは手法ごとにどう違う形をするか** — 「低 NFE で崩れる点」が
  手法選定の実質的な判断材料になるはずだが、統一プロトコルでの比較がまだない(W29 出力キューの中心仮説)
- 推論時 τ-schedule 変更 (11442) は、画像生成でなく**軌道生成**でも同じ利得を出すか。
  出るなら既存の flow-matching 軌道生成器に追加コストゼロで載る
- one-step drift で失う多峰性は、運転の意思決定(追い越すか待つか)でどこまで許容できるか。
  許容できないなら「速い生成 × 多仮説保持」を両立する構成は何か(DRIFT の proposal 集合はその一案)
- 高速 world model の rollout スコア (0.99 相関, 15065) は運転ドメインでも代理評価になるか —
  なるなら評価コストの桁が変わる(planner-evaluation サーベイの admissibility 認定と組で使う)
- **DRIFT (proposal 生成) × DriftWorld (高速 rollout 評価) を直列に繋げるか** — 1制御周期内で
  「安く多数出して、安く評価して、1本選ぶ」が閉じるかは実測しないと分からない

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
