# VLA / World Model / E2E Driving — Living Survey
最終更新: 2026-08-09

## 一言でいうと
言語・視覚・行動を1つのモデルで扱う **VLA (Vision-Language-Action)** と、世界の遷移を予測する
**world model** を end-to-end 自動運転にどう接続するかを追う分野。統合の設計空間はほぼ埋まり、論点は
「どう繋ぐか」→「世界状態をどう保持し、どこで grounding するか」→ さらに **「そもそも未来を *描く* 必要があるのか」**
へ降りた: **描画は推論から落とせる**(中間層から軌道が読め、denoising 反復にも鈍感)、**描画を目的にすると
見た目のショートカットを学ぶ**、**その結果できたモデルは物理でなく見た目で汎化する**。処方は
**状態(物理)の枝と描画(見た目)の枝を構造的に分離し、運用では前者だけ走らせる**こと。
残る論点は状態の持ち方(latent / 明示 register / MoE head)と、行動ラベルなし監督のスケール — いずれも
車載レイテンシ・頑健性予算に直結する(R3)。

## 系譜マップ
- **未来を「描く」必要はあるのか(2026-W32 の芯)— 診断 → 処方 → 運用が3本で閉じた**
  - **運用: 描画を推論から落とす** … **Adaptive-WAM (06008)** — video diffusion planner から **反復 denoising ループも
    VAE decode も deploy 時に除去**。性能は **denoising timestep に鈍感**、効くのは DiT の深さだが最終層は不要で
    **中間層 hidden state から良い軌道が読める**。複数ブロックに trajectory head を付け軽量 scorer で早期 exit。
    NAVSIM **90.8 PDMS / 平均 170ms**、fine-tuning なしで nuScenes 転移。「world model = 生成器ではなく特徴抽出器」
  - **処方: 描画を目的にした時の汚染を封じる** … **LAWM-3D (05706)** — multi-view を LAM に食わせても 3D 理解は
    出ない(明示的な negative result)。原因は **未来フレームの appearance leakage** とカメラ間の見た目差。
    処方3点セット = 視点不変な行動 tokenization / 中間特徴を **3D foundation model にアンカー**(軽い部分蒸留)/
    **non-injective な RGB-D 同時再構成**で覗き見を封じる。人間動画 pretrain → ロボット fine-tuning
  - **診断: できたモデルは何で汎化しているのか** … **XEWorld (05799)** — シーン・物理を固定し **機体だけ held-out** に
    する統制テストベッド。汎化を決めるのは **kinematic 類似度ではなく visual similarity** で、現行 world model は
    本質的に **2D 視覚パターンマッチャ**。数値 joint action を一貫した視覚運動に翻訳できず、zero-shot には
    **pixel-space action + 明示的時空間 alignment** が必須。few-shot 適合は既知機体の catastrophic forgetting を招く
  - 系譜の接続: この3本は **HyWorldVLA (20988)**(pre-train で pixel 接地 → 運用は latent 専用)を**層方向**に、
    **WorldWeaver (21594)**(状態推論と描画を別重みに分ける MoT)を**構造方向**に延長したもの。
    5本で「状態の枝 / 描画の枝の分離」という設計方針が固まった
- 統合方式(world model の恩恵をどう受けるか)— R3 分類マップの本体
  - (a) 単一 backbone co-training + 推論時脱着: **UNIVERSE (05133)** — 単一 DiT で video+action、visibility mask で未来漏れ遮断、推論 4.3x 高速・zero-shot 転移
  - (b) 行動表現の座標系を変える: **PixelPilot (04637)** — 画像平面 2D 再定式化で異種データ混合スケール + ego-status 近道学習対策
  - (c) frozen 生成モデルから latent 蒸留で事前知識のみ継承: **InternVLA-A1.5 (04988)** — foresight tokens + VQA 混流 / 系譜: **DriveTeach-VLA (01658)**(知覚蒸留+軌道誘導)・**VLAFlow (01586)**(future latent alignment)
  - (d) dual-level 埋め込み: **WCog-VLA (08375)** — 意味レベル(agent token + Game-CoT)+生成レベル(joint trajectory diffusion)、NAVSIM PDMS 92.9
  - (e) 単一 world latent に理解・予測・行動を統一: **Orca (30534)** — 凍結 latent + 軽量 readout
  - (f) 観測と行動の**座標系を揃える**: **robot-centric pointmaps (11498)** — 各ピクセルに ego/ロボット座標の 3D を格納。dense グリッド形状を保つので既存 2D VLA に最小改修で追加、未知カメラ配置への汎化が拡大
  - (g) 高レベル出力のインタフェース設計: **ABot-N1 (10383)** — slow (CoT 推論) が **pixel goal (画像空間アンカー)** を出し fast (action expert) が waypoint。数値座標より座標ドリフトに強く、複数タスクを1形式に畳める
