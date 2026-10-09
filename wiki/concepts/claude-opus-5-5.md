---
type: concept
title: Claude Opus 5.5
updated: 2026-10-10
sources:
  - sources/pricing/2026-10-10-pricing
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
---

# Claude Opus 5.5

## 概要

Claude 5.5 ファミリーの最初のモデル。2026-09-22 に発表された（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。多くの作業で Fable 5.1 と同程度の性能を持ち、Opus 5 より約40%安く動く（同）。Claude Code の `default` モデルである（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。

## 現状（as of 2026-10-10）

- API モデル ID は `claude-opus-5-5`。全プラットフォームで提供（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- 価格（100万トークンあたり）: 入力 $4、出力 $20、キャッシュ書き込み $5（5分）／$8（1時間）、キャッシュヒット $0.20（入力単価の0.05倍）（[[sources/pricing/2026-10-10-pricing]]）。
- Claude Code では **v2.1.280 以降**が必要。既定の effort は medium（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- fast mode に対応（入力 $8、出力 $40）（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。公開時点では研究プレビュー（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。→ [[concepts/fast-mode]]
- thinking は無効にできない（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- Fable と同じ水準の bio とサイバーの安全策を持つ。フラグが付いたメッセージは古いモデルに回されることがある（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。→ [[concepts/cyber-safeguards]]
- セッションの途中で effort を変えてもキャッシュが保たれる（Opus 5.5 と Fable 5.1）（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。ただし Bedrock、Google Cloud、ゲートウェイでは消える（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- Pro、Max、Team、席単位の Enterprise で、5時間ごとの利用上限が引き上げられた（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

- プロンプトの書き方: 完了の条件と止まる条件を伝えて、タスクを丸ごと任せる。「think carefully」のような指示は消す。止まる条件は CLAUDE.md に、タスクの一覧はファイルに置く。返答の中で内部の推論を再現させない。デザインの作業では、避けたいパターンを具体的に挙げる（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。まとめは [[analysis/opus-5-5-prompting]]。

## 変更履歴

- 2026-09-22 — 発表、提供開始（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）

## 未解決・矛盾

- コンテキスト長と最大出力は、取り込んだ出典のどれにも書かれていない。
