---
type: analysis
title: mods の作り方
updated: 2026-10-11
question: mods の作り方を教えて
sources:
  - sources/docs/2026-10-10-mods
  - sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods
  - sources/claude-blog/2026-10-01-customize-claude-code-with-mods
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
---

# mods の作り方

as of 2026-10-11（docs は v2.1.290 時点の記述）

## 前提

- mod は、JS／TS のイベントハンドラ（hook）を持つプラグインで、Claude Code のプロセス内で動く。設定ファイルに書く hook（docs では「settings hook」）とは別物（[[sources/docs/2026-10-10-mods]]）。
- ターミナルは 2.1.287 以降、Desktop は 2.1.286 以降で既定有効（[[sources/docs/2026-10-10-mods]]）。
- **サンドボックスは無い**。ユーザーと同じ権限で動く。権限プロンプトの表示だけは変えられない（[[sources/docs/2026-10-10-mods]]）。信頼できる提供元のものだけを入れる（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）。

## 手順

### 1. Claude に書かせるか、自分で書くか決める

- Claude に頼む: 組み込みスキル `/plugin-authoring`。書き込み先は `~/.claude/dev-mods/<session-id>/` で、そのセッションだけで有効。`claude -p`、`dontAsk`、信頼していないディレクトリ、`--safe-mode`／`--bare`、`disableAllHooks` では読み込まれない（[[sources/docs/2026-10-10-mods]]）。
- 自分で書く: 以下の手順。

### 2. 最小の3ファイルを置く

```
my-mod/
├── .claude-plugin/plugin.json   # name だけ必須
└── hooks/
    ├── hooks.json               # { "description": "...", "modules": ["./register.js"] }
    └── register.js              # export function register(on, options)
```

- `hooks.json` の `modules` にパスを1つ書くと、そのプラグインが mod になる。ビルド不要で `.js`／`.ts` を直接読む（[[sources/docs/2026-10-10-mods]]）。
- `$.state` を使うなら `types/index.d.ts` を置き、`plugin.json` の `types` で指す（[[sources/docs/2026-10-10-mods]]）。
- `name` に `claude-`、`anthropic-`、`cc-plugin-` などで始まる名前は使えない（`validate` がエラー）（[[sources/docs/2026-10-10-mods]]）。
- 利用者に設定させたい値は `plugin.json` の `userConfig` に書く。値は `register` の `options` に既定値込みで渡る（[[sources/docs/2026-10-10-mods]]）。

### 3. hook を書く

docs の例（ツール呼び出しを数え、スピナーに表示し、`/tally` で答える）（[[sources/docs/2026-10-10-mods]]）:

```javascript
let calls = 0
export function register(on) {
  on('session.start', async ($, e, next) => {
    await $.command.register({ name: 'tally', description: 'Show how many tool calls Claude has made' })
    return next(e)
  })
  on('tool.call', async ($, e, next) => { calls += 1; $.ui.invalidate('ui.render'); return next(e) })
  on('command.run', { command: 'tally' }, async () => ({ text: 'Claude has made ' + calls + ' tool calls since this mod loaded' }))
  on('ui.render', { component: 'Spinner' }, async ($, e, next) =>
    next({ ...e, props: { ...e.props, suffix: ' · tool calls: ' + calls + '…' } }))
}
```

- `on(event, matcher?, hook)`。hook は `($, e, next)` を受け取る。`$` は mods API、`e` は凍結されたイベント、`next` は次のハンドラ（[[sources/docs/2026-10-10-mods]]）。
- 使い方は3通り（[[sources/docs/2026-10-10-mods]]）:
  - 観察する: `next(e)` をそのまま呼ぶ。
  - 書き換える: コピーを `next` に渡す。
  - 答える: `next` を呼ばずに結果を返す。例は `{ deny }`、`{ result }`、`{ text }`。
