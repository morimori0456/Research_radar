# DIGEST — 2026-07-16

選定: 6件 / max_deep_per_day 6 (P1×1, P2×2, P3×2, EXPLORE×1)

> **fetch の注意**: sns_wildcard 3件が昨日と完全に同一だった。Direct-OPD は昨日ブリーフ済みのため重複として除外 (rejected.md 参照)。dedup / lookback の修正が必要。

## 今日読むべき TOP3

1. **[TerraZero](2607.13028.md)** (P3/P1, 5/5) — 人間のデモをゼロ件で、procedural に生成したシナリオ上の self-play RL だけで運転 policy を学習し、long-tail ベンチマーク InterPlan で学習型プランナー初の首位。 「実走行ログは地図形状だけに使う」というデータ戦略は、模倣学習中心の現行 E2E 路線への最も具体的な対案で、P1 の閉ループ評価 (対向エージェントを self-play 型に強化する) にもすぐ使える。
2. **[MobileSAM2](2607.12297.md)** (P2, 5/5) — 動画基盤モデル SAM2 の軽量化蒸留。フレーム間の時間的対応と多粒度マスクの知識を hypergraph (複数要素を一辺で結ぶ関係構造) として抽出し、点ごとの feature 一致ではなく関係構造ごと student に転写する。車載向けに動画系 teacher を蒸留する際の「時間方向の知識をどう運ぶか」への具体的な処方箋。
3. **[FlowWAM](2607.13017.md)** (P3, 4/5) — optical flow (ピクセル単位の移動ベクトル場) を action 表現にして、1つの動画生成器を policy と world model の両モードで動かす。flow は生動画から自動抽出できるため、action ラベルなしの大量走行映像をそのまま事前学習に使える — 運転ドメインのデータ構造と相性が良い。

## 全ブリーフ

| 論文 | topic | score | 一言 |
|---|---|---|---|
| [TerraZero](2607.13028.md) | next_arch (P3) | 5/5 | デモゼロ self-play RL の運転 policy、InterPlan 首位 |
| [MobileSAM2](2607.12297.md) | fm_distill_finetune (P2) | 5/5 | SAM2 蒸留、hypergraph で時間・粒度の知識を転写 |
| [FlowWAM](2607.13017.md) | next_arch (P3) | 4/5 | optical flow を action 表現にした World Action Model |
| [MBTI](2607.12782.md) | fm_distill_finetune (P2) | 4/5 | センサ構成差を branch 別 LoRA で吸収する PEFT recipe |
| [ABot-N1](2607.10383.md) | sns_wildcard (EXPLORE) | 4/5 | slow-fast VLN、pixel goal を統一インタフェースに |
| [MDOC](2607.12423.md) | planner_ai (P1) | 3/5 | デモ不要の model-based diffusion プランナー + CBF 射影 |

## プロジェクト別の要点

### P1 (Planner AI + 評価)
今日の planner_ai 枠は小粒 (採用は MDOC 3/5 のみ) だが、**評価の観点では P3 枠の TerraZero が本日最重要**。InterPlan / val14 での位置づけが具体的で、self-play で育てた sim agents を閉ループ評価の対向エージェントに使うアイデアは試す価値が高い。MDOC からは「学習型 diffusion プランナーの後段に CBF (Control Barrier Function; 安全集合からの逸脱を防ぐ制約) 射影を安全レイヤとして足す」という移植可能な部品が取れる。

### P2 (FM 蒸留 + 適合)
蒸留と適合の両軸で1本ずつ。**MobileSAM2** は動画基盤モデル蒸留の関係構造ベース recipe (+ 蒸留 loss を使った student アーキテクチャ探索)、**MBTI** は「他機種適合」の縮図で、入力仕様の違うセンサへ branch 別 LoRA + attention 融合で全情報を保ったまま適合する。次点の Light-MER (optimal transport loss + GRPO 系 reward の蒸留、4/5) は quota で落としたが要フォロー。

### P3 (次世代アーキ)
world model 側は **FlowWAM** (flow を介した action-free 事前学習) が運転データ戦略に直結。E2E 側は **TerraZero** がデモ依存を断つ RL 路線の到達点を示した。EXPLORE 枠の **ABot-N1** は、slow な VLM 推論と fast な waypoint 生成を「画像空間の pixel goal」で橋渡しする dual-system 設計の具体例で、運転 VLA のインタフェース設計 (テキスト vs BEV 座標 vs pixel anchor) を比較する実験仮説をくれる。
