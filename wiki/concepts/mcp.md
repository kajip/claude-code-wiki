---
type: concept
title: MCP（Model Context Protocol）
updated: 2026-10-10
sources:
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
---

# MCP（Model Context Protocol）

## 概要

Claude Code が外部のツールやデータにつなぐためのプロトコル。この期間に、プロトコル 2026-07-28 を既定でネゴシエーションするよう順次切り替わった（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-10）

- ローカル（stdio）のサーバーは、すべての環境でプロトコル 2026-07-28 を既定でネゴシエーションする（2.1.292）。claude.ai のコネクタも同じ（2.1.295）。`MCP_PROTOCOL_NEGOTIATION=legacy` で元に戻せる（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 最初に送るツール説明とサーバー指示の上限は 4,096 字（2.1.296）。tool search 経由で読み込む説明は 16,384 字（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- WebSocket（`ws`）のサーバーで 16 MiB を超えるメッセージを受け取ると、接続を閉じる（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- キャッシュを保つため、MCP をセッションの途中からつながないこと、使わないサーバーは切ることが推奨されている（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。

## 変更履歴

- 2026-10-10 — 2.1.296: 最初に送るツール説明の上限を 2,048 字から 4,096 字に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: claude.ai のコネクタも 2026-07-28 を既定に。tool search 経由の説明の上限を 2,048 字から 16,384 字に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: stdio のサーバーで 2026-07-28 を既定に（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
