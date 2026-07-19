# Foundation Model Distillation & Adaptation — Living Survey
最終更新: 2026-07-19

## 一言でいうと
大きな基盤モデルの能力を**小さく・低メモリ・ローカル実行可能**な形に移し、他ドメイン・
他機種へ適合させる方法を追う分野。論点は「どう縮めるか(手法)」→「**何で教えるか(蒸留データ)**」→
「**挙動レベルで診断できているか**」と広がり、今は **teacher の要否そのもの**が問われている:
生徒自身の軌跡から dense 信号を作る (self-distillation)、teacher の *最終状態* でなく *学習の差分* を運ぶ、
点ごとの一致でなく *関係構造* を運ぶ。同時に「蒸留データの作り方が静かにデータを壊す」負の知見も出た(R2)。

## 系譜マップ
- 何を模倣させるか(手法)
  - output 蒸留(教師出力を模倣)… ベースライン
  - **feature-level 蒸留** … 一般に output より優位
    - **Cross4D-JEPA (00514)** — dense correspondence で 13x 圧縮・同等。利得の主因は「粒度」
    - **Geometric FM Distillation (01851)** — feature 優位 / エンコーダ温存 / SVD warm start
  - タスク空間の中間表現経由: **TGRIP (04812)** — semantic BEV map 経由で異アーキ teacher→student、capacity gap に強い
  - **関係構造を運ぶ**: **MobileSAM2 / HyperKD (12297)** — hypergraph で時間対応(フレーム間)と多粒度マスクの知識を構造ごと転写。点ごとの一致より student の容量要求が緩い。蒸留 loss を student アーキ探索 (NAS) の目的関数にも使う
  - 模倣でなく「重みを生成する」: **PAW (02512)** — compiler が adapter を直接 emit、0.6B≈32B・メモリ 1/50
- teacher の要否を問い直す(今週の主戦線)
  - **最終状態でなく「学習の差分」を運ぶ**: **Direct-OPD (05394)** — 小モデルで RL を回し、(pre-RL, post-RL) の log 比を dense な implicit reward として強い student に適用。ターゲット上で高価な RL を回さずに weak→strong
  - **固定 teacher を要さない self-distillation**: **SEED (14777)** — 生徒自身が自分の軌跡から hindsight skill を抽出し、skill 有無の確率差を token 単位の dense 蒸留信号に変換、outcome RL と同時最適化(off-policy 分布ずれを回避)
  - **student 自身を摂動の条件に**: **SAKD (11557)** — teacher の静的特徴でなく進化中の student 特徴を条件に、パラメータフリーの cyclic shift で多様なビューを生成。追加パラメータ・多段学習なしで multi-teacher 級
- 何で教えるか(データ)
  - **負の知見**: **Answer-Conditioned CoT (14552)** — 失敗サンプルを gold answer で救済すると答えから逆向きに正当化した chain になり、**correctness filter で検出できない形で**データが劣化(最難問で最大 ~27pt)。症状は early final-answer statement、処方は **answer-blind 生成**
  - 分布の広さ: **ZipDepth (08771)** — 頑健性は teacher でなく multi-domain データで決まる。1/50 サイズで zero-shot 保持
  - 少データの選定: **Few-Medoids (05891)** — クラス centroid 近傍の典型例選定が random に一貫勝ち
  - 合成データ: **constraint-first 合成 pre-training (06483)** — 物理制約だけ守りリアリズムを捨てて多様性極大化
- 挙動レベルの診断・校正
  - **Soft Clamp (07050)** — 少数 token の leverage 不均衡による挙動シフトを per-token 発散の圧縮で校正
  - **MIPI/MIPU (29526)** — train/deploy エンジンのズレ(training-inference mismatch)と selective acceptance
  - **Flow-ERD (06957)** — entropy 正則化 reverse-KL で teacher 追従と多様性維持を両立
- 縮めた後の適合(fine-tuning / ドメイン適合)
  - **容量の配り直し**: **UMoE (11444)** — SFT の *前* に低 saliency expert を prune → 摂動で regrow。**パラメータ数・推論コスト不変**のまま単一 frozen recipe で 2アーキ×5ドメイン×12ベンチ全勝
  - **入力仕様の違いを branch で吸収**: **MBTI (12782)** — 入力を共通仕様に潰さず連続帯ごとに branch 分割し branch 別 LoRA + attention 融合。センサ構成が違う他機種への適合の縮図(学習は全体の 2.3%)
  - PEFT 比較: **Efficient PEFT (02158)** — (精度, メモリ, エネルギー) の比較表
  - 機種条件付き on-policy 蒸留: **UI-MOPD (04425)** — 機種別 teacher 群→単一 student、忘却防止と同構造
  - アノテーション無し cross-domain: **Wat3R (08772)** — teacher-student + 幾何整合 loss、評価セットは先に小さく作る
  - 転移の正則化: **UNIVERSE (05133)** — video co-training が zero-shot 転移を改善(詳細は vla-world-model 側)
