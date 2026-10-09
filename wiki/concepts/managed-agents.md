---
type: concept
title: Claude Managed Agents
updated: 2026-10-10
sources:
  - sources/claude-dev/2026-10-08-building-effective-agent-automations
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# Claude Managed Agents

## 概要

Anthropic の基盤で、サーバー側で動くエージェントを作る仕組み。vault（認証情報）、メモリストア、スケジュールされた deployment、予算の上限を持つ（[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。

## 現状（as of 2026-10-10）

- **ベータ**（[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。
- 資源は `ant apply <file>` で作る。手動で動かすには `ant beta:deployments run --deployment-id <id>`（同）。
- 予算: `budget.type: limit`、`max_list_cost`。上限に達すると `budget_reached` で一時停止する（同）。
- Claude Code からは `/claude-api managed-agents-onboard <url>` と `/claude-api managed-agents-onboard <quickstart-name>` で構成を作れる（2.1.290）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-05 — 2.1.290: `/claude-api managed-agents-onboard` を追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
