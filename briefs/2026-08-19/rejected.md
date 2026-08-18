# 落選候補 — 2026-08-19

候補 **50 件**、採用 **6 件** (max_deep_per_day の上限ちょうど)、**落選 44 件。**

> **本日は 4 日ぶりに arXiv 本枠が復旧した。** 08-15〜08-18 は本枠 3 トピック合計でほぼ 0 件だったが、**本日は planner_ai 3 / fm_distill_finetune 30 / next_arch 14 の計 47 件。** **ただし `fetch_candidates.py` には手が入っていない** (git log 上、`313a283` 以降 1 度も変更されていない)。**つまり復旧は修正の結果ではなく、arXiv API 側が単に応答するようになっただけである。** 例外を握り潰す設計はそのまま残っており、**次に落ちたときも我々は同じように気づけない。** → 申し送りは [DIGEST.md](DIGEST.md) 末尾。

---

## 選別と quota の数え方

| topic | 候補数 | quota | 採用 |
|---|---|---|---|
| planner_ai (P1) | 3 | 2 | **1** |
| fm_distill_finetune (P2) | 30 | 2 | **2** |
| next_arch (P3) | 14 | 2 | **2** |
| sns_wildcard (探索枠) | 3 | 1 | **1** |
| **計** | **50** | — | **6** (max_deep_per_day = 6) |

**planner_ai は quota 2 に対し 1 件しか採らなかった。** 残る 2 件が **家庭用ロボットの棚入れ**と **4-DoF アームのペン操作**で、**自動運転の planner 実装・評価という relevance_criteria に接続しないため。** **枠が空いているという理由だけで低スコアを埋めない。**

---

## quota で落ちた最有力 —— これだけは別扱いで記録する

### 2608.16829: CaliBench — Are the Stochastic Dynamics of Video World Models Physically Calibrated? **relevance 4.0 / 5。落選理由は「next_arch の quota 2 を τ₀-VLA (4.5) と GaussianDWM++ (4.5) が埋めたため」であり、内容の問題ではない。**

**video world model が出す確率分布が、現実の確率分布と合っているかを直接測るベンチマーク。** 既存の評価は個々の生成を採点するか、データセット全体で分布を粗く比較するかで、**「特定の現象について、起こりうる結果の散らばり方が正しいか」を測っていなかった。**

**CaliBench の設計判断が鋭い。** 結果を **FID (Fréchet Inception Distance; 学習済みネットワークの特徴空間で生成物と実データの分布を比べる指標) のような学習された特徴空間ではなく、物理的に解釈できる離散空間 (ビンの番号、サイコロの目、トランプのスート、色) で採点する。** そのうえで **参照分布が閉じた式で分かる場面だけを選ぶ** (ガルトンボードの二項分布、ベルヌーイの分岐、一様なサイコロ・カード・くじ、ヨーロピアンルーレットの色の偏り)。**参照が厳密に既知なので、較正の検定が近似なしに行える。**

**そして評価を直交する 2 軸に分解する:** **scorability (そもそも採点可能な結果が出た生成の割合)** と **calibration (採点できたぶんについて、参照分布からの total variation distance = 全変動距離)。** **単一の精度指標はこの 2 つを混ぜてしまう。** 検定は chi-squared (カイ二乗検定) で、**帰無仮説が「較正されている」であるため、示せるのは「較正されていない」ことだけ**と自ら明記している。**N=32/セルでは大きなずれしか検出できない**という検出力の限界も明示。**この誠実さは評価指標の論文として模範的である。**

**結果:** 9 シーン × 6 つの image-to-video モデル (WAN-2.7, SeeDance-2.0, HappyHorse-1.0, Veo 3.1, Runway Gen-4.5, Cosmos3-Super) を各 32 生成。**モデルは一貫して確率質量を少数の結果に集中させ、参照分布を再現しない。** シーン・モデルの組み合わせの大半が有意に miscalibrated で、**極端な例では 1 つの結果に潰れる (Veo 3.1 のサイコロ)。** ルーレットではボールの位置が曖昧で scorability が低いモデルが多い。**9 シーン全てで勝つモデルは無い。**

