# DIGEST 2026-10-12

候補 3 件 (fetch 日曜夜分。全て sns_wildcard で、本流トピックの候補は 0 件)。abstract のみで評価。採用 1 件。2610.12374 は 10-11 に brief 済みのため重複として除外した。日曜 fetch が本流 0 件なのは過去の観測どおり (arXiv の announce 遅延) で、今回 fetch のエラー記録・RSS 回収分は確認できていない。

## 今日読むべきTOP3

候補が 1 件のため、読むべきものは 1 件のみ。

1. **[2610.12242 TokenRouter](2610.12242.md)** — 「1 token ごとに大小 2 つの LLM を切り替えて、品質を保ちつつ計算を減らす」token-level routing を、実際のサーバで速く回すための system 論文 (報告は decoding throughput 2.01〜64.15 倍)。P2 の蒸留は「大きなモデルの品質を小さなモデルに移す」ことが目的だが、これは「易しい token だけ小モデルに任せる」という別解で、蒸留済みモデルの代替・併用案として比較できる。まず手元の student と teacher の出力差から「小モデルで足りる token の割合」を見積もると、system を入れる前に価値が判断できる。ただし対象は LLM の text decoding で、運転の低 latency 制約は扱っていない。

## ブリーフ一覧

- [2610.12242](2610.12242.md) — TokenRouter: Efficient Serving System for Token-Level LLM Routing (P2 寄り、wildcard から採用)

落とした候補: [rejected.md](rejected.md)

## プロジェクト別の要点

- **P1**: 新規なし。
- **P2**: 蒸留の代替/併用として token-level routing を比較する発想。student と teacher の token 単位の差から routing の余地を見積もる実験が軽い (12242)。
- **P3**: 新規なし。

## 注記

- 全ブリーフは abstract のみに基づく。candidates.json の abstract は末尾が途切れている。
- 10-11 (土)・10-12 (日) 実行は本流 0 件で wildcard のみ。週末の 0 件は想定どおり。10-13 (月) 実行で月曜 announce 分が届くかを確認する。
