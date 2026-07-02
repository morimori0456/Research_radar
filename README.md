# Research Radar — 日次インプット加速システム

毎日自動で「読む価値のあるものだけ」を深掘りし、朝に数件のブリーフだけ読む状態を作る。
加速の本質は量ではなく、**読む95%を捨てること**。

## カスケード設計

```
Stage 1 (自動・安い)   arXiv収集              fetch_candidates.py
Stage 2 (絞って深く)   Claudeで選別+深掘り     deep_research.sh
Stage 3 (毎朝・あなた) DIGEST.md のTOP3だけ読む
```

- **Stage 1** は AI を使わず arXiv から候補を広く集めるだけ(数秒・無料)
- **Stage 2** は Claude が候補を選別し、選ばれた数件だけ1ページのブリーフに深掘り
- **Stage 3** はあなた。読むのは DIGEST の TOP3 だけ

扱うのは arXiv の公開情報のみ。生成物(ブリーフ)を git で蓄積し、
必要なら下流(実験化など)へ渡す。

## 構成

```
research_loop/
├── README.md
├── topics.yaml            # 追う分野の定義 (カテゴリ/キーワード/選別基準/上限)
├── fetch_candidates.py    # Stage1: arXiv収集 → candidates.json
├── deep_research.sh       # Stage2: Claudeで選別+ブリーフ生成
├── run_research.sh        # オーケストレータ (収集→深掘り→push)
├── pull_experiments.sh    # 下流: ブリーフから実験スクリプト雛形を生成 (任意)
└── briefs/YYYY-MM-DD/      # 出力: 各ブリーフ + DIGEST.md + rejected.md
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
