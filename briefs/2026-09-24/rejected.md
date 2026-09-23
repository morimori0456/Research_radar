# 2026-09-24 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **1 件** / 不採用 **2 件**。

**quota の割当:** planner_ai 0/2 / fm_distill_finetune 0/2 / next_arch 0/2 / sns_wildcard **1/1** (Realtime-Venus)。**上限 6 に対し 1。**

---

## 不採用の候補

- 2609.24972: RRSI: Regularized Recursive Self-Improvement of Agent Harnesses — **重複提示。**前日 09-23 に P1 3.0 で採用し、ブリーフ作成済み ([09-23 のブリーフ](../2026-09-23/2609.24972.md))。内容は変わっていないので再評価しない。**wildcard に過去 briefs との dedup (重複除去) が無いという既知の欠陥 #2 が、2 日連続で再発した** (09-23 は EvoOntology)。hf_upvotes は 144 → 176 に増えたが、upvotes は relevance を上書きしない。
- 2609.23088: OmniEdu: Open Foundation Models for Learning and Teaching — **P2 2.0。**基盤モデルを教育という別ドメインへ適合させる instruction tuning (指示と応答のペアでの fine-tuning) の recipe で、P2 の「別ドメインへの適合」に形の上では当てはまる。中心の主張は「学習データを出典別ではなく能力別 (問題を解く・カリキュラムを理解する・誤答を診断する・教え方を選ぶ) に組むと良い」である。**しかし本文を見る限り、出典別に組んだ場合との比較 (ablation; 1 要素だけ変えて効果を切り分ける実験) が無い。**示されているのは「base model より tuning 後が良い」ことだけで、recipe のどの工程が効いたかは分からない。P2 に持ち帰れる新しい手法 (loss、少データの工夫、PEFT (Parameter-Efficient Fine-Tuning; 一部のパラメータだけを学習する効率的な適合)) も無い。探索枠は 1 件までなので、学びの具体性で Realtime-Venus (2.5) を優先した。

---

## 本日の fetch 診断 —— **406 で本流 0 件が 5 回連続。本日 (木) は窓内 56 件を喪失**

### 事実

`/home/jetson/research_loop.log` の 09-24 03:00 の実行でも、**3 トピックすべてが `HTTP Error 406: Not Acceptable`** で失敗した。`fetch_candidates.py` は 07-03 (313a283) から変更されていない。

| 実行日 (JST) | fetch エラー | 窓の機構からの予測 | 実害 |
|---|---|---|---|
| 09-13 (日) | 429 × 3 | 0 件の日 | 無し (偶然一致) |
| 09-21 (月) | 406 × 3 | 0 件の日 | 無し (偶然一致) |
| 09-22 (火) | 406 × 3 | 0 件の日 | 無し (偶然一致) |
| 09-23 (水) | 406 × 3 | 候補ありの日 | **60 件喪失** |
| **09-24 (木)** | **406 × 3** | **候補ありの日** | **56 件喪失** |

### 失われた件数 (本日 curl で再取得して実測)

fetch 時点の cutoff (09-21T18:00:17Z) で、同じクエリ (max_results=30、https) を再実行した。

| topic | 窓内の件数 | 30 件の最古 | 窓が切れていないか |
|---|---|---|---|
| planner_ai | 5 | 09-17 | 切れていない |
| fm_distill_finetune | 26 | 09-21T17:09 (cutoff の 51 分前) | ぎりぎり収まった |
| next_arch | 25 (+ 重複 1) | 09-21T14:41 | 切れていない |
| **計** | **56** | | |

### 406 の再現状況 (本日の追加分)

昨日「推測: arXiv 側の throttle (アクセス制限)」とした部分を、条件を変えて切り分けた。

