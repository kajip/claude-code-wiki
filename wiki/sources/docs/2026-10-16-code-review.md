---
type: source
source_id: docs
title: Code Review（概要）／ Set up Code Review ／ Customize Code Review ／ Read and request reviews on a pull request ／ Code Review costs and usage ／ Troubleshoot Code Review
url: https://code.claude.com/docs/en/code-review
published: unknown
retrieved: 2026-10-16
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:e27d0098417de60dc9792fdc86087415970e88a8fdfca60c6b9b3207d39bc5d6
archive_url:
---

# Code Review（docs 概要と下位5ページ）

## 要点

- GitHub の PR を Claude がレビューする管理サービス。複数のエージェントが差分と周辺コードを並列に調べ、検証ステップで誤検出を除き、重複排除・重大度順位付けをして、インラインコメント、要約、チェックランを PR に投稿する。PR を承認もブロックもしない。チェックランは失敗として終了しない（neutral、または push で変更ファイルが無いときは skipped）。
- 有効化は Owner が claude.ai の Admin settings > Claude Code > Code review で行う。実行は Anthropic のインフラ上で、リポジトリにワークフローファイルは不要。GitHub App の導入と連携、リポジトリ選択、テスト PR での確認まで6手順（下記）。
- 調整は `REVIEW.md`（レビュー専用）と `CLAUDE.md`（プロジェクト全般）。サービスは両方を読むが、手元の `/code-review` は `CLAUDE.md` だけを読む。`REVIEW.md` は PR 自身の変更からは読まれず、保護された既定ブランチ（または保護された base ブランチ）から読む。
- レビューレベルは Quick / Standard（既定）/ Deep。組織の既定を Owner が選び、リポジトリごとに上書きできる。実行タイミング（Review runs）もリポジトリごとに、PR 作成時1回 / push のたび / 手動のいずれか。
- 費用は1レビューあたりの定額ではない。トークン使用量に応じて usage credits から課金され、組織の請求になる。月次の支出上限を管理画面で設定でき、上限・クレジット残高が尽きるとレビューはスキップされ、PR に警告コメントが付く。docs に1レビューあたりの金額の数値は載っていない。

## 具体的な値

### 概要ページ（code-review）
- 提供: Team and Enterprise。GitHub（GitHub Enterprise Server、データレジデンシー付き GitHub Enterprise Cloud を含む）。
- 非対応: Zero Data Retention 有効、HIPAA 構成の組織、BAA 対象外、CMEK 利用組織（"isn't yet available"）。
- チェックラン名: **Claude Code Review**。指摘なしのときのタイトルは **Code review found no issues**。
- 実行はリポジトリへ読み取り専用でアクセスし、コードのビルドや実行はしない。モデルは Code Review 側が選び、管理設定に選択肢は無い。
- 他の手段: `/code-review`（任意のプランで手元のセッション）、Ultrareview、GitHub Actions / GitLab CI/CD、自作のサブエージェントやスキル。

### 有効化（code-review-setup）
- 必要な権限: Claude 組織の Owner ロール（管理画面の全操作）。GitHub 組織の Owner（Claude GitHub App の導入と Claude 組織への連携。Owner でなければ事前に導入・連携を頼む）。追加する各リポジトリへの write 権限（連携した GitHub アカウントで）。
- 手順: (1) **Allow code review** スイッチをオン。ダイアログ無しで即オンになったら、既に App 連携かリポジトリ追加済み。 (2) **Connect GitHub** ダイアログで **Connect**（GitHub Enterprise Server は先にインスタンスを選ぶ）。 (3) **Add a repository** に目的のリポジトリが無ければ **Install GitHub App** で GitHub 組織とリポジトリを選び権限を承認（権限は他の Claude 機能と共有で、レビューに必要な範囲より広い）。完了後に **Finish connecting GitHub** が出たら押す。 (4) リポジトリを選び **Continue**。 (5) **Code review is set up** ダイアログで **Finish**（他の閉じ方だとリポジトリは追加されたままスイッチはオフ）。 (6) ドラフトでないテスト PR を開き、数分以内に **Claude Code Review** チェックランが出るか確認。
- 新規リポジトリの初期値は **After every push**（最もレビュー回数が多い）。
- Review level の変更は、変更後に始まるレビューから適用。組織の既定は **Review level** で選び **Change level** で確定。リポジトリごとは **Edit** から選び、最初の選択肢 **Default** は組織に従う。
- **Review runs**: **Once after PR creation**（PR の open / reopen / ready for review 時）、**After every push**（push ごと。指摘を直すとスレッドを自動 resolve）、**Manual (@claude review)**。表の列表示は Once per PR / Every push / Manual。ドラフトとフォークの PR は、どの設定でも自動レビューの対象外。
- **Show tips on pull requests**（既定オン）: レビューが始まらないとき、理由と次の手を PR にコメントする。対象は、Manual 設定、フォークからの PR、bot または write 権限の無い人の `@claude review`、GitHub 組織が Claude 組織に未連携の場合。
- 開発者（Owner 以外）にできること: `@claude review`（write 権限必須、ドラフト・フォークでも可）、`@claude review always`、`REVIEW.md` / `CLAUDE.md` のコミット。開発者が依頼したレビューも組織に課金される。
- 組織全体の一括カバー: 組織行の **Review runs** で設定（選択肢は3つに **Off** を加えたもの）。条件は、連携した GitHub アカウントがその GitHub 組織の owner、github.com 上の組織（GitHub Enterprise Server と個人アカウントは不可）、月次の支出上限が設定済み（Claude 組織または Code Review）。支出が大きく増えうる。個別設定済みのリポジトリも選んだ値に上書きされる（個別に Off のものは Off のまま）。後から個別に変えると **Custom** 表示。組織行に Review level は無い。
- 停止: 個別は **Edit** で **Code review** をオフ、または **Remove repository**。組織全体は組織行で **Off**。全体は **Allow code review** をオフ（リポジトリ一覧は残る）。

