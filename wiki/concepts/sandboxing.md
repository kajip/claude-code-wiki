---
type: concept
title: サンドボックスと隔離（封じ込め）
updated: 2026-10-21
sources:
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/engineering/2026-04-08-scaling-managed-agents
  - sources/docs/2026-10-10-sandboxing
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
---

# サンドボックスと隔離（封じ込め）

## 概要

エージェントが「何をするか」ではなく「何ができるか」を、環境側の境界で制限する考え方と実装（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。承認ダイアログでの監督は疲れで形骸化するため、封じ込めを先に設計し、モデル側の防御は補助とする（同）。

## 現状（as of 2026-10-10）

docs の Bash サンドボックスのページを仕様の正として更新した。Cowork の docs と、docs の比較ページ（sandbox-environments）は未取り込み。下の「公開時点」の行は2026-05-25の記事の記述で、docs と矛盾する点は変更履歴と未解決に整理した。

### Claude Code の Bash サンドボックス（docs）
- 対象と段階: Bash、PowerShell、Monitor のコマンドとその子プロセスを OS が強制する境界で囲む。既定はオフで、`/sandbox` か `sandbox.enabled: true` で有効にする。ベータ等の段階表記はページに無い（`network.tlsTerminate` のみ experimental）（[[sources/docs/2026-10-10-sandboxing]]）
- 対応 OS と仕組み: macOS は Seatbelt、Linux と WSL2 は bubblewrap（`socat` も必要）。ネイティブ Windows ではサンドボックスなしで実行される。依存が欠けて起動できない場合も既定ではサンドボックスなしで動き、`sandbox.failIfUnavailable: true` で起動を止められる。実装は OSS の `@anthropic-ai/sandbox-runtime`（[[sources/docs/2026-10-10-sandboxing]]）
- ファイルの既定: 書き込みは作業ディレクトリ、ユーザー別 temp、追加ディレクトリ。読み取りはほぼ全体で、`~/.ssh` などの認証情報も読める。`sandbox.filesystem.allowWrite` / `denyWrite` / `denyRead` / `allowRead` で調整し、`.claude` 設定や `.bashrc` などの保護パスは `allowWrite` でも解除できない（[[sources/docs/2026-10-10-sandboxing]]）
- 認証情報: `sandbox.credentials` で `deny`（読み取り禁止、環境変数は unset）または `mask`（sentinel を見せ、プロキシが許可先で実値に差し替え）を指定する。組み込みの deny リストは無い（[[sources/docs/2026-10-10-sandboxing]]）
- ネットワークの既定: 直接の経路は無く、マシン上のプロキシ経由のみ。`network.allowedDomains` は空から始まり、許可外ホストの扱いは権限モードで決まる（bypass は許可、Manual と acceptEdits はプロンプト、auto mode と dontAsk は拒否）。`strictAllowlist` と `allowManagedDomainsOnly` で常時拒否にできる（[[sources/docs/2026-10-10-sandboxing]]）
- 承認の方式: auto-allow（サンドボックス内のコマンドは確認なし）と regular permissions の2種。`/sandbox` は権限モードではなく、auto mode の分類器とは別物で、組み合わせられる（[[sources/docs/2026-10-10-sandboxing]]）。→ [[concepts/auto-mode]]
- 逃げ道: 失敗したコマンドを `dangerouslyDisableSandbox` でサンドボックス外に再実行できる。`allowUnsandboxedCommands: false` の strict sandbox mode で無効にでき、managed 設定か `--settings` で設定するとリポジトリ側の緩和設定を無視する admin-required になる（v2.1.285 以降）（[[sources/docs/2026-10-10-sandboxing]]）
- 外で動くもの: Read / Edit / Write / WebFetch / WebSearch、フック、MCP サーバー、LSP、status line、`!` で自分が入力したコマンド、`excludedCommands` に一致するコマンド。サブエージェントは親と同じサンドボックス設定。プロセス全体を囲むには sandbox runtime、コンテナ、dev container を使う（[[sources/docs/2026-10-10-sandboxing]]）
- 既知の制限: 完全な隔離境界ではない。既定のプロキシは TLS を検査せずホスト名で判断するため、domain fronting などで許可外に届く可能性がある。Unix ソケット（`docker.sock` など）や `$PATH`・シェル設定への広い書き込み許可は権限昇格につながる。`enableWeakerNestedSandbox`（Linux）と `allowAppleEvents`（macOS）は隔離を弱める。ファイルとネットワークの両方の隔離が必要（[[sources/docs/2026-10-10-sandboxing]]）
- 非互換の例: `docker`、`jest`（`--no-watchman`）、macOS の Go 製 CLI の TLS 検証、macOS の git over SSH、DB クライアントなどプロキシ変数を読まないツール（[[sources/docs/2026-10-10-sandboxing]]）

