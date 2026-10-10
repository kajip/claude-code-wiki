---
type: concept
title: サイバー・安全策と Cyber Verification Program
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program
  - sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission
  - sources/anthropic-news/2026-10-08-2026-usage-policy-update
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
---

# サイバー・安全策と Cyber Verification Program

## 概要

Claude 5.5 ファミリーには、サイバーと bio の安全策がある。リスクのある依頼は拒否されるか、古いモデルに回される（fallback）。審査を通った組織には、Cyber Verification Program（CVP）で制限を緩めたアクセスが提供される（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）。

## 現状（as of 2026-10-10）

- Opus 5.5: サイバーの作業の多くは Opus 4.8 に回される（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- Sonnet 5.5: リスクの高いサイバー作業は Sonnet 5 に回される。普段のバグ修正には影響しない（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。
- Haiku 5.5: Haiku 4.5 より厳しく、Sonnet 5.5 より緩い。ペネトレーションテストはブロックされる（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
- Claude Code では `/config` の「Switch models when a message is flagged」で、回されたときの動きを変えられる。`/model` で戻せる（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- API では拒否が `stop_reason: "refusal"` と `stop_details`（`cyber` など）で返る（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- CVP は Defense／Red Team／Specialized の3段階。Project Glasswing を統合した（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）。
- オープンソース向けの無料のスキャン（OSS Scanner）が始まった（[[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]）。
- Usage Policy は 11月12日に改定が施行される。Claude Code で Claude が会話を終了できる機能に触れている（[[sources/anthropic-news/2026-10-08-2026-usage-policy-update]]）。

- 拒否の課金: 出力の前に拒否された場合、`bio`、`frontier_llm`、`reasoning_extraction` の3分類は課金される。ほかの分類（`cyber` など）は課金されない（2026-09-24 から）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。

## 変更履歴

- 2026-09-24 — 出力の前の拒否のうち3分類について課金を再開（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-08 — Usage Policy の改定を発表、Cyber Mission を発表（[[sources/anthropic-news/2026-10-08-2026-usage-policy-update]]、[[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]）
- 2026-10-06 — CVP を拡大し、Opus 5.5／Sonnet 5.5 を含めた（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）

## 未解決・矛盾

- CVP が Claude Code の利用にどう適用されるかは、取り込んだ出典には書かれていない。
