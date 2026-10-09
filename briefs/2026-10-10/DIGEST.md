# DIGEST 2026-10-10

候補 65 件 (fetch 土曜夜分。abstract のみで評価、本文は未確認)。採用 6 件。2610.08448 (cross-tokenizer OPD) は 10-08 に brief 済みのため除外し、wildcard の 2610.08077 を P2 枠に移して採用した。

## 今日読むべき TOP3

1. **[2610.12194 MiniWAM](2610.12194.md)** — world model (行動の結果を予測するモデル) を policy の補助学習に使うとき、未来を「高次元の画像特徴」で予測するのをやめ、制御に関係する情報だけを圧縮した target を予測させる。target が 65 倍小さいのに性能が上がり、学習が最大 8 倍速い。E2E 運転の補助 loss 設計にそのまま試せる。
2. **[2610.12249 Dynamic hazard の motion planning 比較](2610.12249.md)** — 探索ベースの classical planner と、PPO (代表的な RL 手法) で学習した policy を同じ条件で比べた benchmark。環境の動きが確率的になると勝者が入れ替わり、決め手は「観測の欠け」でなく「障害物の動きの不確実性」だと示す。自社の planner 評価に「計算 budget と stochasticity を軸に切る」protocol を足せる。
3. **[2610.08077 SRD](2610.08077.md)** — RL で全 rollout が同じ報酬だと学習信号がゼロになる問題に対し、結果を見た後の振り返りを、結果を知らない状態の自分へ蒸留 (self-distillation) して信号を取り出す。全失敗 group が 98% の設定で成功率 0% → 60.6%。外部 teacher なしで回せる蒸留 recipe として P2 の参考になる。

## ブリーフ一覧

- [2610.12249](2610.12249.md) — Real-Time Motion Planning with Dynamic Hazards (P1)
- [2610.11580](2610.11580.md) — Uncertainty-Aware Optimization for Physics-Aware Highway Trajectory Prediction (P1)
- [2610.12345](2610.12345.md) — Supervised Fine-Tuning under Long-Tail Distribution / PASS (P2)
- [2610.08077](2610.08077.md) — Self-Retrospection Distillation (P2, wildcard から移動)
- [2610.12194](2610.12194.md) — MiniWAM (P3)
- [2610.12368](2610.12368.md) — LiteNWM (P3)

落とした候補: [rejected.md](rejected.md)

## プロジェクト別の要点

- **P1**: 評価では「planner の優劣は環境の不確実性で反転する」(12249) ので、deterministic / stochastic を分けて報告する。予測側は deep ensemble + conformal prediction (予測の外れ率を分布仮定なしで保証する統計手法) で coverage 保証付きの uncertainty region を作れる (11580)。ただし highway のみ・marginal coverage のみ。
- **P2**: 少データ適合は「事前学習で支持が弱い tail concept に予算を寄せる」(12345、prior barrier)。蒸留は privileged 情報を持つ同一モデルを teacher にする self-distillation (08077)。どちらも LLM が対象で、vision への移植は未検証。
- **P3**: world model の target は小さく制御関連にする (12194)。候補軌跡の評価は共有 encoding の latent world model で一括化でき、proposer を替えても再学習不要 (12368、128 倍高速)。どちらも操作/低速 navigation の結果で、運転での検証が先。

## 注記

- 全ブリーフは abstract のみに基づく。数値は著者設定内の主張。
- 次点: 2610.12285 PLaW-VLA、2610.12407 LeWAM、2610.11583 SDPAD (spike-driven E2E planner)。
