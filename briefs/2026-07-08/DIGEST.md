# Daily Research Digest — 2026-07-08

本日候補 **52件**(P1: 1 / P2: 30 / P3: 18 / wildcard: 3)→ **選定6件**(max_deep_per_day 上限いっぱい)・却下46件。
**4日ぶりに P1/P2/P3 の本枠候補が復活**した豊作日。P3 は 5点級が 4本あり quota 2 に入り切らず、うち1本 (UNIVERSE) は fetch の P2 分類を活かして P2 枠で採用した。
運用メモ: wildcard の 2606.29526 (MIPI/MIPU) は**昨日ブリーフ済みの再提示**(既読除外)。fetch の既読 ID dedup は未実装のまま([[fetch-duplicate-candidates]] 更新済み)。

---

## 今日読むべき TOP3

1. **[UNIVERSE — 単一 DiT に video と action を統合した自動運転 world action model](2607.05133.md)**(P2枠/P3交差, relevance 4/5)
   world model (将来の映像を予測して環境のダイナミクスを学ぶモデル) と E2E planner を別モジュールにするか統合するかという P3 の中心論争に、「単一の Diffusion Transformer で video と自車軌跡を co-training し、attention mask で未来情報の漏れだけ遮断する」という明快な答えを出した。video 予測という密な教師信号が軌跡生成側の過学習を抑え、**fine-tuning なしで別データセットへ zero-shot 転移**する点は P2 (ドメイン適合) にも直撃。推論時は video 側を丸ごと外せて 4.3 倍高速というのも車載向けに現実的。今日の6本で最も P2/P3 両方に効く。

2. **[PixelPilot — 行動を画像平面で表現してスケールさせる自動運転 VLA](2607.04637.md)**(P3, relevance 5/5)
   VLA (視覚・言語から行動を直接出すモデル) が抱える2つの実務的な急所 — カメラパラメータと結合して異種データセット混合学習がスケールしない問題と、視覚を無視して自車状態だけで軌跡を出す「近道学習」— を、**軌跡予測を画像平面上の 2D タスクに再定式化し 3D 化は推論時に回す**ことで同時に解いた。open-loop (記録データ上の誤差評価) と closed-loop (シミュレータ内で実走行させる評価) の両方で SOTA。異種データを混ぜて学習させたい P3 の学習戦略にすぐ効く。

3. **[InternVLA-A1.5 — frozen video 生成モデルから world model の事前知識を latent 蒸留で継承する VLA](2607.04988.md)**(P3, relevance 5/5, hf 18)
   将来予測を pixel 生成としてゼロから学ぶ代わりに、少数の foresight tokens (タスクに関係する未来を圧縮する学習可能トークン) を**凍結済み video 生成モデルの教師信号で学習**し、推論時は video 側を破棄してリアルタイム性を保つ。さらに行動学習中も VQA (画像への質問応答) を混流して VLM の意味理解を壊さない。「world model の恩恵だけもらって推論コストは払わない」という設計は、車載制約下で world model を使いたい P3 にとって最も参考になる処方箋。P2 の忘却対策とも同型。

---

## 全ブリーフ一覧

| id | タイトル | 判定 | project | relevance | hf |
|---|---|---|---|---|---|
| [2607.05369](2607.05369.md) | GaP: Graph-as-Policy Multi-Agent Self-Learning Harness | ✅ selected | P1 | 3/5 | 0 |
| [2607.04812](2607.04812.md) | TGRIP: Text-Guided Vehicle Instance Prediction | ✅ selected | P2 | 4/5 | 0 |
| [2607.05133](2607.05133.md) | UNIVERSE: Unified Video Action Models for AD | ✅ selected | P2 (P3交差) | 4/5 | 0 |
| [2607.04637](2607.04637.md) | PixelPilot: Scalable VLA for End-to-End AD | ✅ selected | P3 | 5/5 | 0 |
| [2607.04988](2607.04988.md) | InternVLA-A1.5: Understanding + Latent Foresight + Action | ✅ selected | P3 | 5/5 | 18 |
| [2607.04425](2607.04425.md) | UI-MOPD: Multi-Platform On-Policy Distillation | ✅ selected | EXPLORE (P2接続) | 3/5 | 62 |
| 2606.29526 | MIPI/MIPU (昨日ブリーフ済み) | ⏭ 既読除外 | EXPLORE | — | 154 |
| — | 上記以外の45件 | ❌ rejected | — | — | — |