- 同じイベントを matcher 無しで2回登録すると、読み込みに失敗する（[[sources/docs/2026-10-10-mods]]）。
- 外とのやりとりはすべて `$` を通す。Node の API も `setTimeout` も無い（[[sources/docs/2026-10-10-mods]]）。
  - ファイル: `$.fs`
  - コマンド: `$.process.run`
  - HTTP: `$.http.fetch`
  - タイマー: `$.clock`
  - 状態: `$.state`（セッション中）、`$.store`（全セッションで共有する JSON）
- hook の持ち時間は1イベントにつき10秒（`prompt.edit` は50ミリ秒）。`$` の呼び出し中は数えない（[[sources/docs/2026-10-10-mods]]）。
- 正しい型は、手元の版で `.claude-plugin/types/claude-code/index.d.ts` に書き出されるもの。GitHub の型定義は古いことがある（[[sources/docs/2026-10-10-mods]]）。

### 4. 動かして試す

- `claude --plugin-dir ./my-mod`。保存するとホットリロードされ、`register` が再実行される（モジュール変数は初期化される）。手動で読み直すなら `/reload-plugins`、調べるなら `claude --debug`（[[sources/docs/2026-10-10-mods]]、[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。

### 5. 検証とテスト

- `claude plugin validate ./my-mod`（`--strict`、`--json`）。出力の `hooks:` と `calls:` で、何に反応し何を呼ぶかを確かめる（[[sources/docs/2026-10-10-mods]]）。
- `validate` の静的解析が通る書き方（[[sources/docs/2026-10-10-mods]]）:
  - `$.ns.method` を省略せずに書く。
  - `$` を変数に入れたり、分割代入したりしない。
  - イベント名は文字列リテラルで書く。
  - 動的 `import()` と `require` は使わない。
- `claude plugin test ./my-mod`: `*.test.ts` を実行する。`import { expect, test, mock } from 'claude-code/testing'`。テスト側の `$` が Claude Code の役を務め、`on(name, stub)` で返答を差し込む（[[sources/docs/2026-10-10-mods]]）。

### 6. 配る

- `plugin.json` の `version` を上げて push する。版でキャッシュされるため、版を上げないと編集は反映されない（[[sources/docs/2026-10-10-mods]]）。
- 共有の範囲で配り方を選ぶ（[[sources/docs/2026-10-10-mods]]）:
  - 少人数: ディレクトリか `.zip`
  - チーム: 自前のマーケットプレイス
  - 組織全体: 管理者が managed settings で配る
  - 一般: 公開マーケットプレイスか、Anthropic のディレクトリに申請
- 入れる側: `claude plugin marketplace add <dir>` の後、`claude plugin install <name>@<marketplace>`（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。
- Anthropic のディレクトリへの申請（[[sources/docs/2026-10-10-mods]]）:
  - 有料の claude.ai プランが要る。
  - `claude plugin validate --strict` を通す。
  - claude.ai/directory/manage から申請する。

## 気をつけること

- Team／Enterprise と managed settings のある端末では、組み込みの `sec-default` が先に動く。ユーザーの mod は `deny` ルールや管理 `PreToolUse` のブロックを覆せない（[[sources/docs/2026-10-10-mods]]）。
- 管理者が `allowManagedModsOnly` を有効にしていると、ユーザーの mod は全て拒否される（[[sources/docs/2026-10-10-mods]]）。
- 作例: anthropics/claude-code-playground の `claude-code/mods`（`token-weather`、`blast-radius`、`replay-theater`。無保証）（[[sources/docs/2026-10-10-mods]]）。

## wiki に無いこと

- `$` の各メソッドの完全な型（正本は手元の `index.d.ts`）。
- interface ページの細部（要素の木の組み立て、ホットキー、フォーカス）と、troubleshoot のメッセージ一覧。
- ディレクトリ申請の審査の中身（claude.com 側）。
- イベント `session.usage`（claude-dev の記事）は docs の一覧に無い。改名かどうかは [[concepts/mods]] の未解決に残している。
