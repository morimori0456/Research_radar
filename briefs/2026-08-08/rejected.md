# 落選候補 — 2026-08-08

候補 55 件中、採用 6 件(P1×2・P2×1・P3×2・wildcard×1、**max_deep_per_day=6 到達**)。以下 49 件は落選。
🔶 = 惜しい次点(枠が空けば拾う価値あり)。

**枠配分メモ:** P1 と P3 は quota 2 を充足。**P2 は quota 2 に対し 1 件のみの under-fill**。理由は、fm_distill_finetune タグ 30 件のうち高スコア帯が LAWM-3D 以外なく、残りは化学・代謝・病理・超スペクトル・感情認識・音楽/映像生成など**ドメイン特化の応用**に偏り、P2 の核(蒸留 recipe / capacity gap / PEFT / 他ドメイン適合)から遠かったため。3.5 点帯(AgentOPSD / BioKD / RENDEQ / B300 field report)は横並びで、**採用しても TOP3 に絡まない**と判断し、次点として明示的に渋滞させる。

---

## P1 planner_ai(候補 3・採用 2 = INTraJ / Failing Gracefully)

- 2608.05830: **Coordinated Multi-Robot Disassembly (CoMuDi)** — 複数ロボットの分解作業の makespan(全工程完了時間)最小化。ST-RRT*(時空間 RRT*)と時間制約伝播の組み合わせは手堅いが、**狭所での多腕協調スケジューリング**であり、自動運転 planner の評価・軌道生成とは問題構造が違う。転用できるのは「時間制約を伝播して各タスクの最早開始/終了を決める」定式化程度で、深掘りの費用対効果が薄い。**2.0点。**

## P2 fm_distill_finetune(候補 30・採用 1 = LAWM-3D)

### 惜しい次点(3.0–3.5 点帯・枠が空けば即拾う)
- 🔶 2608.05987: **AgentOPSD**(hf **63**、本日の arXiv 側 最高 upvote) — agentic RL の turn-level credit assignment(長い対話のどの手番が結果を決めたかを割り当てる問題)を、**teacher と student の token 単位 log-probability 差**を turn 単位に集約し、**log-odds 空間で Bayesian belief を再帰更新**して解く。critic も追加 rollout も不要で GRPO(Group Relative Policy Optimization; PPO を簡略化した LLM 向け RL 手法)を上回る。**privileged self-distillation を密な報酬信号の作り方として使う**発想は P2 に効くが、評価が ALFWorld/WebShop/Search-QA と我々の設定から遠い。**upvote は高いが relevance を上書きしない**方針どおり次点。**3.5点。**
- 🔶 2608.05670: **RENDEQ / When Does Consensus Mean Correctness?** — 「入力を摂動しても答えが一致する = 正しい」という前提を、**科学図表をプログラムから再描画して意味が厳密に同一な入力集合を作る**ことで初めて直接測定。強い負の結果として、**自分の cross-render 合意で fine-tuning すると 5 回中 5 回とも精度が下がる**(自然画像での既報と逆符号)。self-training / pseudo-label 系レシピの落とし穴として価値が高く、P1 の「ラベルなし信頼度シグナル」にも刺さる。**3.5点、次点筆頭。**
- 🔶 2608.06023: **BioKD** — 生理信号を privileged information(学習時のみ使える追加情報)として動画 student に蒸留。**サンプル単位の reliability gate(教師の信頼度で蒸留の強さを調整する門)+ 段階的蒸留**で negative transfer(質の悪い教師が student を悪化させる現象)を抑える。**「教師を信じる度合いをサンプルごとに変える」**は我々の蒸留パイプに直接足せるレバー。ドメインが感情認識で今回は見送り。**3.5点。**
- 🔶 2608.05944: **Operating Multi-Node Full Fine-Tuning on NVIDIA B300**(field report) — Qwen3-32B を 16×B300 で FSDP/ZeRO-3 フル fine-tuning した運用記録。**GPU 使用率は NCCL ハング中も 100% を示すので、消費電力(W)で compute / 通信 / データ枯渇 / チェックポイント or デッドロック / アイドルを切り分けろ**という triage 表、**「NFS 直読みと事前トークナイズ済みローカルキャッシュが同速(~53k tok/s)」という誠実な負の結果**、epoch 末の token packing 不均衡由来 NCCL デッドロックと 2.7 秒の事前検査ゲート。アルゴリズムの新規性はゼロだが**実務価値は今日いちばん即物的**。**3.0点。**
- 🔶 2608.05769: **FoRM (Flow-Map Distillation on Relation Manifolds)** — 蒸留を「教師と生徒の関係行列を静的な目標に合わせる」のでなく、**関係多様体上の連続的な flow map(任意の時刻 s の状態を直接予測する作用素)を学ぶ**問題に定式化。semigroup 整合制約で誤差蓄積を防ぎ、**学習分散を約 50% 削減**。**新しい distillation loss** という P2 の高優先条件に合致するが、評価が画像復元 5 タスクに閉じており大規模 FM への一般化は未証明。**3.0点。**
- 🔶 2608.05798: **KVAE tokenizer family** — 音声/画像/動画の tokenizer 群を公開。**設計選択の ablation と model selection 手法まで共有**しており、world model の latent 空間を自前で設計するなら参照価値が高い(video は 4×16×16 / 4×8×8 圧縮、causal)。ただし tokenizer 単体は我々の当面のボトルネックではない。**3.0点。**
- 🔶 2608.05631: **ChronoVision**(hf 24) — 言語ベース推論の曖昧さを避け、**最終変換後の状態の latent 表現を予測する Reconstructive Visual Head** + RL の implicit process grounding。**「言語ではなく latent で過程を持つ」**は world model 側と発想を共有。IntPhys2 で 55.0%。今回は同テーマをより直接扱う LAWM-3D / XEWorld を優先。**3.0点。**

