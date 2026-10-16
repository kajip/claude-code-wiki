---
type: concept
title: cloud sessions（Claude Code in the cloud）
updated: 2026-10-16
sources:
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/claude-blog/2026-09-17-projects-redesigned
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute
---

# cloud sessions

## 概要

タスクごとに新しい VM で Claude Code を動かす仕組み。リポジトリを新しいブランチに clone して作業する（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。Anthropic の基盤で動かすか、self-hosted environment で組織のマシンで動かす（同）。

## 現状（as of 2026-10-16）

- 提供: Pro、Max、Team、Enterprise に追加料金なしで含まれる。Console の API キーとサードパーティのプロバイダーでは使えない。ZDR の組織では無効（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- 起動: `claude --cloud`。ローカルに持ってくるには `claude --teleport`（同）。
- 承認のモードは Auto、Accept edits、Plan だけ（同）。Auto の仕組みは [[concepts/auto-mode]]。
- VM は約 4 vCPU、16 GB RAM、30 GB ディスク（同）。
- self-hosted environments は Team／Enterprise でベータ（同）。2.1.295／2.1.296 で、self-hosted runner の修正と変更が続いている（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- self-hosted environments の仕組み（記事は2026-08-06公開時点）: 常駐の runner がセッションを拾い、セッションごとに Claude Code プロセスを起動する。モードは Fixed（台数固定）と On-demand（orchestrator が起動・停止）。各セッションは専用 checkout で分離される。リポジトリ、成果物、シークレットは自社インフラに残り、会話（プロンプト、応答、ツール結果）は Anthropic に送られ transcript が保存される。デフォルトはオフで、ZDR の組織では使えない。ほとんどの企業にはホスト版を推奨しており、self-hosted には構築・保守のエンジニアが要る（[[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]]）。
- self-hosted environments は Remote Control とは別物。Remote Control は本人のマシン上のセッションを手元の端末から続ける仕組みで、そのマシンが止まると終わる（同）。
- Projects のスレッドは cloud session として動く（[[sources/claude-blog/2026-09-17-projects-redesigned]]）。→ [[concepts/projects]]
- 関連（隔離の考え方）: ローカルでは OS サンドボックス、Cowork ではローカル VM で封じ込める。cloud sessions に対する記事の記述は無い。→ [[concepts/sandboxing]]（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

## 変更履歴

- 2026-08-06 — self-hosted environments が public beta（Team／Enterprise）として発表された（[[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]]）。2026-10-16 に取り込み
- 2026-10-06 — 2.1.290: 組み込みの `gh api` で github.com 以外のホストを拒否するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- self-hosted environments の docs ページは wiki に未取り込みのため、提供範囲（Team／Enterprise、ZDR 不可）は claude-dev の記事と blog の2件で一致していることまでしか確認していない。
