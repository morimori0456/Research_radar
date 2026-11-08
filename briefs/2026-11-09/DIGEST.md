# DIGEST 2026-11-09

**今日の新規ブリーフは 0 本。** candidates.json は 3 件で、全部 sns_wildcard (本流 3 トピックは 0 件)。うち 2 件は昨日すでにブリーフ済み、残り 1 件 (2611.05376) は position paper で P1/P2/P3 に使える内容が無く 1.5 点。上限 6 本に届かせるための水増しはしていない。評価はすべて abstract のみに基づく。

## 今日読むべきTOP3

今日の新規論文からは TOP3 を作れない。読む価値があるのは、今日の candidates.json に再来した昨日のブリーフの 2 本だけで、3 本目は無い。

1. **[2611.08449 VFlash: trajectory の座標を 1 回でまとめて出す](../2026-11-08/2611.08449.md)** (昨日のブリーフ / wildcard、P1・P3 に接点) — VLM (Vision-Language Model; 画像と言語を扱う model) が点や trajectory を座標 token 1 つずつ順に生成すると、plan が長いほど遅い。VFlash は座標の構造が既知なことを使い、軽量な drafter (小さい下書き model) が 1 回の forward pass で plan 全体を出す。3D の点の運動予測で約 25 倍速。ただし「予備的な単一 rollout」の計測で、評価は robot manipulation。運転 trajectory で精度が保たれるかは未検証。
2. **[2611.08373 SLA: 推論構造を変えず、学習時だけ中間層に 3D の知識を入れる](../2026-11-08/2611.08373.md)** (昨日のブリーフ / P3) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) は 2D の事前学習から視覚表現を受け継ぐため、3 次元の空間理解が弱い。SLA は pi05 (公開 VLA) を continual pre-training (事前学習を続けて行うこと) しながら、中間層の embedding を、凍結した 3D perception model の空間表現に揃える補助 loss を足す。補助部品は学習時のみなので推論時のコストは増えない。abstract は末尾が切れていて、評価結果は未確認。

## 全ブリーフへのリンク

- 今日の新規ブリーフ: なし
- [rejected.md](rejected.md) — 不採用 3 件 (既読の再来 2 / 低評価 1)
- 昨日の DIGEST: [briefs/2026-11-08/DIGEST.md](../2026-11-08/DIGEST.md)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 新規なし。接点があるのは昨日の VFlash (trajectory を token で出す planner の遅さへの対策) のみ。最小実験は、手元で waypoint を token 化して出す model があれば、1 forward pass でまとめて出す head と autoregressive 版を ADE / FDE (予測軌跡と正解の平均距離 / 最終点の距離) と latency で比べること。
- **P2 (FM 蒸留 + fine-tuning)**: 新規なし。11-07 の次点 2611.07349 (GEAR; LoRA の rank を増やす手法) は candidates.json に再来せず、abstract が無いので評価していない。
- **P3 (次世代アーキテクチャ)**: 新規なし。SLA の最小実験は、中間層に凍結 depth model の特徴との alignment loss を学習時だけ足し、閉ループ指標と latency を見ること。11-07 の次点 2611.07939 (WAM-Sim0.1; 運転 world model の long rollout の drift 対策) も再来せず未評価。
- **wildcard**: 採用なし。2611.05376 (AI-augmented human intelligence の position paper) は hf_upvotes 116 だが、注目度は relevance を上書きしないため落とした。

## 運用メモ

- 本流 0 件は日曜 18:00Z の fetch (週末は announce が無い) と整合する正常な薄さの可能性が高い。ただし fetch の log はこの環境から確認できず、エラーで 0 件に見えている可能性は排除できていない。月曜 18:00Z の fetch で通常の件数 (数十件) に戻るかを確認する。戻らなければ log の `[fetch]   error` を最初に見る。
- wildcard にも既読の再来がある (今日は 3 件中 2 件)。dedup を入れる場合は wildcard 経路にも必要。`fetch_candidates.py` / `topics.yaml` は変更していない。
