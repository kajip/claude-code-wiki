---
type: concept
title: cloud sessions（Claude Code in the cloud）
updated: 2026-11-02
sources:
  - sources/docs/2026-10-16-routines-and-cloud-sessions
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/claude-blog/2026-09-17-projects-redesigned
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute
  - sources/gh-changelog/2026-10-18-v2-1-302
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
---

# cloud sessions

## 概要

タスクごとに新しい VM で Claude Code を動かす仕組み。リポジトリを新しいブランチに clone して作業する（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。Anthropic の基盤で動かすか、self-hosted environment で組織のマシンで動かす（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。

## 現状（as of 2026-11-02）

- 提供: Pro、Max、Team、Enterprise に追加料金なしで含まれる。Console の API キーとサードパーティのプロバイダーでは使えない。ZDR の組織では無効（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- 起動: `claude --cloud`。ローカルに持ってくるには `claude --teleport`（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- 承認のモードは Auto、Accept edits、Plan だけ（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。Auto の仕組みは [[concepts/auto-mode]]。
- VM は約 4 vCPU、16 GB RAM、30 GB ディスク（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- self-hosted environments は Team／Enterprise でベータ（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。2.1.295／2.1.296 で、self-hosted runner の修正と変更が続いている（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- self-hosted environments の仕組み（記事は2026-08-06公開時点）: 常駐の runner がセッションを拾い、セッションごとに Claude Code プロセスを起動する。モードは Fixed（台数固定）と On-demand（orchestrator が起動・停止）。各セッションは専用 checkout で分離される。リポジトリ、成果物、シークレットは自社インフラに残り、会話（プロンプト、応答、ツール結果）は Anthropic に送られ transcript が保存される。デフォルトはオフで、ZDR の組織では使えない。ほとんどの企業にはホスト版を推奨しており、self-hosted には構築・保守のエンジニアが要る（[[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]]）。
- self-hosted environments は Remote Control とは別物。Remote Control は本人のマシン上のセッションを手元の端末から続ける仕組みで、そのマシンが止まると終わる（[[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]]）。
- docs（2026-10-16 取得）での確認: Pro、Max、Team、Enterprise のうち premium seat か Chat + Claude Code seat のユーザーが対象。プランの利用枠に含まれ、クラウド VM への別料金は無い。レート制限はほかの Claude／Claude Code の利用と共有され、並列タスクの数に比例して消費が増える。同時実行数の上限、1セッション全体の実行時間の上限は docs に記載なし。ZDR、HIPAA 構成、CMEK の組織は使えない（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- VM（Anthropic ホスト版）: Ubuntu 24.04、x86_64、4 vCPU、16 GB RAM、30 GB ディスク。前景コマンドは既定2分・最大10分、超えるとバックグラウンドに移り最大30分続く。SessionStart hook は 600 秒でキャンセル。セットアップスクリプトは約5分以内ならキャッシュ。アイドルから数分で VM が一時停止し、後で回収されうる。回収されるとバックグラウンドのサブエージェントやシェルは復元されない（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- ネットワーク: None／Trusted（既定）／Full／Custom。GitHub、有効なコネクタ、network secrets のホスト、Anthropic API は段階に関わらず到達できる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 読み込まれる設定: repo の `CLAUDE.md`、`.claude/rules/`、`.claude/skills/`・`.claude/agents/`・`.claude/commands/`、リポジトリ1つのセッションでは `.claude/settings.json` の hooks と権限ルール、`.mcp.json`。ユーザーの `~/.claude/`、`.claude/settings.local.json`、repo が宣言するプラグインは読み込まれない。複数リポジトリのセッションでは hooks と権限ルールが読まれない。組織の server-managed settings は届く（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- サブエージェントはローカルと同様に使え、repo の `.claude/agents/` が自動で読み込まれる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 権限モード: docs の表では Accept edits、Plan、Auto（claude-dev の記事と一致）（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- routines は cloud session として動く。上限や課金は → [[concepts/routines]]（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- Projects のスレッドは cloud session として動く（[[sources/claude-blog/2026-09-17-projects-redesigned]]）。→ [[concepts/projects]]
- 関連（隔離の考え方）: ローカルでは OS サンドボックス、Cowork ではローカル VM で封じ込める。cloud sessions に対する記事の記述は無い。→ [[concepts/sandboxing]]（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

