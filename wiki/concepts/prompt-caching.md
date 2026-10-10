---
type: concept
title: プロンプトキャッシュとセッションの費用
updated: 2026-10-10
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/docs/2026-10-10-prompt-caching
  - sources/platform-docs/2026-10-10-prompt-caching
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports
---

# プロンプトキャッシュとセッションの費用

## 概要

Claude Code のセッションは長くなり、1回のリクエストのコンテキストも大きくなったため、費用の大部分をキャッシュ読み取りが占める（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]、[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。

## 現状（as of 2026-10-10）

- キャッシュヒットの単価（100万トークンあたり）: Opus 5.5 は $0.20、Sonnet 5.5 は $0.10、Haiku 5.5 は $0.01（100K 以下）、Fable 5.1 は $0.25（[[sources/pricing/2026-10-10-pricing]]）。
- キャッシュヒットの倍率は入力単価の0.1倍が標準。Opus 5.5 と Sonnet 5.5 は0.05倍、Fable 5.1 と Mythos 5.1 は0.025倍（[[sources/pricing/2026-10-10-pricing]]）。
- キャッシュ書き込みは、5分キャッシュで入力の1.25倍、1時間キャッシュで2倍（[[sources/pricing/2026-10-10-pricing]]、[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- effort の変更（**Claude Code の場合**）: 多くのモデルでは、effort の段階ごとに別のキャッシュを持つ。Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 を API キーかサブスクリプションで使う場合は、effort を変えてもキャッシュが残る。Bedrock、Google Cloud's Agent Platform、Claude apps gateway、`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` を設定した場合、HIPAA の構成では残らない（[[sources/docs/2026-10-10-prompt-caching]]）。
- effort の変更（**Claude API を直接使う場合**）: `output_config.effort` を変えると messages のキャッシュは常に無効になる。tools と system への影響はモデルごと。既定値の明示指定は省略と同じで無効にならない。per-message effort 対応モデルでは `role: "system"` メッセージで変えれば保たれる。thinking の設定を変えた場合も同様（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- 最小キャッシュ可能長（Claude API）: Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 は 512 トークン（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- API キーやクラウドプロバイダーの利用者も、1時間のキャッシュ寿命を設定できる（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。
- fork したサブエージェントは親のキャッシュから始まる（同）。
- キャッシュを保つための推奨: 長く間を空けない、途中でモデルを変えない、MCP を後からつながない、fast mode は最初に有効にする（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- 確認は `/usage`、`/cost`（同）。
- API の cache diagnostics は 2026-09-23 に GA になり、beta ヘッダーが不要になった（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。

## 変更履歴

- 2026-10-10 — effort 変更時の挙動を、Claude Code と Claude API に分けて書いた（[[sources/platform-docs/2026-10-10-prompt-caching]]）
- 2026-10-07 — Sonnet 5.5 のキャッシュ読み取りを $0.20 から $0.10 に引き下げ（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]、[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-23 — API の cache diagnostics が GA（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-04-23 — （公開時点の事例）アイドル1時間超のセッションで古い thinking を消す最適化のバグが毎ターン働き、キャッシュミスが続いて使用上限の消費が早まったと説明された。4/10 に修正済み（[[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]]、[[concepts/claude-code-quality-incidents]]）

## 未解決・矛盾

- （なし）
- 解決済み（2026-10-10）: effort を変えたときにキャッシュが残るかどうかの食い違いは、ドキュメントの記述で解決した（[[sources/docs/2026-10-10-prompt-caching]]）。経緯は [[concepts/effort]] を参照。
