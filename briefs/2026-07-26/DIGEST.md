# DIGEST — 2026-07-26

> 候補 **3 件のみ、全て sns_wildcard**(on-topic の P1/P2/P3 候補は **ゼロ**)。採用 **1 件(wildcard×1)** / max_deep_per_day 6 に対し大幅 under-fill。
> **⚠ 在庫異常:** 本日 candidates.json に **topic 別(planner_ai / fm_distill_finetune / next_arch)の arXiv 候補が 1 件も入っていない**。fetch の arXiv 失敗握り潰し([[fetch-duplicate-candidates]])が発火し、wildcard だけが残った可能性が高い。**選別の問題ではなく取得の問題**。
> **⚠ 重複バグ継続:** wildcard 最上位 AREX(125 up)は **昨日 2026-07-25 にブリーフ済みの再提示**。dedup 欠落でまた発火。無効化し次点系から採用。
> **今日のテーマ:** 実質「ドメイン適合の recipe をどう組むか」1 本。**検証済み(solver / simulator)合成データで基盤モデルを特定ドメインに焼く**、という P2 直結の持ち帰り。

---

## 今日読むべき TOP3

本日は採用 1 件のため TOP3 は成立しない。読むべきは 1 件、加えて運用上の必読事項が 2 つ。

### 1.(唯一の採用)SLAI T-Rex — 「検証済み合成データ」で基盤モデルをドメイン適合させる recipe(実質 P2 本命)
trillion 級 MoE(入力ごとに一部の expert だけ動く巨大モデル)を全パラメータ追加学習し、**Operations Research(数理最適化で意思決定を解く分野)**に適合させた技術レポート。肝は **solver-verified synthetic data** ——「最適化ソルバで解の正しさを自動検証した合成ドキュメント」を SFT データに混ぜ、人手ラベル無しで正解を保証する verifier-in-the-loop。結果、10K サンプルの特化 SFT で GPT-5.4-Mini を +3.98pt 上回る。**「生成は難しいが検証は容易」なドメイン(自動運転の実行可能性・衝突判定はまさにこれ)では、この合成データ生成パターンがそのまま転用できる**のが読む理由。system 半分(MFU 34.22%、通信と計算のオーバーラップ)は Ascend NPU 固有なので割り引いて読む。→ [ブリーフ](2607.20145.md)

### 2.(運用・必読)取得パイプラインが on-topic 候補を 1 件も出していない
今日の在庫は wildcard 3 件だけで、P1/P2/P3 の arXiv 候補が完全に欠落。**選別で埋められる問題ではない**。fetch の arXiv 失敗を握り潰す既知バグの疑いが濃厚 → 下の「運用メモ」参照。**明日以降も同症状なら fetch を先に直す必要がある。**

### 3.(運用・必読)重複 dedup が未修正、wildcard 最上位がまた既ブリーフ
AREX(125 up)は昨日ブリーフ済みなのに再提示。3 日以上続く症状。wildcard の実効在庫が毎日 1〜2 件目減りしている。

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| wildcard(実質 P2) | [2607.20145](2607.20145.md) | SLAI T-Rex(trillion MoE の full-param post-training + solver 検証済み合成データで OR 適合) |

落選 2 件の理由(次点 🔶 付き)+ 重複バグの記録: [rejected.md](rejected.md)

---

## プロジェクト別の要点

- **P1(Planner AI + 評価):** 本日 on-topic 候補ゼロ・採用ゼロ。**在庫欠落は取得バグ由来**で、実分野の新着が枯れたわけではない点に注意。間接の持ち帰りとして、SLAI T-Rex の verifier-in-the-loop 合成データは planner 側にも効く——「シミュレータで実行可能性・衝突を検証済みの軌道/シナリオ」を合成学習データにする発想。

- **P2(FM 蒸留 + 適合):** 唯一の採用 SLAI T-Rex([[2607.20145]])がここに直撃。持ち帰りは **solver-verified synthetic data による domain SFT**——正解をソルバ/シミュレータで自動保証し、人手ラベル無しで高品質 SFT データを量産する recipe。**明日できる:** 「生成は難しいが検証は容易」な自前サブタスクを 1 つ選び、検証済み合成データ混入 SFT vs 既存ラベルのみ SFT を matched budget で比較し、Pass@1 と汎化差を実測。次点の K12-KGraph([[2605.09635]])も「graph-guided データが matched budget で汎用 corpora を上回る」というデータ効率の学びがあり、枠が空けば拾う。

- **P3(次世代アーキ):** on-topic 候補ゼロ・採用ゼロ。副次として SLAI T-Rex の trillion MoE full-parameter post-training の system 設計(comp-comm オーバーラップ、高 MFU 維持)は、MoE ベースの大規模 driving/VLA を自前で追加学習する際の前提知識。ただし Ascend NPU 固有部分は GPU に非可搬。

---

## 運用メモ(パイプライン)

- **【最優先】on-topic 候補の完全欠落。** 本日 candidates.json は sns_wildcard 3 件のみで、planner_ai / fm_distill_finetune / next_arch の arXiv 候補が 0 件。[[fetch-duplicate-candidates]] で記録済みの「arXiv 失敗の握り潰し」が発火し、失敗が無言で捨てられ wildcard だけ残った可能性が高い。**症状が続くなら選別より先に fetch_candidates.py の arXiv 取得エラーハンドリングを直すべき**(失敗を握り潰さず可視化 / リトライ)。判断待ち。
- **wildcard dedup が依然未修正。** 本日 wildcard 最上位 AREX(2607.21461, 125 up)は **2026-07-25 にブリーフ済みの再提示**。既ブリーフ ID を candidates 生成時に除外する修正が未実施のまま、複数日連続で発火。wildcard の実効在庫を毎日削っている。[[fetch-duplicate-candidates]] 参照。
- **結果として本日は 6 枠中 1 枠のみ充当。** under-fill だが、これは選別の厳しさではなく **入力(取得)の欠落**が原因。ブリーフ品質のために無理に wildcard を 2 件目まで採る(探索枠の上限逸脱)ことはしていない。
