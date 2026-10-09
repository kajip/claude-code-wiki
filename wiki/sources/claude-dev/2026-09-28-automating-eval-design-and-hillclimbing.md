---
type: source
source_id: claude-dev
title: Automating eval design and hillclimbing with Claude
url: https://claude.dev/blog/automating-eval-design-and-hillclimbing/
published: 2026-09-28
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Automating eval design and hillclimbing with Claude

## 要点

- 評価（eval）の作り方と、過学習せずにスコアを上げていく方法（hillclimbing）の原則を示す。
- Claude Code に同梱される `claude-api` スキルの2つのコマンド、`/claude-api build-eval` と `/claude-api hillclimb` がその原則を実装している。
- build-eval は、ケースを集め、採点器を選び、ベースラインの診断（採点のぶれ、配管、改善の余地）を行う。
- hillclimb は、データを train と test に分け、1回に1つの修正を入れる。train と test の両方が良くなったときだけ残す。

## 具体的な値

- 使い方: `claude update` のあと、`/claude-api build-eval`、`/claude-api hillclimb`
- 例: サポートチケットの評価（44件）で、Opus 4.8・high（74.4%、4.6¢）から Sonnet 5・low・改善したプロンプト（98.9%、1¢）へ。手元に残した14件では、90.5% 対 78.6%。
- `claude-api` スキル自体の評価では、合格率が 66.1% から 87.9% に上がった。

## 関連ページ

- [[concepts/claude-api-skill]]

## 取り込みメモ

- 特になし。
