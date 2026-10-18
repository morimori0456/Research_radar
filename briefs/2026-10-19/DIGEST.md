# DIGEST 2026-10-19

## 今日読むべき TOP3

本日は採用が 1 件のみ。本流の候補が 0 件で、wildcard 3 件のうち 1 件 (Waypoint-OPD) は 10-17 に採用済みの再配信だった。

1. **[2610.22276 MJev-Spatial](2610.22276.md)** — VLM (画像と言語を扱う LLM) は「どの選択肢か」「距離はいくつか」「どこか」といった小さい答えの空間でも、token を 1 つずつ生成して答えを組み立てている。本論文は各候補を class とみなし、モデルが元々持つ attention の Q/K (query/key; 注目先を決める計算) だけでスコアを付けて、forward pass 1 回で決める。追加パラメータも生成もなし。VLA (画像と指示から行動を出すモデル) の action 出力を「生成」から「候補の scoring」に替える発想として P3 に示唆がある。ただし評価は空間理解の QA のみで、運転の閉ループでの効果は未検証。

(2 位以下は該当なし)

## 全ブリーフへのリンク

- [2610.22276](2610.22276.md) — MJev-Spatial: System One Spatial Intelligence via Native Attention Matching (P3 寄り / wildcard)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 2 件: 重複 1・無関係 1)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 新規候補なし。MJev-Spatial の scoring を planner の候補軌道の軽量な再ランクに流用できるか、が副次的な検討点。
- **P2 (FM 蒸留 + fine-tuning)**: 新規候補なし。2610.21601 (Waypoint-OPD) は 10-17 のブリーフを参照。
- **P3 (次世代アーキテクチャ)**: action head を離散候補の scoring にする案。軌道を離散化した anchor を候補にして、自由生成との latency・精度を toy 規模で比較するのが最小の実験。

## 運用メモ

- fetch は日曜 18:00Z 実行で本流 0 件。過去の観察どおり正常な日曜の空振りとみられるが、`[fetch] error` ログは今回確認していない。
- wildcard の 2610.21601 が 10-17 から再来した (dedup が wildcard 経路に無い)。今回は手動で除外した。
- ブリーフは abstract のみに基づく。
