---
type: source
source_id: docs
title: Automate work with routines ／ Use Claude Code in the cloud ／ Configure cloud environments ／ Get started with Claude Code in the cloud（＋ Settings の "Settings in cloud sessions"）
url: https://code.claude.com/docs/en/routines
published: unknown
retrieved: 2026-10-16
version:
tier: primary
review: ok
recheck: weekly
fingerprint: sha256:7e17c96c0b9eff83779590e596a792e2cdb1c6bbea8095aa1989c305cfe29cac
archive_url:
---

# routines と cloud sessions の docs（4ページ＋settings の1節）

取得した Markdown 版（curl）の sha256。fingerprint 欄は routines.md のもの。
- routines.md: `7e17c96c0b9eff83779590e596a792e2cdb1c6bbea8095aa1989c305cfe29cac`
- claude-code-on-the-web.md: `96facadf5c54041b768e5e1c98131f80ae9c851c15253d72639423146dafb704`
- cloud-environments.md: `299e408e9efa92e53fa75c6d36b49132980f228a3f14dd290e18de43a178c61f`
- web-quickstart.md: `11339a9283e576a80ff4241e1229f22fcb7d860dd6fa5901463c94bfecad3886`
- settings.md（該当節のみ参照。ハッシュは取っていない）

## 要点

- **routines は研究プレビュー**（"Behavior, limits, and the API surface may change"）。プロンプト・リポジトリ・コネクタを保存し、スケジュール／API／GitHub イベントのトリガーで cloud session として自動実行する。Pro、Max、Team、Enterprise で利用可。Team／Enterprise の Owner は Routines トグルで組織全体を無効にできる。
- **料金**: routines の実行は「対話セッションと同じようにサブスクリプションの利用枠を消費する」。VM に別料金は無い（cloud sessions 全般が「プランの上限に含まれ、クラウド VM への別料金は無い」）。利用枠を使い切ったとき、usage credits が有効な組織は従量の超過分（metered overage）で実行を続けられ、無効なら枠のリセットまで追加実行は拒否される。API の従量課金ではない（Console の API キーでは `/schedule` 自体が使えない）。
- **上限**: 実行方法ごとに1時間あたりの上限がある（下記の表）。超過分に overage は無い。GitHub イベントにも1時間あたりの上限（routine 単位とアカウント単位）があるが、数値は記載なし。
- **無人実行**: routine は権限モードの選択が無く、シェルコマンド、リポジトリの skills、コネクタの全ツール（書き込み含む）を承認無しで使う（一部の artifact 操作を除く）。push 先は既定で `claude/` 始まりだが、プロンプトで別ブランチを指示すれば変えられる。制御は GitHub の branch protection／ruleset で行う。
- ネットワークは環境（既定は Trusted）に従う。コネクタの通信は Anthropic のサーバー経由なので許可リスト不要。repo の `.claude/agents/`、`.claude/settings.json` の hooks と権限ルールは、リポジトリ1つのセッションで読み込まれる。

## 具体的な値

### routines（https://code.claude.com/docs/en/routines）

- 作成: claude.ai/code/routines、Desktop の Code タブ（Cloud を選ぶ。Local を選ぶと Desktop scheduled task になる）、CLI の `/schedule`（別名 `/routines`）。3か所とも同じクラウドアカウントに書く。`/schedule list`、`/schedule update`、`/schedule run`。
- 所有: routine は個人の claude.ai アカウントに属し、チームメイトとは共有されない。実行はそのアカウントの利用枠に数えられ、コミットや PR は本人の GitHub ユーザー、コネクタの操作は本人の連携アカウントで行われる。
- トリガー:
  - Schedule: hourly／daily／weekdays／weekly のプリセット、または1回きり（実行後に自動で無効化され "Ran" と表示）。時刻はローカル時刻で入力し自動変換される。ちょうど毎時0分は数分遅れることがあるので 9:07 のようにずらす。カスタム cron は `/schedule update` で設定。**最短は1時間間隔**で、それより短い式は拒否される。
  - API: routine ごとの `/fire` エンドポイントに bearer token 付きで POST。トークンは routine ごとで、表示は1回だけ。CLI ではトークンの作成・再生成・削除ができない（Web のみ）。`/fire` は claude.ai ユーザー専用で Claude Platform API の一部ではない。
  - GitHub: Pull request（opened、closed、assigned、labeled、synchronized など）と Release（created、published、edited、deleted）。PR のフィルターは Author／Title／Body／Base branch／Head branch／Labels／Is draft／Is merged。演算子は equals／contains／starts with／is one of／is not one of／matches regex（値全体に一致）。Claude GitHub App がリポジトリに必要。`/web-setup` ではこの App は入らず webhook も有効にならない。CLI からの GitHub トリガー追加は v2.1.225 以降。
  - 1つの routine に複数のトリガーを組み合わせられる。セッションはイベントをまたいで再利用されない。
