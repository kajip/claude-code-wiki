---
type: concept
title: fast mode
updated: 2026-10-21
sources:
  - sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
---

# fast mode

## 概要

同じモデルのまま出力を速く返すモード。Opus 5.5 では最大2.5倍速く、単価は高くなる（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

## 現状（as of 2026-10-21）

- **Opus 5.5 の fast mode は 2026-10-15 に研究プレビューを脱した**。アクセス申請は不要で、`fast-mode-2026-02-01` ベータヘッダーも不要（付けても動く）。Start／Build／Scale の usage tier に既定のレート制限が付く。Opus 5 と Opus 4.8 は研究プレビューのままで、ヘッダーが必要（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- Claude in Microsoft Foundry（Azure ホスト）でも Opus 5.5 の fast mode が使える（10-15）（同）。
- Claude Code の `/fast` ダイアログから、Opus 5.5 の "(research preview)" ラベルが消えた（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 以下の「研究プレビュー」の記述は、Opus 5.5 については 10-15 より前の状態。
- Opus 5.5 の fast mode: 入力 $8、出力 $40（100万トークンあたり）。Claude Code と Claude Platform で使える（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]、[[sources/pricing/2026-10-10-pricing]]）。
- 価格ページでは、2026-10-10 時点でも**研究プレビュー**。対象は Opus 5.5、Opus 5、Opus 4.8。API では Claude API（first-party）だけで使え、Batch API では使えない（[[sources/pricing/2026-10-10-pricing]]）。
- Opus 5.5 の公開時点では**研究プレビュー**。extra usage を有効にしておく必要がある。Claude Code では `/fast` で有効にする（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- キャッシュを保つため、セッションの最初に有効にすることを推奨（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- （公開時点 2026-08-14 の説明）fast mode はキャッシュのキーに含まれ、途中で有効にすると再処理が fast mode の価格で行われる。有効にするなら最初に。無効に戻すときはキャッシュ上の費用は無い（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）。
- Sonnet 5.5 には fast mode が無い（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Claude Tag（Slack）でも `!fast`／`!fast off` で切り替えられる（2.1.290）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-20 — 2.1.304: `/fast` ダイアログの Opus 5.5 から "(research preview)" を削除（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-15 — Opus 5.5 の fast mode が研究プレビューを脱し、申請とベータヘッダーが不要に。Microsoft Foundry でも提供（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）
- 2026-08-14 — （公開時点）キャッシュと fast mode の関係を説明する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-09-22 — Claude API で Opus 5.5 の fast mode を研究プレビューとして提供開始（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-06 — 2.1.290: Claude Tag で fast mode に対応（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- 価格ページ（2026-10-10 取得）は Opus 5.5 の fast mode を研究プレビューとしているが、10-15 のリリースノートで脱した。仕様は platform-docs を正とするため、リリースノートを採用。価格ページが更新されたかは未確認（[[sources/pricing/2026-10-10-pricing]]、[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- 解決済み（2026-10-10）: 研究プレビューを終えたかどうか → 価格ページでは研究プレビューのまま（[[sources/pricing/2026-10-10-pricing]]）。
