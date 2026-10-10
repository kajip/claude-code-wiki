---
type: concept
title: Claude Sonnet 5.5
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# Claude Sonnet 5.5

## 概要

Claude 5.5 ファミリーの2番目のモデル。2026-09-28 に発表された。Sonnet 5 より30%以上速く、多くの作業で最大30%安い（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。仕様がはっきりしていて、結果を確かめられる作業に向く（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。

## 現状（as of 2026-10-10）

- モデル ID は `claude-sonnet-5-5`（Bedrock では `anthropic.claude-sonnet-5-5`）。コンテキスト 1M、最大出力 128k（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- 価格（100万トークンあたり）: 入力 $2、出力 $10、キャッシュ書き込み $2.50（5分）／$4（1時間）、**キャッシュヒット $0.10**（入力単価の0.05倍）（[[sources/pricing/2026-10-10-pricing]]）。
- Claude Code: v2.1.284 から `sonnet` エイリアスが Sonnet 5.5 を指す。既定の effort は `medium`。thinking は切れず、fast mode も無い（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Claude Code の `/cost`、ステータスライン、`--max-budget-usd` は、2.1.296 からキャッシュ読み取りを $0.10 で計算する（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- Sonnet 5 からの移行: `thinking: {"type": "disabled"}` と強制の `tool_choice` は 400 エラーになる。`between_tools` と `auto`＋strict ツールに置き換える（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- thinking block は、作ったアカウントか、それに紐付くアカウントでしか効かない。別のアカウントから送ると、そのブロックは捨てられる（リクエストは成功する）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- Sonnet で初めてサイバーの安全策が入った。リスクの高いサイバー作業は Sonnet 5 に回される（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。→ [[concepts/cyber-safeguards]]

## 変更履歴

- 2026-10-09 — Claude Code 2.1.296 で、費用表示のキャッシュ読み取り単価を $0.10 に更新（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-07 — キャッシュ読み取り単価を $0.20 から $0.10 に引き下げ（入力単価の0.1倍から0.05倍へ）（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]、[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-28 — 発表、提供開始。キャッシュ読み取りは $0.20（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）

## 未解決・矛盾

- （なし）