- **`https://` に変えても 406 は消えない** (Python `urllib` で 2/2 失敗)。昨日の修正案 2 の「https にする」は、301 redirect (転送) を 1 回減らすだけで、406 の対策にはならない。
- **User-Agent を curl と同じにしても、Accept を変えても 406** (各 1 回)。
- **curl は本日すべて 200** だった (再取得 3 トピックと単発テスト 6 回)。Python の UA 文字列を curl に付けて送っても 200 だった。**つまり header の文字列では決まっていない。**
- Python で `Accept-Encoding: gzip` を付けると 1 回だけ 200 が返った。しかし直後の 3 回はすべて 406 で、再現しなかった。
- **推測:** 判定は header ではなく、接続のされ方 (TLS の握手の特徴など) で行われている可能性がある。確定はしていない。

### 直すべきこと (`fetch_candidates.py`) —— 昨日の案を 1 点修正

1. **エラーを 0 件と区別する** (昨日と同じ)。失敗したトピックを `candidates.json` に `fetch_errors` として書き出す。3 トピックとも失敗したら非 0 で終了する。
2. **`query_arxiv` の HTTP 取得を `curl` の subprocess 呼び出しに差し替える** (昨日の「https + backoff」から変更)。本日の実測では、この環境で確実に 200 が返るのは curl だけだった。**標準ライブラリのみという方針からは外れるが、curl はこのマシンに既にある。**backoff (間隔を広げながらの再試行) は、429 対策として残す。
3. 既存の修正順序 (①lb と mr を同時に ②dedup ③planner_ai の keyword ④wildcard の cutoff) は、1〜2 の後に置く。**②dedup は、今日の RRSI の重複で 2 日連続の実害になった。**

---

## 参考: fetch 失敗で評価対象外になった論文から、題名だけで拾った候補

**以下は題名だけの印象で、スコアは付けていない。**本日の候補は `candidates.json` の 3 件と決まっていたので、ブリーフは作っていない。再取得した abstract は `/tmp/refetch_0924.json` に残した (再起動で消える)。

| id | 題名 | 関係しそうな project |
|---|---|---|
| 2609.26618 | NavSafe-∞: Benchmarking Closed-Loop Driving Safety in Photorealistic Environments | **P1** (閉ループ運転安全の benchmark) |
| 2609.25827 | Protocol before progress: leakage-aware evaluation of AIS trajectory prediction | **P1** (評価の split の leakage。RRSI の「split を分ける」と同じ問い。対象は船舶) |
| 2609.26792 | DreamStream: Towards Policy-Oriented Generative Simulation for End-to-End Driving | P1 + P3 (policy 評価用の生成シミュレーション) |
| 2609.26299 | ForeDrive: Foresight-Guided End-to-End Autonomous Driving with a Planning-Relevant Latent World Model | **P3** (運転の world model) |
| 2609.26467 | RouteRLT: Learning When and Which RL Specialist Should Control a Vision-Language-Action Policy | P3 (Realtime-Venus と同じ「いつ誰に任せるか」の問い) |
| 2609.25820 | Beyond Reconstruction Error: Analytical and Data-Driven Action Tokenization for Autoregressive VLA | P3 |
| 2609.25623 | What Should a Self-Teacher See? Privileged Context Design for On-Policy Self-Distillation | **P2** (on-policy distillation = student 自身が生成した出力に teacher が採点を付けて学ぶ蒸留。fm_distill_finetune の keyword に追加を検討中の語) |
| 2609.25655 | From Experts to Sub-experts: Fine-grained Parameter-Efficient Fine-Tuning for MoE LLMs | P2 (MoE = Mixture of Experts; 入力ごとに一部の専門家層だけを使うモデル、への PEFT) |
| 2609.25376 | VLAQuantBench: Closed-Loop Evaluation of Post-Training Quantization for VLA Models | P2 + P1 (post-training quantization = 学習後に重みを低ビット化する圧縮。その後のモデルを閉ループで評価) |
| 2609.26425 | QuantWM: Temporally Consistent 2-Bit KV Cache Quantization for World Models | P3 + P2 (KV cache = 生成時に過去の attention 計算結果を保持するメモリ。その 2-bit 圧縮) |
