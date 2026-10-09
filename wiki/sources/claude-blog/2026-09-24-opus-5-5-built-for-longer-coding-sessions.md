---
type: source
source_id: claude-blog
title: Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.
url: https://claude.com/resources/articles/claude-opus-5-5-built-for-coding-sessions-that-use-more-context
published: 2026-09-24
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.

## 要点

- 2026年3月から9月にかけて、Claude Code のセッションは長くなり、1回のリクエストのコンテキストも大きくなった。
- そのため、キャッシュ読み取りの単価が下がったことの効果が大きい（Opus 5.5 ではキャッシュ読み取りが60%安くなった）。
- Opus 5.5 と Fable 5.1 では、セッションの途中で effort を変えてもキャッシュがリセットされない。
- fork したサブエージェントは、親のキャッシュから始まる。
- 推奨: `/usage` でキャッシュ読み取りの割合を確認する。モデルはセッションの最初に選ぶ。離席の前に compact する。

## 具体的な値

- 1プロンプトあたりの作業時間は3.3倍、モデル呼び出しは40%以上増えた。中断は68%減った。
- 1リクエストあたりのコンテキストは2.6倍。入力と出力のトークン比は 189:1 から 324:1 になった。
- キャッシュに当たらない入力は50%以上減った。
- API キーやクラウドプロバイダーの利用者も、1時間のキャッシュ寿命を設定できる。サブスクリプションの利用者は以前から使えた。

## 関連ページ

- [[concepts/claude-opus-5-5]]
- [[concepts/prompt-caching]]
- [[concepts/effort]]

## 取り込みメモ

- コンテキストウィンドウの大きさは書かれていない。
