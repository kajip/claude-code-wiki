---
type: source
source_id: anthropic-news
title: Introducing Claude Sonnet 5.5
url: https://www.anthropic.com/claude-sonnet-5-5
published: 2026-09-28
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Introducing Claude Sonnet 5.5

## 要点

- Claude 5.5 ファミリーの2番目のモデル。Sonnet 5 より30%以上速く、多くの作業で最大30%安い。
- 単価は Sonnet 5 と同じだが、同じ作業に使うトークンが少ない。
- 既定の effort は、Claude Code と Claude アプリでは Medium、Claude Platform では High。
- thinking を切って使っていた場合は、移行前に新しい `between_tools` 設定へ切り替える必要がある。
- Sonnet で初めて、サイバーの安全策が入った。リスクの高いサイバー作業は Sonnet 5 に回される（fallback）。
- 保持された thinking（preserved thinking）が拡大され、thinking は作ったアカウントに結び付く。Claude Code でセッション中にアカウントを切り替える場合に影響する。

## 具体的な値

- API モデル ID: `claude-sonnet-5-5`。全プラットフォームで提供。zero data retention に対応。
- 価格（100万トークンあたり）: 入力 $2、出力 $10、キャッシュ読み取り $0.20、キャッシュ書き込み $2.50。
- ベンチマーク（Sonnet 5.5／Sonnet 5／Opus 5.5）: Terminal-Bench 4.0 は 70.6%／10.3%／66.4%。FrontierCode 1.1（Main）は 52.1%（Xhigh）、46.2%（Max）／42.4%／54.4%。CursorBench 4.0 は 55.5%／34.1%／57.8%。
- Claude Code の code-review スキル（サブエージェントを使う）は、Max effort で FrontierCode のスコアが下がる要因になっていたと注記がある。

## 関連ページ

- [[concepts/claude-sonnet-5-5]]
- [[concepts/effort]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- キャッシュ読み取りの $0.20 は公開時点の値。2026-10-07 に $0.10 へ引き下げられた（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
- コンテキスト長と最大出力は、このページには書かれていない。
