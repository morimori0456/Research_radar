# DIGEST 2026-11-01

採用は 6 本 (P1 1 / P2 3 / P3 2。うち 1 本は sns_wildcard)。**candidates.json は 3 件で、3 件とも sns_wildcard、本流 3 トピックは 0 件だった。** 土曜 18:00Z の fetch は通常 0 件になる (arXiv の announce が月曜 00:00Z まで出ない機構) ので、fetch の欠陥ではない。RSS は cs.AI だけが 605 件を返し、そのうち keyword に一致して未読の 148 件はすべて 10-31 に走査済みで、新規の論文は 0 件、喪失も 0 件だった。そこで、空いた枠は 10-31 の次点 (評価 4.0 / 3.5) の繰り越しで埋めた。5 本の abstract は arXiv API で取得した。ブリーフはすべて abstract のみに基づく。

## 今日読むべきTOP3

1. **[2610.39543 CoRAct: VLA が「言葉で考えた内容」と実際の行動を一致させる reward 最適化](2610.39543.md)** (P3) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) の中には、行動の前に「こう動く」と言葉で推論するものがある。ただ、その推論は行動を縛らず、推論と行動が食い違うことがある。CoRAct は、推論が述べた動きと、行動をとった後の予測が一致するかを reward にして、行動を作るノイズの分布を GRPO (Group Relative Policy Optimization; 同じ入力から複数の候補を出して相対評価する RL) 系の方式で更新する。10-31 の 2610.40002 は推論時に推論の効きを調整する論文で、これは学習時に行動を推論へ寄せる論文なので、読み合わせると「推論と行動の食い違い」を両側から扱える。ただし manipulation のみの検証で、運転の根拠は無い。10-31 の SaiVLA-JEPA は将来予測の補助 loss が効かなかったので、将来予測を reward に使う本論文とは結論が衝突する可能性がある。
2. **[2610.40091 DS-Upcycling: ドメインごとに expert と router だけを足して適合する](2610.40091.md)** (P2) — 複数のドメインへ LLM を適合させるとき、ドメインごとの LoRA (低ランクの差分だけを学習する軽量 fine-tuning) を足す方式は、容量が小さく、入力に関係ない adapter まで効いてしまう。DS-Upcycling は dense な層に expert と router (入力ごとにどの expert を使うか決める部分) を足し、新ドメインでは該当の expert と router だけを更新する。router の教師は 1 ドメイン 256 例で足り、routing accuracy は 90-98% (教師なしの 43-70% から)。少データでの他ドメイン適合という P2 の主題に最も近い。対象は LLM のみで、画像 backbone に移せるかは未検証。
3. **[2610.40271 GAR: flow policy の最終層だけを Gaussian に置き換えて 2 倍速くする](2610.40271.md)** (P2) — flow policy (flow matching で行動を生成する controller) は複数の行動候補を扱えるが、行動を 1 つ出すのに network を何回も回す。GAR (Gaussian Action Readout) は、調べた policy の行動分布が Gaussian でよく近似できることを根拠に、最終層だけを Gaussian の出力に差し替え、対象 state の 0.02% で学習する。推論は 1 pass、最大 2 倍速で、成功率は元に近い。蒸留の recipe として学習量が極小で試しやすい。最大の未確認点は、運転で分岐する場面 (障害物の左右どちらを避けるか) でも Gaussian で足りるかで、ブリーフに最小の検証を書いた。abstract が短く、数値は未確認。

## 全ブリーフへのリンク

- [2610.39543](2610.39543.md) — CoRAct: 推論と行動の整合を noise 空間の reward で最適化 (P3 / next_arch / 4.0 / 10-31 次点の繰り越し)
- [2610.40091](2610.40091.md) — DS-Upcycling: ドメインごとの expert + router で少データ適合 (P2 / fm_distill_finetune / 4.0 / 10-31 次点の繰り越し)
- [2610.40271](2610.40271.md) — GAR: flow policy の Gaussian 蒸留 (P2 / fm_distill_finetune / 4.0 / 10-31 次点の繰り越し)
- [2610.38661](2610.38661.md) — QbD-VLA: 短い closed-loop の成功率で VLA の量子化 bit 幅を決める (P3 / next_arch / 4.0 / 10-31 次点の繰り越し)
- [2610.39958](2610.39958.md) — eCoMAE: 観測量に確信度を揃える VRU 予測の pretraining (P1 / planner_ai / 3.5 / 10-31 次点の繰り越し)
- [2610.39633](2610.39633.md) — IDM: 自分の EMA コピーの特徴で moment を合わせる distribution matching distillation (P2 関連 / sns_wildcard / 3.5 / hf 243)
- [rejected.md](rejected.md) — 不採用一覧 (candidates 2 件、RSS で今日 abstract を確認した 10 件)

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 1 本のみ。eCoMAE は、予測の確信度が観測の量と整合しているかを評価の対象にする。精度の差は小さい (OOD accuracy で +0.01 程度)。planner の閉ループ性能への効果は示されていないので、手法の採用より、診断として使う価値が大きい。最小実験は、手元の予測 model で観測フレームを削ったときに確信度が下がるかを測ること。planner_ai の本流は今日 0 件で、keyword に一致する新規論文が週末は出ない。
- **P2 (FM 蒸留 + fine-tuning)**: 3 本は「適合」と「蒸留」の両面に分かれる。DS-Upcycling は少データのドメイン適合、GAR は出力を単純化する蒸留、IDM は蒸留に moment の loss を足す。共通するのは、**大きな仕組みを足さず、更新する箇所を小さく限定する**ことである (expert と router だけ、最終層だけ、EMA の特徴だけ)。最小実験は、手元の model で「更新を最終層だけに限った蒸留」が通るかを 1 つの task で確かめること。
- **P3 (次世代アーキテクチャ)**: CoRAct は学習時の推論と行動の整合、QbD-VLA は VLA を車載で小さくする方法を扱う。QbD-VLA は simulation で選んだ割り当てが実機の π0.5 で失敗した点が最も参考になる。最小実験は、公開 code で LIBERO 上の VLA を一様 4 bit と QbD の割り当てで比べること。運転では closed-loop の短い評価でも割り当てが安定するかを次に見る。

## 運用メモ

- candidates.json は 3 件 (generated_at 2026-10-31T18:00Z)。3 件とも sns_wildcard で、id は 2610.32749 / 2610.39633 / 2610.39301。すべて既読リストに無い新規で、うち 1 本 (2610.39633) を採用した。10-31 は wildcard が全件既読の再来だったが、今日は再来がない。
- RSS は cs.LG / cs.CL / cs.CV / cs.RO が 0 件 (lastBuildDate 2026-10-31 04:00Z)、cs.AI のみ 605 件 (new 158 / cross 234 / replace 系 213)。過去ブリーフ・rejected に無い keyword 一致 148 件を 10-31 の走査結果 (/tmp/rss_1031/seen.json、386 件) と照合し、差分 0 件を確認した。
- 空き枠の繰り越しは、10-31 の rejected.md に残した次点から取った。**次点の記録に評価と理由を残しておけば、翌日の空き枠をそのまま消化できる**ことが確認できた。
- 次の fetch は日曜 18:00Z で、日曜の fetch は過去に 0 件が通常だった (10-05)。週末分の announce が候補に入るのは、その後の平日の fetch から。
