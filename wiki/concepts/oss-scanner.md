---
type: concept
title: OSS Scanner（オープンソース向け脆弱性発見サービス）
updated: 2026-10-10
sources:
  - sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source
  - sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission
  - sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities
  - sources/research/2026-10-09-investigating-unintended-model-actions
---

# OSS Scanner（オープンソース向け脆弱性発見サービス）

## 概要

OSS プロジェクトが任意で参加すると、Anthropic の最も強いモデルによる定期的なセキュリティスキャンを無償で受けられるサービス。報告はモデルが生成し、人のレビューを経ない（[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]）。

## 現状（as of 2026-10-10）

- 費用は無償。使うモデルは Claude Mythos を含む最も強いモデル（[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]）。
- 提供の段階: 数十のプロジェクトで数週間検証したあと、より多くのプロジェクトへ提供中。参加は適格なプロジェクトの core maintainers が GitHub リポジトリへ PR で申し込み、案件ごとに判断される。基準は OSS-Fuzz に近い（同上）。
- 報告は reproducer、説明、候補パッチ付き。誤りや無効な報告がありうると明記されている（同上）。
- 検証: 専門家が 97 件を確認し 85 件（88%）が CVD の基準を満たした。false positive は 1 件（同上）。
- 人が検証した報告を送る既存の CVD は続く。OSS Scanner は報告をすぐ受け取りたい人向けの任意の fast-track（同上）。
- 関連: Claude Security は企業向けの一般提供のコードスキャン・パッチ製品。Claude for OSS は Claude Max 20x を無償で提供する（同上）。
- Cyber Mission の発表では OSS Scanner が無料の定期スキャンとして紹介され、真陽性率の見込みは 90% 超とされた（[[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]）。

## 変更履歴

- 2026-10-09 — 関連コンテンツ欄に出ていた。内容の追加は無い（[[sources/research/2026-10-09-investigating-unintended-model-actions]]）
- 2026-10-08 — OSS Scanner を公開し、参加プロジェクトの受け付けを始めた（[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]）
- 2026-09-29 — 研究記事の関連コンテンツ欄に名前が出ていた（[[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）

## 未解決・矛盾

- 真陽性率: Cyber Mission の発表は「90% 超の見込み」、研究記事の実測は critical／high の 88%（CVD 基準）。指標の定義が違う可能性があり、同じ数字とは限らない（推測）。
- Claude Security の価格・提供範囲は、この記事には書かれておらず未確認。
