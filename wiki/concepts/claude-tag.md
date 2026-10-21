---
type: concept
title: Claude Tag（Claude in Slack）
updated: 2026-10-21
sources:
  - sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci
  - sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/gh-changelog/2026-10-18-v2-1-302
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
---

# Claude Tag（Claude in Slack）

## 概要

Slack から Claude を動かす機能。Claude Code そのものではないが、Claude Code の CHANGELOG に `[Claude Tag]` の項目として更新が載る（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-16）

- Slack Connect チャンネルに対応（2.1.300）。Owner か Claude Tag admin が、他の組織と共有するチャンネルで Claude が答えるのを許可できる。既定はオフ。admin がチャンネルに付けた access bundle は、Slack Connect 化しても引き続き有効（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- コネクタ操作で承認が要るとき、Slack のスレッドに自分にだけ見える Allow once／Deny カードが出る。ほかの人には「待っている」ことだけが見える（2.1.300）。Slack の音声クリップは、Slack が文字起こしを持っていれば Claude が読む（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- 100 人超のチャンネルへは紹介メッセージ無しで参加する。誤りの訂正は取り消し線でなく、メッセージをその場で編集し短い "Edited" を付ける。Claude が作った canvas を頼まれれば削除できる（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

- 2026-09-23 の記事の時点では**ベータ**。社内では、claude.ai を速くする取り組みを1つの Slack チャンネルから動かした（[[sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster]]）。
- `!fast`／`!fast off` で fast mode を切り替える（2.1.290）。`!fork` でスレッドを分ける。`@Claude !status` で状態を確認する（2.1.292）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- チャンネルのルールの上限は、ワークスペースごとと組織全体でそれぞれ50（2.1.293 で 20 から変更）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- Claude Tag Admin 権限のあるメンバーは、ワークスペースとチャンネルのメモリファイルを Activity ページの Memory タブで編集できる（2.1.296）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

- 社内版の Claude Tag で長時間動かしたセッションに、CI のテスト選択サービスを監視させた例がある（[[sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci]]）。

**2.1.302 の CHANGELOG（2026-10-17）**

- 管理設定で Claude のアクセスを 4 タブ（Bundles、Connectors、Skills and plugins、Channels）に整理。manager ロールが Slack での Claude Tag も許可する。同一ホストの MCP サーバーのカスタムコネクタは、サーバーごとに別コネクタとして表示。リポジトリ検索は接続済み GitHub アカウント最大 100、GitHub App のインストールの 5,000 件超の private リポジトリにも対応（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- Slack: HEIC／SVG／TIFF／BMP の添付がファイルとして Claude に届く。一時的な Slack 参照の停滞で DM を落とす問題は、先に再試行する。Enterprise Grid の DM は最後に Claude を開いた接続済みワークスペースで動く。チャンネルの月間利用上限の通知は organization owner と usage ページを案内（同）。
- ほか表示の修正多数（"is thinking…" の残留、コードブロック内 URL、リンクの終端）。

**2.1.304〜2.1.305 の CHANGELOG（公開時点の記述）**

- 2.1.304: チャンネルが Enterprise Grid の複数 workspace に共有されたときに黙る問題を修正（1 回だけ新しいスレッドで @ するよう通知）。スレッド外の `@Claude !fork` に、スレッド内で実行するよう伝える非公開メッセージを返す（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 2.1.305: 管理画面の Add の検索で、Claude が未参加の公開 Slack チャンネルも出る。access bundle で別の GitHub アカウントに移ったリポジトリを再追加できる。Slack スレッドの routine が、別の routine による会話再開の後や、会話終了後に投稿されない問題を修正（終了後の実行はスキップし、作成者に通知）。大きな組織で、チャンネル一覧の読み込み中でも plugin、skill、bundle を編集できる（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。

## 変更履歴

- 2026-10-20〜10-21 — 2.1.304〜2.1.305: Enterprise Grid 共有時の沈黙、`!fork` の案内、管理画面の公開チャンネル検索、スレッド routine の投稿の修正（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-17 — 2.1.302: 管理設定の 4 タブ化、コネクタのサーバー別表示、Slack の添付・DM・通知の修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-10-14 — 2.1.300: Slack Connect 対応、Allow once／Deny カード、音声クリップ対応など（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — 2.1.296: メモリファイルの編集を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-08 — 2.1.293: チャンネルのルールの上限を 50 に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-06 — 2.1.290: `!fast` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- 提供の段階（ベータかどうか、どのプランか）を正式に書いた一次情報は、まだ取り込んでいない。
