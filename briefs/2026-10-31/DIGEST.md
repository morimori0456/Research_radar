# DIGEST 2026-10-31

採用は 6 本 (P1 2 / P2 2 / P3 2)。上限まで埋まった。candidates.json からの採用は 2 本で、残り 4 本は arXiv RSS から回収した。fm_distill_finetune は `max_results=30` の天井に当たり、約 11 時間分の 30 件で止まっている。sns_wildcard は 3 件とも見送り済みの再来なので採用なし。

## 今日読むべきTOP3

1. **[2610.40002 reasoning VLA が推論文をどれだけ信じるかを、行動生成の step ごとに決める](2610.40002.md)** (P3) — VLA (vision-language-action; 画像と言語から行動を出す model) の中には、推論文を書いてから行動を生成するものがある。推論文が誤ると行動も誤るが、この論文は正誤の判定でなく「推論にどれだけ行動を引っ張らせるか」を調整する。推論文あり / なしの予測の差を重みで増幅する classifier-free guidance を使い、その重みを行動生成の step ごとに選ぶ。1 step だけ重みを変えて最後まで生成すれば value を正確に測れる点が工夫で、model の再学習は要らない。運転 simulator の closed-loop は 300 scene 中 252 から 262 passed に増え、Waymo の end-to-end driving benchmark の hidden test で最高値 (8.135、既存 8.079) を出した。ただし、この最高値には rule-based 変換の寄与も入っている。
2. **[2610.37937 RPKD: 特徴空間を揃えず、ランダムな prototype を物差しにして蒸留する](2610.37937.md)** (P2) — knowledge distillation では teacher と student の特徴を揃えるのが常識で、異なる architecture の間では専用の射影の設計が要る。RPKD (Random Prototype Knowledge Distillation) は、ランダムに固定したベクトルの集合を共通の基準にして、両者を「その基準との類似度」で比較する。teacher 側は学習せず、基準も組み合わせごとに作り直さない。既存の異種 architecture 向け手法 (OFA) に対して ImageNet-100 で最大 +12.44%、ImageNet-1K で最大 +1.28%。class 数の少ない task で supervision が増える性質は運転の認識に合う。公開 code があるので試しやすいが、報告は画像分類のみで、数値は最大値である。
3. **[2610.38508 SaiVLA-JEPA: 将来予測の補助 loss は、制御を良くしなかった](2610.38508.md)** (P3) — JEPA (画素でなく表現を予測する学習方式) の特徴を VLA に入れると成功率は 71.6% から約 82.5% に上がるが、将来の表現を予測する補助 loss を足しても、10,030 組の paired 比較で検出可能な gain は無かった。これは 10-29 の JAM、10-30 の MoGAP が示した「学習時だけ将来予測を足す」系統の検証になる。P3 で foresight loss に投資する前に読むべき。ただし限られた学習予算での結果で、JEPA 特徴が既に時間情報を持つ影響もありうるので、JAM の否定とは言い切れない。

## 全ブリーフへのリンク

- [2610.40002](2610.40002.md) — CoC-CFG / Q-adaptive guidance: reasoning の効き具合を step 単位で測って制御する (P3 / next_arch / 5.0)
- [2610.38508](2610.38508.md) — SaiVLA-JEPA: 将来の latent 予測の効果を paired closed-loop で検証 (P3 / next_arch / 4.0 / RSS 回収)
- [2610.37937](2610.37937.md) — RPKD: ランダム prototype 空間での異種 architecture 蒸留 (P2 / fm_distill_finetune / 4.5 / RSS 回収)
- [2610.39020](2610.39020.md) — ESC: 蒸留前に entropy の形の一致度で teacher を選ぶ (P2 / fm_distill_finetune / 4.5 / RSS 回収)
- [2610.38628](2610.38628.md) — ADS test の reality gap の systematic mapping、235 本の主張と証拠の整理 (P1 / planner_ai / 4.0 / RSS 回収)
- [2610.38939](2610.38939.md) — ICNN の安全・快適性 cost を LP で埋め込む lane change planner (P1 / planner_ai / 4.0)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 63 件、RSS の次点 20 件)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本は「評価の主張」と「planner の実装」に分かれる。reality gap の調査は、simulator の結果から何を主張できるかを component 単位で明示するよう求めており、closed-loop の評価表に「主張と証拠」の列を足す形で使える。ICNN (入力に対して凸に制約した network) の planner は、学習した cost を LP (線形計画) で最適化に入れる実装例である。最小実験は、自分の評価の主張と証拠の対応表を作り、空欄を数えること。keyword に一致せず RSS で拾った 2610.38628 は、planner_ai の keyword が評価系の論文を拾えていない例でもある。
- **P2 (FM 蒸留 + fine-tuning)**: RPKD は「異なる architecture をどう比べるか」、ESC (Entropy Shape Correlation; 次の token の entropy の系列の一致度) は「どの teacher を選ぶか」に答える。どちらも学習の前段の判断に関わる。最小実験は、手元の teacher 候補 3 体で ESC を計算し、実際の蒸留の順位と合うかを見ること。次点の DS-Upcycling (2610.40091; domain ごとに expert と router だけを fine-tune する) は、少データの他ドメイン適合の主題に最も近い。
- **P3 (次世代アーキテクチャ)**: 2610.40002 は推論時の guidance、SaiVLA-JEPA は学習時の foresight を扱う。共通の結論は、効果を latent の loss でなく closed-loop で測ることである。最小実験は、driving model で事前学習特徴なし / あり / あり+foresight loss の 3 条件を、同じ scene の paired で比較すること。

## 運用メモ

- fetch は金曜 18:00Z 実行 (generated_at 2026-10-30T18:00:28Z)。ログは planner_ai 4 / fm 30 / next 30 件で、`error` は無い。next は 30 件のうち 2 件が他トピックと重複し、candidates.json では 28 件。fm の 30 件は 10-29 07:06Z〜17:59Z の約 11 時間分で、天井で切れている。
- RSS は 5 本とも 200 で、lastBuildDate は 2026-10-30 06:39Z。過去のブリーフ・rejected に既出の id と candidates.json を除くと、keyword 一致は 386 件 (new 181 / cross 63 / replace 系 142)。new と cross の 244 件の title を走査し、30 件の abstract を確認して、4 本を採用した。
- wildcard の 2610.34283、2610.36077、2610.35013 はいずれも過去の rejected に載っている再来で、hf_upvotes だけが増えている。手動で除外した。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
