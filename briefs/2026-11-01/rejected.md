# rejected 2026-11-01

採用 6 本 (P1 1 / P2 3 / P3 2。うち sns_wildcard 1) 以外の記録。candidates.json は 3 件 (generated_at 2026-10-31T18:00Z) で、**3 件とも sns_wildcard、planner_ai / fm_distill_finetune / next_arch は 0 件**。評価は topics.yaml の relevance_criteria に沿った 0-5 点で、すべて abstract に基づく。

## sns_wildcard (3 件中 2 件)

- 2610.32749: Efficient Streaming Audio-Visual Target Speaker Extraction for Real-World Acoustic Scenes — Falcon / RealSSA。音声の話者分離で、edge 向けの軽量化と speaker contrastive loss (推論 cost なしの学習時 loss) は参考になるが、追っている 3 プロジェクトのどれにも接点がない (評価 2.0, hf 251)
- 2610.39301: Youtu-Parsing-Omni: One Encoder, One Schema, All Modalities — 文書・画像・音声・動画を 1 つの encoder で構造化出力する parser。OSAD (on-policy distillation を自分の rollout と参照つきの自分のコピーで回す) は P2 に近いが、中心は document parsing で、検証も parsing benchmark に限る (評価 3.0, hf 163)。wildcard は 1 件までなので 2610.39633 を優先した

## 本流 (candidates.json に 0 件)

土曜 18:00Z の fetch で、3 トピックとも該当なし。fetch の log は確認していないが、土曜夜の fetch は通常 0 件になる (announce が月曜 00:00Z まで出ない機構。09-13 に確定済み)。RSS は cs.LG / cs.CL / cs.CV / cs.RO が 0 件、cs.AI だけが 605 件 (lastBuildDate 2026-10-31 04:00Z)。この cs.AI の keyword 一致 176 件のうち、過去のブリーフに無い 148 件はすべて 10-31 に走査した 386 件の部分集合で、**新規の論文は 0 件**。したがって喪失は 0。

## 10-31 の次点から繰り越して採用 (5 本)

10-31 の rejected.md 「RSS の次点」「planner_ai」「next_arch」にあった 4.0 / 3.5 の論文を、本流が空の日に採用した。abstract は arXiv API で取得した。

- 採用: 2610.40091 (P2 4.0)、2610.40271 (P2 4.0)、2610.38661 (P3 4.0)、2610.39543 (P3 4.0)、2610.39958 (P1 3.5)

## 今日 abstract を確認した RSS の未採用 (cs.AI)

- 2610.38356: Encode Once, Answer Many: Internalizing Context via Parametric Flow — CLIK。context から LoRA の重みを 1 回の forward で生成する hypernetwork。他ドメイン適合の発想は面白いが、対象は LLM の知識注入で、P2 の主題 (蒸留と適合の recipe) からやや外れる (評価 3.5)
- 2610.39876: Turing LLM Post-Training: Calibrated Distillation and Efficient Dynamic-MoE Execution — C-MOPD。複数の teacher を top-K 支持集合で合わせる multi-teacher on-policy distillation。specialist の統合という主題は P2 に近いが、MoE の LLM の実行基盤の話が大きい (評価 3.5)
- 2610.38637: On-Policy Self-Distillation with Teacher Evolution — TESD。自分自身を teacher にする蒸留の teacher を reward で更新し、信頼できない guidance を down-weight する。LLM の reasoning 限定 (評価 3.5)
- 2610.38657: Explore Where It Matters: Targeted Exploration for Efficient Rover Adaptation — TERRA。sim-to-real の world model を、reward に効く誤差の場所を予測して探索しながら適合させる。月面探査 rover で、運転への移植は遠い (評価 3.0)
- 2610.39100: Generating Critic-Guided Synthetic Experience in Latent World Models — CGSE。world model で作る合成経験の action を critic で精製する。offline RL の話で運転の対象は無い (評価 3.0)
- 2610.38095: Nemotron 3.5 Super and Lightning — Mamba-Transformer の hybrid MoE の技術報告。multi-teacher on-policy distillation を含むが、abstract に recipe の詳細が無い (評価 3.0)
- 2610.38391: SCOPE: Selective Critical-Step On-Policy Self-Distillation for Agentic Reinforcement Learning — LLM agent の誤った step だけに自己蒸留を掛ける。ALFWorld と WebShop のみ (評価 3.0)
- 2610.37680: Artifact Distillation: Training-Free Transfer from Frontier to Small Language Models — 勾配更新なしで teacher の解法を bank に外在化する。蒸留という名前だが推論時の retrieval で、蒸留 recipe ではない (評価 2.5)
- 2610.39455: Sparse Fine-Tuning for Parameter-Efficient Adversarial Training — 敵対的訓練で robustness に効く少数のパラメータだけを更新する。PEFT の知見はあるが、主題は adversarial robustness (評価 2.5)
- 2610.38088: What Can Firms Do in the Face of Model Distillation? — 蒸留を経済理論で扱う。技術的な recipe ではない (評価 0.5)

## その他

10-31 の「RSS の次点」のうち、上記で採用していない分 (2610.40576 PIVOT、2610.38383 teacher bridge の否定的結果、2610.38160 ATI-OPD 等) は、10-31 の評価 (3.0〜3.5) を変更せず、今日も見送った。
