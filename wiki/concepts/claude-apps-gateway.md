---
type: concept
title: Claude apps gateway
updated: 2026-11-02
sources:
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud
---

# Claude apps gateway

## 概要

組織が Claude Code や Claude Desktop と、各モデル提供元（Anthropic API、Amazon Bedrock、Vertex、Foundry など）の間に置くゲートウェイ。サインイン、ポリシーの配布、上流へのフェイルオーバー、監査ログを担う。CHANGELOG の記述から読み取れる範囲の要約である（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-11-02）

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
- 2.1.307〜2.1.316 の追加: 共有の月間予算 `pooled_budget`（spend limits の admin API。2.1.316）、`managed.policy_mode: layered`（一致する全ポリシーを重ねる。2.1.316）、Bedrock upstream の `guardrail.input_tagging`（2.1.316）と `guardrail_trace`（2.1.314）、upstream の `groups`（IdP グループで振り分け。フェイルオーバーにも適用。2.1.314）、`oidc.user_id_claim`（2.1.312）。要求が名指しする全モデルを `availableModels`、`deniedModels`、`models` と照合するよう修正（2.1.316）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- Google Cloud での運用（10-27 の記事）: gateway は自己ホストで、Google Cloud のプロジェクト内に置く。IdP グループ別のモデル allowlist、user／IdP group／組織の spend cap（日・週・月）、cap 到達時の 429、75%／95% の警告、spend limits の admin API、テレメトリ送信先の一括設定（検証済みメールと IdP グループを付与）を挙げている。group と組織の cap は各メンバーが継承する既定値（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]、詳細は [[concepts/claude-on-google-cloud]]）。

## 変更履歴

- 2026-10-27 — Google Cloud でのコスト管理の記事が gateway の spend cap と telemetry を説明（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）
- 2026-10-31 — 2.1.307〜2.1.316: 上記の追加（`pooled_budget`、`layered` policy、guardrail 関連、`groups`、`oidc.user_id_claim`）。`claude auth login` が gateway 必須の環境で gateway サインインを出すように、VS Code のチャットパネルからもサインイン可（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-14 — 2.1.299〜2.1.300: attribution ブロックの無効化、拒否モデルの扱いの修正、`desktop:` キーでの起動停止（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — 2.1.296: `code` キーを追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: `models`、`timeouts.upstream_ttfb_ms`、ログイン設定ほかを追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.290: サインイン承認ページに Deny ボタンを追加。PostgreSQL の最低バージョンを 11 に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- ゲートウェイの全体像を説明する一次情報（docs）はまだ取り込んでいない。週次の docs Check で補う。
