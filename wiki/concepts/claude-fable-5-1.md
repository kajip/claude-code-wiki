---
type: concept
title: Claude Fable 5.1 と Mythos 5.1
updated: 2026-11-07
sources:
  - sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1
  - sources/pricing/2026-10-22-pricing
---

# Claude Fable 5.1 と Mythos 5.1

## 概要

Fable 5.1 と Mythos 5.1 は同じモデルで、安全策の強さだけが違う。Fable 5.1 は一般提供、Mythos 5.1 は信頼済みアクセスのプログラム経由のみ（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。Fable 5 に対し、価格（キャッシュ読み取り）、データ保持（EFS）、安全策の精度が改善された。

## 現状（as of 2026-11-07）

- API モデル ID は `claude-fable-5-1`。AWS、Google Cloud、Microsoft Azure を含む全プラットフォームで提供（発表時点）（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。
- 価格（100万トークンあたり）: 入力 $10、出力 $50、キャッシュ書き込み $12.50（5分）／$20（1時間）、キャッシュヒット $0.25（入力の0.025倍）。Mythos 5.1 も同額（limited availability）。Fable 5 のキャッシュヒットは $1（[[sources/pricing/2026-10-22-pricing]]）。発表の価格（入力 $10、出力 $50、キャッシュ読み取り $0.25）は価格ページと一致（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。
- コスト: キャッシュ読み取りの75%値下げにより、Fable 5 比で一般的な作業は約25%、エージェント的な作業は最大約45%安い（2026年8月の実利用による Anthropic の推計）（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/prompt-caching]]
- effort の既定: Claude Code は High、Claude Cowork と Claude.ai は Medium。Low／Medium でも Fable 5 と同等以上を低コストで出すと主張（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/effort]]
- 安全策: サイバーは Claude Code で1セッションの介入が平均約60%減。脆弱性の発見は可、penetration testing、exploit generation、binary-based vulnerability scanning は Opus に回される。生物は初歩的な質問への反応が85%減で、ライフサイエンスの R&D は Opus に回される（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/cyber-safeguards]]
- Mythos 5.1: Cyber Verification Program と Life Sciences Verification Program（米政府と提携）経由。現在は米国の組織に限る。Claude Security も Mythos 5.1 で動く（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。
- データ保持: EFS が使えるまで、対象の顧客は ZDR で使える（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/enterprise-frontier-safeguards]]
- 蒸留対策: 新規 API アカウントは thinking の記録を保ったままの過去コンテキスト編集ができない（既存アカウントは当面対象外）（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/distillation-defenses]]
- Claude Code の docs では、Fable 5.1 は effort 変更でキャッシュが残るモデルの一つ（[[sources/docs/2026-10-10-prompt-caching]]）。ultrathink の対象でもある（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- 性能: 発表の数値は [[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]] の「具体的な値」を参照（Anthropic による測定）。Opus 5.5 は多くの作業で Fable 5.1 と同程度とされる（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

## 変更履歴

- 2026-11-07 — 発表の原典を取り込み、このページを新規作成（公開日は一覧の表示に従い 2026-09-15）（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）

## 未解決・矛盾

- thinking を切れないという 2026-10-22 の記事の主張（Fable 5.1 の部分）は、発表記事には記載が無く、platform-docs との照合も未了（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- 蒸留対策の対象アカウントの日付: 発表記事は「発表日以降」、既存の記述は 2026-08-31 以降。発表日が 09-15 なら食い違う。詳細は [[concepts/distillation-defenses]]（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。
