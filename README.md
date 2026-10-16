# Claude Code 情報 wiki

Claude Code とその周辺（モデル、API、SDK、プラグイン、MCP、スキル、安全性や運用の方針、価格、提供範囲）について、**一次情報だけ**を要約して Markdown で蓄積する wiki です。

運用には Karpathy の llm-wiki パターンを使っています。wiki を書いて維持するのは LLM（Claude Code）の担当で、人間は情報源を選ぶことと質問することに集中します。

## 特徴

- **一次情報のみ**: 取り込むのは [`sources.md`](sources.md) に載っている公式の URL（GitHub、npm、Anthropic と Claude のブログ・ニュース、ドキュメント、価格ページなど）だけです。第三者の解説記事は取り込みません。
- **原本は保存しない**: 元の URL を唯一の原本とします。その代わり、要約ページには必ず `url`、`published`（公開日）、`retrieved`（取得日）を書きます。
- **出典を必ず付ける**: 概念ページに書く事実には、その場で要約ページへのリンクを付けます。
- **出典の優先順位**: 価格は価格ページ、仕様と提供範囲はドキュメント（Claude Code と Claude Platform）を正とします。ブログや発表記事の値は、公開時点の値として扱います。
- **消さずに残す**: 記述が変わったら変更履歴に残し、食い違う記述は「未解決・矛盾」に両方の出典を付けて書きます。

## ディレクトリ構成

```
CLAUDE.md          運用ルール（Schema）。メインのセッションが従う方針と作業の振り分け
README.md          このファイル
sources.md         情報源の台帳（URL、頻度、取得方法、状態、last_seen）
rules/             サブエージェントが読む共通の規則（取得、書き方）
templates/         ページの雛形（source-page.md、concept-page.md）
.claude/agents/    各作業のサブエージェント（wiki-check / wiki-ingest / wiki-query / wiki-lint）
.claude/hooks/     wiki-ingest の書き込み先を制限するフック
.claude/settings.json  権限の設定（WebSearch の禁止、許可するドメインなど）
tests/             フックのテスト
proposals/         まだ採用していない提案（例: 二次情報の扱い）
wiki/
  index.md         内容の目録。ここから読み始める
  status.md        最新バージョンなどのスナップショット
  log.md           作業の時系列ログ（追記のみ）
  sources/<id>/    要約ページ（1資料=1ページ）
  concepts/        概念ページ（機能、モデル、仕組み）
  analysis/        質問への回答のうち、再利用できるもの
```

## 使い方

このディレクトリで Claude Code を起動して、日本語で依頼します。

| やりたいこと | 依頼の例 | 内容 |
| --- | --- | --- |
| 巡回（Check） | 「今日の情報を探してきて」 | 情報源を見て回り、新しい情報を見つける。新しいバージョンや記事があれば取り込む |
| 取り込み（Ingest） | 「この記事を取り込んで」 | 要約ページを作り、関連する概念ページ、目録、ログを更新する |
| 質問（Query） | 「Opus 5.5 の fast mode の価格は？」 | `index.md` から関連ページを探し、出典と「いつ時点の情報か」を付けて答える |
| 点検（Lint） | 「wiki を点検して」 | 矛盾、古い記述、出典の無い記述、壊れたリンクを洗い出す |

各作業は、費用を抑えるために専用のサブエージェントが受け持ちます。

| サブエージェント | モデル | 書き込み | 役割 |
| --- | --- | --- | --- |
| `wiki-check` | Haiku | しない | 情報源を見て回り、新しい記事やバージョンを一覧にする |
| `wiki-ingest` | Sonnet | `wiki/sources/` と `wiki/concepts/` だけ | 1資料を要約し、概念ページを更新する |
| `wiki-query` | Haiku | しない | wiki を調べて、出典付きで答える |
| `wiki-lint` | Haiku | しない | 点検して、直し方を提案する |

目録（`index.md`）、ログ（`log.md`）、状態（`status.md`）の更新と人間への報告は、メインのセッションが行います。詳しい手順は [`CLAUDE.md`](CLAUDE.md) と各エージェントの定義を参照してください。

フックのテストは `tests/test-ingest-write-scope.sh` で実行できます。

## 情報源

| 頻度 | 情報源 |
| --- | --- |
| 毎日 | GitHub Releases、CHANGELOG.md、npm（`@anthropic-ai/claude-code`）、Claude ブログ（Claude Code カテゴリ）、Anthropic News、claude.dev |
| 週次 | Claude Code ドキュメント、Anthropic Engineering、Anthropic Research、価格ページ、Claude Platform ドキュメント（API 側。リリースノートで変更を検知） |

それぞれの URL、取得方法、注意点は [`sources.md`](sources.md) にあります。

## レビュー

新しい要約ページは `review: pending` で作られます。人間が内容を確認したら `review: ok` に変えます。現在は運用の最初の段階で、取り込みのたびに人間が確認しています。安定したら、スケジュールでの自動実行に移る予定です。