**なぜ我々にとって重要だったか。** **R1 (HIL 評価 × conformal 安全指標) が作ろうとしているものと、方法論が驚くほど近い。** 参照が既知の場面を意図的に構成して保証付きの検定を行う、**評価を「測れたか」と「測れたぶんは正しいか」の 2 軸に分ける**、**検出力の限界を明示する** —— **これらは R1 が真似すべき作法そのものである。** さらに **08-18 に確認した「審判に学習モデルを使わない」という R1 の設計判断を、実際に貫いた評価論文の実例**でもある (FID を避けて解釈可能な離散空間を選んだのが、まさにそれ)。

**それでも quota 内では採らなかった:** next_arch の relevance_criteria は **「次世代アーキテクチャの設計・学習に着想を与えるか」**であり、**本論文はアーキテクチャの論文ではなく評価の論文である。** 同じ枠を争った 2 本は **どちらも R3 (VLA × world model 統合の分類マップ) の次のアクションに直接材料を与える**ため、**next_arch の基準では順当に負ける。**

> **申し送り: 本論文は「明日の候補」ではなく「P1 の枠で読むべき論文」である。** トピック分類が next_arch になったのは world model を対象にしているからだが、**中身は評価指標の論文であり、価値は P1 側にある。** **fetch のトピック割り当てが arXiv カテゴリとキーワード一致で決まる以上、この種の取り違えは今後も起きる。** → **R1 のサーベイを始めるときに、真っ先に読むこと。** 忘れないよう、ここに残す。

---

## 惜しかったもの (relevance 3.0–3.5)

### 2608.16859: HarnessEval-W — Agentifying the Evaluation of Visual Worlds. **relevance 3.5 / 5。**

**world model の評価を、固定の採点表ではなく LLM エージェント群にやらせる。** 親エージェントが評価の問いを測定可能な部分問題に分解し、**それぞれに専用の道具と文脈を与えたサブエージェントを立てて**推論させ、集めた証拠を検証して最終判定にまとめる。**すべての評価が検証可能な「証拠の木」として残る**のが売り。18 の world model・330 の評価ケースに適用し、人間の選好とよく一致すると報告。パイプラインは公開され、**生きたベンチマークとして community の貢献を募る形をとる。**

**落とした理由。** **「スコアだけでなく、なぜそのスコアなのかの推論過程が残ること」という問題意識は正しく、08-18 に R1 で確認した「最終結果型か局面分解型か」の軸にも乗る。** しかし **審判が LLM エージェントである。** これは **08-18 に R1 の設計判断として明記した「審判に学習モデルを使わない」と正面から反する。** **R1 が本論文を採るなら、その判断を撤回することになる。** 撤回する理由は現時点で無い —— むしろ本日の [VibeWorlding](2608.15265.md) と合わせると、**「学習モデルを審判にする設計」の実例が 2 本揃った**ことになり、**R1 の差別化としてはそちらのほうが有用である。** **同じ next_arch 枠で、より我々の立場に近い CaliBench (4.0) が上にいたことも大きい。**

> **本日、hf_upvotes が最も強く relevance と食い違った候補である。** **107 upvotes は本日の全 50 件中で最高**であり、次点の [VibeWorlding](2608.15265.md) (50) の 2 倍以上、**本日採用した in-field 4 本はいずれも 0 である。** **規則どおり relevance を上書きさせず、副次シグナルに留めた。** なお **CaliBench (4.0 / hf 0) と本論文 (3.5 / hf 107) は「world model の評価」という同じ主題を扱う近接候補**だったが、**スコアが同点にならなかったため、タイブレークとしても upvote は関与していない。** **両者を分けたのは「審判に学習モデルを使うか否か」という一点である。**

