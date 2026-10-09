---
type: source
source_id: claude-blog
title: How to prepare for AI-driven code modernization projects
url: https://claude.com/resources/articles/how-to-prepare-for-ai-driven-code-modernization-projects
published: 2026-09-23
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# How to prepare for AI-driven code modernization projects

## 要点

- Claude Code でコードのモダナイゼーションを進める手順を6つの段階で示す。目標を決める、certificate（人を介さずに確認できる合格条件）を作る、本番に入れる方針を決める、前提を整える、ワークフローを作って調整する、実行する。
- モダナイゼーションの種類は3つ: Uplift（同じ技術での版の引き上げ）、Transform（振る舞いを変えない別技術への書き換え）、Reimagine（振る舞いも変える作り直し）。
- 問題が出たら、個々の変更ではなくワークフローを直す。
- 機械的で量の多い作業には Sonnet のような安いモデルを使い、難しい変換や敵対的なレビューには強いモデルを使う。

## 具体的な値

- Claude Code の dynamic workflow で、並列のサブエージェントに作業を分ける。
- 公開プラグイン `code-modernization`。コマンドは `assess`、`map`、`extract-rules`。

## 関連ページ

- [[concepts/subagents]]

## 取り込みメモ

- ベストプラクティスの記事で、新機能の発表ではない。