### 圏外(応用ドメイン特化・P2 の核から遠い)
- 2608.06259: RxnCLF — 化学反応の foundation model(縮約反応グラフ + 対照学習、Pistachio 170万反応)。収率予測の SOTA だが、転用できるのは「入出力を1グラフに統合して差分を表現に載せる」着想のみ。**1.5点。**
- 2608.06253: MetaboLLM — 代謝物特化 LLM + GIN でグラフ構築。continual pretraining → SFT → retrieval の三段構成は定石どおりで新規性が薄い。**1.5点。**
- 2608.06246: 6次元 taxonomy of post-training adaptation — fine-tuning / RAG / prompting / unlearning 等を mechanism・goal・data 要件・永続性・構造スコープ・モデル型で整理したサーベイ。**用語整理としては有用**だが AI governance 寄りで、実験を動かす示唆に乏しい。**2.5点。**
- 2608.06205: CFGPNet — RGB-T(可視+赤外)マルチスペクトル物体検出。FLIR/M3FD/LLVIP で強い数字、コード公開。センサ融合の実装参考にはなるが、**蒸留でも適合でもない**。**2.0点。**
- 2608.06137: SkillTFM — 表形式 foundation model を**パラメータ更新なしで「スキルバンクの進化」により適合**させる training-free 手法。「適合をパラメータでなく再利用可能スキルで持つ」着想は面白いが表形式データ限定。**2.0点。**
- 2608.06069: SteerWrite — 勾配更新なしの token-level steering による個人化執筆支援。小データ向け設計は参考になるがタスクが遠い。**2.0点。**
- 2608.06046: ML-for-ML — ネットワーク側と ML 側のノブを time-to-target-loss で共同最適化(最大 42% 高速化)。**prototype 段階の position paper** で再現できる recipe がない。**1.5点。**
- 2608.06025: AutoThread — シミュレータ律速な RL 推論のスレッド数を PINO(物理情報付きニューラル作用素)+ M/M/1 待ち行列で予測し動的調整。**closed-loop シミュレーションのスループット**という我々の実問題には触れるが、systems 論文としての深掘り価値は当面低い。**2.0点。**
- 2608.05993: 合成臨床コミュニケーションのサーベイ + 13 ケーススタディ。「train-on-synthetic, test-on-authentic の検証がほぼ無い」という自己批判は誠実だが、医療 NLP に閉じる。**1.5点。**
- 2608.05983: UCD — SAM3 に対する universal cross-concept 敵対的攻撃。堅牢性の知見としては重要だが、我々の攻撃面ではない。**1.5点。**
- 2608.05976: Diff-VF — 短尺学習の video diffusion を**学習なしで長尺化**(混合ノイズ初期化 + 重み付き窓サンプリング + 時間拡張サンプリング)。**long-horizon rollout の一貫性**という P3 の関心と重なるが、生成品質の話であり行動条件付けがない。**2.5点。**
- 2608.05964: 超スペクトル画像の source-free domain adaptation(ソースデータにアクセスできない適合)。エントロピー momentum 擬似ラベル + 近傍トポロジ整合。**source-free という設定自体は P2 的に重要**だが、リモートセンシング特化で recipe の一般性が読み切れない。**2.0点。**
- 2608.05928: BioM-JEPA — 単一細胞で **JEPA (Joint-Embedding Predictive Architecture; 生の入力ではなく埋め込み空間で未来/欠損を予測する自己教師あり構造)**。**「個別トークンでなくグラフで繋がったブロック単位を予測対象にする」**という予測単位の設計は world model にも移せる着想だが、生物ドメインの評価しかない。**2.5点。**
- 2608.05840: 監視カメラからの車両位置推定(YOLO26 検出 + ResNet34 で接地4隅を回帰)。**CARLA 合成データで学習 → DAIR-V2X 実データで fine-tuning** という sim-to-real の型は我々の関心と重なり、中距離車両の地上誤差 5.52m→0.90m は実用的。ただしインフラ側センサの話で自車 planner から遠い。**2.5点。**
- 2608.05832: TSR + LHRL-VGR — 社会的対話を戦略計画と言語実行に階層分解し、目標達成分散で報酬をルーティング。**2.0点。**
- 2608.05783: GROM — **勾配なし・1ショットの machine unlearning**。リッジ正則化最小二乗の閉形式解で重みを直接編集し、数秒で完了。**量子化で記憶が復活する攻撃に耐える**(勾配ベース手法は復活する)点が鋭い。unlearning は現状の優先事項ではない。**2.5点。**
- 2608.05757: BEACON — WSI(病理全体スライド)推論を**期待情報利得(EIG)最大化による証拠獲得**として定式化。「意味的関連性 ≠ 診断的有益性」という切り分けは、**評価シナリオの能動選択**に転用しうる着想。ドメインが遠い。**2.5点。**
- 2608.05739: LiteKD-Net — depthwise separable conv の軽量 student へ特徴レベル蒸留、モバイル画像デノイズ。手法は標準的で新規性が薄い。**2.0点。**
- 2608.05705: SAP — わざとアンダーサンプリングして折り返したスペクトルを元に戻させる自己教師あり pretext task(回転機械の故障診断)。**「linear probing が full fine-tuning より安定して良い」**という報告は少ラベル適合の知見として面白いが、CWRU 単一データセット。**2.0点。**
- 2608.05691: SciQNet — 科学画像の品質評価、ドメイン適応事前学習 → タスク特化 fine-tuning の二段。**「事前学習データは量より関連性(40% の層化抽出が最良)」**という所見だけは持ち帰る価値あり。ICME チャレンジ 2 位。**2.0点。**
- 2608.05664: S2M-Sense — 物理ガイド付きシミュレータで向き多様な mmWave データを合成し、**わずか 16 サンプルの未ラベル実データ**で敵対的転移。sim-to-real の少サンプル適合の型としては綺麗だが無線センシング特化。**2.0点。**
- 2608.06142: 絵画・写真の構図分析の表現学習。「凍結エンコーダなら人間発想の手法が競合、fine-tuning できるなら大規模自己教師ありが勝つが解釈性と領域外汎化を失う」という**トレードオフの明示**だけが持ち帰り。**1.5点。**

