# DIGEST 2026-11-07

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は 55 件 (planner_ai 2 / fm_distill_finetune 29 / next_arch 21 / sns_wildcard 3)。うち 2611.06918 と 2611.06901 は昨日採用済みの再来で除外した。評価・ブリーフはすべて abstract のみに基づく。wildcard は新規の 3 件で、最高 3.0 のため今日は見送った。

## 今日読むべきTOP3

1. **[2611.07722 OPD の更新が「言い回しの真似」に使われるのを、student 自身の変化量で止める](2611.07722.md)** (P2) — OPD (On-Policy Distillation; student が自分で生成した応答に teacher が token ごとに feedback を返す蒸留) は、teacher と student の確率の差に比例して更新する。数学の応答では、言い回しの位置の差が数学的内容の位置の **3.5 倍**あり、更新の力の多くが teacher の文体の模倣に使われる。SD-OPD (Student-Delta OPD) は、student とその pretrained base の差を更新の係数にして、teacher の feedback と符号が合う token だけ残す。Qwen3 の 1.7B〜8B の 5 構成で、数学 6 task の平均 pass@1 が OPD より 7.76〜10.37 pp 上がる。コードも公開されていて、base model の log-prob を 1 回余分に取るだけなので、手元の蒸留にすぐ足せる。評価は数学 reasoning のみ。
2. **[2611.08016 OPD がなぜ動かない・崩れるかを機構で説明し、offline 蒸留を先に挟む根拠を示す](2611.08016.md)** (P2) — OPD は、更新のたびに student が変わり、次に学習に使う rollout (student の生成) の分布も変わる feedback loop になる。論文はこれを「蒸留の信号が parameter 更新になる段階」と「その更新が別の prefix の予測と rollout 分布を変える段階」に分け、teacher と食い違っても student が動かない現象と、局所的に teacher へ近づくほど失敗する続きの確率も上がって劣化する現象を説明する。offline distillation (teacher が作った固定 data での蒸留) を先にやると held-out accuracy はほぼ変わらないが、その後の OPD で大きく伸びる。1 位と合わせて読むと、「何を更新に使うか」と「どの順で回すか」が揃う。
3. **[2611.08111 near-expert な「危ない trajectory」を負例にして、運転 planner を安全側に押す](2611.08111.md)** (P1) — end-to-end 運転の WAM (World-Action Model; 将来の交通状態と自車の行動を 1 つの生成 model で予測する) は、expert の trajectory を模倣するだけで学習するため、expert に近いが危ない trajectory を抑える信号がない。NegWAM は、expert に幾何的に近いが安全上の危険を持つ負例を作り、予測をそこから遠ざける。推論時に捨てる補助枝で学習するので、**推論の追加コストはゼロ**。NAVSIM v2 (実走行ログに基づく planner 評価 benchmark) の難しい navhard split で 40.4 EPDMS (衝突や走行可能領域などを合成した score) と、最強の比較対象より相対 +4.1%。通常場面 (navtest) は 93.3 でほぼ頭打ちなので、効果は安全が問われる場面に偏る。

## 全ブリーフへのリンク

- [2611.08111](2611.08111.md) — NegWAM: near-expert な負例で WAM の運転を安全側に押す post-training (P1 / next_arch → P1 / 4.5)
- [2611.07912](2611.07912.md) — GuidedWAM: 凍結した WAM に sampling 時だけ energy guidance で運転目的を注入する (P1 / next_arch → P1 / 4.0)
- [2611.07722](2611.07722.md) — SD-OPD: student–base の差を係数にして OPD の更新を内容の token に向ける (P2 / fm_distill_finetune / 4.5)
- [2611.08016](2611.08016.md) — Learning Dynamics of On-Policy Distillation: OPD の loop を 2 段階に分け、offline 蒸留の準備効果を示す (P2 / fm_distill_finetune / 4.5)
- [2611.08128](2611.08128.md) — FreeOcc: 自車の動きを planner に任せて除き、28.3M で 4D occupancy を予測する (P3 / next_arch / 4.0)
- [2611.08156](2611.08156.md) — La-JEPA: 凍結した JEPA feature の上で小さい policy transformer を from scratch で学習する (P3 / next_arch / 4.0)
- [rejected.md](rejected.md) — 不採用 49 件 (重複 2 件を含む) と、持ち越せる次点 7 件

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも NAVSIM v2 の EPDMS で測る WAM の改善で、**同じ model に後から安全性を足す 2 つの経路**になっている。NegWAM は学習時に負例で境界を学ばせ、GuidedWAM は凍結した model に sampling 時の energy (微分可能な望ましさの関数) の勾配を足す。最小実験は、手元の planner に「expert から小さくずらした負例への反発 loss」を 1 つ足すことと、「障害物との最小距離」の energy を 1 つ足して guidance の強さを振ること。planner_ai の 2 件は rehabilitation robot と grasp で運転 planner ではなく、P1 の枠は next_arch から補った。
- **P2 (FM 蒸留 + fine-tuning)**: 昨日は蒸留がゼロだったが、今日は OPD が 3 本 (採用 2 + 次点 1) 出た。SD-OPD は更新の重み付けの recipe、Learning Dynamics は loop の診断と順序 (offline → OPD) の設計で、同じ蒸留を別の側から扱う。最小実験は、手元の teacher–student 組で OPD と SD-OPD を同じ予算で比べることと、offline 蒸留の step 数を振ってから OPD を回すこと。適合側では LoRA の次点が 2 本ある (2611.08414: SFT と RL で LoRA の spectrum の動きが逆; 2611.07349: GEAR; normal space の spectrum で rank を増やす)。
- **P3 (次世代アーキテクチャ)**: 2 本とも「大きな部品を外しても足りる」方向。FreeOcc は自車の動きを model で推定せず planner の出力から除き、La-JEPA は生成 model や VLM を土台にせず、凍結した JEPA feature の上に小さい policy を置く。どちらも推論コスト (車載の制約) に直接効く。最小実験は、既存の occupancy forecaster に自車座標への変換だけ前処理として足すことと、凍結 JEPA 系 encoder の上に小さな transformer を from scratch で学習して現在の backbone と latency を比べること。次点の WAM-Sim (2611.07939; 運転 world model の long rollout の drift を persistent memory と online RL で抑える) は quota 超過で持ち越し。

## 運用メモ

- **candidates.json の fm_distill_finetune は 29 件で、`published` は 11-05T02:08Z〜18:18Z の約 16 時間分**。上限の 30 件に 1 件足りないだけで、天井に当たっている可能性が高い (昨日は 30 件ちょうど)。next_arch は 21 件 (最古 11-04T18:49Z)、planner_ai は 2 件。**今日も RSS での回収は行っていない**。fetch の log も確認していない。
- planner_ai の 2 件が運転と無関係 (rehabilitation と grasp) で、運転 planner の論文は next_arch 側に入っていた。keyword だけで topic を割り当てる fetch 側の限界が続いている。
- 昨日採用した 2611.06918 / 2611.06901 が candidates.json に再来した (id は `v1` 付き)。wildcard だけでなく本流にも既読の除外が無い。`fetch_candidates.py` / `topics.yaml` は変更していない。
