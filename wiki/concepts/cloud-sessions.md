---
type: concept
title: cloud sessions（Claude Code in the cloud）
updated: 2026-10-10
sources:
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/claude-blog/2026-09-17-projects-redesigned
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/engineering/2026-05-25-how-we-contain-claude
---

# cloud sessions

## 概要

タスクごとに新しい VM で Claude Code を動かす仕組み。リポジトリを新しいブランチに clone して作業する（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。Anthropic の基盤で動かすか、self-hosted environment で組織のマシンで動かす（同）。

## 現状（as of 2026-10-10）

- 提供: Pro、Max、Team、Enterprise に追加料金なしで含まれる。Console の API キーとサードパーティのプロバイダーでは使えない。ZDR の組織では無効（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- 起動: `claude --cloud`。ローカルに持ってくるには `claude --teleport`（同）。
- 承認のモードは Auto、Accept edits、Plan だけ（同）。Auto の仕組みは [[concepts/auto-mode]]。
- VM は約 4 vCPU、16 GB RAM、30 GB ディスク（同）。
- self-hosted environments は Team／Enterprise でベータ（同）。2.1.295／2.1.296 で、self-hosted runner の修正と変更が続いている（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- Projects のスレッドは cloud session として動く（[[sources/claude-blog/2026-09-17-projects-redesigned]]）。→ [[concepts/projects]]
- 関連（隔離の考え方）: ローカルでは OS サンドボックス、Cowork ではローカル VM で封じ込める。cloud sessions に対する記事の記述は無い。→ [[concepts/sandboxing]]（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

## 変更履歴

- 2026-10-06 — 2.1.290: 組み込みの `gh api` で github.com 以外のホストを拒否するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- （なし）
