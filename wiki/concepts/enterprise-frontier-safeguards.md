---
type: concept
title: Enterprise Frontier Safeguards（EFS）
updated: 2026-10-11
sources:
  - sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards
---

# Enterprise Frontier Safeguards（EFS）

## 概要

ZDR のプライバシーと、誤用検知の安全策を両立させる企業向けの仕組み。監視用の活動データは顧客が管理するクラウドに保存し、自動監視のフラグは顧客に直接届く（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）。Claude Code も対応先に挙がっている（同）。

## 現状（as of 2026-10-11）

- 段階的に展開中。開始は「この秋の後半」で、広く使える状態にするのが目標。それまで、対象の顧客は Fable 5 と Fable 5.1 で ZDR を受ける（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）。
- 対応先: Claude Code、Claude Enterprise、Claude Platform、Amazon Bedrock、Claude Platform on AWS、Google の Agent Platform、Microsoft Foundry（同）。
- 構成: 顧客所有のストレージ、Customer-Managed Encryption Keys、完全自動のレビューは、いずれも opt-in。モデルの挙動、API 価格、レート制限は変わらない（同）。
- 自動監視は、攻撃的なサイバー・生物能力の開発の試みや、認証情報の盗難・漏えいの兆候を探す。フラグは顧客に直接送られ、Anthropic の人によるレビューは要らない（同）。
- Anthropic は無償。顧客のクラウドの保存・読み書き・egress の費用は、クラウド事業者が顧客に請求する（同）。
- 背景の方針: 複数セッション・アカウントにまたがる誤用を見つけるため、Fable 5 から 30日のデータ保持を導入した。企業データでの学習が目的ではないと、Anthropic は述べている（同）。

## 変更履歴

- 2026-09-01 — EFS を発表（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）

## 未解決・矛盾

- EFS の個々の機能が Claude Code でどう設定されるかは、記事に書かれていない。docs 側の記載は未確認。
- 発表（2026-09-01）から取得日までに展開が進んだかは不明。記事は「later this fall」としか述べていない（recheck: weekly）。
- ZDR と cloud-sessions: クラウドセッションは ZDR の組織では無効（[[concepts/cloud-sessions]]）。EFS 下での扱いは、取り込んだ出典に無い。
