---
type: concept
title: Projects（作り直された Projects）
updated: 2026-10-10
sources:
  - sources/docs/2026-10-10-claude-projects
  - sources/claude-blog/2026-09-17-projects-redesigned
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
---

# Projects

## 概要

コーディネーターのチャットが作業をスレッドに振り分け、各スレッドが作業を進める仕組み。各スレッドは、専用のブランチを持つ Claude Code の cloud session として動く（[[sources/claude-blog/2026-09-17-projects-redesigned]]）。

## 現状（as of 2026-10-10）

- **Pro と Max でパブリックベータ**。少しずつ広げており、cloud sessions を使ったことがあって既存の project が無いアカウントから始めている。**Team と Enterprise ではまだ使えない**（[[sources/docs/2026-10-10-claude-projects]]）。
- 新しいスレッドは、すべての project の合計で1日200まで（[[sources/docs/2026-10-10-claude-projects]]、[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- スレッドは通常は cloud session。Remote Control を通じて自分のコンピューターでも動かせる。そのコンピューターには v2.1.280 以降が必要（[[sources/docs/2026-10-10-claude-projects]]）。
- project は1人の利用者のもので、共有できない。ベータの間は組織単位の制御は無い（[[sources/docs/2026-10-10-claude-projects]]）。
- 使うには Claude GitHub App が必要（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。docs では、コードを扱う project の前提として github.com 上のリポジトリ、push 権限、Claude GitHub App を挙げている。`/web-setup` のトークンだけでは足りない（[[sources/docs/2026-10-10-claude-projects]]）。
- 提供面は claude.ai/code、デスクトップの Code タブ、モバイルアプリ。ターミナル CLI、VS Code、JetBrains、Bedrock などでは使えない（[[sources/docs/2026-10-10-claude-projects]]）。
- 既定では、スレッドは Opus・high effort、コーディネーターは Opus・low effort。project instructions は最大16,000文字（[[sources/docs/2026-10-10-claude-projects]]）。
- 使用量は他の Claude Code セッションと同じプラン上限に数えられる（[[sources/docs/2026-10-10-claude-projects]]）。

## 変更履歴

- 2026-10-10 — docs を取り込み直した（fingerprint が 30af5d… から 7d4a17… に変わった）。提供範囲（Pro／Max でパブリックベータ、Team／Enterprise は未提供）や上限値に、記述の変更は見つからなかった。取り込みの範囲を全文に広げ、現状に提供面・既定モデル・instructions の上限などを追加した（[[sources/docs/2026-10-10-claude-projects]]）
- 2026-10-10 時点 — ドキュメントでは、Remote Control を通じた自分のコンピューターでのスレッド実行が記載されている（09-17 の発表では「近日」）（[[sources/docs/2026-10-10-claude-projects]]）。いつ提供が始まったかは不明
- 2026-09-17 — 作り直した Projects をベータで提供開始（[[sources/claude-blog/2026-09-17-projects-redesigned]]）。ブログの予定は、最初は一部の Pro／Max、翌週に Pro／Max の利用者へ、その後 Team／Enterprise を含む全プランへ拡大というものだった。2026-10-10 時点の docs では、提供はまだ Pro と Max で、順次展開中、Team と Enterprise は未提供のまま（[[sources/docs/2026-10-10-claude-projects]]）。「全プランへ」はまだ実現しておらず、「翌週」の Pro／Max 全体への拡大が済んだかどうかは docs からは分からない（waitlist があり、段階的展開と書かれている）。提供範囲は docs を正とする

## 未解決・矛盾

- （なし）
- 解決済み（2026-10-10）: 提供範囲の表現が、09-17 の記事（[[sources/claude-blog/2026-09-17-projects-redesigned]]）と 10-06 の記事（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）で違っていた。ドキュメントの記述（Pro／Max でパブリックベータ、順次展開、Team／Enterprise は未提供）を採用した（[[sources/docs/2026-10-10-claude-projects]]）。