### REVIEW.md / CLAUDE.md（code-review-customize）
- `CLAUDE.md`: ルート、および変更ファイルの親ディレクトリにあるものを読む。サブディレクトリのものは、その配下のファイルが変わる PR で読まれる。違反は、内容に見合う重大度の指摘になる。
- `REVIEW.md`: ルートに置く自由形式の Markdown。サブディレクトリにも置け、その配下の変更に追加のチェックを足す（ルートに加えて読む）。指摘を探すエージェントと検証するエージェントが、既定のガイダンスと並べて受け取り、最終レビューを書く段階が重大度と要約を決める前に参照する。レビューの形式は変えられない。
- 書式の例（原文のまま）: 見出し `# Review instructions`、`## What Important means here`（Important は動作を壊す・データ漏えい・ロールバックを妨げるものに限る。スタイル・命名・リファクタは最大でも Nit）、`## Cap the nits`（"Report at most five Nits per review."）、`## Do not report`（CI が既に強制するもの、`src/gen/` と `*.lock`、本番ルールに意図的に違反するテスト専用コード）、`## Always check`（新規 API ルートに統合テスト、ログにメール・ユーザー ID・リクエスト本文を出さない、DB クエリを呼び出し元テナントにスコープ）。
- 書く内容の指針: 誤って Important になる→ Important の定義を狭める／`CLAUDE.md` 違反を Important に格上げ。nit が多い→ 上限を決める。生成ファイルや CI 済みの項目→ 対象外のパスと種類を列挙（半端に見たいパスは「`scripts/` では確実かつ重大な場合のみ」のように基準を上げる）。チームの規則→ 追加。誤検出→ `file:line` の引用など根拠を要求。
- 読み込み元ブランチ: PR の base または既定ブランチから読み、PR 自身の変更は読まない。変更するにはまずマージする。保護された既定ブランチのルートファイルでは、重大度を下げる、パス・ファイル・種類を除外する、nit に上限を付ける指示が有効。
- 保護とみなす条件: 既定ブランチは classic のブランチ保護ルールまたは ruleset。それ以外のブランチは ruleset のみ。ruleset は、更新を制限するか、承認1人以上の PR を必須とし、さらに新しい push で承認を取り消すか最後の push 後の承認を求める必要がある。
- 読み込み表: 既定ブランチが保護され PR の対象がそこ（または ruleset 保護の無いブランチ）→ 既定ブランチのルート＋サブディレクトリ。PR の対象が ruleset 保護の別ブランチ→ その base のルート＋サブディレクトリ。既定ブランチが未保護で base も無保護→ 既定ブランチのルートのみ。保護を確認できない（未保護の既定ブランチと classic ルールだけの base を含む）→ 読まない。

