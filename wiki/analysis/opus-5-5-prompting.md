---
type: analysis
title: Opus 5.5 に渡すプロンプトの注意点と事例
updated: 2026-10-10
question: Opus 5.5 に渡すプロンプトの注意点と、簡単な事例を教えて
sources:
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program
---

# Opus 5.5 に渡すプロンプトの注意点と事例

as of 2026-10-10

## 注意点

### 任せ方
- タスクは丸ごと任せる。「何をもって完了とするか」と「どんなときに止まって確認するか」を伝える（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- 結果を確かめる手段（テスト、ビルド）を渡す。複数のファイルにまたがる変更は、先に計画を立てさせる（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- 長い作業では、止まる条件を CLAUDE.md に書き、タスクの一覧は TASKS.md などのファイルに置く。大きな作業はサブエージェントに分け、根拠を確かめてから受け入れさせる（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- CLAUDE.md は200行ほどに収める（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。

### 書かない方がよいこと
- 「think carefully」「think step by step」は消す。Opus 5.5 は返答の前に必ず考える。単純な質問には「Answer directly」と添え、考える量は effort で変える（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- 返答の中で内部の推論を再現させない。フラグの対象になり、拒否されることがある。理由が欲しいときは「なぜこの方法を選んだかを3文で」のように具体的に頼む（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]、Sonnet 5.5 でも同様: [[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- デザインの作業では、「ありきたりな見た目を避けて」のような一般的な指示ではなく、避けたいパターンを具体的に列挙する（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。

### 結果の受け取り方
- 長い作業の後は、要約のうち「自分に求められていること」を先に読む（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- 調べものでは、確かめられなかった点に印を付けさせ、どこを調べたかを書かせる（同）。
- 人がレビューする前に、diff をレビューさせる（同）。

### 安全策
- サイバーや bio に触れる依頼にはフラグが付き、古いモデルに回されることがある。Claude Code では `/model` で戻し、`/config` の「Switch models when a message is flagged」で挙動を変えられる（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]、[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。関連: [[concepts/cyber-safeguards]]

## 事例

### 良くない例
```
think carefully, step by step. 認証まわりを直して。
```

### 良い例（作例。出典の記事の文章ではない）
```
src/auth/ のセッション期限切れのバグを直して。
完了の条件: `npm test -- auth` がすべて通り、新しく回帰テストが1本増えていること。
途中の判断は任せる。止まって聞くのは、公開 API の形を変える必要が出たときと、
データを消すなど取り返しのつかない操作が必要なときだけ。
```

### 出典の記事にある例（要旨）
- CLAUDE.md の止まる条件、サブエージェントへの分割、TASKS.md、diff のレビューの例は [[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]] の「プロンプトの例」を参照。
