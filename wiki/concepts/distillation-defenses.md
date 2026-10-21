---
type: concept
title: 蒸留攻撃への対策（distillation defenses）
updated: 2026-10-21
sources:
  - sources/anthropic-news/2026-10-12-distillation-defenses
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities
---

# 蒸留攻撃への対策（distillation defenses）

## 概要

蒸留攻撃は、不正なアカウント網を使って Claude の能力を大量に抜き取り、別のモデルに複製する行為。最も価値が高いのは推論（thinking）の記録なので、Anthropic の対策は推論に近づけなくすることに集中している（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。API 利用者には、preserved thinking と、推論の抽出を狙う依頼の遮断・課金という形で見える。

## 現状（as of 2026-10-21）

- 3つの柱: 推論の行き先の制御、2段 classifier による遮断、繰り返しの試行の抑止（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。
- preserved thinking: 2026-08-31 以降に作られた新規 API アカウントは、過去のコンテキストを編集できない。Fable 5.1 と Opus 5.5 で導入（同上）。Opus 5.5 の発表記事も同じ日付を挙げている（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- Sonnet 5.5 では、推論記録は依頼した組織だけが読める（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。Sonnet 5.5 の発表記事は、thinking が作ったアカウントに結び付くと説明している。Claude Code でセッション中にアカウントを切り替える場合に影響する（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。
- 2段 classifier の対象: Sonnet 5.5、Opus 5 と 5.5、Fable 5 と 5.1。誤検知率 0.1% 未満（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。
- 課金: 応答前に遮断された依頼のうち、`bio`、`frontier_llm`、`reasoning_extraction` の3分類は課金される（2026-09-24 から）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。記事は同じ日付の再開を、誤検知率 0.1% 未満の分野（蒸留を含む）への措置と説明している（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。
- 効果（Anthropic の推計）: 蒸留者が抜き取った推論トークンは 1/10〜1/100 以下。数万のアカウントを停止（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。
- 開発者への影響: preserved thinking により、一部の開発者は連携の更新が必要（同上）。

## 変更履歴

- 2026-10-12 — 対策の全体像と効果を公開（取り込みは 2026-10-21）（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）
- 2026-09-28 — Sonnet 5.5 で preserved thinking を拡大（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）
- 2026-09-24 — 遮断された依頼への課金を再開（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-22 — Opus 5.5 で preserved thinking（2026-08-31 以降のアカウント）（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）

## 未解決・矛盾

- Claude Code のセッション運用（コンテキストの編集、アカウント切り替え、compaction など）への影響は、記事には書かれていない。docs や platform-docs の preserved thinking の記載を確認する必要がある。
- 効果の数値は Anthropic 自身の推計で、独立した検証はない。記事も長期の効果は未確定と述べている（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。
