# 2026-09-23 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **2 件** / 不採用 **1 件**。

**quota の割当:** planner_ai 0/2 / fm_distill_finetune 0/2 / next_arch **1/2** (WorldCrafter。本来 next_arch の論文なので付け替えた。理由は下記) / sns_wildcard **1/1** (RRSI)。**上限 6 に対し 2。**

---

## 不採用の候補

- 2609.15779: EvoOntology: A Self-Evolving Ontology Layer for Data Agents — **重複提示 (2.0)。**前日 09-22 に 2.0 で不採用として記録済み ([09-22 rejected.md](../2026-09-22/rejected.md))。内容は変わっていないので再評価しない。**wildcard に過去 briefs との dedup が無いという既知の欠陥 #2 が再発した。**hf_upvotes は 66 → 127 に増えたが、upvotes は relevance を上書きしない。

---

## 本日の fetch 診断 —— **本流 0 件の原因は窓ではなく API エラー。しかも 09-13 から 4 回連続**

### 事実

`/home/jetson/research_loop.log` に、fetch の stderr が残っていた。本日 03:00 の実行では **3 トピックすべてが `HTTP Error 406: Not Acceptable` で失敗**している。`fetch_candidates.py` は例外を `except Exception` で握りつぶし、`0 new` と表示して処理を続ける。**このため、エラーによる 0 件は、窓が空だったときの 0 件と出力上区別できない。**

run ごとの集計 (ログの `[fetch]   error` 行を数えた):

| 実行日 (JST) | 候補数 | fetch エラー | 窓の機構からの予測 |
|---|---|---|---|
| 07-03 〜 09-12 (72 回) | 3 (31 回) / 8 (1 回) / 33〜61 (40 回) | **0 回** | すべて予測どおり |
| 09-13 (日) | 3 | **429 × 3** (rate limit) | 0 件の日 → 結果は同じ |
| 09-14 〜 09-20 | — | **実行なし** | マシン停止 (下記) |
| 09-21 (月) | 3 | **406 × 3** | 0 件の日 → 結果は同じ |
| 09-22 (火) | 3 | **406 × 3** | 0 件の日 → 結果は同じ |
| **09-23 (水)** | 3 | **406 × 3** | **40〜57 件の日 → 失われた** |

**09-13 に確定した窓の機構は正しい。**09-12 までの 72 回は、エラー無しで予測どおりだった。**ただし 09-13・09-21・09-22 の「0 件は機構どおり」という診断は、根拠としては無効である。**3 日とも、窓の問題以前に API が失敗していた。窓の予測も 0 件だったので、結果が偶然一致しただけである。**本日は窓の予測が「候補あり」の日なので、初めて実害として表に出た。**

### 失われた件数 (本日 curl で再取得して実測)

fetch 時点の cutoff (09-20T18:00:17Z) で、同じクエリ (max_results=30) を再実行した:

| topic | 窓内の件数 | quota |
|---|---|---|
| planner_ai | 6 | 2 |
| fm_distill_finetune | 30 (上限に到達) | 2 |
| next_arch | 24 | 2 |
| **計** | **60** | 6 |

**WorldCrafter (2609.24984) は next_arch の窓内 24 件に入っていた。**fetch が成功していれば、本流の `seen` に先に入り、next_arch として届いていた。sns_wildcard というラベルは fetch 失敗が原因なので、本日は quota を next_arch で数えた。

### 406 の再現状況

- Python の `urllib` からは、本日 3 トピック × 4 回 (15 秒間隔) の再試行がすべて 406 だった。
- 同じ URL を `curl` で送ると 200 が返る。ただし Python からも一部のクエリは 200 が返り、同じ URL でも結果が揺れた。header (User-Agent / Accept) を変えても結果は変わらなかった。
- 09-13 は 429 (rate limit) だった。**原因は arXiv 側の throttle (アクセス制限) と推測するが、確定していない。**

### 直すべきこと (`fetch_candidates.py`, 修正コード量は小さい)

1. **エラーを 0 件と区別する:** 失敗したトピックを `candidates.json` に `fetch_errors` として書き出す。3 トピックすべて失敗したら非 0 で終了する。**これが無いと、窓の欠陥を直しても効果を判定できない。**
2. **backoff (間隔を広げながらの再試行) を入れる:** 429/406 のときは 30 秒・60 秒・120 秒と待って再試行する。`ARXIV_API` を `https://` にする (`http://` は現在 301 redirect)。
3. 既存の修正順序 (①lb と mr を同時に ②dedup ③planner_ai の keyword ④wildcard の cutoff) は維持する。**ただし、この修正を ① より前に置く。**

### 09-14〜09-20 に実行記録が無い理由

`journalctl --list-boots` と `last -x` で確認した。**マシンは 09-13 21:23 から 09-20 21:19 JST まで停止していた** (再起動時に kernel が 6.17 → 7.0 に変わった)。その間の cron (日次 03:00 ×7、週次 09-20 20:00) は 1 回も起動していない。ログにも `Research Loop` の開始行が無い。**「実行したが出力が残らなかった」ではなく「未実行」である。**`candidates.json` の generated_at 09-20T18:00Z は 09-21 03:00 JST の実行で、停止期間中に fetch が動いた証拠ではない。

---

## 参考: fetch 失敗で評価対象外になった論文から、題名だけで拾った候補

**以下は題名だけの印象で、abstract は読んでいない。スコアも付けていない。**本日の候補は `candidates.json` の 3 件と決まっていたので、ブリーフは作っていない。fetch を直して再実行すれば、正規の手順で評価できる。

| id | 題名 | 関係しそうな project |
|---|---|---|
| 2609.24626 | Relationally Grounded Latent World Models for Autonomous Driving | P3 (運転の world model) |
| 2609.24682 | Think Like a World Model, Act Like a VLA: Distilling World-Model Representations into Compact R… | P3 + P2 (world model から VLA への蒸留) |
| 2609.24048 | What Matters in Designing World Action Models: An Empirical Study | P3 (R3 の分類マップの材料) |
| 2609.23910 | ReVeal: A Reconstruction-Aware Real-to-Sim Framework for VLA Policy Evaluation | P1 (実環境を再構成したシミュレータでの policy 評価) |
| 2609.24350 | LIBERO-VPro: Benchmarking Closed-Loop Visual Robustness of Robotic Foundation Models | P1 (閉ループ評価の benchmark) |
| 2609.24872 | DTKDP: A Dual Teacher Knowledge Distillation and Pruning Framework… | P2 (teacher 2 つの蒸留) |
| 2609.24646 | iSDFT: Information-Proximal Self-Distillation for Continual Learning in LLMs | P2 |
| 2609.24974 | Harness-Zero: Harness Distillation via Agent-as-Harness | P2 / RRSI と同じ題材 |
| 2609.23792 | Risk-Aware Motion Planning and Control under Unknown Dynamics with Hybrid Observations | P1 |
