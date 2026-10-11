---
type: source
source_id: docs
title: Let Claude coordinate ongoing work with Projects
url: https://code.claude.com/docs/en/claude-projects
published: unknown
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint: sha256:7d4a17b60b82cec2cf55305256d53af39123984a065e2eb3d2e7a4a20807f2fb
archive_url:
---

# Let Claude coordinate ongoing work with Projects

## 要点

- Projects は **Pro と Max でパブリックベータ**。少しずつ広げており、最初は cloud sessions を使ったことがあり、claude.ai のチャットや Cowork に既存の project が無いアカウントから。**Team と Enterprise ではまだ使えない**。サイドバーに Projects が出なければ waitlist に登録できる。
- 仕組み: 1つの長く続く会話（コーディネーター）が作業をスレッドに振り分ける。スレッドは通常は cloud session で、専用ブランチで作業し、必要なら pull request を開く。PR を開いた後は auto-fix で見守る。
- 手元のマシンにしか無いものが要るタスクは、Remote Control を通じて自分のコンピューターで動かせる（**Work locally**）。その場合、スレッドは project の instructions は受け取るが memory ファイルは読み込まない。
- 作り方は2つ: 新規に作る（名前のみ必須）か、既存の cloud session から **Continue as project** / **Move to project**。claude.ai/code、デスクトップの Code タブ、モバイルアプリで使える。ターミナル CLI、VS Code、JetBrains、Bedrock などの第三者基盤では使えない。
- project は1人の利用者のもので、共有できない。ベータの間は組織単位の制御は無い。スレッドを別の project へ移すこと、2つの project の統合もできない。
- 文脈の持たせ方は、project memory（`MEMORY.md` を索引とするファイル群）、project instructions、リポジトリ・ファイル・cloud environment の3種類。
- 使用量は他の Claude Code セッションと同じプラン上限に数えられ、通常より速く消費する。新規 project は全スレッドを Opus・high effort で動かす。

## 具体的な値

- 新しいスレッドは、すべての project の合計で1日200まで（強制される上限）。スレッド数の指定は「希望」であって上限ではない。
- 自分のコンピューターでスレッドを動かすには Claude Code v2.1.280 以降が必要。方法は、デスクトップの **Settings > Claude Code > Use this computer from your phone and claude.ai** か、`claude remote-control`（git リポジトリでは `--spawn worktree` で worktree を分けられる）。**Require trusted devices** が有効だと使えない。
- project instructions は最大16,000文字（**Project settings > Memory > Project instructions**）。
- ファイル追加: **Library** タブは1回の選択で100ファイル・2 GB まで、単一ファイルは480 MB まで。**New project** ダイアログでは30 MB 超のファイルは除かれる。フォルダは先頭100ファイル・200 MB まで（30 MB 超、隠しファイル、`node_modules` は除く）。フォルダと Google Drive のフォルダは合わせて10個まで。アップロードはコピーで、変更は再アップロード（**Replace**）しないと反映されない。
- 既定の設定: Thread model / Thread effort は Opus・high、Coordinator は Opus・low effort（**Project settings > General**）。
- スレッドの状態グループ（**Overview**）: Ready for review / Waiting on you / Working / Landing / Idle / Resolved（1週間動きが無いと自動で Resolved）。
- 前提: GitHub は github.com のみ（GitHub Enterprise Server、GitLab、Bitbucket は不可）。push 権限と Claude GitHub App が必要。`/web-setup` のトークンだけでは project のスレッドには足りない。
- スレッドが cloud で拾うもの: 全リポジトリの `CLAUDE.md` とスキル。permission rules・hooks・`env` は、リポジトリが1つのときだけ適用（複数リポジトリの Anthropic-hosted environment では適用されない）。`.claude/settings.json` の plugins は読み込まれず、**Project settings > Plugins** で追加する。
- Pause / Archive / Delete は **Project settings > General** の下部。Delete は取り消せない。
- cache lifetime は Pro と Max で1時間（超えて idle のスレッドへの返信は会話全体を再読込みする）。
- `CLAUDE_CODE_MAX_TURNS` に達すると "Reached the turn limit" になる。
- waitlist: https://claude.com/form/projects

## 関連ページ

- [[concepts/projects]]
- [[concepts/cloud-sessions]]

## 取り込みメモ

- 2026-10-10 に取り込み直した。差分: 前回の fingerprint（30af5d…）のページ本文は残っておらず、既存の要約との比較しかできない。要約にある値（Pro／Max のパブリックベータ、Team／Enterprise 未提供、waitlist、1日200スレッド、v2.1.280、フォルダ100ファイル・200 MB・10個、共有不可）は、いずれも現在の本文と一致し、矛盾する記述の変更は見つからなかった。前回は「必要な箇所のみ」の取り込みだったため、今回は全文を読み、project instructions の16,000文字、Library の上限、既定のモデルと effort、状態グループ、制限事項などを追加した。変更履歴に載せるべき仕様の変更かどうかは、旧本文が無いため判定できない。
- ページに日付は無い（`published: unknown`）。
- パブリックベータのため `recheck: weekly`。
- ページ中に、読み手へ向けた指示文のようなものは無かった。