### 2608.16585: SQuad — Sub-Quadratic Attention Distillation for Efficient Video Generation. **relevance 4.0 / 5 —— fm_distill_finetune の quota 2 が SOPD (4.5) と BRIDGE (4.0) で埋まったため落選。実質的には BRIDGE との一騎打ちに僅差で敗れた 1 本。**

**video Diffusion Transformer の計算はほぼ self-attention に食われており、その費用は latent token 数 n に対して O(n²) で増える。** そのため **生成できる解像度と長さが頭打ちになる。** 線形 O(n) や低ランク O(nk) の代替は安いが表現力が戻らない。**SQuad は O(n√n) という中間の複雑度を狙い、効率と表現力の釣り合いを取る。**

**recipe が実務的で、そこが評価点。** 一から学習し直すのは高すぎるので、**学習済みの full softmax attention を持つ DiT を、2 段階で SQuad-Attention に「詰め替える」:** まず **flow-matching に基づく SFT**、次に **DMD2 (improved Distribution Matching Distillation; 生成分布を合わせる蒸留の改良版) でサンプリング自体も効率化する。** **Wan 2.2 5B の text-to-video で、VBench 83.20 対 83.08 と教師にほぼ並びながら、ブロック・ステップあたりの attention FLOPs を約 67 倍、attention の遅延を約 11 倍、DiT 全体の遅延を 2 倍削減し、生成に必要な NFE (Neural Functional Evaluations; 生成 1 本あたりのモデル呼び出し回数) を既定の 100 から 6 に落とした。**

**落とした理由と、それでも記録する理由。** **「学習済みモデルを、別のアーキテクチャへ蒸留で詰め替える」は fm_distill_finetune の criteria に真っ直ぐ乗る**し、**O(n√n) という設計点は next_arch の "efficient transformer" にも触れる。** 惜しい。**BRIDGE を上に置いたのは、R2 が必要としているのが「もう 1 本の良い蒸留 recipe」ではなく「破綻境界を測る手続き」だからである** —— **R2 の次のアクションは「小規模で予備実験、法則が見えるか」であり、そこに直接効くのは BRIDGE のほう。** SQuad は **recipe としては優れているが、R2 の系統則には材料を足さない。**

> **ただし P3 の車載展開を考え始めた時点で、本論文の優先度は跳ね上がる。** **attention を O(n²) から O(n√n) に詰め替える蒸留 recipe**は、world model や VLA を実機に載せる段になれば直接必要になる。**BRIDGE (どこまで削れるか) と SQuad (どう詰め替えるか) は補完的**であり、**組で読むべき 2 本である。** 本日は R2 側を優先しただけで、**捨てたわけではない。**

### 2608.16384: Self-Routed Tensor Adapters (SRTA) for Parameter-Efficient Universal Visual Adaptation. **relevance 3.0 / 5。**

**PEFT (Parameter-Efficient Fine-Tuning; モデル本体を凍結し、少数の追加パラメータだけ学習して適合させる手法群) の一種。** 標準的な low-rank adapter は全入力に同じ部分空間を使うため、**画風・背景・意味文脈が大きく違うドメインが混ざると窮屈になる。** MoE (Mixture-of-Experts; 複数の専門家経路を用意し、入力ごとに使い分ける構成) 型の adapter はそこを改善するが、**外部のルーター**と**大きな専門家の在庫**を必要とし、パラメータが増えるうえ **ルーティングと適合が別物になる。**

**SRTA は入力を低ランク空間に射影し、その表現から学習可能な domain matrix でルーティング重みを計算し、共有された Tucker core (テンソルを低ランクに分解する形式のひとつ) のスライスを混ぜて、サンプルごとの適合行列を作る。** 外部ゲートが要らず、**ルーティングが適合の中に内在する。** 5 つの異種マルチドメイン画像分類ベンチマークで **MoE 型 PEFT と同等以上の平均精度を、遥かに少ない学習パラメータで達成** (rank 64・4 ドメインで **2.77M 対 MoLoRA 9.52M**、6 ドメインで **3.00M 対 14.31M**)。コード公開あり。

