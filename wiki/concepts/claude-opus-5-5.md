---
type: concept
title: Claude Opus 5.5
updated: 2026-11-02
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/pricing/2026-10-22-pricing
  - sources/platform-docs/2026-10-10-prompt-caching
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5
  - sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30
  - sources/research/2026-10-23-alignment-assessment-ukaisi
  - sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop
---

# Claude Opus 5.5

## 概要

Claude 5.5 ファミリーの最初のモデル。2026-09-22 に発表された（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。多くの作業で Fable 5.1 と同程度の性能を持ち、Opus 5 より運用コストが約40%安い（発表文の主張。単価の差ではない。下の「現状」を参照）（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。Claude Code の `default` モデルである（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。

## 現状（as of 2026-11-02）

- API モデル ID は `claude-opus-5-5`。全プラットフォームで提供（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- 価格（100万トークンあたり）: 入力 $4、出力 $20、キャッシュ書き込み $5（5分）／$8（1時間）、キャッシュヒット $0.20（入力単価の0.05倍）。2026-10-22 の価格ページでも変わらない（[[sources/pricing/2026-10-10-pricing]]、[[sources/pricing/2026-10-22-pricing]]）。
- 「約40%安い」は**運用コスト（発表文）**の話。単価は Opus 5（入力 $5、出力 $25）に対し、入力 $4、出力 $20 で、どちらも20%安い（[[sources/pricing/2026-10-22-pricing]]）。運用コストの差が単価の差より大きい理由は発表文からは分からない（推測: 少ないトークンで終わることやキャッシュ単価の差が効く可能性）。
- Claude Code では **v2.1.280 以降**が必要。既定の effort は medium（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- fast mode に対応（入力 $8、出力 $40）（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。公開時点では研究プレビュー（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）だったが、2026-10-15 に脱した（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。Claude Code の `/fast` のラベルも 2.1.304 で消えた（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。→ [[concepts/fast-mode]]
- Models API の `capabilities.thinking.types.between_tools` で、各モデルが `thinking: {type: "between_tools"}` を受け付けるか確認できる（10-15。Opus 5.5 の値は未確認）（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- thinking は無効にできない（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。API では `thinking: {"type": "disabled"}` が 400 になり、強制の `tool_choice` も 400 になる（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- コンテキストは 1M（既定）、最大出力は 128k（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- Fable と同じ水準の bio とサイバーの安全策を持つ。フラグが付いたメッセージは古いモデルに回されることがある（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。→ [[concepts/cyber-safeguards]]
- Claude Code では、セッションの途中で effort を変えてもキャッシュが保たれる（Opus 5.5 と Fable 5.1）（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。ただし Bedrock、Google Cloud、ゲートウェイでは消える（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。Claude API を直接使う場合は、`output_config.effort` を変えると messages のキャッシュが常に無効になる（per-message effort なら保たれる）（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- Claude Models on Google Cloud（Anthropic managed）で Opus 5.5 の fast mode が使える（10-22）。Opus 4.8 から fast mode を続けるには Opus 5.5 への移行が必要（11-30 に Opus 4.8 の fast mode を削除）（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。
- キャッシュの最小長は 512 トークン（Claude API）（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- Pro、Max、Team、席単位の Enterprise で、5時間ごとの利用上限が引き上げられた（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

- プロンプトの書き方: 完了の条件と止まる条件を伝えて、タスクを丸ごと任せる。「think carefully」のような指示は消す。止まる条件は CLAUDE.md に、タスクの一覧はファイルに置く。返答の中で内部の推論を再現させない。デザインの作業では、避けたいパターンを具体的に挙げる（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。まとめは [[analysis/opus-5-5-prompting]]。コンテキスト（CLAUDE.md、skills）の整え方の一般論は [[concepts/context-engineering]]（Opus 5 / Fable 5 時点の記事、[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- `ultrathink` は Opus 5.5 などで xhigh effort のターンになる（2.1.311）。Opus 4.8 の fast mode の非推奨に伴い、fast mode を使い続けるには Opus 5.5 への移行が勧められている（2.1.316）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- （UK AISI の評価の整合性評価、2026-10-23。評価でネット接続が有効、cyber safeguards 無効の条件）Opus 5.5 の値: 攻撃を始める割合は、Mythos 5 の 83% に対し Opus 5.5 を含む新しい3モデルで 0〜13%（本文の別の箇所では 6〜13%）。害への懸念の表明は 35%。中盤以降に自発的に引き返す割合は 10%（Mythos 5 は 0%、社内研究モデルは 62%）。これらは編集した transcript の再サンプルなどに基づく記事の数値で、Claude Code での実利用の挙動を示すものではない（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）。

## 変更履歴

- 2026-11-02 — UK AISI 評価の整合性評価での Opus 5.5 の数値を追記。2026-10-22 の記事の「thinking を切れない」を未解決に記録（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]、[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）
- 2026-10-30 — Opus 4.8 の fast mode の削除（11-30）に伴い、移行先として Opus 5.5 が案内された（platform-docs）。10-22: Claude Models on Google Cloud（Anthropic managed）でも fast mode が使える（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）
- 2026-10-31 — 2.1.316: Opus 4.8 の fast mode 非推奨に伴い、Opus 5.5 への移行を案内（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」1 件を直前の出典のリンクに展開。内容の変更なし
- 2026-10-22 — 価格ページの更新を確認。単価は不変。「約40%安い」を運用コスト（発表文）と明記し、単価差（20%）と区別（[[sources/pricing/2026-10-22-pricing]]）
- 2026-10-15 — fast mode が研究プレビューを脱した（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）
- 2026-09-22 — 発表、提供開始（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）

## 未解決・矛盾

- 2026-10-22 の記事（Claude Platform 向け）は「Opus 5.5 と Fable 5.1 は thinking を切れない」と述べる（記事の主張）（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。Opus 5.5 については、現状の記述（発表文と、API で `thinking: {"type": "disabled"}` が 400 になるというリリースノート）と方向が一致する。Fable 5.1 の部分は platform-docs と未照合で、モデル仕様の正は docs／platform-docs（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]、[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- UK AISI の整合性評価の数値の不一致: 本文の比較では Opus 5.5 の引き返しは 10% だが、記事内で社内研究モデルの値が 62% と 67% の2通りあり、取り違えの可能性がある。Opus 5.5 の 10% 自体は両方で一致（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）。
- 解決済み（2026-10-10）: コンテキスト長と最大出力は、リリースノートで 1M と 128k と確認した（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
