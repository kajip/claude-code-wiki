---
type: concept
title: Claude Managed Agents
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
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

- 権限ポリシーに `auto` がある。サーバーが各呼び出しを判定して、実行する、拒否する、承認を待つ、のどれかにする（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- `web_fetch` は、セッションにすでに現れた URL しか取得しない。networking が `limited` の環境では、`allowed_hosts` が web ツールにも適用される（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- dynamic workflows（**ベータ**）: 多数のエージェントを段階的に動かすプログラムを、エージェント自身に書かせて実行させられる（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。

## 変更履歴

- 2026-10-09 — dynamic workflows をベータで提供（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-07 — `web_fetch` の取得先を制限。`limited` networking で web ツールにも `allowed_hosts` を適用（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-10 — 権限ポリシー `auto` と `ant beta:sessions connect` を追加（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-05 — 2.1.290: `/claude-api managed-agents-onboard` を追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
