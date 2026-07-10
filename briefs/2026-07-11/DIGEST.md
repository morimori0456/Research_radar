# Daily Digest — 2026-07-11

候補 43件から 6件を選定 (max 6 を使い切り)。planner_ai 1 / fm_distill_finetune 2 / next_arch 2 / wildcard 1 (Vidu S1 が初出、残り 2件は 4日連続の再提示で却下)。

## 今日読むべき TOP3

1. **[WCog-VLA (2607.08375)](2607.08375.md)** — E2E 自動運転向け VLA (視覚+言語から行動を出すモデル) に world model を「意味レベル」と「生成レベル」の 2 階建てで埋め込み、NAVSIM の planning 指標 PDMS で SOTA 92.9 を出した論文。周辺車両を専用トークンで表し、「相手がこう動くなら自分はこう動く」というゲーム理論的な推論過程を 85k 件のアノテーションで明示的に教える。P3 が探している「VLA と world model の統合の仕方」への現時点で最も具体的な答えの一つ。
2. **[ZipDepth (2607.08771)](2607.08771.md)** — 6.1M パラメータ (teacher の 1/50) の単眼深度モデルが、foundation model からの蒸留で zero-shot 汎化 (未知ドメインで再学習なしに動く性質) をほぼ保持し、電力制約デバイスでも実時間で動く。鍵は「何を教えるか」ではなく「multi-domain の大規模データで教える」こと。P2 の蒸留 recipe として今日の本命で、Jetson 級エッジ推論の設計テンプレートになる。
3. **[Post-Training in E2E AD (2607.08072)](2607.08072.md)** — 専門家ログの模倣だけでは誤差蓄積・リカバリー行動の欠如・long-horizon 目的の非表現性を解決できない、として模倣後の追加学習 (post-training; LLM の RLHF に相当する段階の自動運転版) を教師信号の形式で 4 分類した初の統一サーベイ。P3 の学習ロードマップと P1 の「評価基盤を学習信号の供給源として使う」視点の両方に効く。

## 本日のブリーフ一覧

| ID | タイトル | Project | 点数 |
|---|---|---|---|
| [2607.08745](2607.08745.md) | AUTOPILOT-VQA: incident 中心の dashcam 映像理解ベンチマーク | P1 | 4 |
| [2607.08771](2607.08771.md) | ZipDepth: 6.1M で foundation model 級 zero-shot 深度をエッジに | P2 | 5 |
| [2607.08772](2607.08772.md) | Wat3R: アノテーションゼロの cross-domain 3D モデル適合 | P2 | 4 |
| [2607.08375](2607.08375.md) | WCog-VLA: dual-level world-cognitive VLA for E2E AD | P3 | 5 |
| [2607.08072](2607.08072.md) | Post-Training in E2E Autonomous Driving (サーベイ) | P3 | 4.5 |
| [2607.03118](2607.03118.md) | Vidu S1: 民生 GPU 42 FPS のリアルタイム対話型 video generation | EXPLORE | 3.5 (hf 107) |

却下 37件の理由は [rejected.md](rejected.md)。次点は FabriVLA (P3, 1B 級軽量 VLA, quota 落ち)・Super Weights (P2, 選択的学習の失敗という FT 知見)。

## プロジェクト別の要点

### P1: Planner AI + 評価
- **AUTOPILOT-VQA** で「安全クリティカルな状況を VLM が正しく推論できるか」を測る標準ベンチマークが手に入る。avoidability (回避可能性) を問う質問設計は、planner のインシデント事後検証と同型で評価語彙として輸入できる。
- **Post-Training サーベイ** (P3 選定) の含意: closed-loop 評価基盤は planner の採点装置であると同時に post-training の教師信号供給源。評価パイプラインの役割を再定義する視点。

### P2: FM 蒸留 + 適合
- **ZipDepth**: 蒸留の頑健性は teacher よりも「蒸留データの分布の広さ」で決まる、という示唆。自社パイプラインで蒸留データを multi-domain 化する ablation が最短の一手。reparameterization (学習時の複数分岐を推論時に単一 conv へ畳み直す技法) との組み合わせはエッジ配備の定石になり得る。
- **Wat3R**: ラベル不能ドメインへの適合は teacher-student + 幾何整合性 loss で回る、という recipe。「水中」を「悪天候・別センサ」に読み替えれば AD にそのまま持ち込める。適合先に評価基盤がなければまず小さく作る (Water3D 方式) という手順も実務的。

### P3: 次世代アーキテクチャ
- **WCog-VLA** が VLA × world model 統合の具体形を提示: 意味レベル (agent token + Game-CoT) と生成レベル (diffusion による joint trajectory 生成) を分けて持たせ、alignment で denoising を高速化。agent token と相互作用 CoT データ生成は小規模でも試せる。
- **Post-Training サーベイ**は次世代アーキテクチャを「事前学習 (模倣) + post-training」の 2 段構えで設計する根拠を与える。保有資産 (sim・報酬・選好データ) を 4 分類にマッピングして着手点を決めるのが第一歩。
- **Vidu S1** (探索枠): 民生 GPU で 540p/42 FPS・無限長・drift なしの対話型生成は、実時間 world model の推論コスト見積りの基準点。few-step 蒸留 + 専用サービングを対で設計する発想は world model の実時間化にも通じる。

## 運用メモ
- wildcard 枠は 4日連続で再提示が発生 (RynnWorld-4D はブリーフ済み、AlayaWorld は 3回目の却下)。今日は初出の Vidu S1 があったため選定は成立。fetch 側の既読 dedup 実装までは「briefs/ 配下の既存 id は既読」の選別側運用を継続する。
