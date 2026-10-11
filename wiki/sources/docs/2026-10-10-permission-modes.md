---
type: source
source_id: docs
title: Choose a permission mode
url: https://code.claude.com/docs/en/permission-modes.md
published: unknown
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: b6c78ae3ef22a18d2ec6e4f9b2d42bd3299890be23c65f3c57d3712869cb44e2
archive_url:
---

# Choose a permission mode

## 要点

- 権限モードは、確認なしで Claude ができる範囲を決める。モードは `default`（表示名 Manual）、`acceptEdits`、`plan`、`auto`、`dontAsk`、`bypassPermissions` の6つ。deny ルールは全モードで効く。
- Claude Code v2.1.283 以降、auto mode は対話的な terminal と VS Code セッションの組み込みの開始モード（全プラン・全プロバイダ）。それ以前は Pro、Max、Team のみ。
- auto mode の要件は、プランが全プラン、プロバイダは Anthropic API / Claude Platform on AWS / Bedrock / Google Cloud の Agent Platform / Microsoft Foundry / サインイン済み Claude apps gateway、対応モデルはプロバイダで異なる（下記）。Team と Enterprise では既定で利用可、管理者は `permissions.disableAutoMode: "disable"` で止められる。
- 分類器は既定で Sonnet 5 で動く（`/model` の選択ではない）。見るのはユーザーのメッセージ、読み取り専用以外のツール呼び出し、CLAUDE.md で、ツール結果は除かれる。サーバー側で審査する経路もある。
- 既定でブロックされる行為の一覧が詳細にある（`#what-the-classifier-blocks-by-default`）。`rm`/`rmdir` の critical path は分類器を通らず、モード別に扱いが決まる。
- 拒否が3回連続か合計20回で auto mode が一時停止してプロンプトに戻る（設定不可）。段階（プレビュー等）の記載はこのページに無い。

## 具体的な値

**モード一覧と切り替え**

- `default`: 読み取りのみ。`acceptEdits`: 読み取り、ファイル編集、`mkdir`/`touch`/`rm`/`rmdir`/`mv`/`cp`/`sed`。`plan`: 読み取り、auto mode が使えれば分類器が承認したコマンド（`useAutoModeDuringPlan` 既定 on）。`auto`: すべて、背景で安全確認。`dontAsk`: 事前承認ツールのみ、他は拒否。`bypassPermissions`: すべて（コンテナ・VM 専用）。
- CLI: `Shift+Tab` で循環（auto から1回で `default`、次に `acceptEdits`、`plan`。任意モードは `plan` の後に `bypassPermissions`、`auto` の順）。`dontAsk` は循環に出ない。起動時は `claude --permission-mode plan` 等。`manual` は `default` の別名。
- Bash の許可プロンプトに「Yes, and switch to auto mode」（v2.1.247 以降）。
- VS Code: モード表示のクリック。`claudeCode.initialPermissionMode` は `auto` を受け付けない。Desktop: 送信ボタン横のセレクタ。Web/モバイル: cloud sessions は Accept edits / Plan / Auto（Bypass 不可。auto は組織が許可しモデルが対応する場合のみ）、Remote Control は Manual / Accept edits / Plan / Auto。
- 開始モードの優先順: `--permission-mode` か `--dangerously-skip-permissions` → `permissions.defaultMode` → 組み込み既定。`.claude/settings.json` と `.claude/settings.local.json` の `defaultMode: "auto"` と `"bypassPermissions"` は効かない。組み込みの `auto` 既定は macOS/Linux/WSL で v2.1.228 以降、native Windows で v2.1.233 以降。`claude -p`/Agent SDK は feature flag を取得するセッションで `default`。HIPAA 構成の組織では `default`（v2.1.285 以降）。`disableAutoMode` が設定されていれば `default`。
- plan mode の承認選択肢に「Yes, and use auto mode」。

**auto mode の要件（原文表記）**

