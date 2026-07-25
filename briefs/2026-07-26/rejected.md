# 落選候補 — 2026-07-26

本日の candidates は **sns_wildcard 3 件のみ**(on-topic の P1/P2/P3 候補はゼロ)。
wildcard は最大 1 件の探索枠。1 件(2607.20145 SLAI T-Rex)を採用し、残り 2 件を落選。

---

- **2607.21461: AREX — Towards a Recursively Self-Improving Agent for Deep Research** (hf 125)
  — **重複により無効。昨日 2026-07-25 に既にブリーフ済み**(`briefs/2026-07-25/2607.21461.md`)。
  wildcard の dedup 欠落バグ([[fetch-duplicate-candidates]])により、既ブリーフ ID が再提示された。
  upvotes は最上位だが、重複候補は採用対象外。内容(discovery-verification 非対称を使う再帰
  自己改善 deep research agent、長ホライズン RL + context 圧縮)は昨日評価済み。

- **2605.09635: K12-KGraph — A Curriculum-Aligned Knowledge Graph for Benchmarking and Training Educational LLMs** (hf 55) 🔶次点
  — wildcard 枠が 1 に埋まったため落選。core finding(curriculum knowledge graph 由来の
  graph-guided SFT データが、matched な 2,300-sample budget で 8 種の汎用 instruction-tuning
  corpora を一貫して上回る)は P2 の「少データ適合・データ効率」観点で学びがあり、次点扱い。
  ただし対象が K-12 教育ドメインで自動運転から遠く、SLAI T-Rex の
  「検証済み合成データによる適合 recipe」の方が転用価値が高いと判断。枠が空けば拾う価値あり。
