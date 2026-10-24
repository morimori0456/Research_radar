# rejected 2026-10-25

採用 2 本 (P2 のみ、いずれも arXiv RSS cs.CL から回収) 以外の記録。評価は topics.yaml の relevance_criteria に沿った 0-5 点。すべて abstract に基づく。

## sns_wildcard (candidates 3 件、全て不採用)

- 2610.28402: StreamEval: Evaluating Interactive Streaming Video Generation Models — 10-23・10-24 に続く 3 回目の再来 (hf 439)。avatar / 編集中心で、運転の world model との接点は薄い (評価 2.5)
- 2610.21114: Spectral-Spatial Interpretation — multispectral 画像の Shapley 値による attribution (hf 411)。手法は明快だが、planner / 蒸留 / world model のどれにも直接使えない (評価 1.5)
- 2610.31329: WeVisOne-VL: Unified Visual Perception from Objects to Pixels — 10-24 に見送り済みの再来 (hf 231)。VLM の検出・segmentation 統合の技術報告 (評価 2.0)

## RSS (cs.CL, 2026-10-24 04:00Z build) の次点

- 2610.31017: Mostly Reading: What Open-Book Scores Measure in Document-Level LoRA Adapters — 文書ごとの LoRA の open-book 評価は、adapter が知識を持つ効果でなく「読む行動」を測っているという指摘。LoRA を merge する評価の落とし穴として有益だが、対象が文書 QA (評価 3.0、HERD と同点で蒸留の keyword 一致を優先)
- 2610.30934: Verbalizing Activation Differences with Natural Language Autoencoders — fine-tuning 前後の activation 差を言語で説明する解釈手法。recipe ではない (評価 2.0)
- 2610.30379: MemPlan: Memory-Conditioned PDDL Planning for Partially Observable Text Environments — テキスト環境の task planning で、自動運転の planner と別物 (評価 1.0)
- 2610.30841: TRIAD: Benchmarking Omni-Modal Ambiguity in Multimodal Large Language Models — benchmark だが運転の評価ではない (評価 1.0)
- 2610.30663: Group Relative Policy Optimisation Improves Multilingual Speech Recognition in Low-Resource Languages — GRPO を ASR に適用した報告 (評価 1.5)

## その他

- cs.CL の残り (new / cross の keyword 非一致、および 10-24 までのブリーフ・rejected に既出の 2610.31135・2610.31397・2610.31415・2610.31586・2610.31646・2610.30880) は走査のみで個別に採点せず。
- planner_ai / next_arch の候補は candidates.json に 0 件。cs.LG / cs.RO / cs.AI / cs.CV の RSS は 0 件 (土曜 build)。
