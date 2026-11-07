---
type: source
source_id: docs
title: Choose a permission mode
url: https://code.claude.com/docs/en/permission-modes.md
published: unknown
retrieved: 2026-11-07
version:
tier: primary
review: pending
recheck: none
fingerprint: edb867988c953da995b7b997a626e012c30d4a18693519c1d7f1102df00c75fb
---

# Choose a permission mode（2026-11-07 再取得・auto mode の該当箇所のみ）

## 要点

- 再取得の目的は、auto mode の「サーバー側審査」と、CHANGELOG 2.1.319 の「フォールバック廃止」との突き合わせ。docs は審査まわりを 2 つの結果に分けて書く。(a) サーバーがセッションを審査しない場合は、Claude Code 自身の分類器リクエストへフォールバックする。(b) サーバーがあるアクションに判定を返さない場合は、審査なしで実行せず拒否する。
- `CLAUDE_CODE_AUTO_MODE_SERVER=0` は「サーバーに聞かず、常に Claude Code 自身の分類器リクエストを使う」変数として docs に記載がある（前回 2026-10-10 取得分では見つからなかった）。
- 2.1.319 の「テレメトリ／feature flag オフでフォールバック廃止、尋ねるか拒否」に当たる記述は、この取得分には無い。docs 本文に 2.1.319 への言及もない（grep で確認）。
- `CLAUDE_CODE_AUTO_MODE_MODEL`（v2.1.302 以降）が docs に記載されている。分類器の既定は Sonnet 5。
- `claude -p` と Agent SDK は、権限モード未指定のとき v2.1.302 以降は Manual（`default`）で開始する。
- プラン表記に Ultra を含む（Pro、Max、Ultra、Team）。

## 具体的な値

- 開始モード表: 対話の terminal と VS Code は v2.1.283 以降で `auto`。それ以前は Pro、Max、Ultra、Team で feature flag を取得するセッションのみ `auto`、他は `default`。`claude -p` と Agent SDK は `default`（v2.1.302 以降）。v2.1.302 より前は、feature flag を取得しない実行（サードパーティプロバイダや `DISABLE_TELEMETRY`）で auto で始まりえた。
- サーバー側審査（Server-side classifier review）を「聞く」セッション: Anthropic API 直結（terminal は v2.1.271 以降 Pro/Max/Ultra/Team、Enterprise と API は v2.1.278 以降。`-p` と VS Code は v2.1.278 以降、Agent SDK とデスクトップは v2.1.281 以降）。v2.1.282 以降は feature flag を取得しないセッション（テレメトリをオフにした場合など）が、どの種別でも既定でサーバーに聞く。クラウドプロバイダ（Claude Platform on AWS、Bedrock、Google Cloud の Agent Platform、Foundry）と LLM gateway／proxy（`ANTHROPIC_BASE_URL`）は v2.1.278 以降。Claude apps gateway は v2.1.280 以降。Anthropic ホストの cloud session とクラウドの scheduled task は展開中。
- 結果 (a) 審査されない: 「response completes with no review results」またはサーバーが審査しないと答える。主な原因は、審査リクエストや結果を落とす gateway／proxy、サーバー側チェックが未対応のプラットフォーム・リージョン・認証情報。原文: Claude Code は自分の分類器リクエストへフォールバックする。
- 結果 (b) 判定なし: レスポンスが結果の到着前に終わる、結果が読めない形で届く（どの接続でも）。Anthropic API 直結ではサーバーのチェック自体の失敗（タイムアウトなど）も。アクションは拒否。10 回連続で判定なしならターンを止める（errors の節）。
- hook や mod が審査後に入力を変えた場合は判定なしで拒否されうる（`a hook changed this call's input after auto mode reviewed it`）。
- `CLAUDE_CODE_AUTO_MODE_SERVER=0`: サーバーに聞かず常に自前の分類器。Anthropic API 直結では v2.1.281 以降が必要。`=1` は直結でサーバー審査をオンにする（`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` を併用していない限り）。`CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` を設定して `CLAUDE_CODE_AUTO_MODE_SERVER` が未設定なら、サーバーにも聞かなくなる（例外は llm-gateway-protocol の記述）。
- 分類器モデル: 既定は Claude Sonnet 5。`/status` の `Auto mode server` が `Enabled` なら、サーバー審査の対象外の呼び出しだけが分類器リクエストになる。選択表: Anthropic 設定のモデル、Sonnet 4.6 セッションは Sonnet 4.6、`ANTHROPIC_DEFAULT_SONNET_MODEL` の値（Sonnet 5.5 または Opus 5.5 なら Sonnet 5）。Sonnet 5 が使えない・ポリシーで除外のときは、セッションのモデル、または Fable セッションでは Opus。
- `CLAUDE_CODE_AUTO_MODE_MODEL`: v2.1.302 以降、フルのモデル ID を指定（例 `claude-sonnet-4-6`）。クラウドプロバイダ固有の ID も可。無視されたときのデバッグログは `ignoring CLAUDE_CODE_AUTO_MODE_MODEL`。
- 拒否の閾値: 3 回連続、合計 20 回は設定不可。`-p`（`--permission-prompt-tool` なし）では、閾値到達時にそのアクションは実行されず、Claude は作業を続け、実行は止まらない。
- 「No verdict from the classifier」（別の安全チェックが分類器リクエストを拒否、または応答が parse できない）は、通知も Recently blocked の記録も無しでブロックされる。「No verdict from the server」は上記 (b)。

## 関連ページ

- [[concepts/auto-mode]]
- [[sources/docs/2026-11-07-errors-auto-mode]]
- [[sources/docs/2026-10-10-permission-modes]]
- [[sources/gh-changelog/2026-11-06-v2-1-317-to-2-1-319]]

## 取り込みメモ

- ページは約 1050 行。auto mode の開始モード、サーバー側審査、分類器モデル、拒否の節だけを要約した。他の節（モード一覧、HIPAA、プラン別の bypass 等）は読んでいない／要約していない。
- 前回（2026-10-10）要約の全文との差分は取っていない。「前回見つからなかった」は、前回の wiki 要約と concept ページに記載が無かったことに基づく。
- ページ内に読み手への指示文は見つからなかった。
