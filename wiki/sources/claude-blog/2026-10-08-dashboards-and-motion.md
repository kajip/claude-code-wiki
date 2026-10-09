---
type: source
source_id: claude-blog
title: Build live dashboards and animate explainers with Claude
url: https://claude.com/resources/articles/dashboards-and-motion
published: 2026-10-08
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# Build live dashboards and animate explainers with Claude

## 要点

- **Claude Dashboards（ベータ）**: 社内データにつながり、最新の状態に保たれるダッシュボードを作る。数値ごとにクエリへのリンクがあり、グラフごとに最終更新時刻が出る。
- **Claude Motion（ベータ）**: プロンプトから短いアニメーションの解説を作り、MP4 で書き出せる。動画生成モデルは使わず、コードとしてアニメーションを描く。
- Docs、Slides、Design はベータを終え、Free を含む全プランで一般提供になった。
- Design は Claude の会話の中で使えるようになった。単独のサイト claude.ai/design は12月14日まで残る。
- タグに Claude Code が含まれるが、本文の中心は Claude アプリの artifact 機能。

## 具体的な値

- Dashboards: 有料プラン、ベータ。接続先は Amazon Redshift、BigQuery、ClickHouse、Databricks、Snowflake、Salesforce。
- Motion: Team と Enterprise、ベータ。メッセージ欄で `/motion` を使う。
- Enterprise の管理者: Dashboards と Motion は既定で無効。Organization settings > Artifacts で有効にする。Docs、Slides、Design は10月15日に既定で有効になる。
- Artifacts の CMEK に対応。

## 関連ページ

- （Claude Code 固有の概念ページは無し）

## 取り込みメモ

- 「迷ったら取り込む」に従って取り込んだ。Claude Code での使い方は書かれていない。
- ベータの機能を含むため `recheck: weekly`。
