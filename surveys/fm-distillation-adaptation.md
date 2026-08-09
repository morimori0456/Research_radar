# Foundation Model Distillation & Adaptation — Living Survey
最終更新: 2026-08-09

## 一言でいうと
大きな基盤モデルの能力を**小さく・低メモリ・ローカル実行可能**な形に移し、他ドメイン・他機種へ適合させる方法を
追う分野。論点は「どう縮めるか(手法)」→「何で教えるか(データ)」→「挙動で診断できているか」と広がり、
今の最前線は **「一様に適用する」前提の解体**にある: 蒸留データは **サンプル単位で約半分が有害**なので gradient
alignment で gate し、経験は **SFT で焼くと 96% 捨てる**ので文脈経由で内在化し、**軌道内の区間ごとに重みを配る**
(失敗軌道を捨てず、teacher が強く主張する場所を優先的に学ぶ)。裏で **teacher の要否**(self / 差分 / 生成)と
**丸ごと蒸留の要否**(中間特徴のアンカーとして使うだけの部分蒸留)も問われ続ける。
共通の実務指針は **「データを増やす前に、今あるデータから取り出せていない信号と、汚れている監督を疑え」**(R2)。

## 系譜マップ
- 何を模倣させるか(手法)
  - output 蒸留(教師出力を模倣)… ベースライン
  - **feature-level 蒸留** … 一般に output より優位
    - **Cross4D-JEPA (00514)** — dense correspondence で 13x 圧縮・同等。利得の主因は「粒度」
    - **Geometric FM Distillation (01851)** — feature 優位 / エンコーダ温存 / SVD warm start
  - タスク空間の中間表現経由: **TGRIP (04812)** — semantic BEV map 経由で異アーキ teacher→student、capacity gap に強い
  - **関係構造を運ぶ**: **MobileSAM2 / HyperKD (12297)** — hypergraph で時間対応(フレーム間)と多粒度マスクの知識を構造ごと転写。点ごとの一致より student の容量要求が緩い。蒸留 loss を student アーキ探索 (NAS) の目的関数にも使う
  - **丸ごと蒸留せず「アンカー」として使う(部分蒸留)**: **LAWM-3D (05706)** — 基盤モデルの出力を模倣するのでなく、
    自前 encoder の**中間特徴を既存 3D foundation model の特徴に固定する制約を1本足すだけ**。視点間の幾何対応を
    「学習で当てさせる」のでなく**外部の基盤モデルから明示的に与える**。フル蒸留よりはるかに軽く、既存の学習ループに
    alignment loss を追加するだけの最小変更で載る。**着手コストが低い割にリターンが読みやすい**レバー
  - 模倣でなく「重みを生成する」: **PAW (02512)** — compiler が adapter を直接 emit、0.6B≈32B・メモリ 1/50
- teacher の要否を問い直す(今週の主戦線)
  - **最終状態でなく「学習の差分」を運ぶ**: **Direct-OPD (05394)** — 小モデルで RL を回し、(pre-RL, post-RL) の log 比を dense な implicit reward として強い student に適用。ターゲット上で高価な RL を回さずに weak→strong
  - **固定 teacher を要さない self-distillation**: **SEED (14777)** — 生徒自身が自分の軌跡から hindsight skill を抽出し、skill 有無の確率差を token 単位の dense 蒸留信号に変換、outcome RL と同時最適化(off-policy 分布ずれを回避)
  - **student 自身を摂動の条件に**: **SAKD (11557)** — teacher の静的特徴でなく進化中の student 特徴を条件に、パラメータフリーの cyclic shift で多様なビューを生成。追加パラメータ・多段学習なしで multi-teacher 級
  - **生成軌跡上で teacher を当てる (on-policy)**: **ABOPD (18835)** — 固定データでなく **student 自身の生成軌跡上で teacher が監督**し exposure bias を潰す。反復/自己回帰生成(diffusion policy・world model・AR planner)全般に横展開。ABot-World-0 の LongForcing はこの long-horizon 版
