---
type: source
source_id: engineering
title: Redesigning source control at Anthropic
url: https://www.anthropic.com/engineering/redesigning-source-control
published: 2026-10-13
retrieved: 2026-10-21
version:
tier: primary
review: pending
recheck: none
fingerprint: 646fa4294a5bf5e063ba845287af1c6acbf465901147a5e128a5a2602a232906
archive_url:
---

# Redesigning source control at Anthropic

## 要点

- Anthropic ではコードを書くこと自体はもはやボトルネックではなく、source control、ビルド、CI といった人間規模の開発基盤が詰まりどころになった。1日のマージ数は 2026年5月の約 2,500 件から 9月には 30,000 件超に増えた。
- 巨大 monorepo が git の設計（分散・オフライン前提）に合わなくなったため、社内製の VCS「Scion」を作り、5か月で git から完全移行した。クライアントのほぼ全てが常時オンラインのエージェントやジョブである点を前提にした設計。
- 設計原則は、常時オンライン、クライアントとサーバーの非対称（コミット・マージ・rebase・blame はサーバー側）、API で何でも問える、全コンポーネントが水平スケール、コミットは安価でロック不要、作業コピーは任意かつ sparse。
- 効果は、インフラ規模が従来の git ミラー群の 200分の1（CPU・メモリ換算）、チェックアウトが2桁速い（分から秒）、CI の CPU 容量で 25% の改善。
- 開発は7人のチームで、Claude（Claude Mythos Preview、Claude Tag）を使って進めた。エンジニアの役割は設計判断と Claude への「No」に移った。一般向けに Scion を提供する予定はなく、git サーバー側の改善への示唆として共有する、という立場。
- Claude Code との直接の関係は薄い。Topics に Claude Code が付いているが、本文に Claude Code の機能や仕様の記述はない。

## 具体的な値

- マージ数: 2026年5月 約 2,500 件/日、9月 30,000 件/日超。
- monorepo: main の履歴だけで約 100 GB、圧縮した作業コピーが 25 GB 超。CI のチェックアウトは1日約 2,500 万回で、素朴に fetch すると 1日 600 PB 超（原文は over 600 PB of git traffic per day）。
- 従来のピーク時の git ミラーは数百台。
- Scion のキャッシュ階層は各層でヒット率 99% 超。
- Scion の構成要素: `scn`（クライアント）、`scion-daemon`（ノード単位でオブジェクトを保持）、`scion-cache`（リージョン単位のキャッシュ）、`scion-server`（権威。Spanner とクラウドストレージを読む）。3層は同一の RPC に応答し、階層は障害ドメイン分離のため厳格に強制する。
- データ構造: 変更セット（changeset）は write-ahead log の1エントリで、第1親からの変更ファイル一覧と、blob storage 上の内容アドレス指定されたポインタを持つ。ref の移動は Spanner の1行に対する compare-and-swap。blame やパス履歴などは「derived data」として再帰的に計算する。
- コードレビュー面は `Antique`。Scion と Antique を7人で作り、5か月で移行した。
- Claude Mythos Preview の初期の社内スナップショットに git から Scion への ingestion パイプラインを書き直させたところ、メモリ 20分の1、速度 4倍で、暗黙の不変条件も保たれた。
- 運用: Slack に特定コンポーネント専任の Claude「superfan」（scion-daemon、scion-cache、Antique merge queue など）を置き、テレメトリとログを監視させる。
- merge queue のグローバルロックは再現できず、マージ後およびデプロイ前の自動テストに投資した。衝突は Claude が修正する。
- 公開日 2026-10-13、更新 2026-10-15（更新内容は、Scion の技術の源流となったプロジェクトの追記。脚注で Sapling のサーバー Mononoke と Bonsai データモデルに言及）。

## 関連ページ

- [[concepts/claude-tag]]（Claude Tag を運用監視に使う記述がある。反映の候補）

## 取り込みメモ

- 記事ページの HTML を curl で取得し、fingerprint を付けた。
- 日付は記事ページの 2026-10-13 を採用した。一覧によっては 10-19 と出る。
- 図版と図中の数値は読んでいない（本文のみ）。
- ページ内に指示文は無かった。
- Claude Mythos Preview と Claude Tag の公開時期は本記事からは分からない。「同時期に社内で使えるようになった」との記述のみ。
