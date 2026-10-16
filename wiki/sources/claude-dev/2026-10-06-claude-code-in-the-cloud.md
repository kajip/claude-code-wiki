---
type: source
source_id: claude-dev
title: "Claude Code in the cloud: a field guide to cloud sessions"
url: https://claude.dev/blog/claude-code-in-the-cloud/
published: 2026-10-06
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint: sha256:16f39a80b493bd9dec6fe55dfc4b79d4694e466e2306d6fbcfcdc122cecdffe1
archive_url:
---

# Claude Code in the cloud: a field guide to cloud sessions

## 要点

- cloud session では、タスクごとに新しい VM を用意し、リポジトリを新しいブランチに clone して Claude Code を動かす。作業ツリーを他のセッションと共有せず、利用者の認証情報も使わない。
- 始め方は、claude.ai/code、モバイル、デスクトップ、ターミナル（`claude --cloud`）、Slack。`--teleport` でクラウドのセッションをローカルに持ってこられる。
- 承認のモードは Auto、Accept edits、Plan のどれか（コマンドごとの承認は無い）。
- GitHub のトークンは VM に入らない。プロキシが保持し、セッションには自分の作業ブランチにだけ push できる短命の認証情報が渡る。
- Pro、Max、Team、Enterprise に追加料金なしで含まれ、Claude Code と同じ利用上限を使う。Console の API キーやサードパーティのプロバイダーでは使えない。ZDR の組織では無効。
- Routines は研究プレビュー、Projects は Pro／Max でパブリックベータ、self-hosted environments は Team／Enterprise でベータ。
- Routines は承認の確認（approval prompts）無しで動く。Auto-fix、GitHub トリガーの routines、Projects は Claude GitHub App に依存する。

## 具体的な値

- コマンド: `claude --cloud "<prompt>"`、`claude --teleport [<session-id>]`、`claude -p "<prompt>" --cloud <session-id>`、`/teleport`（`/tp`）、`/tasks`、`/autofix-pr`、`/schedule`、`/web-setup`
- VM: 約 4 vCPU、16 GB RAM、30 GB ディスク。
- フォアグラウンドのコマンドのタイムアウトは既定2分、最大10分。その後もバックグラウンドで最大30分続く。`BASH_DEFAULT_TIMEOUT_MS`、`BASH_MAX_TIMEOUT_MS`。
- セットアップスクリプトは root で動き、終了コード 0 で終わる必要がある。約5分以内に終わればキャッシュされる。キャッシュはおよそ7日ごとに作り直される。
- クラウドだけで動かしたい手順は、`CLAUDE_CODE_REMOTE` を見て分ける。
- ネットワークの段階: None／Trusted（既定）／Custom／Full。外向きの通信はすべてプロキシを通り、ホスト名が記録される。
- cloud session からのコミットには `Claude-Session` トレーラーが付く。
- Routines は claude/ で始まるブランチに push する（既定）。スケジュールの最短は1時間ごと。
- Projects: 1日あたり最大200の新しいスレッド。
- 原文: 「Routines run without approval prompts」。「Auto-fix, GitHub-triggered routines and projects also depend on the App」。表では `/web-setup`（gh token）は Auto-fix・GitHub triggers・projects に対し「No, needs the App」。App は組織では owner の承認が通常必要。
- Enterprise では、premium seat か Chat + Claude Code seat が必要。組織のオーナーが claude.ai/admin-settings/claude-code で有効にする必要がある場合がある。

## 関連ページ

- [[concepts/cloud-sessions]]
- [[concepts/routines]]
- [[concepts/projects]]

## 取り込みメモ

- ベータや研究プレビューの機能を含むため `recheck: weekly`。
- 2026-10-10 lint 対応で追記: 承認の確認無しで動く（routines）点と、Projects などが GitHub App に依存する点が本文にあることを確認し、要点と具体的な値に足した。同日に記事本体を curl で取り直し fingerprint を付けた（HTML 全体の sha256）。
