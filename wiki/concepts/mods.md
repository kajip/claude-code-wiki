---
type: concept
title: mods（Claude Code mods）
updated: 2026-10-21
sources:
  - sources/docs/2026-10-10-mods
  - sources/claude-blog/2026-10-01-customize-claude-code-with-mods
  - sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
---

# mods（Claude Code mods）

## 概要

Claude Code の動きと見た目を変える、小さな TypeScript／JavaScript の関数。プラグインに入れて配る（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）。docs の定義では、mod は Claude Code のプロセス内で動くイベントハンドラ（hook）を持つプラグインで、ミドルウェアのような鎖として動く。設定ファイルの hook（[[concepts/hooks]]）とは別物で、docs は後者を「settings hook」と呼ぶ（[[sources/docs/2026-10-10-mods]]）。詳しいフィールドや API は docs の要約ページにある。

## 現状（as of 2026-10-16）

- **対応版**: ターミナルは 2.1.287 以降、Desktop アプリは 2.1.286 以降で既定有効。CLI と Desktop の Code タブで動く。ベータ等の表記は docs に無い（[[sources/docs/2026-10-10-mods]]）。API は版ごとに変わりうるので、`.claude-plugin/types/` に書き出される型定義を正とする（同）。
- **構成**: `.claude-plugin/plugin.json`、`hooks/hooks.json`（`"modules": ["./register.js"]`）、hooks モジュール（`export function register(on, options)`）の3つ。mods が plugin.json に足す必須フィールドは無い。mod 用の任意キーは `types`（`$.state` などの型宣言）と `userConfig`。plugin.json の全フィールドは要約ページの一覧を参照（同）。
- **hook の形**: `on(event, matcher?, ($, e, next) => ...)`。観察（`next(e)`）、書き換え（コピーを `next` へ）、答える（`next` を呼ばない）の3通り。失敗は `.catch(handler)` で受ける。実行順は「sec-default と組織の prepend → ユーザーの mod → 組織の append → 他の組み込み」（同）。
- **mods API `$`**: `ui`、`command`、`tool`、`agent`、`model`、`prompt`、`turn`、`session`、`config`、`settings`、`env`、`fs`、`store`、`state`、`clock`、`http`、`process`、`mcp`、`audio`、`telemetry`、`plugin` の namespace。モジュール自体に Node API は無く、外との接触は `$` 経由（同）。`$.model.complete` の戻りは `{ isAnswered, text, reason, usage }` で、`prompt` をブロック配列にして `cache: true` でキャッシュ breakpoint を置ける（v2.1.292 以降）（同）。
- **コード例**: docs の `first-mod`（`session.start` で `/tally` を登録、`tool.call` で数える、`command.run` で答える、`ui.render` の Spinner に `suffix` を足す）が最小例。全文は要約ページ（同）。
- **開発の道具**: `claude --plugin-dir`（保存でホットリロード）、`/reload-plugins`、`claude plugin validate`（`--strict`、`--json`。`hooks:`／`calls:` を表示）、`claude plugin test`（`claude-code/testing` のテストキット。`mock.clock` などのモック付き、失敗で終了コード 1、1テスト 5 秒）。Claude に頼んで作ることもでき、その場合は `plugin-authoring` スキルが使われ、`~/.claude/dev-mods/<session-id>/` に書かれる（同）。
- **サンドボックスは無い**: ユーザーと同じ権限で動き、ファイル、プロセス、ネットワーク、環境変数、設定、プロンプトとツール呼び出しの全てに触れる。`sandboxing` を有効にしても、mod が起動したプロセスはその外で動く。権限プロンプトの表示だけは変えられない（同。[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]] も同趣旨）。
- **組み込み mod**: `cc-plugin-agents-md`、`cc-plugin-diff`、`cc-plugin-plugin-authoring`、`cc-plugin-sec-default`、`cc-plugin-telemetry`、`cc-plugin-you-should-know`（既定で無効）。`disableAllHooks`、`--bare`、`--safe-mode` では止まらない（[[sources/docs/2026-10-10-mods]]）。
- **管理者の制御**: guard `sec-default@builtin` は managed settings のある端末か Team／Enterprise のサインインで最初に読み込まれる。`pluginConfigs` の `cc-plugin-sec-default@builtin` に `allowManagedModsOnly`／`allowModsToOverrideDenyRules` を置く。ほかに `allowManagedHooksOnly`、`disableAllHooks`、`disableSideloadFlags`、`prependPlugins`／`appendPlugins`。組織の mod は `plugin.register` で他の mod を拒否できる（同）。
- **動作環境の差**: VS Code 拡張、`claude -p`、Agent SDK、クラウドセッションでは hook は走るが描画は出ない。Desktop の WSL セッションはどちらも不可（同）。
- **配布と公開**: `/plugin install <name>@<marketplace>`。公開は自前マーケットプレイス、または claude.ai/directory/manage の開発者ポータルへの申請（有料プラン、`claude plugin validate --strict` を通す、Claude Code 専用要素の確認、ポータルで申請）。`claude-plugins-official` は申請不可。公開済みの `name` は変えない。`claude-` などで始まる名前は `validate` がエラーにする（同）。
- 2.1.290〜2.1.296 で追加された API: `turn.step` の `serverToolUses`、`tool.check` の `agentId`／`ceiling`、`prompt.autocomplete`、`$.model.complete` の `cache: true`、`$.tool.register` の `isDeferred`、`$.ui.notify`（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 2.1.299〜2.1.301 で追加・変更された API: **`prompt.change` フック**（入力欄の文字がタイプ以外で変わったとき。履歴の呼び戻し、クリア、undo、プラグインの入力）、`virtualText`（プロンプトの装飾。ドラフトにも送信にも入らない）、`$.ui.view({ agentId })`、`Text` の `dir`、`size`／`weight`／`mono`／`tabular`（`bold` は非推奨）、`Box` の間隔 `xs`〜`xl`、`Input` の `rows`、`$.prompt.media` と `$.session.identity()`（managed settings で入れた mod 向け）、`skill.prompt` の受け取る情報、`session.append` の `queue` door、`agent.spawn` での workflow エージェントの `prompt`／`model` の書き換えと resume への発火、`turn.start` がサブエージェントも受け取る（`e.agentId`）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- 挙動の変更: フックの `.catch` は throw かタイムアウトのときだけ走る（2.1.301）。`$.env.set` は成功で `{}`、拒否で `{ deny }` を返す（2.1.301）。`claude plugin test` は 10 秒答えない `$` メソッドを失敗とし、`ui.render` の木の各 mod ルートに `part: { plugin }` が付くので、木を厳密に比べるテストは更新が必要（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- 強制の強化: managed な permission rule、hook、組織の MCP ツール名が、ユーザー mod に対してより確実に効く（2.1.299）。ユーザー mod の `$.env.set` が managed settings のコマンドフックの環境を変えられなくなった（2.1.300）。`__proto__` キーが黙って消されて `tool.check` の guard を飛ばせた問題を修正（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

