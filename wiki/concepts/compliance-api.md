---
type: concept
title: Compliance API
updated: 2026-10-21
sources:
  - sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20
---

# Compliance API

## 概要

Claude Enterprise の監査や eDiscovery のために、組織内での Claude の利用内容とメタデータを取得する API。Claude Code のセッションも取得対象に含まれる（[[sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code]]）。

## 現状（as of 2026-10-21）

- Cowork（デスクトップ、web、モバイル）と Claude Code（CLI、デスクトップ）のセッション取得は GA（2026-08-26 の追記）（[[sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code]]）。
- セッション記録は、プロンプト、応答、ツール呼び出し（web と MCP）、skills と artifacts の内容と、ユーザー ID・メール・組織 ID・各種 ID・タイムスタンプのメタデータからなる（同上）。
- 公開時点の対象外: Claude Code on the web、Claude Platform 経由の Claude Code、Bedrock / Vertex AI / Foundry 上のセッション（同上。現在も同じかは未確認）。
- 認証は既存の Compliance Access Key。OpenTelemetry のエクスポートとは併用できる（同上）。
- そのほかの対象: Claude in Chrome のセッション（2026-09-18、ベータ）、Microsoft 365 のローカルセッション（09-24、GA）、統合された Claude の体験のチャット（10-08、ベータ）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- Microsoft 365 アドイン（Excel、Word、PowerPoint、Outlook）と Claude Science はベータ（2026-08-26 の追記）（[[sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code]]）。
- claude.ai の **Instructions for Claude** と Cowork の **Global instructions** を取得できる（Enterprise 向け**ベータ**、10-15）。`GET /v1/compliance/organizations/{org_uuid}/user_preferences`、スコープ `read:compliance_user_data`、既存の Compliance Access Key（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。

## 変更履歴

- 2026-10-15 — ユーザーの Instructions for Claude／Global instructions の取得を追加（ベータ）（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- 2026-10-08 — 統合された Claude の体験のチャットを追加（ベータ）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- 2026-09-24 — Microsoft 365 のローカルセッションが GA（同上）。
- 2026-09-18 — Claude in Chrome のセッションを追加（ベータ）（同上）。
- 2026-08-26 — Cowork と Claude Code が GA。M365 アドインと Claude Science がベータ（[[sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code]]）。
- 2026-08-11 — Cowork と Claude Code のセッション用エンドポイントをベータで追加（同上）。

## 未解決・矛盾

- 2026-08-26 の「M365 アドインはベータ」と、platform-docs の「M365 のローカルセッションは 09-24 に GA」は、対象の呼び方が異なり、同じものか不明。docs 側の記載を優先するが、対応関係は未確認。
- Claude Code 側の公式 docs（`docs`）にはこの API の要約ページが無く、エンドポイント仕様は未確認。
