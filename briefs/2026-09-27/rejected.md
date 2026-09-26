# 2026-09-27 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **1 件** / 不採用 **2 件**。

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch 0/2 ・ sns_wildcard **1/1**。**上限 6 に対し 1。**

wildcard 3 件のうち **2 件は 09-26 の候補と同じ**だった。HF daily papers (Hugging Face が毎日選ぶ注目論文の一覧) の上位が 1 日では入れ替わらないためである。新規は 2609.29845 の 1 件だけ。

---

## 不採用の候補

- 2609.28654: Training Object Permanence in World Models — **09-26 に next_arch で採用し、ブリーフ作成済み (重複)。**→ [briefs/2026-09-26/2609.28654.md](../2026-09-26/2609.28654.md)。内容に追加情報は無い。hf_upvotes は 194 で、今日の 3 件中最高。
- 2609.26780: SpeakerMem-R1: Speaker-Centered Dual-Track Memory for Multi-Party Dialogue — **09-26 に不採用にした候補の再配信。**理由は 09-26 と同じで、複数人の会話で「誰が何を言ったか」を覚える LLM memory の研究。P1〜P3 に持ち込める要素 (評価の設計、蒸留、world model) が無い。スコア P1 0.5 / P2 1.0 / P3 0.5。

---

## 本日の fetch 診断 —— **406 が 8 回連続。ただし今日の取りこぼしは 0 件**

```
[fetch] planner_ai (P1) ...          error: HTTP Error 406: Not Acceptable
[fetch] fm_distill_finetune (P2) ... error: HTTP Error 406: Not Acceptable
[fetch] next_arch (P3) ...           error: HTTP Error 406: Not Acceptable
[buzz] HF daily papers: 51 papers
[buzz] wildcard candidates added: 3
```

(`~/research_loop.log` の 09-27 03:00 実行分。09-23 からずっと同じ形。)

09-26 と同じ RSS の試作を再実行した (`/tmp/rss_0927.py` → `/tmp/rss_0927.json`)。

| feed | HTTP | 件数 (全種別) | lastBuildDate |
|---|---|---|---|
| cs.LG | 200 | 331 | Sat, 26 Sep 2026 04:00 UTC |
| cs.CV | 200 | 199 | 同上 |
| cs.RO / cs.AI / cs.CL | 200 | **0** | 同上 |

| topic | keyword 一致 | 09-26 の RSS との重複 |
|---|---|---|
| planner_ai | 3 | 3 |
| fm_distill_finetune | 25 | 25 |
| next_arch | 13 | 13 |
| **合計 (重複除去)** | **40** | **40 (全件)** |

**今日の RSS は 09-26 に取った内容の部分集合で、新しい論文は 1 件も無かった。**arXiv は土日に announce しない (新着を公開しない) ので、RSS の build は土曜 04:00 UTC から更新されていない。さらに cs.RO / cs.AI / cs.CL の 3 本は中身が空だった。したがって、**今日の取りこぼしは 0 件で、累計は 243 件のまま**になる。

これで、09-26 の「RSS はその日の announce 分しか返さない」という観察に補足が付く。**週末は直前の build がそのまま (一部の feed は空で) 残る。**取りこぼしが増えるのは announce がある平日の分だけである。一方で、RSS を修正後の取得元にするなら、「feed が空 = 失敗」と判定してはいけない。週末は正常でも 0 件になる。

### 繰り越し —— RSS で拾い直したが、まだブリーフが無いもの

09-26 に「fetch が直ったら最初に読む」と書いた次の候補は、今日も候補に入っていない。正規の評価を通していないのでスコアは付けない。

- **2609.28931: HelloWorld: Towards Practical Applications of Generative Driving World Models** (next_arch) —— 2B の運転 world model。自車の動き、地図、周辺物体の 3D box を条件にして、7 カメラの映像と LiDAR (レーザー距離センサ) の点群を同時に生成する。少ステップ推論に蒸留もしている。P3 と P2 の両方に直結する。
- **2609.28865: Direction-Scale Decomposition in Action Representation** (next_arch) —— VLA (Vision-Language-Action; 画像と言語から行動を出すモデル) の action token を、「方向」と「大きさ」に分けて作る。
- **2609.30036: Aim Short to Reach Far: Your Frozen World Model Can Plan Better Than You Think** (next_arch) —— world model で計画するとき、遠い最終目標でなく、過去の記録から取った近い中間目標を狙う。
- **2609.29706: Safety-oriented pedestrian trajectory prediction at urban intersections** (planner_ai) —— 交差点の歩行者の軌跡予測に TTC (Time-to-Collision; 衝突までの残り時間) を組み込む。

fm_distill_finetune の 25 件は、今日も大半が `fine-tuning` / `transfer learning` の 1 語だけで一致した分野外の論文だった (心電図、農業、電力網など)。その中で 2609.28998 (LoRA の rank を lp 正則化で自動配分する) は、PEFT (Parameter-Efficient Fine-Tuning; 一部の parameter だけを学習する fine-tuning) の観点で P2 の対象になりうる。`knowledge distillation` での一致は 0 件。
