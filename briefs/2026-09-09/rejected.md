# 2026-09-09 不採用の候補

## §0 fetch 診断 — **本日は「27 秒」ではなく「4 日」足りなかった**

規則どおり、選別より先に arXiv API を直接叩いた。**障害ではない。API は 3 トピックとも 100 件を正常に返している。**

`generated_at` = **2026-09-08T18:00:17Z (火)** なので `lookback_days: 2` の cutoff は **09-06T18:00Z (日)**。ところが**3 トピックすべて、最新の投稿が 09-04 (金) 17:59Z 前後で止まっている。**

| topic | 返却 | 最新の投稿 | lb=2 (現行) | lb=3 | lb=4 | **lb=5** | lb=6 | lb=7 |
|---|---|---|---|---|---|---|---|---|
| planner_ai | 100 | 09-04 14:02Z | **0** | 0 | 0 | **5** | 6 | 9 |
| fm_distill_finetune | 100 | 09-04 17:59Z | **0** | 0 | 0 | **28** | 62 | 100 |
| next_arch | 100 | 09-04 17:27Z | **0** | 0 | 0 | **12** | 38 | 53 |
| **計** | | | **0** | **0** | **0** | **45** | 106 | 162 |

**これまでの 3 回 (08-25 / 08-30 / 09-06) と性質が違う。**過去 3 回は「投稿締切 18:00Z 直前の山を cutoff が数十秒〜数分の差で切っていた」という**際どい取りこぼし**だった。**本日は 4 日近い空白**である —— 09-05 (土)・09-06 (日) は arXiv が announce せず、**09-07 (月) は米国 Labor Day** (9 月第 1 月曜) に当たる。**週末に祝日が 1 日足されると、`lookback_days: 2` の窓は丸ごと空になる。**

**帰結が実際に出ている。**`briefs/2026-09-07/` と `briefs/2026-09-08/` は**どちらも空ディレクトリ**で、この loop は **2 日連続で出力ゼロ**だった。09-06 の 2 件と合わせ、**過去 4 日の本流ブリーフは 0 本**である (09-02〜09-05 は毎日 6 本)。

- **lb=5 の妥当性はこれで 4 回目の実測。**しかも今回は「際どく足りない」ではなく「祝日を挟むと全滅する」という、**より強い側の証拠**である。
- **一方、09-06 に記録した「fm_distill が max_results の上限に張り付く」現象は本日は起きていない** (lb=5 で 28 件)。投稿自体が少ない日なので当然で、**張り付きは lb=7 相当まで広げたときに再現した (100 件ちょうど)。**「lb=5 + max_results=100」なら実際に 5 日分を見られる、と本日は言える。
- **欠陥#2 (dedup) は本日は発火せず。**3 件とも過去の briefs に既出なし。ただし**直ったからではなく、HF 上位が入れ替わっただけである。**

> **修正は 4 行・20 分で、未実施 17 日目。**推奨順序は変わらない: ①`lookback_days: 2→5` + `max_results: 30→100` を同時に ②dedup ③planner_ai の keyword 追加 ④wildcard 側の cutoff は最後・かつ緩い窓 (21 日) を別に。
> **本日は ① を先取りして手動で 1 本だけ回収した** ([2609.04921](2609.04921.md))。**回収した中に、明日締切の RoboPAD にそのまま引ける P1 論文があった。**

### lb=5 で回収されたが、本日ブリーフにしなかった本流論文 (繰り越し候補)

**quota と時間の都合で落としただけで、質で落としたものではない。**hf 経路に乗っていないため、放置すると再配信されない。

**planner_ai (P1) — 5 件中 4 件**
- `2609.04364` Scalable Edge-assisted Fusion and Path Prediction for Connected Autonomous Vehicles — 車車間・路側連携側で、R1 の単車前提から外れる
- `2609.05161` APEX-RBD: Mixed-Precision Exploration for Hardware-Efficient Robot Dynamics — ハードウェア実装寄りで評価指標の話ではない
- `2609.04530` Energy-Based Latent Neural Evolution Operator for Magnetization Dynamics — 磁化ダイナミクス。キーワード誤ヒット
- `2609.04464` Achieving Asymptotic Near-Optimality Without δ-Similarity — 理論。R1 との接点が abstract から読めず

**next_arch (P3) — 注目すべき 3 件**
- **`2609.05178` LIBERO-RECOVER: Beyond Task Success Towards Failure Recovery** — **本日の次点。**「成功したか」から「失敗から復帰できるか」へ評価軸を移す benchmark で、**R1 の「衝突率の隣に置く量」と主張の形が完全に同型**。manipulation 側の先行例として引ける。**P3 の quota が空いているので明日以降に回す価値が最も高い 1 本。**
- `2609.05324` RoboSPA: Can VLA Models Go Beyond Simple Scenes and Short-Horizon Tasks? — 二値の success rate を超える diagnostic metrics を提案。上と同じ軸
- `2609.04911` TourPhysics: Bringing Physics to World Models — R3 (今月は着手しない方針) 向け

**fm_distill_finetune (P2) — 28 件中、R2 に効きそうな 3 件**
- `2609.04565` Extremely Sparse Supervision Incentivizes Reasoning Ability — **on-policy distillation で、監督を全体の 0.05% (1 軌跡あたり 1〜2 トークン) に絞っても full-token 学習に匹敵**。**R2 の軸「支配変数は監督を当てる範囲」の、最も直接的な検証例。**採用した Uno と対になる (Uno は範囲を広げ、こちらは狭める)
- `2609.04773` Persistent Teacher Anchoring for Tool-Using Agents — teacher-student の分布ギャップが rollout 中に累積する問題。R2 の破綻境界と同じ現象を扱う
- `2609.04646` Importance-Aware Low-Rank Distillation of Diffusion Transformers — 低ランク圧縮 + 蒸留。容量比の議論に直接乗る

---

## §1 本日の candidates.json からの不採用 (1 件)

- **2609.00365: Dr. Claw: An AI Scientist Workspace for Vibe Research** — **本日 hf_upvotes 最高 (123) だが不採用。**relevance **1.0**。P1 (planner の実装・評価)、P2 (蒸留・適合)、P3 (次世代アーキ) のどの `relevance_criteria` にも当たらない。**規則どおり hf_upvotes は relevance を上書きしない。**wildcard 枠は 1 件で、同枠の [2609.02750](2609.02750.md) が R1 に *形式的な論拠* を供給するのに対し、本論文が供給するのは *ツールの提案* である。加えて **09-06 に HarnessDev (「実行基盤そのものを評価する」という同一の軸) を採用済みで、3 日後に同軸の 2 本目を読むのは新しい測定ではなく再測定になる。**この loop の記録上、不足しているのは harness に関する知識ではなく、**harness を書く 20 分**である。
