# 落選候補 — 2026-08-13

候補 **53 件**、採用 **6 件** (max_deep_per_day 6 の上限ぴったり)、**落選 47 件**。

内訳: planner_ai 4 件中 **1 採用** / fm_distill_finetune 30 件中 **2 採用** / next_arch 16 件中 **2 採用** / sns_wildcard 3 件中 **1 採用** (wildcard 上限 1)。

---

## 取得側の健全性 — wildcard 枠で重複が再発

**本枠 (arXiv 3 トピック) は健全。** 50 件が入り、内部の id 重複・題名重複ともに **ゼロ**。published は 08-10〜08-11 で lookback_days=2 の窓の内側。08-09〜08-11 に起きていた「topic 別の候補がゼロ件」は本日も再発せず、**2 日連続で正常。**

**問題は wildcard 枠。3 件中 2 件が既に処理済みの論文だった。**

- **2608.09888 (BDH-CQ)** — **08-12 に採用して briefs/2026-08-12/2608.09888.md を書いている。** 本日また候補として出てきた。hf_upvotes は 207 → **546** に増えており、**「注目度が上がると再浮上する」形の重複**である。
- **2608.09819 (Macaron-V1)** — **08-12 に明示的な理由付きで落選させている** (「744B ベースのシステム報告書であり、我々が再現も検証もできない」)。hf は 146 → **323**。同じく再浮上。

**結果として、本日の wildcard 枠で実際に新規だったのは 2608.06296 の 1 件だけ**だった。これは [[fetch-duplicate-candidates]] に記録済みの **「wildcard の dedup 欠如」** がそのまま観測された形で、**原因は既に特定されているが修正が未実施**のため再発している。

**運用上の含意:** wildcard 枠は名目 3 件だが、**HF のトレンドは数日にわたって上位が入れ替わらない**ため、dedup 無しでは実効的な新規候補は 1〜2 件に落ちる。**修正の優先度は上がったと判断する** —— 少なくとも「過去 briefs のファイル名と rejected.md の id を突き合わせて除外する」だけで済む話であり、**wildcard 枠が本来の「視野を広げる」機能を果たしていない**のは無視できない。

**もう一点、選別上の申し送り:** 本日採用した wildcard の **2608.06296 (U-OPSD) は、実質 P2 の論文**である (on-policy self-distillation)。**wildcard を「分野外の探索枠」として使うという趣旨からは外れており、P2 に 3 枠目を与えたに等しい。** 新規の wildcard がこれ 1 件しか無く、かつ R2 への効きが大きかったための判断だが、**quota の趣旨を曲げた自覚のうえでの採用**として記録しておく。

---

## 惜しかった 7 件

### 最も惜しい 2 件

- **2608.10145: The Evaluation Protocol Determines the Result — An Independent Reproduction of LeWorldModel on TwoRoom** — **本日最も惜しい落選で、採用した VIScore と対になる論文。** 独立再現の報告だが、得られた事実が重い。**(1) 1 ステップ予測精度は長期 planning の成功をまったく順位付けできない** —— 予測誤差が 7 倍の幅を持つ 3 つのチェックポイントで、短期の成功は単調に順位付けできたのに**長期は全く順位付けできなかった**。**これは VIScore (2608.11174) の主張と完全に同じ結論であり、まったく別の方法 (再現実験 vs 指標設計) で到達している。同日に 2 本が独立に同じことを言っているのは強い信号。** **(2) 評価プロトコルの違いだけで、著者自身の重みが 84.0% にも 8.0% にもなる** (goal の作り方を変えるだけ、同一 50 エピソード)。論文の appendix とリポジトリの設定ファイルが**別々の goal offset と step budget を指定しており**、片方でしか報告値が再現しない。**(3) 公開設定だけを追った再現者は predictor が収束しないモデルを得る** —— 結果を決める 4 つの慣行 (frameskip ブロックをまたぐ dense action gathering、プログラム的に決まる action encoder の幅、ImageNet の画素正規化、action の z-scoring) が**どの設定ファイルにも書かれていない**。**(4) batch normalization 層が validation loss を最大 300 倍に膨らませ、平坦なままの training loss を隠していた。** next_arch quota 2 に対し VIScore と 4D-WAM を優先したが、**この論文は「評価プロトコルの提案 = R1」をやるなら必読**であり、**weekly review で必ず拾い直すこと。** しかも **$25 の借りた計算資源とノート PC 1 台**でやっている —— 予算で殴れない我々にとっては手法以上に方法論の手本。

