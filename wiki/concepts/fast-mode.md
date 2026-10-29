---
type: concept
title: fast mode
updated: 2026-10-22
sources:
  - sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/pricing/2026-10-22-pricing
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

## 現状（as of 2026-10-22）

- 価格ページ（2026-10-22 取得）も、Opus 5 と Opus 4.8 の fast mode だけを研究プレビューとし、Opus 5.5 は外れた。fast mode の価格は 200k 入力トークン超を含む**全コンテキスト**に掛かる。入力／出力は Opus 5.5 が $8／$40、Opus 5 と Opus 4.8 が $10／$50。Claude API（first-party）で使え、Opus 5.5 は Microsoft Foundry（Azure ホスト）でも使える。Claude Platform on AWS とパートナーのクラウドでは使えず、Batch API でも使えない。キャッシュとデータ所在地の倍率は fast mode の価格に重ねて掛かる（[[sources/pricing/2026-10-22-pricing]]）。
- **Opus 5.5 の fast mode は 2026-10-15 に研究プレビューを脱した**。アクセス申請は不要で、`fast-mode-2026-02-01` ベータヘッダーも不要（付けても動く）。Start／Build／Scale の usage tier に既定のレート制限が付く。Opus 5 と Opus 4.8 は研究プレビューのままで、ヘッダーが必要（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- Claude in Microsoft Foundry（Azure ホスト）でも Opus 5.5 の fast mode が使える（10-15）（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- Claude Code の `/fast` ダイアログから、Opus 5.5 の "(research preview)" ラベルが消えた（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 以下の「研究プレビュー」の記述は、Opus 5.5 については 10-15 より前の状態（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- Opus 5.5 の fast mode: 入力 $8、出力 $40（100万トークンあたり）。Claude Code と Claude Platform で使える（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]、[[sources/pricing/2026-10-10-pricing]]）。
- 価格ページの **2026-10-10 の値（更新前）**: **研究プレビュー**。対象は Opus 5.5、Opus 5、Opus 4.8。API では Claude API（first-party）だけで使え、Batch API では使えない（[[sources/pricing/2026-10-10-pricing]]）。
- Opus 5.5 の公開時点では**研究プレビュー**。extra usage を有効にしておく必要がある。Claude Code では `/fast` で有効にする（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- キャッシュを保つため、セッションの最初に有効にすることを推奨（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- （公開時点 2026-08-14 の説明）fast mode はキャッシュのキーに含まれ、途中で有効にすると再処理が fast mode の価格で行われる。有効にするなら最初に。無効に戻すときはキャッシュ上の費用は無い（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）。
- Sonnet 5.5 には fast mode が無い（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- Claude Tag（Slack）でも `!fast`／`!fast off` で切り替えられる（2.1.290）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 変更履歴

- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」1 件を直前の出典のリンクに展開、出典の無かった 1 行に出典を付与。内容の変更なし
- 2026-10-22 — 価格ページが更新され、Opus 5.5 の fast mode が研究プレビューから外れた（Opus 5 と Opus 4.8 は研究プレビューのまま）。全コンテキストに fast mode の料金が掛かる旨も明記（[[sources/pricing/2026-10-22-pricing]]）
- 2026-10-20 — 2.1.304: `/fast` ダイアログの Opus 5.5 から "(research preview)" を削除（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-15 — Opus 5.5 の fast mode が研究プレビューを脱し、申請とベータヘッダーが不要に。Microsoft Foundry でも提供（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）
- 2026-08-14 — （公開時点）キャッシュと fast mode の関係を説明する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-09-22 — Claude API で Opus 5.5 の fast mode を研究プレビューとして提供開始（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-06 — 2.1.290: Claude Tag で fast mode に対応（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- 解決済み（2026-10-22）: 価格ページ（2026-10-10 取得）は Opus 5.5 の fast mode を研究プレビューとしていたが、10-15 のリリースノートで脱していた。価格ページの 10-22 版が更新され、Opus 5.5 は研究プレビューから外れて食い違いは無くなった（[[sources/pricing/2026-10-10-pricing]]、[[sources/pricing/2026-10-22-pricing]]、[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- 解決済み（2026-10-10）: 研究プレビューを終えたかどうか → 価格ページでは研究プレビューのまま（[[sources/pricing/2026-10-10-pricing]]）。
