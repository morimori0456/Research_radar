# DIGEST — 2026-07-14

## 今日読むべき TOP3

今日は選定が **1件のみ** (候補3件全てが探索枠 sns_wildcard。本枠 P1/P2/P3 の候補は3日連続でゼロ)。TOP3 は構成できないため、唯一の選定1件を挙げる。

1. **[GenCeption (2607.09024)](2607.09024.md)** — text-to-video 生成で学習した diffusion backbone (ノイズ除去を繰り返す生成モデルの主流方式) を、depth 推定や segmentation などの知覚モデルにそのまま転用したら、専用 SOTA モデルに 7〜500分の1 のデータで並んだという報告。video 生成の学習は world model (環境の未来を予測する内部モデル) と実質同じ学習なので、「world model 的 pretraining が知覚・3D理解にどれだけ転移するか」の定量的な裏付けとして P3 に直結する。V-JEPA / VideoMAE (どちらも動画の self-supervised 学習手法) との同条件比較で生成 pretraining が勝つ、という結果も設計判断に効く。

## ブリーフ一覧

| id | タイトル | topic | score |
|---|---|---|---|
| [2607.09024](2607.09024.md) | Video Generation Models are General-Purpose Vision Learners | sns_wildcard | 4/5 |

却下: [rejected.md](rejected.md) (2件 — wildcard 枠超過1、分野が遠い1)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 本日直接の新着なし。却下した Long-Horizon-Terminal-Bench (2607.08964) の「タスクを graded subtask に分解し、部分点と dense な中間報酬で評価する」設計は、最終結果しか見ないプランナー評価の粗さへのヒントとして rejected.md に記録済み。
- **P2 (FM 蒸留 + fine-tuning)**: 本日直接の新着なし。GenCeption の「専用モデル比 7〜500分の1 のデータで同等」というデータ効率は、少データでの他ドメイン適合 (P2 の中心課題) の観点で読む価値がある。
- **P3 (VLA / World Model / E2E)**: GenCeption が本日の主役。走行データでの video 生成 pretraining → 知覚/planning ヘッドへの転用という実験ラインをブリーフで提案。VideoMAE 系との A/B と、公開 video diffusion backbone の zero-shot 評価が着手しやすい。

## 運用メモ (要対応)

- **本枠候補が3日連続で完全枯渇** (07-12〜07-14 とも wildcard のみ)。fetch_candidates.py の本枠取得 (カテゴリ/キーワードクエリ) の失敗が濃厚。取得ログの確認が急務。
- 既読再提示 (Vidu S1 が3日連続) は**今日は解消**。3件とも新規で、dedup 問題は再発せず。継続観察。