**2.1.304〜2.1.305 の CHANGELOG（公開時点の記述）**

- `tool.check` の答えに `decider: "person"` を追加（2.1.304）。許可ダイアログかホストのコールバックだけが承認でき、誰にも聞けない環境では mod の理由つきで拒否される。`tool.check` のイベントに `e.isReadOnly`（読み取り専用の呼び出しで true）も追加（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `settings.read` フックは各 settings 層を受け取り、マージ後の設定を書き換えられる（2.1.304）。managed な mod が組織の設定を上限にでき、保持期間の掃除が使う `cleanupPeriodDays` も対象（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 先に走るプラグインが mod のフックを飛ばしたとき、transcript にイベントとプラグイン名の行が出る。mod のリロード失敗で前の版のツールとコマンドが消える問題、同ラベルでキーなしのボタンのクリックが失われる問題を修正。VS Code のチャットパネルで、Bedrock、Vertex、Foundry、LLM ゲートウェイ配下、テレメトリ無効のセッションでも mod を描画（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `Image` が iTerm2 3.5 以降の fullscreen rendering で画像を描く。ドック領域は端末幅の 45% 以内（2.1.305）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。

## 変更履歴

- 2026-10-20〜10-21 — 2.1.304〜2.1.305: `decider: "person"`、`e.isReadOnly`、`settings.read` の層別受け取りと書き換えなどを追加・変更（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-14〜10-15 — 2.1.299〜2.1.301 で上記の API を追加・変更（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — docs（Mods overview と配下のページ）を取り込み、plugin.json、hooks.json、register の例、`$` の API、テスト、型定義、公開手順、管理者設定を追加（[[sources/docs/2026-10-10-mods]]）。
- 2026-10-06〜10-10 — 2.1.290〜2.1.296 で API を追加（上記）。組織の mod のトーストを先に出すよう変更（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-01 — 発表（[[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]]）。同日の claude-dev の入門記事では、必要な版を 2.1.287 以降と書いていた（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。docs は Desktop のみ 2.1.286 以降とする。

## 未解決・矛盾

- 入門記事（公開時点）はイベントの1つに `session.usage` を挙げている（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。docs の v2.1.290 時点のイベント一覧には無く、近いものは `session.measure` と `$.session.usage()`（[[sources/docs/2026-10-10-mods]]）。docs を現状として採るが、改名かどうかは未確認。
- `$` の各メソッドの引数と戻り値の完全な型は docs のページには無い（手元の `claude-code/index.d.ts` が正本）。wiki には docs の例に出た範囲だけを記録している（[[sources/docs/2026-10-10-mods]]）。