**落とした理由。** **「基盤モデルを少ないパラメータで他ドメインへ適合させる」という criteria 後半にはよく合う**が、**R1・R2・R3 のどの次のアクションにも材料を足さない。** 特に **R2 は蒸留の破綻境界を狙っており、PEFT は容量を削る話ではなく凍結して足す話なので、軸が違う。** **上位 2 本 (4.5 / 4.0) との差は relevance で明確についている。**

> **保留メモ:** **P2 の実務側で「1 つの基盤モデルを複数の車種・複数のドメインに適合させる」という要求が具体化したときは、本論文が第一候補になる。** パラメータ効率の数字 (3〜5 倍差) は実務上意味のある幅であり、コードも公開されている。

### 2608.16620: Palmyra x6 Technical Report — Anchored Supervised Fine-Tuning. **relevance 3.0 / 5。**

**MoE ベースモデルに対する post-training の技術報告。** 特筆すべきは **recipe が意図的に極端に保守的なこと: 検証済みの合成 tool-use 軌跡 626 本のみ、1 epoch、低い学習率、そして凍結したベースモデルへの KL anchor (元のモデルから離れすぎないよう KL で引き留める正則化)。** 最適化は **Muon + Adam のハイブリッド。** **BFCL Core で 0.785**、6 ベンチマークの平均で同時期のモデル群の首位を主張。

**落とした理由。** **「626 本・1 epoch・KL で元に繋ぎ止める」という少データ適合の recipe は、fm_distill_finetune の criteria (少データでの適合) に確かに乗る。** しかし **enterprise 向け agentic LLM の技術報告であり、対照実験が無い** —— **KL anchor が効いたのか、データの質が効いたのか、Muon が効いたのかが切り分けられていない。** **recipe を輸入するには、どの部分が効いているかが分からなければ使えない。** 本日は **同じ「少データで効かせる」主題を、明快な理論的位置づけと対照込みで扱った SOPD がある。** 比較して落とした。

> **ただし KL anchor という道具立ては覚えておく価値がある。** **「凍結した元モデルへの KL で引き留めながら少量データで適合させる」は、基盤モデルを別ドメインに転用するときの過適合対策として、そのまま試せる形をしている。**

### 2608.16632: DRAFE — Cross-City Fine-Grained Traffic Object Detection. **relevance 2.5 / 5。**

**LW-DETR と RF-DETR という 2 つの detection transformer を独立に学習してアンサンブルし、都市をまたぐ交通物体検出のドメイン汎化を狙う。** 2 段階学習 (擬似ラベル拡張と human-in-the-loop での注釈精緻化により 6,049 枚・203,619 注釈のコーパスを作り、その後にチャレンジ規定のデータで fine-tuning)。推論時に anchor 条件付きのクラス整合マッチング、信頼度重み付き座標融合、一致度を見た信頼度再較正、補完仮説の回収を行う。**AI City Challenge 2026 Track 6 で mAP 0.4022、25 チーム中 6 位、予備アンサンブルから +0.0553。**

**落とした理由。** **主題 (都市をまたぐドメイン汎化・交通物体) は P2 の criteria にも運転にも近い**が、**中身はチャレンジ向けのアンサンブル工学であり、一般化できる原理が無い。** **6 位という順位も、手法の優位を主張する材料としては弱い。** **1 ページ割いて持ち帰れるものが「アンサンブルの融合を丁寧にやると上がる」に留まる。**

### 2608.16837: HAF — Adapting Generalist VLAs to Humanoid Whole-Body Loco-manipulation. **relevance 3.0 / 5。**

**汎用 VLA をヒューマノイドの全身 loco-manipulation (移動と操作を同時に行う課題) に適合させる。** 高次元で相互依存する全身の動きを、単段の VLA では移動・腰姿勢・両腕操作の協調として捌けない、という問題設定。階層的な action flow と spectral latent RL で対処する。

