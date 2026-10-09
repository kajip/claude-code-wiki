---
type: concept
title: サブエージェント
updated: 2026-10-10
sources:
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization
---

# サブエージェント

## 概要

メインの会話から作業を切り出して動かすエージェント。モデル、effort、スキル、compaction の設定を個別に持てる（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-10）

- モデル: `CLAUDE_CODE_SUBAGENT_MODEL` で全サブエージェントのモデルを決める。定義の `model:` の方が優先される（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。workflow エージェントだけは `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` で一括指定できる（2.1.296）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- effort: Agent ツールの `effort` パラメータ（2.1.292）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- compaction: frontmatter と `--agents` の `autoCompactWindow`（2.1.296）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- スキル: `skills` から先読みするのは最大32件（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 名前は最大256文字（2.1.292）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- fork したサブエージェントは、親のキャッシュから始まる（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。
- 検索やログ読みのサブエージェントには Sonnet か Haiku を使うことが推奨されている（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- dynamic workflow は、作業を並列のサブエージェントに分ける（[[sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization]]）。

## 変更履歴

- 2026-10-09 — 2.1.296: `autoCompactWindow` と `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` を追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-08 — 2.1.295: `skills` の先読みを最大32件に（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.292: Agent ツールに `effort` を追加。名前の長さを制限（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
