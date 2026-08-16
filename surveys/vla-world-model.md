# VLA / World Model / E2E Driving — Living Survey
最終更新: 2026-08-16

## 一言でいうと
言語・視覚・行動を1つのモデルで扱う **VLA (Vision-Language-Action)** と、世界の遷移を予測する **world model** を
end-to-end 自動運転にどう接続するかを追う分野。論点は「どう繋ぐか」→「世界状態をどう保持するか」→
「そもそも未来を*描く*必要があるのか」と降り、**2026-W33 でさらに手前に戻った** ——
**「出来上がった world model の良し悪しを、何で測るのか」**。答えは厳しい: **表現の綺麗さは planning を説明せず**、
**もっともらしい未来は反実仮想ではなく**、**予測精度と planning 成功は逆順に並ぶ**。
一方で統合アーキテクチャの側は今週で**分類マップの軸が3本とも決まった** ——
**(1) どの高さで融合するか (token / feature / action 空間)、(2) その潜在空間は planner のコストとして使えるか
(reachability か単なる近さか)、(3) その world model は反実仮想として使えるのか前向きの生成だけか。**
そして空き地の位置も見えた: **reasoning・action・prediction の3者を1本の stream に統合した構成は、現時点で見当たらない。**

## 系譜マップ
- **★ R3 分類マップの3軸(2026-W33 で確定)— 論文を読むだけで3列とも埋まる**
  - **軸1: どの高さで融合するか (token / feature / action 空間)** —— **両端が2日で揃った**
    - **token/feature で混ぜる側は失敗すると名指しされた: BrainWAM (12854)** — 運転の planning は
      **意味の制約**(「あれはスクールバスだから停まる」)と **予測ダイナミクス**(「3秒進むと周囲はどう動くか」)を同時に要求する。
      両者のトークンを1つの attention に流し込むと、**意味側は「見ればすぐ答えが出る」ショートカットを提供するので
      共有 attention 空間を占拠し、予測ダイナミクス側の寄与が抑え込まれる**(attention-allocation mismatch)。**足したのに片方しか働いていない。**
      解は**融合する高さを上げること** —— **2本の経路がそれぞれ独立に「で、どう動くべきか」まで書き切ってから、
      コンパクトな行動表現のレベルで揃える**。NAVSIM **v1 89.5 / v2 89.6**、VLA のみ・WAM のみの両方を一貫して上回る。
      実装の持ち帰りがもう1つ: **重い映像側の生成と軽い行動側を非同期に回して推論遅延を短縮**(車載ならここだけ移植する手もある)
    - **反対端「分けるな」: G0.5 (11739)** — 現在の標準構成「事前学習済み VLM + 別学習の action expert」では
      **VLM が文脈を埋め込むだけの装置に格下げされ、実際に「どう動くか」を決めているのは別学習の小さな expert**になる。
      だから **VLM が持っていたはずの指示追従能力や未知シーンへの対処が身体の振る舞いに乗ってこない**。
      解は **1つの transformer decoder が推論トークンと行動トークンを同じ目的関数のもとで吐くこと**
      (機種横断の **cross-embodiment action tokenizer** / 行動 token と交互に織り込む CoT / vision encoder 経由の visual memory)。
      **重み共有の効果がいちばん面白い部分: 追加学習なしにプロンプトを書き換えるだけで動作の粒度・タスクの長さ・未知シーンでの振る舞いが変わる**
      (「性能が上がった」とは質の違う主張)。実機 fine-tuning **76.7% 対 π0.5 の 53.3%**、BEHAVIOR Challenge 2025 で **31.4%**(優勝者 26.1% 超)。
      **読み方の注意: LIBERO 98.9% は飽和域、BEHAVIOR 31.4% は勝ってはいるが解けていない。
      そして abstract からはモデルサイズも学習コストも読めない —— 「統合したから強い」のか「単に大きいから強い」のかは ablation を見ないと切り分けられない**
  - **軸2: その潜在空間は planner のコストとして使えるか(reachability か、単なる近さか)** ——
    **12959** が「潜在二乗距離は proximity であって reachability ではない」を示した(詳細は planner-evaluation サーベイ)。
    **処方側は AirForesight (12835) の cross-space planning consistency loss**(中間表現から復号した軌道を専門家の行動方向と揃える)。
    **12959 が診断・12835 が処方という対で、consistency loss を入れた前後で潜在コストの単調性を測れば、
    どちらの論文単体でも出せない結果が出る。ここに新規性の芽がある**
  - **軸3: その world model は反実仮想として使えるのか、前向きの生成だけか** —— **11601**(abduction 段の欠落)。
    **ほとんどの論文が答えを書いていないはずなので、埋めた時点で情報になる列**
  - **★ 空き地**: **G0.5 は未来の観測を予測しない**(推論と行動の統合であって、予測の統合ではない)。
    **4D-WAM (10107) は world model と planning の統合。両者を並べると、reasoning・action・prediction の3者を
    1本の stream に統合した構成は現時点で見当たらない。R3 が主張しうるのはそこである**
  - **常に疑うべき交絡**(落選 12078 由来): **未知の分布シフト下での頑健性は、object-centric という構造ではなく
    凍結した事前学習特徴の方が主因かもしれない**(DINO-WM が同等に強い)。
    **「構造の工夫だと思っていたものが、実は事前学習特徴の効果だった」**は R3 のマップを作るとき常に疑う