- 世界状態と行動を「どう持つか」(2026-W30 の主戦線)— 上の統合方式を横に切る新しい設計軸
  - 予測ターゲット **pixel か latent か**: **HyWorldVLA (20988)** — pre-train で **pixel 再構成により latent を実映像に接地**、co-fine-tuning/推論は **latent 専用**に絞り高速・頑健。world model のノイズ頑健性を測る評価軸を新設、NAVSIM v1/v2 で pixel/latent 両 baseline 超え
  - 状態を **観測履歴か明示 register か**: **WorldWeaver (21594)** — **world state registers**(学習可能な記憶スロット、チャンク生成ごとに更新)+ BEV/scene text 接地、状態推論と描画を **Mixture-of-Transformers** で分業。multi-agent/multi-view の状態一貫性
  - action head を **単一か MoE か**: **MoE VLA (20771)** — action head を MoE 化すると原始技能(車線維持・合流・停止)が expert に自然分離・創発。router 再学習で few-shot 適合
  - 長ホライズンで崩さない: **ABot-World-0 (19191)** — **LongForcing**(student の長 self-rollout を長ホライズン teacher に整合)+ **ODE distillation**(多step 拡散を少step へ蒸留)で drift 抑制。RTX 5090 単体 720P 16FPS
  - action を視覚空間で条件付け: **Masked Visual Actions (19343)** — action を pixel 空間の **部分開示された軌跡**として渡す。同一モデルが forward(行動→応答)/inverse(望む運動→行動)両用。imagined rollout が実行と相関 → planning のランキングに使える
  - 未来幾何を明示 token に: **GeoWorldAD (17521)** — 周辺 agent と自車前方 free-space の短期変化を予測する軽量 **latent future geometry token** を E2E AD に付加。過保守な減速を減らし NAVSIM v1/v2 SOTA
- continual で「どこが忘れるか」を成分別に測る(2026-W30)
  - **World Model Remembers, Actor Forgets (19749)** — DreamerV3 系で連続タスクを学ぶと **world model は reward/value/終了構造を retention≈1.0 で保持し actor だけ崩壊**。凍結 world model の夢中 RL では回復せず(0/3)、採点済みの夢への **self-imitation (dream rehearsal)** なら環境対話ゼロで 3/3 回復。忘却対策のリソースは policy 更新経路へ配れ(事前登録・棄却仮説まで報告)
- 異機体で action space を共有する embodied 基盤モデル
  - **RynnBrain 1.1 (17977)** — 2B→122B の open な MoE family。「1バックボーン + embodiment-specific masking で異機体を跨ぐ」recipe。標準ベースライン/蒸留 teacher 化の公算(hf=136)
- 行動ラベルなしで監督を作る
  - latent action: **WALA (11397)** — action-free 動画から実行可能な latent action を学習。予測ターゲットは raw pixel でなく **DINOv3 特徴 + depth の delta**
  - flow を action 表現に: **FlowWAM (13017)** — optical flow は RGB と同形式なので同一動画生成器で dual-stream 化、policy mode / world-model mode を1モデルで。flow は生動画から自動抽出=action-free 事前学習
  - デモを一切使わない: **TerraZero (13028)** — 実ログは**地図形状のみ**、あとは手続き生成 + self-play RL。左側通行まで創発
  - 生成 pretraining の転移: **GenCeption (09024)** — text-to-video 生成 backbone を feed-forward な知覚モデルに転用し専用 SOTA に 1/7〜1/500 のデータで並ぶ。「world model 的 pretraining は知覚・3D にどれだけ転移するか」の定量的根拠
- world model の表現を行動に近づける
  - **RynnWorld-4D (06559)** — RGB+depth+flow の 4D 予測、denoising を回さず 1-forward で行動
  - 共通教訓: 明示的幾何(点群骨格 / depth+flow / pointmap)の係留が長時間 rollout の安定性と行動接続を改善
- 推論ステップを畳む(diffusion → 一発生成)— planner-evaluation サーベイの DRIFT/VSFM と同一潮流
  - **DriftWorld (15065)** — 学習時に action-conditioned drift を獲得し推論は単一 forward。diffusion 比 **17倍高速・30+fps** で推論時 action search が実用域に
