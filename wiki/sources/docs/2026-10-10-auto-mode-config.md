---
type: source
source_id: docs
title: Configure auto mode
url: https://code.claude.com/docs/en/auto-mode-config.md
published: unknown
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: none
fingerprint: a8feb7dac2f2070bdb140462603d1c6ef3bc86560eff5ea4e8443792382aa3a7
archive_url:
---

# Configure auto mode

## 要点

- auto mode の設定リファレンス。分類器に、組織が信頼するリポジトリ・バケット・ドメインを伝える `autoMode` 設定ブロックと、`claude auto-mode` サブコマンドを扱う。on/off の切り替えは Permission modes のページ側にある。
- 既定で分類器が信頼するのは作業ディレクトリと現在のリポジトリの設定済み remote だけ。それ以外（社内の GitHub org、チームのバケット等）は `autoMode.environment` に書くまでブロックされる。
- `deny` と明示的な `ask` ルールは分類器より先に評価される。`permissions.ask` は auto mode でも必ず確認を出す。
- `autoMode` を読むのはユーザー設定、managed settings、`--settings`/Agent SDK のみ。プロジェクトの `.claude/settings.json` と `.claude/settings.local.json` は読まない（リポジトリ側からの許可ルール注入を防ぐため）。
- ルール上書きは `hard_deny` / `soft_deny` / `allow` の3つ。`"$defaults"` を入れないと、そのセクションの既定が丸ごと置き換わる。
- 提供範囲: 全ユーザー、全プロバイダ。このページには研究プレビュー等の段階の記載は無い。

## 具体的な値

**設定キー（`autoMode`）**
- `autoMode.environment`: 信頼するインフラの散文記述。大半の組織はこれだけで足りる。
- `autoMode.allow`: soft block ルールの例外。
- `autoMode.soft_deny`: ユーザーの意図で解除できる破壊的操作のルール。
- `autoMode.hard_deny`: 無条件の境界。
- `autoMode.classifyAllShell: true`: auto mode の間、Bash/PowerShell のすべての allow ルールを停止し、全シェルコマンドを分類器に通す（critical-path removals を除く）。遅延と分類器呼び出し数が増える。
- 各配列に文字列 `"$defaults"` を入れると既定が差し込まれ、リリースでの既定の更新も引き継ぐ。
- 関連: `permissions.ask`（例 `Bash(git push *)`、`Bash(gh pr create *)`）、`permissions.deny`、`skillOverrides: {"auto-mode-setup": "off"}`、`disableBundledSkills`（`/auto-mode-setup` は効かない）。

**優先順位（分類器内の4段）**
1. `hard_deny`: 無条件。ユーザーの意図も `allow` も効かない。
2. `soft_deny`: 次にブロック。ユーザーの意図と `allow` で上書き可。
3. `allow`: 該当する `soft_deny` の例外。
4. ユーザーが実行直前の操作を直接かつ具体的に述べた場合は、残りの soft block を上書き（「clean up the repo」は force push の許可にならない）。

**スコープ**
- `~/.claude/settings.json`（個人）、managed settings（組織全体）、`--settings` フラグまたは Agent SDK（呼び出しごと）。各スコープの項目は合算され、開発者は managed の項目を消せない。ただし開発者の `allow` が組織の `soft_deny` を上書きしうるので、厳格な境界にはならない。
- 絶対に実行させない操作は managed settings の `permissions.deny`（分類器より前に効く）。
- 分類器は Claude 自身が読む CLAUDE.md も読む。

**CLI サブコマンド**
- `claude auto-mode defaults`: 組み込みの `environment`/`allow`/`soft_deny`/`hard_deny` を JSON で出力。`--label '<ラベルの先頭>'`（大文字小文字無視の前方一致、例 `'Git Destructive'`）で1件の全文を表示（v2.1.208 以降）。
- `claude auto-mode config`: 実際に分類器が使う実効設定を JSON で出力。
- `claude auto-mode critique`: 自作ルールを AI がレビューし、曖昧、重複、誤検知の原因になりそうなものを指摘。
- `claude auto-mode reset`: ユーザー設定の `autoMode` を削除（v2.1.212 以降）。確認 `Reset auto mode configuration to defaults?`、`--yes` で省略。managed settings と `--settings` の分は残る。

