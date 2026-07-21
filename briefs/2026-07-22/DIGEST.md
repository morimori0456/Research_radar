# DIGEST — 2026-07-22

> **✅ 収集パイプライン復旧。** 候補 48 件、**P1/P2/P3 の本枠が久々に揃った**(直近 3 日は本枠 0 件・wildcard のみだった)。
> 採用 6 件(P1×1・P2×2・P3×2・wildcard×1)。P1 は今回、本枠候補が全体に弱く 1 件のみ採用。
> **注記:** RAGU (2607.11683) が昨日ブリーフ済みなのに再提示された。dedup 欠如の症状は今日も残る([[fetch-duplicate-candidates]])。

---

## 今日読むべき TOP3

### 1. GeoWorldAD — 「未来の空き空間」を先読みする E2E 自動運転(P3, 本命)
本日いちばんミッション直撃の 1 本。**E2E(知覚から行動まで1モデル)の自動運転**に、周辺エージェントと自車前方の free-space(空き空間)が短期でどう変化するかを予測する小さな **world model 的 head(latent future geometry token)**を足した構成。効く理由は明快で、「未来の空き空間」を先読みできると、**安全性を落とさずに過度な減速(過保守な判断)を減らせる**と、我々の評価ベンチである **NAVSIM v1/v2 で SOTA** を示している。P3(アーキ)と P1(NAVSIM 評価・collision と progress のトレードオフ)を同時に射抜く。→ [ブリーフ](2607.17521.md)

### 2. Patch Policy — 巨大 VLA を fine-tune せず「凍結した密特徴 + 極小 head」で超える(P2)
本日の **capacity gap(teacher と student の表現力差が開きすぎて蒸留が失敗する現象)への最も鋭い教訓**。事前学習 ViT(画像をパッチに割る視覚バックボーン)の**パッチ単位の密特徴を凍結したまま**、軽量な policy に直接食わせるだけで、**fine-tune 済み OpenVLA-OFT を +18% 上回り、しかも学習パラメータは約 0.7%**。「大きなモデルの価値の大半は *凍結特徴* の中にあり、バックボーン全体を fine-tune しなくても取り出せる」——student を巨大化せずに済む可能性を突きつける。→ [ブリーフ](2607.18236.md)

### 3. RynnBrain 1.1 — 異機体で action space を共有する embodied 基盤モデル(P3, hf=136 中の本枠最高 hf=31)
新しい open な embodied foundation model の family(2B→122B の MoE = 一部の専門家サブネットだけ活性化して総容量を増やしつつ計算量を抑える構造)。読む価値は 2 つ。**(a)** 標準ベースライン/蒸留 teacher 化する公算が大きい注目株(本枠で本日最高の hf=31)。**(b)** 「1つのバックボーン + 機体ごとの masking で異機体を跨いで学ぶ」recipe は、将来 1 モデルを車種・センサ構成違いに展開したい時の設計テンプレート。→ [ブリーフ](2607.17977.md)

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| P1 planner | [2607.18060](2607.18060.md) | RoboHarness: 異種 policy の orchestration + 能力境界の routing |
| P2 distill/ft | [2607.18236](2607.18236.md) | Patch Policy: 凍結 ViT 密特徴 + block-causal head |
| P2 distill/ft | [2607.17467](2607.17467.md) | DA-MergeLoRA: hypernetwork で source LoRA を融合し少データ適合 |
| P3 next_arch | [2607.17521](2607.17521.md) | GeoWorldAD: geometry world action model (E2E AD) |
| P3 next_arch | [2607.17977](2607.17977.md) | RynnBrain 1.1: cross-embodiment embodied foundation model |
| wildcard EXPLORE | [2607.17423](2607.17423.md) | TimeLens2: set-valued な temporal Wasserstein reward |

落選 42 件の理由: [rejected.md](rejected.md)

---

## プロジェクト別の要点

- **P1(Planner AI + 評価):** 本枠候補は今回全体に弱く採用 1 件。**GeoWorldAD が NAVSIM v1/v2 で我々の評価面に直接乗る**のが最大の収穫で、「future-token を ablate して collision-vs-progress の動きを切り分ける」実験が明日にでも立てられる。**RoboHarness** からの持ち帰りは「各 planner の in-distribution state region を推定し、planner 間の不一致を eval シグナル / fallback trigger にする」評価上の着想。次点(rejected 参照): Reasoning double-edged sword(reasoning が VLA を *弱く* する反証)、Thinking in Video(world model 評価の perception-prediction gap)。
- **P2(FM 蒸留 + 適合):** 本日の主戦場。2 つの相補的な収穫。**Patch Policy** = 「凍結特徴 + 極小 head」で capacity gap を回避する容量設計、**DA-MergeLoRA** = ドメイン別 LoRA ライブラリ + 学習された merging で無ラベル少データ適合する recipe。実験候補: (1) full fine-tune vs 凍結密特徴 + 軽量 head の Pareto 比較、(2) 運用ドメイン別 LoRA を hypernetwork で融合し新規デプロイ域へ適合。**次点の What Transfers Under Source Shift**(source shift 下では simpler is safer / LoRA は優位を失う)は適合戦略を決める前に本文参照推奨。
- **P3(次世代アーキ):** GeoWorldAD(world model + action for AD)と RynnBrain(embodied FM の scaling + cross-embodiment)で本枠を確保。**共通テーマは「world/geometry の先読み」と「1 バックボーンの多機体展開」**。次点 POT-VLA(persistent 3D object token で verifiable execution)も closed-loop 検証の設計として追跡価値。
- **横断(wildcard):** TimeLens2 の **matching 不要な set-valued reward(temporal Wasserstein)** は、multi-modal trajectory prediction(P1)という *同じく可変個数の集合値問題* への転用余地。winner-take-all matching loss を集合距離に置換する実験が候補。

---

## パイプライン状況(復旧確認)

**本枠(P1/P2/P3)候補が 3 日ぶりに供給された** = arXiv 取得は今日は成功。ただし既知バグは未修正のまま:
- **dedup 欠如は今日も顕在化** — RAGU (2607.11683) が昨日ブリーフ済みなのに wildcard 枠で再提示された。
- 本枠 0 件を招いていた「arXiv 取得失敗の握り潰し」は、今日はたまたま取得成功で表面化しなかっただけ。根治(取得失敗を candidates 生成前に検知して落とさない + wildcard の dedup)は依然として判断待ち。→ [[fetch-duplicate-candidates]]
