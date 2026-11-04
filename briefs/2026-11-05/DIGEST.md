# DIGEST 2026-11-05

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は 64 件 (本流 61 + sns_wildcard 3)。評価・ブリーフはすべて abstract のみに基づく。wildcard は最大 2.5 で、総数の上限 6 に入らず見送った。

## 今日読むべきTOP3

1. **[2611.05072 RFWorld: 候補軌道ごとに未来を作らず、共有した場面 memory から直接 score を引く評価器](2611.05072.md)** (P3) — E2E (end-to-end; 画像から直接軌道を出す) 運転の planner では、複数の候補軌道を出して評価器で 1 本を選ぶ構成がある。従来の world model (未来の場面を予測する model) 型の評価器は、候補ごとに未来を何ステップも生成するので重く、予測誤差も積み上がる。この論文は、場面の memory を 1 回だけ作り、各候補軌道がその memory の必要な場所だけを引いて score にするので、計算が planning の先読み長 × 候補数の分だけ減る(論文の見積もり)。NAVSIM (実走行ログを元にした planner の評価 benchmark) と Bench2Drive (CARLA 上の closed-loop 運転 benchmark) で state-of-the-art。world model を「生成」でなく「比較」に使う設計は、車載の計算予算にも合う。実測の推論時間と改善幅は abstract に無い。
2. **[2611.05249 VLA の action expert の勾配を VLM に流すべきか](2611.05249.md)** (P1) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) は、VLM (Vision-Language Model) に行動を出す小さな expert を付ける構成が多く、主流の recipe は expert の loss の勾配を VLM に流さない。この論文は、運転と manipulation で「勾配を流すか」と「VLM に行動 token の予測を課すか」を独立に動かし、**open-loop (記録済みログでの軌道誤差) では差が出にくい条件でも、closed-loop (出した行動が次の入力に返る) の route progress は勾配を流したほうが約 17〜40% 上がる**と示した。open-loop の誤差だけで recipe を選ぶと誤る例であり、手元の VLA 型 planner の学習設定の棚卸しにそのまま使える。benchmark 名と model 規模は abstract に無い。
3. **[2611.04368 RAFT: 少ない demonstration で VLA を適合させても頑健性を落とさない 2 段階 fine-tuning](2611.04368.md)** (P2) — 汎用 VLA を少数の demonstration で fine-tuning すると、その task の成功率は上がるが、見た目・物体・指示が変わると壊れやすくなる。RAFT は、先に reasoning (推論) の注釈で adapter (LoRA のように重みの差分を小さな行列で持つもの) だけを学習し、凍結してから行動を学ぶ。実機で out-of-distribution (学習時と違う条件) の成功率が plain fine-tuning の 27.9% から 75.0% に上がる。少データ適合でドメインギャップに強くする recipe として、P2 の基準にそのまま当たる。対象は manipulation で、運転での注釈コストは未確認。

## 全ブリーフへのリンク

- [2611.05072](2611.05072.md) — RFWorld: rollout なしの world model で候補軌道を評価する (P3 / next_arch / 4.5)
- [2611.05249](2611.05249.md) — VLA の action expert の勾配を VLM に流すか、action-token supervision との関係 (P1 / planner_ai / 4.5)
- [2611.04368](2611.04368.md) — RAFT: reasoning 注釈で adapter を先に学習する VLA の少データ適合 (P2 / next_arch → P2 / 4.5)
- [2611.05093](2611.05093.md) — LoopQ: 量子化 VLA の closed-loop 公平比較。Jetson AGX Thor では 4 bit でも速くならない (P1 / next_arch → P1 / 4.0)
- [2611.05003](2611.05003.md) — AEGIS: SFT による一般能力の劣化を feature interference で説明し、margin の drift を抑える loss (P2 / fm_distill_finetune / 4.0)
- [2611.04527](2611.04527.md) — DreamFree: 未来の動画を作らず、video diffusion model の予測表現を現在の観測に蒸留する (P3 / next_arch / 4.0)
- [rejected.md](rejected.md) — 不採用 58 件と、持ち越せる次点 7 件

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「評価の条件を揃えて、見かけの差を疑う」話。2611.05249 は open-loop と closed-loop で結論が食い違うことを示し、LoopQ は同じ checkpoint・層・engine で 1 要因だけ動かす比較で、**VLA 専用の量子化は単純な RTN (Round-To-Nearest; 最も近い値に丸めるだけの量子化) に勝てない**ことを示した。LoopQ は Jetson AGX Thor でも計測しており、4 bit にしても全設定で遅くなる。原因は、メモリ律速の action expert が GPU 時間の 63% を占めるのに 16 bit のまま残ること。最小実験は、手元の model を Thor で 16 bit のまま profile し、backbone と action 側の GPU 時間比を出すこと。量子化はその後。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本とも、適合で「何を守るか」の話。RAFT は行動を学ぶ前に reasoning 注釈で adapter を固め、頑健性を守る。AEGIS は、SFT (Supervised Fine-Tuning; 正解データでの追加学習) で一般能力が落ちる原因を特徴どうしの干渉と説明し、正解と競合候補の logit 差の drift を抑える loss を足す(標準 SFT の約 1.3 倍の計算)。最小実験は、手元の fine-tuning で一般能力の小さな評価を固定して回し、劣化の大きさを数字にすること。次点の RAPID (2611.04081; 蒸留で teacher と student の次元差をランダム射影で解消し、学習を最大 21.1% 効率化) は 4.0 点で、quota 超過のため持ち越し。
- **P3 (次世代アーキテクチャ)**: 2 本とも、world model の重い「未来の生成」を推論時から外す。RFWorld は候補軌道の評価に使い、DreamFree は未来を予測する video diffusion model の表現を、現在の観測だけから出せる encoder に蒸留する。後者は 14B の backbone で 11 Hz の closed-loop 制御ができ、行動注釈の無い動画から新しい task を学べる。最小実験は、手元の planner に RFWorld 型の評価器を載せて推論時間と NAVSIM の score を見ることと、動画 model の表現を回帰する encoder を作って軌道誤差との相関を見ること。どちらも manipulation が主な対象の DreamFree は、運転での転用が未確認。

## 運用メモ

- **fm_distill_finetune が 30 件ちょうどで、max_results=30 の天井に当たっている。** この 30 件の `published` は 11-03 08:13Z〜18:54Z の約 10.7 時間分しかなく、それ以前の fm の新着は落ちている可能性が高い。next_arch は 25 件、planner_ai は 6 件で天井ではない。**今日も RSS での回収は行っていない** (採用は candidates.json のみから選んだ)。fm 側の 4.0 点以上の論文を取りこぼしている可能性は残る。fetch の log は確認していない。
- planner_ai の本流候補 6 件のうち、運転を扱うのは 2611.05249 の 1 件だけ。他は manipulation・宇宙・レーダー・数理で、keyword 一致のうち P1 の基準に当たるものは少ない。`fetch_candidates.py` / `topics.yaml` は変更していない。
- sns_wildcard は 3 件とも 2.5 以下で、学びの価値はあるが追う 3 プロジェクトへの接点が弱く見送った。
- 次点 7 件 (評価 3.5 以上) は rejected.md に残した。
