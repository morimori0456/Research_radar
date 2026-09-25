# 2026-09-26 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **2 件** / 不採用 **1 件**。

**quota の割当:** planner_ai 0/2 ・ fm_distill_finetune 0/2 ・ next_arch **1/2** ・ sns_wildcard **1/1**。**上限 6 に対し 2。**

wildcard 3 件は、今日は **3 件とも新規**だった (過去の briefs に id の出現なし)。09-23〜09-25 のような重複は今日は起きていない。

---

## 不採用の候補

- 2609.26780: SpeakerMem-R1: Speaker-Centered Dual-Track Memory for Multi-Party Dialogue — **分野外で、学びの転用先も無い。**複数人の会話で「誰が何を言ったか」を記憶する LLM memory の研究。GRPO (Group Relative Policy Optimization; PPO の簡略版で LLM の RL 学習に使う) で記憶の書き込み役を学習している。ただし、P1〜P3 のどれにも持ち込める要素 (評価の設計、蒸留、world model) が無い。スコア P1 0.5 / P2 1.0 / P3 0.5。wildcard 枠は 1 件までで、[Taste-Bench](2609.25804.md) の方が P1・P2 の両方に転用先がある。hf_upvotes 82 は 3 件中最低で、タイブレークでも逆転しない。

---

## 採用の補足: Object Permanence を next_arch に移した件

[2609.28654](2609.28654.md) は candidates.json では sns_wildcard だった。しかし同じ日の arXiv RSS で確かめると、cs.AI の新規掲載 (cs.CV に相互掲載) で、next_arch の keyword `world model` に一致していた。**本流の fetch が生きていれば next_arch で届いていた論文**なので、next_arch の quota で採用した。wildcard 枠は別の論文に使った。

---

## 本日の fetch 診断 —— **406 が 7 回連続**

```
[fetch] planner_ai (P1) ...          error: HTTP Error 406: Not Acceptable
[fetch] fm_distill_finetune (P2) ... error: HTTP Error 406: Not Acceptable
[fetch] next_arch (P3) ...           error: HTTP Error 406: Not Acceptable
```

(`~/research_loop.log` の 09-26 03:00 実行分。09-25 と同じ形。)

**今日も RSS は通った。**09-25 の試作 (`/tmp/rss_0925.py`) を出力先だけ変えて再実行した (`/tmp/rss_0926.py` → `/tmp/rss_0926.json`)。

| feed | HTTP | 新規 + 相互掲載 |
|---|---|---|
| cs.RO / cs.AI / cs.LG / cs.CL / cs.CV | 5 本とも 200 | 重複を除いて 630 件 |

| topic | keyword 一致 | 09-25 の RSS との重複 |
|---|---|---|
| planner_ai | 7 | 0 |
| fm_distill_finetune | 40 | 0 |
| next_arch | 22 | 0 |
| **合計 (重複除去)** | **68** | — |

**今日失った候補は 68 件。**09-23 以降の累計は **175 + 68 = 243 件**になる。RSS は 09-25 分と 1 件も重ならない。つまり RSS は「その日の announce 分だけ」を返しており、**毎日取りに行かないと取りこぼす**。修正の優先度は下がらない。

### RSS で拾い直した候補のうち、fetch が直ったら最初に読むもの (正規の評価を通していないのでスコアなし)

- **2609.28931: HelloWorld: Towards Practical Applications of Generative Driving World Models** (next_arch) —— 2B の運転 world model。自車の姿勢・HD map (高精度地図)・3D box を条件に 7 カメラの映像と LiDAR (レーザー距離センサ) の点群を同時に生成し、少ステップ推論に蒸留している。P3 と P2 の両方に直結する。今日の Object Permanence の「遮蔽の再出現率」の実験の、評価対象の第一候補でもある。
- **2609.28865: Direction-Scale Decomposition in Action Representation** (next_arch) —— 離散 token の VLA で、動きの増分を「方向」と「大きさ」に分けてから token 化する。複数データセットを混ぜた学習で、成功率が 10.3 点上がった。運転 VLA の軌跡の token 化にもそのまま試せる。
- **2609.30036: Aim Short to Reach Far: Your Frozen World Model Can Plan Better Than You Think** (next_arch) —— world model で計画するとき、最終目標との距離で採点すると失敗する場面がある。過去の記録から「近い中間目標」を取ってきて狙う方が良い、と示した。追加学習は要らない。
- **2609.29706: Safety-oriented pedestrian trajectory prediction at urban intersections using time-to-collision and crossing-zone** (planner_ai) —— 交差点の歩行者の軌跡予測に TTC (Time-to-Collision; 衝突までの残り時間) を組み込む。planner_ai の 7 件のうち、運転に関係するのはこの 1 件だけだった (残りはロボットアームの motion planning や推薦システムなど)。

fm_distill_finetune の 40 件は、今日も大半が `fine-tuning` の 1 語だけで一致した分野外の論文 (音声認識、翻訳、法律など) だった。`knowledge distillation` での一致は 0 件。
