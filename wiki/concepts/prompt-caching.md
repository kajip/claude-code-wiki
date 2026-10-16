---
type: concept
title: プロンプトキャッシュとセッションの費用
updated: 2026-10-16
sources:
  - sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/pricing/2026-10-10-pricing
  - sources/docs/2026-10-10-prompt-caching
  - sources/platform-docs/2026-10-10-prompt-caching
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions
  - sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
---

# プロンプトキャッシュとセッションの費用

## 概要

Claude Code のセッションは長くなり、1回のリクエストのコンテキストも大きくなったため、費用の大部分をキャッシュ読み取りが占める（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]、[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。

## 現状（as of 2026-10-16）

- **アイドル時のコンパクション（ターミナル、2.1.299）**: 200K トークン以上の会話を約54分放置すると、1時間のプロンプトキャッシュが切れる前に圧縮する。次のメッセージで全体を処理し直さずに済む。下限は `CLAUDE_CODE_IDLE_COMPACT_MIN_TOKENS` で変更、settings.json の `"idleCompaction": false` で無効。どちらも v2.1.290 以降が必要（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- OpenTelemetry の `api_request` イベントに `cache_creation_5m_tokens` と `cache_creation_1h_tokens` が加わり、キャッシュ書き込みを寿命別に見られる（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- コンテキストの小さいモデルに切り替えるとき、会話が長すぎれば前のモデルが先に要約する（2.1.301）。2.1.301 では、確認なしに usage credits を使って要約することがあった問題も直した。モデルを途中で変えるとキャッシュが失われる点は、従来の推奨どおり（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- LLM gateway が要求と別のモデル名で応答するために会話が繰り返し圧縮される問題を修正（2.1.301）。gateway 固有のモデル名で 200K 付近に "Prompt is too long · automatic compaction failed" になる問題も修正（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

- キャッシュヒットの単価（100万トークンあたり）: Opus 5.5 は $0.20、Sonnet 5.5 は $0.10、Haiku 5.5 は $0.01（100K 以下）、Fable 5.1 は $0.25（[[sources/pricing/2026-10-10-pricing]]）。
- キャッシュヒットの倍率は入力単価の0.1倍が標準。Opus 5.5 と Sonnet 5.5 は0.05倍、Fable 5.1 と Mythos 5.1 は0.025倍（[[sources/pricing/2026-10-10-pricing]]）。
- キャッシュ書き込みは、5分キャッシュで入力の1.25倍、1時間キャッシュで2倍（[[sources/pricing/2026-10-10-pricing]]、[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- effort の変更（**Claude Code の場合**）: 多くのモデルでは、effort の段階ごとに別のキャッシュを持つ。Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 を API キーかサブスクリプションで使う場合は、effort を変えてもキャッシュが残る。Bedrock、Google Cloud's Agent Platform、Claude apps gateway、`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS` を設定した場合、HIPAA の構成では残らない（[[sources/docs/2026-10-10-prompt-caching]]）。
- effort の変更（**Claude API を直接使う場合**）: `output_config.effort` を変えると messages のキャッシュは常に無効になる。tools と system への影響はモデルごと。既定値の明示指定は省略と同じで無効にならない。per-message effort 対応モデルでは `role: "system"` メッセージで変えれば保たれる。thinking の設定を変えた場合も同様（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- 最小キャッシュ可能長（Claude API）: Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1 は 512 トークン（[[sources/platform-docs/2026-10-10-prompt-caching]]）。
- API キーやクラウドプロバイダーの利用者も、1時間のキャッシュ寿命を設定できる（[[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]]）。
- fork したサブエージェントは親のキャッシュから始まる（同）。
- キャッシュを保つための推奨: 長く間を空けない、途中でモデルを変えない、MCP を後からつながない、fast mode は最初に有効にする（[[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]]）。
- 確認は `/usage`、`/cost`（同）。
- （公開時点 2026-08-14 の説明）リクエストは「ツール定義、システムプロンプト、会話（CLAUDE.md が先頭）」の順で、前方が変わると後ろ全部を再処理する。読み取りは入力の0.1倍、書き込みは最大2倍。キャッシュを壊すのは `/model`（opusplan も）、`/effort`、fast mode の途中有効化、`/compact`、時間切れ。モデルや effort の変更は、セッションの最初か `/clear` の直後が安い（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）。
- （同記事）キャッシュ寿命はサブスクリプション1時間、API キー5分で、`ENABLE_PROMPT_CACHING_1H=1` で1時間にできる。`/compact` は古い会話がキャッシュにあるうち（休憩の前）が安い。直近の数ターンを捨てるなら `/rewind` が、`/compact` と違い前方のキャッシュを保つ。`/loop` はそのセッションの全会話を運ぶので、別セッションで動かす（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）。
- API の cache diagnostics は 2026-09-23 に GA になり、beta ヘッダーが不要になった（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。

## 変更履歴

- 2026-10-14〜10-15 — 2.1.299 でアイドル時のコンパクション、2.1.300 で `api_request` の寿命別キャッシュ書き込み、2.1.301 でモデル切り替え時の要約の仕様変更（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — effort 変更時の挙動を、Claude Code と Claude API に分けて書いた（[[sources/platform-docs/2026-10-10-prompt-caching]]）
- 2026-10-07 — Sonnet 5.5 のキャッシュ読み取りを $0.20 から $0.10 に引き下げ（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]、[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-09-23 — API の cache diagnostics が GA（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-08-14 — （公開時点）キャッシュの仕組みと壊す操作を整理した記事が公開された。effort 変更でキャッシュが壊れるという説明は、5.5 世代以前の記述（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]）
- 2026-04-23 — （公開時点の事例）アイドル1時間超のセッションで古い thinking を消す最適化のバグが毎ターン働き、キャッシュミスが続いて使用上限の消費が早まったと説明された。4/10 に修正済み（[[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]]、[[concepts/claude-code-quality-incidents]]）

## 未解決・矛盾

- 解決済み（2026-10-16）: 記事（2026-08-14）は `/effort` でキャッシュが壊れると説明するが、docs では Opus 5.5、Sonnet 5.5、Haiku 5.5、Fable 5.1（API キーかサブスクリプション）では残る。docs を現状とし、記事は公開時点の説明として残す（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]、[[sources/docs/2026-10-10-prompt-caching]]）。
- 未確認: 記事の「書き込みは最大2倍、読み取り0.1倍」は、モデルごとの現行倍率（0.05倍など）とは別の一般的な説明（[[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]]、[[sources/pricing/2026-10-10-pricing]]）。
- （なし）
- 解決済み（2026-10-10）: effort を変えたときにキャッシュが残るかどうかの食い違いは、ドキュメントの記述で解決した（[[sources/docs/2026-10-10-prompt-caching]]）。経緯は [[concepts/effort]] を参照。
