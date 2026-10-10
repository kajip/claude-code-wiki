---
type: source
source_id: docs
title: Configure the sandboxed Bash tool
url: https://code.claude.com/docs/en/sandboxing.md
published: unknown
retrieved: 2026-10-10
version: 
tier: primary
review: pending
recheck: none
fingerprint: sha256:4b3ad95a235ff8ea1c98ce60775c08ef3e8e9b2aa2e2bc39e643967b8747cbbb
archive_url:
---

# Configure the sandboxed Bash tool

## 要点

- Bash サンドボックスは、Claude が実行するシェルコマンド（Bash、PowerShell、Monitor とその子プロセス）を OS が強制する境界で囲む機能。既定はオフ。`/sandbox` を実行するか `sandbox.enabled: true` を設定して有効にする。
- 対応は macOS、Linux、WSL2。ネイティブ Windows ではサンドボックスなしで実行される。仕組みは macOS が Seatbelt、Linux と WSL2 が bubblewrap（Linux は `socat` も必要）。実装は OSS の `@anthropic-ai/sandbox-runtime`。
- 既定の境界は、書き込みが作業ディレクトリ・ユーザー別 temp・追加ディレクトリのみ、読み取りはほぼ全体（`~/.ssh` などの認証情報も読める）、ネットワークはプロキシ経由のみで許可ドメインは空から始まる。
- 2つのモードがある。auto-allow（サンドボックス内のコマンドは確認なしで承認）と regular permissions（サンドボックス内でも通常の確認）。サンドボックス外で再実行する逃げ道（`dangerouslyDisableSandbox`）は `allowUnsandboxedCommands: false` で無効化できる。
- ファイルツール（Read/Edit/Write）、WebFetch/WebSearch、フック、MCP サーバー、LSP、status line などはサンドボックスの外で動く。完全な隔離境界ではないと明記されている。
- 組織向けに managed settings で強制・ロックできる（`failIfUnavailable`、`allowManagedDomainsOnly`、admin-required など）。認証情報の `deny` / `mask` 機能がある。
- ベータや研究プレビューなどの段階表記はページ全体には無い。`network.tlsTerminate` だけが experimental と書かれている。

## 具体的な値

### 有効化
- `/sandbox`（パネルのタブ: Mode / Overrides / Config、Linux で seccomp が無いと Dependencies）。選択は `.claude/settings.local.json` に保存される。
- `sandbox.enabled`（`~/.claude/settings.json` に置けば全プロジェクト）。
- 1セッションだけ: `claude --settings '{"sandbox": {"enabled": true, "allowUnsandboxedCommands": false}}'`
- `sandbox.failIfUnavailable: true` — 依存欠如や非対応環境で起動時に終了させる。既定では、起動できないとサンドボックスなしで実行される。
- Linux の依存: `sudo apt-get install bubblewrap socat`（Ubuntu/Debian）、`sudo dnf install bubblewrap socat`（Fedora）。ripgrep はネイティブバイナリに同梱。任意の seccomp フィルタ（Unix ドメインソケットのブロック）は `npm install -g @anthropic-ai/sandbox-runtime`。
- Ubuntu 24.04 以降: `sysctl kernel.apparmor_restrict_unprivileged_userns` が `1` なら `/etc/apparmor.d/bwrap` のプロファイルを追加して `systemctl reload apparmor`。
- WSL1 では `Sandboxing requires WSL2` と表示される。

### モードと逃げ道
- auto-allow でも有効なもの: 明示的な deny ルール、critical path への `rm` / `rmdir`、`Bash(git push *)` のような内容指定の ask ルール。プランモードでは auto-allow は承認を広げない。
- 逃げ道の承認者: `bypassPermissions` はプロンプトなし、Manual と `acceptEdits` は "Bash command (unsandboxed)" のプロンプト、auto mode は別の分類器、`dontAsk` は拒否。一致する allow ルール（例 `Bash(curl *)`）は再実行も承認する。`Bash(dangerouslyDisableSandbox:true)` の ask ルールで常にプロンプトにできる。
- strict sandbox mode = `"allowUnsandboxedCommands": false`（Overrides タブ表示は Strict sandbox mode）。`!` で自分が入力したコマンドはバックグラウンドセッションと、Linux で `CLAUDE_CODE_SUBPROCESS_ENV_SCRUB` を設定したセッションを除きサンドボックス外。v2.1.260 より前は全セッションでサンドボックス内。v2.1.285 より前は、プロジェクトの `true` がユーザー設定の `false` を上書きできた。
- `sandbox.excludedCommands`（例 `["docker compose *"]`）— 一致するコマンドをサンドボックス外で実行。呼び出し全体の全コマンドが一致する必要がある。通常の権限フローを通る。

### ファイルの境界
- `sandbox.filesystem.allowWrite` / `denyWrite` / `denyRead` / `allowRead`。同じ配列は設定スコープ間でマージされる。重なる読み取りルールは狭いパスが優先。ただし広い allow の中の deny は保持される。
- パス表記: `/tmp/build` は絶対、`~/.kube` はホーム基準。Read/Edit の権限ルール（`//path` が絶対、`/path` がプロジェクト相対）とは異なる。`.` はプロジェクト設定に書けばプロジェクトルート。
- `permissions.blockReadsOutsideWorkingDirectories` — ホームなどの読み取りを塞ぐ。
- `sandbox.filesystem.disabled: true` — ファイル隔離だけをオフにしネットワーク隔離は残す（v2.1.216 以降。プロジェクト設定からは不可）。
- 書き込み既定: 作業ディレクトリ、`$TMPDIR` のユーザー別 temp、`--add-dir` / `/add-dir` / `permissions.additionalDirectories`。linked git worktree では本体の共有 `.git` も書き込み可（`hooks/` と `config` は拒否）。
- 保護パス（`allowWrite` でも解除不可）: `.claude` の設定ファイルと skills / agents / commands / hooks、`.mcp.json`、`.bashrc` `.zshrc` `.gitconfig`、`.vscode` `.idea`、`.git` 内の `hooks` と `config`、`~/.claude`、`~/.claude.json`、`.credentials.json` など。
- 認証情報: `sandbox.credentials`（`files` / `envVars`、`mode` は `deny` か `mask`）。`mask` は sentinel を見せ、プロキシが許可先で実値を差し込む。`network.tlsTerminate`、`injectHosts`、`extract`、`decode`、`maskClaims`、`onExtractNoMatch`、`awsPairs`、`sigv4`。ファイル mask は v2.1.221 以降、macOS では deny 相当。組み込みの deny リストは無い。

