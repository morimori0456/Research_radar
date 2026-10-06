# 2026-10-07 不採用

候補 63 件 (planner_ai 1 / fm_distill_finetune 30 / next_arch 29 / wildcard 3)。採用 6 件 (P1 2 / P2 2 / P3 2)。採点は abstract のみ。fetch の diagnostic は今回未実施 (candidates.json の generated_at は 10-06T18:00Z)。

注: Odyssey と ControlPed は topic が next_arch だったが内容は P1 の評価なので P1 枠で採用した。SimForcing は next_arch 由来だが蒸留が核なので P2 枠。

## planner_ai
- 2610.06153: Talk, Render, Act (humanoid の音声・顔・ジェスチャ統合) — 運転 planner と無関係 (keyword は表面一致のみ)

## fm_distill_finetune (高めの次点から)
- 2610.06542: LoRA Fine-Tuning Landscape (rank 選択とデータ選択) — 次点 (3.5)。rank 選びは実務で有用だが、上位 2 本 (Flash-OPD / SimForcing) の方が蒸留の recipe として直接的。次回の再浮上候補
- 2610.05966: HuatuoGPT-3 (RL-only の domain adaptation) — 3.5。医療 LLM の recipe で、運転系への転用は遠い
- 2610.06243: RoSA (一度に一部の層だけ学習する PEFT) — 3.0。メモリ効率の着想は良いが、評価の詳細が abstract では不明
- 2610.06437: HeuFouFT (Fourier fine-tuning の周波数選択) — 3.0。task 依存の探索コストが重そう
- 2610.06415: Training-Free Transformer Merging — 3.0。merging は適合の周辺技術で、P2 の主線から外れる
- 2610.06450: EMG-FM-Bench (筋電図 FM の転移 benchmark) — 2.5。適合の観点は合うが分野が遠い
- 2610.06447: Time-series FM for Predictive Control — 2.5。zero-shot 予測と制御の関係。運転とは遠い
- 2610.06327: Dual VAE for Sim-to-Real (低コストロボットの navigation) — 2.5。sim-to-real は関連するが小規模
- 2610.06324: Readout Blindness (VLM 空間関係の読み出し) — 2.5。診断としては面白いが蒸留/適合の recipe ではない
- 2610.06750: Hybrid LMs の memory 利用 — 2.0。LM 向け
- 2610.06329: Dynamic Minimax Regret (LLM post-training) — 2.0
- 2610.06241: Few-Shot Prototype Head (ECG の on-device 個人化) — 2.0。少データ適合だが ECG 固有
- 2610.06693: Adapting PFN for tabular anomaly detection — 2.0。tabular
- 2610.06226: LeAVJEPA (audio-visual SSL) — 2.0。運転に音声は不要
- 2610.06850: InterMimicGen (humanoid の loco-manipulation) — 2.0
- 2610.06847: S2PD (video diffusion の物理整合) — 2.0
- 2610.05861: Imagine to Act (GUI agent の data 合成) — 1.5
- 2610.06293: VepAgent (video event prediction) — 1.5
- 2610.06290: GAMBIT (multi-robot の trajectory) — 1.5。planning だが multi-robot
- 2610.06782: T-Search (agentic retriever) — 1.0
- 2610.06505: Proactive AI Assistance — 1.0
- 2610.06439: Reward Hacking in Legal Reasoning — 1.0
- 2610.06404: Multi-Step Reasoning の安定性 — 1.0
- 2610.06238: Certification-Enhanced Generalization Bounds — 1.0
- 2610.06602: 膝 MRI の MT-cGAN — 0.5。分野外
- 2610.06596: SWIR 画像の検出 (自動運転) — 1.5。運転だが分析のみ、手法の新規性が薄い
- 2610.06503: T2I の有害生成 — 0.5
- 2610.06420: Secure FL (医療画像) — 0.5
- 2610.06196: EORestore-Agent (リモセン画像) — 0.5

## next_arch
- 2610.06271: VLA-ZO (VLA の zeroth-order 適応) — 次点 (3.5)。forward のみで deployment 時 shift に適応する点は P2/P3 に効くが、枠が埋まった。次回の再浮上候補
- 2610.05719: When to Switch (VLA の action-chunk 延長; hf 9) — 3.5。推論の停止を減らす実用的な話だが manipulation 寄り
- 2610.05739: HLA-WM (hybrid linear attention の長期 video world model) — 3.5。KV cache 削減は効率面で関心があるが、診断の 05550 と階層の H-JEPA を優先
- 2610.05994: VLA post-training の data augmentation — 3.0
- 2610.05745: Quantized VLA の汎化回復 — 3.0。量子化は P2 の圧縮に近い
- 2610.06318: Affordance head の wiring (VLA) — 3.0
- 2610.05996: EpicWorldModel (非決定的な JEPA の探索 planning) — 3.0。H-JEPA を優先
- 2610.06582: Mind the Execution Gap (world-model 制御の非同期実行) — 3.0。実機遅延の観点は示唆的だが小規模
- 2610.06349: KineWorld (action-induced transport field) — 3.0
- 2610.06078: VLA は物体の物理を理解しているか — 2.5
- 2610.06235: VLA の grounding gap — 2.5
- 2610.06184: ACG-Bench (dual-arm VLA) — 2.5
- 2610.05878: OGAM (VLA の runtime monitoring) — 2.5。評価に近いが manipulation
- 2610.06843: Recursive Video ICL for Agentic Robot — 2.0
- 2610.06814: TAPDreamer (world action model への adversarial patch) — 2.0
- 2610.05818: VLA の implied harm — 2.0
- 2610.05755: Port-Hamiltonian Retuning — 2.0
- 2610.06637: Textual World Modeling — 1.5。言語環境
- 2610.06100: Agentic Language World Models — 1.5。言語環境
- 2610.06540: WaveGSSM (graph の state space model) — 1.5
- 2610.06039: MercerFlow (時系列 forecasting) — 1.5
- 2610.06250: レーザー melt pool の world model — 1.0。製造
- 2610.06008: 超音波 operator guidance — 1.0
- 2610.05865: Weave Mamba Fusion (顔検出) — 1.0

## sns_wildcard
- 2609.38879: Does Learning Protein Folding Generalize to Broader Reasoning? — 既出 (10-06 に採用済みブリーフあり)。HF daily papers 経由の再来で、dedup が wildcard 経路に要る例の 3 回目
- 2610.01780: RealCompanion (長期会話の benchmark; hf 263) — 注目度は高いが 3 トピックのどれにも学びが移らない。今日は探索枠を使わない
- 2610.05608: Kandinsky 6.0 Video (音声同期の動画生成 FM; hf 111) — 技術報告で、手法の学びが抽象度の高いレベルに留まる
