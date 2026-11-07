---
type: source
source_id: engineering
title: The components of agent memory
url: https://www.anthropic.com/research/components-of-agent-memory
published: 2026-11-06
retrieved: 2026-11-07
tier: primary
review: pending
recheck: none
fingerprint: 3f5fad614f1b6f072c1713a6e3ed8787d8770125b577ca0d59138d77d5fb440b
---

# The components of agent memory

## 要点

- 「エージェントのメモリ」を、Claude が経験から得て、セッションをまたいで読める形（メモ、フォルダ、DB など）に保存した知識と定義する。重みの変更、in-context learning、compaction は含めない。
- 記事は、リアルタイムの記録（セッション中にメモを書く）と、オフラインの整理（「dreaming」。ログやトランスクリプトを後で見返してメモを直す・作る）を対にして考える。dreaming は Letta と UC Berkeley の sleep-time compute の発想を借りたもの。
- Claude は何を保存すべきかの判断（salience）が上達した。CL-Bench と Pokémon Red の評価で、新しいモデルほど検証済みの規則や目標だけを少数のファイルに残す。Sonnet 3.7 は 413 ファイルを書いて 1 バッジ、Fable 5 は 9 ファイルで 4 バッジ。
- 強いモデルには「メモリフォルダがある」程度の一般的な指示が効き、「失敗だけ記録せよ」のような固定ルールは利得を減らした。古いモデル（Sonnet 4.6）には、読む・理論を検証するよう促すと効いた。
- dreaming の用途は 5 つ。誤ったメモの訂正、wiki など新しい表現の構築、上位層（毎回読み込む層）への昇格、目標に合わせた整理、複数セッションにまたがる穴埋め。
- Claude Code の auto memory は、`MEMORY.md` の先頭 200 行または 25 KB だけを読み込む索引として説明されている。

## 具体的な値

- CL-Bench 1.0（Claude Managed Agents 上で実行）: Sonnet 4.6 は未検証の推測を並べる段階、Opus 4.7 はノートを 1 つに統合して確認済みかどうかを印付け、Sonnet 5 は採点後に confirmed を付けて誤答時に訂正を書く。Opus 5 が最初にループを閉じ（規則とその根拠、過去の答え、罠の警告）、Opus 5.5 と Sonnet 5.5 も閉じた。メモリあり時のスコアは Opus 5 とほぼ同じ。メモリなしの基準は Opus 5.5 と Sonnet 5.5 の方がやや高い。
- Pokémon Red（約 10,000 ステップ時点）: Sonnet 3.7 は 413 ファイル・225 フォルダ・1 バッジ。Fable 5 は 9 ファイル・2 フォルダ＋ `global.md`・4 バッジ。Opus 5.5 も小さなフォルダで現在の目標と次の手順を書き換えながらクリアした。Fable 5 のフォルダ構成は `global.md`（ダッシュボード）、`locations`、`gameplay`。
- 指示の効果: Sonnet 4.6 に「回答前にメモリを読む」「理論を検証する」を促すとスコアがほぼ倍になった。Sonnet 5 は促さなくても 10 回中 9 回、回答前に読んだ（Sonnet 4.6 は半分未満）。「record only failures」の規則は Opus 5 と Opus 4.7 のメモリによる利得を大きく減らした。
- dreaming による訂正（Pokémon の Mt. Moon）: 訂正なしでは同じ道に 3 回落ち、Cerulean City に着かずに終わった。dreaming で訂正すると洞窟に戻って Cerulean City に着いた。
- wiki の評価: Stainless の社内文書（約 350,000 ファイル、約 420M トークン）、25 問。Opus 5 のエージェントが 128 セッション、共有ログで協調して wiki を作成。dreaming を 2 セッションから 128 セッションに増やすと、採点基準に対する達成率が 13% から 48% へ。wiki のみで最高 48%。検索のみ 53%、検索＋wiki は 54% から 61%（wiki の成長に伴う）。検索＋wiki では 1 問あたり約 20,000 トークンの節約。
- 合併案件の 24 問: 複数文書をまたぐ問いで wiki 参照 87%、検索のみ 73%。Harvey LAB の一部タスクでは差が出ず、別のタスクでは wiki が元文書より大きくなった。
- 契約条項のタスク: 共有表に複数エージェントが書くと 57 件中 41 件（72%）が残った。契約 1 件につき 1 エージェント・1 ページで条項を原文のまま引用する指示に変えると 57 件中 57 件（100%）。指示の改善は「失敗を振り返り→指示を修正→wiki を再構築」のループで見つけた。
- 第 2 回の dreaming で、存在しないページへのリンク 9 件を既存ページに付け替え、索引を含む 3 ページを追加した例がある。
- 上位層への昇格（context injection）: 注入したメモはトークンを使い、誤ったメモが全セッションに持ち越される。記事は Claude Code の docs を引き、長い指示ファイルは遵守率を下げると述べる。最上位層を小さく保つため、詳細を下の層に移してリンクを残す。
- Claude Code の auto memory: 注入層を小さく保つ。全部は読み込まず、`MEMORY.md` の先頭 200 行または 25 KB のみ。この先頭部が索引になる。
- 参照されたもの: 付属の cookbook（「getting started with dreaming」「knowledge wikis」）。Claude Duet（人に合わせて整理するアシスタントの例）。

## 関連ページ

- [[concepts/agent-memory]]
- [[concepts/context-engineering]]
- [[sources/docs/2026-10-10-claude-projects]]（project memory は `MEMORY.md` を索引とする、との記述）
- [[sources/engineering/2026-04-08-scaling-managed-agents]]

## 取り込みメモ

- curl（User-Agent は変更せず）で記事ページ本体の HTML を取得でき、本文も入っていた（WebFetch は不要）。fingerprint はこの HTML の sha256。HTML 全体のため、ページの更新やスクリプトの差で値が変わりうる。
- 公開日 Nov 6, 2026 は記事ページ上の表示で確認した。チーム表示は Engineering、執筆は Lance Martin。
- 図（Figure 1〜15）は画像で、本文と図のキャプションのみ読んだ。図中の数値は未確認。
- 記事は「Claude Opus 5.5」「Sonnet 5.5」「Fable 5」「Claude Duet」などに触れる。Claude Duet は wiki 内に要約が無く、製品の位置づけは未確認。
- 記事内に指示文は見当たらなかった。
- auto memory の 200 行／25 KB は、記事の記述のみ。docs 側の要約が wiki に無いため、docs との照合は未了。