- 長期文脈: **どこでコストを払うか**の両端
  - 推論時に畳む: **RoboTTT (15275)** — TTT の fast weights に履歴を圧縮し 8K timestep、レイテンシ不変。**context 長 = 新しい scaling 軸**(閉ループ性能が単調改善)
  - 学習時に畳む: **LongStraw (14952)** — GRPO の共有 prompt を autograd 外に出し応答ブランチを1本ずつ replay。2M+ token の RL を固定 GPU で実行可能に(※著者自ら「実行可能性であって学習の正しさではない」と留保。精度主張には引用不可)
  - latent memory: **LaMem-VLA (07608)** — short/long dual memory
- world model を「評価器」にする(planner-evaluation サーベイと相互参照)
  - **Point as Skeleton (06516)** — 生成型 closed-loop 評価、nuPlan IF 公開
  - **WM Admissibility (07196)** — L0–L4 認定 ladder。視覚品質上位 ≠ 行動追従性上位の「逆転」を実証
  - **KineBench (19876)** — 評価から **抽出器誤差を追い出す**。生成映像から行動を逆推定する IDM をやめ、汎用視覚 FM で手先 6D pose を直接抽出 → 物理シミュで再実行して closed-loop 検証。IDM が OOD で壊れる **attribution ambiguity** を回避(planner-evaluation サーベイと相互参照)
- 学習パラダイム
  - **Post-Training in E2E AD (08072)** — 模倣後の post-training を教師信号の形式で4分類した初の統一サーベイ。「事前学習(模倣)+post-training」の2段構え設計の根拠
- 実時間化の基準点
  - **Vidu S1 (03118)** — 民生 GPU 540p/42FPS の対話型生成。few-step 蒸留+専用サービングを対で設計

