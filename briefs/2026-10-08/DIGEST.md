# 2026-10-08 DIGEST

候補 61 件から 6 件を採用 (P1 2 / P2 2 / P3 2)。採点は abstract のみで、本文・コードは未確認。

## 今日読むべき TOP3

1. **[2610.08448](2610.08448.md) Cross-Tokenizer On-Policy Distillation (P2)**
   教師と student で tokenizer (文字列を token に分ける規則) が違う蒸留では、「token の対応づけを広げるほど良い」と思いがちだが、本論文は逆を示す。確実に対応する位置の top-16 語彙だけで reverse KL (student 側の分布を基準にした KL) を取れば全語彙と同等の精度で、補助 loss を足すと gradient の向きが食い違って精度が落ちる。実装が軽く、補助 loss を足す前に gradient の向きを確認するという習慣にも転用できる。
2. **[2610.08123](2610.08123.md) Query-Based Cost Learning for End-to-End Driving (P1)**
   E2E (センサ入力から計画まで一気通貫) の planner が、走行点列を回帰する代わりに「到達可能な軌道ごとのコスト」を学習する。コストの形が見えるので、安全制約を後から足しやすい。open-loop の L2 が同等でも collision rate に差が出る点は、planner の評価指標を考える材料になる。
3. **[2610.07381](2610.07381.md) GeoWM (P3)**
   world model (環境の将来を予測するモデル) を、将来の画像でなく 3D geometry を直接予測する形にし、再帰的な rollout をやめて誤差の累積と計算量を抑える。driving の depth・pose 予測で既存 world model より良い。同日の PPWM と合わせると、「再帰しない予測」が共通の流れとして見える。

## ブリーフ一覧

| ID | 題 | プロジェクト |
|---|---|---|
| [2610.08123](2610.08123.md) | Query-Based Cost Learning over Reachable Ego Futures | P1 |
| [2610.07277](2610.07277.md) | Distribution-Transfer Safe-Horizon MPC | P1 |
| [2610.08448](2610.08448.md) | Cross-Tokenizer On-Policy Distillation | P2 |
| [2610.08669](2610.08669.md) | MemFLoRA | P2 |
| [2610.07381](2610.07381.md) | GeoWM | P3 |
| [2610.08627](2610.08627.md) | Parallel Predictive World Models (PPWM) | P3 (P1 にも関連) |

不採用: [rejected.md](rejected.md)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 軌道ごとにコストを出す planner は、安全制約の追加や評価指標の差し込みがしやすい。もう 1 本は MPC (Model Predictive Control; 先を予測して制御入力を最適化する手法) で、他車の挙動の確率が不明でも衝突リスクの保証を保つ理論。PPWM は planning 内側ループの高速化でも関係する。
- **P2 (蒸留 + 適合)**: 蒸留は「supervision を増やすより、信頼できる位置に絞る」。適合は、CNN で端末上の PEFT (Parameter-Efficient Fine-Tuning; 少数パラメータだけ学習する手法) を行う場合、律速は activation メモリなので、MemFLoRA の設計基準 (backward が full-width 入力に依存しない) が参考になる。
- **P3 (VLA / world model / E2E)**: GeoWM と PPWM はどちらも、再帰 rollout をやめて指定 horizon を直接予測する。次点には、VLA の action latent (ViDAL)、world model の latent 空間での robust 意思決定 (2610.07599) があり、詳細は rejected.md を参照。

## 補足
- candidates.json の generated_at は 10-07T18:00Z。fetch の diagnostic (エラー有無・RSS 回収分の採点) は今回実施していない。
- 今日の採用は candidates.json の分のみで、RSS 回収分は採点していない。
