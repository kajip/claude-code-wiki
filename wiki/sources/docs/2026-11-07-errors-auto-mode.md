---
type: source
source_id: docs
title: Error reference（auto mode の節のみ）
url: https://code.claude.com/docs/en/errors.md
published: unknown
retrieved: 2026-11-07
version:
tier: primary
review: pending
recheck: none
fingerprint: 99a4ab2cfe3df924baae99daa9f4a846c5bbadd2dd0d1197c19d5fff44ca20e5
---

# Error reference: auto mode の 2 節（2026-11-07 取得）

## 要点

- 対象は「Auto mode cannot determine the safety of an action」と、続く「The server returned no safety verdict」の 2 節だけ（約 6,480 行のページの一部）。
- 前者は分類器モデルが判定を出せない場合。読み取り、検索、作業ディレクトリ内の編集は分類器を通らないので動き続ける。メッセージは失敗の種類を括弧で示す。
- 後者はサーバー側審査で判定が返らない場合の拒否。10 回連続でターンを止める。
- どちらの節にも、2.1.319 の変更（フォールバック廃止、尋ねるか拒否）への言及は無い。判定なしの対処として `CLAUDE_CODE_AUTO_MODE_SERVER=0`（自前の分類器へ切り替え）を挙げている。

## 具体的な値

- メッセージ: `<model> is temporarily unavailable, so auto mode cannot determine the safety of <tool> right now. Wait a moment and then try this action again.`
- 種類（v2.1.229 以降）: `(rate-limited)`、`(overloaded)`、`(server error)`、`(timed out)`、`(connection failed)`。
- 対話セッションでは `Not run · auto mode's check had no usable answer` の薄い行になる（v2.1.296 より前は赤いエラー）。`Ctrl+O` で transcript を見る。
- parse できない応答: `Auto mode could not evaluate this action and is blocking it for safety — run with --debug for details`。対話では承認／拒否のプロンプト、または `/compact`。
- Bedrock（Mantle 含む）では、AWS アカウントがモデルを invoke できないと再試行のたびに繰り返す。
- `CLAUDE_CODE_AUTO_MODE_MODEL` に指定したモデルをプロバイダが提供していないと繰り返す。変数を直すか unset して既定の分類器モデルに戻す。
- OAuth トークンの期限切れ／他セッションでの更新は、更新して 1 回再試行（v2.1.216 より前は全拒否）。
- サーバーが判定を返さない場合: `The server-side auto mode classifier gave no verdict (timed out), so auto mode cannot determine the safety of <tool>.`。10 回連続で `Auto mode is unavailable — the server returned no safety verdict for the last 10 responses, so Claude stopped. ...`。`-p` ではそこで実行が終わりエラー扱い、subagent は途中で止まる。
- 対処: `/compact`（`(the conversation is too long for the check)` のとき）、再送、gateway が streaming を切る／書き換えていないか確認、`CLAUDE_CODE_AUTO_MODE_SERVER=0`（Anthropic API 直結では v2.1.281 以降）、auto mode を抜ける。
- 履歴: v2.1.280 より前は判定なしを即拒否し、ターンは止めなかった。v2.1.302 より前は、直結で長すぎる会話をコンパクションしなかった。
- `-p` で `--permission-prompt-tool` が無い場合: アクションは実行されず、実行は続く（errors.md の別行）。

## 関連ページ

- [[concepts/auto-mode]]
- [[sources/docs/2026-11-07-permission-modes]]

## 取り込みメモ

- 上記 2 節以外は要約していない。`claude -p` の exit code（2.1.319 で exit 1 に変更）に当たる記述は、読んだ範囲では見ていない。
- ページ内に読み手への指示文は見つからなかった。
