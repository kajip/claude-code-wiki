---
type: concept
title: Claude Tag（Claude in Slack）
updated: 2026-10-10
sources:
  - sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci
  - sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
---

# Claude Tag（Claude in Slack）

## 概要

Slack から Claude を動かす機能。Claude Code そのものではないが、Claude Code の CHANGELOG に `[Claude Tag]` の項目として更新が載る（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-10）

- 2026-09-23 の記事の時点では**ベータ**。社内では、claude.ai を速くする取り組みを1つの Slack チャンネルから動かした（[[sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster]]）。
- `!fast`／`!fast off` で fast mode を切り替える（2.1.290）。`!fork` でスレッドを分ける。`@Claude !status` で状態を確認する（2.1.292）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- チャンネルのルールの上限は、ワークスペースごとと組織全体でそれぞれ50（2.1.293 で 20 から変更）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- Claude Tag Admin 権限のあるメンバーは、ワークスペースとチャンネルのメモリファイルを Activity ページの Memory タブで編集できる（2.1.296）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

- 社内版の Claude Tag で長時間動かしたセッションに、CI のテスト選択サービスを監視させた例がある（[[sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci]]）。

## 変更履歴

- 2026-10-10 — 2.1.296: メモリファイルの編集を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-08 — 2.1.293: チャンネルのルールの上限を 50 に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.290: `!fast` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- 提供の段階（ベータかどうか、どのプランか）を正式に書いた一次情報は、まだ取り込んでいない。
