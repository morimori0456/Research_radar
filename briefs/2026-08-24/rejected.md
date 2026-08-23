# 2026-08-24 不採用の候補

本日の候補は **3 件すべてが sns_wildcard**。本流 3 トピック (planner_ai / fm_distill_finetune / next_arch) は **0 件**だった。
wildcard は規定により最大 1 件しか採れないため、**構造的に 2 件が落ちる**。以下の理由は、その制約下でのものである。

## 不採用

- **2608.19880: EnvHarness: Awakening Static Worlds for Agent Learning** — **重複。08-22 に wildcard 枠で採用しブリーフ作成済み** ([brief](../2026-08-22/2608.19880.md))、08-23 にも重複として不採用にした。**同一論文の 3 回目の提示。**hf_upvotes が 245 → 254 に増えただけで内容は同一。論文の質の問題ではなく、**欠陥#2 (wildcard の dedup 欠如) による再提示で、7 日連続。**

- **2608.20335: 4DAnyone: Create Anyone in 4D from a Casual Monocular Video** — relevance **2.5**。単眼動画から 4D の人物を再構成する研究 (4DGS = 4D Gaussian Splatting; 3D 点群をガウス分布で表して時間軸も持たせる、動く被写体の描画表現)。**落とした理由は 2 つ。**(1) P1/P2/P3 のどの relevance_criteria にも直接当たらない — planner の評価手法でも、蒸留/適合の recipe でも、driving policy のアーキテクチャでもない。(2) wildcard 枠は 1 件で、[FACET](2608.18580.md) (relevance 3.5) が上回った。hf_upvotes も 68 < 114 で同方向、タイブレークの出番はなかった。

  **ただし完全な捨て札ではない、と記しておく。**本論文の中身は 2 つに割れる。**応用側** (単眼動画から人物の 4D アセットを作る) は、**closed-loop sensor simulation に VRU (Vulnerable Road User; 歩行者や自転車など保護対象の交通参加者) のアセットを増やす**経路になりうる。**手法側**の Reference Context Packing (参照文脈を固定長に圧縮して O(N) → O(1) にする) と Target Context Routing (denoising の途中で生成対象のグループ分けを回して群間で文脈を共有する) は、**1 回の forward pass に収まらない量を生成するときの文脈設計**という一般問題への答えで、next_arch の関心と地続きである。**次に「生成モデルで sensor sim を作る」話が本流トピックに出てきたら、この 2 つの機構を思い出す価値がある。** 今日落とすのは枠の問題であって、質の問題ではない。

## 本日の候補一覧と公開日 (lookback_days:2 の逸脱を記録)

| id | 公開日 | 実行時点 (08-23 18:00Z) からの経過 | lookback_days:2 内か |
|---|---|---|---|
| 2608.20335 | 2026-08-19 | 4 日 | ❌ 超過 |
| 2608.19880 | 2026-08-19 | 4 日 | ❌ 超過 |
| 2608.18580 | 2026-08-18 | 5 日 | ❌ 超過 |

**3 件とも lookback_days:2 の範囲外。**これは偶然ではなく、wildcard 経路 (HF Daily Papers) に **cutoff 判定が一切かかっていない**ためである (`fetch_candidates.py` の `main()` で、wildcard 候補は `parse_entries` を通らず cutoff 比較なしに `candidates` へ追加される)。**欠陥#3 として確定。**
