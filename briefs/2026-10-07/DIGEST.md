# DIGEST 2026-10-07

候補 63 件から 6 件を採用 (P1 2 / P2 2 / P3 2)。探索枠 (wildcard) は 0 件 (1 件は既出)。根拠は abstract のみで、本文は未確認。

## 今日読むべき TOP3

1. **[2610.06469 Odyssey](2610.06469.md)** — 自動運転 planner の評価 benchmark。既存の評価は短い区間しか見ないので、「最初の判断が 1 分後に響く」失敗を拾えない。Odyssey は 100 秒の closed-loop (planner 自身の出力で車を動かし続ける評価) と、道路地図上の明示的な経路指定で、経路追従と車線変更の準備を測る新指標 (RouteDS など) を出している。P1 の最優先タイプ (評価手法の新提案) で、コードが出れば自前 planner にすぐ当てられる。
2. **[2610.06105 Flash-OPD](2610.06105.md)** — 蒸留のコストを 2.2〜7.5 倍下げる手法。OPD (On-Policy Distillation; 生徒が自分で生成した出力に教師が採点する蒸留) では、生成が長いほど高コストなのに、教師の採点が当てにならなくなる長さは軌跡ごとに違う。Flash-OPD は生成しながら教師との不一致を数え、軌跡ごとに必要な所で打ち切る。精度は維持または向上と報告されている。P2 を実際に回す時の手間を減らす recipe として最も直接的。ただし LLM 設定とみられ、画像/運転への転用は未確認。
3. **[2610.05550 低い予測誤差が planning を誤らせる](2610.05550.md)** — world model (行動の結果を予測するモデル) を MSE だけで選ぶのが危険、という診断。誤差の大部分を占める成分と、行動の順位付けに効く成分が別で、6 セルでは後者だけ直した方が候補の順位が良くなる。ただし設定で結論が変わり、小さな control task での結果。P3 の world model を作る前に、評価指標の設計に取り入れる価値がある。

## ブリーフ一覧
- P1: [2610.06469 Odyssey](2610.06469.md) / [2610.06171 ControlPed](2610.06171.md)
- P2: [2610.06105 Flash-OPD](2610.06105.md) / [2610.06598 SimForcing](2610.06598.md)
- P3: [2610.06805 H-JEPA](2610.06805.md) / [2610.05550 Latent world model の診断](2610.05550.md)
- 不採用と理由: [rejected.md](rejected.md)

## プロジェクト別の要点

### P1 (Planner AI + 評価)
- Odyssey: 長い horizon と明示的な route で closed-loop 評価を作り直す。試すこと: 自前 planner の RouteDS と既存スコアの順位相関。
- ControlPed: 危険な歩行者の場面で、7 つの E2E モデルの HDScore が平均 88.8 → 47.4。通常 scenario のスコアが高くても、この slice を足す必要がある。
- 共通の注意: 両方とも 3DGS (3D Gaussian Splatting; 複数視点から 3D シーンを再構成して描画する手法) の描画に依存するので、描画 artifact と planner の差を切り分ける。

### P2 (蒸留 + 適合)
- Flash-OPD: rollout を軌跡ごとに打ち切って OPD を高速化。
- SimForcing: sim 教師から motion の時間変化だけを蒸留し、見た目の gap を避ける。domain gap 対策の具体例。
- 次点: LoRA の rank/data 選択 (2610.06542)、VLA の forward のみ適応 (2610.06271)。次回の再浮上候補。

### P3 (VLA / World Model / E2E)
- H-JEPA: 時間スケール別の階層で長期 planning (AntMaze 18% → 73%)。運転の経路/操舵の階層に対応しうる。
- 診断論文: MSE でなく action 候補の順位相関で world model を評価する。
- SimForcing の world model で VLA を初期化すると LIBERO が改善。world model → policy の接続の証拠として読める。

## メモ
- 今日の candidates は 63 件で、fm_distill_finetune が 30 件、next_arch が 29 件。fetch の天井 (max_results=30) 付近で、取りこぼしの可能性は残る (今回は未診断)。
- 2609.38879 が wildcard で再来 (10-06 採用済み)。
