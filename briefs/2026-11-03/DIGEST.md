# DIGEST 2026-11-03

採用は 6 本 (P1 2 / P2 2 / P3 2)。**candidates.json は 3 件で、3 件とも sns_wildcard、本流 3 トピックは 0 件だった。** 今日は日曜ではなく月曜 announce 分が届く日で、前回の予告どおり 0 件の原因を確認した。log に `error` は無く、arXiv API を直接引くと最新の `published` が 10-30 12:35Z で、cutoff (10-31 18:00Z) より古かった。つまり **lookback_days=2 では月曜の窓が構造的に空になり、エラー無しで 0 件になる**。RSS (lastBuildDate 11-02 05:00Z) は 5 カテゴリで 1,047 件を返していたので、keyword で絞った 167 件のうち上位 18 件の abstract を読んで 6 本を選んだ。評価・ブリーフはすべて abstract のみに基づく。wildcard は 3 件とも評価 3.0 以下で、総数の上限 6 に入らず見送った。

## 今日読むべきTOP3

1. **[2610.40935 GATS: LiDAR で「見る場所」を先に決めると、計算が 18 倍減って planner が良くなる](2610.40935.md)** (P3) — camera だけの E2E (画像から直接軌道を出す方式) の運転 model は、1 frame に数千の image token (画像を細かく刻んだ断片) を処理するが、大半は空や建物で planning に要らない。しかもそれらが planner の注意を薄めるので、**ランダムに 75% 捨てるだけで全部使う model より良くなる**。この論文は LiDAR と radar の点が落ちた場所だけを、画像を encoder に通す前に残す。token を 10% に絞っても L2 誤差 (予測軌道と正解の距離) と NAVSIM の EPDMS (衝突や走行可能領域の遵守などを合成した運転の評価 score) で全部使う場合を上回り、危険な車両との衝突率は 0.34% から 0.09% に下がる。計算を減らす話と精度を上げる話が同時に成り立つので、E2E の入力設計を見直す最初の根拠になる。LiDAR 前提で、遠方や小さい障害物が落ちる条件は abstract から読めない。ブリーフに最小の ablation を書いた。
2. **[2610.41185 E2E 運転 model の中身を Sparse Autoencoder で読む](2610.41185.md)** (P1、P3 にも関連) — E2E の planner は性能が高い一方で、なぜその軌道を出したか確認できない。この論文は **SAE (Sparse Autoencoder; 内部の値を「ほとんど 0」の高次元な表現に分解し、1 要素が 1 概念に対応しやすくする autoencoder)** を planner の内部に学習し、route intent (進路の意図) を教師なしで 98.3% の精度で読み出す。信号や stop sign だけを画像編集で変えた対で、対応する要素が反応することも確かめ、その要素を直接動かすとブレーキや曲率が予測どおり変わる。閉ループの score が同じでも「何を見て決めたか」が違う planner を区別できる、という評価の足し方に使える。対象は単眼 camera の単純な model で、改善も 3.44% と小さい。
3. **[2610.40857 基盤 model を sim → 実データの順に fine-tuning すると前の段階が壊れる、が 1% の replay で戻る](2610.40857.md)** (P2) — 物理 (PDE; 偏微分方程式で表す流体などの現象) の基盤 model を simulation で fine-tuning すると、元の事前学習データの 1 step 予測誤差が最大 35 倍に悪化する。次に実験データで適合すると、simulation の性能もさらに落ちる。対策は **replay** (過去のデータを少量混ぜて学習する) で、実験データの学習中に simulation データを 1% 混ぜるだけで失った性能の大半が戻り、実験への適合も保たれる。他機種・他ドメインへの適合を段階的に重ねるときの、安い保険として直接使える recipe になる。対象が物理の model で、vision や言語で同じ割合になるかは未確認。

## 全ブリーフへのリンク

