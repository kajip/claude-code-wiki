---
type: concept
title: fast mode
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# fast mode

## 概要

同じモデルのまま出力を速く返すモード。Opus 5.5 では最大2.5倍速く、単価は高くなる（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

## 現状（as of 2026-10-10）

- Opus 5.5 の fast mode: 入力 $8、出力 $40（100万トークンあたり）。Claude Code と Claude Platform で使える（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]、[[sources/pricing/2026-10-10-pricing]]）。
- 価格ページでは、2026-10-10 時点でも**研究プレビュー**。対象は Opus 5.5、Opus 5、Opus 4.8。API では Claude API（first-party）だけで使え、Batch API では使えない（[[sources/pricing/2026-10-10-pricing]]）。
- Opus 5.5 の公開時点では**研究プレビュー**。extra usage を有効にしておく必要がある。Claude Code では `/fast` で有効にする（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- キャッシュを保つため、セッションの最初に有効にすることを推奨（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- Sonnet 5.5 には fast mode が無い（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Claude Tag（Slack）でも `!fast`／`!fast off` で切り替えられる（2.1.290）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-09-22 — Claude API で Opus 5.5 の fast mode を研究プレビューとして提供開始（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-05 — 2.1.290: Claude Tag で fast mode に対応（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
- 解決済み（2026-10-10）: 研究プレビューを終えたかどうか → 価格ページでは研究プレビューのまま（[[sources/pricing/2026-10-10-pricing]]）。
