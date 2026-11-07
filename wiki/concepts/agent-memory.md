---
type: concept
title: エージェントのメモリと dreaming
updated: 2026-11-07
sources:
  - sources/docs/2026-11-07-memory
  - sources/engineering/2026-11-06-components-of-agent-memory
  - sources/docs/2026-10-10-claude-projects
---

# エージェントのメモリと dreaming

## 概要

エージェントのメモリは、Claude が経験から得て、セッションをまたいで読める形で保存した知識を指す。重みの変更、in-context learning、compaction は含めない（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。ログを後から見返してメモを直す・作る処理を「dreaming」と呼ぶ（同じ出典）。

## 現状（as of 2026-11-07）

- 書き込みは 2 通り。セッション中に Claude がメモを書く方法と、dreaming でオフラインに整理する方法。前者は主タスクから注意を奪い、後者は結果がすぐには使えない、というトレードオフが挙がっている（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- 新しいモデルほど何を残すかの判断が良く、検証済みの規則や現在の目標を少数のファイルに絞る。Pokémon Red で Sonnet 3.7 は 413 ファイルで 1 バッジ、Fable 5 は 9 ファイルで 4 バッジ（公開時点の記事の値）（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- 指示の出し方: 強いモデルには「メモリがある」程度の一般的な指示にとどめる。「失敗のみ記録」のような固定ルールは利得を減らした。古いモデル（Sonnet 4.6）には、読む・検証するよう促すと効いた。記事は、フロンティアのモデルには、頼まれたとき、または明らかに覚える価値があるときにメモを作る程度の指示を勧める（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- dreaming の用途: 誤ったメモの訂正（トランスクリプトを根拠に検証）、wiki の構築、上位層への昇格、目標に合わせた整理、複数セッションの穴埋め（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- wiki は検索と併用したときに効く。Stainless の文書 25 問で、dreaming を 2 から 128 セッションに増やすと 13% から 48%、検索＋wiki は 54% から 61%（検索のみ 53%）。単一文書で足りるタスクでは差が無く、wiki が元文書より大きくなる例もあった（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- 毎セッションに注入する上位層は小さく保つ。長い指示ファイルは遵守率が下がり、誤ったメモが全セッションに載るため（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- Claude Code の auto memory（記事の説明）: `MEMORY.md` の先頭 200 行または 25 KB だけを読み込み、その先頭部が索引になる（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。docs も同じ上限を述べる: `MEMORY.md` の先頭 200 行または先頭 25KB の先に達した方まで。それ以降は開始時に読まれない。上限は `MEMORY.md` のみで、CLAUDE.md は全文が読まれる（4 MiB 超は読まれない）。上限に近い／超えたときは Claude Code が短くするよう促す（[[sources/docs/2026-11-07-memory]]）。
- Claude Projects では project memory が `MEMORY.md` を索引とするファイル群で、Work locally のスレッドは memory ファイルを読み込まない（[[sources/docs/2026-10-10-claude-projects]]）。
- cookbook に dreaming と knowledge wikis の入門がある（記事より。URL は取得していない）（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。

## 変更履歴

- 2026-11-07 — Claude Code の docs（memory）を取り込み、auto memory の読み込み上限を照合。記事（200 行または 25 KB）と docs（200 lines or 25KB）は一致し、未解決を閉じた（[[sources/docs/2026-11-07-memory]]）
- 2026-11-07 — ページ作成。Engineering の記事「The components of agent memory」（2026-11-06）を反映（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。

## 未解決・矛盾

- 解決済み（2026-11-07）: auto memory の読み込み上限（200 行／25 KB）。記事の記述と docs の記述は一致した（[[sources/engineering/2026-11-06-components-of-agent-memory]]、[[sources/docs/2026-11-07-memory]]）。
- dreaming が Claude Code や Managed Agents の機能として提供されているかは、記事からは分からない（Managed Agents 上の評価で使われたことのみ記載）。提供状況は platform-docs で要確認。
