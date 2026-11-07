---
type: concept
title: fast mode
updated: 2026-11-07
sources:
  - sources/pricing/2026-11-07-pricing
  - sources/platform-docs/2026-11-07-fast-mode
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
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30
---

# fast mode

## 概要

同じモデルのまま出力を速く返すモード。Opus 5.5 では最大2.5倍速く、単価は高くなる（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。

## 現状（as of 2026-11-07）

- 価格ページ（2026-11-07 取得）は、Opus 5 と Opus 4.8 の fast mode だけを研究プレビューとし、Opus 5.5 は外れている。fast mode の価格は 200k 入力トークン超を含む**全コンテキスト**に掛かる。入力／出力は Opus 5.5 が $8／$40、Opus 5 と Opus 4.8 が $10／$50。提供先は Claude API（first-party）と、Opus 5.5 に限り Claude Models on Google Cloud（Anthropic managed）および Microsoft Foundry（Azure ホスト）。Batch API では使えない。キャッシュとデータ所在地の倍率は重ねて掛かる（[[sources/pricing/2026-11-07-pricing]]）。
- platform-docs の fast mode ページ（2026-11-07 取得）の対応表も同じ: Opus 5.5 は Claude API、Claude Models on Google Cloud（Anthropic managed）、Microsoft Foundry（Azure ホスト）で「Available」。Opus 5 と Opus 4.8 は Claude API のみで研究プレビュー。Opus 5 を使うには担当者への連絡かウェイトリストが必要。Priority Tier の契約とは併用できず、Batch API でも使えない。Opus 4.8 の fast mode は 2026-11-30 に削除（[[sources/platform-docs/2026-11-07-fast-mode]]）。
- **Claude Platform on AWS と Bedrock での扱い**: 価格ページの提供先にも、fast mode ページの対応プラットフォーム（Claude API、Google Cloud（Anthropic managed）、Foundry）にも載っていない。「使えない」と明言した記述は見つからず、載っていないだけなので、使えるかどうかは**未確認**（[[sources/pricing/2026-11-07-pricing]]、[[sources/platform-docs/2026-11-07-fast-mode]]）。
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
- Claude Code の CHANGELOG は、**Opus 4.8 の fast mode を 2026-10-30 付けで非推奨**とし、**2026-11-30 に削除**すると記載（2.1.316）。削除後、Opus 4.8 の fast mode リクエストはエラーになり、標準の Opus 4.8 にはフォールバックしない。Opus 5.5 への移行で高速化を維持できる（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- **Claude Platform のリリースノート（10-30）が Opus 4.8 の fast mode の非推奨を確認**。2026-11-30 に削除し、以降 `claude-opus-4-8` への `speed: "fast"` はエラーを返す。移行先は Opus 5.5（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。
- Claude Models on Google Cloud（Anthropic managed）でも Opus 5.5 の fast mode が使える（10-22）（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。価格ページの 10-22 取得版は「パートナーのクラウドでは使えない」としていたが、11-07 取得版で明記された（下の未解決を参照）。

## 変更履歴

- 2026-11-07 — 価格ページと fast mode ページを再取得。提供先に Claude Models on Google Cloud（Anthropic managed）の Opus 5.5 が明記された。10-22 版の要約にあった「Claude Platform on AWS とパートナーのクラウドでは使えず」は原文の言い切りではなかったため、「一覧に載っていない。AWS は未確認」に修正した（古い記述は上の現状から差し替え、ここに記録）。単価は変更なし。価格ページの Haiku 3.5 の行は消えた（[[sources/pricing/2026-11-07-pricing]]、[[sources/platform-docs/2026-11-07-fast-mode]]）
- 2026-10-30 — Opus 4.8 の fast mode を非推奨、2026-11-30 に削除（platform-docs で確認）（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）
- 2026-10-22 — Claude Models on Google Cloud（Anthropic managed）で Opus 5.5 の fast mode が使えるように（[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）
- 2026-10-31 — 2.1.316: Opus 4.8 の fast mode を非推奨（2026-10-30 付け）、削除は 2026-11-30 と発表（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」1 件を直前の出典のリンクに展開、出典の無かった 1 行に出典を付与。内容の変更なし
- 2026-10-22 — 価格ページが更新され、Opus 5.5 の fast mode が研究プレビューから外れた（Opus 5 と Opus 4.8 は研究プレビューのまま）。全コンテキストに fast mode の料金が掛かる旨も明記（[[sources/pricing/2026-10-22-pricing]]）
- 2026-10-20 — 2.1.304: `/fast` ダイアログの Opus 5.5 から "(research preview)" を削除（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-15 — Opus 5.5 の fast mode が研究プレビューを脱し、申請とベータヘッダーが不要に。Microsoft Foundry でも提供（[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）
- 2026-08-14 — （公開時点）キャッシュと fast mode の関係を説明する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-09-22 — Claude API で Opus 5.5 の fast mode を研究プレビューとして提供開始（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-06 — 2.1.290: Claude Tag で fast mode に対応（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- 解決済み（2026-11-07）: 価格ページ 10-22 版の「fast mode はパートナーのクラウドでは使えない」と、10-22 のリリースノートの「Google Cloud（Anthropic managed）で Opus 5.5 の fast mode が使える」の食い違い → 価格ページ 11-07 版と fast mode ページが Google Cloud（Anthropic managed）での提供を明記し、解消。Anthropic 運営のクラウド（Google Cloud (Anthropic managed)、Foundry）と、パートナー運営（Google managed、Bedrock）は価格ページで区別されている（[[sources/pricing/2026-11-07-pricing]]、[[sources/platform-docs/2026-11-07-fast-mode]]）。
- 未確認: Claude Platform on AWS で fast mode が使えるか。価格ページにも fast mode ページにも載っておらず、不可とも書かれていない。
- 解決済み（2026-10-22）: 価格ページ（2026-10-10 取得）は Opus 5.5 の fast mode を研究プレビューとしていたが、10-15 のリリースノートで脱していた。価格ページの 10-22 版が更新され、Opus 5.5 は研究プレビューから外れて食い違いは無くなった（[[sources/pricing/2026-10-10-pricing]]、[[sources/pricing/2026-10-22-pricing]]、[[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]）。
- 解決済み（2026-10-10）: 研究プレビューを終えたかどうか → 価格ページでは研究プレビューのまま（[[sources/pricing/2026-10-10-pricing]]）。
- 解決済み（2026-11-02）: Opus 4.8 の fast mode の非推奨・削除は CHANGELOG のみの記載で、価格ページ（10-22 取得）は Opus 4.8 を研究プレビューの対象に載せたままだった。platform-docs のリリースノート 10-30 が非推奨と 2026-11-30 の削除を確認したため、platform-docs を正として閉じる。価格ページは 10-22 取得で 10-30 より前の版（時点の差）。次回の pricing 取り込みで Opus 4.8 の行が更新されるか確認する（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]、[[sources/pricing/2026-10-22-pricing]]、[[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]）。
