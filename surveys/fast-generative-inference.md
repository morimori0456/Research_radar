# Fast Generative Inference — 推論ステップを削る生成 — Living Survey
最終更新: 2026-08-09

> 新設 (2026-W29)。プランナー (P1) と world model (P3) の双方で「反復 denoising を捨てる」
> 論文が独立に3本以上溜まり、既存2サーベイのどちらにも収まらなくなったため分離した。

## 一言でいうと
軌道生成も world model も diffusion / flow matching で書けるようになった一方、車載では
**NFE (Number of Function Evaluations; サンプリング時のネットワーク評価回数) がそのままレイテンシ予算**になる。
削り方は4系統 — 学習し直さずに削る(schedule)/ 学習して削る(one-step drift)/ 生成を1回にする / そして
**2026-W32 で加わった「そもそも生成を完走しない」**(深さ方向の early exit + 出力段の除去)。
最後の系統が示したのは、**削る軸は反復回数(時間方向)だけでなくネットワークの深さ方向にもある**こと、そして
**下流タスクが要求する情報は生成の完成品よりずっと手前にある**こと。
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
  - **ABot-World-0 / ODE distillation (19191)** — 多step の拡散/フロー生成を **少step に蒸留**しつつ、**LongForcing** で長 self-rollout の distribution shift を抑える。few-step 化と long-horizon drift 対策を同時に解く(vla-world-model と相互参照)
- **そもそも生成を完走しない(2026-W32 新設)— 時間方向でなく深さ方向に削り、出力段を捨てる**
  - **Adaptive-WAM (06008, P3→P1)** — video diffusion planner を制御実験で解剖したところ、
    **denoising timestep(時間方向)には性能がほぼ鈍感**で、効くのは **DiT の深さ**、しかも最終層は不要で
    **中間層 hidden state から既に良い軌道がデコードできる**。そこで複数ブロックに trajectory diffusion head を付け、
    軽量 **trajectory-quality scorer** が閾値を超えたら即打ち切り(超えなければキャッシュから続行)。
    deploy 時は **CFG の反復 denoising ループも VAE decode も実行しない** — どちらも未来動画の合成にしか要らないため。
    NAVSIM **90.8 PDMS**(固定 exit + 64 proposal で 92.6)/ **平均 170ms**(full-depth 320ms 比 47% 減)、
    target domain の fine-tuning なしで nuScenes 転移。**「world model を生成器でなく特徴抽出器として使う」**割り切り
  - 他系統との違い: VSFM / DRIFT / DriftWorld はいずれも **生成を最後まで走らせた上で**回数を削る。
    こちらは**下流タスクに必要な情報が生成の途中にある**という前提に立ち、完成品を作らない。
    **シーン難易度に応じて深さを動的配分**する点も他にない軸(vla-world-model サーベイと相互参照)
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
  ステップ数を削っても hard constraint (衝突回避・走行可能領域) を破らない道を示す。
  **BiCompoDiff (21341)** は競合制約を **微分可能 energy** 化して逆過程に勾配注入し、制約ごとに破れ量を分解できる
  (annealed MCMC の精緻化ステップは追加コストと制約充足のトレードオフ = ステップ数と品質の同じ軸)

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-08-08 | Adaptive-WAM (2608.06008) | 深さ方向の early exit + denoising/VAE decode の除去。生成を完走せず中間層から軌道を読む。90.8 PDMS / 170ms | [brief](../briefs/2026-08-08/2608.06008v1.md) |
| 2026-07-25 | BiCompoDiff (2607.21341) | 制約を微分可能 energy 化し拡散逆過程に勾配注入、制約別に破れを分解 | [brief](../briefs/2026-07-25/2607.21341v1.md) |
| 2026-07-23 | ABot-World-0 (2607.19191) | ODE distillation で少step 化 + LongForcing で long-horizon drift 抑制 | [brief](../briefs/2026-07-23/2607.19191.md) |
| 2026-07-18 | DriftWorld (2607.15065) | 一発生成の action-conditioned world model、17倍高速・rollout 評価 0.99 相関 | [brief](../briefs/2026-07-18/2607.15065.md) |
| 2026-07-18 | DRIFT (2607.14507) | 軌道 latent の one-step drift で 48 proposal を1パス、ラベルなし集約 | [brief](../briefs/2026-07-18/2607.14507.md) |
| 2026-07-16 | MDOC (2607.12423) | CBF 射影で生成中も hard constraint を厳守、score は dynamics から計算 | [brief](../briefs/2026-07-16/2607.12423.md) |
| 2026-07-15 | VSFM (2607.11442) | 速度プロファイル一般化。再学習なしの τ-schedule 変更で低 NFE を改善 | [brief](../briefs/2026-07-15/2607.11442.md) |
| 2026-07-11 | Vidu S1 (2607.03118) | 民生 GPU 42FPS の実時間対話型生成(few-step 蒸留 × サービング) | [brief](../briefs/2026-07-11/2607.03118.md) |
| 2026-07-10 | Flow-ERD (2607.06957) | entropy 正則化で few-step 化の realism–diversity パレートを測る | [brief](../briefs/2026-07-10/2607.06957.md) |
| 2026-07-09 | RynnWorld-4D (2607.06559) | 4D 予測 + 1-forward で行動を出す | [brief](../briefs/2026-07-09/2607.06559.md) |

## Open Questions
- **削る軸は「反復回数」と「深さ」のどちらが効率的か** — 06008 は timestep に鈍感で深さに敏感だと報告したが、
  これは planning が粗い情報しか使っていないからか、**NAVSIM が粗い判断しか要求していない**からか。
  合流・遮蔽・カットインのサブセットで感度が復活しないかを見れば切り分けられる
- **早期 exit の安全性を保証付きで言えるか** — trajectory-quality score を非適合度スコアとして calibration し
  「早期 exit した軌道の失敗率 ≤ α」を conformal で主張できるか(06008)。ただし **exit 位置が入力依存で変わる時点で
  交換可能性 (exchangeability) が壊れていないか**が論点。ここが解ければ R1 との接続点になる
- **scorer と exit head が同じ hidden state を共有する自己都合バイアス**はないか — 浅い exit の軌道を
  scorer が高く評価してしまう構造的な危険。早期 exit が誤った時の失敗分布を見る必要がある(06008)
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
