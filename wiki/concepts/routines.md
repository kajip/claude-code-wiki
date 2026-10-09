---
type: concept
title: routines（ルーティン）
updated: 2026-10-10
sources:
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# routines

## 概要

プロンプト、リポジトリ、コネクタ、環境を保存しておき、トリガーで cloud session として動かす仕組み。トリガーは、スケジュール、HTTP 呼び出し、GitHub のイベントのどれか（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。

## 現状（as of 2026-10-10）

- **研究プレビュー**（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- 作り方: claude.ai/code/routines、デスクトップ、`/schedule`（同）。
- 承認の確認無しで動き、既定では `claude/` で始まるブランチに push する。スケジュールの最短は1時間ごと（同）。
- スケジュール実行と Run now の実行は、自分だけが見られる新しい artifact を承認なしで公開する（2.1.292）。telemetry を無効にした環境でも同じ動きになった（2.1.295）（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-08 — 2.1.295: telemetry を無効にした環境でも artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.292: 自分だけが見られる artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