### ネットワークの境界
- Linux/WSL2 は別 network namespace、macOS は Seatbelt でプロキシ以外への接続をブロック。プロキシは `HTTP_PROXY` `HTTPS_PROXY` `ALL_PROXY` で指示される。
- `sandbox.network.allowedDomains`（既定は空、ポート無しは全ポート）、`deniedDomains`、`strictAllowlist`（v2.1.219 以降）、`allowManagedDomainsOnly`。IPv6 は `"[::1]"` 形式（v2.1.229 以降）。
- 許可外ホスト: `bypassPermissions` は許可、Manual / `acceptEdits` はプロンプト、auto mode は拒否（コマンドが列挙して分類器が承認した場合を除く）、`dontAsk` は拒否。「Yes, and don't ask again」は `WebFetch(domain:...)` の allow ルールとして保存。
- auto mode のコマンド単位の許可ドメイン（v2.1.271 以降）: そのコマンドの間だけホストを開く。設定には追加されない。
- ループバックなどに解決されるホスト名はプロキシが拒否（v2.1.284 より前は接続した）。
- TCP 以外（UDP、QUIC、ICMP）と、プロキシ変数を読まないツール（素の `ssh`、多くの DB ドライバ）は外に出られない。
- カスタムプロキシ: `network.httpProxyPort` / `socksProxyPort`。設定すると Claude Code のネットワーク制御は効かなくなる。企業プロキシは `HTTPS_PROXY` / `HTTP_PROXY` / `NO_PROXY`。
- 緩和系: `enableWeakerNestedSandbox`、`enableWeakerNetworkIsolation`、`network.allowAllUnixSockets`、`network.allowLocalBinding`（macOS のみ有効）、`allowAppleEvents`。

### 組織向け
- managed settings 例: `{"sandbox": {"enabled": true, "failIfUnavailable": true, "allowUnsandboxedCommands": false}}`
- `allowManagedReadPathsOnly`、admin-required（`allowUnsandboxedCommands: false` を managed または `--settings` で設定、または `allowManagedDomainsOnly`）。この状態ではリポジトリの `.claude/settings*.json` による緩和設定は無視される（v2.1.285 以降。v2.1.282〜284 は `excludedCommands` のみ無視）。

### トラブルシュートで挙がる非互換
- `jest` は `--no-watchman`。`docker` は非互換で `excludedCommands` が必要。macOS の Go 製 CLI（`gh`、`gcloud`、`terraform`）は TLS 検証に失敗しうる。`open` / `osascript` は Apple Events が既定でブロック（エラー `-600`）。クリップボード系（`pbcopy` `xclip` `wl-copy`）は届かないことがあり `/copy` を使う。macOS の git over SSH は失敗する（Linux/WSL2 は可）。コンテナ内の bubblewrap は `enableWeakerNestedSandbox` が必要。
- 診断コマンド: `claude doctor`。

### 既知の制限（原文の Limitations）
- 完全な隔離境界ではない。既定のプロキシは TLS を終端・検査せず、ホスト名で判断するため、domain fronting などで許可外へ届く可能性がある。`github.com` のような広いドメインは流出経路になりうる。TLS を意識した強い隔離は開発中と書かれている。
- Unix ソケット（例 `/var/run/docker.sock`）の許可、`$PATH` 上の実行ファイルや `.bashrc` への広い書き込み許可は権限昇格につながる。
- Linux の `enableWeakerNestedSandbox` は安全性を大きく下げる。macOS の `allowAppleEvents` はコード実行の隔離を外す。
- 範囲外: 内蔵ファイル/Web ツール、フック、MCP、LSP、プラグイン monitor、helper コマンド、ユーザー入力の `!` コマンド、除外コマンド、mod が起動するプロセス、computer use。サブエージェントは親と同じ設定でサンドボックス化される。
- 実効的な隔離にはファイルとネットワークの両方が必要。

## 関連ページ

- [[concepts/sandboxing]]
- [[concepts/auto-mode]]（auto mode のコマンド単位ドメインと分類器との関係。別の Ingest で更新中）
- [[sources/engineering/2026-05-25-how-we-contain-claude]]

## 取り込みメモ

- docs ページは公開日が無いため `published: unknown`。ファイル名と retrieved は取得日（2026-10-10）。raw Markdown を curl で取得し、sha256 を付けた（1001 行）。
- `version` は該当バージョンが単一でないため空。本文中の「v2.1.xxx 以降」はページが示す要件。
- 数値（84%、93% など）は docs に無い。Linux/macOS の動作差（localhost、git over SSH、mask）は原文のとおり。
- ページ内に外部への指示文は無かった。比較ページ `sandbox-environments`（dev container、カスタムコンテナ、VM との比較）と cloud の `claude-code-on-the-web#security-and-isolation` はリンクのみで取り込んでいない。
- 設定キーの詳細一覧は `settings-reference` にあり、未取り込み。
