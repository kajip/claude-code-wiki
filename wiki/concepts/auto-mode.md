---
type: concept
title: auto mode（権限の自動判定）
updated: 2026-10-10
sources:
  - sources/engineering/2026-03-25-claude-code-auto-mode
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/docs/2026-10-10-auto-mode-config
  - sources/docs/2026-10-10-permission-modes
  - sources/docs/2026-10-10-sandboxing
---

# auto mode

## 概要

Claude Code の承認を、人ではなくモデルベースの分類器に任せるモード。手動承認と `--dangerously-skip-permissions` の中間にあたる（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）。設計の一次情報は2026-03-25の Engineering 記事で、設定の仕様は docs の設定ページ（[[sources/docs/2026-10-10-auto-mode-config]]）。auto mode の要件・分類器・既定ブロックは docs の Permission modes ページ（[[sources/docs/2026-10-10-permission-modes]]）。

## 現状（as of 2026-10-10）

設計の記述は2026-03-25の記事に基づく。数値とモデルは「公開時点の値」。仕様・提供範囲・モデルは docs（[[sources/docs/2026-10-10-permission-modes]]、[[sources/docs/2026-10-10-auto-mode-config]]）を正とする。

**docs の Permission modes ページ（取得日 2026-10-10）**

- 開始モード: Claude Code v2.1.283 以降、auto mode は対話的な terminal と VS Code セッションの組み込みの開始モード（全プラン・全プロバイダ）。それ以前は Pro、Max、Team のみ。HIPAA 構成の組織では `default` 開始（v2.1.285 以降）。cloud sessions は組織が許可しモデルが対応する場合のみ Auto を提供（[[sources/docs/2026-10-10-permission-modes]]）。
- 要件: プランは全プラン。Team／Enterprise は既定で利用可で、管理者は managed settings の `permissions.disableAutoMode: "disable"` で無効化できる。プロバイダは Anthropic API、Claude Platform on AWS、Bedrock、Google Cloud の Agent Platform、Foundry、サインイン済み Claude apps gateway。段階（プレビュー等）の記載は無い（同）。
- 対応モデル: Anthropic API と Claude Platform on AWS は Opus 4.6 以降、Sonnet 4.6 以降、Haiku 5.5、Fable。Bedrock、Agent Platform、Foundry、Claude apps gateway は Sonnet 5 以降、Opus 4.7 以降、Haiku 5.5、Fable のみ（Haiku 5.5 は v2.1.293 以降）。Sonnet 4.5、Opus 4.5、Haiku 4.5、claude-3 系は非対応（同）。
- 分類器のモデル: 既定で Sonnet 5（`/model` の選択ではない）。サーバー側で設定されたモデルがあればそちらが優先。セッションが Sonnet 4.6 か `availableModels` が Sonnet 5 を除外している場合はセッションのモデル、Fable セッションでは Opus。第三者プロバイダでの Opus の代替は `ANTHROPIC_DEFAULT_OPUS_MODEL`、未設定なら Opus 5（同）。FPR などの性能数値の記載は無い。
- 分類器が見るもの: ユーザーのメッセージ、読み取り専用以外のツール呼び出し、CLAUDE.md。ツール結果は除かれる。別にサーバー側 probe が入力のツール結果を走査。PostToolUse hook の `classifierContext` で注釈できる（v2.1.236 以降）。サーバー側審査（Anthropic API 直結は v2.1.271〜281 以降、段階的展開）があり、無判定は拒否（同）。→ [[concepts/hooks]]
- 既定でブロック: `curl | bash`、機微データの外部送信、本番デプロイ、IAM 付与、force push、`git reset --hard` 等、`terraform destroy` 等、人間未承認 PR のマージ、CI 無効化、トンネル、IMDS からの認証情報取得（v2.1.257 以降）など約40項目。バージョン別の追加あり（v2.1.203、205、257、261）。全文は同ページの `#what-the-classifier-blocks-by-default` と `claude auto-mode defaults`。既定で許可: 作業ディレクトリ内の操作、lock ファイルの依存 install、作業中リポジトリの任意ブランチへの push 等（同）。
- critical paths: `rm`/`rmdir` の対象（ルート、ホーム、作業ディレクトリとその親など）は、allow ルールや hook の allow で承認されず、既定では分類器も通らない。auto では terminal で承認を求め（2分のカウントダウン、時間切れで拒否）、terminal 以外では即拒否（v2.1.281 以降）（同）。
- 拒否時: 通知と `/permissions` の Recently denied。3回連続か合計20回で一時停止してプロンプトに戻る（設定不可）。`-p` でプロンプト手段が無い場合はそのアクションを実行せず、Claude は作業を続け、実行は止まらない（同）。
- 会話での境界（「push するな」）は分類器が履歴から読み直す。圧縮で失われうるので、確実にするなら deny ルール。承認は行為と危険の具体点を名指しした1回分のみ有効（同）。
- auto mode に入ると `Bash(*)`、`Bash(python*)`、パッケージマネージャ実行、`Agent`、`Monitor` の広い allow ルールは外され、抜けると復元（同）。