- **★ world model の良し悪しを何で測るか(2026-W33 の芯)— 5本が独立に同じ場所を指した**
  - **VIScore (11174)** — 表現の綺麗さは planning を説明しない(**probing は我々が真っ先に使う手口**)。
    測る場所を **encoder → predictor → planner の3段**に広げる(planner-evaluation サーベイに詳述)
  - **12959** — **予測精度と planning 成功は逆順に並ぶ。予測損失で checkpoint を選ぶと最も下手なものを選ぶ**
  - **11601** — **もっともらしい未来は反実仮想ではない**(abduction の欠落)
  - **境界条件(落選 12078)** — object-centric world model では **planning 成功は slot の品質指標と正に相関する。
    ただし高品質域で飽和する。** VIScore と力点が逆だが矛盾はせず、**「表現指標は低品質域では効く」**という範囲の話に落ちる。
    **この2本を突き合わせて「表現指標はどの範囲で有効か」を決めるのが R3 の本命作業**
  - **報告の作法(LDR 09926 由来)** — **分布内の誤差ではなく、分布内と分布外の「差」で報告する。
    分布内の誤差だけを競わせると、暗記したモデルが勝つ**
- **latent の遷移をどれだけハードコードするか(2026-W33 新設の軸)**
  - **LDR (09926)** — 未来の latent を丸ごとネットワークに予測させるのをやめ、**位置は速度の積分・速度は加速度の積分という
    運動学の積み上げを決め打ちで書き、ネットワークには3次以上の残差だけを出させる**。学習させる量が小さくなるほど
    **外挿は「関数の外挿」ではなく「積分の続行」になる**。分布内/外の誤差ギャップが baseline の **1/20**、
    **パラメータ 1/26・143倍速**(構造から出た副産物)。**赤い球が左から右に動く映像だけで学習して、青い四角が右から左に動く運動を当てる**
    = モデルが持っているのが見た目の記憶ではなく**運動の規則**であることの直接の証拠。
    **検証は完全に白箱の合成物理ベンチに閉じている**(5タスク、クリーンな剛体運動、実写ゼロ)ので「初の外挿する world model」は
    **この設定の中での話**として読む。**ただし前提は自動運転では最初から成立している** —— 位置・速度・加速度が意味を持つ観測可能な物理量として存在する。
    落選した **ELWM (09876)** が独立に「latent に energy と momentum を持たせろ」と同日に主張しており、方向として無視できない信号
- **思考を言語化するか(2026-W33 新設の軸)**
  - **FactorDrive (09591)**(言語化する側)— 場面ごとの **PCF (planning-critical factor: 計画を左右する要因)** で推論を編成し、
    **軌道の良さを報酬に推論経路そのものを最適化**(MCTS でガイドした GRPO)。nuScenes / NAVSIM で SOTA。
    **PCF は「シナリオを見た目ではなく要求される判断で分類し直す」ための語彙候補としても使える**(P1 と交差)
  - **BDH-CQ (09888、hf 207)**(言語化しない側)— 思考を言語化せず **latent の反復計算**で解き、
    **150M で ARC-AGI の cost-accuracy Pareto を突破**(1タスク $0.0007)。**FactorDrive の正反対の設計**。
    **リアルタイム制約下では CoT の token 生成コストが直接レイテンシになるので、
    「出力を伸ばさずに計算だけ深くする」は運転ドメインでこそ筋が良い**
