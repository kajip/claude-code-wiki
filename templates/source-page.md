---
type: source
source_id: claude-dev            # sources.md の ID（gh-changelog / claude-blog / anthropic-news / claude-dev / docs / engineering / research / pricing）
title: （記事タイトル。原文のまま）
url: https://example.com/...     # 記事ページの URL（一覧ではなく本体）
published: 2026-10-06            # 情報源が示す日付。読み取れなければ unknown
retrieved: 2026-10-10            # 取得日（JST）
version:                         # 該当する Claude Code のバージョン（あれば）
tier: primary
review: pending                  # pending | ok
recheck: none                    # none | weekly（プレリリース等、変わりやすいもの）
fingerprint:                     # Bash で取得した生データの sha256 のみ。WebFetch の出力には付けない
archive_url:                     # 重要な情報源のみ（Wayback 等）
---

# （タイトル）

## 要点

- 自分の言葉で3〜7行。

## 具体的な値

- コマンド、フラグ、設定キー、環境変数、数値、バージョンを原文表記のまま。

## 関連ページ

- [[concepts/...]]

## 取り込みメモ

- 取得できなかった部分、不確かな点、推測にとどまる点。