- API 呼び出し例の要点: `POST https://api.anthropic.com/v1/claude_code/routines/<trigger-id>/fire`。ヘッダーは `Authorization: Bearer ...`、`anthropic-beta: experimental-cc-routine-2026-04-01`、`anthropic-version: 2023-06-01`、`Content-Type: application/json`。本文は任意の `text`（自由形式の文字列）。応答は `type: routine_fire`、`claude_code_session_id`、`claude_code_session_url`。beta ヘッダーの形は変わりうる。破壊的変更は新しい日付のヘッダーで出し、直近2つの旧ヘッダーは動き続ける。
- `text` は `<routine-fire-payload>` ブロックで包まれ、信頼できないデータとして扱われる。routine の保存済みプロンプトがそのペイロードを明示的に参照しないと、実行の指示としては使われない。Run now で渡す `text` も同じ。
- 保存済みプロンプトは、トリガー発火時に「割り当てられたタスク」として実行される（v2.1.213 より前は、信頼できないバックグラウンド通知として渡されていた）。ただし、これは実行中の操作への承認や同意にはならない。
- モデル選択: プロンプト入力にモデルセレクターがあり、毎回選んだモデルを使う。
- 実行時の挙動: 各 repository は毎回 clone され、既定ブランチから始まる。PR イベントで起動し、PR のリポジトリが先頭のリポジトリなら、PR の head コミットから始まる。
- **push 先**: "Claude pushes its work to a branch prefixed with `claude/` unless your prompt directs it to push to another branch." つまりプロンプトの指示で `claude/` 以外にできる。設定項目としての「push 先の制限」は無く、制御は GitHub 側の branch protection／ruleset（接続した GitHub アクセスに適用。そのアクセスがバイパスできる規則は止めない）。
- GitHub 接続が切れた・期限切れのとき、routine は最大72時間は実行をスキップし、再接続すれば自動で再開する。72時間を超えると routine がオフになり、再接続後に手動でオンに戻す。
- 承認: "no permission-mode picker"。シェルコマンド、skills、コネクタを「承認のために止まること無く」実行する（artifact の一部操作を除く）。コネクタは既定で接続済みのすべてが含まれ、書き込みを含む全ツールを承認無しで使える。不要なものは外す。
- artifact: スケジュールと Run now の実行では、新しい artifact を承認無しで公開できる（自分だけが見える）。ページが実行時の機能（コネクタ呼び出し、ファイルダウンロード）を宣言する公開は事前に確認する。既存 artifact の再公開は一定の条件（自分で編集でき自組織のもの、公開共有でない、など）を満たすときだけ承認無し。API／GitHub トリガーで始まった実行では常に確認する。
- 環境とネットワーク: 既定の Default 環境は Trusted（許可リストのレジストリ等のみ）。許可外ホストへの通信は `403` と `x-deny-reason: host_not_allowed`。Custom（ドメインを列挙。既定リストを併用するチェックあり）か Full（無制限）に変更できる。変更は次の実行から有効。組織共有の環境は Owner が管理画面で変更する。
- 実行ステータス: 一覧の緑は「セッションが起動し、インフラのエラー無く終了した」ことだけを示し、タスクの成功は意味しない。
- 利用枠と上限（原文の "Usage and limits"）:

| 操作 | 上限 | 数える単位 | 超過時 |
| :- | :- | :- | :- |
| スケジュール実行（1回きりを含む） | 100回／時 | アカウント | 上限のリセットまで実行が待つ |
| Run now、API fire、1回きり routine の再設定 | 30回／時 | routine ごと（3つで1つの数） | リセットまで失敗する |
| Run now、1回きり routine の再設定 | 100回／時 | アカウント | 同上 |
| API fire | 100回／時 | アカウント（Run now とは別に数える） | 同上 |
| GitHub イベント | 数値は記載なし | routine ごと・アカウントごとの1時間上限 | 上限を超えたイベントはリセットまで破棄 |

  - "None of these hourly limits has overage."
  - 購読が一時停止中は routine も保留され、再開後に手動でオンに戻す。
