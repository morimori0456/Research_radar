# Daily Research Digest — 2026-07-07

本日候補 **3件**(すべて topic=sns_wildcard/EXPLORE、P1/P2/P3 の本枠候補はゼロ)→ 探索枠1件制約により **選定1件・却下2件**。
運用メモ: candidates.json は前2日の重複3件から **新規 ID に入れ替わった**(fetch の重複再提示は今回は解消方向)。ただし 2607.02501 は 07-04 却下分の再提示で、dedup は引き続き要観察。

---

## 今日読むべき TOP3

本日は選定1件のため、選定 → 却下(学習メモとして目を通す価値順)で提示する。

1. **[MIPI/MIPU — LLM RL の“本当の最適化対象”は inference policy](2606.29526.md)**（selected, P2 接続, relevance 3/5, hf 111）
   RL (強化学習) で LLM を post-training(仕上げ学習)すると崩壊しやすい、その主因は **学習用エンジンと推論用エンジンが同じ生成系列に別々の確率を返す** ズレ(training-inference mismatch)にある、と指摘する論文。核心の学びは「**自分が最適化している対象(学習時の重み)と、実際に価値が出る対象(deploy 時の挙動)がズレていないか**」という一般原理で、これは RL に限らず蒸留・量子化・PEFT すべてに刺さる。悪化する更新を安価な proxy で弾く selective acceptance の設計も P2 の適合ループにそのまま移植できる。読む理由は「手法」より「見落としやすい落とし穴の指摘」の価値が高いから。

2. **[OrbitQuant — calibration 不要の data-agnostic 量子化](rejected.md)**（rejected, P2 キーワード一致, relevance 3/5, hf 23）
   拡散 transformer を回転で分布を既知化し、**キャリブレーションデータ無し**で単一 codebook を全条件に使い回して低ビット化(画像で重み2bit/活性4bitまで)。対象が画像・動画生成でドメインが遠く枠を譲ったが、「回転で活性分布を入力によらず固定分布に寄せる」という圧縮の発想は P2 の量子化メモとして押さえる価値あり。手法の質は本日随一。

3. **[Embodied.cpp — VLA/WAM のエッジ推論ランタイム](rejected.md)**（rejected 再提示, relevance 2/5, hf 34）
   VLA/世界モデル系の推論を統一する C++ ランタイム。展開工学として実用的だが新規の学習/アーキ知見はなく、**07-04 に続き2度目の却下**。読む価値は低いが、fetch が過去却下分を再提示した運用事実として記録。

---

## 全ブリーフ一覧

| id | タイトル | 判定 | project | relevance | hf |
|---|---|---|---|---|---|
| [2606.29526](2606.29526.md) | MIPI/MIPU: Monotonic Inference Policy for LLM RL | ✅ selected | P2 (EXPLORE) | 3/5 | 111 |
| [2607.02461](rejected.md) | OrbitQuant: Data-Agnostic DiT Quantization | ❌ rejected | P2 | 3/5 | 23 |
| [2607.02501](rejected.md) | Embodied.cpp: Portable Embodied Inference Runtime | ❌ rejected (再提示) | P3 | 2/5 | 34 |

却下の詳細理由 → [rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1(Planner AI + 評価)
- 本日は直接該当なし。前日採用の EvoPolicyGym([../2026-07-06/2607.02440.md](../2026-07-06/2607.02440.md))の「closed-loop 改善過程を最終スコアに潰さず trajectory 単位で診断する」評価哲学を、引き続き P1 の評価基盤メモとして継続追跡。

### P2(Foundation Model 蒸留 + 適合)
- **本日の主収穫は MIPI/MIPU の一般原理**: 「最適化対象 ≠ 価値の出る対象」のズレを疑え。**deploy 時に量子化/別バックエンドを使うなら、学習時精度で loss を取るだけでは deploy 挙動の改善を保証しない**。まず自社パイプラインで train/deploy エンジン間の出力分布ギャップを実測する健康診断を推奨(→ ブリーフの実験アイデア1)。
- **selective acceptance の移植**: 適合の各更新を、deploy 相当の推論で測る安価な proxy で gating し悪化更新を棄却する。少データ適合の安定化テンプレとして試す価値。
- 補助メモ: OrbitQuant の calibration-free 量子化(回転で活性分布を既知化)は、将来 student を低ビット deploy する際の圧縮候補として保留。

### P3(次世代アーキテクチャ)
- 本日は新規知見なし。Embodied.cpp は VLA/WAM の **展開層**の話で、アーキテクチャ/学習の着想にはつながらない(2度目の却下)。

---

## 運用アクション
- **fetch_candidates.py の dedup 確認**([[fetch-duplicate-candidates]]): 前日重複3件は解消したが、2607.02501 のように lookback 窓外の過去却下分が再提示される事象は残る。既ブリーフ済み/既却下 ID を除外する dedup が効いているか、次回 fetch のログで確認。