- Plan: All plans。Organization: Team と Enterprise は既定で利用可、`permissions.disableAutoMode` を `"disable"` にすると組織で無効（managed settings）。
- Model: Anthropic API と Claude Platform on AWS は Claude Opus 4.6 以降、Sonnet 4.6 以降、Haiku 5.5、Fable モデル。Amazon Bedrock、Google Cloud の Agent Platform、Microsoft Foundry、サインイン済み Claude apps gateway は Sonnet 5 以降、Opus 4.7 以降、Haiku 5.5、Fable のみ。Sonnet 4.5、Opus 4.5、Haiku 4.5、claude-3 系はどのプロバイダでも非対応。非対応モデルではセッションは Manual で始まる。これらのプロバイダでの Haiku 5.5 は v2.1.293 以降。
- v2.1.158〜v2.1.206 は上記の第三者プロバイダで `CLAUDE_CODE_ENABLE_AUTO_MODE=1` が必要だった。v2.1.207 以降は効果なし。
- `disableAutoMode` 設定で実行中のセッションも auto mode を抜ける（v2.1.251 以降。それ以前は終了まで継続）。表示は `auto mode disabled by settings`。

**分類器**

- モデル: 既定で Claude Sonnet 5。Anthropic がサーバー側で設定したモデルがあればそちらが優先。セッションのモデルが Sonnet 4.6、または `availableModels` が Sonnet 5 を除外している場合はセッションのモデル、Fable セッションでは Opus モデル。第三者プロバイダでの Opus の代替は `ANTHROPIC_DEFAULT_OPUS_MODEL`、未設定なら Opus 5。最初のリクエストで Sonnet 5 を検証し、利用不可なら代替へ。
- 見るもの: ユーザーのメッセージ、読み取り専用の検索以外のツール呼び出し、CLAUDE.md。ツール結果は除かれる。別にサーバー側の probe が入ってくるツール結果を走査する。PostToolUse hook の `classifierContext`（v2.1.236 以降）で結果に注釈を付けられる。
- 評価順: (1) allow/ask/deny ルールで即決（保護パスへの書き込み、critical path の `rm`/`rmdir`、`requiresUserInteraction` の MCP ツールは例外）、(2) 読み取り専用と作業ディレクトリ内の編集は自動承認、(3) それ以外は分類器、(4) ブロック時は理由（例 `[Data Exfiltration]`）が Claude に返る。
- auto mode に入ると、`Bash(*)`、`Bash(python*)` のような広い allow、パッケージマネージャ実行、`Agent`、`Monitor` の allow ルールは外される（抜けると復元）。
- サブエージェント: 起動前にタスク記述、実行中は各アクション、終了時に最終報告を審査。frontmatter の `permissionMode` は無視。
- `SendMessage`（エージェント間メッセージ）も審査（v2.1.222 以降）。
- サーバー側審査: Anthropic API 直結で v2.1.271 以降（Pro/Max/Team の terminal）、v2.1.278 以降（Enterprise と API アカウント）、`-p`/SDK/VS Code/Desktop は v2.1.281 以降。クラウドプロバイダや LLM gateway では v2.1.278 以降が既定。サーバーが審査しないと独自の分類器リクエストに戻る。判定が得られなければ拒否し、10回連続で無判定ならターンを止める。`CLAUDE_CODE_AUTO_MODE_SERVER=0` で独自分類器に固定。
- コスト: Enterprise と API 系アカウントでは分類器の呼び出しがトークン使用量に入る。読み取りと作業ディレクトリ内の編集は分類器をスキップ。
- サンドボックス内のネットワークは既定で無し。コマンドが必要なホストを名指しし、分類器がコマンドと一緒に審査して、そのコマンドだけ開く。

**既定でブロック（`#what-the-classifier-blocks-by-default`）**

