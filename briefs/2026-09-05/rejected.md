# 2026-09-05 不採用の候補

候補 **57 件** / 採用 **6 件** / 不採用 **51 件** (採用率 11%)。
届いたラベル別内訳: planner_ai **1** / fm_distill_finetune **30** / next_arch **23** / sns_wildcard **3**。
**内容による再分類後の採用: P1 3 / P2 2 / P3 1** (`max_deep_per_day: 6` ちょうど)。
**quota 上の割当: planner_ai 2 / fm_distill_finetune 2 / next_arch 2 / sns_wildcard 0。**

> `git log -- topics.yaml fetch_candidates.py` の最終変更は **2026-07-03 の初期構築時のまま** = **設定は 1 行も変わっていない (修正 20 分・未実施 13 日目)。**

---

## §0. fetch の診断 —— 本日、欠陥#7 と欠陥#2 が「最悪の形」で同時に出た

### 【欠陥#7・確定的な証拠】planner_ai が届けた 1 件は、宇宙機のドッキングだった

**本日 planner_ai ラベルで届いた候補は 1 件のみ。**中身は [2609.03067](http://arxiv.org/abs/2609.03067v1) —— **国際宇宙ステーションへのドッキングの world model** である。P1 (自動運転の planner 実装・評価) とは関係がない。

**57 件全部に対して planner_ai の 4 キーワードを文字列一致で当て直した結果:**

| キーワード | 57 件中の一致 |
|---|---|
| `motion planning` | **1 件** (Qwen-Drive-1.0 —— **sns_wildcard 経由で届いた**) |
| `trajectory prediction` | **1 件** (宇宙機ドッキング) |
| `planner evaluation` | **0 件** |
| `closed-loop simulation` | **0 件** |

**一方、本日の P1 本流 4 件は、planner_ai の 4 語のどれにも一致しない。**そして 09-04 に提案した修正語を当てると、全部が拾える:

| 論文 | 一致する修正語 |
|---|---|
| [SV-WAM](2609.03602.md) | `NAVSIM` |
| [Drive-HWM](http://arxiv.org/abs/2609.03572v1) | `NAVSIM` |
| [LaPla](2609.04070.md) | `closed-loop evaluation` |
| [StyleDrive](2609.03225.md) | **`Bench2Drive` のみ** |

> **09-04 の修正案 (`NAVSIM` / `nuPlan` / `closed-loop evaluation`) では、StyleDrive が漏れる。**本日の証拠で**修正案を更新する: `Bench2Drive` を 4 語目に足す。**
> **更新後の追加語: `NAVSIM` / `nuPlan` / `Bench2Drive` / `closed-loop evaluation`。**これで 09-04 の 4 件と本日の 4 件、**2 日分 105 件で検証済みになる。**ベンチマーク名は手法名と違って表記が揺れない。

**そして本日の数字は、修正の順序についても新しいことを言っている。****planner_ai の 1 件という数は、`max_results: 30` の上限とは無関係である** (上限に達していない)。**つまり planner_ai に限れば、`lookback_days` と `max_results` をいくら広げても件数は増えない。**メモの修正順序 (①窓と上限 → ②dedup → ③planner_ai のキーワード) は正しいが、**③ は ① の効果を待つ必要がまったくない。**独立に、単独で、今すぐ効く。

### 【欠陥#1・4 日連続】fm_distill_finetune はまた「ちょうど 30 件」だった

公開日の内訳: **09-03 が 23 件、09-02 が 7 件。**合計 **30 = `max_results` ちょうど。**新しい順に取って 30 で打ち切られている形が、09-04 と同じく再現した。
next_arch は 23 件 (上限未達) で、**09-03 が 22 件・09-02 が 1 件。**窓の cutoff は `generated_at` (09-04T18:00Z) から 2 日 = **09-02T18:00Z** なので、09-02 の日中に出た論文は構造的に入らない。**上限と窓の両方が効いている。**

### 【欠陥#2・本日が最も悪い】sns_wildcard の 3 件は、3 件とも再配信だった

| id | 状態 |
|---|---|
| 2609.02749 Repo-To-Skill (up 512) | **09-04 に採用済み・ブリーフ作成済み** |
| 2609.00111 Qwen-Drive-1.0 (up 369) | **09-03 に採用済み・ブリーフ作成済み** |
| 2609.01591 StudentSim (up 480) | 09-03・09-04 と **2 日連続で不採用** |

**wildcard 枠 3/3 が既出。実効的な新規供給はゼロである。**hf の上位は数日単位で動かないので、**dedup が無い限りこの枠は今後も同じ 3 件を配り続ける。**

> **これが本日の選別に実害を出した。**Qwen-Drive-1.0 は本日の候補の中で単独 2 番目に P1 適合度が高い (5 点満点で 4.5) が、**09-03 に全文ブリーフ済みのため採る意味がない。****結果、wildcard 枠は 0 件で運用し、空いた 1 枠を next_arch に回した。**
> **dedup は「無駄なブリーフを防ぐ」機能ではなく、「1 枠を空費させない」機能である。**本日はその 1 枠が、たまたま手作業で救えただけである。

---

## §1. planner_ai ラベル (1 件中 0 件採用)

- **2609.03067 GPU-Accelerated Astrodynamics World Models for Spacecraft Rendezvous** — **宇宙機のドッキング。**world model + 不確かさ + OOD 汎化という道具立ては P3 と共通だが、**P1 の planner 評価にも R1 の指標設計にも接続点がない。**JAX の並列シミュレータを公開している点は P3 の道具箱として記憶に留めるが、R3 は今月着手しない。**キーワード `trajectory prediction` が宇宙軌道の予測に当たっただけである** (§0)。

## §2. 運転・planner 系で quota により落とした (次点。惜しい順)

- **2609.03572 Drive-HWM** — **本日の次点。**slow-fast の階層 world model (遅い側が長期の未来表現、速い側が次フレームと即時行動) + optical flow で学習する dynamic-aware latent。NAVSIM v1/v2 で検証。**落とした理由は品質ではなく主題の重複** —— [SV-WAM](2609.03602.md) と [StyleDrive](2609.03225.md) で「driving world model の最新」は 2 本取れており、3 本目の限界効用が小さい。**10 月に R1 の比較対象を選ぶときに最初に読み直す 1 本。**
- **2609.03952 WorldReward (up 15)** — camera 条件付き world model の生成結果を **VLM に対で判定させる reward model** + 人手 benchmark。**評価の話なので R1 と近いが、対象が「生成映像の質と行動整合」であって「方策の安全余裕」ではない。**同じ「VLM を判定器にする」路線は [R2S-Eval](2609.03276.md) で 1 本採ったので重複。
- **2609.04147 A Low-Cost, Open Platform for End-to-End Autonomous Driving on a Miniature Ackermann Vehicle** — 小型実車の E2E 運転プラットフォーム。**安価に閉ループを回せる環境は R1 の 10 月の実験にとって潜在的に有用**だが、**明日の図 1 には要らない** (図 1 は既存ログか 2D toy で出す方針)。**10 月に実データが詰まったときの代替経路として記録。**
- **2609.03774 Rethinking World Models for Safety-Critical Embodied Systems** — **主張は R1 と近い** (「尤度が高いことと安全な判断ができることは別」「予測でなく介入と結果で世界モデルを組め」)。だが **perspective 論文で数値がない。**R1 が今必要なのは味方の主張ではなく**自分の図 1** である。**ただし RoboPAD (09-10) が open-problem/perspective を歓迎する枠であることを考えると、これは「競合の投稿先が同じ」という意味を持つ。**related work としてではなく**位置取りの参考**として、09-10 の投稿判断の前に abstract だけ読み直すこと。
- **2609.03294 Latent Energy Action Planning with World Models** — 潜在空間のエネルギー関数で行動計画。R3 の軸②に関係するが、R3 は今月着手しない。
- **2609.03565 Toward Physically Grounded JEPA World Models** — JEPA (Joint-Embedding Predictive Architecture; 画素を再構成せず表現空間で未来を予測する方式) の物理接地。**同上、R3 待ち。**
- **2609.03557 Building Pretraining Data for World Models (Unreal Engine pipeline)** — world model の事前学習データ生成 pipeline。データ側の話で、R1 の指標設計に直結しない。
- **2609.03225 以外の閉ループ benchmark 系はなし。**

## §3. VLA / ロボット操作 (R3 が閉じているため一律で落とす)

- **2609.03681 WISE** — world model の想像を「いつ使うか」を制御して VLA の post-training を効率化 (計算 80% 減)。**設計としては本日の候補で最も気が利いているが、対象が manipulation で R1 に接続しない。**R3 再開時の必読リストに入れる。
- **2609.03927 Toward Unified Robot Learning** — 表現・VLA・world model を橋渡しする統合論。**R3 の分類マップと目的が重なるため、10 月に R3 へ戻るとき最初に読む。今日読むと軸が他人の分類に引きずられる。**
- **2609.03715 MINERVA (LIBERO を解ける最小の方策サイズ)** — 「どこまで小さくできるか」は P2 の関心と隣接するが、**対象が manipulation 方策で、蒸留の recipe が出てこない。**
- **2609.03889 FWBC-VLA** / **2609.03591 Scaling Bimanual Household Manipulation** / **2609.04193 GIFT** / **2609.03142 Sensing Which Modality Matters** / **2609.03483 Air-Ground Collaborative VLN** / **2609.03834 Semantic Bayesian World Models** / **2609.03891 hybrid ontology-based semantic mapping** — いずれも manipulation / navigation の個別課題。**R3 が閉じている以上、今読む理由がない。**
- **2609.04134 Prospective Coding in Continuous-Time RNNs** / **2609.03689 Semantic-Aware Subgraph State Space Model (病理画像)** — 分野外。

## §4. fm_distill_finetune で quota により落とした (次点)

- **2609.03150 Routing Is Not Enough (SpawnLoRA)** — **P2 の次点。**MoE + LoRA の多ドメイン fine-tuning で、**expert の routing が分かれていても LoRA の低ランク部分空間内で勾配が衝突して負転移が起きる**ことを、Jaccard routing overlap と adapter-gradient cosine similarity という 2 つの診断量で示した。**「他ドメインへの適合」という P2 の 2 本目の柱に真正面から当たる。**落としたのは [Compression×TTA](2609.03604.md) と主題 (適合能力が構造的に潰される) が重なり、かつあちらの方が R2 の既存ログで検証しやすいため。**R2 で「適合余地」を測る段になったら、この 2 つの診断量をそのまま借りる。**
- **2609.03216 ProgResViT** — 入力ごとに解像度と幅を段階的に上げる適応推論。蒸留を併用して DeiT-III-S 相当に到達。**計算と精度の trade-off の話で、R2 の「破綻境界」には接続しない。**
- **2609.03181 Jina-OCR-v1** — speculative decoding (小さい下書きモデルで先読みし本体で検証する高速化。greedy 検証なので出力は無損失) + 検証可能報酬での GRPO。**実務の配備 recipe としては良質だが、P2 の問い (蒸留がどこで壊れるか) と別方向。**
- **2609.03563 FlashRender (up 11)** — few-step 化のための蒸留 3 段構え (表現整合 → MeanFlow → on-policy flow map 蒸留)。**拡散モデルの step 蒸留は P2 の対象と技術的に近いが、R2 の対象は言語モデルの蒸留であり移らない。**
- **2609.03206 Learning to Zoom Efficiently** — SFT の warm-start 無しで tool 使用を学ぶ InfoNCE 型の内在報酬。**「warm-start SFT を消す」という形は面白いが、P2 の蒸留に直接は接続しない。**
- **2609.03379 RecurTrace** — 潜在推論のループ時間メモリ。**推論効率の話。**
- **2609.03887 Beyond Shallow Alignment** — post-training 手法が refusal 回路と steering 頑健性をどう決めるか。**安全性の解釈可能性で、P2 の適合と目的が違う。**
- **2609.04194 Legibility is Not Interpretability** — CoT の「読みやすさ」と「実際の寄与」が別物であることの実証。**主張の形は R1 と同型 (見えているものと効いているものが違う) だが、R1 の introduction には既に 3 領域の例が揃っており、4 本目は要らない。**

## §5. 分野外・関心外 (fm_distill_finetune ラベルの大半)

いずれも「fine-tuning / distillation / transfer learning という語が abstract にあるだけ」で、P2 の問い (蒸留の破綻境界・他ドメインへの適合 recipe) に接続しない。

- **2609.04148 Terminal-Universe (up 204)** — agent の実行履歴から実行可能な環境を復元し、post-training 用のタスクを大量合成 (37.3k 環境)。**hf で本日最も注目された arXiv 論文だが、対象が terminal agent。**注目度は relevance を上書きしない (規則通り)。
- **2609.04202 TokenMatch** (3D メッシュ対応) / **2609.04168 Para-Pipe** (SoC 上の演算子並列) / **2609.04061 When Models Edit Too Much** (コード編集の最小性) / **2609.04048 Translation as a Decision Space** (低資源方言) / **2609.03992 Text-Audiobox** (吹き替え音声) / **2609.03892 GraFT** (3D シーングラフで空間推論) / **2609.03813 SPARK** (DiT 超解像) / **2609.03806 SVG-Score** / **2609.03788 Reverse Sign Language Dictionary** / **2609.03695 SignSeek** / **2609.03505 IoT 異常検知** / **2609.03454 メンタルヘルス QA の選択的検索** / **2609.03330 Less Is Moral** / **2609.03321 全二重対話のターン制御** / **2609.03273 タミル語の綴り訂正** / **2609.03231 PNPL Competition (脳磁図の単語分類)** / **2609.03215 SWIM (学習者作文の模擬)** / **2609.03210 AI 気象モデルの降水補正** / **2609.03102 WireSeg-32K** — **すべて分野外。**

## §6. sns_wildcard (3 件・**全件が再配信のため 0 件採用**)

- **2609.02749 Repo-To-Skill (up 512)** — **09-04 に採用しブリーフ済み。**再配信 (§0)。
- **2609.00111 Qwen-Drive-1.0 (up 369)** — **09-03 に採用しブリーフ済み。**再配信。**本日の候補の中では P1 適合度が最上位クラスだが、既読のため採らない。**
- **2609.01591 StudentSim (up 480)** — 09-03・09-04 に続き **3 日連続で届いた 3 度目の不採用。**LLM で学習者を模擬する話で、P1〜P3 のいずれにも接続しない。

> **§6 が丸ごと「再配信」で埋まるのは今回が初めてである。**wildcard の趣旨 (分野外だが注目度が高いものを 1 件だけ探索的に読む) が、**dedup の欠如で機能停止している。**