- **2608.10413: DriveVLA-M0 — Failure-Aware Memory Augmentation for Autonomous Driving** — **next_arch で 3 番目、僅差で落選。** VLA (Vision-Language-Action) による E2E 運転に **失敗事例の latent memory pool** を持たせ、**静的な道路構造と動的な agent 相互作用を分離した retrieval** で似た場面を引き当て、推論時に **LoRA ベースの TTT (Test-Time Training; 推論時にその場でモデルを少し更新する手法)** で注入する。backbone を触らずに場面ごとの補正を掛ける設計で、**Navtest 94.1 PDMS / Navhard 47.0 EPDMS、TTT の backward が 26.44 ms**。**memory を増やすだけで学習無しに性能が伸びる**という主張も実務的に効く。**コード公開済み** (github.com/ZebinX/DriveVLA-M0)。4D-WAM と同じ NAVSIM で戦っており比較しやすい。**「同じ失敗を繰り返す」は我々の実運用でも一番痛い形の弱点**なので、R3 のマップには必ず載せる。

### その他 5 件

- **2608.10232: FACT — Failure-Aware Causal Training for World-Action Models** — **DriveVLA-M0 と同じ問題意識に、学習側から答えている。** 既存の WAM は成功デモだけで学習されるので**悪い行動の帰結を予測する理由が無い**。FACT は**実行した action で条件付けて**未来映像とタスク進捗を予測することで、**失敗 rollout を捨てずに教師信号として使える**ようにする。推論時には進捗予測器で候補行動を採点することもできる。**失敗データを入れるほど良くなる**ことと、**悪い行動の下での「成功に偏った未来の幻覚」が減る**ことを示している点が良い。**本日「失敗を資産にする」論文が 2 本 (FACT と DriveVLA-M0) 独立に出ている**のは記録に値する。題材が bimanual manipulation で quota 落ち。

- **2608.10484: Lost in Reconstruction (SALT) — Aligning Action Representations with Language in VLA Models** — **数字が本日の next_arch で最も派手** (SimplerEnv 平均成功率 **71.9%** vs 再構成のみの VQ-VAE tokenizer 42.7%、FAST 31.2%)。主張は「**action の離散化を再構成誤差だけで学習すると、動詞に対応する情報が系統的に削られる**」 —— L1/L2 で近いことと、言語的に意味のある区別は一致しない。SALT は VQ-VAE 型の tokenizer に、**凍結した VLM が量子化された action latent から指示文を復元できること**を補助目的として足す。**「行動の軌跡そのものが言語接地の情報源である」という主張は面白い。** ただし**手法の効きが tokenizer の設計に閉じており**、我々の連続軌道出力の planner には距離がある。next_arch quota で落選。

- **2608.10905: ReOrder-OPD — Reliability-Aware Prompt Ordering for On-Policy Distillation** — **fm_distill で 3 番目。** OPD の教師信号の信頼性を**トラジェクトリ単位ではなく prompt 単位**で捉える: **teacher が student の途中経過から正解に到達できる確率 R** を定義し、**R の高い prompt から順に学習する**と利得が大きいことを oracle 実験で示す。R の推定は高いので、**student の独立な 1 rollout と、検証器が正解と認めた同一 prompt の teacher trajectory との ROUGE-5 F1 の最大値**で代理する。Qwen3 / Gemma4 の数学・コードで全比較に勝ち、既存の trajectory 内の重み付け手法と**補完的**であることも示している。**昨日の TIDE、本日採用の U-OPSD と合わせて「OPD の教師信号をどう選ぶか」の 3 本目**。**データの並べ方だけで効くので実装が非常に安い**のは魅力だが、**U-OPSD を wildcard で採ったため OPD 軸が重複**すると判断して落とした。**R2 の実験を組むときに一緒に読むこと。**

