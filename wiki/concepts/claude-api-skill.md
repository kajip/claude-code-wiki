---
type: concept
title: claude-api スキル
updated: 2026-11-02
sources:
  - sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-10-08-building-effective-agent-automations
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop
  - sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation
---

# claude-api スキル

## 概要

Claude Code に同梱されるスキル。Claude API を使った開発を助けるサブコマンドを持つ（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。

## 現状（as of 2026-11-02）

- `/claude-api build-eval`、`/claude-api hillclimb`: 評価を作り、過学習を避けながらスコアを上げる（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。
- `/claude-api migrate this project to claude-sonnet-5-5`: モデルの差し替えとパラメータの変更を自動で行う（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- `/claude-api prompt-audit`: スキルや CLAUDE.md の悪い書き方を指摘する（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- `/claude-api managed-agents-onboard <url>`、`<quickstart-name>`: Managed Agents の構成を作る（2.1.290）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]、[[sources/claude-dev/2026-10-08-building-effective-agent-automations]]）。
- ソース: github.com/anthropics/skills の `skills/claude-api`（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。

- `/claude-api managed-agents-secure`（2.1.304）: Managed Agents の agent の設定を Anthropic 公開のセキュリティガイドと比較する。何も変更しない（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- Claude Platform on AWS では、SDK や curl に戻らず `ant` CLI を使う（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `/claude-api api-version`: Claude API のコードを API version `2026-10-21` へ移す（2.1.307）。API tracing を SDK tracing と並べて提案、未対応と言う前にライブ docs を確認（2.1.309）。Datadog の API tracing は `dd-llmobs-enabled: true` ヘッダーを送り、`ant` の install から macOS の `xattr` 手順を削除（2.1.314）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- （2026-10-22 の記事）`/claude-api prompt-audit` は旧モデル向けの指示を diff で提案する。`/claude-api hillclimb` は、サブエージェントを skills と tools に畳んだ版が元に並ぶか比べるのに使う。`/claude-api cost-optimize` は prompt caching、不要トークンの削減、effort、モデル選択を1つずつ提案する。これらをつなぐ「migration kit」（複数エージェントを単一ループへ移す誘導付きワークフロー）が紹介されている。kit の実体は未取得（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- skill の形（`SKILL.md` を含むフォルダ）と標準の動向は [[concepts/skills]] を参照。skills の標準は 2026-10-22 に AAIF へ寄贈された。この記事には `claude-api` スキル自体への言及は無く、同梱スキルが標準にどこまで沿うかは不明（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）。

## 変更履歴

- 2026-11-02 — skills の標準（AAIF への寄贈）と [[concepts/skills]] へのリンクを追記（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）
- 2026-10-22 — `cost-optimize` の記載と migration kit の紹介（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）
- 2026-10-31 — 2.1.307〜2.1.314: `api-version` の追加、Managed Agents の `multiagent_20261001` への切り替え、tracing まわりの更新（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「現状」の as of を 2026-10-21 に更新。内容の変更なし
- 2026-10-20 — 2.1.304: `managed-agents-secure` を追加。Claude Platform on AWS で `ant` CLI を使うよう更新（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-06 — 2.1.290: `managed-agents-onboard` を追加。Managed Agents の例では、必要なとき以外は web ツールを切り、`auto` の権限ポリシーを使うよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