- **失敗を捨てずに資産にする(2026-W33 で2本が独立に出た)**
  - **DriveVLA-M0**(落選・惜しい)— 失敗事例を latent memory に貯め、**静的な道路構造と動的な agent 相互作用を分離した retrieval** で
    引き当て、推論時に LoRA で注入。**memory を増やすだけで学習なしに伸びる**という主張。コード公開
  - **FACT**(落選)— **実行した action で条件付けて未来を予測**することで、**失敗 rollout を捨てずに教師信号として使える**。
    **失敗データを入れるほど良くなる**。「同じ失敗を繰り返す」は我々の実運用でも最も痛い形の弱点で、2本同時 = 定着しつつある
- **未来を「描く」必要はあるのか(2026-W32 の芯、W33 で3例目が出た)— 診断 → 処方 → 運用**
  - **SimWAM (07468)** — **「予測できるように学習させる。ただし決めるときには予測を見ない」**。映像生成の枝と軌道予測の枝を
    一緒に学習させ、**学習が終わったら映像側を丸ごと捨てて軌道を直接吐く planner だけを残す**。
    NAVSIM **91.5 PDMS**・低レイテンシ・nuScenes へ zero-shot、**コード/重み公開**。
    **読む価値の本体は「捨てても壊れない」を根性ではなく構造で保証している点** ——
    単に補助タスクを足しただけなら軌道側は未来映像の情報に頼るように育ってしまうが、
    **本論文は isolated attention mask で参照関係そのものを禁止し、依存すること自体を不可能にしている**。
    **これは「学習時にはあるが本番には無い情報」を使い切る一般的な道具**で、我々なら**他車の未来軌道の正解や
    後知恵で計算した最適軌道**がそれに当たる。**未来映像である必然性はどこにもない。**
    読むとき最初に探すべき表: **「映像側を一切使わずに軌道側だけ学習した場合」との差**(小さければ主張は成立しない)。
    落選した **World Tokens** が独立に同じ設計に到達しており、**1日おいて別グループが同じ設計に着地するのは定着の印**
  - **teacher から渡すのは、teacher の出力そのものではなく teacher が満たしている性質にせよ: 4D-WAM (10107)** —
    WAM の学習データは**立体的な世界を平面に投影した動画**しかないので、空間の構造を理解しないまま学習され、
    **見た目はもっともらしいのに辻褄が合っていない未来**(奥行きが揺れる・他車の大きさが物理的にありえない変化)を作り、
    **下流の planning がそれを真に受ける**。処方が上手いのは幾何を**アーキテクチャではなく loss として**入れたところ ——
    3D 幾何を推定する事前学習済みモデルを**学習時だけ**呼び、生成された未来フレームを食わせて返答の時間的整合性を loss にする。
    **デプロイされるのは元の WAM のままで推論コストの増加はゼロ、4D の正解データも要らない**(幾何モデルが疑似ラベル器として働く)。
    もう1つ独立に価値のある発見: **運転の決定(曲がるか止まるか)は生成の早い粗い段階でほぼ確定しているので、
    細部を綺麗にする後半に監督を厚くしても planning は良くならない** —— 同じ loss を効く区間に配り直すだけで追加コストなし。
    **一般形として読むのが一番得: 交通ルールの検証器・他車の挙動予測器・地図の整合性チェッカ、どれも同じ形で
    「生成された未来を採点させて loss にする」ことができる。** 留保: NAVSIM は他車が反応しない設定であり、**学習は確実に重くなる**
  - **診断 → 処方 → 運用が3本で閉じた(2026-W32)**
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
| 2026-08-15 | BrainWAM (2608.12854) | 意味と予測を token で混ぜると意味が attention を独占。行動の高さで揃えろ。NAVSIM v1 89.5 / v2 89.6 | [brief](../briefs/2026-08-15/2608.12854.md) |
| 2026-08-15 | The Objective Is the Bottleneck (2608.12959) | 予測精度と planning 成功が逆順。潜在二乗距離は reachability を表さない。コスト差し替えで 26%→98% | [brief](../briefs/2026-08-15/2608.12959.md) |
| 2026-08-14 | G0.5 (2608.11739) | 行動を別モジュールに出すと VLM が意思決定者でなくなる。推論と行動を1本の stream に統合 | [brief](../briefs/2026-08-14/2608.11739.md) |
| 2026-08-14 | 反実仮想 driving world model (2608.11601) | action 差し替えの予測は abduction を欠く。正解付き検証環境を構築、処方は学習ゼロ・凍結 | [brief](../briefs/2026-08-14/2608.11601.md) |
| 2026-08-13 | 4D-WAM (2608.10107) | 幾何 FM を学習時の採点者としてだけ使い推論コスト増ゼロ。決定が形成される早期区間に監督を寄せる | [brief](../briefs/2026-08-13/2608.10107.md) |
| 2026-08-13 | VIScore (2608.11174) | latent の綺麗さは planning を説明しない。encoder/predictor/planner の3段で測り校正誤差まで出す | [brief](../briefs/2026-08-13/2608.11174.md) |
| 2026-08-12 | LDR (2608.09926) | latent 遷移を運動学の積分として書き3次以上の残差だけ学習。分布内外ギャップ 1/20、143倍速 | [brief](../briefs/2026-08-12/2608.09926.md) |
| 2026-08-12 | FactorDrive (2608.09591) | PCF で推論を編成し、軌道の良さを報酬に推論経路そのものを最適化(MCTS ガイドの GRPO) | [brief](../briefs/2026-08-12/2608.09591.md) |
| 2026-08-12 | BDH-CQ (2608.09888) | 思考を言語化せず latent 反復で解く。150M で ARC-AGI のコスト効率 SOTA。FactorDrive の正反対 | [brief](../briefs/2026-08-12/2608.09888.md) |
| 2026-08-11 | SimWAM (2608.07468) | 映像生成は学習時の信号としてのみ使い、isolated attention mask で依存を構造的に禁止して推論時に破棄 | [brief](../briefs/2026-08-11/2608.07468.md) |
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
- **★ R3 の分類マップを 3列で埋める(論文を読むだけで完成する。新しい候補を待つ必要がない作業)**:
  (1) **どの高さで融合するか** (token / feature / action)、(2) **その潜在空間は planner のコストとして使えるか**
  (reachability か単なる近さか)、(3) **その world model は反実仮想として使えるのか前向きの生成だけか**。
  **軸1は両端(G0.5 / BrainWAM)が揃っているので、単なる整理ではなく「どちらが勝っているか」という主張を持てる**
