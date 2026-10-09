---
type: source
source_id: claude-dev
title: Getting the most out of Opus 5.5 in Claude and Claude Code
url: https://claude.dev/blog/getting-the-most-out-of-opus-5-5/
published: 2026-09-22
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Getting the most out of Opus 5.5 in Claude and Claude Code

## 要点

- タスクは丸ごと任せ、「何をもって完了か」と「いつ止まって聞くか」を伝える。
- 「think carefully」のような指示は消す。Opus 5.5 は返答の前に必ず考える。
- 長い作業では、止まる条件を CLAUDE.md に書く。タスクの一覧はファイル（例: TASKS.md）に置き、要約されても残るようにする。
- Opus 5.5 は、Fable と同じ水準の bio とサイバーの安全策を持って出た最初の Opus。フラグが付いたメッセージは、多くの場合、古いモデルに回される。
- fast mode は、Opus 5.5 の公開時点では**研究プレビュー**。extra usage を有効にしておく必要がある。

## 具体的な値

- Claude Code での操作: `/model`（モデルを戻す）、`/config` の「Switch models when a message is flagged」、`/feedback`、`/fast`、Esc を2回押して直前のメッセージを編集。
- Claude アプリ: Settings → Capabilities で同じ設定を切り替える。

## 関連ページ

- [[concepts/claude-opus-5-5]]
- [[concepts/fast-mode]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- 既定の effort やコンテキスト長は、この記事には書かれていない。
