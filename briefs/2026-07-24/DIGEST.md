# DIGEST — 2026-07-24

> 候補 45 件。採用 **5 件(P1×1・P2×2・P3×2)**。max_deep_per_day=6 に対し 5 件で止まる。
> **理由:** P1 は候補が 1 件しか来ず(quota 2 だが在庫不足)、wildcard 3 件は **全て過去ブリーフ済みの重複再提示**で無効([[fetch-duplicate-candidates]] 症状が今日も再現)。よって quota・在庫・重複で埋まる上限が 5 件。
> 本日のテーマは **「モデルは覚えている/効いている、が *どこで* 効くかを測って選別せよ」**。distillation は半分のデータが有害(P2)、world model は覚えていて actor が忘れる(P3)、world model 評価は抽出器の誤差と本体を分離せよ(P3)——**「一様に効かせる」思考をやめて成分/サンプル単位で切り分ける**論文が並んだ。

---

## 今日読むべき TOP3

### 1. When Does Knowledge Distillation Hurt? — 蒸留データの約半分は student を悪化させている(P2、本命)
knowledge distillation(大きな teacher の出力分布を小さな student に写す圧縮)を「全データで一様にかける」現状への直撃。Bangla 要約で **訓練サンプルの約 51% が student の validation loss を実際に悪化**させ、標準 KD の利得はほぼゼロ(+0.0003 ROUGE-L)だと実測した。効く理由が我々に直結で、**gradient alignment(その蒸留の勾配が validation を下げる方向と揃うか)で有害サンプルを弾く gate** を入れるだけで +0.017、さらに capacity-proportional constraint(teacher と student の能力差=capacity gap に応じて制約を効かせる)で 60M student が 50 倍大きい Qwen2.5-3B を上回る。**明日できる:** 我々の蒸留パイプで per-sample の KD 有用性を測り「有害比率」を出す——半分近ければ recipe を選別型に切り替える価値が確定する。→ [ブリーフ](2607.19956v1.md)

### 2. The World Model Remembers, the Actor Forgets — 忘れているのは記憶でなく出力経路(P3、本命)
「continual learning でどの構成要素が忘れるのか」を初めて実測。DreamerV3 系(world model = 環境を潜在空間で予測し、その"夢"の中で policy を学ぶ)で連続タスクを学ぶと、**world model は旧タスクの reward・value・終了構造をほぼ完全に保持(retention ≈ 1.0)し、actor の振る舞いだけが崩壊**する。しかも world model を凍結して夢の中で RL しても回復せず(0/3)、**world model 自身の"採点済みの夢"への self-imitation** なら環境と一切対話せず 3/3 回復。忘却対策のリソースを replay 容量でなく **policy 更新経路(dream rehearsal)** に振れ、という具体的な結論が持ち帰り。事前登録で棄却仮説まで報告する誠実さも◎。→ [ブリーフ](2607.19749v1.md)

### 3. KineBench — world model 評価から「抽出器の誤差」を追い出す(P3、横断で P1 にも効く)
embodied world model(行動に応じた未来映像を生成するモデル)の物理妥当性評価は、生成映像から行動を逆推定する **IDM (Inverse Dynamics Model)** に依存し、IDM が分布外で壊れると「world model が悪いのか抽出器が悪いのか」区別できない(attribution ambiguity)。KineBench は IDM をやめ、**汎用視覚基盤モデルで手先の 6D pose を直接抽出 → 物理シミュで再実行**して closed-loop 検証する。これは我々の NAVSIM 系「closed-loop 評価で抽出器誤差と本体を分離したい」という論点そのもの。visual OOD スイート(訓練外の見た目)で world model がどこで破綻するかを段階的に測れるのも実用的。→ [ブリーフ](2607.19876v1.md)

---

## 全ブリーフ

| topic | id | title |
|---|---|---|
| P1 planner | [2607.19971](2607.19971v1.md) | Unified Prediction & Planning via DPT(prediction/planning の Skill Conflict を model-merging で分離) |
| P2 distill/ft | [2607.19956](2607.19956v1.md) | When Does KD Hurt(有害サンプルを gradient alignment で選別する reliability-aware distillation) |
| P2 distill/ft | [2607.19604](2607.19604v1.md) | Scaling Laws for Hypernetwork Knowledge Injection(hypernetwork が LoRA を生成、OOD で急な scaling) |
| P3 next_arch | [2607.19749](2607.19749v1.md) | World Model Remembers, Actor Forgets(dream rehearsal で continual world-model RL) |
| P3 next_arch | [2607.19876](2607.19876v1.md) | KineBench(IDM-free kinematic grounding で embodied world model を closed-loop 評価) |

落選 40 件の理由(近い次点 🔶 付き)+ wildcard 重複の記録: [rejected.md](rejected.md)

---

## プロジェクト別の要点

- **P1(Planner AI + 評価):** 在庫難で本枠採用は DPT([[2607.19971]])1 件のみ。持ち帰りは **「prediction と planning を1 backbone に載せると重みを奪い合う(Skill Conflict)」**という診断視点と、「タスク別に核パラメータを分離 → sparse merge」という解。加えて横断で **KineBench([[2607.19876]])の "closed-loop 評価から抽出器誤差を分離する" 発想**が NAVSIM の過保守/帰属曖昧さ論点に直撃。**明日立てられる実験:** 現行 unified モデルで prediction loss と planning loss の層別勾配コサインを取り、負(競合)になる層を可視化して Skill Conflict の実在を確認。

- **P2(FM 蒸留 + 適合):** 2 件とも「一様に適用」からの脱却。KD Hurt([[2607.19956]])は **サンプル単位の有害性選別 + capacity gap 対策(capacity-proportional constraint)** を、再現可能な recipe として提供——我々の蒸留の「有害データ比率」をまず測るのが第一手。Hypernetwork scaling([[2607.19604]])は **適合を「対象ごとに LoRA を都度学習」から「hypernetwork が adapter を生成」へ** amortize する道と、その投資対効果を測る scaling law を与える。多機種・多ドメイン展開のコスト構造を変えうる。次点に StatLoRA・PortLLM・PSDA と PEFT/DA の良球が渋滞しており、明日以降の枠で拾う価値あり。

- **P3(次世代アーキ):** world model を「作る」より「**どこが忘れ/壊れるかを測って直す**」年次。World Model Remembers([[2607.19749]])は忘却対策のリソース配分を actor 側(dream rehearsal)へ振れと示し、KineBench([[2607.19876]])は物理妥当性を IDM 抜きで測る評価土台を与える。driving world model を 30–60 秒 rollout で使う我々にとって、**「潜在は覚えている(P3 の設計判断)」と「評価の帰属を切り分ける(P1 と共有)」** の 2 点が今日の核。次点 Koopman Dreamer([[2607.19719]])は long-horizon rollout 安定化の構造として近日拾いたい。

---

## 運用メモ(パイプライン)
- **wildcard dedup が依然未修正。** 本日も探索枠 3/3 が重複で無効化され、視野拡大の機会を丸ごと損失。arXiv 取得失敗の握り潰しと wildcard の dedup 欠如は、既ブリーフ ID を candidates 生成時に除外する形で塞ぐべき([[fetch-duplicate-candidates]])。判断待ちのまま 3 日連続で症状が出ている。
