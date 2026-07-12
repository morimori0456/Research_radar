# Foundation Model Distillation & Adaptation — Living Survey
最終更新: 2026-07-12

## 一言でいうと
大きな基盤モデルの能力を**小さく・低メモリ・ローカル実行可能**な形に移し、他ドメイン・
他機種へ適合させる方法を追う分野。論点は「どう縮めるか(手法: feature 蒸留 / PEFT / 重み生成)」
から「**何で教えるか(蒸留データの分布と選定)**」と「**挙動レベルで診断できているか
(集計 loss に見えないシフト、train/deploy mismatch)**」へ広がった。エッジ配備の適合レシピ確定が実務ゴール(R2)。

## 系譜マップ
- 何を模倣させるか(手法)
  - output 蒸留(教師出力を模倣)… ベースライン
  - **feature-level 蒸留** … 一般に output より優位
    - **Cross4D-JEPA (00514)** — dense correspondence で 13x 圧縮・同等。利得の主因は「粒度」
    - **Geometric FM Distillation (01851)** — feature 優位 / エンコーダ温存 / SVD warm start
  - タスク空間の中間表現経由: **TGRIP (04812)** — semantic BEV map 経由で異アーキ teacher→student、capacity gap に強い
  - 模倣でなく「重みを生成する」: **PAW (02512)** — compiler が adapter を直接 emit、0.6B≈32B・メモリ 1/50
- 何で教えるか(データ)← 今週の主戦線
  - 分布の広さ: **ZipDepth (08771)** — 頑健性は teacher でなく multi-domain データで決まる。1/50 サイズで zero-shot 保持
  - 少データの選定: **Few-Medoids (05891)** — クラス centroid 近傍の典型例選定が random に一貫勝ち
  - 合成データ: **constraint-first 合成 pre-training (06483)** — 物理制約だけ守りリアリズムを捨てて多様性極大化
- 挙動レベルの診断・校正
  - **Soft Clamp (07050)** — 少数 token の leverage 不均衡による挙動シフトを per-token 発散の圧縮で校正
  - **MIPI/MIPU (29526)** — train/deploy エンジンのズレ(training-inference mismatch)と selective acceptance
  - **Flow-ERD (06957)** — entropy 正則化 reverse-KL で teacher 追従と多様性維持を両立
- 縮めた後の適合(fine-tuning / ドメイン適合)
  - PEFT 比較: **Efficient PEFT (02158)** — (精度, メモリ, エネルギー) の比較表
  - 機種条件付き on-policy 蒸留: **UI-MOPD (04425)** — 機種別 teacher 群→単一 student、忘却防止と同構造
  - アノテーション無し cross-domain: **Wat3R (08772)** — teacher-student + 幾何整合 loss、評価セットは先に小さく作る
  - 転移の正則化: **UNIVERSE (05133)** — video co-training が zero-shot 転移を改善(詳細は vla-world-model 側)
- 直交する後段圧縮: **Vitality-Aware Compression (00382)** — 層ごと vitality で圧縮強度を配分

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
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
- 縮小率スイープで精度が急落する「破綻境界」は手段(feature/output/adapter 生成)でどれだけ動くか?(R2 系統則)
- **「頑健性はデータ分布の広さで決まる」(ZipDepth) は破綻境界も右に動かすか — データ×手法の交互作用**(R2 の新変数)
- adapter を forward 1回で生成(PAW)vs 少データ LoRA、コスト対効果の交差点は?
- capacity gap を跨げる interpreter サイズの下限(0.6B/1.5B/4B スイープ)
- 集計 loss に見えない挙動シフトは、軌道生成のような非言語 token 列でも per-token 診断で検出できるか?
- 蒸留の目的関数を deploy 時挙動(量子化後)に張り替えると、capacity gap 大の設定で効くか?(MIPI の移植)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
