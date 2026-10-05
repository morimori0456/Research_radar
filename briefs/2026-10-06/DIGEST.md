# 2026-10-06 (火) DIGEST

`git log --since=2026-09-21 -- experiments/` = **0 件** (`experiments/` ディレクトリはまだ無い)。

candidates.json の候補は **3 件** (本流 3 トピックは 0 件・wildcard 3 件、うち 2 件は 10-01/02 に rejected 済みの再来)。予告どおり本流 0 件の日だったので、**RSS で回収した本流 keyword 一致 60 件 (P1 1 / P2 32 / P3 27) を同じ基準で採点した。** **採用 5 件 (RSS 回収 4 + wildcard 1) / 上限 6 に対し 5。**

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 2/2 ・ next_arch 2/2 ・ sns_wildcard 1/1。

> **fetch のエラーは 5 日連続で無い。0 件は announce 遅延による。**月曜 UTC の fetch で、木〜金の投稿分が窓外になった。RSS は 5 本とも 200 で、重複除去後 656 件 (本流 keyword 一致 60 件)。**この 60 件が今日の喪失分に相当し、採用 4 本はすべてここから出た。**fetch 側の修正 (RSS 取得元化・dedup) をしない限り、毎週月曜に同じことが起きる。詳細は [rejected.md §0](rejected.md)。
>
> wildcard の `2609.38078` (10-01) と `2609.38839` (10-02) が HF 経由で戻ってきた。dedup (欠陥②) が wildcard の経路にも要る実例の 2 回目。

---

## 今日読むべき TOP3

### 1. FastOPD (`2610.02832`) —— P2 4.5 / P3 4.0

**なぜ読むか: 大きな VLA (画像と言語から行動を出す基盤モデル) を、推論 2 ステップの小さな生徒に蒸留する recipe。教師の 84% の性能を保ったまま、推論遅延を 78% 減らした。P2 の「蒸留を実務で回す」に最も近く、運転 VLA の制御周期の問題にも直結する。**

鍵は on-policy distillation (生徒自身が実際に訪れる状態で、教師の出力を正解として学習する蒸留)。教師のデータだけで学習すると、生徒が教師の知らない状態に入ったときに誤差が積み上がるが、それを避けられる。理論の裏づけもあるが、評価は操作タスクで、運転ではない。最初の一歩は、**自社の policy head の denoising ステップ数と推論時間を並べて、2 ステップなら制御周期に収まるかを見積もること** (ブリーフの実験 3) → [ブリーフ](2610.02832.md)

### 2. Counterfactual Action Evaluation in JEPA World Models (`2610.02860`) —— P3 4.0 / P1 3.5

**なぜ読むか: world model (行動を入れると次の状態を予測するモデル) の予測誤差が小さくても、「行動が違えば結果も違う」ことを区別できているとは限らない、と実測で示した論文。world model を評価や学習に使うなら、合格条件を「誤差が低い」から変える必要がある。**

同じ状態から行動だけを変えて分岐させ、どの段階で行動の情報が消えるかを調べた。次の画像の 41.5% は行動を変えても画素が同一で、見えていない分は予測できない。見えている場合でも predictor は行動の経路をほとんど使っておらず、同じ大きさのノイズを足した場合の 1/50〜1/190 しか動かない。P1 では、閉ループ評価の simulator が ego の行動に応答しているかの検査にそのまま使える。最初の一歩は、**同一シーンで ego の行動だけを変えた 2 本を回し、他車の反応に差が出るかを数えること** (ブリーフの実験 3) → [ブリーフ](2610.02860.md)

### 3. FUSEye (`2610.02799`) —— P2 4.0

**なぜ読むか: 「カメラが変わると基盤モデルが動かない」という、他機種への適合の典型問題に対し、少量のパラメータと少量のラベルで戻す recipe。ラベル 25% でも全ラベル時の 97.6% に届いた。**

