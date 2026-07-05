# VLA / World Model / E2E Driving — Living Survey
最終更新: 2026-07-05

## 一言でいうと
言語・視覚・行動を1つのモデルで扱う **VLA (Vision-Language-Action)** と、世界の遷移を
潜在で予測する **world model** を、end-to-end 自動運転にどう接続するかを追う分野。
共通課題は「言語推論に偏った表現へ**空間接地・状態遷移**をどう注入するか」(R3)。

## 系譜マップ
- VLA に空間接地を注入する
  - **DriveTeach-VLA (01658)** — what to see (DVD知覚蒸留) → where to look (2D-TGP) → how to act (GRPO)。NAVSIM/nuScenes SOTA
- VLA の学習パラダイム統制
  - **VLAFlow (01586)** — 言語共学習で汎化保全 + future latent alignment で状態遷移改善(軽量world-model信号)
- world model を土台にする(next-state prediction を行動へ接続)
  - **Orca (30534)** — 単一 world latent に理解・予測・行動を統一、凍結latent+軽量readout
  - 同トレンド群: WorldDirector / TAP / WorldSample(未精読、翌日再検討筆頭)
- 収束点: **future-latent / next-state prediction を行動学習に繋ぐ**流れが明確

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-04 | Orca (2606.30534) | 単一world latentで理解・予測・行動を統一(hf199) | [brief](../briefs/2026-07-04/2606.30534.md) |
| 2026-07-04 | VLAFlow (2607.01586) | 言語共学習+future latent alignmentでVLA学習を統制比較 | [brief](../briefs/2026-07-04/2607.01586.md) |
| 2026-07-04 | DriveTeach-VLA (2607.01658) | 知覚蒸留+軌道誘導で空間接地を注入、NAVSIM/nuScenes SOTA | [brief](../briefs/2026-07-04/2607.01658.md) |

## Open Questions
- future latent alignment 補助損失は action-only 学習の OOD 頑健性をどれだけ上げるか?
- 「凍結 world latent + 軽量 action デコーダ」でどこまで行動生成が届くか(下流有用性)?
- VLA × world model の統合分類マップ(R3 の次アクション)— 統合方式は何通りに整理できるか?
- 2D-TGP 相当の軌道誘導プロンプトを自社 e2e プランナに足すと軌道精度はどう動くか?

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