- **軌道の「どこを学ぶか」に重みを配る(2026-W32)— 選別(捨てる/使う)から重み付け(区間ごとに配る)へ**
  - **正解から逆算して中間目標を作る**: **ABSeeker (05102)** — 学習時に ground-truth を持っている立場を使い
    **「この答えに至るには途中で何を掴んでいる必要があったか」を答え側から復元**(answer-backtracked clue recovery)、
    clue の回収度で各ステップを採点。**失敗軌道の中の正しかった判断にも点が入る** = 成功軌道だけ残す rejection
    sampling が捨てている情報を回収する。SFT (loss 重み) と GRPO (報酬) の両方に同じ信号を差し込む。
    Qwen3.5-4B・**8.5k 例**で BrowseComp 37.3%。**前向きの reward shaping は恣意的になるが、逆算なら中間目標が
    ゴールから機械的に決まる**のが設計上の利点。弱点は clue の復元自体を LLM に任せており必要条件性が未検証
  - **teacher との食い違いを「損失」でなく「重要度」として読む**: **AgentOPSD (05987)** — 正解を使わず、
    **privileged teacher と student の log-prob 差**を turn 単位に集約し、**log-odds 空間の Bayesian 再帰更新**で
    「ここが勝敗の分かれ目だった確率」を持つ。**絶対値でなく信念の変化量**で pivotal turn を判定。
    critic も追加 rollout も不要で既存の policy optimization にそのまま乗る。ALFWorld 89.1%
  - **2本の対比が設計空間そのもの**: ABSeeker は**外部の正解から逆算**(根拠が固いが正解が要る)、
    AgentOPSD は**内部のモデル比較から推定**(正解不要だが teacher の質に全面依存)。
    **我々は事後的に最適軌道を計算できる場合が多い = ABSeeker 側から試すのが筋**
  - 系譜上の位置: **SEED (14777)**(自分の軌跡から hindsight skill → 確率差を dense 信号に)・
    **Direct-OPD (05394)**(RL 前後の log 比を dense reward に)の延長線上。3本とも
    **「疎な結果報酬を、確率差から作った密な信号に化かす」**という同一の型
- 何で教えるか(データ)— 「一様適用」を捨て選別/検証する(2026-W30 の主戦線)
  - **検証を通ったものだけが次の種になる**: **RST (05466)** — (課題, 環境, 模範解答, 採点器) の4点を整合させたまま
    **検証済みタスクを種に再帰的に難化**させ、生成軌跡を rejection sampling → SFT → agentic PPO。
    15 ラウンドで **$0.05/件・37,484 タスク**、強モデルの pass@4 が 90% → 2.5%。**「作ってから検証」ではなく
    「検証を通ったものだけを次の入力にする」**という順序が肝(planner-evaluation サーベイと相互参照)
  - **サンプル単位で選別する**: **KD Hurt / CHAD (19956)** — Bangla 要約で標準 KD は +0.0003 しか上げず訓練の **約51% が student を悪化**。各サンプルの KD 勾配が validation を下げる方向と揃うか(**gradient alignment**)で有害を弾く gate + **capacity-proportional constraint (CPDP)** で 60M が 50倍の Qwen2.5-3B 超え。コード公開
  - **経験をどう重みに焼くか**: **Experience Distillation (21051)** — 集めた経験を素朴な **SFT で焼くと ICL 利得の 3.8% しか回収できない**。**context distillation**(文脈で得た ICL 振る舞いを重みへ内在化)なら環境対話ゼロで 64.8%+ を保持、RL 同等を **9.6倍少ない環境サンプル**で
  - **検証済み合成データで焼く**: **SLAI T-Rex (20145)** — **solver-verified synthetic data**(最適化ソルバで解の正しさを自動検証した合成文書)を SFT に混ぜ人手ラベル無しで正解保証。10K の特化 SFT で GPT-5.4-Mini を +3.98pt。「生成は難しいが検証は容易」なドメイン(実行可能性・衝突判定)に転用可
  - **負の知見(監督の汚染)**: **LAWM-3D (05706)** — multi-view 動画を足しても 3D 理解は出ない。原因は
    **未来フレームの見た目が漏れるショートカット学習(appearance leakage)**。処方は **non-injective な RGB-D 同時再構成**で
    覗き見を封じること。**データを増やす前に何が supervision を汚しているかを疑え**という順序の教訓
    (vla-world-model サーベイと相互参照)
  - **負の知見**: **Answer-Conditioned CoT (14552)** — 失敗サンプルを gold answer で救済すると答えから逆向きに正当化した chain になり、**correctness filter で検出できない形で**データが劣化(最難問で最大 ~27pt)。症状は early final-answer statement、処方は **answer-blind 生成**
  - 分布の広さ: **ZipDepth (08771)** — 頑健性は teacher でなく multi-domain データで決まる。1/50 サイズで zero-shot 保持
  - 少データの選定: **Few-Medoids (05891)** — クラス centroid 近傍の典型例選定が random に一貫勝ち
  - 合成データ: **constraint-first 合成 pre-training (06483)** — 物理制約だけ守りリアリズムを捨てて多様性極大化
