# Research Radar — 日次インプット加速システム

毎日自動で「読む価値のあるものだけ」を深掘りし、朝に数件のブリーフだけ読む状態を作る。
加速の本質は量ではなく、**読む95%を捨てること**。

> **操作方法・カスタマイズ・トラブル対応は [MANUAL.md](MANUAL.md) を参照。**
> **睡眠・運動・読書など人間側の習慣の導入は [HABITS_GUIDE.md](HABITS_GUIDE.md) を参照。**

## カスケード設計

```
Stage 1 (自動・安い)   arXiv収集 + SNS注目度    fetch_candidates.py
Stage 2 (絞って深く)   Claudeで選別+深掘り      deep_research.sh
Stage 3 (毎朝・あなた) DIGEST.md のTOP3だけ読む
週次   (日曜・自動)    テーマ統合+精読推薦      weekly_review.sh
```

- **Stage 1** は AI を使わず arXiv から候補を広く集める。加えて
  Hugging Face Daily Papers からコミュニティ注目度(upvotes)を取得し、
  各候補に注釈 + 分野外でも注目度の高い論文を wildcard 候補として追加(探索枠)
- **Stage 2** は Claude が候補を選別し、選ばれた数件だけ1ページのブリーフに深掘り。
  注目度は relevance を上書きしない副次シグナル。wildcard は最大1件/日
- **Stage 3** はあなた。読むのは DIGEST の TOP3 だけ
- **週次レビュー** が「読んだ」を「身についた」に変換する:
  テーマ統合 / 原論文を精読すべき1本の推薦 / 実験アイデアの未着手棚卸し /
  記憶チェック5問 / topics.yaml の調整提案

扱うのは arXiv / Hugging Face の公開情報のみ。生成物(ブリーフ)を git で蓄積し、
必要なら下流(実験化など)へ渡す。

## 構成

```
research_loop/
├── README.md
├── topics.yaml            # 追う分野の定義 (カテゴリ/キーワード/選別基準/上限)
├── fetch_candidates.py    # Stage1: arXiv収集 + HF注目度 → candidates.json
├── deep_research.sh       # Stage2: Claudeで選別+ブリーフ生成
├── run_research.sh        # オーケストレータ (収集→深掘り→push)
├── weekly_review.sh       # 週次: テーマ統合/精読推薦/実験棚卸し/記憶チェック/出力キュー
├── monthly_review.sh      # 月次: スキルマップ/基礎テーマ/ポートフォリオ監査/外部FB
├── pull_experiments.sh    # 下流: ブリーフから実験スクリプト雛形を生成 (任意)
├── briefs/YYYY-MM-DD/      # 日次出力: 各ブリーフ + DIGEST.md + rejected.md
├── weekly/YYYY-Wxx.md      # 週次出力: WEEKLYレビュー
├── monthly/YYYY-MM.md      # 月次出力: 方向修正レビュー
└── SKILL_MAP.md            # 月次で更新されるスキル自己評価 (根拠必須)
```

## セットアップ

```bash
# 1. GitHub にリポジトリを作り remote を設定
#    (トークンは会話等に貼らず、自分の端末で直接設定する)
git remote add origin https://github.com/<user>/<repo>.git

# 2. 追う分野を編集
$EDITOR topics.yaml

# 3. 手動で1回テスト
./run_research.sh

# 4. cron で毎晩自動実行 (例: 深夜3時)
#    crontab -e に:
#    PATH=<claudeのパス>:/usr/bin:/bin
#    0 3 * * * /path/to/research_loop/run_research.sh >> ~/research_loop.log 2>&1
```

無人 push のために、初回に `git config --global credential.helper store` で
認証情報を永続化しておく。

## 下流で実験化する場合 (任意)

蓄積したブリーフを別マシン/別リポジトリで実験スクリプトに落とす:

```bash
git clone https://github.com/<user>/<repo>.git ~/research_radar

export RESEARCH_REPO=~/research_radar          # このリサーチリポジトリ (read-only扱い)
export EXPERIMENT_REPO=~/work/<実験repo>        # 実験スクリプトの置き場

./pull_experiments.sh          # 今日のブリーフから実験雛形を生成
```

情報は「リサーチ → 実験」の一方向にだけ流す。

## Claude Code の /loop で回す場合 (cronの代わり)

```
/loop 毎晩: run_research.sh を実行し、生成された最新の DIGEST.md を読んで、
TOP3の中で最も重要な1件について、なぜ試す価値があるかを2文で追記してから終了
```

cron が確実・無料なので基本は cron 推奨。定型処理に司会役の知能は不要で、
知能が要る箇所(Stage 2 の deep research)だけ内部で `claude -p` を呼ぶ。

## 運用ルール

1. **1日の deep research は上限内に** — topics.yaml の `max_deep_per_day` で制御。
   上限に張り付くなら選別基準が甘い証拠
2. **ブリーフは1件1ページ厳守** — 深掘りしても要約は短く。読む時間を守る
3. **週1で topics.yaml を見直す** — 追う分野がずれたら更新。ここだけが手作業
4. **捨てたものも rejected.md に記録** — 選別基準を後で検証できるように
5. **topics.yaml の編集は1箇所に統一** — 複数マシンで別々に編集すると git が枝分かれする。
   cron を回すマシンに寄せるのが安全
