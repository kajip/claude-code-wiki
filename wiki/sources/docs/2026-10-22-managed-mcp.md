---
type: source
source_id: docs
title: Control MCP server access for your organization
url: https://code.claude.com/docs/en/managed-mcp.md
published: unknown
retrieved: 2026-10-22
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:02baf70310d9028d77764e3e5d40f83473fdf72a4fec855e25312c8c52a51077
archive_url:
---

# Control MCP server access for your organization

## 要点

- 組織が MCP サーバーを制限・配布する方法の docs。固定セットを配る `managed-mcp.json`、ユーザーのサーバーと併用する `managedMcpServers`、絞り込みの `allowedMcpServers`／`deniedMcpServers` を扱う。
- `allowedMcpServers` は `managed-mcp.json` のサーバーには原則かからない。例外は、定義に `${VAR}` 展開を使うサーバーで、これは allowlist で検査される（v2.1.259 以降。それ以前は全 managed サーバーが allowlist を通る必要があった）。
- 検査対象になる欄は command、args、`env`、URL、headers のどれか。`${VAR}` を使わない managed サーバーだけが検査を免れる。
- `deniedMcpServers` は managed サーバーにも効き、denylist に一致したものは読み込まれない。何にも上書きされない。
- 2.1.305 の CHANGELOG にある「`env` だけに `${VAR}` を使う stdio サーバーは絞り込まれない」という変更への言及は、このページには無い。

## 具体的な値

- 検査の順序: 1. リストの統合、2. denylist、3. allowlist。`type: "sdk"` のプロセス内サーバーは3つとも免除。
- allowlist を免れるもの: `managedMcpServers` の全エントリ、`${VAR}` 展開を使わない `managed-mcp.json` のエントリ、組み込みサーバー（Claude in Chrome、`ide` など）、Claude Tag セッションの Slack ツール。
- 「`managed-mcp.json` のサーバーを `allowedMcpServers` で止めていた場合、v2.1.259 以降の初回起動から（`${VAR}` 展開を使わない限り）通知なしで読み込まれる。`deniedMcpServers` で止める」との注意書きがある。
- 許可の強制: `allowedMcpServers` と `allowManagedMcpServersOnly: true` を managed 設定源に置く。読み取りには v2.1.273 以降。
- `serverCommand`／`serverUrl` は展開してから照合。`serverName` は展開しない。

## 関連ページ

- [[concepts/mcp]]
- [[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]

## 取り込みメモ

- curl で取得した raw の Markdown（約 45 KB）。ページに日付の記載が見つからないため `published: unknown`（ファイル名は取得日）。
- 更新日が読めないため、2.1.305（2026-10-21）より前の版か後の版かは不明。docs が 2.1.305 の変更を反映していないのか、CHANGELOG の記述が限定的なのかは判断できない。
- ページ内に、読み手への指示文は見つからなかった。
