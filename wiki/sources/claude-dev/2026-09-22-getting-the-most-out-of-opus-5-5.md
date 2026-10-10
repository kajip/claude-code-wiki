---
type: source
source_id: claude-dev
title: Getting the most out of Opus 5.5 in Claude and Claude Code
url: https://claude.dev/blog/getting-the-most-out-of-opus-5-5/
published: 2026-09-22
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: weekly
fingerprint:
archive_url:
---

# Getting the most out of Opus 5.5 in Claude and Claude Code

## 要点

- タスクは丸ごと任せ、「何をもって完了か」と「いつ止まって聞くか」を伝える。
- 「think carefully」のような指示は消す。Opus 5.5 は返答の前に必ず考える。単純な質問には「Answer directly.」と添える。考える量を変えたいときは、指示ではなく effort で調整する。
- 長い作業では、止まる条件を CLAUDE.md に書く。タスクの一覧はファイル（例: TASKS.md）に置き、要約されても残るようにする。大きな調査や移行はサブエージェントに分け、各サブエージェントの根拠を確かめてから受け入れさせる。
- 結果の確かめ方: 長い作業の後は、要約のうち「自分に求められていること」を先に読む。人がレビューする前に diff をレビューさせる。調べものでは、確かめられなかった点に印を付けさせ、どこを調べたかを書かせる。
- 返答の中で内部の推論を再現させない（フラグの対象になる）。必要なら「なぜこの方法を選んだかを3文で」のように、欲しいものを具体的に頼む。
- デザインの作業では、「ありきたりな見た目を避けて」のような一般的な指示ではなく、避けたい具体的なパターンを列挙する。指示が無いと、既定の数種類のスタイルに戻る。
- Opus 5.5 は、Fable と同じ水準の bio とサイバーの安全策を持って出た最初の Opus。フラグが付いたメッセージは、多くの場合、古いモデルに回される。
- fast mode は、Opus 5.5 の公開時点では**研究プレビュー**。extra usage を有効にしておく必要がある。

## 具体的な値

- Claude Code での操作: `/model`（モデルを戻す）、`/config` の「Switch models when a message is flagged」、`/feedback`、`/fast`、Esc を2回押して直前のメッセージを編集。
- Claude アプリ: Settings → Capabilities で同じ設定を切り替える。

## プロンプトの例（記事の例の要旨）

- CLAUDE.md の止まる条件: 自分の入力が要らない段階では止まらずに進め、状況の報告は次の作業と同じメッセージに書く。止まって聞くのは、自分がいないと進めないときと、取り返しのつかない操作（データの削除、force push、このリポジトリの外の変更）の前だけ。
- サブエージェントへの分割: 対象をサービスごとにサブエージェントへ割り当て、戻ってきた根拠を確かめてから受け入れ、最後に「サービス／影響の有無／根拠」の表にまとめさせる。
- タスクの一覧: TASKS.md にチェックリストを置き、終わったら印を付け、新しく見つけたものを書き足させる。
- diff のレビュー: main と比べた diff を見て、マージを止めるほどの問題だけを挙げさせる。各問題について、ファイルと行、なぜ誤りか、失敗をどう示せるかを書かせる。

## 関連ページ

- [[concepts/claude-opus-5-5]]
- [[concepts/fast-mode]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- 既定の effort やコンテキスト長は、この記事には書かれていない。
- 2026-10-10 にプロンプトについての質問を受けて記事を取得し直し、要点と「プロンプトの例」を追記した。例は英語の原文を日本語で言い換えたもの。
