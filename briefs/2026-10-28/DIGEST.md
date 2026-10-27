# DIGEST 2026-10-28

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は本流 51 件 + sns_wildcard 3 件 (generated_at 2026-10-27T18:00Z) で、本流が届いたため RSS 回収は行っていない。wildcard は本流に評価 4 以上が十分あり、上限 6 本が埋まったので採用していない。トピックの付け替えが 2 件ある: 2610.35448 (fm_distill_finetune として届いた) は内容が planner の評価なので P1、2610.34674 (next_arch として届いた) は評価指標の提案なので P1 で採用した。

## 今日読むべき TOP3

1. **[2610.35448 特定の planner の弱点に合わせて危険場面を作り、fine-tuning で衝突率を半減](2610.35448.md)** (P1) — end-to-end driving model (画像から軌道まで 1 つの network で出す運転 model) は標準 benchmark では良くても、危険場面では衝突しやすい。著者らは NeuroNCAP (closed-loop の衝突回避評価 benchmark) で DiffusionDrive の衝突の 95.9% が「見えているのに避けられない」planning の失敗だと切り分け、その planner の planning head から軽い代理 model を蒸留して、重い画像 renderer を使わずに危険場面を探す。選んだ 50 場面 (攻撃 + 安全な回避軌道) で fine-tuning すると、closed-loop 衝突率が SparseDrive 28.0% → 12.2%、DiffusionDrive 37.5% → 19.2% になる。効果は「その planner 用に作った場面」で最も大きく、他の planner の場面では 18.3 点の低下が 6.7 点に減る。失敗を perception 側と planning 側に分けて数える、評価 set を planner ごとに作る、という 2 点は自前の評価にすぐ使える。ただし代理 model と本体のずれの大きさは abstract に無い。
2. **[2610.34689 RSKD: 運転 VLM の蒸留で、teacher を信じる度合いを語句ごとに変える](2610.34689.md)** (P2) — knowledge distillation (大きな teacher の出力を小さな student に真似させる学習) は、全 token を一様に合わせると planning に効く語が薄まり、teacher が間違っているときはその誤りも写る。RSKD は答えの中の重要な語句を取り出し、teacher の予測が正解と意味的に一致する語句では teacher の蒸留 loss を強め、一致しない語句では正解ラベルの loss を強める。蒸留 loss は JSD (2 つの確率分布の違いを測る距離) で、既存の要素の重みを切り替えるだけの単純な設計。DrivingVQA と LingoQA (運転場面の質問応答) で student ベースの比較手法を上回る。teacher に間違いを混ぜて「誤りを増幅しない」を安く再現できるので、P2 の「実務で回す recipe」の候補になる。closed-loop の運転性能との関係と、改善幅の数値は abstract に無い。
3. **[2610.35044 DriveUniTok: 見た目・depth・自車軌道を 1 つの latent に統合した driving world model](2610.35044.md)** (P3) — world model (将来の状態を予測する model) を、画像、LiDAR depth を投影したもの、自車の動きの 3 つを別々に扱わず、1 つの連続 latent に符号化する tokenizer (入力を latent に変換する encoder / decoder の組) で統合する。tokenizer を凍結して、その上で diffusion model が未来の latent を予測し、decode すると未来の見た目・depth・自車軌道が出る。NAVSIM (実走行 log を使う planning 評価) で別々に扱う構成より予測も planning も良く、計算コストも低い。RL post-training 後の PDMS (NAVSIM の planning score) は 91.54 で、比較した WAM (World-Action Model; 世界の予測と行動を同じ model で出す) 系 planner の中で最高。「先に tokenizer を作って凍結し、その上で適応する」2 段階は P3 の学習の組み立て方として再利用できる。LiDAR depth が前提なので、camera だけの構成なら depth の supervision の入手が先に決める点になる。

## 全ブリーフへのリンク

- [2610.35448](2610.35448.md) — 特定 planner 狙いの危険場面を代理 model で生成し fine-tuning で衝突率を半減 (P1 / fm_distill_finetune から付け替え / 4.5)
- [2610.34674](2610.34674.md) — OSMA-Bench: 障害物の種類だけ変えた対の scenario で、安全性の意味が動きに出るかを SSI で測る (P1 / next_arch から付け替え / 3.5)
- [2610.34689](2610.34689.md) — RSKD: 運転 VLM の蒸留を、語句の重要度と teacher の整合度で振り分ける (P2 / fm_distill_finetune / 4.5)
- [2610.35374](2610.35374.md) — GIFT: Householder reflection で表現の幾何を保つ fine-tuning、未知の天候への汎化 (P2 / fm_distill_finetune / 4.0)
- [2610.35044](2610.35044.md) — DriveUniTok: 見た目・depth・自車軌道を統合した tokenizer と driving world-action model (P3 / next_arch / 4.5)
- [2610.34663](2610.34663.md) — Video World Models Need Predictable Latents: 予測しやすい latent で world model の学習と推論が大幅に安くなる (P3 / next_arch / 4.0)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件、惜しかった 6 件 [OpTTA、VLA-HWBench ほか]、見送った分)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「評価を、失敗の原因に沿って切り分ける」話。35448 は衝突を perception 失敗と planning 失敗に分け、さらに planner ごとの弱点に合わせた場面を作る。34674 は障害物の種類だけ変えた対の scenario で、余白と速度が注意の順序に従うかを測る。最小の一歩は、手元の closed-loop 失敗を「検出できている衝突」と「検出できていない衝突」に分けて数えること (35448)。planning 側が支配的なら、危険場面の生成と fine-tuning に進める。
- **P2 (FM 蒸留 + fine-tuning)**: 34689 は蒸留の loss 設計 (teacher を信じる度合いの局所化)、35374 は別 domain への適合 (表現の幾何を壊さない PEFT)。どちらも運転ドメインで、小さな ablation から試せる。34689 は teacher に誤りを混ぜた data での再現、35374 は同じ parameter 数の LoRA との比較が最初の実験。惜しかった 2610.34756 (Adaptive-LoRA; task ごとに効く layer を選ぶと 30% の layer で全 layer LoRA を上回る) は rejected.md にあり、LoRA の layer 選択を調べる日に先に読む。
- **P3 (次世代アーキテクチャ)**: 2 本とも「latent の設計が world model の性能を決める」という話。35044 は modality を統合した latent、34663 は時間方向に予測しやすい latent を作る。35044 の tokenizer に 34663 の temporal objective を足せるかは、小規模な実験で確かめられる。2610.35636 (OpTTA; 凍結した world model を planning の cost で test 時に適応) と 2610.34717 (VLA-HWBench; Jetson AGX Thor で VLA の latency を 7 stage に分解) は rejected.md に記録した。後者は手元の Jetson での検証に直接関係する。
