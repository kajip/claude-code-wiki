---
type: concept
title: Claude on Google Cloud
updated: 2026-11-07
sources:
  - sources/pricing/2026-11-07-pricing
  - sources/platform-docs/2026-11-07-fast-mode
  - sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05
  - sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30
  - sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud
---

# Claude on Google Cloud

## 概要

Google Cloud のプロジェクト経由で Claude を使う提供形態と、その上で Claude Code のコストを管理する方法。2026-10-22 に「Claude Models on Google Cloud（Anthropic managed）」が始まった（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。Claude Code 向けの運用（spend cap、テレメトリ、ROI）は 10-27 の記事が扱う（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。

## 現状（as of 2026-11-07）

- 提供形態: Anthropic が運用する Claude API を、顧客の Google Cloud プロジェクト経由で使う。アクセス制御は Google Cloud IAM、課金は Google Cloud Marketplace。Opus 5.5 の fast mode も使える（10-22）（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。
- message threads（ベータ、`message-threads-2026-08-12`）は、Claude Models on Google Cloud（Anthropic managed）でも使える（11-02）（[[sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05]]）。
- 課金: 消費量に応じた従量課金で、請求額は開発者の使用量の反映になる（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。単価は pricing を参照する（記事に数値は無い）。
- Claude Code の管理は3レバー: control（Claude apps gateway の spend cap、モデルの allowlist と既定モデル、admin API）、track（OpenTelemetry、BigQuery エクスポート、Cloud Monitoring）、prove（usage、satisfaction、impact の指標）（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。
- gateway は自己ホストで、Google Cloud のプロジェクト内で Claude Code と Claude on Google Cloud の間に置く。IdP（例: Google Workspace）でサインインさせ、リクエストに検証済みの身元を載せる（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。詳細は [[concepts/claude-apps-gateway]]。
- cap の挙動: Claude Code 内で 75% 超と 95% 超に警告し、cap に達すると gateway が 429 を返す。group と組織の cap は各メンバーが継承する既定値で、共有プールではない（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。共有の月間予算 `pooled_budget` は 2.1.316 で別に追加された（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- Google Cloud 側の機能: per-project billing、billing budgets and alerts、BigQuery exports、Quotas、Provisioned throughput、Spend caps（**Preview**）（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。
- テレメトリの属性付けは `OTEL_RESOURCE_ATTRIBUTES`。ユーザーのプロンプトの記録はオプトイン（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）。

## 変更履歴

- 2026-11-07 — 価格ページが fast mode の提供先に Claude Models on Google Cloud (Anthropic managed)（Opus 5.5）を明記し、fast mode の未解決を解消（[[sources/pricing/2026-11-07-pricing]]）
- 2026-11-02 — message threads（ベータ）の提供先に Claude Models on Google Cloud（Anthropic managed）が含まれた（[[sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05]]）
- 2026-10-27 — Claude Code を Google Cloud で運用する際のコスト管理と ROI の手引きが公開された（[[sources/claude-blog/2026-10-27-manage-costs-and-roi-for-claude-code-on-google-cloud]]）
- 2026-10-22 — Claude Models on Google Cloud（Anthropic managed）の提供を開始（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）

## 未解決・矛盾

- Vertex AI 経由の提供との違い、対象モデル、リージョンは、どちらの出典にも書かれていない。docs（`/docs/en/build-with-claude/claude-models-on-google-cloud/anthropic-managed`）の取得が必要。
- 解決済み（2026-11-07）: pricing 10-22 版の「fast mode はパートナーのクラウドでは使えない」と、リリースノートの「Google Cloud でも Opus 5.5 の fast mode が使える」の関係 → pricing 11-07 版と fast mode ページが、Claude Models on Google Cloud (Anthropic managed) での Opus 5.5 の fast mode を明記した。価格ページでは Anthropic 運営（Anthropic managed）とパートナー運営（Google managed）が区別されている（[[sources/pricing/2026-11-07-pricing]]、[[sources/platform-docs/2026-11-07-fast-mode]]、[[concepts/fast-mode]]）。
- 価格ページによると、`inference_geo` の 1.1倍は Claude Models on Google Cloud (Anthropic managed) に適用され、Google managed は独自のリージョン価格（[[sources/pricing/2026-11-07-pricing]]）。
- 記事の gateway の機能（spend cap、admin API、テレメトリ設定）は、gateway の docs 本体では確認していない。
