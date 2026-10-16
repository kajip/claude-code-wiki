---
type: concept
title: Claude Code の品質低下報告と原因（2026年3〜4月）
updated: 2026-10-10
sources:
  - sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports
---

# Claude Code の品質低下報告と原因（2026年3〜4月）

## 概要

2026年3〜4月に「Claude Code の応答が悪くなった」という報告が続き、Anthropic は3つの別々の変更が原因と結論した。API と推論層は影響を受けていない。3件とも 2026-04-20（v2.1.116）までに解消済み（[[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]]）。

## 現状（as of 2026-10-10）

- 3件とも解消済み。以下のモデル名・既定値は**公開時点（2026-04-23）の値**で、現在の仕様は別ページを参照（[[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]]）。
- 変更1（effort の既定）: 3/4 に high → medium、4/7 に戻し、Opus 4.7 は `xhigh`、ほかは `high` が既定になった（公開時点）。Sonnet 4.6 と Opus 4.6 に影響。現在の既定は [[concepts/effort]] を参照。
- 変更2（thinking の削除バグ）: 1時間以上アイドルのセッションで古い thinking を消す最適化（`clear_thinking_20251015`、`keep:1`）が毎ターン働き、物忘れ・繰り返し・キャッシュミスを招いた。3/26 に導入、4/10（v2.1.101）に修正。Sonnet 4.6 と Opus 4.6 に影響。
- 変更3（冗長さを抑えるプロンプト）: 4/16 に追加、4/20 に取り消し。後の ablation で eval が3%低下。Sonnet 4.6、Opus 4.6、Opus 4.7 に影響。
- 再発防止: システムプロンプト変更ごとにモデル別 eval と ablation、モデル固有の変更はそのモデルに限定、soak 期間と段階的ロールアウト、公開ビルドの社内利用拡大、Code Review の改善（同）。

## 変更履歴

- 2026-04-23 — 原因と対策を Engineering 記事で公表。全購読者の使用上限をリセット（[[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]]）
- 2026-04-20 — 変更3を取り消し。3件すべてが解消（v2.1.116）（同）
- 2026-04-16 — 変更3を Opus 4.7 とともに投入（同）
- 2026-04-10 — 変更2を v2.1.101 で修正（同）
- 2026-04-07 — 変更1を戻す（同）
- 2026-03-26 — 変更2を投入（同）
- 2026-03-04 — 変更1を投入（同）

## 未解決・矛盾

- （なし）