### PR 上の動作（code-review-pull-requests）
- 重大度: 🔴 Important（マージ前に直すべきバグ）、🟡 Nit（軽微）、🟣 Pre-existing（この PR 以前からあるバグ）。記録された推論があれば折りたたみ **Why this was flagged** が付く。
- 指摘への対応: 解決（resolve）はスレッドを自分で resolve するのが唯一の却下方法で、返信だけでは却下にならない。直して push すれば、次のレビューが直ったと判断したスレッドを resolve する。返信しても Claude は即応せず、返信でレビューも始まらない。次のレビューが返信を読み、スレッドの resolve か追加返信1件を行う。ブランチ保護が会話の resolve を必須にしていれば、マージ前に各スレッドを resolve する。
- チェックランの **Details**: 重大度順の表（Severity / File:Line / Issue）。インラインにできなかった指摘は Files changed タブの注釈（Important は赤、Nit は黄、Pre-existing は灰）。インライン位置の無い指摘は、レビュー本文の **Additional findings** 見出しの下。
- スクリプトで結果を読む: `gh api repos/OWNER/REPO/commits/<commit-sha>/check-runs --jq '.check_runs[] | {id, name}'` で ID を得て、`gh api repos/OWNER/REPO/check-runs/CHECK_RUN_ID --jq '.output.text | split("bughunter-severity: ")[1] | split(" -->")[0] | fromjson'`。出力は例 `{"nit": 1, "normal": 2, "pre_existing": 0}`。`normal` が Important の件数。この行が無いのは判定なしとして扱う（失敗・タイムアウト・キャンセル・新レビューに置換されたものは無い）。件数には、スレッドがまだ開いている過去のレビューの指摘を含む。
- コマンド: `@claude review`（1回だけ。以後の push は購読しない）、`@claude review always`（開始し、以後の push のたびのレビューに購読）、`@claude review once`（`@claude review` と同じ）。条件: 新しいトップレベルの PR コメント（インラインやレビュー本文は不可、編集も不可）、コメントの先頭に書く（`always` は同じ行）、大文字小文字は不問、リポジトリの write / maintain / admin 権限（bot は不可）、PR が open。受理されるとチェックランが **Code review queued...** となり、開始で **Code review in progress...** になる。👀 のリアクションはレビュー開始を保証しない。同じ最新コミットでレビュー実行中なら、2つ目は始まらない。
- 変更履歴（docs 記載）: 2026年7月の更新より前は、`@claude review` が push ごとのレビューに購読していた。そのままにしたい場合は `@claude review always`。
- 後続レビュー: push などで自動に始まるレビューは、前回からの変更に絞り、nit と pre-existing を減らす。除いた件数は要約に出る。全体をもう一度見るには `@claude review`。
- ドラフトとフォーク: 自動レビュー対象外。コメントコマンドはドラフトでも動く。ドラフトへの push はレビューを始めず、`always` 後も同様（ready にすると購読が有効）。フォークでは `@claude review` が使え（必要な write 権限は base リポジトリ側）、`always` は動くが以後の push は購読されない。**Re-run** もフォークでは無効。
- 自動リトライ: セッションが中断したレビューは1回だけ自動で再実行される。
- GitHub Action との併用: `@claude` を既定のトリガーにした対話モードの Claude Code GitHub Action があると、`@claude review` で Action も動く。分けるには Action の `trigger_phrase` を別の語にする。
- プランに Code Review が無いときは、Claude Code セッションの `/code-review` を使う。

### 費用（code-review-costs）
- 定額の1レビュー価格は無い。1レビューの費用は、レビューレベル、変更の大きさ、周辺コードの複雑さ、検証が必要な候補の数で決まる。件数は Review runs で決まる。docs に、1レビューあたりの金額の数値は無い。
- 課金: トークン使用量に応じ usage credits（プラン付属の利用量とは別）。組織に課金され、PR を開いた人や依頼者には課金されない。Bedrock、Google Cloud の Agent Platform、Microsoft Foundry を他の機能に使っていても、請求は Anthropic から。
- 回数への影響: After every push は push 数だけ費用が増える。`@claude review always` は、Once または Manual のリポジトリでは push ごとの費用が加わり、After every push のリポジトリでは変化しない。`@claude review` は1回のみ。ドラフトとフォークは自動では増えない。
- 見積り手順: パイロットで月次上限を設定 → 代表的なリポジトリを Once または Manual で有効化 → 数回後に Repositories 表の **Average cost** 列を読む → PR 数を掛ける（After every push はさらに PR あたりの push 数を掛ける）。
- 支出上限: claude.ai/admin-settings/usage で Claude Code Review サービスの月次上限を設定（組織全体に適用、次の請求期間で戻る。上げれば即再開）。次のいずれかが尽きるとスキップ: Code Review の上限、組織全体の月次上限、usage credits 残高。残りが1レビューの想定費用に満たなくてもスキップ。スキップ時、PR にコメントが付き、原因と使用量設定へのリンクが示される。
- 使用量: claude.ai/analytics/code-review。PRs reviewed、Code Review cost（当月選択時のみ金額表示）、Feedback（自動 resolve された件数）、Repository breakdown（PR 数、resolve 数、実行数、推定費用）。分析の費用は定価ベースの推定で、割引やクレジット前のもの。請求書とは異なりうる。

