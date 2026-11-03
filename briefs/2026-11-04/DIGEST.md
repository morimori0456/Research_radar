# DIGEST 2026-11-04

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は 56 件 (本流 53 + sns_wildcard 3)。評価・ブリーフはすべて abstract のみに基づく。wildcard は最大 3.0 で、総数の上限 6 に入らず見送った。

## 今日読むべきTOP3

1. **[2611.03067 PlanContext: 「同じ場面で意図だけ変えたら、判断が変わるか」を測る benchmark](2611.03067.md)** (P1) — 既存の E2E (end-to-end; 画像から直接軌道を出す) 運転の評価は、軌道の安全性や快適性といった「軌道の質」を測る。だが実際には「同じ場面で左折する意図か直進する意図か」で正しい判断が変わる。この論文は**場面を固定したまま運転意図だけを変えた対**で評価し、公開されている 23 個の E2E model で、従来の score が高くても意図に沿った判断が強いとは限らないと示した。手元の planner に route command (左・右・直進の指示) だけを入れ替えて、軌道が意図に沿って変わるかを見る試験は、既存の log だけで作れる。閉ループで意図を変えたときの挙動までは測れない可能性がある。
2. **[2611.02853 ScaleDrive: 行動ラベルなしの運転動画で作った視覚表現を凍結したまま planner に載せる](2611.02853.md)** (P3) — 事前学習は、操舵などの注釈が無い大量のインターネット運転動画で、**video latent prediction (動画の将来を latent 空間で予測して表現を学ぶ方法)** だけを使う。この encoder を下流の planning 学習中も凍結しても、複数の policy 構造と closed-loop benchmark で性能が上がり、動画を増やすほど ego-motion (自車の動き) と depth (奥行き) の情報が表現に増える。注釈コストなしでスケールできる事前学習の根拠になる。benchmark 名と改善幅は abstract に無く、手元の camera 構成が違うと合わない可能性がある。
3. **[2611.02526 INTERACT: 物体ごとの slot で「自車が動くと周りがどう変わるか」を予測し、planner に蒸留する](2611.02526.md)** (P3) — 既存の E2E model は場面を密な特徴にまとめ、物体どうしの相互作用を暗黙のままにしている。INTERACT は、注釈なしの動画から**物体 1 つに 1 本の特徴ベクトル (slot)** を学び、自車の操作を条件に未来の slot を予測し、その結果を distillation (大きな model の出力を小さな model に写す学習) で trajectory planner に渡す。NAVSIM (実走行ログを元にした planner の評価 benchmark) で state-of-the-art、特に衝突系の指標が改善する。TOP2 の ScaleDrive が dense な latent、こちらが物体単位の表現なので、同じ planner に載せて比べる実験が書ける。どの段階が効いたかは abstract から分からない。

## 全ブリーフへのリンク

- [2611.03067](2611.03067.md) — PlanContext: 運転意図だけを変えた対で E2E の判断力を評価する benchmark (P1 / planner_ai / 4.5)
- [2611.02853](2611.02853.md) — ScaleDrive: action 注釈なしの運転動画の latent prediction を凍結して E2E に載せる (P3 / next_arch / 4.5)
- [2611.02526](2611.02526.md) — INTERACT: slot 型 world model を注釈なし動画から学び planner に蒸留 (P3 / next_arch / 4.5)
- [2611.03528](2611.03528.md) — CAT-CKD: adapter で共有空間を作り、複数 source model の consensus を蒸留する source-free な適合 (P2 / fm_distill_finetune / 4.0)
- [2611.03125](2611.03125.md) — SurgPace: 確信度 + Lorentz 幾何で難易度を測る curriculum と、teacher 模倣 → task 教師の loss schedule (P2 / fm_distill_finetune / 4.0)
- [2611.02101](2611.02101.md) — When Delay Meets Drift: 推論遅延と camera のずれの交互作用 (単独の和より 33.5 pp 大きい) (P1 / 評価 / 3.5)
- [rejected.md](rejected.md) — 不採用 50 件と、持ち越せる次点 8 件

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「単独の試験に合格しても、条件を組み合わせると崩れる」を測る評価設計である。PlanContext は、場面を固定して運転意図だけを変える対評価で、従来の score では見えない判断力を測る。When Delay Meets Drift の論文 (2611.02101) は、推論遅延と camera のずれを同時に入れると、単独の影響の合計より 33.5 percentage point 大きい違反率になると示す (対象は manipulation で、運転ではない)。最小実験は、手元の planner に route command だけを入れ替えて、軌道が意図に沿って変わる場面の割合を数えること。次に、遅延 × センサのずれの格子で closed-loop の衝突率を測る。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本は、適合・蒸留の「どこを触り、いつ何を重くするか」の話。CAT-CKD は、凍結した ViT に adapter だけを入れて共有の特徴空間を作り、複数の source model の logit を 1 つの consensus にして target に蒸留する。「機種 A・B の model はあるが元データは使えず、機種 C は unlabeled」という状況の recipe になる。SurgPace は、teacher の確信度で難しさを測る curriculum と、「teacher 模倣 → task の教師」へ重心を移す loss の schedule を分離する。最小実験は、手元の蒸留で「一様 / curriculum のみ / schedule のみ / 両方」の 2×2 を回すこと。次点の REPAIR (2611.02777; RL specialist を flow-matching VLA に on-policy で蒸留) と History Forcing (2611.02782; video world model の on-policy 蒸留) も 4.0 で、quota 超過で外れた。
- **P3 (次世代アーキテクチャ)**: 2 本とも、注釈なしの運転動画から表現を作り、planner に渡す。ScaleDrive は dense な latent を凍結して載せる方式、INTERACT は物体単位の slot と自車の latent action で interaction を明示する方式である。最小実験は、公開されている動画 encoder を凍結して手元の planner の backbone と置き換え、ego-motion と depth の probe (凍結した表現から単純な model で読み出す検査) と L2 誤差・衝突率を見ること。その上で、dense 表現と slot 表現を同じ planner で比べる。

## 運用メモ

- **fm_distill_finetune が 30 件ちょうどで、max_results=30 の天井に当たっている。** この 30 件の `published` は 11-02 09:13Z〜18:59Z の約 10 時間分しかなく、それ以前の fm の新着 (11-01 後半〜11-02 午前) は落ちている可能性が高い。next_arch は 22 件で天井ではない。**今日は RSS での回収を行っていない** (本日の採用は candidates.json のみから選んだ)。fm 側の 4.0 点以上の論文を取りこぼしている可能性は残る。
- planner_ai の keyword に当たる運転の planner 評価の論文 (PlanContext) は next_arch に分類され、planner_ai の本流候補は manipulation の TAMPAgent 1 件だけだった。planner_ai の keyword が、評価 benchmark を拾えていない。`fetch_candidates.py` / `topics.yaml` は変更していない。
- 次点 8 件 (評価 3.5 以上) は rejected.md に残した。