**落とした理由。** **「汎用 VLA を別の機体・別の課題に適合させる」は P2 と P3 の交点にあり、筋は悪くない。** しかし **ヒューマノイドの全身制御という課題の固有性が強く、運転ドメインへの写り方が見えない。** **同じ next_arch 枠で、R3 の分類マップに直接寄与する 2 本が上にいる。**

### 2608.16287: SCALE — State-Calibrated Latent Embeddings for JEPA Planning. **relevance 3.5 / 5 —— 内容は面白い。next_arch の quota で落ちた 2 本目。**

**JEPA (Joint-Embedding Predictive Architecture; 生成せずに埋め込み空間で未来を予測する world model の作り方) 系の planning は、予測した終端埋め込みと目標埋め込みの距離をコストとして候補を選ぶ。** 埋め込みが潰れないようにする方法は 2 系統あり、**事前学習済み特徴空間を借りる (DINO-WM)** か **崩壊防止の正則化つきで end-to-end に学習する (LeWM + SIGReg)** か。

**本論文の指摘が鋭い。** **どちらのモデルでも「タスクに関係する状態」は埋め込み全体からは復元できる。しかし DINO-WM のほうが、主成分の上位に状態情報を遥かに多く残している。** **Euclidean なコストは分散の大きい方向に支配されるので、この差が「状態が候補選択にどれだけ影響できるか」を変える。** SCALE は **サンプリングした潜在空間の対距離を、標準化したタスク状態空間の距離と相関させる**ことで、LeWM の学習済みエンコーダを置き換えずに DINO-WM 的な幾何を誘導する。5 タスク × 3 ソルバ × 5 計算予算の全平均で LeWM を上回り、**学習時の軽い正則化 1 つだけで planning 時のコストはゼロ。**

**結論の言い方が本論文の価値の核心:** **「planning の成否は、タスク関連情報が表現に含まれているかだけでなく、その情報が planner の使う幾何を形作っているかで決まる」。** 情報の有無と、情報が効く形になっているかは別、という主張。**しかも latent→state 回帰の対照実験で、復元可能性を上げるだけでは planning は良くならないことを示している。**

**落とした理由。** **quota。** τ₀-VLA と GaussianDWM++ が R3 の分類マップに直接材料を足すのに対し、**本論文は既存の JEPA 系 world model の改良であり、統合アーキテクチャの分類には新しいセルを作らない。**

> **保留メモ: R3 が「world model の内部表現」軸を掘る段になったら、本論文は必読。** **「表現に情報が入っているか」と「その情報が planner に届く幾何になっているか」の区別は、分類マップの評価欄に入れるべき観点である。** GaussianDWM++ が意味を 3D Gaussian に埋め込んでいることの是非も、この観点で問える。

### 2608.16476: Exposing the Long-tail in Embodied Urban Navigation via Scalable Learning from In-the-Wild Videos. **relevance 3.0 / 5。**

**web 規模の一人称視点動画から、都市ナビゲーションの方策を学ぶ枠組み。** 動画を自動注釈してタスク特化のデータ収集コストを回避しつつ、**稀だが安全上重要なシナリオ (long tail) の被覆の薄さを体系的に露出させる**ことを狙う。

**落とした理由。** **「long tail を体系的に露出させる」という問題意識は R1 に接続しうる** —— **評価において稀な危険事例をどう扱うかは、まさに R1 の中心的困難である。** しかし **本論文の主眼は方策学習側にあり、露出の手続きが評価指標として使える形で提示されているかが abstract から読めない。** **同じ next_arch 枠に、より確度の高い 2 本があった。**

### 2608.16172: SparkVLA / 2608.16503: NebulaVLA / 2608.16889: BATON. **いずれも relevance 2.5–3.0 —— hierarchical VLA の運用上の詰め。**

