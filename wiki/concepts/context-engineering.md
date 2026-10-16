---
type: concept
title: コンテキストエンジニアリング（Claude 5 世代）
updated: 2026-10-11
sources:
  - sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5
---

# コンテキストエンジニアリング（Claude 5 世代）

## 概要

プロンプト以外に Claude が受け取るコンテキスト（システムプロンプト、skills、CLAUDE.md、記憶など）を設計すること。Anthropic は Claude 5 世代で、制約を減らして判断に任せる方針に転換した（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。

## 現状（as of 2026-10-11）

- Claude Code のシステムプロンプトの 80% 超を Opus 5 / Fable 5 向けに削除し、コーディング評価に測定可能な低下は無かった（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- 指針: 厳格なルールより判断に任せる。例よりツールのインターフェース設計。全部を先頭に置かず段階的開示（skills、deferred loading のツール）。ツール説明は簡潔にし、システムプロンプトで繰り返さない（同）。
- CLAUDE.md は軽く保ち、自明なことは書かず、コードベース固有の落とし穴に使う。検証手順などは skill に分けて CLAUDE.md から参照する（同）。
- 記憶は `#` による手動保存から、Claude の自動メモリへ（同）。
- 参照物は単純な markdown より、HTML artifacts、テストスイート、移植元コード、rubric など豊かなものを @ メンションで渡す（同）。
- `/doctor`（`claude doctor`）に上記の指針が入っており、skills と CLAUDE.md の整理に使える（同）。

## 変更履歴

- 2026-07-24 — 記事公開。Then/Now 形式で旧来の定石を見直し（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）

## 未解決・矛盾

- 記事の対象は Opus 5 / Fable 5。Opus 5.5 以降への適用は記事に明記なし。Opus 5.5 向けの書き方は [[concepts/claude-opus-5-5]] を参照（推測: 方針は同じ方向）。
- `/doctor` の挙動は docs 側で未確認。