- `/schedule` が使えない条件: Console API キー、Anthropic profile／federation credential、Bedrock／Vertex（Agent Platform）／Foundry の認証、サインインしていない状態、cloud session の内側、組織が cloud sessions を無効にしている、Owner が routines を無効にしている。`/schedule` には claude.ai のサブスクリプションログインが必要。
- 組織の IP allowlist が有効だと、Anthropic ホスト版の routine は認証エラーで失敗する（self-hosted に routed すれば自社ネットワークから API を呼ぶ）。
- CLI の `/schedule` で run 履歴を尋ねられるのは v2.1.227 以降。

### cloud sessions（https://code.claude.com/docs/en/claude-code-on-the-web）

- 提供: Pro、Max、Team、および Enterprise のうち premium seat か Chat + Claude Code seat のユーザー。
- 料金: "It counts toward your plan's usage limits ... and there's no separate charge for the cloud VM."（原文の趣旨）。レート制限は、アカウント内のほかの Claude／Claude Code の利用と共有。並列に走らせるタスクの数に比例して消費が増える。
- 起動元: ブラウザ（claude.ai/code）、モバイルアプリの Code タブ、Desktop（Cloud を選択）、`claude --cloud`、routines。デフォルトは Anthropic 管理のインフラで、組織が routed した場合は self-hosted environment。
- `claude --cloud` は一度に1リポジトリ。旧 `--remote` は非推奨の別名。クラウド VM は手元のチェックアウトではなく GitHub リモートの現在のブランチを clone するため、先に push する。非 GitHub のリポジトリは `CCR_FORCE_BUNDLE=1` でローカルバンドルとして送れるが、結果をそのリモートへ push はできない。
- 並列: `--cloud` を実行するごとに独立したセッションが作られ、同時に走る。**同時実行数の上限の記載なし**（レート制限を共有するとのみ記載）。
- ZDR または HIPAA 構成の組織は cloud session 機能を使えない。CMEK を使う組織もセッションを開始できない。
- 権限モード: 作成時と実行中にモードのドロップダウンで選ぶ（web-quickstart の表では Accept edits、Plan、Auto）。
- サブエージェント: "work the same way they do locally"。Agent tool で起動でき、repo の `.claude/agents/` のものは自動で読み込まれる。VM が回収されたとき、実行中だったバックグラウンド作業（サブエージェント、シェルコマンド）は復元されない。**routine の中のサブエージェントについて個別の記述は無い**（routine は「完全な cloud session」として動くと書かれているので、同じ扱いになると思われる（推測））。
- auto-fix PR: PR の CI 失敗とレビューコメントに反応して修正を push する。ベースブランチの競合は webhook が出ないため自動では対応できない。
- 分離: 隔離された Anthropic 管理の VM、既定で制限されたネットワーク（無効にもできる）、git 認証情報と署名鍵はサンドボックス外（プロキシが代行）、環境の network secrets もサンドボックス外。ネットワークを None にしても Anthropic API とは通信できるため、データが VM の外に出る可能性がある旨の記載がある。
- 制限（Limitations）: レート制限の共有、コマンドと SessionStart hook のタイムアウト、セットアップスクリプトのキャッシュ（約5分以内に終わる場合のみ）、リポジトリ認証、GitHub 必須（GitHub Enterprise Server は Team／Enterprise で対応）、IP allowlist との非互換。

### cloud environments（https://code.claude.com/docs/en/cloud-environments）