却下の詳細理由と次点(Multiplayer World Models, VLM-CASE, LP-SFT 等)→ [rejected.md](rejected.md)

---

## プロジェクト別の要点

### P1(Planner AI + 評価)
- **[GaP](2607.05369.md)**: プランナーを解釈可能な計算グラフとして生成し、自動生成した closed-loop simulation で rehearsal → 反復改良するループ。**失敗シナリオから回帰テスト用のシミュレーション課題を自動生成する**という運用アイデアが今日の持ち帰り。
- 評価の観点では選外からも2点: [PixelPilot](2607.04637.md) の ego-status 近道学習対策は「open-loop 指標が近道学習に欺かれる」という P1 の既知課題への処方で、ego-status ablation は自社評価スイートに安く足せる。rejected の Pinocchio (2607.04681) は AD での reasoning faithfulness 評価、operator-on-F (2607.04464) は world model の planning-time 診断で、いずれも評価手法メモとして記録。

### P2(Foundation Model 蒸留 + 適合)
- **[TGRIP](2607.04812.md)**: VLM teacher の意味知識を semantic BEV map という**タスク空間の中間表現**経由で車載ネットに蒸留する recipe。teacher/student のアーキが違っても成立し capacity gap に強い。annotation 不要の dense supervision としてコスト評価する価値あり。
- **[UNIVERSE](2607.05133.md)**: video co-training がデータセット固有バイアスへの過学習を抑える**転移の正則化**として働く実証。転移先データが少ない案件で試す手が増えた。
- **[UI-MOPD](2607.04425.md)** (探索枠): 「機種ごとの teacher 群 → 機種条件付けした単一 student への on-policy 蒸留」は、P2 の**他機種適合 + 忘却防止**問題と構造が同じ。車種 A/B teacher → shared student の試作実験まで落とし込める。
- 次点メモ: LP-SFT (SFT 中の元能力保護 loss)、Wrong Before Right (圧縮失敗の事前診断)、DPRD (5% パラメータの relational KD) は rejected.md に理由付きで保留。

### P3(次世代アーキテクチャ)
- 今日の3本 ([UNIVERSE](2607.05133.md) / [PixelPilot](2607.04637.md) / [InternVLA-A1.5](2607.04988.md)) で「**world model と行動生成の統合方法**」の設計空間が綺麗に埋まった: (a) 単一 backbone で co-training し推論時にモダリティを脱着 (UNIVERSE)、(b) 行動表現の座標系を変えてスケールと近道学習を解決 (PixelPilot)、(c) frozen video 生成モデルから latent 蒸留で事前知識のみ継承 (InternVLA)。次世代アーキ検討の比較軸としてこの3方式を並べた実験計画を推奨。
- 惜しくも選外の **Multiplayer World Models (2607.05352, hf 12)** は「他エージェントを環境でなく行動条件として扱う」multi-agent world model で、多エージェント環境そのものである自動運転に直結する問い。時間があれば読む価値が高い(→ [rejected.md](rejected.md) 冒頭)。

---

## 運用アクション
- **fetch の既読 dedup**([[fetch-duplicate-candidates]]): 本枠候補の取得は4日ぶりに回復したが、briefs 済み ID (2606.29526) の再提示が発生。fetch_candidates.py に「briefs/*/ に存在する id を除外」する処理を入れるのが根本対応。それまで選別側の既読扱い運用を継続。
- **topic 分類の誤配**: UNIVERSE (P3 内容 → P2 分類) のように keyword マッチによる誤配が quota を歪める。今回は逆に P3 の枠不足を吸収できたが、fetch 側で複数 topic ヒット時の優先順位付けを検討する余地あり。