3 本とも **hierarchical VLA の「上位と下位の接続部をどう設計するか」**を扱う。**SparkVLA は「いつ現在の subtask を打ち切るか」と「提案された action chunk をどこまで実行するか」が相互依存する問題を扱い、NebulaVLA は高次の意味推論と低次の行動制御を非同期の二周波数に分けて効率と滑らかさを取り、BATON は VLA を凍結して LLM エージェントに指揮させる構成の破綻 (誤差の累積、subtask 間の暗黙の制約) を扱う。**

**まとめて落とした理由。** **本日採用した [τ₀-VLA](2608.16885.md) が、同じ「hierarchical VLA の上位判断」という問題に対して、より一般的な枠組み (推論時計算量のスケーリング) を与えている。** 3 本はいずれもその枠組みの中の個別の設計判断に相当し、**τ₀-VLA を読んだ後で必要になったら戻ればよい。** **R3 の分類マップには、細目としてまとめて 1 行で入れる。**

### 2608.16338: SIGMA-Lane — Scale-pyramId Gated MAmba for Video Lane Detection. **relevance 2.5 / 5。**

**SSM (State Space Model; 系列を状態の線形な時間発展として扱い、長い系列を効率よく処理できるモデル族。Mamba がその代表) を使った動画レーン検出。** 遮蔽で壊れた観測が hidden state に入り込み、**誤りが後続フレームに残り続ける「状態の汚染」**を問題として立てる。SSM の書き込み経路と残差融合経路に遮蔽を見たゲートを置き、履歴から失われたレーン構造を回収する経路を併設。VIL-100 と OpenLane-V で遮蔽下の時間的安定性が改善。

**落とした理由。** **next_arch のキーワード "state space model" に当たり、対象も運転である**が、**知覚モジュールの改良であってアーキテクチャの着想ではない。** ただし **「recurrent な状態に汚染が入ると後まで引きずる」という問題の立て方は、world model 系にそのまま存在する問題**であり、**R3 の観点で 1 行覚えておく価値はある。**

### 2608.16651: Orbit-Planner (衛星の軌道上障害物回避のための latent world model). **relevance 2.0 / 5。**

**行動条件付きの空間表現を学ぶ 2 段階の latent world model。** 事前の地図や固定的な環境仮定に頼る従来のプランナーに対し、限られた機上観測から衝突リスクを予測する。**「world model + planning」という構造は P3 と同型**だが、**軌道上という環境が運転とかけ離れており (交通参加者がいない、力学が違う、時定数が違う)、移せる知見が構造の一般論に留まる。**

---

## 重複 —— 昨日すでに処理した候補が再提示された

### 2608.14144: Self-Supervised Visual On-Policy Distillation (S²VOPD) — **重複。08-18 に採用しブリーフ作成済み** ([briefs/2026-08-18/2608.14144.md](../2026-08-18/2608.14144.md))。
### 2608.14391: Can We Defend Against AI-Generated Video Attacks on Real-World Crisis Events? — **重複。08-18 に relevance 1.0 で落選済み。**

**本日の sns_wildcard 候補 3 件のうち 2 件が、昨日すでに処理済みのものだった。** **つまり探索枠の実効的な候補数は 1 件しかなく、[VibeWorlding](2608.15265.md) は「選ばれた」というより「唯一残った」に近い。** ブリーフ内でその前提を明記してある。

**これは memory に記録済みの既知欠陥 (wildcard 経路に dedup が無い) が、本日また発現したものである。** 08-18 の時点では **本枠が枯れていたため wildcard 経路の欠陥は表面化しにくかった**が、**本日のように本枠が復旧しても wildcard 側は独立に壊れたままである**ことが確認できた。**修正は arXiv 側の例外処理とは別件として扱う必要がある。**

> **実害の見積もり:** wildcard は元々 1 日 1 件の枠である。**その候補プールの 2/3 が既読で埋まるということは、探索枠がほぼ機能していないに等しい。** **「視野を広げるための枠」が、実際には「昨日の再放送を眺める枠」になっている。** 修正は難しくない —— **過去の briefs ディレクトリに存在する id を除外するだけ。**

