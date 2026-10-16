---
type: source
source_id: docs
title: Code Review
url: https://code.claude.com/docs/en/code-review
published: unknown
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:e27d0098417de60dc9792fdc86087415970e88a8fdfca60c6b9b3207d39bc5d6
archive_url:
---

# Code Review（docs 概要ページ）

## 要点

- GitHub の PR を Claude がレビューする。複数のエージェントが差分と周辺コードを並列に調べ、検証ステップで誤検出を除き、重複排除・重大度順位付けをして、インラインコメント、要約、チェックランを PR に投稿する。
- レビューは PR を承認もブロックもしない。マージの判断はチーム側に残る。
- 既定では正しさ（本番で壊れるバグ）に絞る。調整は `REVIEW.md` と `CLAUDE.md` で行う。
- レビューレベルは Quick（最速・最安）/ Standard（既定）/ Deep（最も徹底、最も遅く高コスト）。Owner が組織の既定を選び、リポジトリごとに上書きできる。モデルは Code Review 側が選び、管理設定に選択肢は無い。
- 実行は Anthropic のインフラ上。リポジトリへのアクセスは読み取り専用で、コードのビルドや実行はしない。セルフホスト環境では動かない。

## 具体的な値

- 提供: Team and Enterprise。GitHub（GitHub Enterprise Server、データレジデンシー付き GitHub Enterprise Cloud を含む）。
- 非対応: Zero Data Retention 有効、HIPAA 構成の組織、BAA 対象外、CMEK 利用組織（"isn't yet available"）。
- チェックラン名: **Claude Code Review**（失敗として終了しない）。指摘なしのときのタイトルは **Code review found no issues**。
- 実行タイミング（リポジトリごと）: PR を開いたとき1回 / push のたび / 依頼時のみ。書き込み権限のある人が `@claude review` とコメントして開始できる。ドラフトとフォークは自動実行の対象外。
- `REVIEW.md` は base または既定ブランチのものを読み、PR 自身の変更からは読まない。
- 他の手段: `/code-review`（任意のプランで手元のセッション）、Ultrareview、GitHub Actions / GitLab CI/CD、自作のサブエージェントやスキル。
- 関連ページ（未取得）: code-review-setup、code-review-customize、code-review-pull-requests、code-review-troubleshooting、code-review-costs。

## 関連ページ

- [[concepts/code-review]]
- [[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]

## 取り込みメモ

- `.md` 版を curl で取得（概要ページのみ。下位ページと料金・費用の詳細は未取得）。ページに日付表示が無いため published は unknown。ファイル名には取得日を使った。
- ページ内に取り込み担当への指示文は無かった。
