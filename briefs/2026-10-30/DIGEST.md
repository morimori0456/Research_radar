# DIGEST 2026-10-30

採用は 4 本 (P2 2 / P3 2)。**P1 は該当なしで 0 本**。candidates.json は sns_wildcard 3 件だけで、本流は 3 トピックとも `0 new` (fetch ログに `error` は無し)。wildcard は 3 件とも不採用 (うち 2 件は昨日見送り済みの再来) なので、採用 4 本はすべて arXiv RSS (cs.AI feed) から回収した。

## 今日読むべきTOP3

1. **[2610.36624 MoGAP: 動画 model を robot の制御に転用するとき、「動く場所」だけ強く予測させる](2610.36624.md)** (P3) — WAM (World Action Model; 動画生成 model を土台に、将来の映像と行動を同時に予測する robot policy) は、映像予測を通じて事前学習の表現を対象 domain に適合させる。標準の予測は画面のどの領域も同じ重みで扱うが、制御に効くのは物体や腕が動く領域だけである。MoGAP (Motion-Guided Asymmetric Prediction) は、動く領域に強いノイズ、静止領域に弱いノイズを乗せた diffusion (ノイズ除去で映像を生成する方式) の予測を、学習時だけの補助経路として足し、静止領域を文脈にして動く領域を復元させる。GR-1 (robot manipulation の simulation) で、Fast-WAM が 38.8% から 47.5%、Cosmos3-Nano が 52.3% から 62.3%。運転の動画は画面の大半が静止した背景なので、同じ問題がより強く出るはず。ただし結果は manipulation の simulation のみで、運転では ego motion (自車の動き) を補正しないと「動く領域」が取れない。昨日の JAM (将来予測を補助 loss にする) と同じ「学習時だけ構造を足す」系統の続報。
2. **[2610.36477 MPOPD: 蒸留で「student が出す出力」自体を teacher 寄りに直す](2610.36477.md)** (P2) — OPD (On-Policy Distillation; student が自分で生成した出力に teacher が supervision を付ける蒸留) は、student の出力が teacher の到達しにくい場所に外れると、teacher の supervision が不安定になり、繰り返し出力のような症状が次の round に残って増える。MPOPD (Mixture Proposal On-Policy Distillation) は loss でなく rollout (student が生成する出力列) の分布を設計対象にし、student と teacher の確率の geometric mixture (確率を重み付きで掛けて正規化した混合) に近い proposal policy から sampling する。16 の推論 benchmark で OPD を上回り、Qwen3-4B-Base の数学で平均 +6.91 点、生成長は 41% 短い。P2 の capacity gap (teacher と student の能力差が大きいと student が学べない問題) 対策として、loss を触る前に確認できる failure mode を具体的に示している。対象は LLM の text 推論で、視覚・運転 model では未確認。
3. **[2610.36445 CARD: teacher の出力を student が学びやすい形に書き換えてから蒸留する](2610.36445.md)** (P2) — 大きい reasoning model は reward で「問題を解く solver」として鍛えられており、その出力は小さい model にとって学びにくい。CARD (Cognition-Aligned Reasoning Distillation) は、既存の teacher の軌跡を RL で「教える軌跡」に変換する。reward は 2 つで、student の予測分布に合うほど高い Distribution Alignment Reward と、誤解を招く失敗した途中経過を減らす Logical Coherence Reward。teacher を再 sampling せず既存データを変換するだけで、in-domain で raw な軌跡からの蒸留を上回り、out-of-distribution で特に伸びる。MPOPD が「student の出力」を直すのに対し、CARD は「teacher の出力」を直すので、gap 対策の 2 方向として並べて読める。こちらも LLM の text 推論が対象で、変換 model を回す追加 cost の比較は abstract に無い。

## 全ブリーフへのリンク

- [2610.36624](2610.36624.md) — MoGAP: 動く領域に集中した映像予測を、学習時だけの補助経路として足す WAM の適合 recipe (P3 / next_arch / 4.5 / RSS 回収)
- [2610.36925](2610.36925.md) — Dwell: VLM を latent の world model と policy の兼用にして、再構成なしで imagination から学ぶ model-based RL (P3 / next_arch / 3.5 / RSS 回収)
- [2610.36477](2610.36477.md) — MPOPD: 蒸留の rollout 分布を student と teacher の geometric mixture に寄せる (P2 / fm_distill_finetune / 4.0 / RSS 回収)
- [2610.36445](2610.36445.md) — CARD: teacher の軌跡を student の分布に合うよう RL で変換してから蒸留する (P2 / fm_distill_finetune / 4.0 / RSS 回収)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件、RSS の次点 14 件 [Freeze, Don't Clone、Mamba-2 state compression ほか]、走査のみの分)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 新規候補なし。candidates.json の planner_ai は 0 件で、RSS の 51 件にも planner 実装・評価に使える論文が無かった (cs.RO の RSS は 0 件)。昨日の SRP (運転 policy の内部表現から失敗を予告する linear probe) と KEPT が未着手のまま。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本とも「teacher と student の gap を、学習の loss でなく**データの作り方**で埋める」話。MPOPD は student の rollout 分布、CARD は teacher の軌跡の形を直す。最小実験は、手元の蒸留で teacher の supervision の質 (teacher の対数尤度や entropy) を student の rollout 上で測り、gap が大きい組で質が落ちるかを見ること (MPOPD の failure mode の再現)。どちらも LLM の text 推論が対象で、視覚・運転 model で同じ症状が出るかは確認が要る。次点の ReSeed (2610.37110; 蒸留した画像生成 model の多様性は最初の denoising step で失われる) は、蒸留の診断として rejected.md に記録した。
- **P3 (次世代アーキテクチャ)**: MoGAP は「将来予測の supervision をどこに配るか」、Dwell は「world model は未来を再構成せず、行動に役立つ形で予測すればよい」を示す。どちらも昨日の JAM と同じく、推論時の構成を重くしない方向。最小実験は、JAM 型の foresight loss を付けた driving model に、ego motion を補正した残差で重み付けする MoGAP 流の配分を足すこと。次点の Freeze, Don't Clone (2610.36247; offline データを手放した RL fine-tuning で prior を凍結する) は、imitation で事前学習した driving policy の closed-loop RL に近いので、rejected.md から拾う価値がある。

## 運用メモ

- fetch は木曜 18:00Z 実行 (generated_at 2026-10-29T18:00:37Z)。ログは `0 new` が 3 トピックで、`[fetch] error` は無い。fetch 後に API を直接叩くと、3 トピックとも最新の `published` は 2026-10-27T17:59Z で、cutoff (10-27T18:00Z) の直前で止まっている。announce 遅延により窓の手前側が構造的に空になる既知の現象で、API エラーではない。昨日 (10-29) の本流 55 件は同じ窓のほぼ同じ範囲を拾っていたので、今日の空は「昨日で取り切った」側の可能性が高い。
- RSS は 5 本中 cs.AI だけが 407 件 (他の 4 本は 0 件)、lastBuildDate は 5 本とも 2026-10-29 04:00Z。過去ブリーフ・rejected に既出の id を除き、新規の keyword 一致 51 件 (new 20 / cross 31) を走査した。昨日の candidates.json (55 件) は上書きされて残っておらず、昨日の rejected に載らなかった走査のみの論文が今日の RSS に混じっている可能性がある。
- wildcard の 2610.34283 と 2610.36077 は昨日の再来 (HF の upvotes は増えている)。dedup が wildcard 経路にも要る、という既存の観察と一致する。今回も手動で除外した。
- ブリーフはすべて abstract のみに基づく。数値表・ablation は未確認。