---

## 一括落選 (relevance 2.0 以下 — 主題が P1/P2/P3 のいずれにも接続しない)

**fm_distill_finetune 枠は 30 件中 24 件がここに入る。** **キーワード ("fine-tuning" "domain adaptation" "transfer learning" 等) が汎用的すぎて、応用分野を問わず広く当たってしまっているのが原因である** (memory 記録の欠陥 #5 と同根)。**個々の論文の質の問題ではない。**

| id | title | topic | 落とした理由 |
|---|---|---|---|
| 2608.16741 | Semantic- and Density-Aware Planning for Multi-Object Placement | planner_ai | 家庭用サービスロボットの棚入れ。planning ではあるが自動運転の planner 実装・評価に接続しない |
| 2608.15968 | Tabletop Pen Manipulation With a Vision-Guided 4-DoF Arm | planner_ai | 低コスト 4-DoF アームの劣駆動下での把持。主題が離れすぎている |
| 2608.16873 | Analytical-Prior Framework for Helmholtz Resonators | fm_distill | 音響共鳴器の有限要素シミュレーション代理モデル。解析的事前分布でデータ効率を上げる着想は一般的だが、我々の対象と重ならない |
| 2608.16661 | Turning spectra into images improves plant trait retrieval | fm_distill | 植物のハイパースペクトル計測。1D スペクトルを 2D 画像に変換する工夫は面白いが分野外 |
| 2608.16622 | HarmTrace: harmful meme target identification | fm_distill | 有害ミームの攻撃対象特定。分野外 |
| 2608.16612 | Degradation-Aligned SSL for Battery State of Health | fm_distill | リチウムイオン電池の劣化推定。ラベル希少下の自己教師あり学習という構造は近いが、応用が遠い |
| 2608.16589 | Ultra: restoration-segmentation collaboration under adverse weather | fm_distill | 悪天候下の教師なしドメイン適応。運転画像に近いが、復元と分割の協調という主題が P2/P3 に接続しない |
| 2608.16569 | Generalizable Reconstruction of High-Dimensional Neural Dynamics | fm_distill | 神経活動記録 (LFP) の再構成。Koopman 作用素による潜在線形化は着想として綺麗だが分野外 |
| 2608.16539 | Listen, Reason, and Segment: LALM media chapterization | fm_distill | 音声の章分割。分野外 |
| 2608.16502 | Source-Style Collapse in Executable Capability Retrieval | fm_distill | エージェントのツール検索の失敗様式。retrieval 層が静かに失敗するという指摘は面白いが P1/P2/P3 に接続しない |
| 2608.16480 | RISE: Roadside Infrastructure Sequence Understanding | fm_distill | 路側インフラの 3D 追跡と視覚言語推論。**運転周辺ではあるが自車側の planner/蒸留/アーキテクチャのいずれでもない。** LiDAR なしで永続的 3D 追跡を復元する点は覚えておく価値あり |
| 2608.16467 | Computational KJ-Ho: LLM による定性データの洞察抽出 | fm_distill | 消費者インサイト分析。分野外 |
| 2608.16429 | Localized TabICLv2: k-NN による表形式 ICL のスケーリング | fm_distill | 表形式データの基盤モデル。分野外 |
| 2608.16379 | Unadapted Multilingual ASR on Kurdish | fm_distill | 音声認識の評価における正規化の扱い。**「評価の前処理が結果を変える」という論点は R1 に通じるが、それだけで 1 ページは割けない** |
| 2608.16334 | Transfer Learning of Keystroke Dynamics | fm_distill | 打鍵パターンによる本人認証の機種間転移。分野外 |
| 2608.16328 | GRNEdit: Efficient General Video Editing (hf 13) | fm_distill | 指示ベースの動画編集。分野外。**hf 13 は本日 3 位だが relevance を上書きさせない** |
| 2608.16284 | TransAnyText: E-commerce 画像内テキストの翻訳 | fm_distill | 分野外 |
| 2608.16269 | Domain-Agnostic Neural Topic Modeling | fm_distill | トピックモデル。分野外 |
| 2608.16268 | CoM³eT: 医用画像の連合学習基盤モデル | fm_distill | 病理と放射線を統合する医用基盤モデル。**「複数専門領域を 1 モデルに統合する」構造は P2 と同型だが、医用固有の制約 (連合学習) が大半を占める** |
| 2608.16161 | Domain-Specific Text Embedding for Entity Resolution | fm_distill | 名寄せ向けの埋め込み。分野外 |
| 2608.16143 | AnyTalk: 任意キャラクタの音声アニメーション (hf 5) | fm_distill | 分野外 |
| 2608.16134 | Riemannian Hypergraph for Online TTA of MI-BCI | fm_distill | 脳波 BCI の test-time adaptation。**オンライン適応という主題は近いが、EEG 固有の幾何 (Riemannian) に依存** |
| 2608.16110 | SUGFW+: SAM の cold start active adaptation | fm_distill | 医用画像分割で基盤モデル (SAM) を少ない注釈予算で適合。**能動学習の枠組みは P2 に近いが医用固有** |
| 2608.16103 | Beyond Similarity Matching: 3DGS の open-vocabulary referring segmentation | fm_distill | 3D Gaussian と言語の対応づけ。**採用した GaussianDWM++ と主題が重なるが、こちらは分割タスクに閉じており world model ではない** |
| 2608.16073 | GOD: Deep Grafting for Sequential Recommendation | fm_distill | 推薦系。**「teacher と student を独立に走らせてから合わせる従来の蒸留は、student 側の各部品の寄与を混ぜてしまう」という指摘は R2 に通じる**が、推薦固有の設定が強い |
| 2608.16011 | ReRef-3D: 3D シーン再配置のベンチマーク | fm_distill | 言語誘導の 3D 配置ベンチマーク。**「指示が一点ではなく許容領域を定義する」ため予測を挿入して評価する設計は評価論として面白い**が、主題が遠い |
| 2608.16806 | State-Semantic Injection in LLM-Driven Embodied Agents | next_arch | エージェントの状態を攻撃面とみなすセキュリティ研究。P1/P2/P3 に接続しない |
| 2608.16074 | US-VLA: 超音波検査の VLA | next_arch | 医用超音波の走査。**VLA ではあるが応用が遠く、報酬設計を避ける工夫も医用固有** |

---

## 本日の hf_upvotes の扱い (規則の適用記録)

**非ゼロは 5 件のみ:** 16859 (107) ・ 15265 (50) ・ 14391 (267・重複) ・ 14144 (158・重複) ・ 16328 (13) ・ 16143 (5)。

- **本日採用した in-field 4 本 (τ₀-VLA / SOPD / GaussianDWM++ / BRIDGE) は、すべて hf_upvotes 0 である。**
- **本日最高の 107 (HarnessEval-W) は落選した。** relevance 3.5 で、quota 内の 4.5 / 4.5 に届かず、かつ **R1 の設計判断と反する。**
- **タイブレークの場面は発生しなかった。** 採用・落選の境界にあった CaliBench (4.0 / hf 0) と HarnessEval-W (3.5 / hf 107) はスコアが同点でないため、**upvote は本日も結論に一切関与していない。**

> **3 日連続で、hf_upvotes の順位と relevance の順位は無関係かほぼ逆順である。** 08-18 は「最も注目された論文が最も関係のない論文だった」。本日は **「採用した 4 本すべてが upvote 0」** —— つまり **arXiv 本枠が生きている日には、HF は我々にとってほとんど情報を持たない。** **HF が価値を持つのは、本枠が落ちている日の保険としてである** (08-18 がまさにそれだった)。**副次シグナルという位置づけは正しい。**
