---
type: concept
title: Claude Haiku 5.5
updated: 2026-10-22
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/pricing/2026-10-22-pricing
  - sources/platform-docs/2026-10-10-prompt-caching
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
---

# Claude Haiku 5.5

## 概要

Claude 5.5 ファミリーの小型モデル。2026-10-07 に発表された。量が多くコストに敏感な処理や、上位モデルの下で動くサブエージェントを想定している（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。

## 現状（as of 2026-10-22）

- API モデル ID は `claude-haiku-5-5`。全プラットフォームで提供（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
- 価格（100万トークンあたり。100K 以下／100K 超）: 入力 $0.10／$0.50、出力 $0.50／$2.50、キャッシュ書き込み（5分）$0.125／$0.625、（1時間）$0.20／$1、キャッシュヒット $0.01／$0.05（[[sources/pricing/2026-10-10-pricing]]）。プロンプトの長さには、キャッシュの読み書きも数える（[[sources/pricing/2026-10-10-pricing]]）。
- 1M コンテキストの料金: プロンプトが 100K 以下のリクエストは入力 $0.10、出力 $0.50、100K 超のリクエストは入力 $0.50、出力 $2.50。他の Claude 4.6 以降のモデルのように全域が標準単価になるわけではない。判定はリクエストごとで、キャッシュヒットの分も長さに数え、以前のリクエストは当時の単価のまま。`inference_geo` の US 指定の1.1倍は 100K 超の単価にも掛かる。Batch は $0.05／$0.25（100K 以下）と $0.25／$1.25（100K 超）。2026-10-22 の価格ページでも単価は変わらない（[[sources/pricing/2026-10-22-pricing]]）。
- Haiku クラスで初めて effort を調整できる（[[sources/pricing/2026-10-22-pricing]]）。Claude API を直接使う場合、`output_config.effort` を変えると messages のキャッシュが常に無効になる（[[sources/platform-docs/2026-10-10-prompt-caching]]）。最小キャッシュ可能長は 512 トークン。thinking ブロックは既定で保たれ、非ツール結果のユーザー内容を足してもキャッシュは有効（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- コンテキストは 1M、最大出力は 128k。adaptive thinking が既定で有効。Haiku 4.5 向けのコードでは、`budget_tokens`、`temperature`／`top_p`／`top_k`、prefill、`computer_20250124` が 400 になる。Bedrock では structured outputs を使えない（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- Claude Code は 2.1.293 で追加した。Anthropic API での既定の Haiku で、コンテキストは 1M（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 複雑なエージェント型コーディングには、Sonnet 5.5 や Opus 5.5 の方が向くとされる（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。

## 変更履歴

- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」3 件を直前の出典のリンクに展開。内容の変更なし
- 2026-10-22 — 価格ページの更新を確認し、1M コンテキストの料金（100K で単価が変わる）を現状に追記。単価は変わらず（[[sources/pricing/2026-10-22-pricing]]）
- 2026-10-07 — 発表。Claude Code 2.1.293 で追加（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]、[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- Claude apps gateway の背景処理は、2.1.295 の時点でも「Haiku 4.5」を使うと書かれている（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。Haiku 5.5 に切り替わる予定かどうかは不明。
