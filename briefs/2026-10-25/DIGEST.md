# DIGEST 2026-10-25

採用は 2 本 (P2 のみ)。candidates.json は wildcard 3 件だけで本流は 0 件、wildcard は 3 件とも不採用 (2 件は過去に見送り済みの再来)。2 本とも arXiv RSS の cs.CL から回収した。本日は土曜 18:00Z の fetch なので、本流 0 件は過去の観察どおりの正常な空振り。

## 今日読むべき TOP3

採用が 2 本のため、3 位は該当なし。

1. **[2610.30344 AQL-Lite](2610.30344.md)** (P2 / 別ドメインへの適合 recipe) — 学習済みの LLM を別の領域 (ここではアラビア語) に適合させるとき、全パラメータを更新する continual pretraining (既に学習済みの model に新分野のデータで事前学習を続ける) は高くつく。著者は、LoRA (小さな追加行列だけを学習する PEFT) を network 全体に付け、さらに最後の 8 transformer block と embedding も更新する中間の方式を作り、full 更新の効果の 94% を 52% の時間で得た。LoRA だけの baseline には全 benchmark で勝つ。もう一つの結果が、データを選別せずに学習すると効果がゼロ、選別すると +3.51 点になること。対象は言語だが、「LoRA だけでは足りないとき、どこまで開ければよいか」の具体的な設計と数字が出ている。
2. **[2610.31401 HERD](2610.31401.md)** (P2 / 蒸留を繰り返すときの劣化対策) — 新しい skill を順に覚えさせると、古い能力が消える (catastrophic forgetting)。HERD (Harness-Evolving Recursive Distillation) は、経験をまず手順書 (harness) に溜め、それを蒸留で重みに取り込む。このとき元の model から離れすぎないよう制約 (drift-constrained distillation) を付け、2 つの基準点 (anchor) を置いて、何世代蒸留を重ねても forgetting が積み上がらないようにする。蒸留を一度で終わらせず、新ドメインのたびに回す運用の設計に参考になる。ただし対象は LLM agent で、anchor の定義は abstract からは不明。

## 全ブリーフへのリンク

- [2610.30344](2610.30344.md) — AQL-Lite: LoRA + 末尾 block + embedding を更新する軽い continual pretraining (P2 / RSS 回収分)
- [2610.31401](2610.31401.md) — HERD: drift 制約付きの再帰的な蒸留で forgetting を抑える (P2 / RSS 回収分)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件 + RSS 次点 5 件)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 新規候補なし。candidates.json にも RSS (cs.RO / cs.AI / cs.LG / cs.CV はいずれも 0 件) にも該当が無い。昨日の Route or Adapt と driving VLA の counterfactual 評価の最小実験 (10-24 DIGEST) が未着手のまま。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本とも「軽く、壊さずに適合する」側の知見。最小実験は、(a) 手元の適合タスクで LoRA のみ / LoRA + 末尾 N block / full fine-tuning を同じ wall-clock で比べる (AQL-Lite の縮小版)、(b) 新ドメインへの蒸留を 2〜3 回続けて、各回の後に元ドメインの性能を測り、世代ごとの forgetting の積み上がりを見る (HERD の縮小版)。次点は 2610.31017 (文書ごとの LoRA の open-book 評価は、adapter が知識を持つ効果でなく「読む行動」を測っている、という評価の落とし穴)。
- **P3 (次世代アーキテクチャ)**: 新規候補なし。candidates.json に next_arch の候補が無く、RSS の cs.CL に VLA / world model / E2E 運転の一致も無かった。

## 運用メモ

- fetch は土曜 18:00Z 実行 (generated_at 2026-10-24T18:00:27Z)。本流 0 件・wildcard 3 件。ログが無く `[fetch] error` の有無は確認できないが、土曜は全 feed 空が正常という既存の観察と一致する。
- RSS は 5 本中 cs.CL だけが 183 件 (new 77 / cross 40 / replace 66) で、他の 4 本は 0 件。lastBuildDate は 5 本とも 2026-10-24 04:00Z。cs.CL だけ空でない理由は不明。items の id は 2610.30154〜2610.31667 で、10-24 の採用 id 帯と重なる。10-24 の RSS 走査 (lastBuildDate 10-23) の対象と同じ配信かは未確認で、brief・rejected に既出の 14 件は除いて採点した。
- wildcard の 2610.28402 (StreamEval) は 3 日連続の再来、2610.31329 (WeVisOne-VL) は 10-24 の再来。dedup が wildcard 経路にも要る、という既存の観察と一致する。今回も手動で除外した。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