## P3 next_arch(候補 19・採用 2 = Adaptive-WAM / XEWorld)

### 惜しい次点(3.5–4.0 点帯・今日は枠負け)
- 🔶 2608.05720: **PhyLatent** — JEPA world model 用の dynamics-relevant 学習目的。**「潜在表現の大域的な崩壊(collapse; 全入力が同じベクトルに潰れる現象)を防いだだけでは、物理状態と行動の帰結が保存される保証はない」**という指摘が鋭く、**physical invariance collapse / physical identifiability collapse / counterfactual dynamics collapse** の3つの失敗モードを新たに定義。OGBench-Cube で失敗率を 15.60/6.71/8.41% → 7.53/0.95/4.62% に下げ、MPC(model predictive control; 予測して短期最適化する制御)成功率 70.0→78.1%、TwoRooms 81.0→98.0%。**XEWorld と同じ「見た目だけ合っている world model」問題への別解**で、採用した2本と主張が重複するため次点。**4.0点、次点筆頭。**
- 🔶 2608.05948: **GAUGE** — 物理エンジン(Isaac Sim / Genesis / Newton)と生成 video world model を**同じ土俵で物理忠実度を診断**する実測ベンチ。22 タスク族、剛体・ケーブル・布・変形体、実軌跡と較正済み物理メタデータに接地。**「どの物理法則がどう破れたか」を特定できる**のが既存の知覚的類似度評価との決定的な差。所見も強い:**一様に忠実なエンジンは存在せず**、video world model は**方程式の形は合っているのに加速度・運動量移動・振動タイミングが間違う**。評価手法の新提案として高優先だが、剛体/布/変形体中心で運転シーンから距離があり次点。**4.0点。**
- 🔶 2608.06332: **GeniWorld** — URDF ベースのレンダリングで**数値行動を「視覚的な行動表現」に変換**し空間的に接地。**embodiment の運動学と環境ダイナミクスを明示的に分離**してシーン過学習を抑える。**scalable な policy evaluator** として使える点は P1 直撃。XEWorld が「zero-shot には pixel-space action が必須」と診断した処方をまさに実装しており、**XEWorld とセットで読むべき次点**。固定シーンの限定データ学習でも未見環境へ zero-shot 汎化。**4.0点。**
- 🔶 2608.06374: **DyPES-VLA**(hf 15) — cross-embodiment VLA。**VLM を未来予測目的で学習して共有 dynamics prior を獲得** + **embodiment ごとの MoE (Mixture-of-Experts; 入力に応じて一部の専門家サブネットのみ使う構造) action head が各機体固有の行動空間へ直接出力**(異種行動を共通形式に手で揃える前処理が不要)。LIBERO 98.0%。「**他機種への適合**」という P2 の関心にも合致し評価も強いが、マニピュレーション特化。**4.0点。**
- 🔶 2608.06375: **ω-0** — ヒューマノイドの移動と操作を同時に行う whole-body world-action model。**未来動画を再構成せず、コンパクトな未来観測埋め込みだけを軽量な予測目的として学ぶ**(Adaptive-WAM の「描かなくていい」と同じ思想)。40時間超の実世界データセット ω-HOME 付き。**3.5点。**
- 🔶 2608.05597: **UA-NWM** — UAV の画像目標ナビゲーション。**軌道スコアリングを条件付き OOD 検出(学習分布から外れているかの判定)として定式化**し、予測と目標の差分を**不確実性で説明できる成分 / できない残差**に分解、**残差だけでスコアリング**することで複数の未来サンプリングを不要にする。**「複数 rollout せずに不確実性を扱う」**は推論予算が厳しい我々に効く着想で、Adaptive-WAM の quality scorer とも補完的。ドメインが空撮ナビ。**3.5点。**
- 🔶 2608.05738: **In-Context VLA** — **自由形式の textual CoT (Chain-of-Thought; 途中の推論を言語で書き出す手法) はむしろ低次制御を悪化させる**と実証・分析。理由は (a) 推論が接地されていない、(b) 生成の遅延が閉ループのタイミングを壊す、(c) 推論トークンと行動トークンの目的関数が競合し**方策が「行動する」代わりに「実況する」ことを学ぶ**。処方は「VLA に必要なのは言語を**生成**する力ではなく**消費**する力」で、構造化文脈として証拠を注入し行動のみを教師信号にする。**VLA に CoT を足す前に読むべき**負の結果。**3.5点。**
- 🔶 2608.05674: **JoyAI-RA 0.5** — VLWA(Vision-Language-World-Action)。**暗黙の行動整合**(視覚遷移から潜在行動を推定し、行動ラベルなしの人間/シミュ/実機データを world model 学習に使う)+ **明示の行動整合**(カメラ座標系・チャンク相対の end-effector 行動という正準表現で接地)。**人間動画の量を増やすほどスコアが伸び、最大規模でも頭打ちの兆候なし**というスケーリング所見が重要。LAWM-3D と主題が重複するため次点。**3.5点。**