COCO で学習した検出器は、強く歪む魚眼カメラの画像ではほぼ動かない (mAP50 0.148)。本体を凍結して約 22 万パラメータの adapter を足すだけで 0.266 まで上がり、全体 fine-tuning の 84% を保った。adapter の出力を 0 で初期化し、学習開始時は元の検出器と同じ出力にしておく工夫は、LoRA 的な適合にそのまま流用できる。絶対精度は低いので、使うのは recipe の方。最初の一歩は、**他機種のカメラ画像が少量でもあれば、凍結した現行モデルでどこまで落ちるかを測ること** (ブリーフの実験 1) → [ブリーフ](2610.02799.md)

---

## 全ブリーフ

- [2610.02832 — FastOPD: On-Policy Distillation for Lightweight VLA Deployment](2610.02832.md) (fm_distill_finetune / P2 4.5 / RSS 回収分)
- [2610.02860 — Counterfactual Action Evaluation, Observation Bottlenecks, and Representation Geometry in JEPA World Models](2610.02860.md) (next_arch / P3 4.0 / RSS 回収分)
- [2610.02799 — FUSEye: Training-Light Fisheye Detection with Overlapping Views and Zero-Initialized Adapters](2610.02799.md) (fm_distill_finetune / P2 4.0 / RSS 回収分)
- [2610.03587 — AVL-JEPA: Preventing Causal Dynamics Information Collapse in JEPA World Models](2610.03587.md) (next_arch / P3 3.5 / RSS 回収分)
- [2609.38879 — Does Learning Protein Folding Generalize to Broader Reasoning?](2609.38879.md) (sns_wildcard / 探索枠 3.5 / hf_upvotes 94)

不採用: [rejected.md](rejected.md) (62 件)

---

## プロジェクト別の要点

### P1: Planner AI + 評価
- 本流の一致は 1 件で、マニピュレータの関節寿命の motion planning。運転に移せないので採用なし。
- ただし **2610.02860 の「行動だけを変えた分岐で応答量を測る」は、閉ループ評価の simulator の信頼性検査として使える。**他車が ego の行動に反応しない simulator なら、閉ループ評価は実質 open-loop と同じ。

### P2: Foundation Model 蒸留 + 適合 (fine-tuning)
- **FastOPD:** 生徒自身の状態で教師に監督してもらう on-policy distillation + 少ステップ化。蒸留 recipe の最有力。
- **FUSEye:** 凍結 + 0 初期化 adapter + 少量ラベルで他センサーへ適合。ラベル量の曲線 (何 % で全ラベルの 95% に届くか) を自分の機種で出すと、必要なデータ量が見積もれる。
- 次点: GRAFT (`2610.02597`; 教師を後から足していく continual multi-teacher distillation)、Adaptive Mutual Distillation (`2610.02856`)。
- wildcard の Fold2Reason は、fine-tuning データの追加実験では「ランダム/シャッフルの同量データ」を対照に置く、という設計の見本になる。

### P3: 次世代アーキテクチャ (VLA / World Model / E2E)
- **world model の診断と対策が 1 組そろった:** `2610.02860` が「行動の経路を使っていない」ことを測り、`2610.03587` (AVL-JEPA) が行動の情報を残しつつ見た目の摂動に不変にする対策を示す。
- **FastOPD** は、運転 VLA に flow/diffusion 型の head を採る場合の遅延対策の材料。
- 運転向けの world model/VLA の新作は今日の一致には無かった (SymRegFlow は運転動画の生成で、planner への寄与なし)。

---

> **予告 (継続):** 毎週月曜 UTC の fetch は、木〜金の投稿分を窓外にしてエラー無しの 0 件を返す。次は 10-13 (火) の実行。それまでに RSS 取得元化 (修正案は 09-25 の試作 `/tmp/rss_*.py` に原型がある) をしなければ、同じ手作業の RSS 採点がまた必要になる。