- **2608.10709: SQuaT — Self-Supervised KD via Student-Aware Quantized Teacher Features** — **指摘が理論的に綺麗。** **QAT (Quantization-Aware Training; 量子化された状態を前提に学習し、精度低下を抑える手法)** と KD を組み合わせる既存研究には、**teacher と量子化された student の値域のズレが「どうやっても消せない残差」を生み、蒸留 loss に下限が張り付く**という欠陥がある。SQuaT は **student の量子化パラメータで teacher の特徴も量子化する**ことでこの下限を理論的に消す。**ラベル不要**、**1〜2 bit の極端な低ビットで特に効く**、アーキテクチャ非依存、**コード公開** (github.com/lcdbsa522/SQuaT)。**車載の推論予算という観点では本日最も直接的**だが、我々の現在のボトルネックが量子化ではないため見送り。**デプロイ段に入ったら最初に読む 1 本。**

- **2608.11204: Surgical WAM — A World-Action Model for Data-Efficient Surgical Robot Learning** — **トピック分類は fm_distill だが中身は WAM。** 問いの立て方が非常に良い: **「action ラベル付きデモの予算を固定したとき、action の付いていない動画での事前学習は closed-loop 制御を改善するか」。** 答えは yes で、**平均成功率 63.5% → 77.8%、接触が多いタスクと両手協調タスクで最大 +20pt**。**我々の状況と構造が同じ** (ラベル無しの走行動画は大量にあり、正解軌道付きは高い)。手術という題材で quota 落ちしたが、**「action-free video pretraining が効く条件」を測った実験設計は P2/P3 の両方に転用できる。**

---

## その他の落選 (40 件)

### planner_ai (3 件)

- **2608.11175: Risk-Aware Kinodynamic Motion Planning Under Uncertainty For Safe Navigation on Planetary Environments** — **quota 2 枠目を空けて落とした 1 件。** sampling-based planner (AO-RRT) で risk-aware かつ漸近的にコスト最適な軌道を作り、それを初期解として SCP (sequential convex programming) で非線形最適化に解き直す 2 段構え。リスクの定量化に **CVaR (Conditional Value-at-Risk; 「最悪側の裾のうち上位 α% の平均損失」を測る指標。最悪値そのものより滑らかで最適化に載せやすい)** を使い、リスクを 97% 削減。**CVaR を「保守性のつまみ」として使う発想は R1 に効く**が、**題材が惑星探査の車輪型ロボットで、地形力学の不確実性が主題**。我々の交通環境とは不確実性の性質が違いすぎる。**3 点と評価し、採用水準に届かないと判断して枠を空けた** (08-12 と同じ運用)。**CVaR という道具の名前だけ持ち帰る。**
- 2608.10383: Real-World Cooperative Bimanual Dexterous Grasp of Large Objects from Single-View Observations — 大型物体の両手協調把持。データセットと実機フレームワーク。**planner_ai に分類されているが manipulation であり、キーワードの誤爆。** 転用先が無い。
- 2608.10256: CRHT — A Continuous Regression Hybrid Transformer for Vessel Trajectory Prediction — AIS データによる船舶の軌道予測。1D 畳み込み + multi-head attention という標準構成に、**希少な操船を訓練で確実に見せるための online K-means cluster sampling** を足したもの。**「データの偏りをサンプリングで直す」という部品だけは我々の希少シナリオ対策と同型**だが、手法として新しくない。海事ドメイン。

### next_arch (12 件)