- 挙動レベルの診断・校正
  - **Soft Clamp (07050)** — 少数 token の leverage 不均衡による挙動シフトを per-token 発散の圧縮で校正
  - **MIPI/MIPU (29526)** — train/deploy エンジンのズレ(training-inference mismatch)と selective acceptance
  - **Flow-ERD (06957)** — entropy 正則化 reverse-KL で teacher 追従と多様性維持を両立
- 縮めた後の適合(fine-tuning / ドメイン適合)
  - **凍結特徴 + 極小 head で capacity gap を回避**: **Patch Policy (18236)** — 事前学習 ViT の**パッチ単位の密特徴を凍結**したまま軽量 policy に直接食わせ、fine-tune 済み OpenVLA-OFT を **+18%・学習パラメータ約 0.7%**。「大モデルの価値の大半は *凍結特徴* にある」/ **Point Ladder Tuning (19171)** — 凍結 point backbone + **2.7% param** で downsampling が捨てた局所幾何を ladder で拾い直す PEFT、AD の LiDAR 知覚適合に直結
  - **hypernetwork で adapter を生成/融合**: **DA-MergeLoRA (17467)** — ドメイン別 LoRA ライブラリを hypernetwork で学習的に merge、新規デプロイ先の**無ラベル少データ**適合 / **Hypernetwork Knowledge Injection の scaling law (19604)** — 適合を「対象ごとに LoRA を都度学習」から「hypernetwork が adapter を生成」へ amortize、**OOD で急な scaling**。PAW(02512)の系譜に scaling 則を与える
  - **容量の配り直し**: **UMoE (11444)** — SFT の *前* に低 saliency expert を prune → 摂動で regrow。**パラメータ数・推論コスト不変**のまま単一 frozen recipe で 2アーキ×5ドメイン×12ベンチ全勝
  - **入力仕様の違いを branch で吸収**: **MBTI (12782)** — 入力を共通仕様に潰さず連続帯ごとに branch 分割し branch 別 LoRA + attention 融合。センサ構成が違う他機種への適合の縮図(学習は全体の 2.3%)
  - PEFT 比較: **Efficient PEFT (02158)** — (精度, メモリ, エネルギー) の比較表
  - 機種条件付き on-policy 蒸留: **UI-MOPD (04425)** — 機種別 teacher 群→単一 student、忘却防止と同構造
  - アノテーション無し cross-domain: **Wat3R (08772)** — teacher-student + 幾何整合 loss、評価セットは先に小さく作る
  - 転移の正則化: **UNIVERSE (05133)** — video co-training が zero-shot 転移を改善(詳細は vla-world-model 側)
