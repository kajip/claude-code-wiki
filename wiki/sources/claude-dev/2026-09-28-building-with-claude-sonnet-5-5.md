---
type: source
source_id: claude-dev
title: Building with Claude Sonnet 5.5
url: https://claude.dev/blog/building-with-claude-sonnet-5-5/
published: 2026-09-28
retrieved: 2026-10-10
version: 2.1.284
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# Building with Claude Sonnet 5.5

## 要点

- 仕様がはっきりしていて結果を確かめる手段がある作業には Sonnet 5.5、慎重な判断が要る長い作業には Opus 5.5 を推奨する。
- Sonnet 5 からの移行で壊れる点: `thinking: {"type": "disabled"}` と、強制の `tool_choice`（`any`／`tool`）は 400 エラーになる。前者は `between_tools`、後者は `auto` と strict ツールに置き換える。
- computer use はツールセット `computer_toolset_20260801` に移った（Claude API と Google Cloud）。
- Claude Code では、v2.1.284 から `sonnet` エイリアスが Sonnet 5.5 を指す。既定の effort は `medium`。`default` のモデルは Opus 5.5 のまま。
- Claude Code では、Sonnet 5.5 の thinking を切れない。fast mode も無い。

## 具体的な値

- モデル ID: `claude-sonnet-5-5`（Bedrock では `anthropic.claude-sonnet-5-5`）
- コンテキスト 1M（ネイティブ、beta header 不要）。最大出力 128k。Message Batches API で `output-300k-2026-03-24` を使うと最大 300k。知識のカットオフは June 2026。
- effort: `low`、`medium`、`high`、`xhigh`、`max`。既定は Claude API が `high`、Claude Code が `medium`。
- `between_tools` は `low`〜`high` の effort でだけ使える（`xhigh`／`max` では 400）。
- キャッシュの最小は 512 トークン（Sonnet 5 は 1,024）。トップレベルの effort を変えるとキャッシュが無効になる。
- 価格（公開時点）: 入力 $2、出力 $10、キャッシュ書き込み（5分）$2.50、（1時間）$4、キャッシュ読み取り $0.20。`inference_geo: "us"` は標準価格の1.1倍。
- 拒否されたときは HTTP 200 で `stop_reason: "refusal"` が返る。`stop_details` は `cyber`、`bio`、`frontier_llm`、`reasoning_extraction`、`general_harms` のどれか。
- サーバー側の fallback（`fallbacks: "default"`、ベータ）は、`cyber` と `frontier_llm` を Sonnet 5 で再試行する。
- 移行用コマンド: `/claude-api migrate this project to claude-sonnet-5-5`

## 関連ページ

- [[concepts/claude-sonnet-5-5]]
- [[concepts/effort]]
- [[concepts/claude-api-skill]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- キャッシュ読み取り $0.20 は公開時点の値。2026-10-07 に $0.10 に下がった（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
