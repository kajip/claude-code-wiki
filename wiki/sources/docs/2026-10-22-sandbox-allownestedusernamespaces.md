---
type: source
source_id: docs
title: sandbox.allowNestedUserNamespaces（Settings reference と Sandboxing の該当部分）
url: https://code.claude.com/docs/en/settings-reference.md
published: unknown
retrieved: 2026-10-22
version: 2.1.305
tier: primary
review: pending
recheck: none
fingerprint: sha256:f94dece81575479b27a94d4d4f158ed0f30d5fceff45488a9d76540caa83e35a
archive_url:
---

# sandbox.allowNestedUserNamespaces（Settings reference と Sandboxing の該当部分）

## 要点

- Linux と WSL2 で、サンドボックス内のコマンドにユーザー名前空間の作成を許す Boolean。Chromium／Electron 自身のサンドボックス、入れ子の bubblewrap、`unshare` が必要とする。v2.1.305 以降。
- `true` にするとセキュリティ境界を外すことになり、サンドボックス内のコマンドのコードがサンドボックスの外で動きうる。保護パスと `credentials.files` を当てにできず、auto-allow mode では確認なしで走りうる。
- 既定は `false`。`true` が効くのは `~/.claude/settings.json`、`--settings`、managed 設定。プロジェクトの `.claude/settings.json` と `.claude/settings.local.json` の `true` は無視される。`CLAUDE_CODE_SUBPROCESS_ENV_SCRUB=1` のセッションでは、どこの `true` も無視される。`false` は任意のファイルから効く。
- rootless Podman／Buildah には、この設定だけでは足りない。docs は `excludedCommands` を使うよう案内する。CHANGELOG（2.1.305）は rootless podman 向けと書いており、この点で食い違う。

## 具体的な値

- 設定キー: `sandbox.allowNestedUserNamespaces`（Boolean、既定 `false`、スコープは User or managed）。
- `unshare` で始まるコマンドは、`excludedCommands` の書き方によらずサンドボックス内に留まる。
- 管理者向け: 開発者が有効にできるキーの一覧に載り、リポジトリ側からは有効にできない。managed 設定で `false` にして使わせないことができる。
- Chromium が `No usable sandbox!` で終了するときの対処は、`--no-sandbox` での起動、またはこの設定。

## 関連ページ

- [[concepts/sandboxing]]
- [[sources/docs/2026-10-10-sandboxing]]
- [[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]

## 取り込みメモ

- 取得: `https://code.claude.com/docs/en/settings-reference.md`（fingerprint）と `https://code.claude.com/docs/en/sandboxing.md`（sha256: 828837815ef9675a7154c48f38980247ed4b4c8532e728c004768b5aee3dd972）を curl で取得。該当部分だけ要約した。
- 依頼文は「sandboxing.md に記載が無い」としていたが、2026-10-22 の取得時点では記載がある（Protected paths の警告、管理者向けの一覧、トラブルシュート節）。
- ページに日付の記載が無いため `published: unknown`。
- ページ内に、読み手への指示文は見つからなかった。
