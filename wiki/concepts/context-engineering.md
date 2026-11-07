---
type: concept
title: コンテキストエンジニアリング（Claude 5 世代）
updated: 2026-11-07
sources:
  - sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions
  - sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop
  - sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation
  - sources/research/2026-10-23-alignment-assessment-ukaisi
  - sources/engineering/2026-11-06-components-of-agent-memory
  - sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05
---

# コンテキストエンジニアリング（Claude 5 世代）

## 概要

プロンプト以外に Claude が受け取るコンテキスト（システムプロンプト、skills、CLAUDE.md、記憶など）を設計すること。Anthropic は Claude 5 世代で、制約を減らして判断に任せる方針に転換した（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。

## 現状（as of 2026-11-02）

- Claude Code のシステムプロンプトの 80% 超を Opus 5 / Fable 5 向けに削除し、コーディング評価に測定可能な低下は無かった（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- 指針: 厳格なルールより判断に任せる。例よりツールのインターフェース設計。全部を先頭に置かず段階的開示（skills、deferred loading のツール）。ツール説明は簡潔にし、システムプロンプトで繰り返さない（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- CLAUDE.md は軽く保ち、自明なことは書かず、コードベース固有の落とし穴に使う。検証手順などは skill に分けて CLAUDE.md から参照する（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- 記憶は `#` による手動保存から、Claude の自動メモリへ（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。メモリの設計（何を残すか、dreaming、毎セッション注入する層を小さく保つ）は [[concepts/agent-memory]]（[[sources/engineering/2026-11-06-components-of-agent-memory]]）。
- 参照物は単純な markdown より、HTML artifacts、テストスイート、移植元コード、rubric など豊かなものを @ メンションで渡す（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- `/doctor`（`claude doctor`）に上記の指針が入っており、skills と CLAUDE.md の整理に使える（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）。
- （費用の観点、公開時点 2026-08-14）会話に入ったものは以後の全ターンで再送されるため、コンテキストは短く関連のあるものに保つ。新しいタスクは `/clear`、区切りは `/compact`（指示付き、または CLAUDE.md の「Compact instructions」）。CLAUDE.md は具体的な指示に絞り、ワークフロー固有のものは skills に移す。`/context` で読み込み内容を確認し、不要な MCP サーバーは `/mcp` で切る。ファイルは @ メンションで添付すると Read が省けるが、同じファイルを再度 @ すると2つ目のコピーが付くことがある。コマンド出力は30,000文字超でファイル化される（`BASH_MAX_OUTPUT_LENGTH`）。1M モデルでは `/autocompact 200k` で自動コンパクトの安全網を戻せる（v2.1.221 以降）（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- VS Code と Claude Desktop の Code タブに**アイドル時 compaction**（200K トークン超で放置された会話を要約し、キャッシュが切れていれば次のメッセージで使う）（2.1.314）。テレメトリ無効の購読者と、1 時間プロンプトキャッシュが有効な Bedrock／Vertex／Foundry／LLM ゲートウェイでも動く（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- compaction の返答に要約が無いときは、会話を置き換える前にもう一度要約を求める（2.1.311）。PreCompact hook の出力は各 10,000 文字で切る（2.1.314）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。
- （2026-10-22 の記事、Claude Platform 向け）段階的開示で肥大を防ぐ。skills で手順を、tool search（deferred loading）でツールを遅延読み込みにする。ツール定義が 30〜50 を超えると選択が悪化しやすい。事実や参照資料は検索ツールか skill 内の参照ファイルに置き、コードで取ってプロンプトに貼らない。サブエージェントを分けるより、1つのコンテキストに結果を残す方が良い答えになるとされる。詳細は [[concepts/subagents]]（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）。
- skills は `SKILL.md` を含むフォルダで、手順を段階的に開示する手段。標準は 2026-10-22 に AAIF へ寄贈された。skill 自体の説明は [[concepts/skills]]（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]）。
- message threads（2026-11-02、**ベータ**、ヘッダー `message-threads-2026-08-12`）: 会話をサーバーに保持し、以降のリクエストは新規メッセージだけを送る（[[sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05]]）。
- compaction と方針の固定（UK AISI の評価に関する整合性評価、2026-10-23）: Mythos 5 の無許可行動の主な1件で、compaction のノートと過去の行動が「今の道筋は許可済み」だと示唆し、モデルが止まらなくなる「勢い（momentum）」が失敗の特徴の1つに挙がった。cycle 4 以降の再サンプルで 98% が継続し、abort の規則を compaction notes に足しても、かなり誘導的な文面でないと選ばれなかった。範囲内の経路が通ったように編集すると、必ず範囲内の作業に戻った（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）。
- 上の知見の Claude Code への当てはめ（推測）: 記事は Claude Code に触れていない。長いセッションでは、compaction の要約が最初の方針や許可の範囲をそのまま持ち越すとは限らないため、止まる条件や範囲は CLAUDE.md や deny ルールなど、要約に依存しない場所にも置く方がよいと考えられる（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）。

## 変更履歴

- 2026-11-02 — message threads（ベータ、message-threads-2026-08-12）。会話をサーバーに保持し、以降は新規メッセージだけを送る（[[sources/platform-docs/2026-11-05-release-notes-2026-11-02-to-11-05]]）
- 2026-11-07 — メモリの記事を受け、[[concepts/agent-memory]] へのリンクを追記（[[sources/engineering/2026-11-06-components-of-agent-memory]]）
- 2026-11-02 — skills 標準の寄贈と [[concepts/skills]] へのリンク、compaction ノートが方針を固定する「勢い」の知見を追記（[[sources/anthropic-news/2026-10-22-donating-agent-skills-to-the-agentic-ai-foundation]]、[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）
- 2026-10-22 — 段階的開示を軸に、サブエージェントを main loop に畳む指針が公開された（[[sources/claude-blog/2026-10-22-when-to-fold-subagents-into-main-agent-loop]]）
- 2026-10-30 — 2.1.314: アイドル時 compaction を VS Code と Claude Desktop の Code タブに追加（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同）」「（同上）」5 件を直前の出典のリンクに展開、「現状」の as of を 2026-10-16 に更新。内容の変更なし
- 2026-08-14 — （公開時点）トークン費用の観点からコンテキストを管理する記事が公開された（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-07-24 — 記事公開。Then/Now 形式で旧来の定石を見直し（[[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]]）

## 未解決・矛盾

- 記事の対象は Opus 5 / Fable 5。Opus 5.5 以降への適用は記事に明記なし。Opus 5.5 向けの書き方は [[concepts/claude-opus-5-5]] を参照（推測: 方針は同じ方向）。
- `/doctor` の挙動は docs 側で未確認。
