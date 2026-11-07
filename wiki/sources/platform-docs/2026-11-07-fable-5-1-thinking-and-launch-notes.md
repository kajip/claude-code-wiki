---
type: source
source_id: platform-docs
title: Claude Platform release notes（Fable 5.1 関連の抜粋）と Models overview
url: https://platform.claude.com/docs/en/release-notes/overview
published: unknown
retrieved: 2026-11-07
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:50248b66c1484a769f1cd196006ddddd4203f36c51e83d8610e5db82eec9e968
archive_url:
---

# Claude Platform release notes（Fable 5.1 関連の抜粋）と Models overview

Lint の照合用に、必要な箇所だけを抜き出した要約ページ。fingerprint は release-notes の Markdown（`overview.md`）の sha256。Models overview（`https://platform.claude.com/docs/en/about-claude/models/overview.md`）の sha256 は `5761ef315b5a4816697fbdc7e4a653d3cb439ccfe9a0a012f90a2d326aba90a2`。

## 要点

- リリースノートの September 1, 2026 の項に Claude Fable 5.1（`claude-fable-5-1`）と Mythos 5.1 の公開が載っている。wiki が別の出典で「発表 2026-09-15」とする日付と食い違う（下の取り込みメモ）。
- 同項: Fable 5.1 では、API が thinking ブロックより前の内容が変わっていないかを確かめる。対象は 2026-08-31 以降に作られた新規アカウントで、`system`、`tools`、前のメッセージを変えて再送すると 400 エラー。
- 同項: 両モデルとも adaptive thinking は常に有効（always-on）。
- Models overview の比較表も、Fable 5.1 の Thinking を「Adaptive (always on)」とする。
- 10-05 の項: Models API に `capabilities.thinking.types.disabled` が加わり、モデルごとに `thinking: {type: "disabled"}` を受け付けるかが分かる。Fable 5.1 についての値そのものは、取得した2ページには書かれていない。

## 具体的な値

- 2026-09-01 の項: 1M トークンのコンテキスト（既定）、最大出力 128k、$10／$50 per MTok、キャッシュ読み取り $0.25 per MTok（0.025 倍。他モデルは 0.1 倍）。
- `tool_choice` の `any` と `tool` は Fable 5.1 と Mythos 5.1 で 400 エラー（`auto`、`none` は変更なし）。
- preserved thinking: Fable 5.1 と Mythos 5.1 の thinking ブロックは、生成したモデルか新しいモデルでのみ保持される。Fable 5.1 は Opus 5、Fable 5、Mythos 5 以前のブロックを受け付ける。新規アカウント（2026-08-31 以降）で履歴が変わっていると 400。ベータヘッダー `thinking-binding-controls-2026-08-01` を付けると、落としたブロックが `input_transformations` に出て、`thinking.block_binding.prefix_mismatch_behavior` で拒否か破棄かを選べる。
- September 14, 2026 の項（同ヘッダー）: `input_transformations` に `thinking_mismatch_allowed` が加わる。API が前置の確認を強制しない要求（例: 2026-08-31 より前に作られたアカウントの Fable 5.1 で `prefix_mismatch_behavior` 未設定）で、確認に失敗したブロックを示す。ブロックはそのままモデルに届く。
- 2026-09-01 の項: Fable 5.1 は 30 日のデータ保持が必須で、Anthropic が明示的に認めた場合を除き ZDR では使えない。
- 2026-10-05 の項: `GET /v1/models` と `GET /v1/models/{model_id}` が `capabilities.thinking.types.disabled` を返す。`supported` が `false` なら、そのモデルは `"disabled"` を 400 で拒否する。
- 参考: Fable 5 と Mythos 5 は adaptive thinking が唯一のモードで `thinking: {"type": "disabled"}` は非対応（June 9, 2026 の項）。Opus 5.5 は `disabled` が 400（リリースノートの Opus 5.5 の項）。

## 関連ページ

- [[concepts/claude-fable-5-1]]
- [[concepts/distillation-defenses]]
- [[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]

## 取り込みメモ

- `published: unknown`: 取得したのは複数日にまたがる一覧ページの一部の抜粋で、単一の公開日が無い。リリースノート全体は 2026-11-05 の項まで含む。
- リリースノートの Fable 5.1 の公開日は September 1, 2026。wiki の既存ページは発表記事の一覧の表示に従い 2026-09-15 としている。どちらが正しいかは、この資料だけでは決められない（リリースノートの項の日付は API 側の提供日かもしれない。推測）。
- Models overview は Fable 5.1 の「常に有効」を述べるが、`thinking.types.disabled.supported` の具体値は示さない（Sonnet 5.5 の例だけを記載）。「切れない」は 'always on' の表記からの読み取り。
