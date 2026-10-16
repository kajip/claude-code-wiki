---
type: source
source_id: claude-blog
title: Compliance API coverage extends to Claude Cowork and Claude Code
url: https://claude.com/resources/articles/compliance-api-cowork-and-claude-code
published: 2026-08-11
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: none
fingerprint: f724ca9584edc971b11565874f91dc2b600936ebeaf4e54550ece41c3289c12a
archive_url:
---

# Compliance API coverage extends to Claude Cowork and Claude Code

## 要点

- Compliance API が Claude Cowork（デスクトップ、web、モバイル）と Claude Code（CLI とデスクトップアプリ）のセッションを対象に加えた。公開時点（2026-08-11）は Claude Enterprise 向けのベータ。
- 新しいセッション用エンドポイントは、プロンプト、応答、ツール活動を1件のセッション記録（サーバー側に保存された transcript）にまとめて返す。
- 既存のエンドポイントとデータには影響がない（追加のみ）。既存の Compliance Access Key をそのまま使え、別の統合は不要。
- 2026-08-26 の追記: Cowork と Claude Code の対応は GA。Microsoft 365 アドイン（Excel、Word、PowerPoint、Outlook）と Claude Science の対応はベータ。
- OpenTelemetry を既にエクスポートしている組織は、それを続けたまま併用できる。

## 具体的な値

- セッション記録の内容: プロンプトと応答、ツール呼び出しの内容（web と MCP）、skills と artifacts の内容（transcript テキストとして）。
- セッションのメタデータ: 検証済みのユーザー ID とメールアドレス、組織 ID、セッション ID とメッセージごとの ID、タイムスタンプ。
- ベータ時点の対象外: Claude Code on the web、Claude Platform 経由の Claude Code、Amazon Bedrock / Google Cloud Vertex AI / Microsoft Foundry で実行したセッション。
- 認証: 既存の Compliance Access Key。エンドポイント名やパスは記事に書かれていない。

## 関連ページ

- [[concepts/compliance-api]]
- [[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]

## 取り込みメモ

- curl で記事ページの HTML を取得（fingerprint はその生データ）。公開日は `published_time` と記事ヘッダの August 11, 2026 で確認。
- 2026-08-26 の追記は記事冒頭の Update 行。上記の対象外リストが GA 後も同じかは記事から読み取れない（記事本文は更新されていない可能性がある。推測）。
- ページ内に指示文は無かった。
