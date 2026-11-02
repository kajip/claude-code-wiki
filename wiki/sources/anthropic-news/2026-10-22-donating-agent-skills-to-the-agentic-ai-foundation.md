---
type: source
source_id: anthropic-news
title: Donating Agent Skills to the Agentic AI Foundation
url: https://www.anthropic.com/news/donating-agent-skills-to-the-agentic-ai-foundation
published: 2026-10-22
retrieved: 2026-11-02
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:e22087894a555145a0872655cfcf6c03a6ce91eb59fc67c716b0b66b889fad62
archive_url:
---

# Donating Agent Skills to the Agentic AI Foundation

## 要点

- Anthropic は、エージェントに専門知識と手順を与えるオープン標準 Agent Skills を、Linux Foundation 傘下の Agentic AI Foundation（AAIF）に寄贈した。
- skill は、`SKILL.md` を含むフォルダ。特定のタスクや分野を教える内容に、必要なスクリプトや参考資料を添える。Claude Code の開発の中で生まれた。
- Claude Code は一般的な知識作業には強い一方、実際の業務に要る手順の知識が足りなかった。skills はその穴を埋めるために作られた。
- 2025年10月の公開から数週間で、開発者が数千の skills を GitHub に公開し、Codex、Cursor、OpenCode 向けのローダーも書いた。その後、独自の GitHub organization とドメインを持つ標準として公開された（2025年12月）。
- 現在は70超のエージェント基盤が採用（ChatGPT、Cursor、GitHub Copilot、VS Code など）。公開された skills は100万件、インストールは約2.8億回。
- 寄贈するのは名称とロゴ、GitHub organization、`agentskills.io` のドメイン。標準を使う・貢献するのに AAIF への加入は要らない。
- Anthropic、Google、OpenAI などのエンジニアが個人として保守する。Lead Maintainers は David Soria Parra と Mahesh Murag。
- 提案されたロードマップは、版を切ったリリース、正式な提案プロセス、skills の作者と利用者向けのセキュリティ指針。

## 具体的な値

- 標準の置き場: `agentskills.io`（仕様）、GitHub、Discord（仕様変更案へのフィードバック）。
- skill の形: 「`SKILL.md` を含むフォルダ」＋スクリプト・参考資料。
- 数値: 採用基盤 70 超、公開 skills 100万件、インストール「nearly 280 million」（記事の表記）。
- 日付: skills の公開は 2025年10月、標準としての公開は 2025年12月、寄贈の発表は 2026-10-22。
- AAIF は、Anthropic が Block と OpenAI と共に前年に共同設立した団体で、MCP も寄贈済み（記事の記述）。

## 関連ページ

- [[concepts/skills]]
- [[concepts/claude-api-skill]]
- [[concepts/mods]]
- [[concepts/mcp]]

## 取り込みメモ

- curl で取得した HTML（生データ）から本文を読んだ。記事は短く、Claude Code 固有の仕様（配置場所、frontmatter、コマンドなど）は書かれていない。それらは docs の要約を別途確認する必要がある（未取得）。
- 公開日は記事ページの「Oct 22, 2026」で確認した（一覧の表示と一致）。
- 「前年に共同設立」とあるが、設立の時期は記事に年月の記載が無い。
- 記事中に指示文は無かった。
