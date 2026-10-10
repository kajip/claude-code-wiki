---
type: concept
title: mods（Claude Code mods）
updated: 2026-10-10
sources:
  - sources/claude-blog/2026-10-01-customize-claude-code-with-mods
  - sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
---

# mods（Claude Code mods）

## 概要

Claude Code の動きと見た目を変える、小さな TypeScript／JavaScript の関数。プラグインに入れて配る（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）。中身は「プラグインに入ったフック」で、ミドルウェアのような鎖として動く（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。

## 現状（as of 2026-10-10）

- Claude Code **2.1.287 以降**が必要で、既定で有効。API は版ごとに変わりうる（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。
- CLI とデスクトップアプリで使える。ベータの表記は無い（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）。
- サンドボックスは無く、Claude Code と同じ権限で動く（同）。
- Team／Enterprise と managed settings のある端末では、組み込みの `sec-default` mod が最初に読み込まれる（同）。
- 組み込みの `/diff` と AGENTS.md への対応も mod として作られている（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。
- 開発の道具: `claude --plugin-dir`（ホットリロード）、`claude plugin validate`、`claude plugin test`（同）。
- 2.1.290〜2.1.296 で追加された API: `turn.step` の `serverToolUses`、`tool.check` の `agentId`／`ceiling`、`prompt.autocomplete`、`$.model.complete` の `cache: true`、`$.tool.register` の `isDeferred`、`$.ui.notify`（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-06〜10-10 — 2.1.290〜2.1.296 で API を追加（上記）。組織の mod のトーストを先に出すよう変更（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-01 — 発表（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）

## 未解決・矛盾

- （なし）
