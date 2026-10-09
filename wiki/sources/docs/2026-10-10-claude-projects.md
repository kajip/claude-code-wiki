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
fingerprint: sha256:30af5d411d1ad6dc0824155de1d4ed623940b774427dfb372a5f510334332c4f
archive_url:
---

# Let Claude coordinate ongoing work with Projects（必要な箇所のみ）

## 要点

- Projects は **Pro と Max でパブリックベータ**。少しずつ広げており、最初は cloud sessions を使ったことがあり、claude.ai のチャットや Cowork に既存の project が無いアカウントから。
- **Team と Enterprise ではまだ使えない**。サイドバーに Projects が出なければ、waitlist に登録できる。
- スレッドは通常は cloud session。手元のマシンにしか無いものが必要なタスクは、**Remote Control を通じて自分のコンピューターで動かせる**。
- 作り方は2つ: 新規に作るか、既存の cloud session から「Continue as project」で作る。claude.ai/code、デスクトップの Code タブ、モバイルアプリで使える。
- project は1人の利用者のもので、共有できない。ベータの間は組織単位の制御は無い。

## 具体的な値

- 新しいスレッドは、すべての project の合計で1日200まで（強制される上限）。
- 自分のコンピューターでスレッドを動かすには、そのコンピューターに Claude Code v2.1.280 以降が必要。`claude remote-control` かデスクトップアプリを使う。
- フォルダの追加: 先頭の100ファイル、合計200 MB まで。30 MB を超えるファイル、隠しファイル、`node_modules` は除かれる。フォルダと Google Drive のフォルダは合わせて10個まで。
- waitlist: https://claude.com/form/projects

## 関連ページ

- [[concepts/projects]]
- [[concepts/cloud-sessions]]

## 取り込みメモ

- 取り込んだのは、提供範囲、構成、ローカルのスレッド、上限、制限事項の節だけ。
- パブリックベータのため `recheck: weekly`。ページに日付は無い。