### 圏外
- 2608.06257: MASS — マルチプレイヤー world model。**世界状態と視点依存の視覚 latent を分離**し、学習された Logic Engine が唯一の再帰記憶として権威ある型付き状態を進め、Rendering Engine が任意カメラの映像を生成。1,024 プレイヤー・10,000 ステップ。**思想は良いが 2026-07-25 にブリーフ済みの WorldWeaver(world state registers + MoT)と実質同型**で、評価が Snake ベンチと玩具的。**3.0点。**
- 2608.05999: HiRoC — VLA の階層的 post-training(高レベル計画と低レベル実行を分離し、executor を RL で改善、事前に planner の subgoal と整合させて分布ずれを緩和)。手堅いが構成要素はすべて既知。**3.0点。**
- 2608.05523: HERA — **凍結した latent predictor に、遮蔽で見えなくなった過去の証拠を後から差し込む adapter**(構造化メモリバンク + メモリ/ワークスペースレジスタ)。**基盤 world model を触らず適合させる**形は実務的だが、V-JEPA 2-G の IntPhys2 精度が 52.57→54.35% と**効果が小さく偶然との区別が苦しい**。**3.0点。**
- 2608.05970: SkillMemo — 長尺デモを潜在的な原始スキルに暗黙分解(MoE のゲート係数で表現)し、スキル単位のエピソード記憶バンクから検索して行動予測を補正。π0.5 超え。着想は面白いが**2026-07-25 の MoE VLA(原始技能の創発分離)と主題が近い**。**2.5点。**
- 2608.05369: W2-VLA(hf 14) — メイン視点と手首視点の役割の違いに着目し、**タスク文脈で条件づけて未来の手首 latent を予測**。80Hz 超。細かい接触操作の話で運転に移らない。**2.5点。**
- 2608.05891: AppDeltaWorld — GUI world model。**次画面を画像でもテキストでもなく「到達可能なコード差分(実行可能 HTML)」として予測する**という表現の選び方が独創的。ドメインがモバイル GUI。**2.5点。**
- 2608.05695: DreamGuard — LLM agent の実行前ガードレールを **risk-aware world model** で proactive 化。**「個々には無害な行動が徐々に危険な状態へドリフトする」long-horizon リスク**を、コンパクトな再帰 latent で未来を予測して捉える。25ms。**「安全性を軌道全体のリスク推移として見る」**発想は P1 と響き合うが、対象が LLM ツール呼び出し。**2.5点。**
- 2608.06020: 経済 world model (EWM) の実装ロードマップ(hf 24)。6段階の能力ラダーとサーベイ。**upvote は高いが我々の技術的関心と交わらない**——hf_upvotes を relevance に昇格させない方針の典型例。**1.5点。**
- 2608.05371: QSWM — 量子論着想(複素値表現・密度行列的 latent)の world model。**評価が初等セルオートマトンのみ**で、著者自身も長期 rollout の限界を認めている。**1.0点。**

