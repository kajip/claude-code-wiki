---
type: source
source_id: claude-dev
title: Getting started with Claude Code mods
url: https://claude.dev/blog/getting-started-with-claude-code-mods/
published: 2026-10-01
retrieved: 2026-10-10
version: 2.1.287
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# Getting started with Claude Code mods

## 要点

- mod は、Claude Code のセッションの中で動く JavaScript／TypeScript のファイル。中身は「プラグインに入ったフック」で、イベントを見る、動きを変える、UI を描くことができる。
- **Claude Code 2.1.287 以降**が必要で、既定で有効。API はリリースごとに変わりうる。手元の版の正しい型は `.claude-plugin/types/` に書き出されるものを見る。
- フックはミドルウェアのように鎖になる。`next(e)` を呼ぶと、他のプラグインと Claude Code 本来の処理に渡る。観察、書き換え、`{ deny: "…" }` を返して答える、の3つの使い方がある。
- モジュールの中には DOM も Node も無く、外とのやりとりはすべて `$` を通す。設定のフック（シェルコマンド）と違い、セッションの間ずっと読み込まれたままで、状態を持てる。
- AGENTS.md への対応と `/diff` のペインも、組み込みの mod として作られている。
- 例として Token Weather（コンテキストの使用率をプロンプトの上に表示）、Blast Radius（危険な Bash を保留）、Replay Theater（編集の再生）を作る。

## 具体的な値

- 構成: `.claude-plugin/plugin.json`、`hooks/hooks.json`（`"modules": [...]`）、モジュールは `register(on, options)` を export する。
- 書き方: `on(event, matcher?, hook)`。フックは `($, e, next)` を受け取る。
- イベント: `tool.call`、`prompt.submit`、`turn.start`、`turn.complete`、`session.start`、`command.run`、`ui.render`、`session.usage`
- API: `$.ui.resolve`、`$.ui.open`、`$.session.usage()`、`$.state.get`／`$.state.set`、`$.process.run`、`$.fs.read`、`$.command.register`
- 状態は型の契約（`interface PluginState`）で宣言し、`plugin.json` に `"types"` を書く。
- フックは1回の呼び出しにつき10秒の持ち時間がある（`$` の呼び出しにかかる時間は数えない）。
- コマンド: `claude --plugin-dir <dir>`（ホットリロード）、`claude plugin validate <dir>`、`claude plugin test <dir>`、`claude plugin marketplace add <dir>`、`claude plugin install <name>@<marketplace> --scope user`、`/reload-plugins`、`claude --debug`
- テストは `claude-code/testing` から import する。
- 作例の置き場所: github.com/anthropics/claude-code-playground の `claude-code/mods`

## 関連ページ

- [[concepts/mods]]
- [[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]

## 取り込みメモ

- API は変わりうると明記されているため `recheck: weekly`。その後の版での API 追加は CHANGELOG を参照（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- Blast Radius は権限の仕組みの代わりにはならないと注意がある（`$(…)` などで迂回できる）。
