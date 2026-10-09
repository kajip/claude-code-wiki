---
type: source
source_id: claude-blog
title: Customize Claude Code with mods
url: https://claude.com/resources/articles/claude-code-mods
published: 2026-10-01
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Customize Claude Code with mods

## 要点

- mods は、Claude Code の動きや見た目を変える小さな TypeScript の関数。プラグインに入れて配り、プラグインと同じ方法で入れる。
- プロンプトの書き換え、ツール呼び出しの拒否・書き換え・再試行、許可の判断、ツール出力からの秘密情報の除去、UI の置き換え、組み込み機能の差し替えができる。
- 組み込みの `/diff` 機能も mod になっており、`/plugin` で無効にしたり置き換えたりできる。
- CLI とデスクトップアプリで、公開日から使える。ベータやプレビューの表記は無い。
- **サンドボックスは無い**。Claude Code と同じ権限でマシンにアクセスするので、信頼できる提供元のものだけを入れるよう書かれている。
- Team／Enterprise と managed settings のある端末では、組み込みの `sec-default` mod が最初に読み込まれ、利用者が入れた mod の危険な操作（deny ルールの上書きなど）を止める。

## 具体的な値

- 同じイベントに複数の mod がある場合は読み込み順に動く。最初に読み込まれた mod が、最初にイベントを受け取り、最後に結果を受け取る。
- 配布: claude.ai/directory、CLI の `/plugin`。公開の申請は claude.ai/directory/manage。
- `sec-default` のソース: github.com/anthropics/claude-code/tree/main/mods
- 管理者は自分たちの mod を `sec-default` より先に読み込ませられる。その場合、制限を保つにはリストに `sec-default` も入れる。
- ドキュメント: code.claude.com/docs/en/plugins/mods/overview

## 関連ページ

- [[concepts/mods]]
- [[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]

## 取り込みメモ

- 対応バージョンは書かれていない（claude.dev の記事では 2.1.287 以降）。
