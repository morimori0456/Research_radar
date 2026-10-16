# DIGEST 2026-10-17

## 今日読むべき TOP3

本日は採用が 1 件のみ (本流の候補が 0 件のため)。

1. **[2610.21601 Waypoint-OPD](2610.21601.md)** — 蒸留 (大きい teacher の出力を小さい student に学ばせる手法) の一種で、RL (reinforcement learning; 報酬で LLM を強化する学習) 済み teacher の「RL 前後の変化」を student への教師信号にする方法がある。ただし変化の途中経過が打ち消し合っていると信号が不正確になる。本論文は RL 途中の checkpoint を 1 本使い、前半と後半で変化の向きが揃う箇所だけを student に渡す。追加コストは teacher の scoring 1 回で、Qwen3 の 3 種の student × 数学・コードの 6 設定すべてで最高スコア。teacher の checkpoint を 1 本余分に保存するだけで試せるので、P2 の次の実験候補として最も安い。

(2 位以下は該当なし)

## 全ブリーフへのリンク

- [2610.21601](2610.21601.md) — Waypoint-OPD: Transferring RL-Induced Policy Shifts via Gated On-Policy Distillation (P2 / wildcard)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 2 件)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 候補なし。
- **P2 (FM 蒸留 + fine-tuning)**: 蒸留の信号を teacher の学習履歴で選別するという新しい軸。実験は中間 checkpoint の保存と、2 つの shift の向きの一致率の可視化から始められる。
- **P3 (次世代アーキテクチャ)**: 候補なし。

## 運用メモ

- candidates.json は wildcard 3 件のみ、本流 0 件。fetch ログの `[fetch] error` は今回確認できていない (ログが見当たらず)。0 件が正常な週末か API エラーかは未切り分けなので、次回 fetch 側で確認が要る。
- ブリーフは abstract のみに基づく。