- VM: Ubuntu 24.04、x86_64、4 vCPU、16 GB RAM、30 GB ディスク。大きなビルドは VM に止められることがある。
- 時間: 前景コマンドは既定2分、最大10分。タイムアウトしたコマンドはバックグラウンドに移り、さらに最大30分動いてから止められる（`sleep` で始まるコマンドは除く）。`BASH_DEFAULT_TIMEOUT_MS`、`BASH_MAX_TIMEOUT_MS`（ミリ秒）で変更でき、`BASH_DEFAULT_TIMEOUT_MS` を `1800000` より大きくするとバックグラウンドの上限も伸びる。SessionStart hook（`command`）は 600 秒でキャンセル（`timeout` で変更、`async: true` は対象外）。セットアップスクリプトは約5分を超えるとキャッシュされない。アイドルから数分で VM が一時停止し、その後回収されうる。
- **1回のセッション全体の実行時間の上限は docs に記載なし**。
- ネットワークの段階: None／Trusted（既定）／Full／Custom。どの段階でも次は到達できる: GitHub（別プロキシ）、有効にしたコネクタ（Anthropic のサーバー経由）、network secrets のホスト、Anthropic API。Trusted の許可リスト（Default allowed domains）は npm、PyPI、RubyGems、crates.io、Docker Hub などのレジストリ、GitHub、クラウド SDK など多数のドメイン（一覧は原文の「Default allowed domains」節）。
- 読み込まれるもの: repo の `CLAUDE.md`、`.claude/settings.json` の hooks と権限ルール（リポジトリ1つのセッション）、`.mcp.json`（同）、`.claude/rules/`、`.claude/skills/`・`.claude/agents/`・`.claude/commands/`。読み込まれないもの: ユーザーの `~/.claude/` 以下（CLAUDE.md、skills、agents、commands、settings.json、hooks）、repo の `enabledPlugins`／`extraKnownMarketplaces` が指すプラグイン、`.claude/settings.local.json`、`env` ブロックの通信系キー（`NODE_EXTRA_CA_CERTS` や mTLS の変数）。組織の server-managed settings は届く（Claude Tag のセッションには届かない）。
- 複数リポジトリのセッション（Anthropic ホスト版）: `.claude/settings.json` からは `enabledPlugins` と `extraKnownMarketplaces` しか読まれず、権限ルール・hooks・`env` などは読まれない。SessionStart hook も動かない。
- 環境変数: その環境を使う誰からも見える。API キーは network secrets に入れる（サンドボックス外に置かれ、一致するリクエストにだけ付く）。`OTEL_*` はコマンドには渡されない。
- hooks: Anthropic ホスト版は repo の hooks と organization の server-managed settings の hooks が走る。`CLAUDE_CODE_REMOTE=true` でクラウドだけの分岐ができる。

### settings（"Settings in cloud sessions"）

- `.claude/settings.json` は単一リポジトリのセッションで読まれる。ユーザー設定と `.claude/settings.local.json` は読まれない。手元の `managed-settings.json` や MDM は届かない（server-managed settings は届く）。

### get started（https://code.claude.com/docs/en/web-quickstart）

- 流れ: clone、setup script、ネットワーク設定、作業、ブランチの push。push 後もセッションは閉じず、同じ会話で PR 作成や追加の編集ができる。
- Team／Enterprise で GitHub にサインインするには、Owner が Organization settings > Connectors で GitHub コネクタを有効にする必要がある。

## 関連ページ

- [[concepts/routines]]
- [[concepts/cloud-sessions]]
- [[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]

## 取り込みメモ

- 公開日は docs ページに示されていないため `published: unknown`。docs は「現状」として扱う。`llms.txt` に routines、claude-code-on-the-web、cloud-environments、web-quickstart、self-hosted-environments の各 URL が実在することを確認してから取得した。
- routines が研究プレビューのため `recheck: weekly`。
- ask ルールの無人実行: docs は routine が「承認のために止まらない」とだけ書き、`settings.json` の `ask` ルールが無人実行でどう扱われるか（拒否されるのか、自動承認されるのか）は **docs に記載なし**。repo の権限ルールが読み込まれる点（単一リポジトリ）は上記のとおり。組み合わせた挙動は未確認。
- routine 内のサブエージェント、routine の同時実行数、1回の実行時間の上限、GitHub イベントの1時間上限の数値、有料プランの具体的な追加料金は **docs に記載なし**。
- 取得した4ページと settings の節には、Claude への指示文は見つからなかった。ページ冒頭の "Documentation Index" 案内（llms.txt の取得を促す文）は、ページの定型文として扱い、従っていない。
- self-hosted-environments の docs は今回の対象外（routines／cloud sessions のページが言及するところだけ参照）。
- 長いページは全体を通読したが、Default allowed domains の長いリストと GitHub 認証の手順、teleport、共有・アーカイブの節は詳細を転記していない。