## 重要論文リスト
| 日付 | 論文 | 一言 | brief |
|---|---|---|---|
| 2026-08-08 | Adaptive-WAM (2608.06008) | video diffusion の中間層から軌道を early exit、denoising 反復と VAE decode を推論から除去。NAVSIM 90.8 PDMS / 170ms | [brief](../briefs/2026-08-08/2608.06008v1.md) |
| 2026-08-08 | LAWM-3D (2608.05706) | multi-view だけでは 3D 理解は出ない(negative result)。幾何アンカー + 非単射 RGB-D で appearance leakage を封じる | [brief](../briefs/2026-08-08/2608.05706v1.md) |
| 2026-08-08 | XEWorld (2608.05799) | 未見機体の統制評価で「world model は 2D 視覚パターンマッチャ」と診断、few-shot 適合は忘却を招く | [brief](../briefs/2026-08-08/2608.05799v1.md) |
| 2026-07-25 | HyWorldVLA (2607.20988) | pixel+latent hybrid world-VLA、pre-train で pixel 接地し実運用は latent 専用、NAVSIM v1/v2 超え | [brief](../briefs/2026-07-25/2607.20988v1.md) |
| 2026-07-25 | WorldWeaver (2607.21594) | world state registers + MoT で multi-agent/view の共有状態を保持 | [brief](../briefs/2026-07-25/2607.21594v1.md) |
| 2026-07-25 | MoE VLA (2607.20771) | MoE action head で原始技能が expert に創発分離、router 再学習で few-shot 適合 | [brief](../briefs/2026-07-25/2607.20771v1.md) |
| 2026-07-24 | World Model Remembers, Actor Forgets (2607.19749) | world model は保持し actor だけ忘れる、dream rehearsal で環境対話ゼロ回復 | [brief](../briefs/2026-07-24/2607.19749v1.md) |
| 2026-07-24 | KineBench (2607.19876) | IDM-free kinematic grounding で world model を closed-loop 評価、attribution ambiguity を回避 | [brief](../briefs/2026-07-24/2607.19876v1.md) |
| 2026-07-23 | Masked Visual Actions (2607.19343) | action を pixel 空間の部分開示軌跡で条件付け、rollout ランキングで planning 改善 | [brief](../briefs/2026-07-23/2607.19343.md) |
| 2026-07-23 | ABot-World-0 (2607.19191) | LongForcing + ODE distillation で long-horizon drift を抑える action-conditioned world model | [brief](../briefs/2026-07-23/2607.19191.md) |
| 2026-07-22 | GeoWorldAD (2607.17521) | latent future geometry token で未来 free-space を先読み、過保守を減らし NAVSIM SOTA | [brief](../briefs/2026-07-22/2607.17521.md) |
| 2026-07-22 | RynnBrain 1.1 (2607.17977) | 2B→122B open MoE、cross-embodiment action space + masking で異機体を跨ぐ | [brief](../briefs/2026-07-22/2607.17977.md) |
| 2026-07-19 | LongStraw (2607.14952) | 長 context RL を固定 GPU で実行可能に(※実行可能性のみ、精度主張なし) | [brief](../briefs/2026-07-19/2607.14952.md) |
| 2026-07-18 | RoboTTT (2607.15275) | fast weights で 8K timestep、context 長という新しい scaling 軸 | [brief](../briefs/2026-07-18/2607.15275.md) |
| 2026-07-18 | DriftWorld (2607.15065) | 一発生成の action-conditioned world model、diffusion 比 17倍 | [brief](../briefs/2026-07-18/2607.15065.md) |
| 2026-07-16 | TerraZero (2607.13028) | 実ログは地図のみ・デモ0件の self-play RL で InterPlan 首位 | [brief](../briefs/2026-07-16/2607.13028.md) |
| 2026-07-16 | FlowWAM (2607.13017) | optical flow を統一 action 表現に、policy/world-model の2モード | [brief](../briefs/2026-07-16/2607.13017.md) |
| 2026-07-16 | ABot-N1 (2607.10383) | slow-fast VLN、pixel goal をタスク横断の統一インタフェースに | [brief](../briefs/2026-07-16/2607.10383.md) |
| 2026-07-15 | WALA (2607.11397) | action-free 動画から latent action、DINOv3+depth の delta を予測 | [brief](../briefs/2026-07-15/2607.11397.md) |
| 2026-07-15 | robot-centric pointmaps (2607.11498) | 観測と行動の frame mismatch を ego 座標 pointmap で解消 | [brief](../briefs/2026-07-15/2607.11498.md) |
| 2026-07-14 | GenCeption (2607.09024) | video 生成 backbone を知覚モデルに転用、1/7〜1/500 のデータで SOTA 級 | [brief](../briefs/2026-07-14/2607.09024.md) |
| 2026-07-11 | WCog-VLA (2607.08375) | dual-level world-cognitive VLA、agent token + Game-CoT、PDMS 92.9 | [brief](../briefs/2026-07-11/2607.08375.md) |
| 2026-07-11 | Post-Training in E2E AD (2607.08072) | 模倣後 post-training の統一サーベイ、教師信号で4分類 | [brief](../briefs/2026-07-11/2607.08072.md) |
| 2026-07-11 | Vidu S1 (2607.03118) | 民生 GPU 42FPS・drift なしの実時間対話型生成(実時間化の基準点) | [brief](../briefs/2026-07-11/2607.03118.md) |
| 2026-07-10 | WM Admissibility (2607.07196) | world model を評価器に使う前に L0–L4 で認定せよ、逆転の実証 | [brief](../briefs/2026-07-10/2607.07196.md) |
| 2026-07-10 | LaMem-VLA (2607.07608) | latent 空間ネイティブな dual memory で VLA に長期文脈 | [brief](../briefs/2026-07-10/2607.07608.md) |
| 2026-07-09 | Point as Skeleton (2607.06516) | 点群骨格係留の生成型 closed-loop AD シミュレーション、nuPlan IF | [brief](../briefs/2026-07-09/2607.06516.md) |
| 2026-07-09 | RynnWorld-4D (2607.06559) | RGB+depth+flow 予測で表現を行動に近づける、1-forward policy | [brief](../briefs/2026-07-09/2607.06559.md) |
| 2026-07-08 | UNIVERSE (2607.05133) | 単一 DiT で video+action co-training、推論時脱着で 4.3x 高速 | [brief](../briefs/2026-07-08/2607.05133.md) |
| 2026-07-08 | PixelPilot (2607.04637) | 行動を画像平面で表現しスケールと近道学習を同時に解く、open/closed-loop SOTA | [brief](../briefs/2026-07-08/2607.04637.md) |
| 2026-07-08 | InternVLA-A1.5 (2607.04988) | frozen video 生成モデルから foresight tokens へ latent 蒸留 | [brief](../briefs/2026-07-08/2607.04988.md) |
| 2026-07-04 | Orca (2606.30534) | 単一 world latent で理解・予測・行動を統一(hf199) | [brief](../briefs/2026-07-04/2606.30534.md) |
| 2026-07-04 | VLAFlow (2607.01586) | 言語共学習+future latent alignment で VLA 学習を統制比較 | [brief](../briefs/2026-07-04/2607.01586.md) |
| 2026-07-04 | DriveTeach-VLA (2607.01658) | 知覚蒸留+軌道誘導で空間接地を注入、NAVSIM/nuScenes SOTA | [brief](../briefs/2026-07-04/2607.01658.md) |

