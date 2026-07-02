# Deep Research Loop — 日次インプット加速システム

毎日自動で「読む価値のあるものだけ」を深掘りし、朝に3件のブリーフだけ読む状態を作る。
加速の本質は量ではなく、**あなたが読む95%を捨てること**。

## アーキテクチャ (機密境界をgitで分離)

```
個人側 (このNUC + 個人Claude Pro)
  arXiv収集 → 選別 → deep research → briefs/ → 個人GitHubへpush
                                                    │
                                          公開情報(論文)のブリーフのみ
                                                    ▼
会社側 (会社PC)
  個人GitHubをpull → ブリーフを読む → 実験スクリプト生成 (Claude→Thor→Codex)
                                     → 社内リポジトリ (個人側へは戻さない)
```

- **個人側は公開情報だけ** — arXiv 論文のリサーチ。社内データを一切扱わないので
  個人契約の Claude Pro / 個人GitHub を使ってよい
- **会社側で初めて社内資産に接続** — pull したブリーフを起点に実験スクリプト化。
  ここから先は社内リポジトリに閉じる (thor_pipeline へ接続可能)
- **一方通行** — 情報は個人→会社の向きにだけ流れる。社内コードは個人側へ戻さない

## カスケード (個人側の中身)

```
Stage 1 (自動・安い)   arXiv収集              fetch_candidates.py
Stage 2 (絞って深く)   個人Claudeで選別+深掘り  deep_research.sh
Stage 3 (毎朝・あなた) DIGEST.md のTOP3だけ読む
```

## 構成

```
research_loop/                    ← 個人GitHubにpushするリポジトリ
├── README.md
├── topics.yaml            # 追う分野 (P1/P2/P3対応)
├── fetch_candidates.py    # Stage1: arXiv収集 → candidates.json
├── deep_research.sh       # Stage2: 個人Claudeで選別+ブリーフ生成
├── run_research.sh        # 個人側オーケストレータ (収集→深掘り→push)
├── pull_experiments.sh    # 会社PCに置く: pull→実験スクリプト化
└── briefs/YYYY-MM-DD/      # 出力: 各ブリーフ + DIGEST.md + rejected.md
```

## セットアップ

### 個人側 (このNUC)

```bash
# 1. 個人GitHubにリポジトリを作り、remoteを設定
#    (トークンは会話に貼らず、自分の端末で直接設定)
git init && git remote add origin https://<個人GitHub>/research_loop.git

# 2. トピックを編集
$EDITOR topics.yaml

# 3. 手動テスト
./run_research.sh

# 4. cron で毎朝7時 (または Claude Code の /loop)
#    0 7 * * * cd ~/w/research_loop && ./run_research.sh >> ~/research_loop.log 2>&1
```

### 会社側 (会社PC)

```bash
# 個人リサーチリポジトリを clone しておく
git clone https://<個人GitHub>/research_loop.git ~/research_loop

export RESEARCH_REPO=~/research_loop           # 個人リサーチ (read-only扱い)
export EXPERIMENT_REPO=~/work/<社内実験repo>    # 実験スクリプトの置き場

# 毎朝 or 好きなタイミングで
./pull_experiments.sh          # 今日のブリーフから実験雛形を生成
```

## Claude Code の /loop で回す場合 (個人側)

```
/loop 毎朝7時: ~/w/research_loop/run_research.sh を実行し、
生成された最新の DIGEST.md を読んで、TOP3の中で最も重要な1件について
なぜ今週試す価値があるかを2文で добавить してから終了
```

## 運用ルール

1. **1日の deep research は最大5件** — topics.yaml の max_deep_per_day で制御。
   それ以上は選別が甘い証拠
2. **ブリーフは1件1ページ厳守** — 深掘りしても要約は短く。読む時間を守る
3. **週1で topics.yaml を見直す** — 追う分野がずれたら更新。これはあなたの判断仕事
4. **捨てたものも rejected.md に記録** — 選別基準を後で検証できるように
5. **個人側に社内データを混ぜない** — この境界が崩れると設計の意味がなくなる