- 直交する後段圧縮: **Vitality-Aware Compression (00382)** — 層ごと vitality で圧縮強度を配分

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-08-09 | AgentOPSD (2608.05987) | teacher/student の log-prob 差を「重要度」として読み、log-odds Bayesian 更新で pivotal turn に重みを配る | [brief](../briefs/2026-08-09/2608.05987.md) |
| 2026-08-09 | ABSeeker (2608.05102) | 正解から逆算して中間 clue を復元し区間ごとに採点、失敗軌道も捨てない。8.5k 例で成立 | [brief](../briefs/2026-08-09/2608.05102.md) |
| 2026-08-08 | LAWM-3D (2608.05706) | 3D FM を中間特徴のアンカーに使う部分蒸留 + appearance leakage の封じ方。人間動画 pretrain → ロボット FT | [brief](../briefs/2026-08-08/2608.05706v1.md) |
| 2026-08-08 | RST (2608.05466) | 検証を通ったものだけを次の種にする再帰的データ生成 → rejection sampling → SFT → RL | [brief](../briefs/2026-08-08/2608.05466.md) |
| 2026-07-26 | SLAI T-Rex (2607.20145) | solver 検証済み合成データで trillion MoE を OR ドメインへ full-param 適合 | [brief](../briefs/2026-07-26/2607.20145.md) |
| 2026-07-25 | Experience Distillation (2607.21051) | 経験を context distillation で内在化、SFT が捨てる 96% を回収 | [brief](../briefs/2026-07-25/2607.21051v1.md) |
| 2026-07-24 | KD Hurt / CHAD (2607.19956) | 蒸留データの約半分が有害、gradient alignment で per-sample に gate | [brief](../briefs/2026-07-24/2607.19956v1.md) |
| 2026-07-24 | Hypernetwork Knowledge Injection (2607.19604) | hypernetwork が LoRA を生成、OOD で急な scaling law | [brief](../briefs/2026-07-24/2607.19604v1.md) |
| 2026-07-23 | ABOPD (2607.18835) | on-policy distillation、student の生成軌跡上で teacher が監督し exposure bias を潰す | [brief](../briefs/2026-07-23/2607.18835.md) |
| 2026-07-23 | Point Ladder Tuning (2607.19171) | 凍結 point backbone + 2.7% param で局所幾何を拾い直す PEFT、LiDAR 適合 | [brief](../briefs/2026-07-23/2607.19171.md) |
| 2026-07-22 | Patch Policy (2607.18236) | 凍結 ViT 密特徴 + 極小 head で fine-tune 済み VLA を +18%・学習 0.7% | [brief](../briefs/2026-07-22/2607.18236.md) |
| 2026-07-22 | DA-MergeLoRA (2607.17467) | ドメイン別 LoRA を hypernetwork で融合し無ラベル少データ適合 | [brief](../briefs/2026-07-22/2607.17467.md) |
| 2026-07-18 | SEED (2607.14777) | 生徒自身の軌跡から hindsight skill を抽出、確率差を dense 蒸留信号に | [brief](../briefs/2026-07-18/2607.14777.md) |
| 2026-07-18 | Answer-Conditioned CoT (2607.14552) | gold を見せた chain 生成は filter を通り抜けてデータを最大27pt劣化させる | [brief](../briefs/2026-07-18/2607.14552.md) |
| 2026-07-16 | MobileSAM2 / HyperKD (2607.12297) | hypergraph で時間対応と多粒度を構造ごと転写する動画 FM 蒸留 | [brief](../briefs/2026-07-16/2607.12297.md) |
| 2026-07-16 | MBTI (2607.12782) | センサ構成差を branch 別 LoRA + attention 融合で吸収する PEFT | [brief](../briefs/2026-07-16/2607.12782.md) |
| 2026-07-15 | UMoE (2607.11444) | SFT 前の prune→regrow だけで推論コスト不変のままドメイン適合を底上げ | [brief](../briefs/2026-07-15/2607.11444.md) |
| 2026-07-15 | SAKD (2607.11557) | student の進化中特徴を条件に cyclic shift でビュー生成、追加パラメータなし | [brief](../briefs/2026-07-15/2607.11557.md) |
| 2026-07-15 | Direct-OPD (2607.05394) | teacher の RL 前後の log 比=「学習の差分」を dense reward として weak→strong | [brief](../briefs/2026-07-15/2607.05394.md) |
| 2026-07-11 | ZipDepth (2607.08771) | 6.1M で FM 級 zero-shot 深度。鍵は multi-domain 蒸留データ | [brief](../briefs/2026-07-11/2607.08771.md) |
| 2026-07-11 | Wat3R (2607.08772) | アノテーションゼロの cross-domain 3D 適合 recipe(悪天候に読み替え可) | [brief](../briefs/2026-07-11/2607.08772.md) |
| 2026-07-10 | Soft Clamp (2607.07050) | multi-teacher 蒸留の挙動シフトを token leverage で解明・校正 | [brief](../briefs/2026-07-10/2607.07050.md) |
| 2026-07-10 | Flow-ERD (2607.06957) | entropy 正則化 reverse-KL の closed-loop 蒸留、realism–diversity Pareto | [brief](../briefs/2026-07-10/2607.06957.md) |
| 2026-07-09 | Few-Medoids (2607.05891) | 少データ蒸留は「典型例選定」だけで random に勝つ | [brief](../briefs/2026-07-09/2607.05891.md) |
| 2026-07-09 | 合成 pre-training (2607.06483) | 制約優先・リアリズム放棄の合成データで少データ適合 40% 改善 | [brief](../briefs/2026-07-09/2607.06483.md) |
| 2026-07-08 | TGRIP (2607.04812) | VLM 知識を semantic BEV 経由で車載ネットに蒸留、annotation 不要 | [brief](../briefs/2026-07-08/2607.04812.md) |
| 2026-07-08 | UI-MOPD (2607.04425) | 機種条件付き単一 student への on-policy 蒸留、忘却防止 | [brief](../briefs/2026-07-08/2607.04425.md) |
| 2026-07-07 | MIPI/MIPU (2606.29526) | training-inference mismatch: 最適化対象と deploy 挙動のズレを疑え | [brief](../briefs/2026-07-07/2606.29526.md) |
| 2026-07-05 | Program-as-Weights (2607.02512) | compiler が adapter 重みを直接生成、0.6B≈32B・メモリ 1/50 | [brief](../briefs/2026-07-05/2607.02512.md) |
| 2026-07-04 | Efficient PEFT (2607.02158) | 2GB 予算下の PEFT 比較表、凍結 DINOv2+線形が微調整超え | [brief](../briefs/2026-07-04/2607.02158.md) |
| 2026-07-04 | Geometric FM Distillation (2607.01851) | feature 優位 / エンコーダ温存 / SVD warm start の3原則 | [brief](../briefs/2026-07-04/2607.01851.md) |
| 2026-07-02 | Cross4D-JEPA (2607.00514) | dense 対応蒸留で 13x 圧縮・同等、主因は粒度 | [brief](../briefs/2026-07-02/2607.00514.md) |
| 2026-07-02 | Vitality-Aware Compression (2607.00382) | 層 vitality で圧縮強度を配分(後段圧縮の着想) | [brief](../briefs/2026-07-02/2607.00382.md) |

