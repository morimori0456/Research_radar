# 却下候補 — 2026-07-02

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。

- **2607.00972v1: Bayesian Uncertainty Propagation for Agentic RAG Pipelines** — score 1/5。planner_ai にタグされているが "planner/evaluator" は LLM の Agentic RAG パイプラインの意味で、自動運転のモーションプランナーとは無関係。不確実性伝播の評価指標(AUROC/ECE)は面白いが対象ドメインがズレており、P1の relevance_criteria(AV実装・評価に直接使える)を満たさない。
- **2607.00326v1: NeHMO — Neural HJ Reachability for Decentralized Safe Multi-Arm Motion Planning** — score 2/5。安全モーションプランニングでHJ reachabilityの安全価値関数は技術的に興味深いが、対象がマルチアーム・マニピュレータでAV文脈への適合度が低い。P1 quota(2)は 00776/00444 で埋まっており、限界効用が低いため却下。
- **2607.00784v1: LeVLJEPA — End-to-End Vision-Language Pretraining Without Negatives** — score 2/5。stop-gradient targetを使う非対照的手法だが、これは蒸留ではなく事前学習。P2の relevance_criteria(蒸留プロセスの実務適用・recipe/新loss/capacity gap対策)に直接は該当しない。
- **2607.00377v1: SAOT — Self-Supervised Continual Graph Learning with Structure-Aware OT** — score 2/5。cross-task knowledge distillationを補助的に使うが本体は継続グラフ学習。グラフドメインでP2の蒸留recipeとしての転用価値が薄い。
- **2606.31781v1: SpikeLogBERT — Energy-Efficient Log Parsing Using Spiking Transformer Networks** — score 2/5。BERT教師→spiking生徒の蒸留自体は新規だが、log parsing + spiking HW という極めてニッチな設定。自社の一般的なFM蒸留recipeへの一般化余地が乏しく、quota内の限界効用が低いため却下。
