---
type: source
source_id: claude-blog
title: Code Review is now generally available
url: https://claude.com/resources/articles/code-review-is-now-generally-available
published: 2026-10-15
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:7bb809fcf9841456391f8a292f954351b17fd5457644f0194953ed77124786da
archive_url:
---

# Code Review is now generally available

## 要点

- Code Review が研究プレビューを終え、一般提供（GA）になった。対象は Claude Team と Enterprise の組織。
- GA に向けた改善は3点。速度（多くのレビューがプレビュー時の約20分から6〜10分に、約3倍速）、品質（重要なバグをより多く検出し、問題・発動条件・修正を数文で示す簡潔な指摘）、柔軟性（管理者がリポジトリごとに Quick / Standard（既定）/ Deep を選べる）。
- 導入手順: 管理者が Claude Code の設定で Code Review を有効にし、GitHub App をインストールして対象リポジトリを選ぶ。開発者側は設定不要で、有効化後は新しい PR に対して自動でレビューが走る。
- 適格な Claude Enterprise 組織は、2027-01-15 までに少なくとも $10,000 分の Code Review クレジットを申請できる（申請後30日で失効。利用条件あり）。
- Anthropic 自身も社内の PR で Code Review を使っている。プレビュー利用者の要望は「より静かに、変更の大きさに見合った量で、より速く」だった。

## 具体的な値

- 公開日: October 15, 2026（メタデータは 2026-10-15）。読了時間 3 min。カテゴリ: Announcements / Product / Claude Code。
- 提供: "Team and Enterprise plans"。
- モード: Quick / Standard (default) / Deep（リポジトリごとに管理者が選択）。
- 速度: ~20 minutes → 6-10 minutes（プレビュー比で約3倍速）。
- クレジット: Enterprise は at least $10,000、申請期限 January 15, 2027、申請後30日で失効。
- 有効化: Claude Code settings → GitHub App のインストール → リポジトリ選択。

## 関連ページ

- [[concepts/code-review]]
- [[sources/docs/2026-10-16-code-review]]

## 取り込みメモ

- 取得は curl（HTML）。本文は静的 HTML から抽出して読んだ。一覧の日付 2026-10-15 は記事ページのメタデータと一致。
- 記事内の仕様・提供範囲は docs を正とする（確認結果は概念ページ参照）。クレジットの詳細は記事が参照する support.claude.com のページにあるが、sources.md 対象外のため未取得。
- ページ内に取り込み担当への指示文は無かった。
