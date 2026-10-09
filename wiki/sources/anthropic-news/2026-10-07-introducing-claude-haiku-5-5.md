---
type: source
source_id: anthropic-news
title: Introducing Claude Haiku 5.5
url: https://www.anthropic.com/claude-haiku-5-5
published: 2026-10-07
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Introducing Claude Haiku 5.5

## 要点

- Claude 5.5 ファミリーの小型モデル。要約、compaction、分類のように量が多くコストに敏感な処理と、Opus 5.5／Sonnet 5.5 の下で動くサブエージェントを想定している。
- Haiku 4.5 と比べて、運用コストは平均で約75%安い。100K トークンまでの単価は90%安く、100K を超えると50%安い。
- Haiku クラスで初めて effort を調整できる（Low／Med／High／Xhigh／Max）。
- 複雑なエージェント型コーディングには Sonnet 5.5 や Opus 5.5 の方が向くと本文にある。
- サイバー分野の安全策は Haiku 4.5 より厳しく、Sonnet 5.5 より緩い。ペネトレーションテストは引き続きブロックされる。
- 同日、Sonnet 5.5 のキャッシュ読み取り単価を $0.20 から $0.10 に下げたと表に記載されている。

## 具体的な値

- API モデル ID: `claude-haiku-5-5`。AWS、Google Cloud、Microsoft Azure を含む全プラットフォームで提供。
- 価格（100万トークンあたり。100K 以下／100K 超）: 入力 $0.10／$0.50、出力 $0.50／$2.50、キャッシュ読み取り $0.01／$0.05、キャッシュ書き込み $0.125／$0.625。
- 比較: Haiku 4.5 は入力 $1.00、出力 $5.00。Sonnet 5.5 はキャッシュ読み取り $0.10（$0.20 から引き下げ）。
- トークナイザーが更新され、同じタスクでやや多くのトークンを使う。
- ベンチマーク（Haiku 5.5／Haiku 4.5／Sonnet 5.5）: Terminal-Bench 4.0 は 39.2%／0.0%／70.6%。OSWorld 2.1（offline subset）は 72.4%／15.7%／83.9%。FrontierCode 1.1（Main）は 46.4%／—／52.1%（Xhigh）。
- プラン: Max 5x には月 $100、Max 20x には月 $200 の API クレジット。Team には最大 $500 を利用者全員で共有。
- SDK（Python／TypeScript）での computer use と browser use の対応は**ベータ**。
- システムカード: anthropic.com/claude-haiku-5-5-system-card

## 関連ページ

- [[concepts/claude-haiku-5-5]]
- [[concepts/claude-sonnet-5-5]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- コンテキスト長と最大出力は記事に書かれていない。1M コンテキストは CHANGELOG 2.1.293 の記述（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 本文に Claude Code への言及は無い。
