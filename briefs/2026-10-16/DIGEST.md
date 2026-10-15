# DIGEST 2026-10-16

## 今日読むべき TOP3

1. **[2610.20609 SafeDriveVLA](2610.20609.md)** — 運転用 VLA (Vision-Language-Action; 画像と言語から行動を直接出すモデル) に「危険なナビ指示」を与えると、既存モデルは従ってしまう。本論文は指示に従った場合の未来を world model (将来の状態を予測するモデル) で想像し、従って安全かを判定する。Bench2Drive で Driving Score 88.16、危険指示での衝突を 60 → 38 に削減。P3 の設計と P1 の評価の両方に効く。
2. **[2610.19714 Uncertainty-Driven Self-Play](2610.19714.md)** — 自分のコピー同士で走らせる self-play で、一部の agent に「他 agent の epistemic uncertainty (モデルの知識不足による不確実性) を上げる」報酬を与え、難しいシナリオを自動生成する。nuPlan Val14 で zero-shot 99.12%。uncertainty が難シナリオの選別器になる点は、手元のシナリオ集合でも検証できる。
3. **[2610.19825 What Matters for World Modeling in VLAs](2610.19825.md)** — VLA に world model を足す 4 方式を同条件で比較した実証研究。decoupled な MoT (Mixture-of-Transformers) の future expert が OOD に強く、2D semantic 表現が安定して効く、という結論。自前 VLA に future 予測を足すときの第一候補を決める根拠になる。

## 全ブリーフへのリンク

- [2610.19714](2610.19714.md) — Uncertainty-Driven Self-Play for Robust Multi-Agent Driving Policies (P1)
- [2610.19601](2610.19601.md) — PA1-OPD: One-Step Prefix-Augmented On-Policy Distillation (P2)
- [2610.19700](2610.19700.md) — ReGRA: Residual-Gradient Adaptation for Complementary Low-Rank Fine-Tuning (P2)
- [2610.20609](2610.20609.md) — SafeDriveVLA (P3)
- [2610.19825](2610.19825.md) — What Matters for World Modeling in VLAs (P3)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard は採用なし)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: uncertainty を難シナリオの選別器にする案が新しい。quota 2 のうち 1 件のみ採用 (他は理論/manipulation で該当なし)。SafeDriveVLA の conflict-aware benchmark は評価観点としても参考。
- **P2 (FM 蒸留 + fine-tuning)**: PA1-OPD は「student が間違えやすい状態だけ teacher に聞く」on-policy 蒸留の軽量版 (LM pretraining での検証)。ReGRA は同じ総 rank で LoRA を相補的 2 段に分け、merge 後の推論コストが増えない。ReGRA はコード公開済み。
- **P3 (次世代アーキテクチャ)**: world model を VLA に統合する設計判断 (What Matters) と、運転での安全ゲート応用 (SafeDriveVLA) が揃った。どちらも abstract のみで確認しており、本文確認が要る。

## 運用メモ

- 本流 64 件 + wildcard 3 件。wildcard は 2609.39601 が既読の再配信、残り 2 件は新規だが不採用。
- 全ブリーフは abstract のみに基づく。fetch の error ログは未確認。
