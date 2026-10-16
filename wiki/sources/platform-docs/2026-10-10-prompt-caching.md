---
type: source
source_id: platform-docs
title: Prompt caching
url: https://platform.claude.com/docs/en/build-with-claude/prompt-caching
published: unknown
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:e52e22f01d4eb474d5b15bd2b3ced251223679c96241eb141b79816333005df0
archive_url:
---

# Prompt caching

## 要点

- Claude API 側のプロンプトキャッシュの仕様ページ。`cache_control` による明示的なブレークポイントと、トップレベルの自動キャッシュがある。TTL は既定 5 分、1 時間は 2 倍の価格で選べる。
- キャッシュは `tools` → `system` → `messages` の階層で、ある層の変更はその層以降を無効にする。
- `output_config.effort` を変えると、messages のキャッシュは常に無効になる。tools と system への影響は「Model-specific」（モデルごと）。effort を既定値に明示指定するのは、省略と同じ扱いで無効にならない。
- thinking の設定（mode、extended mode の `budget_tokens`）も同様で、変えると messages のキャッシュは常に無効になる。tools と system はモデルごと。
- per-message effort に対応するモデルでは、`messages` 内の `role: "system"` メッセージで effort を変えると、キャッシュされたプレフィックスは保たれる。
- 最小のキャッシュ可能長はモデルごとに違う（下記）。

## 具体的な値

- 無効化の表（Tools / System / Messages の順）。Effort setting: Model-specific / Model-specific / ✘。Thinking parameters: Model-specific / Model-specific / ✘。Speed setting（`speed: "fast"` と標準の切り替え）: ✓ / ✘ / ✘。Tool definitions の変更: ✘ / ✘ / ✘。
- effort の行の原文要旨: 「Changing the `output_config.effort` value always invalidates message blocks, with the same model-specific effect on tool and system caches as thinking parameters」。「On models that support per-message effort, an effort change carried in a `role: "system"` message inside `messages` leaves the cached prefix intact」。per-message effort は `effort#change-effort-mid-conversation-beta` へのリンクで、ベータ表記。
- どのモデルで tools / system が無効になるかは、このページには書かれていない（thinking ページの「Thinking and prompt caching」への参照のみ）。
- 最小キャッシュ可能長（Claude API、Claude Platform on AWS、Google Cloud、Microsoft Foundry）: 512 トークン = Fable 5.1、Mythos 5.1、Opus 5.5、Opus 5、Sonnet 5.5、Fable 5、Mythos 5、Haiku 5.5。2,048 = Mythos Preview、Opus 4.7。4,096 = Opus 4.6、Opus 4.5、Haiku 4.5。1,024 = Opus 4.8、Sonnet 5、Sonnet 4.6、Sonnet 4.5、Opus 4.1、Opus 4、Sonnet 4。2,048 = Haiku 3.5。
- 価格（100万トークンあたり。ベース入力／5分書き込み／1時間書き込み／ヒット／出力）: Opus 5.5 $4／$5／$8／$0.20／$20、Sonnet 5.5 $2／$2.50／$4／$0.10／$10、Haiku 5.5（100K 以下）$0.10／$0.125／$0.20／$0.01／$0.50、（100K 超）$0.50／$0.625／$1／$0.05／$2.50。ヒットは標準が入力の 10%、Fable 5.1 と Mythos 5.1 は 2.5%、Opus 5.5 と Sonnet 5.5 は 5%。
- 自動キャッシュ: リクエスト最上位に `cache_control`（例 `{ "cache_control": { "type": "ephemeral", "ttl": "1h" } }`）。最後のブロックに TTL の異なる明示指定があると 400 エラー。レガシーの Amazon Bedrock（Opus 4.6 以前）では最上位の `cache_control` が 400。
- 混在 TTL: 1 時間のエントリは 5 分より前に置く。
- thinking ブロック: `cache_control` を直接付けられないが、前のターンのものは他の内容と一緒にキャッシュされ、読み出し時は入力トークンに数える。Opus 4.5+、Sonnet 4.6+、Haiku 5.5 は非ツール結果のユーザー内容を足してもブロックが保たれ、キャッシュは有効。それ以前の Opus/Sonnet と Haiku 4.5 までは thinking ブロックが取り除かれ、後続がキャッシュから外れる。
- Dropped thinking blocks: Fable 5.1、Mythos 5.1、Opus 5.5、Sonnet 5.5、Haiku 5.5 で、受け取れないブロックを API が落とすと、そのブロック以降のプレフィックスが変わる（Messages ✘）。
- mid-conversation システムメッセージ: Fable 5.1、Mythos 5.1、Fable 5、Mythos 5、Opus 5.5、Opus 4.8、Opus 5、Sonnet 5.5、Haiku 5.5 で、`{"role": "system"}` を `messages` に足せば system と messages のキャッシュは無効にならない。Sonnet 5 では使えない。`inline-tools-2026-09-15` ベータヘッダーで、ツールの追加・変更も `tool_addition` ブロックで可能（対応モデルのみ）。
- 事前ウォームアップでは、本番と同じ thinking 設定と `output_config.effort` を使う。違うと本番が当たらないエントリを書く。
- 診断: 使用量の `cache_creation_input_tokens` と `cache_read_input_tokens` が両方 0 なら、キャッシュされていない。トラブルシュートでは `tool_choice`、画像、thinking 設定、`output_config.effort` を一貫させる。

## 関連ページ

- [[concepts/effort]]
- [[concepts/prompt-caching]]
- [[concepts/claude-opus-5-5]]
- [[concepts/claude-sonnet-5-5]]
- [[concepts/claude-haiku-5-5]]
- [[sources/docs/2026-10-10-prompt-caching]]（Claude Code 側の記述）

## 取り込みメモ

- 公開日がページから読み取れないため `published: unknown`、ファイル名は取得日。URL は llms.txt の記載（`.md` 付き raw を取得）から確定した。
- tools / system のキャッシュがどのモデルで無効になるかは、このページでは確定できない（thinking ページ側の記述。未取得）。
- 表は長いため、effort / thinking / 最小長 / 価格 / thinking ブロックの部分だけを拾った。cache diagnostics は別ページ。
- ページ内に指示文は見当たらなかった。