**2.1.302 の CHANGELOG（2026-10-17）**

- 費用と使用量が、新しいプロセスで再開すると 0 から数え直しになる問題を修正。「Rewind to here」が最新のメッセージ以外で失敗する問題を修正（self-hosted runner は v2.1.246 以降が必要）。PR 状態バー、リポジトリ改名・移動後の diff、別デバイスのメッセージ表示の修正。起動失敗時のエラーは "Connection lost"／"Server error" と表示（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- self-hosted runner: reftable 形式の checkout を再利用するセッションの git fetch 失敗を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- Remote Control: オフライン後にサブエージェントのペインが回り続ける問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。

**2.1.304〜2.1.305 の CHANGELOG（2026-10-20〜21）**

- 新規会話の最初のターンは、claude.ai から同期したプラグインのローカル（stdio）MCP サーバーを待たない。サーバーが `alwaysLoad: true` を指定する場合を除く（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- cloud session や SDK の `setMcpServers` で渡した MCP サーバーが、後から自分の設定の同名サーバーに置き換えられる問題を修正（2.1.305）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。→ [[concepts/mcp]]
- compaction で古いメッセージを要約から外したことを、cloud session とチームメイトが Claude に伝えない問題を修正（2.1.305）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- Cloud environments の管理画面が、既存環境の保存を "installs packages" エラーで誤って拒否する問題を修正。self-hosted environment の削除ダイアログは、妨げる要因と影響を示す（2.1.305）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- self-hosted runner の修正（2.1.305）: `TERM` 設定時に stdout だけ共有する起動スクリプトが失敗する問題（2.1.300 の回帰）、`GIT_CONFIG` で設定を読む git credential helper／askpass でリポジトリアクセスが失敗する問題（2.1.296 から）、背景に残る runner で spawn-runner フックがタイムアウト扱いになる問題（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 2.1.307〜2.1.316 の変更: 管理画面で Cloud sessions と Remote Control を Enterprise のカスタムロールで制御（2.1.310）、routine の model picker に effort（2.1.312）、MCP サーバーが求めるフォームのカード・network secrets を Enterprise メンバーが管理（2.1.316）、スケジュールタスクが claude.ai のアカウントで有効なプラグインを読み込む・セットアップスクリプトがエラー終了しても起動する（2.1.314）。`/autocompact` が cloud session の再起動で既定窓に戻る問題を修正（2.1.307）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。

## 変更履歴

- 2026-10-31 — 2.1.307〜2.1.316: 上記の変更と、Changes ペイン、setup script エディタ、self-hosted runner の修正多数（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」14 件を直前の出典のリンクに展開、「現状」の as of を 2026-10-21 に更新。内容の変更なし
- 2026-10-21 — 2.1.305: `setMcpServers` のサーバー置き換え、compaction の通知、Cloud environments 管理画面、self-hosted runner の修正。2.1.304: 最初のターンが stdio サーバーを待たない（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-17 — 2.1.302: cloud session の修正（費用の数え直し、Rewind、diff、エラー表示）と self-hosted runner の reftable 対応の修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-10-16 — docs を取り込み。記事（2026-10-06 公開時点）の提供範囲・VM の値と食い違いは無し。Enterprise は premium seat／Chat + Claude Code seat が条件、という補足が加わった（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）
- 2026-08-06 — self-hosted environments が public beta（Team／Enterprise）として発表された（[[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]]）。2026-10-16 に取り込み
- 2026-10-06 — 2.1.290: 組み込みの `gh api` で github.com 以外のホストを拒否するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- self-hosted environments の docs ページは wiki に未取り込みのため、提供範囲（Team／Enterprise、ZDR 不可）は claude-dev の記事と blog の2件で一致していることまでしか確認していない。
