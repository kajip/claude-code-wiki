---
type: source
source_id: claude-blog
title: Agentic coding is straining CI. Here's how we scaled test impact analysis at Anthropic
url: https://claude.com/resources/articles/agentic-coding-is-straining-ci-heres-how-we-scaled-test-impact-analysis-at-anthropic
published: 2026-09-14
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Agentic coding is straining CI. Here's how we scaled test impact analysis at Anthropic

## 要点

- Anthropic 社内では、エージェントによるコーディングで出荷するコードの量が大きく増え、CI の負荷が急増した。2021〜2025年と比べて四半期あたり約8倍で、その約80%を Claude が書いた。
- 変更ごとに実行するテストを選ぶ社内の test impact analysis サービスは、書き手が1つの構成だった。処理が遅れると、選ばれるテストが古いデータに基づいてしまう。
- 3回の応急処置（マシンの増強、shard 化、毎日の再起動）はどれも長く持たず、状態をプロセスの外に出す作り直しをした。書き込み側は状態を持たないワーカーにし、journal に追記したものを別の consumer が集約する。
- 監視には、社内版の Claude Tag で長時間動かしたセッションを使った。shard 化のコードは Claude が書き、運用時の規模の調整の多くも Claude が自律的に行った。
- 提言: 2四半期で約25倍の負荷を見込み、最初の版から10〜20倍の規模に耐えるよう設計する。エージェントが計測して改善を回せるよう、サービスに計測を仕込む。

## 具体的な値

- テストの数は10倍、CI のジョブは6か月で25倍になった。
- 応急処置が持った期間: コア数を倍にして70日、shard 化して29日。
- 監視の警告: listener の遅れが 50,000 ジョブを超えたとき。
- 作り直しは、エンジニア1人で3週間かかった。1年前なら約1四半期かかったと見積もっている。

## 関連ページ

- [[concepts/claude-tag]]

## 取り込みメモ

- 社内の事例で、公開された製品やプラグインは無い。
- 2026-10-10 の初回 Check では一覧の上位に出なかった。`?page=2` で見つけた。
