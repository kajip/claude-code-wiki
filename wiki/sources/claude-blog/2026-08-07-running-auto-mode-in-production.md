---
type: source
source_id: claude-blog
title: Running auto mode in production
url: https://claude.com/resources/articles/auto-mode-in-production
published: 2026-08-07
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: none
fingerprint: 3d9d9a4febd8ae3687e514e0bbe6bdc29fa0bb09e870692aeece8b3f703997a7
archive_url:
---

# Running auto mode in production

## 要点

- 著者 Molly Vorwerck、カテゴリ Best practices、読了10分。同日公開の既定化の記事（[[sources/claude-blog/2026-08-07-auto-mode-default-in-claude-code]]）の顧客事例編にあたり、Nuro、Gusto、Garner Health が auto mode を日常的に使う理由と運用の工夫を紹介する。
- 冒頭の主張（Anthropic 側、公開時点）: 社内評価で分類器は、人が権限プロンプトを手でクリックするより多くの危険な操作を止め、第三者のレッドチームでも性能が保たれた。中断が減るため、Claude Code 全体の利用で、以前の既定より「9倍長く」中断なしで動く。
- Nuro: 夜間の長時間エージェント（評価指標を改善し続ける研究エージェント）に使う。22時に起動し5時まで動いて朝に PR 3件、という例。
- Gusto: PR 出荷の高速化と権限疲れの軽減。分類器の拒否は 2026-05 中旬以降のセッションの約 10%。機微な本番作業は accept edits に切り替える人もいる。
- Garner Health: 全従業員 550人に展開。標準化した SDLC（skills のプラグイン）が「auto mode でのみ可能」と語る。コミュニケーション系の操作（Slack、メール）は承認しない設定にした。
- 共通する運用: 危険コマンドの deny、他者に影響する作業では手動に戻す、MCP のプロキシやテレメトリなど多層の統制と併用。

## 具体的な値

**記事の数値（公開時点、Anthropic 側の主張、第三者の検証なし）**
- 「9x longer between interruptions than under the previous default」（Claude Code 全体の利用）。算出方法は記事に記載なし。
- Nuro: 2025年後半に Claude Code 導入、3月には社内で最も使われるエージェント型コーディングツール。Kai Zhou は以前、hook で各操作を小さなモデルに送り、定型の約 90% を自動承認し、機微なものは Slack で人に回す自作の仕組みを試作していたが、auto mode の提供で取りやめた。3〜4セッションを並列で auto mode 実行。他チームに関わる作業（PR レビュー等）は interactive mode に戻す。再帰削除などの危険コマンドは settings で deny し、分類器はその内側で判断。
- Gusto: Martin Emde は 12月以降 2,425 セッション。トランスクリプトの約 10% に auto mode の拒否（2026-05 中旬以降、同社の分析）。Chad Kunsman は Terraform、AWS、本番 API への POST など本番寄りの作業で accept edits に切り替え、ツール呼び出しを手で確認。MCP トラフィックは、ツールガードとプロンプト検査を備えたプロキシ層を経由。
- Garner Health: 2月に全 550人へ展開。Salesforce、Zendesk、Snowflake と連携。週約2時間の自動化を推奨。Evan Magnussen は「分類器の注入プロンプトを、より緩く／厳しく調整した」チームがある（コアな知的財産を扱うチーム）と説明。

**設定・機能への言及**
- 具体的な設定キーやコマンドの記載はなし。「分類器の injected prompts を調整できる」という表現は、docs の `autoMode.environment` / `allow` / `soft_deny` 等に対応すると思われる（推測）。
- 「Get started with auto mode in Claude Code」へのリンクが末尾にある。

## 関連ページ

- [[concepts/auto-mode]]
- [[sources/claude-blog/2026-08-07-auto-mode-default-in-claude-code]]
- [[sources/docs/2026-10-10-permission-modes]]
- [[sources/docs/2026-10-10-auto-mode-config]]

## 取り込みメモ

- 日付は `article:published_time`（2026-08-07）と本文の Date 表示（August 7, 2026）で確認。一覧の日付と一致。
- fingerprint は curl で取得した記事 HTML の sha256。本文は HTML から抽出して読んだ。
- 「Related articles」に 2026-10-05〜10-08 の記事が並ぶ。ページは動的に関連記事を差し込んでおり、公開日の記事本文とは別の要素と判断した（推測）。
- 既定化の日付、課金、提供範囲の記述は本記事には無く、同日の記事に従う。
- ページ内に、エージェントへの指示文は見つからなかった。
