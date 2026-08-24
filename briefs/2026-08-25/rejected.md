# 2026-08-25 不採用の候補

本日の候補は **3 件すべてが sns_wildcard**。本流 3 トピック (planner_ai / fm_distill_finetune / next_arch) は **3 日連続で 0 件**だった。
wildcard は規定により最大 1 件しか採れないため、**構造的に 2 件が落ちる。**以下の理由は、その制約下でのものである。

## 採否の一覧

| id | タイトル | P1 | P2 | P3 | hf | 採否 |
|---|---|---|---|---|---|---|
| [2608.20061](2608.20061.md) | Compute-Efficient Hyperparameter Transfer for MoE | 0 | **3.5** | 3.0 | 31 | **採用** |
| 2608.20910 | InfinityEdit | 0 | 2.0 | **3.0** | 30 | 不採用 |
| 2608.21156 | Graph Engineering in the Era of LLM Agents | 0 | 0.5 | 1.0 | 29 | 不採用 |

**タイブレークは発生していない。**hf_upvotes は 31 / 30 / 29 とほぼ横並びで、順位は relevance だけで決まった。**注目度が拮抗しているときほど、hf_upvotes が選別に何の情報も足さないことがよく分かる例である。**

## 不採用

- **2608.20910: InfinityEdit — Infinite Video Editing with a Lightweight Edit-Ignition Adapter** — relevance **P3 3.0 / P2 2.0**。**今日いちばん惜しい 1 本で、落としたのは枠の問題である。**

  内容は「**infinite video editing**」という設定の提案 — 従来の instruction-based video editing (「この動画を夜のシーンにして」のような自然言語指示で動画を編集する研究) は、**固定長のクリップを frame ごとに書き換える in-place 編集**を前提にしている。本論文が扱うのは、**まだ終わっていない映像ストリームに対して、これから来るフレームに編集を効かせ続ける**設定である (実況中のゲーム画面の restyle など)。提案手法 InfinityEdit は、streaming video generator に載せる軽量 adapter で、3 種の attention から成る — **history cross-attention** (直前までの入力フレームを参照して denoising 中のフレームを導く)、**temporal causal self-attention** (時間の流れを過去→未来の一方向に限る)、**edit cross-attention** (編集指示を生成に注入する)。

  **落とした理由は 2 つ。**(1) wildcard 枠は 1 件で、[MoE の LR transfer](2608.20061.md) (P2 3.5) が上回った。**上回った差は relevance ではなく着手可能性である** — 後者は自分の手元で半日で検証できるが、本論文を試すには streaming video generator を用意するところから始まる。memory の記録では **実験着手 8 週連続ゼロ**であり、この状況では「読んで面白い」より「今週着手できる」を優先すべきと判断した。(2) hf_upvotes は 30 対 31 でほぼ同点、タイブレークとしては機能していない。

  **ただし P3 の関心とは実際に近く、捨て札ではない。**edit request を action、streaming 継続を rollout と読み替えると、**この構造は instruction-conditioned な world model そのものの形をしている** — 過去の観測を条件に未来を自己回帰的に生成し、外から与えられる制御入力でその未来を曲げる。**さらに本論文が正面から扱っている「編集が積み重なっても品質が落ちない」という課題は、world model の中心的な難所である drift (自分の出力を自分の入力に食わせ続けると誤差が累積し、rollout が長くなるほど世界が壊れていく現象) と同じ問題である。**P3 で driving の world model を長時間 rollout させる話になったとき、**history cross-attention と temporal causal self-attention の役割分担 (何を参照させ、何を遮断するか) は具体的な設計の参考になる。**次に本流トピックから world model の論文が来たら、対比のために思い出す価値がある。

- **2608.21156: Graph Engineering in the Era of LLM Agents — From Individual Intelligence to System Intelligence** — relevance **P3 1.0 / P2 0.5 / P1 0**。**枠の問題ではなく、内容が P1/P2/P3 のどれにも当たらないため落とした。**

  主張は LLM agent の設計パラダイムの整理と提案である。prompt engineering → context engineering → harness engineering → loop engineering と来た流れの次として、**単一 agent の能力や文脈をいくら増やしても解けない構造的限界がある**とし (異種の専門性・相互依存する subtask・並列実行・独立した検証・永続する状態が同時に要る仕事は、1 つの agent の組織化能力を超える)、**タスク・agent・システム状態を明示的なグラフとして構築し動的に更新する「Graph Engineering」**を提唱する。position / survey 寄りの論文で、新しい手法や実験結果を出すものではない。

  **P1/P2/P3 との接点がない。**planner の評価手法でもなく、蒸留や適合の recipe でもなく、知覚・制御のアーキテクチャでもない。multi-agent の orchestration は追っている 3 プロジェクトのどれの射程にも入っていない。

  **一点だけ、プロジェクトではなく道具の側で引っかかる部分がある。**この research_loop 自体が、まさに論文のいう loop engineering の実例である (fetch → 選別 → brief → weekly review の反復)。**そしてこの loop の実際の問題は、agent をグラフに組織すれば解けるものではない** — memory の記録どおり、**ボトルネックは実験選定でも情報処理でもなく、90 分ブロックが確保できないという人間側の出力制約**である。**agent を増やして解決する種類の問題ではないので、この論文は本日の関心に対して答えを持っていない。**そう判断できたこと自体が読む前より進んだ点で、それ以上に追う理由はない。

## 本日の候補一覧と公開日 (lookback_days:2 の逸脱を記録)

fetch 実行時刻: **2026-08-24T18:00:37Z** / lookback_days:2 の cutoff: **2026-08-22T18:00:37Z**

| id | 公開日 | 実行時点からの経過 | lookback_days:2 内か |
|---|---|---|---|
| 2608.20061 | 2026-08-20T09:57Z | 4.3 日 | ❌ 超過 |
| 2608.20910 | 2026-08-20T20:00Z | 3.9 日 | ❌ 超過 |
| 2608.21156 | 2026-08-20T20:00Z | 3.9 日 | ❌ 超過 |

**3 件とも lookback_days:2 の範囲外。**08-24 と同じ形で、**欠陥#3 (wildcard 経路に cutoff 判定がかからない) の再確認である。**`fetch_candidates.py` の `main()` で wildcard 候補は `parse_entries` を通らず、cutoff 比較なしに `candidates` へ直接追加される (該当箇所: `for p in hf_top:` のループ)。**皮肉なことに、この欠陥のおかげで本日も候補がゼロにならずに済んでいる。**cutoff が正しく効いていれば、本日の候補は **3 件ではなく 0 件**だった。
