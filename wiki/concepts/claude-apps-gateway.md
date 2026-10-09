---
type: concept
title: Claude apps gateway
updated: 2026-10-10
sources:
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# Claude apps gateway

## 概要

組織が Claude Code や Claude Desktop と、各モデル提供元（Anthropic API、Amazon Bedrock、Vertex、Foundry など）の間に置くゲートウェイ。サインイン、ポリシーの配布、上流へのフェイルオーバー、監査ログを担う。CHANGELOG の記述から読み取れる範囲の要約である（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-10）

- `managed.policies[]` の `code` キー（2.1.296）: `cli` と同じ設定を Claude Desktop の Code タブにも効かせる（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 上流ごとの `models` リスト（`*` のワイルドカード可）と `timeouts.upstream_ttfb_ms` の設定（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- `forceLoginMethod: "gateway"` と `forceLoginGatewayUrl` を、managed settings の無いマシンではユーザー設定にも書ける（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 監査イベント `inference` に `upstream_request_id`、応答に `request-id` ヘッダーが付く（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- Bedrock ではトークン数を CountTokens API で数える。`bedrock:CountTokens` の権限が必要（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 背景のリクエストには Haiku 4.5 を使う。提供されていなければセッションのモデルを使う（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 対応する PostgreSQL の最低バージョンは 11（2.1.290 で 14 から変更）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-09 — 2.1.296: `code` キーを追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-08 — 2.1.295: `models`、`timeouts.upstream_ttfb_ms`、ログイン設定ほかを追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-05 — 2.1.290: サインイン承認ページに Deny ボタンを追加。PostgreSQL の最低バージョンを 11 に変更（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- ゲートウェイの全体像を説明する一次情報（docs）はまだ取り込んでいない。週次の docs Check で補う。
