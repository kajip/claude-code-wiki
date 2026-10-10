---
type: concept
title: 長時間動くエージェントのハーネス
updated: 2026-10-10
sources:
  - sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes
  - sources/engineering/2026-03-24-harness-design-long-running-apps
  - sources/research/2026-10-01-claude-shaped-science
---

# 長時間動くエージェントのハーネス

## 概要

人が付き添わずに、エージェントを長時間動かし続けるための足場（ループ、同期、テスト、記録、役割分担）の設計。取り込み済みの出典は2本で、2026-02-05 の C コンパイラ実験（[[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]）と、2026-03-24 の generator と evaluator を分ける設計の記事（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）。どちらも半年以上前の公開で、モデルは当時のもの。

## 現状（as of 2026-10-10）

2026-02-05 の記事（Opus 4.6 の時点）:

- 単一セッションは人の入力待ちで止まるため、タスクが終わると次を取る単純なループでハーネスを組んだ。コンテナ内で動かす前提（[[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]）。
- 並列化は、コンテナごとのクローンと、git 上のロックファイル（`current_tasks/`）で衝突を避ける。オーケストレーション用のエージェントも、エージェント間の別の通信手段も使わない（同上）。
- 成否を分けるのは、ほぼ完全なテスト、コンテキストを汚さない出力、時間感覚の欠如を補うサンプル実行（`--fast`）、README と進捗ファイルによる自己オリエンテーション（同上）。
- 作業が単一の巨大タスクになると並列化が効かない。既知の正しい実装（GCC）をオラクルにして作業を分割した（同上）。
- 役割を分けた専門エージェント（重複除去、性能、コード品質、ドキュメント）を置ける（同上）。
- 限界: モデルの能力の上限に近づくと、新機能が既存機能を壊す。自律開発では、テストが通っても完了とは限らない（同上）。
- 費用の規模: 約 2,000 セッションで $20,000 弱（公開時点）（同上）。

2026-03-24 の記事（Sonnet 4.5、Opus 4.5、Opus 4.6 の時点の知見）:

- 長いタスクの失敗は2系統。コンテキストが埋まると一貫性が落ちる（モデルによっては「context anxiety」で早く切り上げる）ことと、自己評価が甘いこと（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）。
- context reset（空の窓で新しいエージェントに構造化した引き継ぎ）は compaction（その場の要約）と違い、clean slate を与える。Sonnet 4.5 では reset が必須だったが、Opus 4.5 で context anxiety がほぼ消え、reset なしで SDK の自動 compaction による連続セッションにできた（同上）。
- 作る役と評価する役を分ける。評価役の調整は「作る役を自己批判的にする」より扱いやすい。ただし評価役も LLM なので甘さは残り、ログを読んで判断のずれを直す調整が要る（同上）。
- 主観的な品質は、原則を符号化した採点基準（design quality、originality、craft、functionality）で採点可能にする。基準の言い回し自体が出力の傾向を変える（同上）。
- 構成は planner（1〜4 文を仕様に展開。技術の細部は固定しない）、generator（1 機能ずつ）、evaluator（Playwright MCP で実アプリを操作）。sprint ごとに done の定義を事前に合意し、通信はファイル経由（同上）。
- 費用の例（公開時点）: Opus 4.5 でレトロゲームメーカーを作ると、単独 20 分 $9、フルハーネス 6 時間 $200。単独は中核機能が壊れ、ハーネスは動いた（同上）。
- Opus 4.6 では sprint 分割を外し、evaluator を最後の1回にしても、ブラウザ DAW を 3 時間 50 分、$124.70 で作れた（同上）。evaluator は、タスクがモデルの単独で確実にできる範囲を超えるときに価値がある（同上）。
- 設計原則: ハーネスの各部品は「モデルにできないこと」の仮定であり、新モデルが出たら 1 部品ずつ外して再検証する（同上）。
- 2026-10 の実践例: Claude Code のセッションをプロジェクトごとに分け、全体を束ねるマスターセッション（調整、計算資源の割り当て、検証）と、執筆、検証、敵対的な査読の専用セッションを置いた。compaction で文脈を失うため計画ファイルを定期的にまとめ直させ、時間の見積もりは人が補った（[[sources/research/2026-10-01-claude-shaped-science]]）。

## 変更履歴

- 2026-10-01 — Claude Code の複数セッションによる研究での実践例が公開された（[[sources/research/2026-10-01-claude-shaped-science]]）
- 2026-03-24 — generator と evaluator の分離、planner を加えた3エージェント構成、モデル更新に伴う簡素化が公開された。モデル名と費用は公開時点の値（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）
- 2026-02-05 — agent teams による C コンパイラ構築の実験とハーネス設計の学びが公開された（[[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]）

## 未解決・矛盾

- 2026-03 の記事の「Opus 4.5 以降は reset が不要」「Opus 4.6 では sprint が不要」は当時のモデルについての観察。現行モデル（2026-10 時点）での再検証は取り込んでいない。
- 2026-02 の方式（並列セッションとロックファイル、評価役なし）と 2026-03 の方式（役割分担の直列的な協調）の優劣は、どちらの記事も比較していない。題材も違う。
- Claude Code の製品機能（サブエージェントなど）との関係は未確認。2026-03 の記事は Claude Agent SDK と Playwright MCP で組んだ自作ハーネスの話。