- 2608.10386: **Dreamer-SAC** — recurrent state-space world model と off-policy の soft actor-critic を latent 空間で結合した自動運転向け RL。DreamerV3 / SAC / PPO に勝ち、実環境との相互作用が大幅に少ない。**知見として拾えるのは 2 つ** —— **rollout horizon と性能が逆 U 字** (短い latent rollout が、追加の学習信号とモデルバイアスの蓄積の最良の折衷)、**n-step target が 1-step TD より予測経験を活かせる**。**どちらも我々が world model ベースの学習を組むときに直接効く実務知**だが、手法自体は既存部品の組み合わせで新規性が薄く、4D-WAM / VIScore に劣後。
- 2608.10824: **Neural Introspection Gating for Adaptive KV-Cache Reuse in VLA Models** — VLA の推論高速化。既存の VLA-Cache は**観測空間のヒューリスティクス** (視覚的に変化の少ない patch の KV を再利用) だけで判断していたが、本手法は**モデル自身の確信度** —— 上位 2 つの action token の logit 差 —— を見て、閾値を割ったらキャッシュを捨てて再計算する。**学習不要**で、LIBERO-Goal / Long で**失われた精度の 100% 超を回復しつつ計算削減の 80% を保持**。**「ゼロコストの確信度信号で適応的に手を抜く」という型は車載の推論予算に効く**が、我々のボトルネックが VLA の KV キャッシュではない。**デプロイ最適化の段で読み直す。**
- 2608.10618: **World-Model-Centric Autonomous Racing Agent** — 自動運転レースを「極限条件での embodied 知能の限界」を測る試験場として使う。高頻度の定位と知覚、敵対的な相互作用、飽和寸前の車両ダイナミクス。**「保守的な安全マージンの中でしか評価されていない」という問題提起は R1 と同じ方向**だが、**レースは我々の運用領域と要求が違いすぎる** (過保守さがそもそも許されない設定)。問題意識だけ記録。
- 2608.10439: **Stream Forcing** — ストリーミング動画生成の train-inference mismatch (推論は特殊な denoise 順序なのに、学習は多様なノイズ設定を要求する) を、拡散のサンプリングを再定式化して解く。**world model のオンライン生成という点で P3 に接続しうる**が、生成品質の話であり planning に届かない。
- 2608.10120: **ChronoSSM** — SSM (State Space Model; 系列を状態の再帰で扱うモデル。長い系列を transformer より安く処理できる) で、**「何が起きるか」だけでなく「いつ起きるか」を同じ backbone で同時に学習**する。タイミングを凍結表現の上で後から学ぶ 2 段構えより、joint 学習の方が時間情報が取り出しやすくなり、生成品質は落ちない。**時刻を第一級に扱うという論点は運転の系列モデルに効きうる**が、検証はデータマイニング系の 4 ドメインで、我々の設定から遠い。
- 2608.11017: R4DSG — 長時間の一人称視点動画に対する相対 4D シーングラフ記憶。物体の同一性と空間変化を保持して QA する。**永続的な世界表現という論点は面白い**が、ウェアラブル AI 向け。
- 2608.10756: Embodied Multimodal Grounding via Semantic 3D Gaussian Splatting — 開語彙の移動マニピュレーション。Semantic-3DGS + 到達可能性を考えた基地位置決め + 拡散 VLA。屋内の家事タスク。
- 2608.10449: PBD-AG — 長期運用のサービスロボット向けに、**ロボットが検証した安定部分と変化分 (delta) を分離した永続グラフ**を持つ。オンライン地図構築の誤差蓄積を避ける設計。**「変わらない部分と変わる部分を分けて持つ」は地図運用の論点として妥当**だが屋内サービス向け。
- 2608.10718: TCAM for Autonomous Deformable Manipulation (WBCD 2026 Track 4 優勝システム) — T シャツの 1 枚取りと整形。**技術報告書**であり一般的な主張が無い。
- 2608.10393: Hidden in Plain Sight (DURA) — 拡散ベースの制約なし敵対攻撃で VLA を騙す。画素空間の摂動や白箱アクセスに頼らないので現実的、という主張。**VLA の頑健性は将来の論点だが、現在の我々の優先事項ではない。**
- (2608.10145 / 2608.10413 / 2608.10232 / 2608.10484 は上記「惜しかった」を参照)

### fm_distill_finetune (26 件)

**本日も 30 件中、蒸留・PEFT の手法論文は 6 件だけ**で、残り 24 件は "fine-tuning" を含むだけの応用論文だった。**08-12 とまったく同じ症状で、topics.yaml の課題として 2 日連続で観測された** (末尾の調整メモを参照)。

**手法として意味はあるが我々から遠い 6 件:**

