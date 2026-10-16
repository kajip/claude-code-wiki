---
type: source
source_id: claude-dev
title: The new rules of context engineering for Claude 5 generation models
url: https://claude.dev/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models/
published: 2026-07-24
retrieved: 2026-10-11
version:
tier: ok
review: pending
recheck: none
fingerprint: 567cbcc5bc9481a658ad3cc27a67f02b9ce732b6ca53aa5f06f7b241cbd14bf4
archive_url:
---

# The new rules of context engineering for Claude 5 generation models

著者は Thariq Shihipar（Anthropic）。読了目安 7 分。

## 要点

- Claude Code のシステムプロンプトの 80% 超を、Claude Opus 5 と Claude Fable 5 向けに削除した。コーディング評価に測定できる低下はなかったという。
- 原因は過剰な制約。システムプロンプト、skills、ユーザーの依頼が互いに矛盾する指示（例: 「ドキュメントを適宜残す」と「コメントを書くな」）を生み、モデルがその調停に思考を使っていた。
- 旧来の定石を「Then → Now」で見直している: ルール → 判断に任せる、例 → インターフェース設計、全部を最初に置く → 段階的開示、繰り返し → 簡潔なツール説明、CLAUDE.md への記憶 → 自動メモリ、単純な spec → 豊かな参照物。
- 実践: CLAUDE.md は軽くし、コードベース固有の落とし穴（gotchas）に使う。skills は軽いガイドにして分割する。参照物は @ メンションで渡し、コードで書かれたもの（HTML のモックアップなど）を優先する。
- これらの指針は `claude doctor`（Claude Code 内では `/doctor`）に組み込まれ、skills と CLAUDE.md の整理を支援する。

## 具体的な値

- 削除量: システムプロンプトの「over 80%」。対象モデルは「Claude Opus 5 and Claude Fable 5」（5.5 ではない）。
- 旧システムプロンプトの例: コードのコメントは原則書かない、複数段落の docstring を書かない、計画・判断・分析の文書は頼まれない限り作らない。新しい文は「コードは周囲のコードに合わせて書く（コメント密度、命名、慣用句）」という趣旨。
- 例を与えると探索空間が制約される。代わりにパラメータを表現力のある形にする。Todo ツールでは status を `pending` / `in_progress` / `completed` の列挙にするだけで使い方が伝わり、「`in_progress` は1件」という指示が望む挙動を定める。
- 段階的開示: 検証とコードレビューの手順を専用 skill に分離。一部のツールは deferred loading（`ToolSearch` で完全な定義を検索してから使う）で、Task ツール群が必要になるまでコンテキストを占めない。
- 旧: `#` ホットキーで CLAUDE.md に書き込む。新: Claude が関連する記憶を自動で保存する（auto-memory）。
- 参照物: 新機能 artifacts の HTML、詳細なテストスイート、別コードベースの関数、rubric（検証 agent を立てて好みを検証）。
- コマンド: `/doctor`（`claude doctor`）。
- 記事の末尾に「Fable field guide」への言及あり（リンク先は未取得）。

## 関連ページ

- [[concepts/context-engineering]]
- [[concepts/claude-opus-5-5]]

## 取り込みメモ

- 公開日は記事ページの「Jul 24, 2026」。一覧の日付と一致。
- 記事のモデルは Opus 5 と Fable 5 であり、Opus 5.5 より前の公開（推測: 5.5 世代にも当てはまると思われるが、記事は明言していない）。
- `/doctor` や `claude doctor` の挙動の詳細は記事に無い。docs 側の記載は未確認。
- ページ内に指示文は無かった。