- **★ reasoning・action・prediction の3者を1本の stream に統合した構成は本当に存在しないか** —— **R3 が主張しうる空き地**
- **G0.5 の利得は「統合」由来か「規模」由来か**(11739)— **ablation だけ先に読めば 30分で切り分けられる。
  規模由来なら我々のスケールに持ち帰れるものは無い**
- **attention-allocation mismatch は手元で再現できるか**(12854)— 意味経路と予測経路の attention 配分を測る。
  再現するなら融合の高さを上げる価値が確定する
- **表現指標はどの範囲で有効か**(11174 と落選 12078 の突き合わせ)— **低品質域では効き、高品質域で飽和する**なら、
  「表現指標を使ってよい領域」を数字で切れる。**これが R3 の本命作業**
- **trajectory prediction の出力を「速度・加速度の積分 + 残差」に書き換えると、分布外はどうなるか**(09926)—
  モデルもデータも変えず出力パラメータ化だけ。**評価は分布内誤差ではなく、通常速度域で学習して高速域・急減速域を held-out にしたギャップ。
  改善するのはギャップであって分布内誤差ではない、と最初から決めて測りにいくこと**
- **SimWAM の isolated attention mask を、我々の特権情報に転用できるか**(07468)—
  **他車の未来軌道の正解 / 後知恵で計算した最適軌道**を学習時だけ使い、推論時に構造的に依存できなくする。
  **未来映像である必然性はどこにもない**。先に公開重みでレイテンシを自前環境で実測して投資判断する
- **early-decision は我々の生成モデルでも起きているか**(10107)— **生成を途中で打ち切って軌道を読み出し、
  最終出力との一致率を timestep の関数でプロットするだけ**(推論のみ)。早期に飽和すれば監督の配り方を変える価値がある
- **「生成された未来を外部モデルに採点させて loss にする」を、幾何以外で試せるか**(10107 の一般形)—
  交通ルールの検証器 / 他車の挙動予測器 / 地図の整合性チェッカ
- **CoT を出さずに latent の反復で深くする設計は、運転のレイテンシ予算で有利か**(09888 対 09591)—
  **リアルタイム制約下では CoT の token 生成コストが直接レイテンシになる**
- **失敗を資産にする2型(retrieval で引く / action 条件付けで教師信号にする)は運転で序列が付くか**(落選 DriveVLA-M0 と FACT)
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
