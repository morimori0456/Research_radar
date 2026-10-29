# rejected 2026-10-30

採用 4 本 (P2 2 / P3 2、すべて arXiv RSS から回収) 以外の記録。candidates.json は sns_wildcard 3 件だけで本流は 0 件 (generated_at 2026-10-29T18:00Z)。評価は topics.yaml の relevance_criteria に沿った 0-5 点で、すべて abstract に基づく。P1 (planner_ai) は該当なしで採用 0。

## sns_wildcard (3 件、全件不採用)

- 2610.34283: ChronoReplay: One Answer Interface Is Not Enough for Streaming Spatial Intelligence (hf 399) — 10-29 に見送り済み (hf 315) の再来。spatial VLM の post-training が回答形式に偏る問題で、運転の評価・蒸留・world model との接点は薄い (評価 2.0)
- 2610.36077: The Trinity: Capability-Driven Recursive Self-Improvement for Multimodal Agents (hf 384) — 10-29 に見送り済みの再来。環境と harness (agent の足場) を自動で作る agent 基盤の話 (評価 1.5)
- 2610.35013: Multiscale Policy Optimization for Long-Horizon LLM Agents (hf 379) — 新規。LLM agent の RL で、critic の値が turn 間で大きく変わることを根拠に、turn 単位の advantage と token 単位の credit を組み合わせる (MPO; Multiscale Policy Optimization)。credit assignment の工夫として読めるが、対象は LLM の tool-use で、P1-P3 に移せる形が見えない (評価 2.0)

## RSS (cs.AI, 2026-10-29 04:00Z build) の次点

- 2610.36247: Freeze, Don't Clone: Fine-Tuning with Expressive Policies Without Retaining Offline Data — offline-to-online RL (offline データで事前学習した policy を online で fine-tune する) で、offline データを手放した後に behavioral cloning (BC; 行動の模倣) を続けると事前学習した prior が消える、という失敗を指摘し、prior を凍結して価値学習だけで改善する。imitation で事前学習した driving policy を closed-loop の RL で fine-tune する場面に近く、P3 では最も惜しかった (評価 3.5)。P3 の枠 2 本は world model 側 (MoGAP と Dwell) を優先して見送り。次に fine-tuning の安定性を調べる日に読む
- 2610.36617: Balanced State Subspaces for Mamba-2 State Compression — Mamba-2 (state space model の一種で、文脈を固定サイズの再帰的な状態に圧縮する) の状態を、座標ごとでなく write-read の部分空間で圧縮し、層ごとに rank を配分する post-training の手法。state space model と compression の両方に触れるが、対象は LLM の decoding memory で、運転 model には直接つながらない (評価 3.5)
- 2610.37547: When, Where, and What to Correct: Human-Guided Adaptive Residual Correction for Robot Policies (ARC) — 凍結した policy の上に、人の sparse な修正で探索を絞った residual を RL で学ぶ。10-29 の GRAFT (2610.36507) と近い「凍結 + 小さな補正」の構造だが、対象は manipulation の last-mile 精度 (評価 3.0)
- 2610.36386: LoRA on a Budget: Function-Aware Post-Hoc Compression for Adapter Fleets — 多数の LoRA adapter を共通の rank 予算で圧縮する配分問題 (FRA; Functional Rank Allocation)。PEFT (Parameter-Efficient Fine-Tuning; 少数の追加パラメータだけを学習する適合) の運用側の話で、多機種に adapter を持つ場合に効くが、適合の recipe そのものではない (評価 3.0)
- 2610.37110: A First-Step Bias Restores Lost Diversity in Diffusion Model Distillation — 蒸留した few-step の画像生成 model で出力の多様性が落ちるのは最初の denoising step が原因と突き止め、そこだけに 0.002% の追加パラメータの adapter を足す (ReSeed)。蒸留の診断として面白いが、対象は text-to-image/video (評価 3.0)
- 2610.36082: How Much Does the Hint Matter? Scope Conditions for Hindsight Self-Distillation in Financial Reasoning — 失敗した最初の step の critique を hint にして自己蒸留する recipe (Fin-SD)。10-29 の Live-OPSD (2610.36959; privileged hint 付きの自己蒸留) と同系統で、対象は金融の推論 (評価 3.0)
- 2610.37019: V-LUMEN: Visual Lookup Memory for Embedding Scaling in Vision-Language Models — 凍結した VLM に、非パラメトリックな lookup 型の visual memory を足して容量を増やす。LoRA の容量の一部を置き換えても精度が保たれる、という観察が P2 に近いが、適合の recipe ではない (評価 3.0)
- 2610.37281: RPSD: Retrieval-Privileged On-Policy Self-Distillation with Optimal Transport — 系列推薦 (ユーザーの次の行動の予測) の RL で、privileged knowledge を持つ teacher が student の token ごとの confidence 差から credit を割り当てる。self-distillation の credit 設計は参考になるが、対象は推薦 (評価 2.5)
- 2610.36009: DuplexTune: Coupled-State Replay for Memory-Efficient Mixture-of-Experts Adaptation — MoE (Mixture-of-Experts; 入力ごとに一部の専門 network だけを使う構造) の LLM を fine-tune するときの memory を、checkpointing 付きの SFT の 64.8 GB から 38.8 GB に減らす。適合の効率化だが、LLM の MoE に特化 (評価 2.5)
- 2610.36493: AC-JEPA: Anchored Cross-Modal Joint Embedding Predictive Architecture for Visual-to-Symbolic Translation — 化学構造の画像認識 (OCSR) で、不完全な pseudo-label に強い JEPA (Joint Embedding Predictive Architecture; 潜在表現を予測して学ぶ) の補助 loss。noisy label に強い補助 loss という点は参考になるが、対象が化学 (評価 1.5)
- 2610.36425: Repulsive Population Policy Gradients for Behaviorally Diverse Reinforcement Learning (RePPO) — 多様な policy の集団を PPO で学ぶ quality-diversity RL。運転の多様性とは目的が異なる (評価 1.5)
- 2610.36544: Monitor Accuracy Isn't the Answer: A Decision-Value Framework for Evaluating AI Agent Restart Monitors — monitor の精度でなく、restart の判断としての価値で評価する枠組み。評価の視点は 10-29 の SRP (失敗予告) に通じるが、対象は AI agent の再起動 (評価 1.5)
- 2610.35989: Layerwise Repacking: Variable-Length Hybrid-Attention Training without an Extra Redistribution Pass — 長さが不揃いな sample の hybrid attention 学習の並列化。大規模 LLM の学習 infra (評価 1.0)
- 2610.35982: Generation and Verification: Human-Agent Collaboration for Safety-Critical Automotive Software Engineering — 車載ソフトの開発工程の話で、planner 実装・評価ではない (評価 1.0)

## その他

- RSS cs.AI の残り (keyword 一致 51 件のうち上記以外の約 33 件) は題名と冒頭を走査のみ。RAG、推薦、化学・天文・量子など分野外が大半で個別には採点していない。
- RSS の cs.LG / cs.CL / cs.CV / cs.RO は今回 0 件 (lastBuildDate は 5 本とも 2026-10-29 04:00Z)。cs.AI だけが 407 件。
- planner_ai / fm_distill_finetune / next_arch の candidates は 0 件。
