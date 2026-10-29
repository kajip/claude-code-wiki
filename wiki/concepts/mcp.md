---
type: concept
title: MCP（Model Context Protocol）
updated: 2026-10-22
sources:
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/gh-changelog/2026-10-18-v2-1-302
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/docs/2026-10-22-managed-mcp
---

# MCP（Model Context Protocol）

## 概要

Claude Code が外部のツールやデータにつなぐためのプロトコル。この期間に、プロトコル 2026-07-28 を既定でネゴシエーションするよう順次切り替わった（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-22）

- **allow ルールの変更（非互換の可能性、2.1.299）**: MCP の allow ルールは、名前を指したサーバーだけに効く。`mcp__a` は `a__b` や `a_` というサーバーを許可しなくなった。サーバーの正規化後の名前全体で `mcp__<server>__*` と書く。agent の `tools:` リストも同様で、`__` を含む名前のサーバーは `mcp__<whole name>__*` と書く。従来 `mcp__a` で複数のサーバーを一括許可していた設定は、許可されなくなる可能性がある（推測: 影響は名前に `__` や末尾の `_` を含むサーバーがある場合）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- deny／ask ルール（`mcp__<server>`）が、正規化後の名前に `__` を含むサーバーに効かなかった問題を 2.1.299 で修正。名前が `constructor`／`prototype` のサーバーが接続されない問題と、`constructor`／`toString` のツールが auto／bypass で確認を求める問題も修正（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- プロトコル既定: cloud session と Remote Control のコネクタは、フラグを取得しない環境でも 2026-07-28 を既定でネゴシエーションする。`MCP_PROTOCOL_NEGOTIATION=legacy` で無効（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- `api.anthropic.com` の第一者 MCP サーバーのツール説明とサーバー指示は、4,096 字で切られず全文が Claude に届く（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- claude.ai のコネクタプロキシ、Anthropic ホストの MCP サーバー、クラウド／self-hosted runner の MCP プロキシへのリクエストは、HTTP リダイレクトに従わない（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- ポリシーで拒否されるサーバーは、起動・接続する前に blocked と報告される（`claude mcp list`／`get`、サブエージェント、headless／SDK に追加したサーバー）（2.1.299）。入力スキーマを API が拒否した MCP ツールは、以後その会話ではパラメータ無しで送られる（2.1.300）。compaction 後に接続したサーバーのツールと指示は、次のツール呼び出しを待たずに Claude に伝わる（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- 以下は 2026-10-10 時点の記述（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）:
- ローカル（stdio）のサーバーは、すべての環境でプロトコル 2026-07-28 を既定でネゴシエーションする（2.1.292）。claude.ai のコネクタも同じ（2.1.295）。`MCP_PROTOCOL_NEGOTIATION=legacy` で元に戻せる（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 最初に送るツール説明とサーバー指示の上限は 4,096 字（2.1.296）。tool search 経由で読み込む説明は 16,384 字（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- WebSocket（`ws`）のサーバーで 16 MiB を超えるメッセージを受け取ると、接続を閉じる（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- キャッシュを保つため、MCP をセッションの途中からつながないこと、使わないサーバーは切ることが推奨されている（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- 2.1.302（2026-10-17）: プロトコル 2026-07-28 をネゴシエーションするが `resultType`、`ttlMs`、`cacheScope` を返さないサーバーで、ツールが表示されない／全呼び出しが失敗する問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- **managed サーバーと `allowedMcpServers`（docs の規則）**: `allowedMcpServers` は `managed-mcp.json` のサーバーには原則かからない。例外は、command、args、`env`、url、headers のどれかで `${VAR}` 展開を使うサーバーで、これは allowlist で検査される（2.1.259 以降）。検査されないのは `${VAR}` を使わない managed サーバーだけ。`deniedMcpServers` は managed サーバーにも効き、何にも上書きされない（[[sources/docs/2026-10-22-managed-mcp]]）。2.1.305 の CHANGELOG はこれと食い違う記述があり、未解決（下の「未解決・矛盾」）。
- cloud session や SDK の `setMcpServers` で渡した MCP サーバーが、後から自分の設定の同名サーバーに置き換えられる問題を修正（2.1.305）。MCP の同意ダイアログは、プロンプト向けの Enter を Accept と取りにくくした（2.1.305）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- cloud session の最初のターンは、claude.ai から同期したプラグインのローカル（stdio）MCP サーバーを待たない。サーバーが `alwaysLoad: true` を指定する場合を除く（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- カスタム `ANTHROPIC_BASE_URL` 配下では tool search が既定でオンになった（2.1.304）。ゲートウェイが拒否する環境で全リクエストが失敗する回帰が出て、tool search 抜きで再試行するよう 2.1.305 で修正した（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。

## 変更履歴

- 2026-10-22 出典の表記を整理（Lint）: 出典の無かった 1 行に出典を付与。内容の変更なし
- 2026-10-22 — docs の managed-mcp ページを取り込み、`${VAR}` を使う managed サーバーは allowlist で検査される、という docs の規則を `## 現状` に採用。2.1.305 の CHANGELOG の記述は未解決に移した（[[sources/docs/2026-10-22-managed-mcp]]）
- 2026-10-21 — 2.1.305: CHANGELOG によると `allowedMcpServers` が `managed-mcp.json` の stdio サーバー（`${VAR}` を `env` のみに使うもの）を絞り込まなくなった（docs と食い違い、未解決。allowlist 漏れが読み込まれうる）。`setMcpServers` のサーバーが置き換えられる問題を修正。2.1.304: stdio サーバーを待たない cloud session の最初のターン、tool search の既定オン（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-17 — 2.1.302: 2026-07-28 で `resultType`／`ttlMs`／`cacheScope` を省くサーバーの問題を修正（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-10-14 — 2.1.299: allow ルールを名前指定のサーバーだけに限定（非互換の可能性）。agent の `tools:` も同様。cloud／Remote Control のコネクタの 2026-07-28 既定をフラグ未取得の環境にも拡大。第一者サーバーの説明の 4,096 字切り詰めを廃止（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — 2.1.296: 最初に送るツール説明の上限を 2,048 字から 4,096 字に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: claude.ai のコネクタも 2026-07-28 を既定に。tool search 経由の説明の上限を 2,048 字から 16,384 字に変更（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: stdio のサーバーで 2026-07-28 を既定に（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）

## 未解決・矛盾

- **`allowedMcpServers` と `${VAR}`（セキュリティに関わる。2.1.305）**: CHANGELOG は「`managed-mcp.json` の stdio サーバーで `${VAR}` を `env` にだけ使うものは `allowedMcpServers` が絞り込まなくなった。allowlist に載せていなかったサーバーがアップグレードで読み込まれる。止めるには `deniedMcpServers`」と書く（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。一方 docs（2026-10-22 取得）は、`${VAR}` を command、args、`env`、url、headers のどれかで使う managed サーバーは allowlist で検査される、検査されないのは `${VAR}` を使わないものだけと書き、2.1.305 の変更に触れていない（[[sources/docs/2026-10-22-managed-mcp]]）。`env` だけに `${VAR}` を使うサーバーがどちらの扱いか不明。CHANGELOG が正しければ、allowlist 漏れのサーバーが通知なしで読み込まれる（推測: docs が未更新の可能性）。運用上は、止めたいサーバーに `deniedMcpServers` を入れておくのが確実（docs と CHANGELOG の両方が denylist は効くとしている）。