- 2608.10812: **Reference-Free Post-Training for Multilingual Machine Translation** (hf 5・本枠の最高) — SFT 済みモデルに **GRPO (Group Relative Policy Optimization; PPO を簡略化した LLM 向け強化学習手法。複数出力の相対比較で優劣を決めるので価値関数モデルが要らない)** を、**参照訳を使わない品質推定モデル 2 つの平均を報酬**として適用し、**SFT と RL のチェックポイントを線形補間**する。46 言語で商用系にも競る。**持ち帰るのは 2 つ —— 「参照解の無い報酬」と「SFT と RL の重みを混ぜる」。後者は極めて安く、我々の適合でも試せる。** さらに**著者は on-policy distillation も試して「RL + 補間の到達点に届くが超えない」と報告している** —— **本日の OPD 3 本に対する外からの評価**として価値がある。機械翻訳という題材で落選。
- 2608.10804: **BPG — Balancing Plasticity and Generalization for Domain Incremental Learning** — ドメインが次々増える設定で、**ドメインごとの特徴の分離しやすさに応じて adapter の隠れ次元を動的に決め**、推論時は**複数のドメイン特化モデルを soft に混ぜる** (ドメイン ID の誤選択を緩和)。DomainNet で忘却 0.22%。**「機種・地域ごとに adapter を用意して推論時に混ぜる」は P2 の適合の話としてそのまま読み替えが効く**ので、**08-12 に落選させた Macaron-V1 の Mixture-of-LoRA と合わせて、この設計パターンは 2 日で 3 回目。** quota で落選したが**そろそろ 1 本ちゃんと読むべき系統**。
- 2608.10473: **Critic-Free Pretraining for Efficient Online RL Fine-Tuning** — offline-to-online RL で、**オフラインで学習した critic を引き継ぐと、方策とデータ分布が急変する online 初期に価値推定がズレて足を引っ張る**という指摘。処方は単純で、**critic の事前学習を完全に捨てて初期化し直す。** **「引き継がない方が速い」という反直感的な結果**は覚えておく価値があるが、我々は現在 O2O RL を回していない。
- 2608.11019: DEFT — 時空間の物理系 (PDE) のモデリングで、**支配的な Fourier モードを特定して逆離散フーリエ変換でデータを効率的にサンプリング**する。少データでの汎化。**物理系のデータ効率という点で world model と接点はあるが、対象が PDE。**
- 2608.11025: Data Attribution of Emergent Misalignment with Persona Features — **狭いタスクで fine-tuning すると無関係な領域で有害な振る舞いが出る (emergent misalignment)** 現象の出所を、**SAE (Sparse Autoencoder) による model diffing** で事前学習文書まで遡る。**「fine-tuning が予期しない副作用を起こす」という点で、採用した MVRD の問題意識と遠い親戚**だが、安全性研究。
- 2608.10437: MammoMix — MoE でマンモグラフィの病変検出をデータセット横断で頑健にする。**heterogeneous なデータ源をまたぐ汎化という論点は共通**だが医療画像。

**応用・別ドメイン (20 件):**

- 2608.11201: VidForensics-M1 (AI 生成動画の検出に meta-detection と検証可能な時間的接地の RL) — フォレンジック
- 2608.11047: V-FiLLM (実表から計算木を生成して構成的に正しい金融推論ベンチを作る) — 金融。**「正解が構成上正しいベンチを自動生成する」という作り方は評価設計として面白いので名前だけ記録**
- 2608.11036: myMediWhisper (ビルマ語医療音声コーパスと Whisper の FFT/LoRA 比較) — 音声・低資源
- 2608.10981: ThinkAfford (雑然とした 3D シーンでの affordance 中心の細粒度接地) — 3D 接地
- 2608.10964: CARE (医療 VQA の確信度校正。**表明する確信と実際の正答率のズレを精度と同時に最適化**) — 医療。**校正という論点は R1 と共通するが医療**
- 2608.10963: REAP (閉じた本の設定で LLM から知識ベースを構築、AKBC Shared Task 2026) — 知識ベース
- 2608.10939: 多言語短文分類の費用効率ルーティング (強い言語は直行、弱い言語だけ迂回) — NLP 運用
- 2608.10916: FaithformBench (数学の chain-of-thought を Lean に形式化する系の忠実性を、**誤った入力も含めて**評価) — 形式手法
- 2608.10870: NullEdit (VLM の条件を逸らして画像編集を静かに無効化する保護) — 画像保護
- 2608.10835: UniProbe (LVLM の内部表現から token 単位で hallucination を検出) — 生成の信頼性
- 2608.10827: MIRA (医療画像診断でツール使用の必要性と証拠の妥当性を自己検証するエージェント) — 医療
- 2608.10801: リモートセンシングでの小規模太陽光パネルの基盤モデル segmentation — 環境
- 2608.10764: FADE (反実仮想動画理解のベンチが選択肢から答えを漏らしている問題を指摘し、能動的発見に変える) — **「ベンチが自分で答えを漏らしている」という監査は評価設計として学びがある**が動画理解
- 2608.10670: Seeds Before Objectives (低資源 Garhwali 語 ASR で、**単一 seed の比較では再現しない改善が出ることを示し、multi-seed + 有意性検定を標準にせよと主張**) — **主張は方法論として完全に正しく、我々の実験にもそのまま効く。題材が遠いだけ**
- 2608.10660: Cross-View Sequential Visual Localization for Autonomous Driving — 地上画像と衛星地図の照合による定位に時間的文脈を入れる。CVIS で平均誤差 3.80m→1.57m、実車ゼロショットで 2.84m。**自動運転だが定位であり、planner にも P2/P3 にも届かない**
- 2608.10649: PolypVision (大腸ポリープの分類とセグメンテーション) — 医療
- 2608.10524: 特定ドメインのテキスト画像検索 (1 クエリに複数の正解がある前提のベンチ) — 検索
- 2608.10517: 超広帯域光ネットワークの物理層デジタルツイン — 光通信
- 2608.10480: 分子 LLM の多粒度な根拠に基づく物性予測 — 創薬
- (2608.11204 / 2608.10905 / 2608.10709 は上記「惜しかった」を参照)

