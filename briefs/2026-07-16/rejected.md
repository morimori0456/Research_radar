# Rejected — 2026-07-16

注記: 本日の candidates.json の sns_wildcard 3件は昨日 (2026-07-15) と同一だった (fetch 側の dedup 問題、要修正)。うち Direct-OPD は昨日ブリーフ作成済みのため重複として除外。

## P1 (planner_ai) — 採用1件 (MDOC 3/5)、以下は不採用

- **2607.12732: SteinSQP (Globalized Constrained Stein Variational Inference for Diverse Feasible Robot Motion Planning)** — 3/5。制約を厳密に守りながら多様な低コスト軌道のアンサンブルを GPU バッチで得る手法で、サンプリング型プランナーの候補生成には示唆がある。同点の MDOC と比較し、MDOC の方がデモ不要 diffusion + CBF 射影という自動運転の学習型プランナーの現行トレンドに直接刺さるため、全体上限 (max 6) の枠を wildcard の ABot-N1 (4/5) に譲ってこちらを落とした。関節制約・接触など manipulation 寄りの検証である点もマイナス。

## P2 (fm_distill_finetune) — 採用2件 (MobileSAM2 5/5, MBTI 4/5)、以下は quota 超過・低relevance で不採用

- **2607.12787: Light-MER (1B未満の multimodal 感情認識モデルへの蒸留)** — 4/5。Sliced Wasserstein Distance ベースの optimal transport loss + GRPO 系 multi-reward という蒸留 recipe は「新しい loss」として P2 の中心に刺さる。quota=2 で、動画基盤モデル蒸留として汎用性の高い MobileSAM2 と「他機種適合」軸の MBTI を優先。次点として要フォロー。
- **2607.12934: DG-FDD (domain-incremental な変化検出 + 周波数分離蒸留)** — 3/5。周波数領域で構造と domain style を分離して蒸留する発想は domain 適合に使えるが、リモートセンシング変化検出に特化しており recipe の一般化度で MBTI に劣る。
- **2607.13010: DermDepth (皮膚科向け単眼 metric 3D 復元)** — 3/5。合成データ事前学習 + 少量実データ fine-tuning で metric scale 誤差 16x→1.1x という domain gap 克服の good case study だが、ドメインが遠い。
- **2607.12464: C2I (分類器への勾配影響で diffusion 生成データを選別・RL 誘導)** — 3/5。「合成データの有用性をタスク勾配で測る」視点は少データ適合のデータ拡張に使えるが、few-shot 医用画像特化。
- **2607.12450: RINO (あらゆる視覚タスクを RGB-to-RGB 編集に統一, hf3)** — 3/5。統一視覚インタフェースの発想は面白いが、P2 の蒸留/適合 recipe というより統一アーキテクチャの提案で、P3 寄りとしても具体的な設計示唆が薄い。
- **2607.12292: SERD (SAM3 内部応答の decode で zero-shot き裂 segmentation)** — 3/5。「基盤モデルの最終出力より内部応答の方が転移しやすいインタフェース」という知見は fine-tuning 不要適合のヒントだが、き裂検出特化。
- **2607.12896: UniMedSeg** — 2/5。医用 segmentation の統一 in-context 学習。paradigm 統合は興味深いが医用特化で蒸留/適合 recipe ではない。
- **2607.12687: CARE-PPO (critic を confidence 推定器に再利用する PPO fine-tuning)** — 2/5。RL fine-tuning + 不確実性推定の組合せは面白いが LLM の数値予測タスク特化。
- **2607.12856: TES 制御への RLVR fine-tuning** — 2/5。DP の行動価値を dense reward にする verifiable reward 設計は一読の価値があるが、建物空調ドメインで P2 への経路が薄い。
- **2607.12112: FedCMM / 2607.12111: PFAdapter (federated MLLM fine-tuning 2本)** — 2/5。継続学習・階層 LoRA 分解 (global/local 分離) の部品は将来のフリート学習で参照しうるが、現時点の P2 の蒸留・適合 recipe から遠い。
- **2607.12987: cgDDI / 2607.12785: ExtraGS / 2607.12775 系の医用・内視鏡** — 2/5。生成データによる公平性改善、diffusion 誘導 3DGS 外挿。いずれもドメイン特化。
- **2607.12820: AVSCap / 2607.12774: HSEmotion / 2607.12215: OCEAN 検出** — 1-2/5。音声視覚キャプション・感情認識・性格推定の応用で P1-P3 への転用経路が乏しい。
- **2607.12771: 化学反応機構の LLM 推論 / 2607.12612: 翻訳ブリッジ BERT / 2607.12336: Bangla 医療偽情報** — 1-2/5。ドメイン特化 NLP。
- **2607.12418: MQAdapter (量子 adapter)** — 2/5。VLM の coarse-to-fine 適合という課題設定は良いが量子計算前提で実務適用が遠い。
- **2607.12248: TimesFM LoRA の base-rate 検証** — 2/5。「directional accuracy の見かけの高さは base rate」という評価方法論の教訓は P1 の評価設計にも通じる読み物だが、金融時系列で deep brief の枠には満たない。
- **2607.12206: RegHead / 2607.12177: GeoFM サーベイ / 2607.12175: X線トモグラフィ / 2607.12086: CityBehavEx / 2607.12042: SymbOmni** — 1-2/5。アバター・地理空間・ビームライン・都市シミュ・agentic 生成の応用/サーベイで、蒸留・適合の再現可能な recipe を含まない。

