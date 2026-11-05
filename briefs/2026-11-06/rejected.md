# rejected 2026-11-06

採用 6 本 (P1 2 / P2 2 / P3 2) 以外の記録。candidates.json は 50 件 (generated_at 2026-11-05T18:00Z)。評価は topics.yaml の relevance_criteria による 0-5 点で、**abstract のみに基づく**。

## 採用 (6 本)

2611.06453 (P1 5.0) / 2611.06710 (P1 4.0) / 2611.06486 (P2 4.0) / 2611.05811 (P2 4.0) / 2611.06918 (P3 4.5) / 2611.06901 (P3 4.5)。

- 2611.06453 と 2611.06918 は candidates.json では fm_distill_finetune に分類されていたが、前者は運転の評価指標として P1、後者は VLA 構造として P3 に置いた。2611.06710 は next_arch から P1 (Thor での VLA 推論) に移した。
- sns_wildcard 3 件は **昨日と同じ 3 件** (2611.00859 / 2611.01860 / 2611.03178)。最高 2.5 で、今日も採用なし。

## 持ち越せる次点 (評価 3.5 以上)

- 2611.05847: Time-to-Goal: Learned Temporal Metrics for Long-Horizon Planning with JEPA World Models — [3.5→4.0 次点] JEPA world model の planning cost を time-to-goal の ranking loss で学習し直す。AntMaze と FourRoom の小規模検証で運転の接点が弱いが、P3 で 06901 と同じ LeWM 系。quota 超過で持ち越し
- 2611.06447: $A^3$-VLA: Automatic Perception-Guided Attention Alignment for Robot Manipulation — [4.0 次点] VLA の attention を、操作の中の視覚変化から自動生成した領域に揃える loss。P3 の学習改善で有望だが manipulation 限定。quota 超過で持ち越し
- 2611.06007: MotoVerse: A Benchmark for Predictive Perception of Motorized Two-Wheelers in Dense Unstructured Traffic — [3.5 次点] two-wheeler 視点の maneuver 予測 benchmark。P1 の trajectory prediction 評価に近いが、自車が二輪で、4 輪 planner への転用が弱い
- 2611.06598: The Behavioral Rate of Fine-Tuning: Compression as a Measure of Useful Information — [3.5 次点] LoRA の「必要な bit 数」を behavioral rate として測る。P2 に関連するが、手法でなく測定の枠組み
- 2611.06476: The Alignment Tax Is Graded: Task-Selective Capability Loss Under Length-Normalized DPO with SFT Retention — [3.5 次点] DPO で margin が増えたときの能力低下が task 選択的であることの実証。新手法なし、金融文書 task に限定。昨日の AEGIS と同系統
- 2611.06302: Beyond Scene Shortcuts: Action-Centric Video-Text Alignment for Fine-Grained Action Understanding — [3.5 次点] fine-tuning で scene shortcut に頼る幻覚 (EGAH) を GRPO の attention reward で抑える。video 理解で運転への接点は間接的
- 2611.05567: MESA: An Evaluation Framework for Compositional, Semantic, and Spatial Generalization in Robotics — [3.5 次点] manipulation 政策の汎化を 4 軸に分けて測る benchmark (MESA)。評価設計の参考になるが対象が P1 の運転ではない

## 不採用

