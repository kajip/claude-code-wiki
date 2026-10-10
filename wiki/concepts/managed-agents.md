---
type: concept
title: Claude Managed Agents
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/claude-dev/2026-10-08-building-effective-agent-automations
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/engineering/2026-04-08-scaling-managed-agents
---

# Claude Managed Agents

## 概要

Anthropic の基盤で、サーバー側で動くエージェントを作る仕組み。vault（認証情報）、メモリストア、スケジュールされた deployment、予算の上限を持つ（[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。

## 設計思想（2026-04-08 の記事より。公開時点）

- エージェントを session（追記専用イベントログ）、harness（Claude を呼ぶループ）、sandbox（実行環境）に仮想化し、それぞれを独立に差し替え・失敗させられる設計。harness 自体は特定のものに固定しない meta-harness で、Claude Code も載せ得るハーネスの一例とされる（[[sources/engineering/2026-04-08-scaling-managed-agents]]）。
- 認証情報は sandbox から到達できない vault などに置く。MCP 呼び出しは専用プロキシ経由で行い、harness は資格情報を扱わない（同）。
- コンテナを必要時だけ起動する構成で、公開時点の p50 TTFT は約 60%、p95 は 90% 超短縮（同）。この値は公開時点のもので、現在の値は未確認。

## 現状（as of 2026-10-10）

- **ベータ**（[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。
- 資源は `ant apply <file>` で作る。手動で動かすには `ant beta:deployments run --deployment-id <id>`（同）。
- 予算: `budget.type: limit`、`max_list_cost`。上限に達すると `budget_reached` で一時停止する（同）。
- Claude Code からは `/claude-api managed-agents-onboard <url>` と `/claude-api managed-agents-onboard <quickstart-name>` で構成を作れる（2.1.290）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

- 権限ポリシーに `auto` がある。サーバーが各呼び出しを判定して、実行する、拒否する、承認を待つ、のどれかにする（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- `web_fetch` は、セッションにすでに現れた URL しか取得しない。networking が `limited` の環境では、`allowed_hosts` が web ツールにも適用される（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- dynamic workflows（**ベータ**）: 多数のエージェントを段階的に動かすプログラムを、エージェント自身に書かせて実行させられる（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。

## 変更履歴

- 2026-10-09 — dynamic workflows をベータで提供（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-07 — `web_fetch` の取得先を制限。`limited` networking で web ツールにも `allowed_hosts` を適用（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-10 — 権限ポリシー `auto` と `ant beta:sessions connect` を追加（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-06 — 2.1.290: `/claude-api managed-agents-onboard` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-04-08 — Engineering 記事で設計（brain / hands / session の分離）と TTFT 短縮（p50 約 60%）が公開された（[[sources/engineering/2026-04-08-scaling-managed-agents]]）

## 未解決・矛盾

- 記事の関数名（`execute`、`wake` など）が現行 API の公開名と一致するかは、platform-docs で未確認。