### 記事の記述（公開時点）
- 製品ごとの型（公開時点）: claude.ai は gVisor の使い捨てコンテナ、Claude Code は OS レベルのサンドボックス＋人の承認、Cowork はローカル VM（[[sources/engineering/2026-05-25-how-we-contain-claude]]）
- Claude Code のサンドボックス（公開時点）: macOS は Seatbelt、Linux は bubblewrap。書き込みはワークスペース内、ネットワークは既定で拒否。権限プロンプトが 84% 減った。ランタイムは OSS（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。OS の仕組み・書き込み範囲・ネットワーク既定・OSS は docs と一致（[[sources/docs/2026-10-10-sandboxing]]）。84% は docs に記載なし
- リファレンス devcontainer は無人実行用（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。docs は dev container を「プロセス全体を囲む選択肢」として挙げる（[[sources/docs/2026-10-10-sandboxing]]）
- 防御は環境、モデル、外部コンテンツの3要素に重ねる。モデル層（auto mode など）は確率的で 100% にならない（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。→ [[concepts/auto-mode]]
- 設計上の教訓: 許可ドメインは「宛先フィルタ」ではなく「機能の付与」と考える。信頼ダイアログ前にプロジェクト設定を実行しない。symlink 解決をパス検証より先に行う。自前の部品が最も弱い（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。docs も広い許可ドメインの流出リスクを記し、保護パスに symlink が現れたら指す先も書き込み拒否にする（[[sources/docs/2026-10-10-sandboxing]]）
- 他の実装例: Managed Agents は sandbox を session、harness と分離し、認証情報を sandbox から届かない場所に置く（[[sources/engineering/2026-04-08-scaling-managed-agents]]）。→ [[concepts/managed-agents]]

### 最近の CHANGELOG の修正（2.1.299〜2.1.300）
- サンドボックス内のシェルコマンドが、`--plugin-dir` のフォルダ（Claude Code がサンドボックス外で再読み込み・実行するコード）に書き込めた問題を修正（2.1.299）。macOS で denied path が symlink 経由のとき、実体の場所から読み書きできた問題を修正（2.1.299）。`denyRead`／`allowRead` のグロブで、フォルダ名に波括弧・括弧・バックスラッシュがあると設定の確認とサンドボックスで解釈が違った問題を修正（2.1.299）。`allowRead`／`allowWrite` の起点ディレクトリが symlink に置き換わったとき再確認するようにした（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- `/sandbox` は、プロジェクトフォルダが書き込み不可で設定を保存できなかったとき、成功と報告せず「何も変わらなかった」と理由を示す（2.1.299）。モード表示は "Sandbox commands"（2.1.300）。`claude remote-control` の `--sandbox`／`--no-sandbox` は効果が無かったため削除され、指定するとエラーになる。代わりに設定の `sandbox.enabled`（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

**2.1.304〜2.1.305 の CHANGELOG（2026-10-20〜21、公開時点の記述）**

- **`sandbox.allowNestedUserNamespaces`（Linux、2.1.305）**: サンドボックス内のコマンドがユーザー名前空間を作れるようになる（Chromium、rootless podman 向け）。CHANGELOG は、これによりサンドボックスのファイル保護を回避しうると明記している。有効化すると隔離が弱まる設定で、docs の既知の制限にある `enableWeakerNestedSandbox` と同じ性格（推測）。設定の置き場所と既定値は CHANGELOG に無い（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `sandbox.filesystem.denyRead` のグロブに、文字クラスでない角括弧（`[user-id]` のルートフォルダなど）があると、Linux でサンドボックス内のコマンドが起動しない問題を修正（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `rm -r` でマウント済みドライブやトップレベルのフォルダ（`/Volumes`、`/media`、WSL の `/mnt/c`）を消すとき、`rm -rf /Applications` と同じ安全確認が出るようにした（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。

## 変更履歴

- 2026-10-21 — 2.1.305: `sandbox.allowNestedUserNamespaces` を追加（ファイル保護を回避しうる）。2.1.304: `denyRead` の角括弧グロブの修正、`rm -r` のマウント先への安全確認（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-14〜10-15 — 2.1.299〜2.1.300 のサンドボックス関連の修正を追記（上記）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — docs のサンドボックスページを取り込み、`## 現状` を docs 基準に更新。記事の記述（Seatbelt / bubblewrap、書き込み範囲、ネットワーク既定拒否、OSS）は docs と一致し、「公開時点」のまま残した。docs で新たに分かったこと: 既定オフ、auto-allow と regular の2モード、サンドボックス外への再実行と strict sandbox mode、認証情報の deny / mask、managed 設定による admin-required。段階表記は無い（[[sources/docs/2026-10-10-sandboxing]]）
- 2026-05-25 — 3製品の封じ込め設計と、見落とした4件のリスクを Engineering 記事で公開。Cowork は full-VM mode から、agent loop を VM 外に置く host mode へ移行済み（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

## 未解決・矛盾

- 記事の数値（93%、84%、約0.1%／5〜6% など）と Cowork・claude.ai の構成が現行でも同じかは未確認。docs のサンドボックスページに該当記載が無く（[[sources/docs/2026-10-10-sandboxing]]）、Cowork の docs 等の Ingest で確かめる。
- 記事の「Claude Code は OS サンドボックス＋人の承認」は、docs では auto-allow（承認なし）と regular permissions を選べる形になっている。記事の記述が既定構成の説明か、モード選択の簡略かは不明（推測: 簡略）（[[sources/engineering/2026-05-25-how-we-contain-claude]]、[[sources/docs/2026-10-10-sandboxing]]）。