### トラブルシューティング（code-review-troubleshooting）
- チェックランのタイトル: **Code review queued...** / **in progress...**（待つ）、**Code review found no issues**、指摘ありを示すタイトル、**Code review skipped — no new changes**（push で変更ファイルが無い。`@claude review` で強制）、**Code review failed** / **timed out**（再実行）、**Code review declined**（実行されず。予算か上限の記載を確認）、チェックランなし（`@claude review`）。
- コマンドが効かない原因: リポジトリで Code Review がオフ（コメントもチェックランも出ない）、条件を満たさないコメント、write 権限なし（tips オンなら "No review was started: manual reviews can only be requested by someone with write access to this repository." と返信）、予算切れ（"⚠️ Code review skipped" で始まるコメント）。
- 予算メッセージの文言と原因: "has reached its monthly code review spending cap"（Code Review の月次上限。次の請求期間か上限引き上げで再開）、"has no extra usage available to pay for this review"（usage credits の残高が空、または組織全体の月次上限）、"is too low to start another review"（残りが1レビューの想定費用未満）。復旧後は `@claude review` で、スキップされたレビューを得る。
- 失敗・タイムアウト: 要約に "The review session was interrupted before it could finish. A new review of this commit has been queued automatically." とあれば自動再実行されるので何もしない。それ以外は `@claude review` か、フォーク以外の PR で **Re-run**（現在の head コミットを対象。購読はしない）。
- 指摘がインラインで見えない: Details の表、Files changed の注釈、レビュー本文の **Additional findings**。
- チェックランが `REVIEW.md` に触れるメッセージ: "...from its default branch, which is not protected against direct pushes."（ルートのみ読んだ）、"were not applied to this review: branch protection could not be confirmed"（読んでいない）。
- 設定の問題: リポジトリが Add a repository に出ない→名前で検索、**Install GitHub App** で権限付与。テスト PR にチェックランが出ない→ **Allow code review** がオンか、リポジトリが一覧にあるか、App がアクセスできるか、ドラフトでないか、Manual なら `@claude review` が要る。

## 関連ページ

- [[concepts/code-review]]
- [[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]
- [[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]

## 取り込みメモ

- 取得日 2026-10-16（JST）。すべて curl で `.md` 版を取得。URL は `https://code.claude.com/docs/llms.txt` の一覧で実在を確認した。ページに日付表示が無いため published は unknown。ファイル名には取得日を使った。
- 各ページの URL と sha256（生データ）。frontmatter の fingerprint は概要ページのもの:
  - 概要 https://code.claude.com/docs/en/code-review.md — e27d0098417de60dc9792fdc86087415970e88a8fdfca60c6b9b3207d39bc5d6
  - setup https://code.claude.com/docs/en/code-review-setup.md — ccf9c2ac509fda29a1b973b84974584df273b79184423c34e004569c5ecc666c
  - customize https://code.claude.com/docs/en/code-review-customize.md — 934b5d7ed1a1dd671af0e7cce0d19385fac5736d77c1f80d775d235f776bb629
  - pull-requests https://code.claude.com/docs/en/code-review-pull-requests.md — 563c0cebf2a21f68005b2f2801a26bd512e40fb0ba974ca00d7417ea21d717cc
  - costs https://code.claude.com/docs/en/code-review-costs.md — 93504a0e1aa12e30593b8970d8011b652493a45de6a2f95859de422746993fa2
  - troubleshooting https://code.claude.com/docs/en/code-review-troubleshooting.md — 73e25bbed25e2d3de9f6066302e283cbeb3077ca93ddbf13421215e8eddadd9d
- 概要ページは前回取得分（本ページ作成時）を再取得していない。下位ページの内容は概要と矛盾しなかった。
- 未取得: `code-review-local`（`/code-review`）、`ultrareview`、`github-actions`、`github-enterprise-server`、usage credits の support.claude.com 記事（対象外）。
- 「月次上限のコメント」は、docs の文言（上記の3種）を根拠にした。1レビューあたりの金額（単価）は docs の範囲に無かったので、書けない。
- ページ内に取り込み担当への指示文は無かった。
