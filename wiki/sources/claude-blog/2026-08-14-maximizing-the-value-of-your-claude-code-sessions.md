---
type: source
source_id: claude-blog
title: Maximizing the value of your Claude Code sessions
url: https://claude.com/resources/articles/maximizing-the-value-of-your-claude-code-sessions
published: 2026-08-14
retrieved: 2026-10-16
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:d5d0cce6d574cf6c9c9735f49835a47901ea691afd44e3f896eb2ded502997c8
archive_url:
---

# Maximizing the value of your Claude Code sessions

著者 Lydia Hallie、カテゴリ Best practices、読了4分。

## 要点

- トークンの価格は、モデル、入力か出力か、キャッシュされたかの3つで決まる。出力は入力の約5倍の価格。thinking が出力の多くを占め、その量を effort が決める。
- プロンプトキャッシュは Claude Code が自動で管理する。読み取りは入力価格の0.1倍、書き込みは最大2倍。リクエストは「ツール定義、システムプロンプト、会話（CLAUDE.md が先頭）」の順に並び、前方が変わると後ろ全部を再処理する。
- キャッシュを壊す操作（公開時点の説明）: `/model`、`/effort`、fast mode の途中での有効化、`/compact`、時間切れ。モデルや effort の変更は、セッションの最初か `/clear` の直後が安い。
- 会話に入ったものは以後の全ターンで再送される。コンテキストを短く保つため、タスクの切り替えで `/clear`、同じタスクの区切りで `/compact`、ファイルは @ メンション、騒がしいコマンドは quiet フラグか subagent に任せる。
- subagent は独立したコンテキストを持ち、メインに戻るのは答えだけ。大量出力の作業に向くが、小さな仕事ではオーバーヘッドになる。
- 「Where to look first」の節は、4項目を挙げるとあるが、取得した本文に項目が出なかった（取り込みメモ参照）。

## 具体的な値

- キャッシュ読み取り 0.1x、書き込み最大 2x、出力は入力の約 5x（記事の値。公開時点）。
- キャッシュの寿命: サブスクリプション1時間、API キー5分。`ENABLE_PROMPT_CACHING_1H=1` で1時間にできる。
- `MAX_THINKING_TOKENS=0 claude`: そのセッションの thinking を切る（Fable 5 を除く）。`/effort low` より下の段階。
- `/model`、`/effort` は、会話の途中で切り替えるときに確認を求める。`/model` は opusplan でもプランモードの出入りのたびに全体の再処理が起きる。
- fast mode: キャッシュのキーに含まれ、再処理は fast mode の価格で行われる。有効にするなら最初に。無効に戻すときはキャッシュ上の費用は無い。
- `/rewind`: 直前の数ターンを捨てるなら `/compact` より安い（末尾を切るだけで前方のキャッシュが残る）。
- `/compact` は、古い会話がキャッシュにあるうちが安い（休憩の前）。「Compact instructions」節を CLAUDE.md に置ける。
- `/context`: 新しいセッションで読み込み内容（CLAUDE.md、MCP ツール定義）を確認。`/mcp` で不要な MCP サーバーを切る。
- `BASH_MAX_OUTPUT_LENGTH`: コマンド出力が 30,000 文字を超えると、ファイルに書き出してプレビューとパスだけを会話に入れる。変更可。
- `/autocompact 200k`: 1M モデルで自動コンパクトの安全網を戻す（Claude Code v2.1.221 以降）。
- `/rename`（`/clear` の前）、`/loop` はそのセッションの全会話を運ぶフルターンで、1時間空けばキャッシュミスになる。別端末の新しいセッションで動かす。
- subagent は独自のシステムプロンプトとツールと CLAUDE.md を持ち、会話は引き継がない。定義に `model: haiku`（または `sonnet`）を指定できる。指定しなければメインセッションのモデルで動く。
- @ メンションはファイルを最初のリクエストに添付し、Read を省く。同じファイルを後のターンで再度 @ すると、2つ目のコピーが付く場合がある。
- 例のコマンド: `npx vitest run <file> --reporter=dot`（CLAUDE.md に書く例）。
- 関連記事として Choosing a Claude model and effort level in Claude Code に言及（本文のみ、未取得）。

## 関連ページ

- [[concepts/prompt-caching]]
- [[concepts/effort]]
- [[concepts/fast-mode]]
- [[concepts/subagents]]
- [[concepts/context-engineering]]

## 取り込みメモ

- 日付は記事ページの `article:published_time`（2026-08-14）と本文の Date（August 14, 2026）で一致を確認した。
- 生の HTML を curl で取得し、本文を抽出した。「Where to look first」の4項目は、おそらく画像や折りたたみ部品で本文に出なかった（推測）。図やグラフ（"for illustration purposes only"）の内容も未確認。
- 公開は 2026-08-14 で、Claude 5.5 世代より前。effort とキャッシュ、キャッシュ寿命などは公開時点の説明で、現行の仕様は docs が正（[[sources/docs/2026-10-10-prompt-caching]] は、Opus 5.5 などで effort 変更でもキャッシュが残るとする）。
- 記事内の価格倍率は pricing の現行値（モデルにより0.05倍など）と異なりうる。pricing は未照合の箇所がある。
- ページ内に読み手への指示文は無かった。
