# 2026-09-25 の不採用候補と fetch 診断

候補 **3 件** (planner_ai **0** / fm_distill_finetune **0** / next_arch **0** / sns_wildcard **3**) / 採用 **0 件** / 不採用 **3 件**。

**quota の割当:** planner_ai 0/2 / fm_distill_finetune 0/2 / next_arch 0/2 / sns_wildcard **0/1**。**上限 6 に対し 0。**

**3 件はすべて過去に評価済み**で、中身は前回と変わっていない。wildcard 経路に「過去の briefs に出た id を除く」処理 (dedup) が無いという既知の欠陥 #2 が、**3 日連続で出た。今日は 3 件すべてが重複**になった。

---

## 不採用の候補

- 2609.13814: Realtime-Venus: A full-duplex interaction system with asynchronous delegation — **重複。**昨日 09-24 に P3 2.5 で採用し、ブリーフは作成済み ([09-24 のブリーフ](../2026-09-24/2609.13814.md))。hf_upvotes は 207 に増えたが、upvotes は relevance を上書きしない。
- 2609.24972: RRSI: Regularized Recursive Self-Improvement of Agent Harnesses — **重複 (3 回目の提示)。**09-23 に P1 3.0 で採用済み ([09-23 のブリーフ](../2026-09-23/2609.24972.md))。09-24 にも重複として落としている。
- 2609.23088: OmniEdu: Open Foundation Models for Learning and Teaching — **重複。**09-24 に P2 2.0 で不採用にした。理由は、recipe のどの工程が効いたかを切り分ける ablation (1 要素だけ変えて効果を見る実験) が無いこと ([09-24 の rejected.md](../2026-09-24/rejected.md))。新しい情報は無いので、判断は変えない。

---

## 本日の fetch 診断 —— **406 が 6 回連続。昨日の「curl なら通る」は今日反証された。RSS は通る**

### 事実

`/home/jetson/research_loop.log` の 09-25 03:00 の実行でも、**3 トピックすべてが `HTTP Error 406: Not Acceptable`** で失敗した。`fetch_candidates.py` は今も 07-03 の `313a283` のままである。

| 実行日 (JST) | fetch エラー | 実害 |
|---|---|---|
| 09-13 (日) | 429 × 3 | 無し (もともと 0 件の曜日) |
| 09-21 (月) / 09-22 (火) | 406 × 3 | 無し (もともと 0 件の曜日) |
| 09-23 (水) | 406 × 3 | **60 件喪失** |
| 09-24 (木) | 406 × 3 | **56 件喪失** |
| **09-25 (金)** | **406 × 3** | **59 件喪失** (下の RSS で実測) |

### 切り分け (本日 03:00 JST 頃に実施)

| 取得方法 | 結果 |
|---|---|
| Python `urllib` → `export.arxiv.org/api` (https) | **406** |
| **curl** → `export.arxiv.org/api` (標準設定で 3 回) | **406 ×3** |
| curl + ブラウザの User-Agent / `Accept: application/atom+xml` | 406 / 406 |
| `arxiv.org/api/...` | 302 で `export.arxiv.org` に転送され、406 |
| **`rss.arxiv.org/rss/<category>`** (curl でも Python `urllib` でも) | **200** |
| `oaipmh.arxiv.org` (OAI-PMH; 論文メタデータの一括取得用 API) / `arxiv.org/abs/...` | 200 / 200 |
| HF daily papers API | 200 |

- **昨日の「curl だけ毎回 200」は今日反証された。**curl でも、header を変えても 406 だった。**API の endpoint (`export.arxiv.org/api`) だけが、このマシンからの要求を全部拒んでいる**、と見るのが今の事実に合う。原因がクライアント側の癖ではなかったので、**昨日の修正案「curl に差し替える」は取り下げる。**
- 406 の応答は本文が空で、`via: varnish` (arXiv 前段のキャッシュサーバ) から返っている。理由の説明は付いていない。IP 単位の制限かどうかは確かめられていない。

### RSS で失われた分を再取得した

`rss.arxiv.org` の RSS は、**announce (arXiv が新着を公開する時刻) ごとに、その回の新着一覧を返す。**`cs.RO / cs.AI / cs.LG / cs.CL / cs.CV` の 5 本を Python `urllib` で取得した。`announce_type` が `new` (新規) と `cross` (他カテゴリからの相互掲載) のものは 738 件あった。これに `topics.yaml` と同じ keyword を部分一致で当てた。

| topic | keyword 一致 | 備考 |
|---|---|---|
| planner_ai | **2** | 2 件とも運転と無関係 (手指の操作、拘束付き motion planning の幾何) |
| fm_distill_finetune | 30 | 大半は `fine-tuning` という語だけでの一致 |
| next_arch | 28 | 大半はロボット manipulation (物体操作) の VLA |
| **計 (重複除く)** | **59** | |

