# 却下候補 — 2026-07-07

選別基準は topics.yaml の relevance_criteria。落とした理由を記録し、後で選別の妥当性を検証できるようにする。
本日候補 **3件**(すべて topic=sns_wildcard/EXPLORE)→ 選定 **1件**(2606.29526 MIPI/MIPU)、却下 **2件**。

- **fetch の状態変化**: 本日の candidates.json は、2026-07-05/06 に連続提示されていた重複3件(2607.02512 PAW / 2607.02255 AgenticSTS / 2607.02440 EvoPolicyGym)から **新規 ID 3件に入れ替わった**。[[fetch-duplicate-candidates]] の「前日と同一候補を再提示」懸念は今回は解消方向。
- **ただし部分的な再提示は残存**: 下記 2607.02501 (Embodied.cpp) は **2026-07-04 に 2/5 で却下済み**の候補が再び上がってきたもの。lookback_days=2 の窓を越えて過去却下分が混ざる余地があり、fetch の dedup は引き続き要観察。
- 探索枠(sns_wildcard)は **最大1件**。relevance でも hf_upvotes でも首位の MIPI/MIPU(3/5, hf 111)を採用。hf は副次シグナルだが、今回は relevance 首位と一致したためタイブレークは不要だった。

---

## wildcard(sns_wildcard)— EXPLORE 枠は最大1件、MIPI/MIPU を選定

- **2607.02461: OrbitQuant — Data-Agnostic Quantization for Image and Video Diffusion Transformers** — relevance 3/5(hf 23)。DiT (Diffusion Transformer; 画像・動画生成用の拡散モデルを transformer で構成したもの)の PTQ (Post-Training Quantization; 学習後にモデルを低ビット化して推論を軽くする手法)。従来 PTQ は活性値が timestep/prompt/guidance ごとに動くため checkpoint やモダリティごとに calibration データの再フィッティングが必要だった。OrbitQuant は **RPBH (Randomized Permuted Block-Hadamard) 回転**で各座標を入力によらず既知の固定分布に集中させ、単一の Lloyd-Max codebook を全 timestep/prompt/層で共有する **data-agnostic** な量子化を実現。回転は重み側に吸収して線形層内で相殺させ、推論時は活性への前段回転だけ残す。FLUX.1/Z-Image-Turbo/Wan 2.1/CogVideoX で低ビット PTQ の SOTA、画像 DiT を W2A4(重み2bit/活性4bit)まで実用画質で押し下げた。**P2 の "model compression" キーワードに直接掛かり手法も上質**だが、対象が画像・動画 **生成** DiT であり、自社の FM 蒸留/適合(P2 の本題)からドメイン距離が大きい。「calibration-free で回転により分布を既知化する」発想は将来の量子化メモとして保留し、探索枠1件は P2 全体に効く一般原理を持つ MIPI/MIPU に譲った。

- **2607.02501: Embodied.cpp — A Portable Inference Runtime of Embodied AI Models on Heterogeneous Robots** — relevance 2/5(hf 34)。**2026-07-04 に既に 2/5 で却下済み**([../2026-07-04/rejected.md](../2026-07-04/rejected.md))。VLA (Vision-Language-Action; 視覚・言語入力から行動を直接出すモデル) と WAM (World-Action Model; 世界モデルと行動を統合したモデル) のエッジ推論を統一する C++ ランタイム。5 層(input adapters / sequence builders / backbone execution / head plugins / deployment adapters)に整理し、multi-rate 実行・latency-first の batch-1 融合推論を提供。pi0.5/HY-VLA で closed-loop 成功率 100%/91%、WAM ブロックのメモリを 312→88 MiB に削減。**展開工学(deployment engineering)としては実用的だが、新規アーキテクチャや学習手法の知見ではない**ため P3 の relevance が低い(前回判断を踏襲)。再提示された点のみ fetch の dedup メモに記録。

---

## 選定側との比較メモ(なぜ MIPI/MIPU を残したか)
OrbitQuant と MIPI/MIPU はどちらも P2 に掛かり relevance 3/5 で接戦。決め手は **一般化可能性**。OrbitQuant は手法として優れるが対象が画像・動画生成 DiT に閉じ、自社の FM 蒸留/適合(言語系・制御系)への移植は間接的。対して MIPI/MIPU の核心「**最適化しているオブジェクト(training engine の重み)と、実際に価値が出るオブジェクト(deploy 時の挙動)がズレていないか**」という問いは、蒸留・量子化・PEFT すべてに一般化し、P2 の複数タスクに横断的に効く。hf も MIPI/MIPU(111)> OrbitQuant(23)で副次シグナルも一致した。