- 信頼範囲は作業ディレクトリと、セッション開始時に設定済みの remote。セッション中に `git remote add`/`set-url` した remote は信頼しない。
- 基本: `curl | bash` のようなコードのダウンロード実行、機微データの外部送信、本番デプロイとマイグレーション、クラウドストレージの大量削除、IAM やリポジトリ権限の付与、共有インフラの変更、セッション前から存在するファイルの不可逆な破棄、force push。
- 秘密情報や機微データがリポジトリ外に出る、またはデプロイの公開範囲が広がる変更のコミット・push（どのブランチでも、公開リポジトリでも。v2.1.211 より前は既定ブランチのみが対象）。
- `git reset --hard`、`git checkout -- .`、`git restore .`、`git clean -fd`、`git stash drop`/`clear`。HEAD が当セッション作成でない場合の `git commit --amend`、v2.1.198 以降は push 済みの場合も（Claude がこのセッションで作った未 push のコミットへ、何も追加 stage せず `-m` だけの reword は除く）。
- `terraform destroy`、`pulumi destroy`、`cdk destroy`、`terragrunt destroy` と、リソースを破棄する plan の適用。
- シークレットマネージャへの書き込み、DNS や TLS 証明書の変更。人間が承認していない PR のマージ、Claude 自身の PR の承認、CI チェックの無効化。`atlantis apply` や `/deploy` のような自動化へのコマンドコメント。
- 本番 feature flag の切替・段階的展開・削除。保護された IaC スコープへの適用、クラスタノードの drain と削除。名指しした範囲を超える共有クラスタへの書き込み（label selector や `--all`）。全ノードで動く、またはクラスタ通信を横取りする Kubernetes リソース（DaemonSet、admission webhook）。
- 機微なリモート対象への対話シェルや port-forward。ローカルサービスを公開インターネットに出すトンネルやリバースシェル。生の認証情報やトークンをトランスクリプトやファイルに出力。
- environment で機微データ場所とされた場所へのアクセスと、そこからの持ち出し。内部パッケージレジストリを迂回して公開レジストリから install。`--insecure` のように安全装置を外すフラグ。
- 人間の承認もサンドボックスも無い自律エージェントループ（`--dangerously-skip-permissions`、`--no-sandbox`、`--yes-always` 等）。Claude in Chrome で、ページ内容・cookie・認証情報をオリジン外に送りうる操作。
- `/tmp`、`$TMPDIR` など共有スクラッチ領域のワイルドカード・glob・経過時間による削除。他者や共有システム宛てのコンテンツに、本人が許可していない機微な詳細を含めること（PR/issue 本文、コミットメッセージ、コメントを含む。v2.1.203 以降の確認）。
- Claude Code 自身の tmux ペインへのキー送信。セキュリティ挙動を守るテスト（認証、アクセス制御、入力検証、サンドボックス）のコメントアウト・削除・強制 pass。Claude が作っていない stateful リソースの削除。API base URL、proxy、webhook、registry mirror を無関係な第三者ホストへ向け直すこと。`git remote set-url`/`add`（名指しされた場合を除く）。公開リポジトリへの秘密・個人データの push。別リポジトリ・組織への PR、`gh repo fork`、第三者リポジトリへの push（名指しされた外部対象を除く）。
- v2.1.203 以降: 機微なローカルストア（セッショントランスクリプト、SSH 鍵、クラウド認証情報、ブラウザプロファイル、シェル履歴、ユーザーデータのエクスポート等）や機微と判断できるファイルの内容が、コミット、push、PR/issue、gist、パッケージ公開に入ること（送り元と送り先の両方を名指ししない限り）。
- v2.1.205 以降: `~/.claude/projects/` 配下の `.jsonl` トランスクリプトへの書き込み（読み取りは可）。会話に出てこないシェル変数を対象にした `rm -rf "$VAR"` や `Remove-Item -Recurse -Force $dir`（正確なパスを名指しするか、解決済みの実パスで再実行すれば解除）。
- v2.1.257 以降: クラウドのインスタンスメタデータ（`169.254.169.254`）からの認証情報取得、マシン自身のサービスアカウント・ノード ID での認証、直接リクエスト以外の経路（トンネル、リバースシェル、resolver・proxy 設定の書き換え）での公開ホスト到達、ホスト側の認証情報の読み取り、自分で起動していない兄弟コンテナ・pod・VM やノードへの接続・スキャン。許可したい環境は `autoMode.environment` の Host containment エントリで記述。
- v2.1.261 以降: URL 自体が共有内容を運ぶ公開 paste・図・データ共有サービスへのリンクの投稿（サービスを名指ししない限り）。
- 全ルールは `claude auto-mode defaults` が JSON で出力する。

**既定で許可**

- 作業ディレクトリのローカルファイル操作、lock ファイルやマニフェストにある依存の install、`.env` の読み取りと対応する API への認証情報送信、読み取り専用 HTTP、作業中リポジトリの任意ブランチ（既定ブランチ含む）への push（`production` や `gh-pages` のような配布先ブランチは別途判断）、同セッションで作ったジョブの削除、セキュリティ関連コードの読み書き、同一マルチエージェントセッション内のエージェント間メッセージ、`environment` に挙げた信頼先へのデータ送信、信頼ドメイン・localhost・名指しした URL への Chrome 操作。
- v2.1.211 より前は、開始ブランチ、Claude 作成のブランチ、既定ブランチへの定型 push のみ許可。v2.1.203 より前は既定ブランチへの直接 push はブロック。