- [2610.40935](2610.40935.md) — GATS: LiDAR の形状で image token を選び、sparse latent world model で運転 (P3 / next_arch / 4.5 / RSS 回収)
- [2610.41185](2610.41185.md) — Mechanistic Interpretability for E2E Self-Driving: SAE で planner の内部を読む (P1 / planner_ai / 4.0 / RSS 回収)
- [2610.41772](2610.41772.md) — WorkIng: 高速道路の工事区間の実データ + CARLA benchmark (P1 / planner_ai / 4.0 / RSS 回収)
- [2610.40900](2610.40900.md) — AquaProbe: ドメインギャップの位置を測って LoRA の rank を配分する (P2 / fm_distill_finetune / 4.0 / RSS 回収)
- [2610.40857](2610.40857.md) — Frozen in Time: 物理の基盤 model の sim-to-real 適合での忘却と replay (P2 / fm_distill_finetune / 4.0 / RSS 回収)
- [2610.41609](2610.41609.md) — VLA Policies Do Not Know When Not to Act: 指示が空でも動き出す VLA と抑制法の比較 (P3・P1 評価 / next_arch / 3.5 / RSS 回収)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 3 件、評価 3.5 の次点 10 件、前日の次点 11 件の持ち越し、0 件の原因の実測)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本は、planner を「どの場面で」「何を見て」決めているかを測る道具である。WorkIng は工事区間という edge case (まれだが重要な場面) を、実データと CARLA (自動運転用の simulator) の 24 scenario で層別に評価できる benchmark で、topology (道路の形) × 規格の格子のどこで planner が崩れるかを表にできる。SAE の論文は、内部の概念が信号やブレーキに対応するかを調べる試験を足す。最小実験は、手元の planner を WorkIng-CARLA で閉ループ評価し、崩れた場面の frame で信号に対応する内部の要素が反応しているかを見ること。2 本をつなぐと、score の低下の原因が「見えていない」のか「見えているのに使っていない」のかを切り分けられる。
- **P2 (FM 蒸留 + fine-tuning)**: 2 本はどちらも「適合するとき、どこを触り、何を守るか」の話。AquaProbe は、clean な画像と劣化をかけた画像の対でギャップが出る層を測り、同じ parameter 数の LoRA (低ランクの差分だけを学習する軽量 fine-tuning) を、そこに多く配分する (一様配分より mIoU が 1.9 point 良い)。Frozen in Time は、適合の段階を重ねると前の能力が壊れ、1% の replay で戻ると示す。11-02 の 2610.38001 (元の model を教師にした distillation で劣化を防ぐ) と対になるので、replay と distillation を同じ設定で比べる実験が書ける。最小実験は、機種 A → 機種 B の順に fine-tuning して、段階ごとに機種 A の性能を測ること。
- **P3 (次世代アーキテクチャ)**: GATS は入力 token の選び方、VLA の論文は指示に対する policy の振る舞いを扱う。後者は、指示が空でも 6 つの checkpoint が全部動き出し、「指示の先頭に注意書きを足す」方法は 1 つも止められなかった。最初の action chunk (数 step 先まとめて出した行動) が空指示のときとほぼ同じなら止める gate (条件で通す・止める仕組み) は、6 中 5 で止めた。運転では route command を空・矛盾にして軌道が変わるかを測る paired 試験に移せる。最小実験は、手元の E2E で token をランダムに 25% / 10% に落として、全部使う場合と比べること。

## 運用メモ

- **月曜の 0 件は lb=2 が原因と確定した (エラー無し)。** API の最新 `published` は 10-30 12:35Z (金曜) で、cutoff が 10-31 18:00Z。10-06 の予告 (木〜金投稿分が月曜 announce なのに窓外でエラー無し 0 件) と同じ現象で、今日は 1 回の直接確認で機構を裏づけた。RSS の月曜 announce 分は 1,047 件あり、keyword 一致は 167 件。今日のようにブリーフを RSS から作る運用を続ける限り、候補の質は保てるが、`fetch_candidates.py` 自体は未修正で、月曜は毎週この形で空になる。
- 修正案 (未実施): 月曜 (と祝日明け) の実行だけ lookback_days を 4 以上にする、または取得元を RSS に替える (announce 単位なので遅延も重複も消える)。コードは変えていない。
- 今日の採用 6 本はすべて RSS 回収分。candidates.json の 3 件はどれも採用しなかった (wildcard は最大 3.0 で、6 本の上限に届かなかった)。11-02 の次点 11 件は消化せず、持ち越している。
