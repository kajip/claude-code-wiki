---
type: concept
title: サブエージェント
updated: 2026-10-18
sources:
  - sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization
  - sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes
  - sources/engineering/2026-03-24-harness-design-long-running-apps
  - sources/research/2026-10-01-claude-shaped-science
  - sources/gh-changelog/2026-10-18-v2-1-302
---

# サブエージェント

## 概要

メインの会話から作業を切り出して動かすエージェント。モデル、effort、スキル、compaction の設定を個別に持てる（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-10-10）

- モデル: `CLAUDE_CODE_SUBAGENT_MODEL` で全サブエージェントのモデルを決める。定義の `model:` の方が優先される（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。workflow エージェントだけは `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` で一括指定できる（2.1.296）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- effort: Agent ツールの `effort` パラメータ（2.1.292）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- compaction: frontmatter と `--agents` の `autoCompactWindow`（2.1.296）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- スキル: `skills` から先読みするのは最大32件（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 名前は最大256文字（2.1.292）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- fork したサブエージェントは、親のキャッシュから始まる（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。
- （公開時点 2026-08-14 の説明）subagent は独自のコンテキストを持ち、システムプロンプト、ツール、CLAUDE.md は持つが会話は引き継がない。メインに戻るのは答えだけ。大量出力の作業（ログの調査など）に向き、小さな仕事ではオーバーヘッドになる。毎回頼むノイズの多い作業は、`model: haiku`（または `sonnet`）を指定した subagent 定義にする。指定しなければメインのモデルで動く（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）。
- 検索やログ読みのサブエージェントには Sonnet か Haiku を使うことが推奨されている（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- dynamic workflow は、作業を並列のサブエージェントに分ける（[[sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization]]）。
- 参考: サブエージェントとは別に、独立したセッションを複数並列に動かす「agent teams」の実験がある。16 エージェントが共有リポジトリで、ロックファイルによりタスクを分担した（2026-02-05 公開、Opus 4.6 の時点）（[[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]）。詳細は [[concepts/long-running-agent-harness]]。
- 参考: 役割を分けた planner、generator、evaluator の3エージェントで、数時間のアプリ開発を自律的に行わせた事例がある（Claude Agent SDK で構築、2026-03-24 公開、Opus 4.5〜4.6 の時点）。Claude Code のサブエージェント機能そのものの説明ではない（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）。
- 実践例: 長期の研究で、各セッションが計算をバックグラウンドのサブエージェントに任せ、途中結果を markdown に残した。分類器のブロックを1つのエージェントだけに閉じ込めることも、サブエージェントに分けた理由に挙がっている（一人称の実践談で、docs では未確認）（[[sources/research/2026-10-01-claude-shaped-science]]）。

**2.1.302 の CHANGELOG（2026-10-17）**

- fork subagent（`subagent_type: "fork"`）が `claude -p`、Agent SDK、デスクトップアプリ、VS Code でも既定オン（ターミナルは元からオン）。`CLAUDE_CODE_FORK_SUBAGENT=0` で無効化。`claude mcp serve` は常に提供しない（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- デスクトップアプリと VS Code は、メイン会話のサブエージェントを常にバックグラウンドで実行する（Claude に選ばせない）。サブエージェント自身の Agent 呼び出しは、`claude -p`、Agent SDK、デスクトップアプリ、VS Code では既定でフォアグラウンド（同）。
- prompt hook と agent hook は、同一イベントで同時に最大 12 件まで（同）。
- 出典は CHANGELOG のみ。docs でのサブエージェントの記述は未取り込み。

## 変更履歴

- 2026-10-17 — 2.1.302: fork subagent を `claude -p`、Agent SDK、デスクトップアプリ、VS Code でも既定オンに。デスクトップアプリと VS Code はメイン会話のサブエージェントを常にバックグラウンド実行（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-08-14 — （公開時点）コンテキストを守る手段としての subagent を説明する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-10-10 — 2.1.296: `autoCompactWindow` と `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: `skills` の先読みを最大32件に（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: Agent ツールに `effort` を追加。名前の長さを制限（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-01 — 研究での実践例（バックグラウンドのサブエージェント）が公開された（[[sources/research/2026-10-01-claude-shaped-science]]）
- 2026-03-24 — 役割分担型の自律ハーネス（generator と evaluator の分離）の事例が公開された。製品の仕様変更ではない（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）

## 未解決・矛盾

- （なし）
