---
type: concept
title: Claude Haiku 5.5
updated: 2026-10-10
sources:
  - sources/pricing/2026-10-10-pricing
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296
---

# Claude Haiku 5.5

## 概要

Claude 5.5 ファミリーの小型モデル。2026-10-07 に発表された。量が多くコストに敏感な処理や、上位モデルの下で動くサブエージェントを想定している（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。

## 現状（as of 2026-10-10）

- API モデル ID は `claude-haiku-5-5`。全プラットフォームで提供（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
- 価格（100万トークンあたり。100K 以下／100K 超）: 入力 $0.10／$0.50、出力 $0.50／$2.50、キャッシュ書き込み（5分）$0.125／$0.625、（1時間）$0.20／$1、キャッシュヒット $0.01／$0.05（[[sources/pricing/2026-10-10-pricing]]）。プロンプトの長さには、キャッシュの読み書きも数える（同）。
- Haiku クラスで初めて effort を調整できる（同）。
- Claude Code は 2.1.293 で追加した。Anthropic API での既定の Haiku で、コンテキストは 1M（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。
- 複雑なエージェント型コーディングには、Sonnet 5.5 や Opus 5.5 の方が向くとされる（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。

## 変更履歴

- 2026-10-07 — 発表。Claude Code 2.1.293 で追加（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]、[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- Claude apps gateway の背景処理は、2.1.295 の時点でも「Haiku 4.5」を使うと書かれている（[[sources/gh-changelog/2026-10-09-v2-1-290-to-2-1-296]]）。Haiku 5.5 に切り替わる予定かどうかは不明。
