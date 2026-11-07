---
type: concept
title: サブエージェント
updated: 2026-11-07
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
  - sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop
  - sources/gh-changelog/2026-11-06-v2-1-317-to-2-1-319
---

# サブエージェント

## 概要

メインの会話から作業を切り出して動かすエージェント。モデル、effort、スキル、compaction の設定を個別に持てる（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。

## 現状（as of 2026-11-07）

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
- デスクトップアプリと VS Code は、メイン会話のサブエージェントを常にバックグラウンドで実行する（Claude に選ばせない）。サブエージェント自身の Agent 呼び出しは、`claude -p`、Agent SDK、デスクトップアプリ、VS Code では既定でフォアグラウンド（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- prompt hook と agent hook は、同一イベントで同時に最大 12 件まで（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。
- 出典は CHANGELOG のみ（[[sources/gh-changelog/2026-10-18-v2-1-302]]）。docs でのサブエージェントの記述は未取り込み。

**2.1.304〜2.1.305 の CHANGELOG（2026-10-20〜21）**

- 変更の無い subagent の worktree が掃除されないことがある問題を修正（2.1.305）。bare リポジトリの新規 worktree が既定ブランチでなくローカル HEAD から始まることがある問題も修正（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- subagent が同時に多数動くときの応答性と throughput を改善（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- VS Code: background sub-agent は Agent カードの下に1行の状態表示で出る。全文は /tasks で見る（2.1.304）（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- 出典は CHANGELOG のみ（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）。
- `CLAUDE_CODE_SUBAGENT_EFFORT` でサブエージェントの既定 effort を設定できる（2.1.316）。親サブエージェントのモデルを継承したサブエージェントが、バックグラウンドの起床でメインのモデルへ移る問題を修正（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- prompt hook と agent hook は 1 セッション（サブエージェント込み）で同時 24 件まで（2.1.312）。サブエージェントの `autoCompactWindow` は `CLAUDE_CODE_AUTO_COMPACT_WINDOW` の窓を下げる方向にだけ効く（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。

**設計指針（2026-10-22 の記事。Claude Platform のエージェント向けで、Claude Code の仕様ではない）**

- Applied AI チームの企業導入の比較では、skills 付きの単一エージェントが、サブエージェント構成より品質で上回ることが多く、費用と遅延も下がることが多かった（公開時点）（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- サブエージェントを残す条件: 単一ループでコンテキスト肥大による性能低下が測定できる／破棄できる新しいコンテキストで並列に進めたい／ツール選択が不安定、または指示が衝突している。検証、並列作業、権限の分離にも向くとされる（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- 領域別・チーム別に分けると組織図の複製になり、受け渡しで情報が落ちる。分けるなら「コンテキストで分ける」: 他から必要なものが少なく、短い結果を返す仕事（独立した調査経路、境界の明確な部品、ブラックボックスの検証）（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- 畳む順序: eval を作る → 結合の強い専門家を統合 → サブエージェントを tool として呼ぶ（ユーザーとの会話は main が持つ。完全な引き継ぎはユーザーと直接話す必要があるときだけ）→ 1つずつ skills と MCP tools に変えて比較する。タスクごとの反転を見て、複数回実行する（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- Claude Code への当てはめ（推測）: skills への切り出しと、サブエージェントを残す条件の判断に参照できる。Claude Code 自体の docs の推奨ではない。
- 2.1.317〜2.1.319: メインと異なるモデルのサブエージェント／チームメイトは、保存済み effort か既定を使う（2.1.317）。SendMessage は実行中のバックグラウンドエージェントへ、実行中コマンドを止めずバックグラウンドへ移して早く届ける（2.1.317）。バックグラウンドのサブエージェントは全プロバイダでシェルコマンドを3分後にバックグラウンドへ移す。"Switch models when a message is flagged" が "Ask each time" ならモデルを切り替えず停止（2.1.318）。`/tasks` に終了済みサブエージェントの "Earlier in this session" 行（2.1.319）。safeguards で止まったサブエージェント後の Claude への指示は「狭いプロンプトで再試行するか、ユーザーに伝える」（2.1.319）（[[sources/gh-changelog/2026-11-06-v2-1-317-to-2-1-319]]）。

## 変更履歴

- 2026-11-06 — 2.1.317〜2.1.319: effort の継承、SendMessage の届き方、3分後のバックグラウンド化ほか（[[sources/gh-changelog/2026-11-06-v2-1-317-to-2-1-319]]）
- 2026-10-22 — サブエージェントをいつ main loop に畳むかの設計指針の記事が公開された。Claude Platform 向け（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）
- 2026-10-31 — 2.1.307〜2.1.316: fork subagent 同時起動時の自己認識の改善、`SubagentStop` hook の重複実行の修正、分離 worktree の早期削除の修正、`CLAUDE_CODE_SUBAGENT_EFFORT` 追加ほか（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」2 件を直前の出典のリンクに展開、出典の無かった 2 行に出典を付与、「現状」の as of を 2026-10-21 に更新。内容の変更なし
- 2026-10-21 — 2.1.305: 変更の無い subagent worktree の掃除漏れを修正。2.1.304: 多数時の応答性と throughput の改善、VS Code の background sub-agent の表示変更（[[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]]）
- 2026-10-17 — 2.1.302: fork subagent を `claude -p`、Agent SDK、デスクトップアプリ、VS Code でも既定オンに。デスクトップアプリと VS Code はメイン会話のサブエージェントを常にバックグラウンド実行（[[sources/gh-changelog/2026-10-18-v2-1-302]]）
- 2026-08-14 — （公開時点）コンテキストを守る手段としての subagent を説明する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-10-10 — 2.1.296: `autoCompactWindow` と `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: `skills` の先読みを最大32件に（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: Agent ツールに `effort` を追加。名前の長さを制限（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-01 — 研究での実践例（バックグラウンドのサブエージェント）が公開された（[[sources/research/2026-10-01-claude-shaped-science]]）
- 2026-03-24 — 役割分担型の自律ハーネス（generator と evaluator の分離）の事例が公開された。製品の仕様変更ではない（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）

## 未解決・矛盾

- 2026-10-22 の記事（サブエージェントを減らす方向）と、Claude Code 側の機能追加・既定値の変更（fork subagent の既定オンなど）の関係は、どちらの出典も論じていない。記事は Claude Platform 向けで、Claude Code の推奨としての位置づけは未確認（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
