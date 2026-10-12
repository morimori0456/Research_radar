# DIGEST 2026-10-13

候補 3 件 (fetch 月曜夜分。全て sns_wildcard で、本流トピックの候補は 0 件)。abstract のみで評価。採用 1 件 (wildcard 枠の上限)。過去ブリーフとの重複は無し。本流 0 件は 10-12 と同様で、fetch のエラー記録・RSS 回収分は今回確認していない。

## 今日読むべきTOP3

候補が 1 件のため、読むべきものは 1 件のみ。

1. **[2610.12772 Reflex](2610.12772.md)** — humanoid (人型ロボット) が飛んでくる箱を、自分の目 (RGB-D カメラ) だけで全身を使って受け止める論文。学習を 3 段に分け、(1) 箱の真の状態を知っている policy を RL (報酬で方策を学習する) で作り、(2) 遅延・欠損のある観測から箱の動きを推定させ、(3) 画像 encoder にその「箱の動きの表現」だけを復元させる (controller は固定)。視覚学習が重い end-to-end RL から小さな回帰問題に変わる。「特権情報を持つ teacher を、画像だけの student が模倣する」構図は P2 の蒸留に近く、「制御に要る低次元の状態だけを視覚から出す」分離は P3 の E2E 運転の中間表現設計の参考になる。まず運転の toy で「周囲車両の将来軌道の表現を画像から復元する encoder だけ」を学習し、planner 固定のまま teacher との成績差を測るとよい。ただし評価は simulation の humanoid で、運転にそのまま使える手法ではなく「学習の分解方法」だけが転用対象。

## ブリーフ一覧

- [2610.12772](2610.12772.md) — Reflex: Visually Grounded Reactive Humanoid Control (P3 / P2 寄り、wildcard から採用)

落とした候補: [rejected.md](rejected.md) (DiffusionART、S-Space)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 今日は該当なし。Reflex の「遅延・欠損のある観測から動く物体の dynamics を推定する」部分が trajectory prediction と同型という程度。
- **P2 (蒸留 + 適合)**: Reflex の privileged teacher → vision student は、情報量の差を capacity gap の一種として扱う例 (特権情報 87.9% → 視覚のみ 85.7%)。DiffusionART (diffusion の RL fine-tuning を GPU 時間 12 倍減で行う) は不採用だが、fine-tuning 効率化の動向として rejected.md に記録。
- **P3 (次世代アーキテクチャ)**: Reflex の「視覚 encoder は dynamics 表現だけ出し controller は固定」は world model の予測対象を task 必要最小限に絞る選択肢。S-Space (MLLM 内部に座標が線形 subspace で符号化されているという解析) は VLA の空間理解の診断として次点。
