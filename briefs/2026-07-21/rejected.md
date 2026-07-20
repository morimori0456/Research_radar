# 落選候補 — 2026-07-21

本日の候補は 3 件すべて `sns_wildcard` (分野外だが注目度が高い探索枠)。
ワイルドカードは最大 1 件までしか採らない規則のため、採用は 1 件 ([2607.11683 RAGU](2607.11683.md))。残り 2 件を以下に記録する。
なお 3 件とも過去のブリーフ・落選記録には無い**新規候補**で、昨日までの「重複再提示」は今日は起きていない。

---

- **2606.29538: RESOURCE2SKILL — Distilling Executable Agent Skills from Human-Created Multimodal Resources** (up=105)
  — タイトルの "distill" は **model distillation ではなく skill library の構築**を指す別語義。実体は tutorial 動画・repo・記事から software agent 用の再利用可能スキルを抽出し、hierarchical な Skill Wiki に整理して inference 時に retrieval/compose するエージェント基盤。P2 の蒸留とは問題設定が別物で、P1/P3 への接点も薄い。注目度は高いが、追っているプロジェクトへの転用価値が低く見送り。学びとしては「multimodal 資源を構造化知識に落とす」着想のみ。

- **2607.16051: Loop the Loopies! (Loopie)** (up=53)
  — looped Transformer (同じ層/ブロックを複数回ループさせて重みを使い回す構造) の MoE 版 (20B/active 2B、6B/active 0.6B)。「同計算予算なら param を N 倍する方がループ N 回より強い」という looped Transformer 積年の課題を克服したと主張し、P3 (efficient transformer / parameter 効率) には筋として合う。ただし **(1)** タイトル・命名・「IMO/IPhO で gold を tool なしで達成」という記述のトーンが戯画的で、**(2)** abstract に再現可能な recipe や具体的な ablation 条件がほぼ無く、信頼して手を動かす根拠にできない。同点タイブレークでも RAGU (up=105、P2 直結) に劣後。P3 でループ構造を追うなら、より査読・実装の裏取りが効く別論文を待つ。