**サンドボックスとの関係（docs）**

- auto mode でサンドボックスが有効なとき、コマンドは必要なホストを列挙し、分類器がコマンドと一緒に審査する（v2.1.271 以降）。承認された一覧はそのコマンドの間だけ有効で、設定には残らない。`strictAllowlist` や `allowManagedDomainsOnly` が有効なら拒否（[[sources/docs/2026-10-10-sandboxing]]）。
- `dangerouslyDisableSandbox` によるサンドボックス外での再実行は、auto mode では別の分類器が評価する（同）。
- サンドボックスの auto-allow と auto mode は別の仕組みで、組み合わせられる。auto-allow でも明示的な deny、critical path の `rm`/`rmdir`、内容指定の ask ルールは有効（同、[[sources/docs/2026-10-10-permission-modes]]）。→ [[concepts/sandboxing]]

**docs の設定仕様（取得日 2026-10-10）**

- 提供範囲: 全ユーザー、全プロバイダ（Anthropic API、Claude Platform on AWS、Amazon Bedrock、Google Cloud の Agent Platform、Microsoft Foundry、サインイン済み Claude apps gateway）。利用不可のときは Permission modes ページの要件を確認、と案内（[[sources/docs/2026-10-10-auto-mode-config]]）。このページに研究プレビュー等の段階の記載は無い。
- 既定の信頼範囲は作業ディレクトリと現在のリポジトリの設定済み remote のみ。作業リポジトリの任意のブランチ（既定ブランチ含む）への push と PR 作成は既定で許可。`production`/`release`/`gh-pages` など配布先を示す非既定ブランチへの push は分類器が本番デプロイとして個別判断。force push や秘密情報の混入はブロックのまま（同）。
- 設定キー: `autoMode.environment` / `allow` / `soft_deny` / `hard_deny` / `classifyAllShell`。`"$defaults"` を含めないとそのセクションの既定が置き換わる（同）。
- 優先順位は hard_deny → soft_deny → allow（soft_deny の例外）→ 直接かつ具体的なユーザーの意図、の4段。`permissions.deny` と明示的な `permissions.ask` は分類器より前に評価される（同）。
- `autoMode` はユーザー設定、managed settings、`--settings`/Agent SDK から読む。プロジェクトの `.claude/settings*.json` からは読まない（同）。
- CLI: `claude auto-mode defaults`（`--label` は v2.1.208 以降）、`config`、`critique`、`reset`（v2.1.212 以降、`--yes`）（同）。
- 既定ルールの全文はページに無く `claude auto-mode defaults` で確認する前提。ページ内で名前が出るのは soft_deny の `Git Destructive`、allow の `Test Artifacts`、拒否理由の `[Data Exfiltration]`、`[Production Deploy]`。`$defaults` なしで失う例は force push、`curl | bash`、本番デプロイ、auto-mode bypass（soft_deny）と組み込みのデータ流出ルール（hard_deny）（同）。
- 環境の文脈は context / trust / sensitivity の3種のスロット（Organization、Source control、Trusted cloud buckets、Host containment 等）。`/auto-mode-setup` が下書きを生成（Pro、Max、Team、v2.1.228 以降、cloud session では不可）。`/permissions` の Auto mode タブは v2.1.246 以降（同）。

**engineering 記事に基づく設計**

