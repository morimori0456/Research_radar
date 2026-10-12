# rejected 2026-10-13

候補は 3 件 (fetch 月曜夜分、全て sns_wildcard。本流トピックの候補は 0 件)。wildcard 枠は 1 件のため採用 1 件 (2610.12772)。

- 2610.12572: DiffusionART: Efficient, Stable and Scalable Reinforcement of Diffusion Models — diffusion model を black-box reward で RL fine-tuning する手法 (HunyuanVideo-13B で GPU 時間 12 倍減を報告; score 2)。fine-tuning の効率化として P2 に近いが、対象が画像・動画生成の reward 最適化で、蒸留や他ドメイン適合の recipe ではない。P1/P3 への接点も薄い。同枠の Reflex を優先
- 2610.13527: S-Space: Exploring Spatial Workspace in Multimodal Language Models — MLLM 内部の空間表現 (座標が線形 subspace に符号化される) を解析する interpretability 研究 (score 2.5)。VLA の空間理解の診断として P3 に着想はあるが、解析が主で学習・設計の recipe が無い。abstract も末尾 (bottleneck の結論) が途切れている。次点
