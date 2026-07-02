# 却下候補 — 2026-07-03

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。

- **2607.00972v1: Bayesian Uncertainty Propagation for Agentic RAG Pipelines** — score 1/5。planner_ai にタグされているが、ここでの "planner/evaluator/generator" は LLM の Agentic RAG パイプラインの段を指し、自動運転のモーションプランナーとは無関係。Bayesian Network による不確実性伝播とキャリブレーション指標(AUROC/AUARC/ECE/Brier)は着想として面白いが、対象ドメイン(offshore wind の意思決定支援を想定)がP1の relevance_criteria(AV実装・評価に直接使える)から外れる。
- **2607.00326v1: NeHMO — Neural HJ Reachability for Decentralized Safe Multi-Arm Motion Planning** — score 2/5。学習したHJ reachability安全価値関数で最悪ケースのアーム間安全制約を捉える発想は技術的に良質だが、対象がマルチアーム・マニピュレータでAV文脈への適合度が低い。P1 quota(2)は 00776/00444 で埋まり、限界効用が低いため却下。安全価値関数の学習という筋は将来 topics 見直し時に別トピック化の候補。
- **2607.00784v1: LeVLJEPA — End-to-End Vision-Language Pretraining Without Negatives** — score 2/5。stop-gradient target とper-modality正則化による非対照的な大規模事前学習で、frozen backbone としての密特徴が強いのは魅力。ただし本体は**蒸留でなく事前学習**であり、P2の relevance_criteria(蒸留プロセスの実務適用・recipe/新loss/capacity gap対策)に直接該当しない。教師特徴源として 00514 の teacher 側に将来使える可能性はメモ。
- **2607.00377v1: SAOT — Self-Supervised Continual Graph Learning with Structure-Aware OT** — score 2/5。cross-task knowledge distillation を補助的に用いるが、本体は最適輸送で関係構造を保持する継続グラフ学習。グラフドメイン特化で、自社の一般的なFM蒸留recipeへの転用価値が薄いため却下。
