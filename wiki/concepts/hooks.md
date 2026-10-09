---
type: concept
title: hooks（設定のフック）
updated: 2026-10-10
sources:
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
  - sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
---

# hooks（設定のフック）

## 概要

イベントごとにシェルコマンドなどを動かす仕組み。JSON を stdin／stdout でやりとりする。mods と違い、イベントの書き換えや UI の描画はできない（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。→ [[concepts/mods]]

## 現状（as of 2026-10-10）

- コマンドフックと HTTP フックの `onFailure: "block"`: 起動しない、タイムアウトした、想定外の終了コードだった、のどれかのときに操作を止める（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- フックの出力にある `<system-reminder>` タグは、Claude に渡す前にエスケープされる（2.1.292）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 長い出力は切り詰めてログに残される（2.1.290）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- `--debug` で、フックのコマンド、プラグイン、結果、かかった時間が記録される（2.1.296）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- cloud session では、SessionStart フックで `npm install` などを動かす。`CLAUDE_CODE_REMOTE` でクラウドかどうかを判定する（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。

## 変更履歴

- 2026-10-09 — 2.1.296: managed settings の `PreToolUse` フックが `"continue": false` で拒否してもターンが終わらなかった問題を修正（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-08 — 2.1.295: `onFailure: "block"` を追加（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.292: **Security**: PreToolUse フックの承認が、UNC パスからの読み込みで許可の確認を飛ばしていた問題を修正（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
