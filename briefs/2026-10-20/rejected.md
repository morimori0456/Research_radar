本流 (planner_ai / fm_distill_finetune / next_arch) の候補は 0 件。candidates.json は sns_wildcard 3 件のみ。wildcard 枠は最大 1 件なので、P3 に最も近い 1 件を採用した。

- 2610.23479: HexaShell: A Thin Harness for Exploring the Limits of VLM Agents as Robot Coding Agents — 次点。VLM の coding agent が robot を操作し、失敗ログから tool (プログラム) を書き直す構成で RoboDojo 42 task の success 39.7%。三角測量ベースの tool 化は面白いが、手法が manipulation 専用の幾何処理で、運転・蒸留・world model への転用が薄い。採用枠が 1 件のため見送り
- 2610.20424: BizBench: Unveiling Hidden Challenges in Deploying Long-Horizon Agents for Real-World Business — 決済業務の long-horizon agent を対象にした benchmark。「最終成功だけでなく途中の制約違反を測る」という発想は planner evaluation と似ているが、題材が業務 policy と tool 呼び出しで、運転の評価に具体的に使える部分がない。見送り
