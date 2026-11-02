---
type: concept
title: Agent Skills（skills）
updated: 2026-11-02
sources:
  - sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation
  - sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop
---

# Agent Skills（skills）

## 概要

skill は `SKILL.md` を含むフォルダで、特定のタスクや分野の手順をエージェントに教える。Claude Code の開発の中で生まれ、のちにオープン標準になった（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）。Claude Code では、CLAUDE.md を軽く保つために、ワークフロー固有の内容を skill に分ける使い方が勧められている（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。

## 現状（as of 2026-11-02）

- 標準は 2026-10-22 に Agentic AI Foundation（Linux Foundation 傘下）へ寄贈された。名称とロゴ、GitHub organization、`agentskills.io` が対象。標準の利用や貢献に AAIF への加入は不要（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）。
- 採用は70超の基盤、公開された skills は100万件、インストールは約2.8億回（同上）。
- ロードマップの提案: 版を切ったリリース、正式な提案プロセス、作者と利用者向けのセキュリティ指針（同上）。
- Claude Code 側の仕様（changelog より）: `skills` から先読みするのは最大32件（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。skill hooks は1ソースにつき1セッション最大 1,024 件、マッチャー 16,384 字（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。`UserPromptSubmit` フックは skill の展開より前に走る（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- `~/.claude/skills/.trash` と `~/.claude/plugins/.trash` が際限なく増える問題を修正し、それぞれ約 1024 件に制限した。`cleanupPeriodDays` には関係しない（2.1.314）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- `CLAUDE_CODE_SYNC_SKILLS` を設定し、feature-flag 取得がオフのセッションは、同じマシンの他のセッションが取得した最大 10 分前の claude.ai skills 一覧を再利用する（2.1.311）。サブディレクトリの skills が Bash の `cd` 後に見つからない問題も修正（2.1.312）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- （2026-10-22 の記事、Claude Platform で作るエージェント向け。Claude Code の仕様ではない）skills は「チームの仕事の進め方」（手順、ルール、判断）に向き、ナレッジは検索ツールか skill 内の参照ファイルに置く。複数のサブエージェントを skills 付きの単一エージェントに畳む構成が、品質・費用・遅延で上回ることが多いとされる（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。記事は `/skill-creator`（skill の作成と、既存 skill の整理・重複排除・再構成）と `/skill-doctor`（各 skill の費用と利用頻度を見て不要なものを削除）を挙げる。この2コマンドは docs では未確認（同上）。
- 同梱の skill の例は [[concepts/claude-api-skill]]。プラグイン（mods）の標準レイアウトにも `skills/` がある（[[concepts/mods]]）。

## 変更履歴

- 2026-11-02 — 2.1.311〜2.1.314 の skills 関連（`CLAUDE_CODE_SYNC_SKILLS`、`.trash` の上限）と、2026-10-22 の記事の `/skill-creator`・`/skill-doctor` を追記（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]、[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）
- 2026-10-22 — skills の標準を AAIF に寄贈すると発表（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）
- 2026-10-20 — 2.1.304: skill hooks の上限（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-09 — 2.1.295: `skills` の先読みを最大32件に（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- Claude Code の skills 自体の docs（配置場所、frontmatter、読み込みの仕組み）はまだ取り込んでいない。Claude Code の skill が標準のどこまでを実装しているかは不明。
- `/skill-creator` と `/skill-doctor` は 2026-10-22 の記事（Claude Platform 向け）にだけ出てくる。Claude Code の docs では未確認で、同梱かどうか、対象環境も不明（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- 記事は skills の誕生を「2025年10月の公開」とするが、標準の公開は2025年12月とも述べる。両者は別の出来事と読めるが、記事の書き方からの読み取り（推測）。
