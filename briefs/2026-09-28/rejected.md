# 2026-09-28 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **0 件** / 不採用 **3 件**。

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch 0/2 ・ sns_wildcard 0/1。**上限 6 に対し 0。**

wildcard 3 件のうち **2 件は既にブリーフがある** (09-26 と 09-27)。新規は 2609.30221 の 1 件だけで、これも基準に届かなかった。

---

## 不採用の候補

- 2609.28654: Training Object Permanence in World Models — **09-26 に next_arch で採用し、ブリーフ作成済み (重複・3 日連続の再配信)。**→ [briefs/2026-09-26/2609.28654.md](../2026-09-26/2609.28654.md)。hf_upvotes は 201 で、3 件中最高。
- 2609.29845: Your Transformer Can Hold Two Thoughts at Once: Evidence of Linear Superposition in LLMs — **09-27 に sns_wildcard で採用し、ブリーフ作成済み (重複)。**→ [briefs/2026-09-27/2609.29845.md](../2026-09-27/2609.29845.md)。hf_upvotes は 75。
- 2609.30221: WanPE: Towards Cinematic Prompt Enhancement for Modern Text-to-Video Generation — **新規だが、持ち帰れる教訓が 1 段落に収まるため不採用。スコアは P1 1.5 / P2 1.0 / P3 1.5 (hf_upvotes 36)。**397B の prompt enhancement model (ユーザーの短い指示を、カメラの動き・照明・音まで書いた長い撮影台本に書き直すモデル) で、text-to-video 生成の前段に置く。P1〜P3 に効く部分は次の 1 点だけである。
  - **reverse construction (実物の動画から逆向きに台本を起こし、それを学習の正解にする作り方)** が、LLM に指示を書き足させる forward rewriting (前向きの書き直し) より明確に良かった。P1 に移すと、「運転の world model に渡すシナリオ記述」は、LLM に書かせるより、実走行ログから逆に起こすほうが良い可能性がある。ただし、画像生成でキャプションを実画像から付け直す手法 (recaptioning) で既に知られている考え方で、新しさは小さい。
  - 蒸留 (P2) には触れていない。397B を小さくする話は無い。SC-GRPO (Semantic-Consistency GRPO; GRPO = Group Relative Policy Optimization で、PPO を簡略化した LLM 向け RL 学習手法。それに「ユーザーの要求が shot を跨いでも保たれているか」の報酬を足したもの) も、長い動画の台本に特化している。
  - 評価の WanPEval は約 11K 件の blind pairwise 比較 (どちらのモデルかを伏せて 2 本を並べ、人が良い方を選ぶ) である。設計としては標準的で、P1 の評価指標に新しく持ち込める点は無い。

---

## 本日の fetch 診断 —— **406 が 9 回連続。今日も取りこぼしは 0 件**

```
[fetch] planner_ai (P1) ...          error: HTTP Error 406: Not Acceptable
[fetch] fm_distill_finetune (P2) ... error: HTTP Error 406: Not Acceptable
[fetch] next_arch (P3) ...           error: HTTP Error 406: Not Acceptable
[buzz] HF daily papers: 22 papers
[buzz] wildcard candidates added: 3
```

(`~/research_loop.log` の 09-28 03:00 実行分。)

09-27 と同じ RSS の試作を再実行した (`/tmp/rss_0928.py` → `/tmp/rss_0928.json`)。実行時刻は 09-27 18:00 UTC (日曜 14:00 ET) で、arXiv の日曜夜の announce (20:00 ET) より前である。

| feed | HTTP | 件数 |
|---|---|---|
| cs.RO / cs.AI / cs.LG / cs.CL / cs.CV | 200 | **5 本とも 0** |

| topic | keyword 一致 |
|---|---|
| planner_ai / fm_distill_finetune / next_arch | 0 / 0 / 0 |

**今日は 5 本の feed がすべて空だった。**09-27 は cs.LG と cs.CV に金曜 build の中身が残っていたが、日曜はそれも消えた。announce が無い日なので失われた論文は無く、**累計は 243 件のまま。**09-27 の注意がそのまま裏付けられた。RSS を修正後の取得元にするなら、**「全 feed が空 = 失敗」と判定してはいけない**。正常な日曜はこの形になる。

**次に取りこぼしが増えるのは 09-29 03:00 JST の実行である。**日曜夜の announce 分 (約 1 日分) がこの実行で初めて届く。修正が入らなければ、この分がそのまま失われる。

### 繰り越し —— RSS で拾い直したが、まだブリーフが無いもの (09-27 から変化なし)

正規の評価を通していないのでスコアは付けない。

- **2609.28931: HelloWorld: Towards Practical Applications of Generative Driving World Models** (next_arch) —— **3 日連続で TOP3 に入っているが、まだ未読。**→ https://arxiv.org/abs/2609.28931
- 2609.28865: Direction-Scale Decomposition in Action Representation (next_arch)
- 2609.30036: Aim Short to Reach Far: Your Frozen World Model Can Plan Better Than You Think (next_arch)
- 2609.29706: Safety-oriented pedestrian trajectory prediction at urban intersections (planner_ai)
- 2609.28998: LoRA の rank を lp 正則化で自動配分する (fm_distill_finetune)