## Open Questions
- **生成 pretraining の寄与はどこまで本質か** — Adaptive-WAM (06008) が推論で生成を一切回さないなら、同じ backbone を
  最初から軌道予測だけで学習したものと差が出るのか。差が小さければ「world model は要らず大きい video encoder で足りる」
  ことになり **R3 の前提そのものが変わる**(W32 精読の問い3)
- **「denoising timestep に鈍感」は planner が粗いのか、ベンチが粗いのか** — 合流・遮蔽・カットインのサブセットだけで
  感度が復活しないか。飽和する層の深さがシーン難易度で動くなら adaptive exit の根拠が強まる(06008)
- **我々のモデルも「見た目で汎化」しているか** — 同一シーンで (a) 車体の見た目だけ / (b) 幾何(ホイールベース・カメラ位置)
  だけを変えた条件の予測誤差を比較すれば XEWorld (05799) の診断がそのまま自社に移る。**車種・センサ構成の変更は
  我々にとっての「未見 embodiment」**
- **appearance leakage は運転動画でも起きているか** — 未来フレームを入力から遮断する ablation で性能低下が小さければ
  「見た目を覗いていた」証拠(05706)。非単射 RGB-D 再構成の導入価値がその場で確定する
- **世界状態の default 構成は「latent 中心 + 明示 state register + MoE action head」でいいか** — HyWorldVLA(pixel 接地→latent)
  ・WorldWeaver(register)・MoE VLA(MoE head)を運転で1つに束ねた時、どの組合せが車載レイテンシ/頑健性で残るか
- pixel grounding (20988) が noisy 側でだけ効くのは「頑健性」か「OOD 汎化」か。pixel を切る schedule に最適点はあるか
- continual で actor だけ忘れる (19749) は driving world model + policy でも再現するか。dream rehearsal は
  環境対話ゼロで旧シナリオ保持を回復するか(replay 容量でなく policy 更新経路にリソースを振る根拠になる)
- world model 評価の抽出器誤差 (KineBench 19876) は NAVSIM 系でどれだけ結論を歪めているか(P1 と交差)
- **action-free 事前学習の3方式(latent action 11397 / flow 13017 / 生成 pretraining 09024)は
  運転データで序列が付くか** — 「ラベル付きが少量・生動画が大量」という運転の構造では利得が最も大きい領域
- context 長の scaling (15275) は運転でどこで飽和するか。fast weights 圧縮は occlusion 後の再認識のような
  「まれだが決定的な1フレーム」を保持できるか(KV-cache との A/B が必要)
- 一発生成 (15065) で失う多峰性は、運転の意思決定(追い越すか待つか)でどこまで許容できるか
- pointmap による座標系統一 (11498) は、車種・センサ構成をまたぐ適合(P2)にも効くか —
  未知のカメラ外部パラメータでの zero-shot 汎化が判定基準
- 高レベル出力のインタフェースは pixel goal / BEV 座標 / テキストのどれが運転で最も頑健か(10383)
- 統合方式 (a)–(e) を自社制約(車載レイテンシ・データ量・既存スタック)で序列付けすると
  どれが残るか — R3 の分類マップは材料が揃った。次は比較実験計画への落とし込み
- admissibility(行動追従性)を学習目的に足すと生成品質とのトレードオフはどう出るか(07196 の逆転の裏返し)
- 長期記憶(LaMem 型 dual memory)は Markovian E2E のどの failure mode を実際に減らすか — まず
  memory-demanding シナリオの失敗率定量化から
- 「凍結 world latent + 軽量 action デコーダ」でどこまで行動生成が届くか(Orca / RynnWorld の 1-forward と接続)
- post-training 4分類のうち、保有資産(sim・報酬・選好データ)で最も低コストに始められるのはどれか
- シーンのトークン化(WCog の agent token / LaMem の memory token / SciReasoner 07708 の
  addressable evidence token)は決定根拠のトレーサビリティに使えるか(P1 と交差)

## 自分の実験・メモ
(本人が自由に書く欄。週次レビューは消さない)