## Open Questions
- **失敗軌道を「捨てる」から「区間重み付きで使う」に変えると baseline を超えるか**(05102)— 重みの作り方は最初は雑でよく
  (終端から遡って行動を摂動し成功率が落ちる区間を重くする)、**成功軌道のみの baseline を超えるか**だけを見る。
  超えれば収集コストを増やさずに実効的な学習信号量が増える
- **逆算で引いたサブゴールは本当に必要条件か**(05102 の弱点)— 「この区間を踏まなければ本当に失敗したのか」は
  反実仮想の問題で、シミュレータで実際に踏まずに走らせて確かめる必要がある。**運転では検証できるのが利点**
- **運転で「1 turn」とは何か**(05987)— 固定制御周期か、意味的イベント(車線変更・減速開始・分岐通過)か。
  ここを決めないと後段が全部ぶれる。また log-prob 差は確率的方策が前提で、**決定論的な回帰型 planner には
  そのままは載らない**(予測分布の KL で代用できるか)
- **privileged teacher(未来3秒の他車軌道を入力に足しただけ)との差が大きい時刻は、人間が「判断ポイント」と
  思う時刻と重なるか**(05987)— 重ならなければ手法の前提が我々の設定で成立していない
- **3D/depth foundation model への alignment loss を1本足すだけで、視点変化・カメラ位置変更への頑健性はどれだけ上がるか**
  (05706)— フル蒸留に対するコスト対効果が読みやすく、**最初に試すべき部分蒸留**
- **うちの蒸留データの有害サンプル比率は何%か** — 19956 の gradient-alignment を per-sample に測るだけ。50% 近ければ
  recipe を選別型に切り替える価値が確定(W30 推薦実験)。capacity gap が大きいほど gate の利得は開くか(CPDP)
- SFT の利得回収率 (21051) は運転/planner の経験でも一桁%まで落ちるか。context distillation で何倍回収できるか
- **solver/simulator 検証済み合成データ (20145) は運転の「実行可能性・衝突判定」でそのまま機能するか** —
  検証強度(厳密/heuristic/無)を振ると SFT 後性能はどこで頭打ちになるか
- hypernetwork による adapter 生成 (17467/19604) が個別 LoRA を上回る交差点はどこか。多機種展開のコスト構造を変えるか
- **teacher は本当に要るか** — SEED (self) / Direct-OPD (差分) / SAKD (student 条件) は
  いずれも teacher への依存を減らす方向。capacity gap が大きい設定でどこまで teacher-free で届くか
- 「学習の差分を蒸留する」(05394) は非言語 token 列(軌道生成)に移せるか。
  reference チェックポイントの選び方に結果がどれだけ敏感か
- 蒸留データの静かな劣化 (14552) は運転ドメインにも同型の罠があるか —
  例: 失敗軌道を「正解軌道に寄せて」再生成する data augmentation は同じ後付け正当化を作らないか
- 関係構造の蒸留 (12297) は、点ごとの feature KD より本当に容量要求が緩いのか(縮小率スイープで検証可能)
- 推論コスト不変の容量再配分 (11444) は dense モデル(FFN ニューロン単位 saliency)にも効くか
- 縮小率スイープで精度が急落する「破綻境界」は手段(feature/output/adapter 生成)でどれだけ動くか?(R2 系統則)
- **「頑健性はデータ分布の広さで決まる」(ZipDepth) は破綻境界も右に動かすか — データ×手法の交互作用**(R2 の新変数)
- adapter を forward 1回で生成(PAW)vs 少データ LoRA、コスト対効果の交差点は?
- capacity gap を跨げる interpreter サイズの下限(0.6B/1.5B/4B スイープ)
- 集計 loss に見えない挙動シフトは、軌道生成のような非言語 token 列でも per-token 診断で検出できるか?
- 蒸留の目的関数を deploy 時挙動(量子化後)に張り替えると、capacity gap 大の設定で効くか?(MIPI の移植)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