## P3 (next_arch) — 採用2件 (TerraZero 5/5, FlowWAM 4/5)、以下は quota 超過で不採用

- **2607.12356: VistaVLA (3D Gaussian 接地 + Merge-then-Query token 圧縮の VLA)** — 3/5。3D semantic 表現を 99% 圧縮して VLA の context に入れる設計は運転の BEV/3D 表現にも示唆があるが、manipulation 検証で quota 超過。次点。
- **2607.12992: ChunkFlow (chunked action head の境界ジッタ対策)** — 3/5。chunk 境界の連続性 loss + overlap blending は実時間 VLA の実装知見として有用。運転の軌道 chunk 出力にも通じるが、アーキテクチャ新規性より工学的改善。
- **2607.12931: ExToken (VLA の RL fine-tuning を行動 token で構造化探索)** — 3/5。rollout の多様性が量より効くという分析は良いが manipulation の VLA-RL 特化。
- **2607.12892: UR-VC (時刻由来 progress ラベルのエピソード横断補正)** — 3/5。訓練不要のラベル補正は value/progress 信号を使う学習全般に効く小技だが、布操作の実証で範囲が狭い。
- **2607.12659: Jetson-PI (Jetson Orin 上の VLA 非同期推論)** — 3/5。future correction module で perception-execution のずれを補正する非同期推論は車載デプロイに関連するが、P3 の「アーキテクチャ設計・学習」よりデプロイ最適化。エッジ実装の参考文献としてブックマーク推奨。
- **2607.12287: VLA の時間冗長性削減 (差分 token 更新 + 2-step diffusion)** — 3/5。同上、推論高速化の工学。
- **2607.12231: GEST-Engine (イベントグラフ→注釈付き合成動画)** — 3/5。「明示的・検査可能な world model + ゲームエンジン実行」でアノテーション費ゼロの動画生成。合成データ生成基盤としては面白いが、学習型 world model の設計への直接の示唆は薄い。
- **2607.12571: TrustVLA (VLA backdoor の推論時防御)** — 2/5。セキュリティ観点で重要だが P3 の軸から外れる。
- **2607.12681: MambaPSA (YOLO26 の attention block を Mamba に置換)** — 2/5。SSM (State Space Model; 線形計算量で系列を扱うアーキテクチャ) の効率検証としては小粒 (VOC で -0.1 mAP)。

## sns_wildcard (EXPLORE) — 採用1件 (ABot-N1 4/5, hf84)、以下は不採用

- **2607.05394: Direct-OPD (Weak-to-Strong Generalization via Direct On-Policy Distillation, hf112)** — **昨日 (2026-07-15) ブリーフ作成済みの重複**。briefs/2026-07-15/2607.05394.md を参照。
- **2607.10350: ABot-AgentOS (ロボット Agent OS + 生涯マルチモーダル記憶, hf72)** — 3/5。昨日と同一候補。評価も昨日と同じ: agentic な運用層の設計で P1-P3 の構造/学習への直接の適用が薄い。wildcard 枠は、P3 の dual-system 設計に直接学びのある ABot-N1 を優先。
