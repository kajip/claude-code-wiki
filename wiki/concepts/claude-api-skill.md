---
type: concept
title: claude-api スキル
updated: 2026-10-10
sources:
  - sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-10-08-building-effective-agent-automations
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# claude-api スキル

## 概要

Claude Code に同梱されるスキル。Claude API を使った開発を助けるサブコマンドを持つ（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。

## 現状（as of 2026-10-10）

- `/claude-api build-eval`、`/claude-api hillclimb`: 評価を作り、過学習を避けながらスコアを上げる（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。
- `/claude-api migrate this project to claude-sonnet-5-5`: モデルの差し替えとパラメータの変更を自動で行う（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- `/claude-api prompt-audit`: スキルや CLAUDE.md の悪い書き方を指摘する（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- `/claude-api managed-agents-onboard <url>`、`<quickstart-name>`: Managed Agents の構成を作る（2.1.290）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]、[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。
- ソース: github.com/anthropics/skills の `skills/claude-api`（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。

## 変更履歴

- 2026-10-05 — 2.1.290: `managed-agents-onboard` を追加。Managed Agents の例では、必要なとき以外は web ツールを切り、`auto` の権限ポリシーを使うよう変更（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
