# Foundation Model Distillation & Adaptation — Living Survey
最終更新: 2026-07-05

## 一言でいうと
大きな基盤モデルの能力を、**小さく・低メモリ・ローカル実行可能**な形に移す方法を追う分野。
「どこまで縮められるか(capacity gap の破綻境界)」と「どう縮めるか(feature蒸留 / PEFT /
重み直接生成)」が二大論点。エッジ配備の適合レシピ確定が実務ゴール(R2)。

## 系譜マップ
- 何を模倣させるか
  - output 蒸留(教師出力を生徒に模倣) … ベースライン
  - **feature-level 蒸留** … 一般に output より優位
    - **Cross4D-JEPA (00514)** — dense correspondence で13x圧縮・同等。利得の主因は「粒度」
    - **Geometric FM Distillation (01851)** — feature優位 / エンコーダ温存 / SVD warm start
- 模倣でなく「重みを生成する」
  - **PAW / Program-as-Weights (02512)** — compiler が凍結interpreter用 adapter を直接emit。
    0.6B が 32B に並ぶ / 推論メモリ約1/50(amortized adaptation)
- 縮めた後の適合(PEFT)
  - **Efficient PEFT (02158)** — QLoRA/BitFit/凍結DINOv2+線形ヘッドを (精度,メモリ,エネルギー) で比較
- 直交する後段圧縮
  - **Vitality-Aware Compression (00382)** — 層ごとvitalityで圧縮強度を配分

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-05 | Program-as-Weights (2607.02512) | compilerがadapter重みを直接生成、0.6B≈32B・メモリ1/50 | [brief](../briefs/2026-07-05/2607.02512.md) |
| 2026-07-04 | Efficient PEFT (2607.02158) | 2GB予算下のPEFT比較表、凍結DINOv2+線形が微調整超え | [brief](../briefs/2026-07-04/2607.02158.md) |
| 2026-07-04 | Geometric FM Distillation (2607.01851) | feature優位 / エンコーダ温存 / SVD warm start の3原則 | [brief](../briefs/2026-07-04/2607.01851.md) |
| 2026-07-02 | Cross4D-JEPA (2607.00514) | dense対応蒸留で13x圧縮・同等、主因は粒度 | [brief](../briefs/2026-07-02/2607.00514.md) |
| 2026-07-02 | Vitality-Aware Compression (2607.00382) | 層vitalityで圧縮強度を配分(後段圧縮の着想) | [brief](../briefs/2026-07-02/2607.00382.md) |

## Open Questions
- 縮小率スイープで精度が急落する「破綻境界」は手段(feature/output/adapter生成)でどれだけ動くか?(R2 系統則)
- adapter を forward 1回で生成(PAW) vs 少データ LoRA、コスト対効果の交差点は?
- 「教師のモダリティより対応の粒度が支配的」は自社データでも成立するか?
- capacity gap を跨げる interpreter サイズの下限(0.6B/1.5B/4B スイープ)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