## sns_wildcard(候補 3・採用 1 = RST)

- 🔶 2608.03974: **JoyAI-Video-Edit**(hf **84**) — 16B の autoregressive diffusion で**リアルタイム(B200 1枚で 720p ≈30FPS)のオープンエンド動画編集**。**SA-DMD (Source-Anchored Distribution Matching Distillation; 元動画への忠実性を保ったまま少ステップ生成へ蒸留する手法)** と **Long-Horizon Autoregressive Distillation** で、学習と推論の乖離・**時間方向のドリフト蓄積**を抑える。**「自己回帰的な長尺生成のドリフトを蒸留で抑える」は driving world model の rollout に直撃**し、P2×P3 の交差点として実は今日いちばん実用的かもしれない。**wildcard で落とした理由は「分野外の探索枠」という枠の趣旨に合わないため**(これは分野内)。**枠が空けば最優先で本枠採用すべき次点。コード公開。**
- 2607.28956: **MerchantBench**(hf 92) — EC 出品者の 365 日シミュレーションで LLM agent の **Long-Term Coherence(長期にわたり目的整合的に振る舞い、蓄積した証拠に応じて判断を更新する能力)**を測るベンチ。**遅延の異なるフィードバックが混ざり、非整合な振る舞いが累積的な損失として現れる**設計は評価設計として学びがある(最良の LLM でも人間の最終純資産の 27.3%)。ただし **RST と「長期タスクをどう作る/測る」という主題が重なり**、RST の方が生成側の方法論として転用余地が大きいので wildcard 1枠は RST に。

---

## 運用メモ(パイプライン)

- **重複バグは本日は不発火。** 採用/次点の全 ID を過去ブリーフ全件に対して照合し、**再提示はゼロ**。[[fetch-duplicate-candidates]] の wildcard dedup 欠落は**未修正のまま**なので、今日たまたま出なかっただけ。修正は引き続き判断待ち。
- **トピック割当の誤りが今日も多発。** `fm_distill_finetune` タグ 30 件のうち、**LAWM-3D(latent action world model)は実質 P3**、逆に `next_arch` の Adaptive-WAM は **P1 の planner 評価に直撃**。キーワードマッチによる topic 割当が粗く、**relevance ベースの再仕分けを人手で毎回やり直している**。`quota` を topic 単位で切っている以上、この誤割当は**枠配分そのものを歪める**(今日は P2 が実質 1 枠しか埋まらなかった原因の一つ)。
- **P1 の在庫が構造的に薄い。** 候補 55 件に対し `planner_ai` はわずか **3 件**(P2 30・P3 19)。うち自動運転文脈は INTraJ の 1 件のみ。**keyword が "motion planning" 等のロボティクス汎用語に寄りすぎ**て、自動運転 planner の論文が `next_arch` 側に流れている疑いが強い(Adaptive-WAM がまさにそれ)。topics.yaml の planner_ai に `NAVSIM` / `nuScenes` / `PDMS` / `ego trajectory` / `planner benchmark` を足すのが具体策。
