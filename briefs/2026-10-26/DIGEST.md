# DIGEST 2026-10-26

採用は 1 本 (sns_wildcard 枠を P2 に読み替え)。candidates.json は wildcard 3 件だけで本流は 0 件。RSS 5 本も 0 件で、日曜 18:00Z の fetch としては正常な空振り (喪失なし)。wildcard のうち 2610.31329 は 3 回目の再来、2610.30926 は運転・蒸留への接点が薄く見送った。

## 今日読むべき TOP3

採用が 1 本のため、2 位・3 位は該当なし。

1. **[2610.24738 LayerEditor](2610.24738.md)** (P2 / 壊さずに適合する蒸留) — 指示で画像を編集する model を、「1 枚の画像」ではなく「重ねて使える透明度付きの層 (RGBA layer)」を出力するように作り替える論文。出力の形を変える fine-tuning では、元の model が持っていた編集能力が落ちやすい。著者は元の model を teacher にした蒸留 (Compositional Edit-Prior Distillation) で、完成画像と、予測した層を重ねて作った画像の両方に元の能力を写して、これを防ぐ。画像編集の話だが、「出力の形を変えて別ドメインへ適合するとき、元の model を teacher にして能力を保つ」という recipe として P2 に読み替えられる。ただし abstract に数値が無く、蒸留の具体式は未確認。

## 全ブリーフへのリンク

- [2610.24738](2610.24738.md) — LayerEditor: 出力形式を変える適合で元の編集能力を蒸留で保つ (P2 / wildcard)
- [rejected.md](rejected.md) — 不採用一覧 (wildcard 2 件 + 本流 0 件の記録)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 新規候補なし。candidates.json にも RSS にも該当が無い。10-24 の Route or Adapt と driving VLA の counterfactual 評価の最小実験が未着手のまま。
- **P2 (FM 蒸留 + fine-tuning)**: LayerEditor の最小実験は、出力 head や表現の形を変える適合で、(a) 蒸留 loss なし、(b) 凍結した元 model を teacher にした蒸留 loss あり、(c) さらに新出力から旧形式を再構成した側にも蒸留 loss あり、の 3 つを比べ、元タスクの性能の落ち方を見ること。
- **P3 (次世代アーキテクチャ)**: 新規候補なし。candidates.json に next_arch の候補が無く、RSS も空。

## 運用メモ

- fetch は日曜 18:00Z 実行 (generated_at 2026-10-25T18:00:18Z)。本流 0 件・wildcard 3 件。ログが無く `[fetch] error` の有無は確認できないが、日曜は全 feed 空が正常という既存の観察と一致する。
- RSS は 5 本とも HTTP 200・items 0 件・lastBuildDate 2026-10-25 04:00Z (日曜の空 feed)。回収分なし。
- wildcard の 2610.31329 (WeVisOne-VL) は 10-24 から 3 日連続の再来で、dedup が wildcard 経路にも要る、という既存の観察と一致する。今回も手動で除外した。2610.24738 と 2610.30926 は過去のブリーフ・rejected に無く、今回が初出。
- 次の fetch (月曜 18:00Z) は金曜投稿〜月曜 announce 分が入る最初の回になり得る。そこで本流が 0 件のままなら、エラーの有無を先に確認する。
- ブリーフは abstract のみに基づく。数値表・ablation は未確認。
