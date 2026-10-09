---
type: source
source_id: claude-dev
title: Building effective agent automations
url: https://claude.dev/blog/building-effective-agent-automations/
published: 2026-10-08
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# Building effective agent automations

## 要点

- **Claude Managed Agents（ベータ）** で、定期的に動くエージェントを作る参考実装を示す。Slack や GitHub を読み、前回からの変化を Slack に短く報告する。
- 構成は6つ: 情報源、書き込み先、エージェント、スケジュール、メモリ、ガードレール。
- 期間を固定せず、情報源ごとに「どこまで読んだか」（bookmark）を記録する。読めなかった情報源は、何も無かった日として扱わない。
- 投稿の成功を確かめてから記録する。投稿の前に重複を調べる。権限は最小にし、1回の実行の費用に上限を付ける。
- Claude Code からは `/claude-api managed-agents-onboard <url>` で、記事の構成を手元に作れる。

## 具体的な値

- コード: `anthropics/claude-quickstarts` の `managed-agents/daily-brief`
- `ant apply <file>`（作った資源の ID は `claude-lock.json` に記録）、`ant beta:deployments run --deployment-id <id>`
- メモリストアは `/mnt/memory/` にマウントされる。
- 予算の設定: `budget.type: limit`、`max_list_cost`（金額はセント単位の文字列）。上限に達すると `budget_reached` で一時停止する。
- 例で使うモデル: `claude-sonnet-5-5`

## 関連ページ

- [[concepts/managed-agents]]
- [[concepts/claude-api-skill]]

## 取り込みメモ

- 一覧には日付が出ていないが、記事ページには Oct 08, 2026 とある。
- ベータの機能を扱うため `recheck: weekly`。
