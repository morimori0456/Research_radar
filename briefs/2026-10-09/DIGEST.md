# 2026-10-09 DIGEST

候補 64 件から 6 件を採用 (P1 2 / P2 2 / P3 2)。採点は abstract のみ。planner_ai 由来の候補は 3 点以下で、P1 枠は next_arch 由来の 2 件を回した。wildcard は 10-08 採用済みの再来と、見送り 2 件で採用なし。

## 今日読むべき TOP3

1. **2610.09763 ICDP** — 自車の軌道は logged data にあっても、周囲の車の動きとの「組み合わせ」はデータに無い、という状況を offline RL (固定データだけで方策を改善する強化学習) で明示的に抑える planner 論文。nuPlan の closed-loop と実機トラックで検証済み。密度比を学習する小さな分類器の score は、collision や L2 に出ない失敗の予兆指標として、手元の planner 評価にすぐ試せる。
2. **2610.09695 ViRA** — 大規模事前学習の画像モデル (VFM) の表現に E2E planner の中間特徴を揃える補助 loss で、推論コストを変えずに NAVSIM v2 の EPDMS (運転品質の総合スコア) が 92.3 まで上がる。どの VFM を target にするかで 2.7 点ぶれる、という評価上の注意点も、補助の perception supervision で 0.5 点に縮むと示している。後付けで足せる。
3. **2610.09835 Deafening Silence** — fine-tuning で元の能力が落ちる現象 (catastrophic forgetting) が、新データにほぼ出ない token の出力側の重みに集中する、と突き止めた論文。Adam の epsilon を出力層だけ大きくする 1 行の変更で、忘却を 4 割〜7 割減らす。別ドメインへ適合させる fine-tuning を回すときのコストの低い保険になる。

## 全ブリーフ

- [2610.09763 ICDP (P1)](2610.09763.md)
- [2610.09695 ViRA (P1/P3)](2610.09695.md)
- [2610.10390 GeoCoTDrive (P3)](2610.10390.md)
- [2610.10515 RoboJEPA (P3)](2610.10515.md)
- [2610.09835 Deafening Silence (P2)](2610.09835.md)
- [2610.09940 Juno (P2/P3)](2610.09940.md)
- [不採用一覧](rejected.md)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: interaction 支持度の density-ratio score (ICDP) と、NAVSIM v2 EPDMS での alignment 比較 (ViRA) が評価側の材料。RoboJEPA の「world model の rollout 誤差が下流 planning 性能の代理になる」も、closed-loop 実走が高コストな評価の代替案として検討価値がある。
- **P2 (蒸留 + 適合)**: 忘却の防止策 (出力層のみ Adam epsilon 増) と、Juno の「teacher を新ドメインで先に適応・凍結してから student を LoRA で合わせ直す」流れが recipe として使える。いずれもロボット / LLM 対象で、視覚モデルでの再現は未確認。
- **P3 (VLA / world model / E2E)**: GeoCoTDrive は 2D で注目領域を決めてから、その領域の 3D 特徴だけ VLA に差し込む設計。RoboJEPA は latent world model の scaling law を 8B parameter で示した。

## 備考

- 2610.08448 (wildcard) は 10-08 に採用済みで HF 経由で再来した (重複除外)。
- 今日の 6 本はどれも「試す実験」を 3 つずつ書いた。着手の判断は 10-11 の decisions/ で。
