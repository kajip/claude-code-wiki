---
type: source
source_id: anthropic-news
title: Introducing Claude Opus 5.5
url: https://www.anthropic.com/claude-opus-5-5
published: 2026-09-22
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Introducing Claude Opus 5.5

## 要点

- Claude 5.5 ファミリーの最初のモデル。多くの作業で Claude Fable 5.1 と同程度の性能で、Opus 5 より約40%安く動く。
- 出力の生成は Opus 5 より30%以上速い。
- Pro、Max、Team、席単位の Enterprise で、5時間ごとの利用上限が引き上げられた。契約者には、後で使えるレート制限のリセットも配られた。
- fast mode（最大2.5倍の速さ）は Claude Code と Claude Platform で使える。
- Fable 5.1 と同じ水準の bio とサイバーの安全策。サイバーの作業の多くは Opus 4.8 に回される。
- thinking モードは無効にできない。EU AI Act に対応するため、電子透かしを入れている。

## 具体的な値

- API モデル ID: `claude-opus-5-5`。全プラットフォームで提供。zero data retention に対応。
- 価格（100万トークンあたり。Opus 5.5／Opus 5）: 入力 $4／$5、出力 $20／$25、キャッシュ読み取り $0.20／$0.50、キャッシュ書き込み $5／$6.25。
- fast mode: 入力 $8、出力 $40。
- ベンチマーク（Opus 5.5／Fable 5.1／Opus 5）: Terminal-Bench 4.0 は 66.4%／55.8%／52.3%（公開リーダーボードの Claude Code ハーネスで計測）。FrontierCode v1.1（Main）は 54.4%／50.3%／48.0%。CursorBench 4.0 は 57.8%／51.8%／46.6%。OSWorld 2.1（partial）は 81.8%／80.7%／74.0%。
- 封じ込めの境界を回避しようとした頻度は、Opus 5 や Claude Mythos 5.1 より約85%少ない。
- preserved thinking は、2026-08-31 以降に作られた API アカウントに適用される。

## 関連ページ

- [[concepts/claude-opus-5-5]]
- [[concepts/fast-mode]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- コンテキスト長と最大出力は書かれていない。
- Cyber Verification Program を Opus 5.5 に広げる件は、公開時点では「数週間以内」とされていた。