### sns_wildcard (2 件)

- **2608.09888: BDH-CQ** (hf **546**・本日最高) — **08-12 に採用済み。ブリーフは briefs/2026-08-12/2608.09888.md にある。** 重複として落選。
- **2608.09819: Macaron-V1** (hf **323**) — **08-12 に落選済み** (理由: 744B ベースのシステム技術報告書で再現も検証もできない)。**hf が 146→323 に倍増しているが、注目度は relevance を上書きしない**という本日の方針どおり、判断を変える理由が無い。重複として落選。ただし **Mixture-of-LoRA の設計パターンは、本日の BPG と合わせて 3 回目の遭遇**なので、weekly review で「1 本読むべきか」を判断すること。

---

## 今後の調整メモ (weekly review 向け)

1. **wildcard の dedup を実装する (優先度: 高、本日昇格)。** [[fetch-duplicate-candidates]] で原因は特定済み、修正が未実施。**本日、wildcard 3 件中 2 件が既処理という形で実害が出た** (実効的な新規候補は 1 件)。**過去 briefs のファイル名と rejected.md の id を突き合わせて除外するだけ**で解決する。HF のトレンドは数日上位が動かないので、dedup 無しでは wildcard 枠は機能しない。

2. **fm_distill_finetune のキーワードが広すぎる (2 日連続で同じ指摘)。** 本日も 30 件中、蒸留・PEFT の手法論文は 6 件のみ。**"fine-tuning" 単独と "transfer learning" 単独が拾っているのは、ほぼ「LLM/VLM を何かに fine-tuning してみた」応用論文**である。08-12 に提案した狭い句 ("on-policy distillation", "capacity gap", "LoRA", "synthetic-to-real") への差し替えを**改めて提案する。** さらに **"quantization-aware training" と "continual learning" / "domain incremental"** を足す価値がある (本日 SQuaT と BPG がどちらも quota ではなく分類の粗さで埋もれた)。

3. **planner_ai が慢性的に薄い (本日 4 件、うち転用可能 2 件)。** 08-12 は 4 件、本日も 4 件。**しかも本日 planner に最も関係が深かった論文 (DriveVLA-M0、4D-WAM、Dreamer-SAC) は全部 next_arch に分類されている。** 08-12 に提案した "occupancy", "NAVSIM", "nuPlan", "closed-loop evaluation", "trajectory scoring" の追加は**依然として妥当**で、特に **"NAVSIM" は本日 2 本が使っている**ので効果が見込める。

4. **max_deep_per_day 6 と quota 合計 6 + wildcard 1 が構造的に衝突している。** quota (2+2+2) を全部埋めると wildcard の 1 枠が必ず溢れる。**本日は planner_ai の 2 枠目を空けることで吸収したが、これは「planner_ai が薄い」という偶然に依存した解決である。** max_deep_per_day を 7 にするか、wildcard を quota 内に明示的に含めるか、**topics.yaml 側で決めておくべき。**
