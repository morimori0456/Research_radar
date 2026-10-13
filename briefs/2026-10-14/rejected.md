# rejected 2026-10-14

候補は 3 件 (fetch 火曜夜分、全て sns_wildcard。本流トピックの候補は 0 件)。wildcard 枠は 1 件のため採用 1 件 (2609.39601)。
うち 2610.13527 と 2610.12572 は 10-13 の候補と同一 (重複再配信)。10-13 の判断をそのまま引き継ぐ。

- 2610.13527: S-Space: Exploring Spatial Workspace in Multimodal Language Models — MLLM 内部の空間表現 (座標が線形 subspace に符号化される) を解析する interpretability 研究 (score 2.5)。VLA の空間理解の診断として P3 に着想はあるが、解析が主で学習・設計の recipe が無い。abstract が末尾 (bottleneck の結論) で途切れている。10-13 に続き 2 回目の不採用。
- 2610.12572: DiffusionART: Efficient, Stable and Scalable Reinforcement of Diffusion Models — diffusion model を black-box reward で RL fine-tuning する手法 (HunyuanVideo-13B で GPU 時間 12 倍減を報告; score 2)。対象が画像・動画生成の reward 最適化で、蒸留や他ドメイン適合の recipe ではなく、P1/P3 への接点も薄い。10-13 に続き 2 回目の不採用。
