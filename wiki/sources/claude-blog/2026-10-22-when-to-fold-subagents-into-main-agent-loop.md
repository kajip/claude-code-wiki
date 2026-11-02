---
type: source
source_id: claude-blog
title: "Building agents: When to fold subagents into your main agent loop"
url: https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop
published: 2026-10-22
retrieved: 2026-11-02
version:
tier: primary
review: pending
recheck: none
fingerprint: 4e4bf99a7714858086572107b805c37191a70986314e1afcf2ca5927813ec469
archive_url:
---

# Building agents: When to fold subagents into your main agent loop

著者 Diane Sarkis、読了目安 18 分、カテゴリは Best practices／Perspectives、製品タグは Claude Platform。対象は Claude Code ではなく Claude Platform で作るエージェント。

## 要点

- Applied AI チームが複数の企業導入を比べたところ、ルーター、プランナー、領域別サブエージェントを main loop に畳んだ「skills 付きの単一エージェント」が、サブエージェント構成より品質で上回ることが多く、費用と遅延も下がることが多かった。ある顧客は単一ループで実行時間が約 2 倍速くなった。
- サブエージェントを残す条件は3つ。(1) 単一ループでコンテキスト肥大による性能低下が測定できる、(2) 破棄できる新しいコンテキストで並列に進めたい、(3) ツール選択が不安定、またはシステムプロンプトの指示が衝突している。
- 大企業で起きがちな失敗: コンテキストの受け渡しでの欠落、サブエージェントの乱立、チームごとに一文ずつ足して矛盾する「Frankenprompt」、局所的すぎる eval、遅延。組織図がそのままエージェント構成になる（コンウェイの法則）と警告している。
- 単一ループが成立する理由: 共有コンテキストが良い答えを生む／skills とツール検索による段階的開示でコンテキスト肥大を防げる／モデルが強くなった（Opus 4.5 以降。Opus 5.5 と Fable 5.1 は thinking を切れない）。Claude Code のシステムプロンプトを先進モデル向けに 80% 超削減した例にも触れる。
- 移行は段階的に: 小さな end-to-end eval を作る、結合の強い専門家を統合する、サブエージェントを tool として呼ぶ形にして基準を取る、1つずつ skills と MCP tools に畳んで比較する。サブエージェントを畳むと、通っていた手順が壊れる例があった。
- 体制は、システムプロンプトと全体の品質を持つ小さな中央チームと、skills／tools を持つ各チームの DRI。最後の原則は「測る、1つずつ変える、持ちこたえたものを残す」。

## 具体的な値

- ツール定義がシステムプロンプトに 30〜50 を超えると、ツール選択が悪化しやすい。ユーザーの意図ごとにツールをまとめ、API ごとに1つにはしない。
- eval は 10 件の golden examples からでも始められる。同じタスクを複数回実行する（壊れ方が 2 回に 1 回しか出ない例があった）。
- 単一ループの形: 1 つのモデルと 1 つのコンテキストでツールループを回し、ターン数とコストの予算、書き込みの gate は harness 側に置く。毎ターン、ツール呼び出しをまとめて出し、harness が並列実行して生の結果を返す。予算到達かモデルの回答で停止する。
- ツールは動作、ライブデータ、固定形式の結果に向く。tool search と deferred loading を使い、前提条件はツール側で確かめる。ユーザーごとの権限もツール側で確認し、読める拒否文を返す。
- skills は「チームの仕事の進め方」（手順、ルール、判断）に向く。ナレッジは検索ツールか skill 内の参照ファイルに置き、コードで取って貼り付けることは避ける。
- `/skill-creator`（skill の作成と、既存 skill の整理・重複排除・再構成）、`/skill-doctor`（各 skill の費用と利用頻度を見て不要なものを削除）。
- `/claude-api build-eval`、`/claude-api prompt-audit`（旧モデル向けの指示を diff で提案）、`/claude-api hillclimb`（畳んだ版が元のサブエージェントに並ぶか比較）、`/claude-api cost-optimize`（prompt caching、不要トークンの削減、effort、モデル選択などを1つずつ提案）。
- 記事は「migration kit」を紹介している。複数エージェントを単一ループへ移すための誘導付きワークフローで、モックで試せるデモ付き。上の `/claude-api` のスキルをつないで使う。

## 関連ページ

- [[concepts/subagents]]
- [[concepts/skills]]
- [[concepts/long-running-agent-harness]]
- [[concepts/context-engineering]]
- [[concepts/claude-api-skill]]
- [[concepts/agent-evals]]

## 取り込みメモ

- 公開日は記事ページのメタデータ（datePublished／article:published_time）と本文の日付表示（October 22, 2026）の両方で確認した。一覧の表示と一致。
- 取得は curl（HTML）。本文テキストへの変換は自前で行った。本文中のリンク先（multi-agent research system、比較データ、80% 削減の記事、migration kit の実体など）は取得していない。比較した企業数や具体的な測定値は記事に出ていない。
- 記事は Claude Platform（API で作るエージェント）向け。Claude Code のサブエージェント機能の仕様や推奨ではない。Claude Code への当てはめは推測にとどまる。
- 「Fable 5.1」「Opus 5.5 は thinking を切れない」は記事の記述。モデル仕様の正は docs／platform-docs で、未照合。
- ページ内に読者への指示文はなかった（migration kit を試すよう勧める通常の案内のみ）。
