# Rejected — 2026-07-24

候補 45 件中 5 件採用(P1×1・P2×2・P3×2)。以下 40 件は落選。🔶 = 惜しい次点。

## 重要:sns_wildcard は全滅(重複再提示)
本日の wildcard 3 件は **全て過去にブリーフ済みの再提示**で、探索枠として無価値。既知の [[fetch-duplicate-candidates]] 症状(arXiv 取得失敗の握り潰し + wildcard の dedup 欠如)が今日も再現。よって wildcard は 0 件採用。

- 2607.19191: ABot-World-0 — **2026-07-23 にブリーフ済み**(当時 hf=148、本日 up=199 で再浮上)。重複。
- 2607.17977: RynnBrain 1.1 — **2026-07-22 にブリーフ済み**。重複。
- 2607.17423: TimeLens2 — **2026-07-22 にブリーフ済み**。重複。

## fm_distill_finetune (P2) — 採用2、落選28
- 🔶 2607.20205: Statistical Inference for Rank Allocation in LoRA (StatLoRA) — LoRA の rank 割当を仮説検定 + p 値で行う PEFT recipe。強いが quota 上限で次点。hypernetwork 論文(scaling law + up=10)にタイブレークで譲った。
- 🔶 2607.20367: Variance-reduced Domain Adaptation using Paired Sampling (PSDA) — MMD/CORAL の高分散を paired sampling で抑える汎用 UDA。有望だが quota 次点。
- 🔶 2607.20301: The Blessing of Dimensionality (PortLLM) — LoRA patch の training-free な temporal portability を長期実証+理論。適合コスト削減で魅力だが quota 次点。
- 🔶 2607.20072: Factor-Informed Uncertainty Distillation (FIUD) — 不確実性を teacher(GBT)→student へ蒸留。着想は良いが gaze 推定に特化。
- 🔶 2607.19901: StrokeSeg2 — KD + Float16 量子化で 102M→0.84M(90% 省エネ)。実装的だが医療デプロイ特化。
- 🔶 2607.20116: RIM — cross-domain fine-tune + 凍結 DINOv2 から局所記述子を蒸留し backbone 2本目を排除。backbone 再利用は良いが UAV 測位 niche。
- 🔶 2607.20327: PyroDash — SLM が制御 token で LLM へ委譲する token-level 協調推論(GRPO)。コスト効率だが routing 寄りで蒸留核から外れる。
- 🔶 2607.19711: PSFT — 破損 point cloud に頑健な point-selection PEFT(凍結 backbone + prompt token)。堅牢 PEFT だが 3D corruption 特化。
- 🔶 2607.19765: Extending View Synthesis for Panoptic Seg — 凍結 view synthesis モデルでラベルを新視点へ伝播、微調整なしで転移。FM 再利用の着想は良いが 3D 特化。
- 🔶 2607.20027: Zero-Shot HRV Forecasting with TSFMs — time series 基盤モデルの zero-shot 転移(微調整なしでベースライン超え)。FM 転移の観点は面白いが wearable 医療 niche。
- 🔶 2607.19701: SafeGen — VLM ベース AD 向け safety-critical シナリオを goal-conditioned diffusion で生成。P1 評価に横断的に効くが、生成寄り + P2 quota 埋まりで見送り。
- 2607.20410: LKValues — スリランカの価値観 alignment。文化特化で汎用 recipe 性が薄い。
- 2607.20389: PercepCap — video captioning の perceive-describe(SFT+RL)。蒸留/適合の核でない。
- 2607.20385: Persian Pixel — ペルシャ語 OCR 合成データセット。分野 niche。
- 2607.20339: iPANN/fPANN — 力学 constitutive modeling の不確実性定量化。分野外。
- 2607.20284: RS-MLLM survey — remote sensing MLLM の survey/診断。汎用モデルの転移性の示唆はあるが survey。
- 2607.20194: OLEDLM — OLED 分子の逆設計 LM。分野外。
- 2607.20087: CMR cardiac AI — 心臓 MRI 診断の vision FM fine-tune。医療 niche。
- 2607.20057: AAMFM — 抗原特異的抗体設計の multimodal FM。分野外。
- 2607.20056: Arabic KG ABSA — アラビア語の暗黙 aspect 抽出。task adaptation が決定的という知見のみ、niche。
- 2607.19994: Sentinel-2 Building Detection — 季節別 fine-tune ガイドライン。運用 niche。
- 2607.19992: tiny_schiller — ドイツ語戯曲コーパス配布。手法性なし。
- 2607.19889: LAViFiT — 手術 instrument-tissue 認識の vision fine-tuning。niche。
- 2607.19880: EA-Nav — cross-embodiment navigation(模倣学習 + embodiment 幾何)。P3 寄りだが embodiment 特化。
- 2607.19864: PRISM-DR — 網膜病変の per-lesion 検出。医療 niche。
- 2607.19816: Hypothesis-and-Refinement — 分光→分子構造の逆問題。化学 niche。
- 2607.19777: LB-Edit — 3DGS 編集のカメラ配置 + multi-view 整合。分野外。
- 2607.19744: Domain-Adapted Power Curve — 風力 cross-farm の domain adaptation。分野外。

## next_arch (P3) — 採用2、落選9
- 🔶 2607.19719: Koopman Dreamer — Koopman 由来の spectrally-constrained latent dynamics で長ホライズン rollout を安定化、誤差上界も導出。world model アーキとして強く、採用の KineBench と僅差の次点(評価 vs 構造で KineBench の横断性を優先)。
- 🔶 2607.20345: DEED (Retail Humanoids VLA) — GR00T VLA を単一 GPU で data-efficient post-training。「lab→store は構造でなく systems 統合問題」という主張は実務的だが、新規アーキ着想は薄め。
- 🔶 2607.20061: ReferTrack — VLA の抽象 CoT を明示的 bbox 検出に接地する referring-then-tracking。設計着想は良いが embodied tracking 特化。
- 🔶 2607.19695: NavVerse — indoor→outdoor 連続 navigation ベンチ。VLA/RL/modular の zero-shot 比較は有用だが navigation 特化。
- 2607.20228: User-Centric Transactional SSM — Mamba(選択的 SSM)+ CoLES で取引系列モデル化。SSM 応用だが金融取引 domain。
- 2607.20152: Active Inference as Convex MDP — 期待自由エネルギー最小化を convex MDP に定式化。理論的で応用は遠い。
- 2607.19809: Dreamer-CPC — world model 上の分散 MARL 通信学習。MARL niche。
- 2607.19787: CV-SSMNet — PolSAR 分類の複素 SSM + 散乱事前。remote sensing 特化。
- 2607.19633: LENS — LLM でクラッタ環境を抽象化して planning/control 支援。着想は面白いが manipulation 特化。

## planner_ai (P1)
候補 1 件のみで採用済み。落選なし。