- 2611.06353: Traffic-VL: Reinforced Vision-Language Models for Generalizable End-to-End Traffic Signal Control — planner_ai だが対象は交差点の信号制御で、自動運転 planner ではない (VLM を RL で動かす recipe は参考程度)。
- 2611.06876: SpecCompact: Accelerating LLM Agent Context Compaction with Slot-Parallel Semantic Speculative Verification — LLM agent の context 圧縮の高速化。P2 の蒸留・適合と無関係 (1.5)。
- 2611.06849: Trainspotting: Learning Object-Centric 3D Reconstruction from Found Photos — 野外写真からの物体中心 3D 再構成。P3 の対象外 (1.5)。
- 2611.06829: Enabling AWS Cloud FPGA Development Using High-Level Vitis HLS — FPGA 開発環境の話 (0.5)。
- 2611.06789: Ranking Agreement Does Not Reveal Paragraph-Edit Agreement in Two Released Paper Acceptance Predictors — 論文の採否予測器の評価の分析 (0.5)。
- 2611.06724: Dexterous Robotic Hands in the Foundation-Model Era: A Full-Stack Survey of Hardware, Data, Cross-Embodiment Transfer, Learning, and Evaluation — dexterous hand の survey。cross-embodiment の章は P2 の観点に触れるが、manipulation ハードが中心 (2.0)。
- 2611.06706: ALTO: African and Levantine Tech-Facilitated Gender-Based Violence Corpus — gender-based violence の言語 corpus (0.5)。
- 2611.06517: Dialect Matters: A Dialect-Aware Baseline for Igala-English Machine Translation — Igala-English 機械翻訳 (1.0)。
- 2611.06452: Within-Family EfficientNet Scaling under Fixed-Resolution Transfer Learning for Spectral-Domain Optical Coherence Tomography Retinal Disease Classification — 網膜 OCT 画像分類での EfficientNet scaling。転用できる知見が薄い (1.5)。
- 2611.06371: Training-Free Character-Length Control in Summarization with Diffusion Language Models — diffusion LM の文字数制御 (1.0)。
- 2611.06356: EEGDash Corpus: A Training-Ready Public Corpus for EEG Foundation Models — EEG foundation model 用の corpus (1.0)。
- 2611.06194: Cross-Asset Knowledge Transfer for Early Fault Detection of Data-Scarce Assets Without Target Fault Data — 産業設備の zero-shot domain adaptation (ADANN)。手法は古典的 (domain-adversarial + MMD) で、FM との接点が薄い (2.5)。
- 2611.06170: AssameseLM-E2B: An Open-Weight Assamese Language Model for Efficient Consumer-Grade Deployment — Assamese の小型言語 model (1.5)。
- 2611.06123: From Handcrafted to Generative: RLVR-Optimized Icon Generation for Alexa+ — Alexa+ の icon 生成を RLVR で最適化 (1.5)。
- 2611.06096: Many Pixels, One Composition: Self-Supervised Spectra for Specimen-Level Prediction — 標本レベル予測のための自己教師あり spectra (1.0)。
- 2611.06090: Overview of the NTCIR-19 SciClaimEval Task: Cross-modal Claim Verification in Scientific Papers — NTCIR-19 の task overview (1.0)。
- 2611.06066: PRISM-AMC: Replay-Free Continual Learning for Automatic Modulation Classification — 変調方式分類の replay 無し continual learning。continual learning は P2 の周辺だが信号分類に限定 (2.0)。
- 2611.06062: Adapting Qwen3 to Tajik from 0.6B to 8B: Lower Text Loss Did Not Mean Better Understanding — Qwen3 の Tajik 適合で、text loss の低下が理解の改善と一致しなかった報告。適合の評価の注意点として興味深いが、言語固有で規模が小さい (2.5)。
- 2611.06000: Intra-Architecture Source Attribution for Stable Diffusion: A New Task with Benchmark Dataset and Baseline — Stable Diffusion の出処判別 benchmark (1.0)。
- 2611.05974: PathoS2VD: From 2D Histopathology to Pseudo Z-Stack Representations — 病理画像の疑似 Z-stack (0.5)。
- 2611.05901: Retrieval Supersedes Scale: Efficient Log Level Prediction via Multiplex Socio-Technical Context — ログレベル予測 (0.5)。
- 2611.05892: When Is One Query per Template Enough? Adapting Learned Cost Models to New Hardware — learned cost model を新しいハードに適合させる。少数サンプルでの適合という発想は P2 に近いが、DB の runtime 予測に限定 (2.5)。
- 2611.05744: Text-Only Domain Adaptation for Low-Resource Medical ASR: Shallow Fusion and Density Ratio Rescoring for Hausa — Hausa の医療 ASR への text-only 適合 (2.0)。
- 2611.05734: Mitigating Spurious Invariance in Contrastive Learning: A Probabilistic Self-Supervised Learning Framework for Medical Image Analysis — 医療画像の contrastive learning の spurious invariance (2.0)。
- 2611.06652: Dynamical State-Space Diffusion for Spatiotemporal Prediction — state-space model を拡散の corruption に使う時空間予測。P3 の SSM 語彙に当たるが天気・流体系の予測で運転に接点が薄い (3.0)。
- 2611.06544: MKD2World: A Typed Spatial MarkDown World Model For Web Agents — web agent 用の Markdown world model (1.0)。
- 2611.06475: Robocasa-Mem: Benchmarking Environment and Process Memory in Long-Horizon Mobile Manipulation — mobile manipulation の memory benchmark (2.5)。
- 2611.06184: Can Astra Solve RoboMME without Breaking the Bank? — RoboMME の費用対効果の報告 (2.0)。
- 2611.06120: ReactWorld: Structuring Interaction Responses for Embodied Video Generation — embodied video 生成の interaction response 構造化 (2.5)。
- 2611.06061: TouchéWorld tech report : Towards Online Unified Camera--Hand Exploration in Generative Worlds — 生成 world の camera と hand の探索 tech report (2.0)。
- 2611.05907: Does Your Trial Simulator Know What the Drug Does? An Intervention-Blind Test of Interventional Validity on 7,207 Registered Trials — 臨床試験 simulator の intervention 妥当性検定 (1.0)。
- 2611.05667: Correct Robots Before They Make Mistakes: Proactive Human-in-the-Loop Intervention via Preference Learning — preference learning による robot の proactive 介入 (2.5)。
- 2611.05577: Readable Is Not Steerable: Pre-Registered Tests of Physical Structure in Learned Fluid Representations — 流体表現が steerable かの事前登録検定 (1.5)。
- 2611.05372: PolicyIK: High-Precision Inverse Kinematics for Robot Arms with Reinforcement Learning — robot arm の IK を RL で解く (2.0)。
- 2611.01860: Advances in Agentic Computer Graphics — agentic computer graphics の survey。昨日も見送り済みで再来 (wildcard, 2.0)。
- 2611.00859: Wave Forcing: Towards Speed-of-Light Streaming Video Generation — streaming video 生成の pipeline 設計 (Wave Forcing)。昨日・一昨日も見送り済みで再来 (wildcard, 2.5)。
- 2611.03178: CoworkOS:Scaling Agent Coworkers for Real-world Automation — computer-use agent の自動化基盤 (wildcard, 1.5)。
