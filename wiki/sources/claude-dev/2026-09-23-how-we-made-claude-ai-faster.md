---
type: source
source_id: claude-dev
title: How we made claude.ai 3x faster in two weeks
url: https://claude.dev/blog/how-we-made-claude-ai-faster/
published: 2026-09-23
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# How we made claude.ai 3x faster in two weeks

## 要点

- 2026年8月の2週間で、claude.ai の web とデスクトップの主な操作を約3倍速くした。3,000を超える変更を、事故もロールバックも無しに入れた。
- 使った道具は **Claude Tag（ベータ）** で、Claude Code ではない。Opus 5.5 と同程度の社内の研究用モデルを、1つの Slack チャンネルから動かした。
- 計測の対象には Claude Code の新しいセッションの開始が含まれる（0.8秒から0.3秒、約2.7倍）。
- 進め方: 遅い箇所ごとにスレッドを開く → ベンチマークを作る → 変更をフラグの裏で入れる → デプロイを見る → ベンチマークの上限を下げる。

## 具体的な値

- 13の計測の平均で3.1倍速くなった（幾何平均）。
- 同時に動いた調査のスレッドは150を超えた。
- Datadog の MCP サーバーを使った。

## 関連ページ

- [[concepts/claude-tag]]

## 取り込みメモ

- Claude Code の機能やコマンドは出てこない。