**会話での境界・承認、拒否時の挙動**

- 「don't push」等の境界は分類器が履歴から読み直す。保存はされず、コンテキスト圧縮で失われうる。確実にするなら deny ルール。承認は、行為と危険の具体点を名指ししたときだけ効き、1回の行為に限る（常設は `autoMode.allow`）。
- ブロック時: 通知と `/permissions` の Recently denied タブ（`r` で再試行）。3回連続または合計20回のブロックで auto mode が一時停止してプロンプトに戻り、承認すると再開（しきい値は設定不可、合計カウンタはその上限発動時にだけリセット）。
- `-p` で `--permission-prompt-tool` が無い場合は、しきい値到達時にそのアクションは実行されず、Claude は作業を続ける。実行は止まらない。
- 分類器が判定できない場合（別の安全チェックがリクエストを拒否、応答が解析不能）は通知なしで拒否。モード切替中の判定は、新モードが要求しない判定なら破棄。
- 誤検知は `/feedback`、管理者は信頼インフラを設定。

**critical paths**

- `rm`/`rmdir` が対象の保護パス: ファイルシステムのルート、ルート直下のディレクトリ、ホーム、Windows のドライブルートとその直下、作業ディレクトリとその親。追加の作業ディレクトリは直下への glob（`rm -rf <dir>/*`）のみ。変数配下の glob（`"$DIR"/*`）、`$(pwd)` 由来の変数、コマンド置換だけの対象なども含む。
- どの allow ルールや `PreToolUse` hook の `"allow"` でも承認されない。deny ルールは常にブロック。既定では分類器は見ない。
- モード別: `default`/`acceptEdits`/`plan` は承認を求める。`auto` は terminal で承認を求める（2分のカウントダウン、時間切れで拒否、未回答3回で以後は即拒否）。terminal 以外（`-p`、Agent SDK、VS Code チャット、Desktop）では即拒否。`dontAsk` は拒否。`bypassPermissions` は承認を求める（terminal で時間制限付き）。v2.1.281 以降。
- 無効化用の環境変数: `CLAUDE_CODE_DISABLE_SUBSTITUTION_RM_PROMPT=1`、`CLAUDE_CODE_DISABLE_INLINE_SHELL_RM_PROMPT=1`、`CLAUDE_CODE_DISABLE_DANGEROUS_RM_TIMEOUT=1`（auto では critical path 削除が分類器に回る）、`CLAUDE_CODE_DISABLE_POWERSHELL_CMD_RM_DENY=1`。
- PowerShell の `Remove-Item` のシステムパスとワイルドカードは全モードで拒否（分類器の前）。`cmd` の `rd`/`del` 等は v2.1.283 以降。

**Team／Enterprise の組織制御**

- `permissions.disableAutoMode: "disable"`（managed settings）で `Shift+Tab` の循環から auto が消え、`--permission-mode auto` でも Manual で始まる。
- 組織の `permissions.defaultMode`（managed settings）で開始モードを指定。`permissions.disableBypassPermissionsMode: "disable"` で bypass を止める。`autoMode.environment` で信頼インフラを追加。

**その他のモード**

- `bypassPermissions`: `--permission-mode bypassPermissions` か `--dangerously-skip-permissions`。root/sudo では起動拒否（サンドボックス内は除く）。cloud sessions は設定ファイルの `bypassPermissions`/`dontAsk` を無視。どのモードでも自動承認されないもの（明示的な ask ルール、`AskUserQuestion`、critical path の削除など）あり。

## 関連ページ

- [[concepts/auto-mode]]
- [[sources/docs/2026-10-10-auto-mode-config]]
- [[sources/docs/2026-10-10-sandboxing]]

## 取り込みメモ

- 記事ページ本体の raw Markdown を curl で取得（89,704 バイト）。`published` はページに日付が無いため unknown。
- このページには auto mode の段階（研究プレビュー、ベータ等）の記載は見つからなかった。FPR 0.4% や FNR の数値の記載も無い。
- 既定ブロック一覧は上に整理して書いた。原文の細かい例外（条件節）は一部省略しているので、全文は `claude auto-mode defaults` と原ページを参照。
- ページ内に取得者への指示文は見つからなかった。
- Team／Enterprise の組織制御として、Enterprise 固有の追加機能の記載は見当たらない（上記 `disableAutoMode` 等のみ）。