- 直交する後段圧縮: **Vitality-Aware Compression (00382)** — 層ごと vitality で圧縮強度を配分

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-18 | SEED (2607.14777) | 生徒自身の軌跡から hindsight skill を抽出、確率差を dense 蒸留信号に | [brief](../briefs/2026-07-18/2607.14777.md) |
| 2026-07-18 | Answer-Conditioned CoT (2607.14552) | gold を見せた chain 生成は filter を通り抜けてデータを最大27pt劣化させる | [brief](../briefs/2026-07-18/2607.14552.md) |
| 2026-07-16 | MobileSAM2 / HyperKD (2607.12297) | hypergraph で時間対応と多粒度を構造ごと転写する動画 FM 蒸留 | [brief](../briefs/2026-07-16/2607.12297.md) |
| 2026-07-16 | MBTI (2607.12782) | センサ構成差を branch 別 LoRA + attention 融合で吸収する PEFT | [brief](../briefs/2026-07-16/2607.12782.md) |
| 2026-07-15 | UMoE (2607.11444) | SFT 前の prune→regrow だけで推論コスト不変のままドメイン適合を底上げ | [brief](../briefs/2026-07-15/2607.11444.md) |
| 2026-07-15 | SAKD (2607.11557) | student の進化中特徴を条件に cyclic shift でビュー生成、追加パラメータなし | [brief](../briefs/2026-07-15/2607.11557.md) |
| 2026-07-15 | Direct-OPD (2607.05394) | teacher の RL 前後の log 比=「学習の差分」を dense reward として weak→strong | [brief](../briefs/2026-07-15/2607.05394.md) |
| 2026-07-11 | ZipDepth (2607.08771) | 6.1M で FM 級 zero-shot 深度。鍵は multi-domain 蒸留データ | [brief](../briefs/2026-07-11/2607.08771.md) |
| 2026-07-11 | Wat3R (2607.08772) | アノテーションゼロの cross-domain 3D 適合 recipe(悪天候に読み替え可) | [brief](../briefs/2026-07-11/2607.08772.md) |
| 2026-07-10 | Soft Clamp (2607.07050) | multi-teacher 蒸留の挙動シフトを token leverage で解明・校正 | [brief](../briefs/2026-07-10/2607.07050.md) |
| 2026-07-10 | Flow-ERD (2607.06957) | entropy 正則化 reverse-KL の closed-loop 蒸留、realism–diversity Pareto | [brief](../briefs/2026-07-10/2607.06957.md) |
| 2026-07-09 | Few-Medoids (2607.05891) | 少データ蒸留は「典型例選定」だけで random に勝つ | [brief](../briefs/2026-07-09/2607.05891.md) |
| 2026-07-09 | 合成 pre-training (2607.06483) | 制約優先・リアリズム放棄の合成データで少データ適合 40% 改善 | [brief](../briefs/2026-07-09/2607.06483.md) |
| 2026-07-08 | TGRIP (2607.04812) | VLM 知識を semantic BEV 経由で車載ネットに蒸留、annotation 不要 | [brief](../briefs/2026-07-08/2607.04812.md) |
| 2026-07-08 | UI-MOPD (2607.04425) | 機種条件付き単一 student への on-policy 蒸留、忘却防止 | [brief](../briefs/2026-07-08/2607.04425.md) |
| 2026-07-07 | MIPI/MIPU (2606.29526) | training-inference mismatch: 最適化対象と deploy 挙動のズレを疑え | [brief](../briefs/2026-07-07/2606.29526.md) |
| 2026-07-05 | Program-as-Weights (2607.02512) | compiler が adapter 重みを直接生成、0.6B≈32B・メモリ 1/50 | [brief](../briefs/2026-07-05/2607.02512.md) |
| 2026-07-04 | Efficient PEFT (2607.02158) | 2GB 予算下の PEFT 比較表、凍結 DINOv2+線形が微調整超え | [brief](../briefs/2026-07-04/2607.02158.md) |
| 2026-07-04 | Geometric FM Distillation (2607.01851) | feature 優位 / エンコーダ温存 / SVD warm start の3原則 | [brief](../briefs/2026-07-04/2607.01851.md) |
| 2026-07-02 | Cross4D-JEPA (2607.00514) | dense 対応蒸留で 13x 圧縮・同等、主因は粒度 | [brief](../briefs/2026-07-02/2607.00514.md) |
| 2026-07-02 | Vitality-Aware Compression (2607.00382) | 層 vitality で圧縮強度を配分(後段圧縮の着想) | [brief](../briefs/2026-07-02/2607.00382.md) |

## Open Questions
- **teacher は本当に要るか** — SEED (self) / Direct-OPD (差分) / SAKD (student 条件) は
  いずれも teacher への依存を減らす方向。capacity gap が大きい設定でどこまで teacher-free で届くか
- 「学習の差分を蒸留する」(05394) は非言語 token 列(軌道生成)に移せるか。
  reference チェックポイントの選び方に結果がどれだけ敏感か
- 蒸留データの静かな劣化 (14552) は運転ドメインにも同型の罠があるか —
  例: 失敗軌道を「正解軌道に寄せて」再生成する data augmentation は同じ後付け正当化を作らないか
- 関係構造の蒸留 (12297) は、点ごとの feature KD より本当に容量要求が緩いのか(縮小率スイープで検証可能)
- 推論コスト不変の容量再配分 (11444) は dense モデル(FFN ニューロン単位 saliency)にも効くか
- 縮小率スイープで精度が急落する「破綻境界」は手段(feature/output/adapter 生成)でどれだけ動くか?(R2 系統則)
- **「頑健性はデータ分布の広さで決まる」(ZipDepth) は破綻境界も右に動かすか — データ×手法の交互作用**(R2 の新変数)
- adapter を forward 1回で生成(PAW)vs 少データ LoRA、コスト対効果の交差点は?
- capacity gap を跨げる interpreter サイズの下限(0.6B/1.5B/4B スイープ)
- 集計 loss に見えない挙動シフトは、軌道生成のような非言語 token 列でも per-token 診断で検出できるか?
- 蒸留の目的関数を deploy 時挙動(量子化後)に張り替えると、capacity gap 大の設定で効くか?(MIPI の移植)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
