# VLA / World Model / E2E Driving — Living Survey
最終更新: 2026-07-12

## 一言でいうと
言語・視覚・行動を1つのモデルで扱う **VLA (Vision-Language-Action)** と、世界の遷移を予測する
**world model** を end-to-end 自動運転にどう接続するかを追う分野。統合の設計空間(どこで
world model の恩恵を受け、推論時に何を捨てるか)はほぼ埋まり、論点は **world model を
「信じてよい条件」の認定**と、実時間制約・長期文脈下での恩恵の受け方に移った(R3)。

## 系譜マップ
- 統合方式(world model の恩恵をどう受けるか)— R3 分類マップの本体
  - (a) 単一 backbone co-training + 推論時脱着: **UNIVERSE (05133)** — 単一 DiT で video+action、visibility mask で未来漏れ遮断、推論 4.3x 高速・zero-shot 転移
  - (b) 行動表現の座標系を変える: **PixelPilot (04637)** — 画像平面 2D 再定式化で異種データ混合スケール + ego-status 近道学習対策
  - (c) frozen 生成モデルから latent 蒸留で事前知識のみ継承: **InternVLA-A1.5 (04988)** — foresight tokens + VQA 混流 / 系譜: **DriveTeach-VLA (01658)**(知覚蒸留+軌道誘導)・**VLAFlow (01586)**(future latent alignment)
  - (d) dual-level 埋め込み: **WCog-VLA (08375)** — 意味レベル(agent token + Game-CoT)+生成レベル(joint trajectory diffusion)、NAVSIM PDMS 92.9
  - (e) 単一 world latent に理解・予測・行動を統一: **Orca (30534)** — 凍結 latent + 軽量 readout
- world model の表現を行動に近づける
  - **RynnWorld-4D (06559)** — RGB+depth+flow の 4D 予測、denoising を回さず 1-forward で行動
  - 共通教訓: 明示的幾何(点群骨格 / depth+flow)の係留が長時間 rollout の安定性と行動接続を改善
- world model を「評価器」にする(planner-evaluation サーベイと相互参照)
  - **Point as Skeleton (06516)** — 生成型 closed-loop 評価、nuPlan IF 公開
  - **WM Admissibility (07196)** — L0–L4 認定 ladder。視覚品質上位 ≠ 行動追従性上位の「逆転」を実証
- 長期文脈(Markovian な現行 E2E への文脈注入)
  - **LaMem-VLA (07608)** — latent ネイティブな short/long dual memory(対照: NativeMEM の 1 frame 1 token 圧縮)
- 学習パラダイム
  - **Post-Training in E2E AD (08072)** — 模倣後の post-training を教師信号の形式で4分類した初の統一サーベイ。「事前学習(模倣)+post-training」の2段構え設計の根拠
- 実時間化の基準点
  - **Vidu S1 (03118)** — 民生 GPU 540p/42FPS の対話型生成。few-step 蒸留+専用サービングを対で設計

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-07-11 | WCog-VLA (2607.08375) | dual-level world-cognitive VLA、agent token + Game-CoT、PDMS 92.9 | [brief](../briefs/2026-07-11/2607.08375.md) |
| 2026-07-11 | Post-Training in E2E AD (2607.08072) | 模倣後 post-training の統一サーベイ、教師信号で4分類 | [brief](../briefs/2026-07-11/2607.08072.md) |
| 2026-07-11 | Vidu S1 (2607.03118) | 民生 GPU 42FPS・drift なしの実時間対話型生成(実時間化の基準点) | [brief](../briefs/2026-07-11/2607.03118.md) |
| 2026-07-10 | WM Admissibility (2607.07196) | world model を評価器に使う前に L0–L4 で認定せよ、逆転の実証 | [brief](../briefs/2026-07-10/2607.07196.md) |
| 2026-07-10 | LaMem-VLA (2607.07608) | latent 空間ネイティブな dual memory で VLA に長期文脈 | [brief](../briefs/2026-07-10/2607.07608.md) |
| 2026-07-09 | Point as Skeleton (2607.06516) | 点群骨格係留の生成型 closed-loop AD シミュレーション、nuPlan IF | [brief](../briefs/2026-07-09/2607.06516.md) |
| 2026-07-09 | RynnWorld-4D (2607.06559) | RGB+depth+flow 予測で表現を行動に近づける、1-forward policy | [brief](../briefs/2026-07-09/2607.06559.md) |
| 2026-07-08 | UNIVERSE (2607.05133) | 単一 DiT で video+action co-training、推論時脱着で 4.3x 高速 | [brief](../briefs/2026-07-08/2607.05133.md) |
| 2026-07-08 | PixelPilot (2607.04637) | 行動を画像平面で表現しスケールと近道学習を同時に解く、open/closed-loop SOTA | [brief](../briefs/2026-07-08/2607.04637.md) |
| 2026-07-08 | InternVLA-A1.5 (2607.04988) | frozen video 生成モデルから foresight tokens へ latent 蒸留 | [brief](../briefs/2026-07-08/2607.04988.md) |
| 2026-07-04 | Orca (2606.30534) | 単一 world latent で理解・予測・行動を統一(hf199) | [brief](../briefs/2026-07-04/2606.30534.md) |
| 2026-07-04 | VLAFlow (2607.01586) | 言語共学習+future latent alignment で VLA 学習を統制比較 | [brief](../briefs/2026-07-04/2607.01586.md) |
| 2026-07-04 | DriveTeach-VLA (2607.01658) | 知覚蒸留+軌道誘導で空間接地を注入、NAVSIM/nuScenes SOTA | [brief](../briefs/2026-07-04/2607.01658.md) |

## Open Questions
- 統合方式 (a)–(e) を自社制約(車載レイテンシ・データ量・既存スタック)で序列付けすると
  どれが残るか — R3 の分類マップは材料が揃った。次は比較実験計画への落とし込み
- admissibility(行動追従性)を学習目的に足すと生成品質とのトレードオフはどう出るか(07196 の逆転の裏返し)
- 長期記憶(LaMem 型 dual memory)は Markovian E2E のどの failure mode を実際に減らすか — まず
  memory-demanding シナリオの失敗率定量化から
- 「凍結 world latent + 軽量 action デコーダ」でどこまで行動生成が届くか(Orca / RynnWorld の 1-forward と接続)
- post-training 4分類のうち、保有資産(sim・報酬・選好データ)で最も低コストに始められるのはどれか
- シーンのトークン化(WCog の agent token / LaMem の memory token / SciReasoner 07708 の
  addressable evidence token)は決定根拠のトレーサビリティに使えるか(P1 と交差)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
