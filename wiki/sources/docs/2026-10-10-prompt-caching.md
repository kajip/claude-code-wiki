---
type: source
source_id: docs
title: How Claude Code uses prompt caching
url: https://code.claude.com/docs/en/prompt-caching
published: unknown
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:de13a11825487ea2e021d861db0c83e238a80258b5cbb4296fad23341850a034
archive_url:
---

# How Claude Code uses prompt caching（必要な箇所のみ）

## 要点

- Claude Code はプロンプトキャッシュを自動で管理する。
- 多くのモデルでは、effort の段階ごとに別のキャッシュを持つ。そのため、途中で effort を変えると次のリクエストはキャッシュに当たらない。キャッシュがまだ温かいうちは、Claude Code が変更の前に確認を求める。
- **Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 を API キーか Claude のサブスクリプションで使う場合は、effort を変えてもキャッシュが残る**。このとき Claude Code は確認せずに新しい段階を適用する。
- この例外は、Amazon Bedrock、Google Cloud's Agent Platform、Claude apps gateway では効かない。`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` を設定した場合と、組織が HIPAA の構成の場合も効かない。
- 推奨: モデルと effort はセッションの最初に決め、`/compact` は作業の区切りで使う。

## 具体的な値

- v2.1.260 より前は、Fable 5.1 でも effort を変えるとキャッシュが無効になっていた。
- 環境変数 `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS`

## 関連ページ

- [[concepts/prompt-caching]]
- [[concepts/effort]]

## 取り込みメモ

- 取り込んだのは effort とキャッシュに関わる節（「Changing effort level」ほか）だけ。モデルの切り替え、`/compact` の費用、TTL の選び方などは未読。
- ページに日付は無い。raw の Markdown（URL の末尾に `.md`）を curl で取得した。
