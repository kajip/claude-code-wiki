---
type: concept
title: routines（ルーティン）
updated: 2026-11-07
sources:
  - sources/docs/2026-11-07-routines
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/docs/2026-10-16-routines-and-cloud-sessions
  - sources/docs/2026-10-10-permission-modes
  - sources/gh-changelog/2026-10-18-v2-1-302
---

# routines

（ページのスラッグは `routines` のまま。現在の docs での名称は scheduled tasks で、routines は旧称（[[sources/docs/2026-11-07-routines]]）。）

## 概要

プロンプト、リポジトリ、コネクタ、環境を保存しておき、トリガーで cloud session として動かす仕組み。トリガーは、スケジュール、HTTP 呼び出し（API）、GitHub のイベントのどれか。1つの routine に複数を組み合わせられる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]、[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。

## 現状（as of 2026-11-07）

出典は特記が無い限り docs（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。以下の名称、段階、提供プラン、`/schedule` の別名は 2026-11-07 の再取得による（[[sources/docs/2026-11-07-routines]]）。

- **名称**: docs の呼称は「scheduled tasks」で、routines は旧称（原文: formerly routines）。旧称は URL `claude.ai/code/routines`、CLI の `/routines`、API の `/fire` パスと beta ヘッダー、組織設定のトグル（「Scheduled tasks (Was Routines)」または「Routines」）、一部アカウントのアプリ表示（New routine）に残る（[[sources/docs/2026-11-07-routines]]）。
- **研究プレビュー**（2026-11-07 の docs でも表示あり。"Scheduled tasks are in research preview"）。docs は「挙動、上限、API の形が変わりうる」と明記。`/fire` は beta ヘッダー `experimental-cc-routine-2026-04-01` の下にある（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 提供: **Pro、Max、Ultra、Team、Enterprise**（2026-10-16 の要約は Ultra が抜けていた）。Team／Enterprise の Owner は「Scheduled tasks (Was Routines)」または「Routines」のトグルで組織全体を無効にできる（Enterprise のカスタムロールでは scheduled tasks の権限も必要）。作り方は claude.ai/code/routines、Desktop（Cloud を選ぶ）、`/schedule`。`/routines` は `/schedule` の別名として残る（[[sources/docs/2026-11-07-routines]]）。`/schedule` は claude.ai のサブスクリプションログインが必要（この条件は 2026-10-16 取得分）で、Console API キーやクラウドプロバイダー経由では使えない（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- **料金と利用枠**: 実行は対話セッションと同じようにサブスクリプションの利用枠を消費する。VM への別料金の記載は無い（cloud session 全般が「別料金なし」）。枠を超えたとき、usage credits が有効な組織は従量の超過分で続行でき、無効なら枠のリセットまで追加実行は拒否される。API の従量課金ではない（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- **1時間あたりの上限**（どれも overage なし）: スケジュール実行は100回／アカウント。Run now、API fire、1回きり routine の再設定は30回／routine（3つで1つの数）。Run now と1回きりの再設定は100回／アカウント、API fire は100回／アカウント（別カウント）。GitHub イベントにも routine 単位・アカウント単位の上限があるが数値は docs に記載なし。超えたイベントは破棄される（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- スケジュールの最短は1時間間隔（短い cron は拒否）。ちょうど毎時0分は数分遅れることがある（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 無人実行: 権限モードの選択が無く、シェル、skills、コネクタ（既定では接続済みの全部、書き込み含む）を承認のために止まらず使う。一部の artifact 操作は確認される（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。ただし、明示的な ask ルール（例 `Bash(git push *)`）は、どの権限モードでも自動では承認されない（[[sources/docs/2026-10-10-permission-modes]]）。routine の docs はこの点に触れていない。この wiki の試しの実行（2026-10-16）では、リポジトリの `.claude/settings.json` の ask ルールに当たった操作で承認待ちになり、止まった（log.md の 2026-10-17 の schema を参照）。
- push 先: 既定は `claude/` 始まりのブランチ。プロンプトで別のブランチへの push を指示すればそちらへ push する。専用の設定項目は無く、制限は GitHub の branch protection／ruleset で行う（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- ネットワーク: 環境に従う。Default 環境は Trusted（許可リストのみ）で、許可外ホストは `403`／`host_not_allowed`。Custom か Full に変えられる。コネクタの通信は Anthropic のサーバー経由で、許可リストの対象外（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- repo の `.claude/agents/`、`.claude/settings.json` の hooks と権限ルールは、リポジトリ1つのセッションで読み込まれる。複数リポジトリのセッションでは読まれない。ユーザーの `~/.claude/` は読まれない（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- routine 内のサブエージェントの扱い: 個別の記述は docs に記載なし。cloud sessions 一般では repo の `.claude/agents/` のサブエージェントが使える（→ [[concepts/cloud-sessions]]）。routine は完全な cloud session として動くため同様と思われる（推測）（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 同時実行数、1回の実行時間の上限: docs に記載なし（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 所有は個人のアカウント。共有されず、コミットやコネクタの操作は本人として記録される（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- 発火時の `text` は `<routine-fire-payload>` で包まれ信頼できないデータとして扱われる。保存済みプロンプトが明示的に参照したときだけ指示として使われる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- GitHub 接続が切れると最大72時間はスキップされ、それ以降は routine がオフになる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
- スケジュール実行と Run now の実行は、自分だけが見られる新しい artifact を承認なしで公開する（2.1.292）。telemetry を無効にした環境でも同じ動きになった（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。docs にも同じ趣旨の節がある（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。API／GitHub トリガーの実行では常に確認する。

**2.1.302 の CHANGELOG（2026-10-17）**

- routine のページに、直近の実行が始まらなかった理由のバナーを追加（例: 組織の同時 cloud session の上限）（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- 実行状態の表示を修正: cloud session が異常停止した実行は Completed でなく failed、開始前にアーカイブされた実行は Cancelled でなく failed（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- 途中で失敗した scheduled routine が 1 時間以上後に最初から再実行され、同じレポートの 2 回投稿などが起きうる問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。

## 変更履歴

- 2026-11-07 — docs を再取得（Lint の指摘対応）。呼称が scheduled tasks（旧称 routines）に、提供プランに Ultra が加わっていた。研究プレビューの表示は継続。`/routines` が `/schedule` の別名であることを確認。1時間あたりの上限（スケジュール 100、Run now／API／再設定 30／タスクと 100／アカウント）は表で再確認し変更なし（[[sources/docs/2026-11-07-routines]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」2 件を直前の出典のリンクに展開、出典の無かった 15 行に出典を付与、「現状」の as of を 2026-10-18 に更新。内容の変更なし
- 2026-10-17 — 2.1.302: 実行が始まらなかった理由のバナーを追加。失敗した実行の状態表示と、失敗後の再実行の問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-10-17 — 「承認のために止まらない」に、明示的な ask ルールは例外であることを追記（[[sources/docs/2026-10-10-permission-modes]]）
- 2026-10-16 — docs を取り込み。利用枠の扱い、1時間あたりの上限の数値、`claude/` 以外への push が可能なこと、ネットワークの既定を追加（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）
- 2026-10-09 — 2.1.295: telemetry を無効にした環境でも artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: 自分だけが見られる artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — claude-dev の記事（公開時点）: 研究プレビュー、承認の確認無しで動く、既定で `claude/` 始まりのブランチに push、スケジュールの最短は1時間（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。docs の現状と矛盾は無い（push 先は docs が「プロンプトで変更可」と補足）

## 未解決・矛盾

- 解決済み（2026-10-17）: `settings.json` の ask ルールと無人実行の関係。ask ルールは自動承認されない（[[sources/docs/2026-10-10-permission-modes]]）。
- routine 内のサブエージェント、同時実行数、1回の実行時間の上限、GitHub イベントの1時間上限の数値は、docs に記載が無く未確認（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