- 2層: 入力側の prompt-injection probe と、出力側の transcript classifier（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）。
- 分類器は2段（単一トークンのフィルタ→必要時のみ推論）。ユーザーのメッセージとツール呼び出しだけを見る。公開時点（2026-03）では Sonnet 4.6 で動いていた。現行は上記の docs を参照（同）。
- 判定は3層。安全ツールの許可リストとユーザー設定、プロジェクト内のファイル操作、分類器の順。入るとき、任意コード実行を許す広い許可ルールは外される（同）。
- 設定は3つの枠（environment、block rules、allow exceptions）。`claude auto-mode defaults` で既定を確認できる（同）。
- 公開時点の性能: 実トラフィックの FPR 0.4%、実 overeager の FNR 17%、合成 exfil の FNR 5.7%。著者は、慎重に手動承認している人にとっては退行になりうるとしている（同）。
- 公開時点の記述: 拒否後は別の手を探させ、連続3回または合計20回でエスカレーション。headless（`claude -p`）では終了する（同）。3回／20回は docs と一致するが、headless の挙動は docs と異なる（未解決欄参照）。
- サブエージェントの委任時と返却時にも分類器が働く（同）。→ [[concepts/subagents]]
- cloud sessions の承認モードは Auto、Accept edits、Plan だけ（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。→ [[concepts/cloud-sessions]]
- Managed Agents の権限ポリシー `auto` も、サーバーが各呼び出しを判定する。Claude Code の auto mode との実装上の関係は出典に記述が無い（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。→ [[concepts/managed-agents]]
- 位置づけ（2026-05-25の記事）: 確率的な防御で取りこぼしがあるため、サンドボックス内の多層防御の一層であり代替ではない。当時の説明では overeager の約 83% を実行前に捕捉（FPR 0.4%、FNR 約 17% は3月の値と整合）。環境側の防御が使えない場面でモデル層が補う役割（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。→ [[concepts/sandboxing]]

## 変更履歴

- 2026-10-10 — docs の Permission modes と sandboxing を取り込み。分類器の既定モデルが Sonnet 5（公開時点は Sonnet 4.6）、対応プラン・モデル、既定ブロックの一覧、critical paths、サンドボックスとの連携を docs の記載で更新。headless の挙動は docs では「実行は止まらない」（[[sources/docs/2026-10-10-permission-modes]]、[[sources/docs/2026-10-10-sandboxing]]）
- 2026-10-10 — docs の設定ページを取り込み。提供範囲、設定キー、CLI、優先順位、既定の挙動を docs の記載で更新（[[sources/docs/2026-10-10-auto-mode-config]]）
- 2026-10-07 — 2.1.292: auto mode が、ネットワーク（UNC）パスからのファイル読み込みで許可の確認を飛ばしていた問題を修正（Security）。同期間のバッチで、2.1.281 で入れた auto mode の拒否メッセージの変更を取り消し（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-09-10 — Managed Agents に権限ポリシー `auto` を追加（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-05-25 — 封じ込めの記事で、承認プロンプトの約 93% が承認されている（承認疲れ）ことを auto mode の動機として説明。自動化は取りこぼしがあるためサンドボックスと併用する位置づけ（[[sources/engineering/2026-05-25-how-we-contain-claude]]）
- 2026-03-25 — 設計と評価を Engineering 記事で公開。分類器は Sonnet 4.6、FPR 0.4%、overeager の FNR 17%（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）

## 未解決・矛盾

- 解決済み: 「既定の block rules の全容」。2026-10-10 に docs の Permission modes ページで、既定ブロックと既定許可の一覧が確認できた。全文のルール本体は `claude auto-mode defaults` の JSON で、そのまま wiki には写していない（[[sources/docs/2026-10-10-permission-modes]]、[[sources/docs/2026-10-10-auto-mode-config]]）。
- 解決済み: 「分類器のモデル」。docs では既定で Sonnet 5（セッションが Sonnet 4.6 などの場合の代替あり）。公開時点（2026-03）の Sonnet 4.6 は過去の値（[[sources/engineering/2026-03-25-claude-code-auto-mode]]、[[sources/docs/2026-10-10-permission-modes]]）。
- 解決済み: 「対応プランと対応モデル」。全プラン、モデルはプロバイダ別（現状の節を参照）（[[sources/docs/2026-10-10-permission-modes]]）。
- 解決済み: headless（`claude -p`）での連続拒否時の挙動。engineering 記事（公開時点）は「終了する」、docs は「そのアクションは実行されず、Claude は作業を続け、実行は止まらない」。docs を正とする（[[sources/engineering/2026-03-25-claude-code-auto-mode]]、[[sources/docs/2026-10-10-permission-modes]]）。
- 未解決: 性能数値（FPR 0.4%、overeager の FNR 17%、合成 exfil の FNR 5.7%）が、分類器が Sonnet 5 になった現行でも当てはまるか。docs に性能数値の記載は無い。公開時点の値として残す（同）。
- 未解決: auto mode の段階（プレビュー等）。docs の2ページに記載が無く、一般提供かどうかは明記されていない。「全ユーザー・全プラン」「組み込みの開始モード」とのみ書かれている（同、[[sources/docs/2026-10-10-auto-mode-config]]）。
