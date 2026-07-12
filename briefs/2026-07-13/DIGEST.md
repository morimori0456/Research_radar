# DIGEST — 2026-07-13

## 今日読むべき TOP3

今日は選定が **1件のみ** (候補3件全てが探索枠 sns_wildcard で、うち1件は既読の再提示。本枠 P1/P2/P3 の候補は2日連続でゼロ)。TOP3 は構成できないため、唯一の選定1件を挙げる。

1. **[Video-Oasis (2603.29616)](2603.29616.md)** — Video-LLM (動画を入力に取る large language model) のベンチマークを監査したら、サンプルの 55% が動画を見ずに解ける shortcut (本来の能力を使わず正解できる抜け道) だったという報告。「新ベンチマークを足す」のではなく「既存ベンチマークを診断してフィルタする」というアプローチが、open-loop planning 評価 (自車状態だけでスコアが出てしまう問題) を抱える P1 のプランナー評価にそのまま輸入できる。分野外の wildcard だが、評価手法の設計テンプレートとして今日読む価値がある。

## ブリーフ一覧

| id | タイトル | topic | score |
|---|---|---|---|
| [2603.29616](2603.29616.md) | Video-Oasis: Rethinking Evaluation of Video Understanding | sns_wildcard | 4/5 |

却下: [rejected.md](rejected.md) (2件 — 既読再提示1、wildcard 枠超過1)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: Video-Oasis の監査プロトコル (blind evaluation = 知覚入力なしで解かせる / temporal ablation = 時間文脈を壊して解かせる) はプランナー評価セットの健全性チェックに直接使える。「知覚なしで解けるシナリオの割合」を測り、shortcut シナリオを除去したハード評価サブセットを作る実験を提案 (詳細はブリーフ参照)。
- **P2 (FM 蒸留 + fine-tuning)**: 本日直接の新着なし。副次的に、shortcut 除去済み評価サブセットを蒸留前後の regression テストに使うと「視覚理解だけが落ちる劣化」を検出できる、という応用がある。
- **P3 (VLA / World Model / E2E)**: 本日直接の新着なし。VLA を QA 形式で評価する際の言語 prior (言語知識だけで答えを当てる傾向) による水増しは Video-Oasis と同型の問題で、blind ablation の導入は低コストで有効。

## 運用メモ (要対応)

- **本枠候補が2日連続で完全枯渇** (07-12, 07-13 とも wildcard のみ)。fetch_candidates.py の本枠取得ログの確認が急務。
- 既読 dedup の欠如も継続 (Vidu S1 が3日連続で再提示)。briefs/*/ 既存 id の除外実装が根本対応。
