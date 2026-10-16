---
type: concept
title: Claude apps gateway
updated: 2026-10-16
sources:
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
---

# Claude apps gateway

## 概要

組織が Claude Code や Claude Desktop と、各モデル提供元（Anthropic API、Amazon Bedrock、Vertex、Foundry など）の間に置くゲートウェイ。サインイン、ポリシーの配布、上流へのフェイルオーバー、監査ログを担う。CHANGELOG の記述から読み取れる範囲の要約である（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-16）

- `code` ポリシーの `env` に `CLAUDE_CODE_ATTRIBUTION_HEADER=0` を置くと、Desktop の Code タブの attribution ブロックを無効にできる。gateway 経由の Claude Code セッションの attribution ブロックには1フィールドが加わり、同じ変数で消せる（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- policy の `availableModelsMatch: exact` や `deniedModels` が拒否するモデルを、gateway が提供してしまう問題を修正。今は 400 を返し、モデル一覧にも出さない（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- `forceLoginGatewayUrl` が Anthropic 運営の gateway で、セッションのホスト名を扱うなら、Desktop の Code タブは managed settings を適用する（起動時に到達できること）。`claude gateway` は、Desktop が gateway から使えない `desktop:` ポリシーキーがあると、キー名を示して起動を止める（従来は警告で起動）（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

- `managed.policies[]` の `code` キー（2.1.296）: `cli` と同じ設定を Claude Desktop の Code タブにも効かせる（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 上流ごとの `models` リスト（`*` のワイルドカード可）と `timeouts.upstream_ttfb_ms` の設定（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- `forceLoginMethod: "gateway"` と `forceLoginGatewayUrl` を、managed settings の無いマシンではユーザー設定にも書ける（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 監査イベント `inference` に `upstream_request_id`、応答に `request-id` ヘッダーが付く（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- Bedrock ではトークン数を CountTokens API で数える。`bedrock:CountTokens` の権限が必要（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 背景のリクエストには Haiku 4.5 を使う。提供されていなければセッションのモデルを使う（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 対応する PostgreSQL の最低バージョンは 11（2.1.290 で 14 から変更）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-14 — 2.1.299〜2.1.300: attribution ブロックの無効化、拒否モデルの扱いの修正、`desktop:` キーでの起動停止（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — 2.1.296: `code` キーを追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: `models`、`timeouts.upstream_ttfb_ms`、ログイン設定ほかを追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.290: サインイン承認ページに Deny ボタンを追加。PostgreSQL の最低バージョンを 11 に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- ゲートウェイの全体像を説明する一次情報（docs）はまだ取り込んでいない。週次の docs Check で補う。