**RSS への切り替えには、406 を避けられること以外にも利点がある。**これまでの本流 0 件のもう一つの原因は announce 遅延だった。arXiv API の `published` は投稿時刻で、窓をその時刻で切っていたため、窓の手前側が構造的に空になっていた (memory の「土日月 0 件」)。**RSS は announce 単位で届くので、その回の新着を取りこぼさない。**`lookback_days` のずれ (修正①) も、この方式ならそもそも起きない。

**弱点:** RSS は最新の 1 回分しか返さない。マシンが止まっていた日 (09-14〜09-20 のような停止) の分は後から取り戻せない。その場合だけ OAI-PMH で補う。

### 直すべきこと (`fetch_candidates.py`) —— 昨日の案を差し替え

1. **エラーを 0 件と区別する** (変更なし)。失敗したトピックを `candidates.json` に `fetch_errors` として書き出す。3 トピックとも失敗したら非 0 で終了する。
2. **本流の取得元を `export.arxiv.org/api` から `rss.arxiv.org/rss/<cat>` に替える。**カテゴリごとに 1 回取得し、`announce_type in (new, cross)` を残す。そこに keyword を部分一致で当てる。**標準ライブラリだけで書ける** (本日 `/tmp/rss_0925.py` で動作確認済み)。この変更で、修正① (lookback と max_results) は不要になる。
3. ②dedup (`briefs/*/*.md` の id を除外) は **今日、候補 3/3 が重複**だったので実害が最大になった。2 と同時に入れる。
4. ③planner_ai の keyword は、今日も運転の論文を 1 件も拾わなかった。運転の評価・planning の論文 (DreamStream、AnchorReasoning) は next_arch 側か、fm_distill の `fine-tuning` 一致でしか届いていない。**`closed-loop evaluation` / `NAVSIM` / `nuPlan` / `Bench2Drive` / `autonomous driving` を足す。**
5. fm_distill に `on-policy distillation` / `distillation` を足す (09-21 の提案と同じ)。今日の `2609.28145` は題名が on-policy distillation そのものである。それでも一致した keyword は `fine-tuning` だけだった。

---

## 参考: fetch 失敗で評価対象外になった 59 件から、題名と abstract の冒頭で拾ったもの

**スコアは付けていない。**本日の評価対象は `candidates.json` の 3 件なので、ブリーフも作っていない。再取得した 59 件の abstract は `/tmp/rss_0925.json` に残した (再起動で消える)。★ は 09-24 の参考リストにも載っていたもの。announce が重なったため再掲になった。

| id | 題名 | 関係しそうな project |
|---|---|---|
| 2609.27747 | Less Language, More Latents: Annotation-Efficient VLAs for Driving | **P3** (運転の VLA。言語の注釈が少なくても学べるように、先に latent action (軌跡から学習した離散的な「意図」の符号) を作り、少数の注釈で言語と対応付ける) |
| 2609.28145 | RL Starts before RL: On Policy Distillation for Better Reinforcement Learning | **P2** (on-policy distillation (student 自身の出力に teacher が採点を付けて学ぶ蒸留) を RL の前段に置く。直後の精度がほとんど上がらなくても、RL 後の最終性能は上がる、という主張) |
| 2609.28366 | AnchorReasoning: A Visual Grounding and Causal Reasoning Dataset in Long-Tail Autonomous Driving Scenarios | P1 + P3 (WOD-E2E (Waymo の end-to-end 運転データセット) 上に、判断の根拠となる物体の位置と、理由から軌跡までを連ねた注釈を付けたデータ) |
| 2609.27533 | ICM: Intra-class Mixing for Domain Adaptation in Adverse Weather | P2 (悪天候への UDA (Unsupervised Domain Adaptation; 正解ラベルの無い新ドメインへの適合)。semantic segmentation (画素ごとのクラス分類) が対象) |
| 2609.26792 ★ | DreamStream: Towards Policy-Oriented Generative Simulation for End-to-End Driving | P1 + P3 |
| 2609.25376 ★ | VLAQuantBench: Closed-Loop Evaluation of Post-Training Quantization for VLA Models | P2 + P1 |
| 2609.26314 | TriWorldBench: A Tri-View Consistency Perspective on Embodied World Models | P3 (world model を 3 視点の整合性で評価する benchmark) |
| 2609.26313 | SafeLoop: Risk-Aware Rollback for Vision-Language-Action Manipulation | P3 (危険を察知したら直前の状態に戻す VLA の安全機構) |
| 2609.28414 | Frozen Flows Forget: Diagnosing and Restoring Lost Motion in a Latent-flow World Model | P3 |
