# Planner Evaluation & Safe Motion Planning — Living Survey
最終更新: 2026-07-05

## 一言でいうと
自動運転プランナを「衝突率」だけで測る時代を終わらせ、**過保守・対人介入頻度・
安全被覆を保証付きで**測る評価と、その保証を計画制約に埋め込む手法を追う分野。
評価基盤(HIL/決定論的sim)と安全保証(conformal)の両輪で進む。

## 系譜マップ
- 安全保証を計画に埋め込む
  - conformal prediction 系 … 予測不確実性を分布フリー保証に変換
    - **Conformalized Distance Fields (FCP/AFCP, 00776)** — 距離場ごとにconformalize、online更新
  - 時空間最適化系 … 通行可能領域の過渡的開閉を凸集合で定式化
    - **ST-GCS (00444)** — space-time の凸集合グラフ、ECD占有予約
- 評価基盤(closed-loop / HIL)
  - 決定論的 HIL … 対人インタラクションを再現可能に採取
    - **CommonRoad-Game (01382)** — wall-clock同期、CommonRoad互換、OSS
- 縦の接続仮説: 予測不確実性 →(FCP)距離場conformal制約 →(ST-GCS)時空間予約プランナ

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-04 | CommonRoad-Game (2607.01382) | wall-clock同期の決定論的HILで対人プランナ評価を再現可能に | [brief](../briefs/2026-07-04/2607.01382.md) |
| 2026-07-02 | ST-GCS (2607.00444) | 時空間凸集合グラフでtime-optimal計画、予測を占有予約に | [brief](../briefs/2026-07-02/2607.00444.md) |
| 2026-07-02 | Conformalized Distance Fields (2607.00776) | 距離場をconformalizeし分布フリー安全保証をMPCに | [brief](../briefs/2026-07-02/2607.00776.md) |

## Open Questions
- 距離場ごとの conformal 被覆は、時間ステップ間の相関をどう扱うと過保守を抑えられるか?
- 残差距離場の低ランク性は非定常シーン(交差点)でも成立するか?
- HIL で採取した対人ログを「certified-safe率/過保守率」の評価に載せられるか(R1 の合わせ技)
- 「衝突率だけでなく過保守・介入頻度を保証付きで測る」= 既存指標に対する新規性はどこか(R1)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