**環境の文脈の指定（`environment` の3種のスロット）**
- Context slots: Organization、Primary use of Claude Code（既定は software development）、Cloud provider(s)、Repository visibility（既定は private とみなす）、Internal sharing / snippet hosting（公開の paste/gist は信頼境界の外）、Org-specific CLIs、Secrets management、CI/CD deploy targets、Network posture、Host containment（v2.1.257 以降。名前を挙げるまで、ホスト自身の認証情報の要求はブロック）、Protected deployment namespaces / environments、Data retention / declassification。
- Trust slots: Trusted repo、Source control（この2つの既定は作業リポジトリとその remote）、Trusted internal domains、Trusted cloud buckets、Key internal services、Internal package registry（他は `None configured`）。
- Sensitivity slots: Sensitive data locations & audiences、Sensitive remote targets（既定は名前に `prod`/`production` を含むホストや namespace）、Protected IaC scopes。
- 記述例: `"Source control: github.example.com/acme-corp and all repos under it"`、`"Trusted cloud buckets: s3://acme-build-artifacts, gs://acme-ml-datasets"`。

**既定の block / allow ルール（このページで分かる範囲）**
- 全文は載っておらず、`claude auto-mode defaults` で確認する前提。ページ内に出てくるラベルは soft_deny の `Git Destructive`、allow の `Test Artifacts`、拒否理由表示の `[Data Exfiltration]`、`[Production Deploy]`。
- `Git Destructive`: force push、リモートのブランチ・タグ・リリースの削除、履歴の書き換え。自分の未 push でない commit の `git commit --amend` も対象。ユーザーが amend/reword/fixup を求めた場合などは解除。
- `$defaults` を外すと失われる例: soft_deny の force push、`curl | bash`、本番デプロイ、auto-mode bypass の各ルール。hard_deny の組み込みデータ流出ルール。
- 既定の挙動: 作業中のリポジトリの任意のブランチ（既定ブランチ含む）への push と PR 作成は許可。`production`/`release`/`gh-pages` のようなデプロイ先を示す非既定ブランチへの push は分類器が本番デプロイとして個別判断。force push、コミットへの秘密情報の混入、CI/デプロイ経由で秘密を外へ出す変更はブロックのまま。

**対応プラン・バージョン・提供範囲**
- auto mode: 全ユーザー、Anthropic API、Claude Platform on AWS、Amazon Bedrock、Google Cloud の Agent Platform、Microsoft Foundry、サインイン済み Claude apps gateway セッション。対応モデルと Team/Enterprise の組織レベル制御は Permission modes ページの要件を参照（このページには書かれていない）。
- `/auto-mode-setup`: Pro、Max、Team プランが必要。v2.1.228 以降（ネイティブ Windows は v2.1.233 以降）。cloud session では不可。feature-flag fetching が必要。
- `/permissions` の **Auto mode** タブ: v2.1.246 以降。managed settings と `--settings` の項目は読み取り専用で、変更は `~/.claude/settings.json` に保存。**Recently denied** タブで `r` を押すと再試行を指示できる。

**`/auto-mode-setup`**
- 読むもの: プロジェクトの `CLAUDE.md`/`README.md`/設定ファイル/git remote、`autoMode` と `permissions.allow`、直近セッションで Claude が実行したコマンドのホスト・バケット・コマンド名（ユーザーのメッセージは読まない）。任意の2スキャン: シェル履歴の各コマンドの先頭語、ホームディレクトリ配下のリポジトリの remote ホストと名前。
- ドラフトは丸ごと承認か破棄。書き込み先は `~/.claude/settings.json`。`environment` は `"$defaults"` なしで書き、`allow`/`soft_deny`/`hard_deny` には `"$defaults"` を入れる。
- auto mode が複数回ブロックしても `environment` が空だと「Teach auto mode about your environment?」ダイアログが出る。

**拒否のデバッグ**
- 拒否表示の例: `bash denied by auto mode · [Data Exfiltration] · /permissions`、`Denied by auto mode classifier`。角括弧内が一致したルール名。
- `PermissionDenied` hook の `tool_input` で正確な入力を取得できる。`Ctrl+O` でトランスクリプトビューア。
- 分類器が判定を出せない場合（モデルが一時的に使えない、応答が解析できない等）は、Recently denied に記録せず拒否する。

## 関連ページ

- [[concepts/auto-mode]]
- [[concepts/managed-agents]]
- [[concepts/sandboxing]]（per-command allowed domains in auto mode への言及）

## 取り込みメモ

- `published: unknown`（docs ページに公開日が無い）。ファイル名の日付は取得日。
- 分類器のモデル名、FPR/FNR、プランごとの利用可否（auto mode 本体）は、このページには書かれていない。Permission modes ページ（`#eliminate-prompts-with-auto-mode`）に要件があるが未取り込み。
- Managed Agents の権限ポリシー `auto` への言及は無い。
- ページ内に AI への指示文は見当たらなかった（冒頭の Documentation Index の案内のみ）。
