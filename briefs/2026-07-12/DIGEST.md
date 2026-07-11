# Daily Digest — 2026-07-12

候補 3件 (全て sns_wildcard) から 1件を選定。planner_ai 0 / fm_distill_finetune 0 / next_arch 0 / wildcard 1。本枠 (P1/P2/P3) の新規候補は今日ゼロで、wildcard 3件のうち初出は 1件 (SciReasoner) のみ。残り 2件 (Vidu S1・LaMem-VLA) は既にブリーフ済みの再提示で却下。

## 今日読むべき TOP3

今日は選定が探索枠 1件のみのため、TOP1 のみ提示する。

1. **[SciReasoner (2607.07708)](2607.07708.md)** — タンパク質・小分子・無機結晶を 1 つの離散 token 語彙にまとめ、各構造 token を「推論中に名指しで参照できる証拠単位 (addressable evidence unit)」として扱う科学 foundation model。答えだけでなく「どの構造部分を根拠にこう推論したか」のトレースを出す。分野は AD と無関係 (探索枠) だが、シーン構成要素をどうトークン化して planner/VLA の推論に載せ、決定根拠を追跡可能にするか、という P3・P1 共通の設計問題に着想を与える。直接適用は薄いので着想メモ扱い。

（本枠候補が今日ゼロのため、通常の P1/P2/P3 からの TOP2・TOP3 は該当なし。）

## 本日のブリーフ一覧

| ID | タイトル | Project | 点数 |
|---|---|---|---|
| [2607.07708](2607.07708.md) | SciReasoner: 構造ネイティブ token での structure-property 推論 foundation model | EXPLORE | 2 (探索枠, hf 83) |

却下 2件 (いずれも既読の再提示) の理由は [rejected.md](rejected.md)。

## プロジェクト別の要点

### P1: Planner AI + 評価
- 今日の新規本枠候補なし。SciReasoner の「予測の根拠となる token を名指しで追跡する」設計は、planner の決定根拠のトレーサビリティ (インシデント事後検証で「どの周辺 agent を根拠に回避したか」を示す) への着想として保持。

### P2: FM 蒸留 + 適合
- 今日の新規本枠候補なし。SciReasoner は foundation model だが蒸留・適合の recipe ではなく、P2 への直接示唆は乏しい。

### P3: 次世代アーキテクチャ
- **SciReasoner** (探索枠): 異種の構造化入力を単一 token 語彙に写し、各 token を推論から参照可能な証拠単位にする表現設計。07-11 の WCog-VLA (agent token) / 07-10 の LaMem-VLA (latent memory token) と同じ「シーンをどうトークン化して推論に載せるか」の問題圏で、根拠付き推論トレースを教師信号化する発想が新しい。driving VLA のシーントークン化と説明可能性の設計に転用余地。

## 運用メモ
- **本枠候補が今日ゼロ**: candidates.json が wildcard 3件のみを返し、P1/P2/P3 の新規 ID が 1件も届かなかった。5日ぶりに本枠が枯れた状態。fetch_candidates.py の新着取得ログを次回 run 前に要確認 ([[fetch-duplicate-candidates]])。
- **wildcard の既読再提示は継続**: Vidu S1 (07-11 ブリーフ済み)・LaMem-VLA (07-10 ブリーフ済み) が hf_upvotes 上位のまま再提示。「既読除外なしで hf 上位を取り直す」構造は不変。初出は SciReasoner 1件のみで、探索枠はかろうじて機能。根本対応 (fetch 側で briefs/*/ 既存 id を除外) の優先度は据え置きで高い。選別側の既読扱い除外は 07-12 も適用。
