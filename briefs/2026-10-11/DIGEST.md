# DIGEST 2026-10-11

候補 3 件 (fetch 土曜夜分。全て sns_wildcard で、本流トピックの候補は 0 件)。abstract のみで評価。採用 1 件。2610.08077 は 10-10 に brief 済みのため重複として除外した。土曜 fetch が本流 0 件なのは過去の観測どおり (arXiv の announce 遅延) で、今回 fetch のエラー記録は確認できていない。

## 今日読むべき TOP3

候補が 1 件のため、読むべきものは 1 件のみ。

1. **[2610.12374 AgentGarten](2610.12374.md)** — 状態の管理は simulator に、見た目の生成は neural renderer (video model を蒸留して real-time 化したもの) に任せ、agent が学習できる仮想世界を作る。核は Adversarial Forcing という蒸留法で、過去の観測の encode の仕方まで後段の loss で更新できるようにする。自己回帰の world model が長く rollout すると誤差が積もる問題に、同じ発想を試せる。ただし対象は game/agent 環境で、運転での検証は無い。

## ブリーフ一覧

- [2610.12374](2610.12374.md) — AgentGarten: Code Worlds for Evolving Agents (P3 寄り / P2 関連、wildcard から採用)

落とした候補: [rejected.md](rejected.md)

## プロジェクト別の要点

- **P1**: 新規なし。「状態は simulator、見た目は neural renderer」の分離が closed-loop simulation の観測生成に使えるかは未検証 (12374)。
- **P2**: video model を real-time 化する蒸留 recipe (Adversarial Forcing) として本文確認の価値あり (12374)。
- **P3**: world model の長期 rollout 安定化に「履歴の encode まで後段 loss で更新する」発想を小規模 toy で試せる (12374)。

## 注記

- 全ブリーフは abstract のみに基づく。candidates.json の abstract は末尾が途切れている。
