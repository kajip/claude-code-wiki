---
type: concept
title: routines（ルーティン）
updated: 2026-10-18
sources:
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/docs/2026-10-16-routines-and-cloud-sessions
  - sources/docs/2026-10-10-permission-modes
  - sources/gh-changelog/2026-10-18-v2-1-302
---

# routines

## 概要

プロンプト、リポジトリ、コネクタ、環境を保存しておき、トリガーで cloud session として動かす仕組み。トリガーは、スケジュール、HTTP 呼び出し（API）、GitHub のイベントのどれか。1つの routine に複数を組み合わせられる（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]、[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。

## 現状（as of 2026-10-16）

出典は特記が無い限り docs（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。

- **研究プレビュー**。docs は「挙動、上限、API の形が変わりうる」と明記。`/fire` は beta ヘッダー `experimental-cc-routine-2026-04-01` の下にある。
- 提供: Pro、Max、Team、Enterprise。Team／Enterprise の Owner は Routines トグルで組織全体を無効にできる。作り方は claude.ai/code/routines、Desktop（Cloud を選ぶ）、`/schedule`（別名 `/routines`）。`/schedule` は claude.ai のサブスクリプションログインが必要で、Console API キーやクラウドプロバイダー経由では使えない。
- **料金と利用枠**: 実行は対話セッションと同じようにサブスクリプションの利用枠を消費する。VM への別料金の記載は無い（cloud session 全般が「別料金なし」）。枠を超えたとき、usage credits が有効な組織は従量の超過分で続行でき、無効なら枠のリセットまで追加実行は拒否される。API の従量課金ではない。
- **1時間あたりの上限**（どれも overage なし）: スケジュール実行は100回／アカウント。Run now、API fire、1回きり routine の再設定は30回／routine（3つで1つの数）。Run now と1回きりの再設定は100回／アカウント、API fire は100回／アカウント（別カウント）。GitHub イベントにも routine 単位・アカウント単位の上限があるが数値は docs に記載なし。超えたイベントは破棄される。
- スケジュールの最短は1時間間隔（短い cron は拒否）。ちょうど毎時0分は数分遅れることがある。
- 無人実行: 権限モードの選択が無く、シェル、skills、コネクタ（既定では接続済みの全部、書き込み含む）を承認のために止まらず使う。一部の artifact 操作は確認される。ただし、明示的な ask ルール（例 `Bash(git push *)`）は、どの権限モードでも自動では承認されない（[[sources/docs/2026-10-10-permission-modes]]）。routine の docs はこの点に触れていない。この wiki の試しの実行（2026-10-16）では、リポジトリの `.claude/settings.json` の ask ルールに当たった操作で承認待ちになり、止まった（log.md の 2026-10-17 の schema を参照）。
- push 先: 既定は `claude/` 始まりのブランチ。プロンプトで別のブランチへの push を指示すればそちらへ push する。専用の設定項目は無く、制限は GitHub の branch protection／ruleset で行う。
- ネットワーク: 環境に従う。Default 環境は Trusted（許可リストのみ）で、許可外ホストは `403`／`host_not_allowed`。Custom か Full に変えられる。コネクタの通信は Anthropic のサーバー経由で、許可リストの対象外。
- repo の `.claude/agents/`、`.claude/settings.json` の hooks と権限ルールは、リポジトリ1つのセッションで読み込まれる。複数リポジトリのセッションでは読まれない。ユーザーの `~/.claude/` は読まれない。
- routine 内のサブエージェントの扱い: 個別の記述は docs に記載なし。cloud sessions 一般では repo の `.claude/agents/` のサブエージェントが使える（→ [[concepts/cloud-sessions]]）。routine は完全な cloud session として動くため同様と思われる（推測）。
- 同時実行数、1回の実行時間の上限: docs に記載なし。
- 所有は個人のアカウント。共有されず、コミットやコネクタの操作は本人として記録される。
- 発火時の `text` は `<routine-fire-payload>` で包まれ信頼できないデータとして扱われる。保存済みプロンプトが明示的に参照したときだけ指示として使われる。
- GitHub 接続が切れると最大72時間はスキップされ、それ以降は routine がオフになる。
- スケジュール実行と Run now の実行は、自分だけが見られる新しい artifact を承認なしで公開する（2.1.292）。telemetry を無効にした環境でも同じ動きになった（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。docs にも同じ趣旨の節がある。API／GitHub トリガーの実行では常に確認する。

**2.1.302 の CHANGELOG（2026-10-17）**

- routine のページに、直近の実行が始まらなかった理由のバナーを追加（例: 組織の同時 cloud session の上限）（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- 実行状態の表示を修正: cloud session が異常停止した実行は Completed でなく failed、開始前にアーカイブされた実行は Cancelled でなく failed（同）。
- 途中で失敗した scheduled routine が 1 時間以上後に最初から再実行され、同じレポートの 2 回投稿などが起きうる問題を修正（同）。

## 変更履歴

- 2026-10-17 — 2.1.302: 実行が始まらなかった理由のバナーを追加。失敗した実行の状態表示と、失敗後の再実行の問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-10-17 — 「承認のために止まらない」に、明示的な ask ルールは例外であることを追記（[[sources/docs/2026-10-10-permission-modes]]）
- 2026-10-16 — docs を取り込み。利用枠の扱い、1時間あたりの上限の数値、`claude/` 以外への push が可能なこと、ネットワークの既定を追加（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）
- 2026-10-09 — 2.1.295: telemetry を無効にした環境でも artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: 自分だけが見られる artifact を承認なしで公開するよう変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — claude-dev の記事（公開時点）: 研究プレビュー、承認の確認無しで動く、既定で `claude/` 始まりのブランチに push、スケジュールの最短は1時間（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。docs の現状と矛盾は無い（push 先は docs が「プロンプトで変更可」と補足）

## 未解決・矛盾

- 解決済み（2026-10-17）: `settings.json` の ask ルールと無人実行の関係。ask ルールは自動承認されない（[[sources/docs/2026-10-10-permission-modes]]）。
- routine 内のサブエージェント、同時実行数、1回の実行時間の上限、GitHub イベントの1時間上限の数値は、docs に記載が無く未確認（[[sources/docs/2026-10-16-routines-and-cloud-sessions]]）。
