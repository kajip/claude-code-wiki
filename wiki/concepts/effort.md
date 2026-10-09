---
type: concept
title: effort（思考量の設定）
updated: 2026-10-10
sources:
  - sources/docs/2026-10-10-prompt-caching
  - sources/claude-dev/2026-09-25-spending-your-effort
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# effort

## 概要

タスクにどれだけ計算を使わせるかの目安。上げると、判断と検証を自分で進める度合いが増える（[[sources/claude-dev/2026-09-25-spending-your-effort]]）。

## 現状（as of 2026-10-10）

- 段階: `low`、`medium`、`high`、`xhigh`、`max`（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Claude Code での既定: Opus 5.5 は medium（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）、Sonnet 5.5 も medium（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。Claude API での Sonnet 5.5 の既定は high（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- 変え方: `/effort`（会話の途中でも可）（[[sources/claude-dev/2026-09-25-spending-your-effort]]）、`/effort status`（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- 2.1.292 で、Agent ツールに `effort` パラメータが追加され、サブエージェントの effort を指定できる（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- キャッシュとの関係（Claude Code）: Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 を API キーかサブスクリプションで使う場合は、effort を変えてもキャッシュが残り、確認なしで適用される。ほかのモデルでは、キャッシュが温かいうちは変更の前に確認を求める。Bedrock、Google Cloud's Agent Platform、Claude apps gateway、`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` を設定した場合、HIPAA の構成では、5.5 世代でもキャッシュが消える（[[sources/docs/2026-10-10-prompt-caching]]）。
- Claude API を直接使う場合は、Sonnet 5.5 でトップレベルの effort を変えるとキャッシュが無効になる。1ターンだけ変えたいときは per-message effort（ベータ）を使う（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Haiku 5.5 も effort を調整できる（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。

## 変更履歴

- 2026-10-10 — キャッシュとの関係を、ドキュメントの記述に合わせて書き直した。Sonnet 5.5 と Haiku 5.5 でも Claude Code ではキャッシュが残ることを確認した（[[sources/docs/2026-10-10-prompt-caching]]）
- 2026-10-06 — 2.1.292: Agent ツールに `effort` を追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
- 解決済み（2026-10-10）: Sonnet 5.5 で effort を変えたときにキャッシュが残るかどうか、ブログどうしで書き方が分かれていた（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]、[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。ドキュメントでは、Claude Code を API キーかサブスクリプションで使う場合は残るとされる（[[sources/docs/2026-10-10-prompt-caching]]）。API の記事は Claude API を直接使う場合の説明と読める（推測）。
