# DIGEST 2026-10-29

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は本流 55 件 + sns_wildcard 3 件 (generated_at 2026-10-28T18:00Z) で、本流が届いたため RSS 回収は行っていない。wildcard は本流に評価 4 以上が十分あり、上限 6 本が埋まったので採用していない。トピックの付け替えが 2 件ある: 2610.37299 (next_arch として届いた) は運転 policy の失敗予測という評価・監視の話なので P1、2610.36507 (同じく next_arch) は凍結した foundation model を別の環境に適合させる recipe なので P2 で採用した。planner_ai として届いた 2 件のうち 2610.36726 は低速の協調走行で評価が低く、P1 の 2 本目は付け替えで埋めた。

## 今日読むべきTOP3

1. **[2610.37299 運転 policy の内部表現を読んで、数秒先の失敗を事前に警告する monitor](2610.37299.md)** (P1) — end-to-end driving policy (画像から軌道まで 1 つの network で出す運転 model) は、内部に周囲の車・自車・道路の表現を持っている。SRP (Structured Representation Probe) は、その表現から「この先の重大な失敗の兆候」を線形の分類器 (linear probe) で読み出し、policy を変えずに警告を出す。Bench2Drive (CARLA の closed-loop 運転 benchmark) の 3 つの policy で、軌道のぶれのような既存の runtime 指標より失敗の予測が良い (DriveTransformer で 2 秒先の ROC-AUC が 0.833 対 0.715、runtime overhead は 2.67%)。評価の面では、失敗率だけでなく「何秒前に失敗を予告できたか」を policy の指標に加える使い方がある。simulation の結果のみで、実走行 log と false alarm の頻度は abstract に無い。
2. **[2610.36079 CLAP-AD: 運転の経路は模倣で、速度は安全制約で採点して選ぶ](2610.36079.md)** (P3) — end-to-end driving は人間の運転 log を真似る imitation learning (模倣学習) で作られることが多いが、1 場面には 1 通りの運転しか見えないので、「もう少しゆっくり」のような好みを test 時に指定できない。正しい運転の多様性は経路より速度に出る、という観察から、経路は模倣で学び、速度は候補を複数用意して、物理的な安全制約を教師にした learned scoring function で選ぶ。既存 model に後付けする planning head で、Bench2Drive-Speed の Speed-Adherence Score が最強 baseline より 12.9 点高く (82.53)、NAVSIM v2 (実走行 log の評価) でも backbone に対して EPDMS (planning の総合点) が +6.1。UniAD / VAD に対する +28.5 / +32.7 は旧い baseline との差である点に注意。
3. **[2610.37219 JAM: 動画を生成しなくても、将来の予測を補助 loss にするだけで制御が強くなる](2610.37219.md)** (P3) — robot の policy は、VLM (vision-language model) 由来の VLA (Vision-Language-Action) と、動画生成 model 由来の WAM (World-Action Model) の 2 系統で議論されるが、比較には backbone の初期化、将来への目的関数、推論時に残すかの 3 つの選択が混ざっていた。JAM は、現在の観測の特徴から、凍結した encoder で符号化した将来の観測を予測する foresight loss を足すだけで、推論時には予測 head を捨てる。LIBERO-Plus で FastWAM の 55.3 から 64.5 に上がり、学習の計算量は推定 73% 減る。「world model の恩恵を、推論の latency を増やさずに loss として取る」構成として、車載の VLA に試す価値がある。robot manipulation の simulation のみの結果で、運転での確認は無い。

## 全ブリーフへのリンク

- [2610.37217](2610.37217.md) — KEPT: conformal prediction の keepout を劣化度で条件づけ、制動距離の条件と組み合わせて planner に渡す (P1 / planner_ai / 4.0)
- [2610.37299](2610.37299.md) — SRP: 運転 policy の内部表現から失敗を予告する linear probe (P1 / next_arch から付け替え / 4.5)
- [2610.36507](2610.36507.md) — GRAFT: 凍結した behavior foundation model に、地形用の residual adapter を privileged 情報の蒸留つきで足す (P2 / next_arch から付け替え / 4.0)
- [2610.37021](2610.37021.md) — 地上写真を学習時のみの teacher にして、衛星 embedding の分類器を蒸留で強くする。時間・地理の shift で差が広がる (P2 / fm_distill_finetune / 3.5)
- [2610.36079](2610.36079.md) — CLAP-AD: 経路は模倣、速度は安全制約の scoring で選ぶ plug-in planning head (P3 / next_arch / 4.5)
- [2610.37219](2610.37219.md) — JAM: VLA と WAM を分解し、動画生成なしの foresight loss で制御を改善 (P3 / next_arch / 4.5)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件、惜しかった 8 件 [PDRVLA、ThinkWorld、Live-OPSD ほか]、見送った分)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「安全の判断を、あとから付ける層に分けて持つ」話。37217 は perception の不確かさを conformal 余白として planner に渡し、保証 (coverage) と到達性を別の量で管理する。37299 は policy の内部表現から失敗を事前に読む。最小の一歩は 37299 の probe で、手元の closed-loop 評価の失敗の直前の窓に risk ラベルを付け、actor の表現だけの linear probe の PR-AUC を軌道のぶれの baseline と並べること。37217 の到達率の改善は信頼区間が 0 を含むので、コアの主張は coverage の維持として読む。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本とも「基盤 model は凍結し、学習時だけ使える情報 (privileged information) で小さな部品を学ぶ」話。2610.36507 は residual adapter と、元ドメインで補正を出さない regularization、privileged な地形情報から搭載 depth への蒸留を組み合わせる。2610.37021 は地上写真という推論時に無い情報を teacher にして、凍結 embedding 上の分類器を蒸留し、shift 下で利得が広がる。どちらも運転に直接の検証が無いので、最初の実験は、凍結 backbone の上で camera 配置を変えた適合と、LiDAR を teacher にした camera student の蒸留。惜しかった Live-OPSD (2610.36959; privileged hint 付きの自己蒸留) は rejected.md にあり、蒸留 loss の設計を調べる日に読む。
- **P3 (次世代アーキテクチャ)**: 36079 は end-to-end driving の planning head を「経路は模倣、速度は採点」に分ける。37219 は world model の将来予測を、推論に持ち込まず補助 loss に留める。どちらも「学習時の構造と推論時の構造を分ける」点が共通で、組み合わせは自然 (JAM の foresight loss を付けた policy に、CLAP-AD の速度採点 head を載せる)。惜しかった PDRVLA (2610.37381; 動画生成なしで physical token を予測する VLA) と、world model の faithful さを測る 2610.37588 (latent rollout consistency) は rejected.md に記録した。後者は world model の評価指標を考える日に読む。
