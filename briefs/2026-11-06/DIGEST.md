# DIGEST 2026-11-06

採用は 6 本 (P1 2 / P2 2 / P3 2)。candidates.json は 50 件 (planner_ai 1 / fm_distill_finetune 30 / next_arch 16 / sns_wildcard 3)。評価・ブリーフはすべて abstract のみに基づく。wildcard は昨日と同じ 3 件で最高 2.5 のため今日も見送った。

## 今日読むべきTOP3

1. **[2611.06453 driving score が同じでも「押し通る agent」と「止まる agent」を見分ける評価](2611.06453.md)** (P1) — CARLA (運転 simulator) の closed-loop (出した行動が次の入力に返る閉ループ) benchmark は、route completion に違反の減点を掛けた driving score で agent を順位づける。この score は、障害物の前で止まる agent と接触しながら押し通る agent を区別できない。論文は、通路の幅や対向車との時間間隔を 1 つだけ動かし、各場面を「通るべき」「止まるべき」と判定したうえで、**進もうとする確率と、接触なく通れる確率を別の曲線で出す**。学習 agent で最高の TFv6 でも、判定の正解率は 0.60 (rule-based の手本は 0.74) で、fine-tuning した robot 版は「通れる gap は増えたが、塞がれていても止まらなくなった」。planner を改良して score が上がったときの副作用検知として、そのまま P1 の評価に足せる。実走行ログへの持ち込み方は abstract に無い。
2. **[2611.06918 VLA は encoder の最終出力でなく、途中の層の視覚表現を読むほうが強い](2611.06918.md)** (P3) — VLA (Vision-Language-Action; 画像と言語から行動を出す model) は、visual encoder で画像を圧縮してから行動を推論するのが普通である。NEO-VLA は専用の encoder を持たず、画像を軽い patch convolution で token にして言語と同じ backbone に通し、行動を出す action expert が **backbone の異なる深さから表現を引く**。同条件の比較で encoder 付きに勝ち、full fine-tuning や scale を増やしても差は埋まらない。層ごとの probing (表現から情報を読み出せるかの検査) で、行動に効く信号は最終層よりずっと手前で最大になる。「action head は最終層だけを読む」前提を疑う根拠で、手元の VLA に中間層を読ませる変更は小さく試せる。評価は manipulation が中心で、運転での遅延は abstract に無い。
3. **[2611.06901 world model が背景だけを覚えて、動きを捨てる失敗とその対策](2611.06901.md)** (P3) — JEPA (Joint-Embedding Predictive Architecture; 画像を再構成せず latent 空間で次の状態を予測する world model) は、**背景のように予測しやすく episode ごとに違うものを表現に残し、操作に関係する変化を捨てる**ことがある (static collapse)。背景をランダム化するだけで planning 成功率が大きく落ちる。対策は、予測した遷移を同じ episode 内の別の候補遷移と比べる contrastive 学習 (似たものを近づけ違うものを離す学習) で、似た動きかどうかの教師に optical flow (画像間の画素の動き) を使う。成功率は 52% → 78% (背景ランダム化の Cube) と 14% → 54% (LIBERO-Object) に上がる。運転は背景が場所ごとに多様で動くものが少なく、同じ失敗が起きやすい。ただし自車が動く設定は未確認で、まず背景だけ入れ替えた対で latent の距離を測る診断から始められる。

## 全ブリーフへのリンク

- [2611.06453](2611.06453.md) — Failure-Boundary Profiles: 「通るべき / 止まるべき」を certify した closed-loop 評価 (P1 / fm_distill_finetune → P1 / 5.0)
- [2611.06710](2611.06710.md) — VLA の推論時間の内訳を 4 種の GPU (Jetson Thor を含む) で測り、最適化手法の積み方の指針 VLA-Triage を導く (P1 / next_arch → P1 / 4.0)
- [2611.06486](2611.06486.md) — Model merging で LoRA の rank を揃える必要はない。magnitude 選択の merge は特異値の小さい adapter を消す (P2 / fm_distill_finetune / 4.0)
- [2611.05811](2611.05811.md) — ReTailor: 凍結した model に小さな residual だけを自己教師で足し、未知の sensor に適合する (P2 / fm_distill_finetune / 4.0)
- [2611.06918](2611.06918.md) — NEO-VLA: encoder-free の VLA が backbone の中間層から行動を読む (P3 / fm_distill_finetune → P3 / 4.5)
- [2611.06901](2611.06901.md) — Motion-guided Contrastive Regularization: latent world model の static collapse を optical flow で防ぐ (P3 / next_arch / 4.5)
- [rejected.md](rejected.md) — 不採用 44 件と、持ち越せる次点 7 件

## プロジェクト別の要点

- **P1 (Planner AI + 評価)**: 2 本とも「見かけの数字の下を測る」話。2611.06453 は driving score が同じでも判断の仕方が違うことを曲線で示し、2611.06710 は高速化手法の効果が GPU の律速 (CPU の起動遅延 / メモリ帯域 / kernel 効率) で決まることを Jetson Thor を含めて測る。最小実験は、通路幅と対向車 gap の 2 family だけ再現して手元の planner の曲線を描くことと、手元の VLA を Thor の eager mode と CUDA graphs で動かして GPU 時間と CPU 時間を分けること。運転の候補は planner_ai がわずか 1 件で、それも交差点の信号制御 (Traffic-VL) だったため、P1 の枠は他 topic から補った。
- **P2 (FM 蒸留 + fine-tuning)**: 今日は蒸留の論文は無く、「適合を小さく保つ」話が 2 本。2611.06486 は、domain ごとの LoRA (低 rank の差分で行う軽量 fine-tuning) を束ねる merge で、大きさで選ぶ手法は特異値の小さい adapter を丸ごと捨て、IFEval が 16〜25 pp 落ちると示した。ReTailor は、凍結した model に残差だけを足し、ラベル無しで未知の sensor に素早く適合する。最小実験は、手元の複数 LoRA を単純平均と magnitude 選択で merge し、domain ごとの評価が片方だけ落ちていないか見ること。
- **P3 (次世代アーキテクチャ)**: 2 本とも、表現が「最後に圧縮された出力」に頼るのをやめる方向。NEO-VLA は行動に効く信号が中間層にあると示し、2611.06901 は world model が背景だけを残す失敗を直す。最小実験は、手元の VLA の action expert が読む層を変える比較と、背景だけ入れ替えた対で latent の距離を測る診断。次点の T2G (2611.05847; JEPA の planning cost を time-to-goal の順序で学習) と A3-VLA (2611.06447; VLA の attention を操作から自動生成した領域に揃える) は quota 超過で持ち越し。

## 運用メモ

- **fm_distill_finetune が今日も 30 件ちょうどで、max_results=30 の天井に当たっている。** 30 件の `published` は 11-03T23:10Z〜11-04T18:59Z の約 20 時間分で、それ以前の fm の新着は落ちている可能性がある。next_arch は 16 件、planner_ai は 1 件で天井ではない。**今日も RSS での回収は行っていない** (採用は candidates.json のみから選んだ)。fetch の log は確認していない。
- planner_ai が 1 件しかなく、運転の評価に当たる論文 (2611.06453) は fm_distill_finetune の側に入っていた。keyword だけで topic を割り当てる fetch 側の限界で、採用時に付け替えた。
- sns_wildcard 3 件は昨日 (2611.05 の rejected.md) と同じ id の再来。wildcard 経路に既読の除外が無い状態が続いている。`fetch_candidates.py` / `topics.yaml` は変更していない。
